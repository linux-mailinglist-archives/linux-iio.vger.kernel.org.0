Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94D1111FB64
	for <lists+linux-iio@lfdr.de>; Sun, 15 Dec 2019 22:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfLOVJi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Dec 2019 16:09:38 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.20]:15269 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbfLOVJi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Dec 2019 16:09:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1576444175;
        s=strato-dkim-0002; d=plating.de;
        h=Message-Id:Date:To:From:Subject:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=y//+UnwPsS0RP8TVPRSnhSrh8GeP4PyOWO9gy5PXxlo=;
        b=TSrvN4yMJih2jlY1tP9/fqBpkmxbHOlsMMuLvLwAImmErXfg5Yo6B5IfyoI0/2ta3d
        XWCPnvXdF59QMc35zMpLbCWRvgx1ehL82nmlqNWf4YBmeVqIeT9NVLBAdF3nlawWAITd
        x4vN2nLo4XW+W9IftsmMHqoeAhuitekB5ar0+Bfs3qMVuU5hA1h5w5FbMKdYQHLNKF+j
        eYO/GrQjQpp03hNMVDvRd2OZ+iD4Dxh3NyfRfmyT8EBPgFfAvKByKW+eD6kSVGr337vG
        3ix4gsqqkdhwggPcDkfS8wwXoqDpsxuhajRzRXtXy4570Jz5lA+3Si2GCXsSi/GocabD
        6v2w==
X-RZG-AUTH: ":P2EQZVataeyI5jZ/YFVerR/NeEUpp/1ZEi4FSKT8sA3i0IzVhLiw6JgrUzaKN77axfKEX18="
X-RZG-CLASS-ID: mo00
Received: from mail.dl.plating.de
        by smtp.strato.de (RZmta 46.0.7 AUTH)
        with ESMTPSA id n050dcvBFL9Z9si
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 15 Dec 2019 22:09:35 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 338A3120456;
        Sun, 15 Dec 2019 22:09:35 +0100 (CET)
X-Virus-Scanned: amavisd-new at dl.plating.de
Received: from mail.dl.plating.de ([127.0.0.1])
        by localhost (mail.dl.plating.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id RpxjLWYqlwgO; Sun, 15 Dec 2019 22:09:29 +0100 (CET)
Received: from mail (localhost [127.0.0.1])
        by mail.dl.plating.de (Postfix) with ESMTP id 1568F120436;
        Sun, 15 Dec 2019 22:09:28 +0100 (CET)
Received: by mail (kopano-spooler) with MAPI; Sun, 15 Dec 2019 22:09:27 +0100
Subject: RE: [PATCH v3] iio: buffer: align the size of scan bytes to size of
 the largest element
From:   =?utf-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>
To:     =?utf-8?Q?Lars_M=C3=B6llendorf?= <lars.moellendorf@plating.de>,
        =?utf-8?Q?Jonathan_Cameron?= <jic23@kernel.org>,
        =?utf-8?Q?Hartmut_Knaack?= <knaack.h@gmx.de>,
        =?utf-8?Q?Lars-Peter_Clausen?= <lars@metafoo.de>,
        =?utf-8?Q?Peter_Meerwald-Stadler?= <pmeerw@pmeerw.net>,
        =?utf-8?Q?linux-iio=40vger=2Ekernel=2Eorg?= 
        <linux-iio@vger.kernel.org>
Date:   Sun, 15 Dec 2019 21:09:27 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Priority: 3 (Normal)
X-Mailer: Kopano 8.6.7.0
Message-Id: <kcis.016016E0AABB4ABC824358438D87FE25@mail>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

-----Urspr=C3=BCngliche Nachricht-----
> Von: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> Gesendet: Freitag 13 Dezember 2019 14:58
> An: Jonathan Cameron <jic23@kernel.org>; Hartmut Knaack <knaack.h@gmx.de>; Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org
> CC: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> Betreff: [PATCH v3] iio: buffer: align the size of scan bytes to size of the largest element
>=20
> Previous versions of `iio_compute_scan_bytes` only aligned each element
> to its own length (i.e. its own natural alignment). Because multiple
> consecutive sets of scan elements are buffered this does not work in
> case the computed scan bytes do not align with the natural alignment of
> the first scan element in the set.
>=20
> This commit fixes this by aligning the scan bytes to the natural
> alignment of the largest scan element in the set.



After re-reading my commit message, I come to the conclusion that it really is sufficient to align the scan bytes to the natural alignment of the *first* element. This would save us the `max()` comparisons for each bit. At the moment I am not at my workstation, but I could submit a v4 next Friday.



> Fixes: 959d2952d124 ("staging:iio: make iio_sw_buffer_preenable much more
> general.")
> Signed-off-by: Lars M=C3=B6llendorf <lars.moellendorf@plating.de>
> ---
> v3:
>   - Fix the problem description in the commit message
>   - Add "Fixes" tag
>=20
> v2:
>   - Fix subject of patch which marked it the first in a set of three.
>   - Add a description of the problem in the commit message
>=20
> ---
>  drivers/iio/industrialio-buffer.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 5d05c38c4ba9..2f037cd59d53 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -546,7 +546,7 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  =09=09=09=09const unsigned long *mask, bool timestamp)
>  {
>  =09unsigned bytes =3D 0;
> -=09int length, i;
> +=09int length, i, largest =3D 0;
>=20
>  =09/* How much space will the demuxed element take=3F */
>  =09for_each_set_bit(i, mask,
> @@ -554,13 +554,17 @@ static int iio_compute_scan_bytes(struct iio_dev *indio_dev,
>  =09=09length =3D iio_storage_bytes_for_si(indio_dev, i);
>  =09=09bytes =3D ALIGN(bytes, length);
>  =09=09bytes +=3D length;
> +=09=09largest =3D max(largest, length);
>  =09}
>=20
>  =09if (timestamp) {
>  =09=09length =3D iio_storage_bytes_for_timestamp(indio_dev);
>  =09=09bytes =3D ALIGN(bytes, length);
>  =09=09bytes +=3D length;
> +=09=09largest =3D max(largest, length);
>  =09}
> +
> +=09bytes =3D ALIGN(bytes, largest);
>  =09return bytes;
>  }
>=20
> --
> 2.23.0
>=20
