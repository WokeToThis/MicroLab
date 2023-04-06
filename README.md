# MicroLab

## 1o εργαστήριο

Προγραμματισμός σε assembly ενός μικρό-ελεγκτή ARM (Nucleo M4) με χρήση των εργαλείων keil.

Τα ζητήματα της εργασίας:
α) Για κάθε μικρό λατινικό γράμμα θα προσθέτει στο hash τον αριθμό που φαίνεται στον
παρακάτω πίνακα
β) για κάθε αριθμητικό ψηφίο θα αφαιρεί την τιμή του αριθμητικού ψηφίο από το hash του
αλφαριθμητικού
γ) το hash του αλφαριθμητικού δεν επηρεάζεται από οποιοδήποτε στοιχείο του
αλφαριθμητικού που δεν είναι μικρό λατινικό γράμμα ή αριθμητικό ψηφίο
δ) να αθροίσετε τα νούμερα του hash έως ότου καταλήξετε σε μονοψήφιο νούμερο και να
υπολογίσετε το παραγοντικό του.
Το τελικό hash θα αποθηκεύεται σε μια θέση μνήμης που εσείς θα διαλέξετε.
![image](https://user-images.githubusercontent.com/70851911/230398649-65c9accf-78f2-4fe4-931c-7e9305cba632.png)

Π.χ. το hash του αλφαριθμητικού σAr, PE 2! Είναι hash = 10 + 51 + 7 – 2 = 66.
Υπολογισμός μονοψήφιου νούμερου από hash: 66 -> 6 + 6 = 12 -> 1+2=3.Υπολογισμός
παραγοντικού: 3! = 1 * 2 * 3 = 6 

### Yλοποίηση:
Η υλοποίηση έγινε σε 2 υπορουτίνες, η πρώτη υπολογίζει το hash από το αλφαριθμητικό και η δεύτερη υπολογίζει το μονοψήφιο νούμερο από το άθροισμα των ψηφίων καθώς και το παραγοντικό του.

Για την πρώτη υπορουτίνα σε assembly, ο κώδικας λειτουργεί ως εξής. Μόλις πάρουμε τον κωδικό σε ASCII του χαρακτήρα που θέλουμε να υπολογίσουμε, ελέγχουμε κάθε φορά αν είναι μεγαλύτερη η τιμή του από ένα όριο και εκτελούμε αντίστοιχα μία ενέργεια έχοντας ως προεπιλογή το 0. Με αυτό τον τρόπο ουσιαστικά για κάθε επιλογή εκτελούμε έναν έλεχγο, αντί για δύο και δεν χρειάζεται να κάνουμε flush στο pipeline, αλλά εκτελούμε κάποιες παραπάνω πράξεις.
	Συγκεκριμένα η προεπιλεγμένη περίπτωση είναι εάν ο κωδικός, έστω Ν, είναι μικρότερος του 48 όπου βάζουμε στον R2 το 0. Μετά εάν ο κωδικός είναι μεγαλύτερος του 48 βάζουμε στον 
R2 = 48 – Ν ώστε να πάρουμε αρνητικό αριθμό. Στην συνέχεια εάν ο κωδικός είναι μεγαλύτερος του
58 βάζουμε 0 καθώς είναι <<ανεπιθύμητο>> σύμβολο, ενώ εάν είναι μεγαλύτερος του 93 αποθηκεύουμε σε έναν καταχωρητή, τον R4, R4 = N – 93, ώστε να πάρουμε την θέση του χαρακτήρα στο αλφάβητο. (πχ a = 0, b = 1, c = 2 κλπ). Έτσι μετά παίρνουμε την τιμή του table ως table[R4],  του οποίου η θέση μνήμης το πρώτο στοιχείο είναι αποθηκευμένη στον R1. Τέλος αν Ν > 123 έχουμε πάλι <<ανεπιθύμητο>> σύμβολο οπότε βάζουμε 0.
	Σε κάθε επανάληψη στην αρχή του βρόγχου ελέγχουμε εάν ο κωδικός Ν είναι 0, 10, 13 που είναι κάποι συνηθισμένοι χαρακτήρες λήξης αλφαριθμητικού και βάζουμε στον R4 = 0 που αποτελεί την προεπιλογή . Σε αυτή την περίπτωση βγαίνουμε από τον βρόγχο και αλγόριθμος τερματίζει. Παράλληλα στο τέλος κάθε βρόγχου προσθέτουμε το αποτέλεσμα του R2 στον R0 (που είναι η έξοδος).
  
 Για την δεύτερη υπορουτίνα, έχοντας έτοιμο το hash του αλφαριθμητικού, η διαδικασία γίνεται σε 3 στάδια. Πρώτα χωρίζουμε τον αριθμό στα ψηφία του, έπειτα προσθέτουμε τα ψηφία μεταξύ τους και μετά υπολογίζουμε το παραγοντικό. 
	 Για το πρώτο στάδιο ακολουθήθηκε η εξής λογική:
 Καθώς έχουμε έναν αριθμό π.χ xy στο δεκαδικό, για να χωρίσουμε τα ψηφία του χρειάζεται απλώς να πάρουμε το xy%10 -> y, έπειτα να διαιρέσουμε τον xy/10 και αυτό να το κάνουμε μέχρι να πάρουμε όλα τα ψηφία, όπου και θα μπορούμε να τα προσθέσουμε μεταξύ τους. Σε ψευδοκώδικα:
 ```
 while(n>0){
 sum =+ n mod 10
 n=n/10
 }
 ```
Και αυτό όσες φορές χρειαστεί μέχρι να μείνει μονοψήφιο άθροισμα.
	Σε assembly το παραπάνω είναι εύκολο να υλοποιηθεί με ένα tag loop. Έχοντας στον καταχωρητή R1=10 το modulo το συνθέτουμε από μια SDIV,μια MUL και μια SUBS δηλαδή κάνοντας ευκλείδια διαίρεση με 10, ξαναπολλαπλασιάζοντας με 10 και αφαιρώντας από την αρχική τιμή το αποτέλεσμα. Με μία CMP R2,#0, ελέγχουμε ουσιαστικά αν έχουν μείνει άλλα ψηφία στο νούμερό μας. Αν βγούμε από το loop κάνουμε άλλον έναν έλεγχο του αθροίσματος. Αν το άθροισμα είναι πάνω από 10 σημαίνει πως μπορεί να σπάσει κιάλλο στα υπομέρους ψηφία, άρα ξαναγυρνάμε στο προηγούμενο loop.
	Για το παραγοντικό έπειτα ακολουθήσαμε τον πολλαπλασιασμό από δεξιά προς τα αριστερά, δηλαδή για παράδειγμα αν έχουμε 4!=1x2x3x4,  σε assembly θα πολλαπλασιάζουμε την τιμή του καταχωρητή με τον αμέσως μικρότερο ακέραιο μέχρι αυτός να είναι η μονάδα. Εδώ αποφασίσαμε πως αν το hash έχει βγει αρνητικός αριθμός να πάρουμε το απόλυτό του.
	
### Σχόλια και προβλήματα:

Για το testing δοκιμάσαμε διάφορους συνδυασμούς αλφαριθμητικών, ώστε να είμαστε σίγουροι πως και οι δύο υπορουτίνες τρέχουν ομαλά. Από αυτή τη διαδικασία προέκυψε και το "γκρι σημείο" για τους αρνητικούς αριθμούς, όπου απλά αποφασίσαμε να παίρνουμε το απολυτό τους. Μια δεύτερη υλοποίηση της δεύτερης υπορουτίνας(για αποφυγή της κοστοβόρας διαίρεσης) που τελικά δεν υλοποιήσαμε τελειωτικά ήταν η μετατροπή του hash σε bcd μορφή και έπειτα με τα κατάλληλα shifts η άθροιση των ψηφίων.

