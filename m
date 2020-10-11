Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3237428A764
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730084AbgJKMmE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 08:42:04 -0400
Received: from mout.gmx.net ([212.227.17.22]:40337 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729855AbgJKMmD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 08:42:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602420103;
        bh=bOrUn2gGWuttQJYlzWNs5PvLM3GvFgJsWN3SpxCBE8g=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=RPXFHh6h3lRuKJoiplJ8hDNCaAsdoDvljRk3vyT9iv1T5XECkPakN2tpbFCi7j0bI
         XLrFHipyQvNbIjAqhmstx1+63X1TKsPlebKYseV4dMq5BeoJIZhptPrKnyVGz+q2/X
         wfUxGTj6qks6NohlPEuBzInp0yC/xHseO0ikLgHc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3KPq-1kI0DF1XQQ-010LGe; Sun, 11
 Oct 2020 14:41:43 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH] iio:core: In map_array_register() cleanup in case of error
Date:   Sun, 11 Oct 2020 14:41:20 +0200
Message-Id: <1602420080-15905-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:auvZJFF1EWZ2bNS8FuYIqdbhOLDRb8x3eW90TO2NSxkLGYaMDzc
 NUGqexM9a2mHUgGexziVp1QMPvJcQ5LkEGVMEeV9vuhkr+6x2bNsSGM3xxRC806dGqpSwvd
 rayzJ/kQvSf6djQAxzrXBZi8jm1crJwC74lzFtsjJaEXJvDkNsH5Mp6zt52drTnyfAryWWQ
 8MXdFDe5JEOpahop3QAOg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:+CSi/9hUOeY=:BAy1mILmvSOgl341F56JqL
 w4cFhmKKK5K/Xcc2IJQWjFi0pxRvmCfJIAh4Ois2UM3q/cCOORKtIxYZ6YIvjwhp2uu3TDuiv
 HchhRrsvRuoumC2b7bPYSS/pBT/gec/Rd45m5JarqtCPgFpC/UWVOvWoO3FFQga/zQvU7s6Ne
 sVyfm1KG158boJ0nz3YYfSA+YLR2IVHQ0JCdmiVAm++Gqf2v9SGiVAYobgm9U/loxG8PnbOyR
 6iE/sAPbpsjNACWfZLauyV7VRjsINP75/ma2A0bkkYVRajDdrOIKt2NwCRbXCAkis9NKKGnMe
 Ix9Tt3Lw53bpR57+LaFX9+Fbemd8LF14NpkD/MDSAeMpVwsYU8WJMxtC9x88PyTMKBz343StI
 TNAL8U5PQUDm6xfsKi7mX0Udwz/+Ax9rDwbhZxKQaVsg2a42TdrTkzIXkL2gov0Rq2QhXHDfx
 6NfVP6FtRo5pM9cEnZMRMU1+D5WZmh6LRMvjoKS5tTEpn9JD3b4x/p1Mmsm4tERHFjCbzTJ37
 yPTfl+LFWY6EdZCdQ5UE5mQRKzNqO5Zy7Li75KOdZbUNejUkcUf1+akD1vB38PZ7n0wb0ETrB
 oXYdvfORmJAk8x4+5SObBMPLqekZdg3A+86e1Tv1srsqkXQ+wnlCEvguCtsajY4z1w8c8jxje
 ZozxZleA7AApUE6EeAxOx2HbQCYs4W0dMoJ69SAsQFPRUUfUm3AbdVlgGBd3qUJKX3CJFAn7C
 T30/hM4rR5v34/1FZoTumPOsuhC3FyWRWh6oZ+4jOLmIC6Q42KS05PvaSLeM/6z8G+ldiutu4
 fKcU8gIKVjLeYBaxTrSgQNdrJ3JR8HnNxO9b2UbOQrWpHvlpdQvI+GE2FLYb+EWeOTUHOMAS/
 XAhyoZMBc/1CJTmBmoUmfGY+koXd/ob+a79+tsmeNOR81udrfiIWqtVTJ4FJPsl3pXmvnlfyP
 f1ECpq5yqh2/Y1rxj8UKft/+4WmeM86MzyIn8Lax+4fSTv0EFD1pOA0/Px2zV8q2LGJQ756bA
 4GClEG4vTE2ySyobNSd6E7NejDkZOGuPWpyLIvyaRd/IyunOxCv8HvIeodXP2V8maZC3OscEl
 xBJYWsqF3uv+WzKbkHEliqTZ1S1WqtsgcDtx+qJJDb3se+JqBJcIq2DE7P63w7Ee+TLrMHnO4
 iuI38pOD1QBvkujneOrWHYV6oWKFyJUiQ2L9wWSZFWdhkBDzUj3f3qHcJROoqeZ9FEaneYp43
 AFnoI9rZTuAV5zlBUCPkA6e8nktTQwCP5YaaRbw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function map_array_register() properly rewind in case of error.
Furthermore save an extra label by using a break instead of goto to leave
the concerning loop.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
=2D--
 drivers/iio/inkern.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 5a8351c..0735cc4 100644
=2D-- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -28,6 +28,7 @@ int iio_map_array_register(struct iio_dev *indio_dev, st=
ruct iio_map *maps)
 {
 	int i =3D 0, ret =3D 0;
 	struct iio_map_internal *mapi;
+	struct list_head *pos, *tmp;

 	if (maps =3D=3D NULL)
 		return 0;
@@ -37,14 +38,22 @@ int iio_map_array_register(struct iio_dev *indio_dev, =
struct iio_map *maps)
 		mapi =3D kzalloc(sizeof(*mapi), GFP_KERNEL);
 		if (mapi =3D=3D NULL) {
 			ret =3D -ENOMEM;
-			goto error_ret;
+			break;
 		}
 		mapi->map =3D &maps[i];
 		mapi->indio_dev =3D indio_dev;
 		list_add_tail(&mapi->l, &iio_map_list);
 		i++;
 	}
-error_ret:
+
+	if (ret) { /* undo */
+		while (i--) {
+			mapi =3D list_last_entry(&iio_map_list,
+					       struct iio_map_internal, l);
+			list_del(&mapi->l);
+			kfree(mapi);
+		}
+	}
 	mutex_unlock(&iio_map_list_lock);

 	return ret;
=2D-
2.7.4

