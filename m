Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4E5E12B39D
	for <lists+linux-iio@lfdr.de>; Fri, 27 Dec 2019 10:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726270AbfL0Jpv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Dec 2019 04:45:51 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:26653 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfL0Jpv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Dec 2019 04:45:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1577439945;
        s=strato-dkim-0002; d=plating.de;
        h=In-Reply-To:Date:Message-ID:From:References:Cc:To:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=8Uj3Yutq6rmg7bXOphCTXSkbMv/4v2GPizzWOcZ/IoY=;
        b=Fo1+uQwGfJDawD3StrzwB/fzwQBDS9fP5A+exM96mSGNDltKJp1gZ/CL9E6VZXAaBh
        +UpZ/8eJmRvC2EvRKInNS0gC44BFDBzwXiUaiChISPdzSNG9OEwgysVMBC5W4uYewfxk
        WYEF5XYwa2ejEimwEZzEhcB5NqRMrkFAo/M261zU/1sH9Q0iypJ7r+S6T/ueAYdUTXql
        HHnCxAr4w9DQGOBcUyG0B3BGEuUWjVArqRzbeGyTb1eJlWWOopj5ZkEtCdC0QJ6lj9Yo
        ZgHOT4pEfu7QQQl5H5YlAOUIzcrVf/f10ABZfh1bSQgNSoLNzWRx/b42O0ynIu1pG758
        Ei6g==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.1.3 AUTH)
        with ESMTPSA id v070eevBR9ji7Vu
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Fri, 27 Dec 2019 10:45:44 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 5C190120450;
        Fri, 27 Dec 2019 10:45:44 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TP483qbJ8Xt8; Fri, 27 Dec 2019 10:45:36 +0100 (CET)
Received: from [10.173.251.122] (unknown [10.173.251.122])
        by mail.dl.plating.de (Postfix) with ESMTPSA id 5F29212044A;
        Fri, 27 Dec 2019 10:45:35 +0100 (CET)
Subject: Re: [PATCH v3] iio: buffer: align the size of scan bytes to size of
 the largest element
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <kcis.016016E0AABB4ABC824358438D87FE25@mail>
 <9e68de59-db62-5ba7-c5b6-26d2a59610a2@metafoo.de>
 <20191223170530.1dcfff85@archlinux>
 <5d8a64e5-d745-bfc4-57e1-4a24f097d36e@metafoo.de>
From:   =?UTF-8?Q?Lars_M=c3=b6llendorf?= <lars.moellendorf@plating.de>
X-Pep-Version: 2.0
Message-ID: <1aba5eb9-43b4-0fb5-f67f-f4792ce94bfb@plating.de>
Date:   Fri, 27 Dec 2019 10:45:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <5d8a64e5-d745-bfc4-57e1-4a24f097d36e@metafoo.de>
Content-Type: multipart/mixed;
 boundary="------------0F87A76989D4717233D5229D"
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a multi-part message in MIME format.
--------------0F87A76989D4717233D5229D
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 26.12.19 22:16, Lars-Peter Clausen wrote:
> On 12/23/19 6:05 PM, Jonathan Cameron wrote:
>> On Mon, 16 Dec 2019 08:51:27 +0100
>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> On 12/15/19 10:09 PM, Lars M=C3=B6llendorf wrote:
>>>> -----Urspr=C3=BCngliche Nachricht----- =20
>>>>> Von: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
>>>>> Gesendet: Freitag 13 Dezember 2019 14:58
>>>>> An: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@g=
mx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pme=
erw@pmeerw.net>; linux-iio@vger.kernel.org
>>>>> CC: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
>>>>> Betreff: [PATCH v3] iio: buffer: align the size of scan bytes to si=
ze of the largest element
>>>>>
>>>>> Previous versions of `iio_compute_scan_bytes` only aligned each ele=
ment
>>>>> to its own length (i.e. its own natural alignment). Because multipl=
e
>>>>> consecutive sets of scan elements are buffered this does not work i=
n
>>>>> case the computed scan bytes do not align with the natural alignmen=
t of
>>>>> the first scan element in the set.
>>>>>
>>>>> This commit fixes this by aligning the scan bytes to the natural
>>>>> alignment of the largest scan element in the set. =20
>>>>
>>>>
>>>>
>>>> After re-reading my commit message, I come to the conclusion that it=
 really is sufficient to align the scan bytes to the natural alignment of=
 the *first* element. This would save us the `max()` comparisons for each=
 bit. At the moment I am not at my workstation, but I could submit a v4 n=
ext Friday.
>>>>  =20
>>>
>>> I thought so too in the beginning, but as Jonathan pointed out, it do=
es
>>> not work for all cases. Lets say you have u16,u16,u32,u16. If all
>>> channels are enabled the size is aligned to the first element, but th=
e
>>> u32 would not be aligned in the second dataset.
>>>
>>
>> I'm sitting on this at the moment... Can I confirm we have consensus
>> that this patch is the correct fix?
>>
>> Lars and Lars?
>=20
> Current version looks good to me.

I agree that the current implementation will fix the aforementioned cases=
=2E

> Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>
>=20
>>
>> Thanks,
>>
>> Jonathan
>>
>>
>>>>
>>>>  =20
>>>>> Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable muc=
h more
>>>>> general.")
>>>>> Signed-off-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
>>>>> ---
>>>>> v3:
>>>>>   - Fix the problem description in the commit message
>>>>>   - Add "Fixes" tag
>>>>>
>>>>> v2:
>>>>>   - Fix subject of patch which marked it the first in a set of thre=
e.
>>>>>   - Add a description of the problem in the commit message
>>>>>
>>>>> ---
>>>>>  drivers/iio/industrialio-buffer.c | 6 +++++-
>>>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/indust=
rialio-buffer.c
>>>>> index 5d05c38c4ba9..2f037cd59d53 100644
>>>>> --- a/drivers/iio/industrialio-buffer.c
>>>>> +++ b/drivers/iio/industrialio-buffer.c
>>>>> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_de=
v *indio_dev,
>>>>>  				const unsigned long *mask, bool timestamp)
>>>>>  {
>>>>>  	unsigned bytes =3D 0;
>>>>> -	int length, i;
>>>>> +	int length, i, largest =3D 0;
>>>>>
>>>>>  	/* How much space will the demuxed element take? */
>>>>>  	for_each_set_bit(i, mask,
>>>>> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_=
dev *indio_dev,
>>>>>  		length =3D iio_storage_bytes_for_si(indio_dev, i);
>>>>>  		bytes =3D ALIGN(bytes, length);
>>>>>  		bytes +=3D length;
>>>>> +		largest =3D max(largest, length);
>>>>>  	}
>>>>>
>>>>>  	if (timestamp) {
>>>>>  		length =3D iio_storage_bytes_for_timestamp(indio_dev);
>>>>>  		bytes =3D ALIGN(bytes, length);
>>>>>  		bytes +=3D length;
>>>>> +		largest =3D max(largest, length);
>>>>>  	}
>>>>> +
>>>>> +	bytes =3D ALIGN(bytes, largest);
>>>>>  	return bytes;
>>>>>  }
>>>>>
>>>>> --
>>>>> 2.23.0
>>>>> =20
>>>
>>
>=20

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


--------------0F87A76989D4717233D5229D
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

--------------0F87A76989D4717233D5229D--
