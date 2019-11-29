Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09CD810D71B
	for <lists+linux-iio@lfdr.de>; Fri, 29 Nov 2019 15:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbfK2Ogs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 29 Nov 2019 09:36:48 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.52]:35825 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726808AbfK2Ogr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 29 Nov 2019 09:36:47 -0500
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Nov 2019 09:36:45 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575038204;
        s=strato-dkim-0002; d=plating.de;
        h=Date:Message-ID:To:Subject:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=ob6/JaL6mTV3z/IzO8lE0djOq/hqJuNOjXL+ZdfBHNM=;
        b=iEGWpttxSDga8hn8wOT3JW8RLUkGVv3Wz5LXWEUwo3f9/CQg3eWfKACuUJbWlEGmX+
        nyM/L9HF3GlMjasEvyl+8TbfaohHImbsz5IL81b0o0AlY9dwZ2xI8I03XZ0Rcvy7yk31
        VW7hE2PsQcmyW6aRjaARRQq5WIr53lUl1QOK3gKLAGQaZ6xhWNp2k0SXL8jCiZKbD9ua
        rhTyNXtvHATVraAsgmMWWmUa2tEAcqImeHpgisjKbtwHL7NVhbSxNIdOlFK8gJrdrS2b
        scTpDL6i4n+x5bpsbizIO1GHgT0D3QkPx/dez/dqGlxsp/66paMQpcQF2/xaK+WEo97T
        g2CQ==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 45.0.2 AUTH)
        with ESMTPSA id x04082vATEUgLfw
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate)
        for <linux-iio@vger.kernel.org>;
        Fri, 29 Nov 2019 15:30:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 5502B12047B;
        Fri, 29 Nov 2019 15:30:42 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HvNMUXq-D37a; Fri, 29 Nov 2019 15:30:37 +0100 (CET)
Received: from [172.16.4.186] (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id 8FB59120433
        for <linux-iio@vger.kernel.org>; Fri, 29 Nov 2019 15:30:36 +0100 (CET)
From:   =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>
Subject: iio_compute_scan_bytes does not seem to account for alignment if
 first channel uses more storagebits than its successors
To:     linux-iio@vger.kernel.org
Message-ID: <ff5a3ea4-4d15-5be3-9cb8-9fd7c716e2e6@plating.de>
Date:   Fri, 29 Nov 2019 15:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------257E4581094833ABC2099637"
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------257E4581094833ABC2099637
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

I have written a custom kernel module implementing the IIO device API
backed by an IIO triggered buffer.

My IIO device provides 3 channels + timestamp. The sizes of the channels =
are

index  | iio_chan_spec.scan_type.storagebits
-------|------------------------------------------------
   0   |  32
   1   |  16
   2   |  16

If I select channel 0 (32bit) and one of channel 1 or 2 (16bit)
indio_dev.scan_bytes and iio_buffer.bytes_per_datum have a value of 6
Byte which does not account for any alignment.


After having a closer look at  `iio_compute_scan_bytes` which is
responsible for calculating both, `indio_dev.scan_bytes` and
`iio_buffer.bytes_per_datum` it seems to me that the order of channels
matter:

```c
	/* How much space will the demuxed element take? */
	for_each_set_bit(i, mask,
			 indio_dev->masklength) {
		length =3D iio_storage_bytes_for_si(indio_dev, i);
		bytes =3D ALIGN(bytes, length);
		bytes +=3D length;
	}
```

I understand that in case the length of each scan element is smaller
then the length of the successive scan elements, this algorithm works
because it aligns the current element to its own length. But if, as in
my case, the length of channel 0's scan elements  is greater then the
size of the samples of the consecutive channels no alignment seems to be
taken into account. Do I miss something here?

To make the algorithm work for any case the greatest length of all
enabled scan elements could be used for alignment, e.g.:

```diff
diff --git a/drivers/iio/industrialio-buffer.c
b/drivers/iio/industrialio-buffer.c
index 5d05c38c4ba9..3d2c4e26d818 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -546,16 +546,18 @@ static int iio_compute_scan_bytes(struct iio_dev
*indio_dev,
 				const unsigned long *mask, bool timestamp)
 {
 	unsigned bytes =3D 0;
-	int length, i;
+	int length, i, align =3D 0, count =3D 0;

 	/* How much space will the demuxed element take? */
 	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		length =3D iio_storage_bytes_for_si(indio_dev, i);
-		bytes =3D ALIGN(bytes, length);
-		bytes +=3D length;
+		align =3D max(align, length);
+		count++;
 	}

+	bytes =3D count * align;
+
 	if (timestamp) {
 		length =3D iio_storage_bytes_for_timestamp(indio_dev);
 		bytes =3D ALIGN(bytes, length);

```

And if the storage bytes for timestamp have to be taken into account for
the alignment of the scan elements (what seems not to be the case as it
is currently implemented), then:

```diff
diff --git a/drivers/iio/industrialio-buffer.c
b/drivers/iio/industrialio-buffer.c
index 5d05c38c4ba9..59aee2ea4e19 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -546,21 +546,23 @@ static int iio_compute_scan_bytes(struct iio_dev
*indio_dev,
 				const unsigned long *mask, bool timestamp)
 {
 	unsigned bytes =3D 0;
-	int length, i;
+	int length, i, align =3D 0, count =3D 0;
+
+	if (timestamp) {
+		align =3D iio_storage_bytes_for_timestamp(indio_dev);
+		count++;
+	}

 	/* How much space will the demuxed element take? */
 	for_each_set_bit(i, mask,
 			 indio_dev->masklength) {
 		length =3D iio_storage_bytes_for_si(indio_dev, i);
-		bytes =3D ALIGN(bytes, length);
-		bytes +=3D length;
+		align =3D max(align, length);
+		count++;
 	}

-	if (timestamp) {
-		length =3D iio_storage_bytes_for_timestamp(indio_dev);
-		bytes =3D ALIGN(bytes, length);
-		bytes +=3D length;
-	}
+	bytes =3D count * align;
+
 	return bytes;
 }
```

But in my case the latter would bloat the buffer from 16 Byte to 4*16 =3D=

64 Byte per scan if all channels are selected and timestamp is active.

For now, I will work around this by using 32 storagebits for all my
channels. This gives my 4 Bytes of overhead per scan if all elements are
selected and additional 2 Byte if timestamp is active.

In "Why do you align the buffer pointer to a multiple of the size of the
current scan element in iio_buffer_foreach_sample()?" on
https://github.com/analogdevicesinc/libiio/issues/324 I have been
pointed to this mailing list.

Regards,
Lars M.

--------------257E4581094833ABC2099637
Content-Type: application/pgp-keys;
 name="pEpkey.asc"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="pEpkey.asc"

-----BEGIN PGP PUBLIC KEY BLOCK-----

mQENBFsNAUABCACbezP4zrBG9BWw9SaAz4LvY6tPQQhMk9+fv6CleGWZIYw5J9Ni
PyV90P/A1nr0Gvn8pMOyBWr0debM1vMWMg6/LB4umeGEIZbXT/+h0paMn4yNCzqn
S1ndTIJ6PmEAGRDfATZKBrQMWqRj/zJvqcOV0n/sEvnGifdM2olVQEyTFXxYYqVI
KBFwP2bjU6vL+43/+rWPMond6FFG4ddz+Mio9i5TGhLgR7ROrsNlEqcwX1s33oiL
Aq+cMwSLz1OFdgLXW8Unq5B0OJcuw1Z5Qy+Q4ge5HIvGxfvFvwuP3Yq1MnOTprC/
kol+0VbWf6j/F58URah5qwdeYYxIio+TDm/BABEBAAG0LkxhcnMgTcO2bGxlbmRv
cmYgPGxhcnMubW9lbGxlbmRvcmZAcGxhdGluZy5kZT6JAVQEEwEIAD4CGwMFCwkI
BwIGFQoJCAsCBBYCAwECHgECF4AWIQSWUL2CuFDU2EeeK/xAA9xF+Xc2PwUCXPE4
uwUJA8Vq+wAKCRBAA9xF+Xc2PycqB/0V1O0/KTN7zJXH4tcLP4m/dzxRzd6WP7W4
85g4fuDRfSyRjLErkTbeHvKQc+KoyLKEznVc+JTrVEvHOCw7m4dbFvBqUi19FohQ
MfT/gZvh3SgCzL1VNEYW6OBo9WoozPKQujWq4zBhbRsce1tFzgZ+E2BIUX43Qoh0
IdkRrfWinHpzZOvWe7XIaV87BtPPusIeTKaEKyEd6Ol20vPl2Gl6ooGONw5y3c8T
D9ncXTdfuCP/9FkisBWLAac3xOilgVyZxWTzNtLz/3/yohUZjF1gL6lRCRlHW1QG
2/Mj6B7AWl4APfPCBhPOftQ5FsNQlMcLtU5PFr9wofW4DYltFQU4uQENBFsNAUEB
CADhdaHowDiVPtwHd2LTb/6RJPhQFWZlgrgk+zfkBjJmRi80nogcZLJFUkWTagiK
qTFsYBWOLZYpU/YBzQXIh/EJ9rDkqn+aNPWEu+YPdQj9V1wBhBr8+2DZe9mqqkgP
4U7U57WKdcOlkjYD5YXpR1Qns48rGRLOQsoO0I+sEpC5hFF50/HiWknqk7xK0G4q
TlHFBSYni5hf0K7/U4d7YuYLbUP19tvPv7IOhfKJbnVHs4//Xt/cKYWBpprJ/G8q
tcrFxmFz7fWoJcq2eM7Ky2ZTq+m74FgRkFHc33zpIhV721iqtD8RCt5laxptokgq
iVAY2pP/mBYr01e1VyAPr7/HABEBAAGJATwEGAEIACYCGwwWIQSWUL2CuFDU2Eee
K/xAA9xF+Xc2PwUCXPE7YQUJA8VtoAAKCRBAA9xF+Xc2P2b3B/9/j1+nI52P3puX
vfeRHPnmbFBGLgB0OTECp6f0/R8oXKcIZSHTKVvRe9cAANKMiEA+SfIMaFHpadHr
zlu5M6bHrurvwWKIT1r84/UGKv/wnCcXvPnF0dupsiZx8Er95c9sx3ftQmwWkG36
+cAqO91S30haamIclq3XYNHsmxKkoQ+b532WdP8pD6JQ4xEQreltelqhnhBwqDC4
yoivK+7UO4HgsXgQ6LXw1Evwy72TwsZ2klg3ZA1KEOIBp10wg30Itg4MjiAnon+6
3hRZueGk3FEyzJrVmaVP2qSdqqz9Tmp6oghpBVzTUgtWhYThsbGjYrYQ5CrKSJjN
LcZ9xDIl
=3Dfv/q
-----END PGP PUBLIC KEY BLOCK-----

--------------257E4581094833ABC2099637--
