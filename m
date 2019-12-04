Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA6F511272C
	for <lists+linux-iio@lfdr.de>; Wed,  4 Dec 2019 10:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbfLDJYr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 4 Dec 2019 04:24:47 -0500
Received: from mo4-p02-ob.smtp.rzone.de ([85.215.255.81]:30489 "EHLO
        mo4-p02-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727425AbfLDJYq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 4 Dec 2019 04:24:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1575451481;
        s=strato-dkim-0002; d=plating.de;
        h=In-Reply-To:Date:Message-ID:From:References:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=qPfG4pqms1E1nNyYO/dUhuUn2d0RD+MYBznsYgNCklU=;
        b=Sj3TqdIMDpKB+gVZdzvRZ/kQP66GNEVqD2RBBz+GcColykpz858NxSlt48vt+bYEni
        U1daCP5sRT06En7tOEtrkBwZOOOS/UyXgQZD7vuvKgIrj81Sby3rerdK8gfO1bJPb+kA
        RBKvRGkl/0bvRohMbB/8T0V/60ZZle7LGYalYj8JD5OoYH/RZ4XMj8lkEZ/49PudHyW7
        GYe7tPHYKBRqt64WeJynF45/miPZoAXvON/k/7AenPgncHQR+NRykYP4D8QFXb5hgnnd
        X0mh70y3w7aWNqXpfs1MJciSWFHroXx7a03UQ979T7Vp/+6waGjC9pxiWVRLXlOXzFNS
        A5dg==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.0.2 AUTH)
        with ESMTPSA id n0aa50vB49Oe7qK
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 4 Dec 2019 10:24:40 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 6FC1E122217;
        Wed,  4 Dec 2019 10:24:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3z2ugWq5SZDR; Wed,  4 Dec 2019 10:24:34 +0100 (CET)
Received: from [172.16.4.186] (unknown [172.16.4.186])
        by mail.dl.plating.de (Postfix) with ESMTPSA id 2D513120429;
        Wed,  4 Dec 2019 10:24:33 +0100 (CET)
Subject: Re: [PATCH 1/3] iio: buffer: align the size of scan bytes to size of
 the largest element
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
References: <810ab64f-31bf-c4af-a655-7bddf364dae4@metafoo.de>
 <20191202130113.24005-1-lars.moellendorf@plating.de>
 <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
From:   =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>
Message-ID: <a6b4d1aa-cb7b-690e-f0b0-2171f993f679@plating.de>
Date:   Wed, 4 Dec 2019 10:24:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <531d08db4d758cb8ab9f7e1955c7b918ff2b0c69.camel@analog.com>
Content-Type: multipart/mixed;
 boundary="------------09C45F0841F2CB5C2E14C937"
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------09C45F0841F2CB5C2E14C937
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02.12.19 14:37, Ardelean, Alexandru wrote:
> On Mon, 2019-12-02 at 14:01 +0100, Lars M=C3=B6llendorf wrote:
>>
>=20
> Hey Lars,
>=20
> Thank you for the patch.
>=20
> Could you add a description of the problem in the commit description?
> You did a really great job on describing it via email earlier, and it w=
ould
> be great to have it in the git history as well.

Is the description in my latest patch ok?


> Also, this patch is marked 1/3 ; curios: are there 2 more patches in a =
set?
> Sometimes, some patches get lost via email clients/servers.

No, there is only one patch. I just did not use `git format-patch`
correctly in my first attempt.

> Maybe Jonathan [or someone else] has some more points to this.

Anything else I can do to improve the patch? It is the first time I am
trying to submit a patch to the kernel. Would be nice to know if it is
accepted and if not, why. So I can learn from my mistakes.

>=20
> Thanks
> Alex
>=20
>> Signed-off-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
>> ---
>>  drivers/iio/industrialio-buffer.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/industrialio-buffer.c
>> b/drivers/iio/industrialio-buffer.c
>> index 5d05c38c4ba9..2f037cd59d53 100644
>> --- a/drivers/iio/industrialio-buffer.c
>> +++ b/drivers/iio/industrialio-buffer.c
>> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_dev
>> *indio_dev,
>>  				const unsigned long *mask, bool timestamp)
>>  {
>>  	unsigned bytes =3D 0;
>> -	int length, i;
>> +	int length, i, largest =3D 0;
>>
>>  	/* How much space will the demuxed element take? */
>>  	for_each_set_bit(i, mask,
>> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_dev=

>> *indio_dev,
>>  		length =3D iio_storage_bytes_for_si(indio_dev, i);
>>  		bytes =3D ALIGN(bytes, length);
>>  		bytes +=3D length;
>> +		largest =3D max(largest, length);
>>  	}
>>
>>  	if (timestamp) {
>>  		length =3D iio_storage_bytes_for_timestamp(indio_dev);
>>  		bytes =3D ALIGN(bytes, length);
>>  		bytes +=3D length;
>> +		largest =3D max(largest, length);
>>  	}
>> +
>> +	bytes =3D ALIGN(bytes, largest);
>>  	return bytes;
>>  }
>>
>> --
>> 2.23.0
>>

--=20

Lars M=C3=B6llendorf, B. Eng.


Tel.:    +49 (0) 7641 93500-425
Fax:     +49 (0) 7641 93500-999
E-Mail:  lars.moellendorf@plating.de <mailto:lars.moellendorf@plating.de>=

Website: www.plating.de <http://www.plating.de>

--------------------------------
plating electronic GmbH - Amtsgericht Freiburg - HRB Nr. 260 592 /
Gesch=C3=A4ftsf=C3=BChrer Karl Rieder / Rheinstra=C3=9Fe 4 =E2=80=93 7935=
0 Sexau =E2=80=93 Tel.:+49 (0)
7641 =E2=80=93 93500-0

--------------------------------
Der Inhalt dieser E-Mail ist vertraulich und ausschlie=C3=9Flich f=C3=BCr=
 den
bezeichneten Adressaten bestimmt. Wenn Sie nicht der vorgesehene
Adressat dieser E-Mail oder dessen Vertreter sein sollten, so beachten
Sie bitte, dass jede Form der Kenntnisnahme, Ver=C3=B6ffentlichung,
Vervielf=C3=A4ltigung oder Weitergabe des Inhalts dieser E-Mail unzul=C3=A4=
ssig
ist. Wir bitten Sie, sich in diesem Fall mit dem Absender der E-Mail in
Verbindung zu setzen. Aussagen gegen=C3=BCber  dem Adressaten unterliegen=
 den
Regelungen des zugrundeliegenden Angebotes bzw. Auftrags, insbesondere
den Allgemeinen Gesch=C3=A4ftsbedingungen und der individuellen
Haftungsvereinbarung. Der Inhalt der E-Mail ist nur rechtsverbindlich,
wenn er unsererseits durch einen Brief oder ein Telefax entsprechend
bestaetigt wird.

The information contained in this email is confidential. It is intended
solely for the addressee. Access to this email by anyone else is
unauthorized. If you are not the intended recipient, any form of
disclosure, reproduction, distribution or any action taken or refrained
from in reliance on it, is prohibited and may be unlawful. Please notify
the sender immediately. All statements of opinion or advice directed via
this email to our clients are subject to the terms and conditions
expressed in the governing client engagement letter. The content of this
email is not legally binding unless confirmed by letter or fax.

Although plating electronic GmbH attempts to sweep e-mail and
attachments for viruses, it does not guarantee that either are
virus-free and accepts no liability for any damage sustained as a result
of viruses.


--------------09C45F0841F2CB5C2E14C937
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

--------------09C45F0841F2CB5C2E14C937--
