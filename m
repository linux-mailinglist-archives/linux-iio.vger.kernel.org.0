Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D496228A939
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 20:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJKSW7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 11 Oct 2020 14:22:59 -0400
Received: from mout.gmx.net ([212.227.17.20]:49691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbgJKSW7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Oct 2020 14:22:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602440554;
        bh=eZEAipj0V5AkYqYKFqJUB/3l8LkxQ8oGC4BmuE0uqmo=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=a72B9GP4pqIdIzQLiu2zip4N2EtoBEdBT93M4MxrwoDqV+fuYUo8DFzbV7PVxln0e
         yeHakh/jWFewoQaEBZhznZcV+koJmkpx2RQz2Q/ovsJY9a6xomuygAd2s9i1ez+vRu
         UKCUXqM+xdcEmUDjFFjdu4i0A1jIvfCCL49Algss=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MuDbx-1kD9oF0uj7-00uXSg; Sun, 11
 Oct 2020 20:22:34 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     jic23@kernel.org
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH v2] iio:core: In map_array_register() cleanup in case of error
Date:   Sun, 11 Oct 2020 20:22:26 +0200
Message-Id: <1602440546-2376-1-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <20201011160748.4a47b889@archlinux>
References: <20201011160748.4a47b889@archlinux>
X-Provags-ID: V03:K1:PJ+A8k9DIDJRgTrIAmbJLU6CFrKNHSBehk1RWkv5SDe/TvM46Ji
 90FwaqdQvNHz3RjwVVhmPkzWEwAlaNSB8bY1VkScsQtytSgFQRxocf2zE90KBNarV73WDvk
 RytoJSZMzunfA6MI/KvJk2Jn6Ge+OUgNZXDRzQeGwATD83C30tXczzWDbeYUSKdNePfKjDH
 Cie2XnrpR46DWLfsQO4xg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qozrvcL/K68=:/L3VQvLxouEcsJ0ImHNWaW
 QBsn54CjReG/T5b7nqi8FY4xOJEsSkuveA956PNf09qlvD3MhOSI2QWtIldC6GcH2T52/18ks
 +n6m1otq2IKQBPQ1YxDi79j5byX5j5gf4rNuWRX3p5MmPH1DZe8vDD1RNt2InAJUWt1L2erap
 Ud3Heg//UsOAlL1+61mdKJliWsCW3Uym5kiy7NKyTXShBLfZ1jztelxLyA2jlvJIl23lgNLM1
 5pBZbSrPRTv86v288DUhJ4Yvf/iwnO2R2OkmwVkvEO3rmbgV8VUzSVIhdg8b9GUZF9veKesaZ
 EKtAhTgwJCQYwm85hQsqYRQ6lF/4sSRoy7eliJ2TQGY/5j4fFnlbDFtnMQ7AyXFGXlg8pNByR
 yAG8+QF/j8U6EqqwNe1Melms49u2x9Vgod/rOAEsEY+s9sEswCbRX0r6xgZYgiiRGtyhnC24V
 FI9XV3SfPgv7gVt/5rzvP+c+5VQleqS6i4sO4AN5/BxY0NHXkcOo68hcHKMdtCCQgRq+1ih4E
 dfJ7qYKJsx/g2IknY/aU8I64nGgFQ9hOgUA1ACiXavX1IIkUGgQqux5pbJ7tMwmGTPwH0AdnN
 3hbA+heV9V+1gK84CjeqAx0ATnmZxyynE0O5DQA571RVvKdspORpvkCVwDYzbPYoQBB2cePfz
 Kp81t90c5ox6fxzN2ttTJAgGAwYA12xf8cWFKQuuwrX8EMl4oEPnW9MzGcAV5gyfsdQqi7JCB
 TKYy2hXEJ07h6UYXpebod9OZrSOsDsXlqzAg6EyliQe1G4xNyUgM7vv/gerG50Un3abvr4FH8
 l8GyNxb5+ScM2KI4DkZdoCEyJIzJoIzyMqaVFNuTmbAllwvet2Ap4+5+417e52ptCPbcOiX75
 39tzUs15qsrz7AiEKYyirlIxiD/fUjFj1DF57Ajrlw8oQPARyLR9oSdpSh13aiyRiNKdcpp2r
 OJugPpnrF2cPXmeEu+Ie8rda1fw6xCYLnStPxx9L+OqlITjpkAc75aiI0DQwe4yBjcaicTM+t
 IGNjx6GdCYDZbEzVevUkT4+03Px/Sqdbk8vE6asE4Bky8HXOFGUsTZd3+J39dplFaUrV++lYn
 zem4RanbkBCJz0mbvKf12hIrU2U/DeMseJP0uhEeO6pADXlwCOpk9MeI5s3pn7MX1N73V0aSe
 VjidZCpiZdMZQZkzPGNzmZsQnqGtxtfANP2pnlNsbigAVMgPmjorQis1Rz3M++th3ja6CQF8T
 H8H3sbXusVUUWWC1mV5bu6Cs5LqiVXiusTVb85w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

In function map_array_register() properly rewind in case of error.
Furthermore remove the now superfluous initialization of "ret" with 0.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
=2D--
 drivers/iio/inkern.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index 5a8351c..9dedc30 100644
=2D-- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -26,7 +26,7 @@ static DEFINE_MUTEX(iio_map_list_lock);

 int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *map=
s)
 {
-	int i =3D 0, ret =3D 0;
+	int i =3D 0, ret;
 	struct iio_map_internal *mapi;

 	if (maps =3D=3D NULL)
@@ -44,7 +44,18 @@ int iio_map_array_register(struct iio_dev *indio_dev, s=
truct iio_map *maps)
 		list_add_tail(&mapi->l, &iio_map_list);
 		i++;
 	}
+	mutex_unlock(&iio_map_list_lock);
+
+	return 0;
+
 error_ret:
+	/* undo */
+	while (i--) {
+		mapi =3D list_last_entry(&iio_map_list, struct iio_map_internal,
+				       l);
+		list_del(&mapi->l);
+		kfree(mapi);
+	}
 	mutex_unlock(&iio_map_list_lock);

 	return ret;
=2D-
2.7.4

