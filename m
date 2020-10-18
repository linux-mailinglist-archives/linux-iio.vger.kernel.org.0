Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBFC291539
	for <lists+linux-iio@lfdr.de>; Sun, 18 Oct 2020 03:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440087AbgJRBOe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Oct 2020 21:14:34 -0400
Received: from mout.gmx.net ([212.227.15.19]:44835 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2440072AbgJRBOd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 17 Oct 2020 21:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602983624;
        bh=xW7mvI7uzI88tMSOvaYU/gCovxydh6Fagjlq8pBOphQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZTYKX1TjGFRs9YpEVzZc6ysvLpEFCHqtMkRgV23hO2YAk75JA0eRWB02/bao9x0cJ
         iHrIwQq5Vyfkot9+WUuHGxjSQJTXmBlQCXpk62JmPj/A+hrV/a93YpgxtUo3fJOwf1
         3VQPpvrj+xiQUDLmT2Lt4kbZeZKuxyF5ltZ3NpV0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from Venus.fritz.box ([78.42.220.31]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQ5vW-1kq0Ma0E8e-00M3j9; Sun, 18
 Oct 2020 03:13:44 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     andy.shevchenko@gmail.com
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>
Subject: [PATCH 1/2] iio:core: Introduce unlocked version of iio_map_array_unregister()
Date:   Sun, 18 Oct 2020 03:11:55 +0200
Message-Id: <1602983516-22913-2-git-send-email-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de>
References: <CAHp75VfQ=fFn_r43VPV0uPCkozS2K=VQsuSEyj0mF+7QVsFQuA@mail.gmail.com>
 <1602983516-22913-1-git-send-email-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aXACTiC5vRlBP2D23fJF+R6x7IdJQpki58X3aE8oKMgksU/R0z6
 6DiDW9j9/kXo7g924lleWJRmoEfMV3M39yutBqBb4cohdJEgLs4Zp3SJQ9B9YtSVdV3tVnn
 ZbAaB4aa1yXvHAwfWa7KIIDi2OjA6q3hiVYc3uaECsvviepx1UwtSLzaXE54hBNdQWMU2Sh
 nzIfCrJ+fY6T7HZVWWZxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:mv8/f+B8eWQ=:LLjXPpLE//ol8lO1hIhcQB
 FYiNTtaV/BKd2Tg5gD1A5+bo1aHXrrXVara/wUAYrHuRIe6Q+pzt/NQQN7GBK07bEczIMJfuG
 WAKxObkQhtw6VVXO4kcQADheboYxx0unCRKGlwrSBWVumV0g/mG+yBqaDWNwb7AnQsK33HnnF
 cEYSXtRDmSX91hYm8QGjB4cgtTFyrgeL/XE8KCPv6Tbf/p3dRPY1Se8yZAdmb5Br6yZkjZdWS
 gtufWE2Mcv2kARYSoX3MQCvbQygST8u7GlCTM03G2zAbO+ZePVZcJCsJj4JpdVw1YNUP/uikK
 pRHhrHHTSFPgxp5+LVbfY55U+N05aWAyH651tJpTdu3j5umAMPb2Z4Z8Yqew60o/DcNs8yece
 fLKwaLq93QVyUZ121oCE6qQ8NPk6/heQDXysBxv59iiTRA0rv2sXlTCTuXje/yB3cazvU/CeO
 yJBrC3Zs+/BupVLsn3Y+TFDcvbTAGSlPYL85KvX64JQtscTKzfRlWYiXJEDBbovfo8U7OuJgH
 X+4xr5DnTDPi7z8vsFuFgYu7S09YVBBvUjAMXMJG6f9136NR9bVQ4Ut4CxpEu3ECNC0X05ZiC
 oNCj74sK7mjHcUKhMw7fVy/u4c+ZdUrloT13GRRKdajekmrlO4Z4Q6yatZViQpYfemcufVUfD
 JzIylWWdyyPsOc9oQQ/6pf+DlPremib8C4fU6e3yV0EsZhujz3SY2VDbbW4XHAZx3qIShhhcp
 YZuXCxmqQBKBxUoBV3GAihTYF3xF0PEv655D9HlBekwbYF+8DWKPkCehKSGwxvUttQFRSy7qD
 DXxzsjjU+ZbgQuXZ9vMOPnMCZqFTjLCeavLn1G3+2MMa1Wp8SRIEuSPt8qOX0GQMJXbxo7Ce7
 KXdGvsV+8NYY9w1kvYZA==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Introduce an unlocked version of iio_map_array_unregister(). This function
can help to unwind in case of error while the iio_map_list_lock mutex is
held.

Signed-off-by: Lino Sanfilippo <LinoSanfilippo@gmx.de>
---
 drivers/iio/inkern.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
index ede99e0..39c1d63 100644
--- a/drivers/iio/inkern.c
+++ b/drivers/iio/inkern.c
@@ -24,6 +24,21 @@ struct iio_map_internal {
 static LIST_HEAD(iio_map_list);
 static DEFINE_MUTEX(iio_map_list_lock);
=20
+static int iio_map_array_unregister_locked(struct iio_dev *indio_dev)
+{
+	int ret =3D -ENODEV;
+	struct iio_map_internal *mapi, *next;
+
+	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
+		if (indio_dev =3D=3D mapi->indio_dev) {
+			list_del(&mapi->l);
+			kfree(mapi);
+			ret =3D 0;
+		}
+	}
+	return ret;
+}
+
 int iio_map_array_register(struct iio_dev *indio_dev, struct iio_map *maps)
 {
 	int i =3D 0, ret =3D 0;
@@ -57,18 +72,12 @@ EXPORT_SYMBOL_GPL(iio_map_array_register);
  */
 int iio_map_array_unregister(struct iio_dev *indio_dev)
 {
-	int ret =3D -ENODEV;
-	struct iio_map_internal *mapi, *next;
+	int ret;
=20
 	mutex_lock(&iio_map_list_lock);
-	list_for_each_entry_safe(mapi, next, &iio_map_list, l) {
-		if (indio_dev =3D=3D mapi->indio_dev) {
-			list_del(&mapi->l);
-			kfree(mapi);
-			ret =3D 0;
-		}
-	}
+	ret =3D iio_map_array_unregister_locked(indio_dev);
 	mutex_unlock(&iio_map_list_lock);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iio_map_array_unregister);
--=20
2.7.4

