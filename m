Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B0E3E3615
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbhHGPXM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 11:23:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:53301 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231159AbhHGPXM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 7 Aug 2021 11:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1628349762;
        bh=+ibWlmjshFukmm99Ae/6IfMlmJeghf0lz1I7GodPIF4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=V3upPG0zpmXrVMIUtlB6qDb7euM0Wvvvq2zxIdopeYNRNz+hAfgQFF4b2OaMc8b/+
         2miACzn6gsd+knq7euuinesND8UlPU+v6nJALWef81qFzMUf70GFVAyTQlnoKO75DJ
         7qMsDfTW0u1kPmTfsU/m+V67acyr8UNfXdZQTA1Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([79.150.72.99]) by mail.gmx.net
 (mrgmx105 [212.227.17.174]) with ESMTPSA (Nemesis) id
 1MuUnK-1n2ZL131r0-00rZBK; Sat, 07 Aug 2021 17:22:41 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Len Baker <len.baker@gmx.com>, Kees Cook <keescook@chromium.org>,
        linux-hardening@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drivers/iio: Remove all strcpy() uses in favor of strscpy()
Date:   Sat,  7 Aug 2021 17:22:25 +0200
Message-Id: <20210807152225.9403-1-len.baker@gmx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QhAQnspX6TgImJfwDPl3bmuKEG8hAVOgxUykdmVAHPXEfoi31dK
 jQtepaQpA444TPsGpY7ROrSsT8KZPNE+M/GDO8tSbbZIioGGyeSAV/YLMpAsLmjMWtzzahV
 MoKrN6sB37ibQRZ//01GJl7xUskCPNQFG1/A4LloUWsKSQLkRV6fAGkhOQATnM+H5fK+E7g
 l13PsfK7TrBtym87hEjiA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:x4oYf3OT8og=:9cXdk1pj5BFSj5WpjW83zF
 oynIBOgINWzzrmri2VRDxVJaH6gm4BtrM+WJ+cLwzcmRPPgupW2IHSq9yEJqNCWNrIvpgypXH
 Z1/tDeob1nL7RtlFwzW1jL4d7ptJviZCgNOXaF44gyE9Z16J0KnW8wY9h12/z9NlMmR6zuCfp
 Z/X2OIvL9ZMuN85NuOvDsG/US7r0VVr0f3FJkcXCbxyFpSmi1rt91cOJHr6ze4UzYB4alUipI
 2uhpftC8QIanE7QEpOZfCqde3Vw1Rsm4/KoXyBZnDxDcxGAByaSAphYuVir/hmtNZSvXFotbd
 ez2PqBohqH5A7JKBdAVDhu7+lc5626dAsXL3AbG30UfU4hh7DoOfDPChBMRYNhh6IPlDp0LLj
 cqJlMZosmJym1e6h+m6h2PJNoggM2+9dYIiOZ3y1wVOE+tO5/2yVshMqfOYgmbuTlg5UBpxxi
 5MBgfg8RKxGHin9u3xxHRCf8SkgkyxKyrLMso5BDfd7iVBBR8tnZzVQi8pNZA01DFlhPDKcSY
 KSy1VW2brIiWTtjvJdebkp76mXEz/bSpJAofHDYdoS10OrI2W0harLXTtFFYIwWSi1rCCS4vr
 0ZD4Kx4+2xk5U6pRzrYTRzw/6eAs2b91pr8cr/pJVxbpvo852Xr0yhIUbAjVGysvV9DrnVYPE
 Ajt364nzjxxZtCiezfyUPnwR77yimbcFbWAkWuuUTUCs/NO3cUggxqgNdblpeM0T6VtzS7Kxs
 J/Z0VT4nBtx6s9fZvVz1nz2Cxzvla+4Ivr0WH9aVTObjOv0HSS6n3RAwYMS42odaemNwZ9ceA
 Ri09j01BMI2vyG6KC0iyT/xwomhkPfYAyLmC/6JzbQGV760Pq2Xpp9nLbCJzK4fpC6isXB7Va
 N6uO94ooQNNpbYS3TFaTwF1Fi6ZkNLeMzlJAeS4AnMJwH3u/YDMDwDjgEMRqc7JodwMEgn18o
 CF8KuMa+6dy4tKzINR1bMmw3nm4Xe4GKj6Llpi6KrfTXmCB+tkIf4Vh43khODkVcQH27oYRtM
 id2JKxYs1tyYUQ4+0yfzmEoRwUBPpedZeqpYUVRlM22pJ0srDqoicK8qKseLWoKHTocChHuAH
 ybt2KKuLALanx64GaL3qHKdYT+mkqsWQWDh4kPYBhDxlIm9Y8iv/2THxg==
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

strcpy() performs no bounds checking on the destination buffer. This
could result in linear overflows beyond the end of the buffer, leading
to all kinds of misbehaviors. The safe replacement is strscpy().

This patch is an effort to clean up the proliferation of str*()
functions in the kernel and a previous step in the path to remove
the strcpy function from the kernel entirely [1].

[1] https://github.com/KSPP/linux/issues/88

Signed-off-by: Len Baker <len.baker@gmx.com>
=2D--
Changelog v1 -> v2
- Modify the commit changelog to inform that the motivation of this
  patch is to remove the strcpy() function from the kernel entirely
  (Jonathan Cameron).

 drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c b/drivers/iio/imu/=
inv_mpu6050/inv_mpu_magn.c
index f282e9cc34c5..3a6aa1c4bf6c 100644
=2D-- a/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_magn.c
@@ -264,6 +264,7 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state *=
st)
 	const char *orient;
 	char *str;
 	int i;
+	size_t n;

 	/* fill magnetometer orientation */
 	switch (st->chip_type) {
@@ -282,17 +283,18 @@ int inv_mpu_magn_set_orient(struct inv_mpu6050_state=
 *st)
 		for (i =3D 0; i < 3; ++i) {
 			orient =3D st->orientation.rotation[6 + i];
 			/* use length + 2 for adding minus sign if needed */
-			str =3D devm_kzalloc(regmap_get_device(st->map),
-					   strlen(orient) + 2, GFP_KERNEL);
+			n =3D strlen(orient) + 2;
+			str =3D devm_kzalloc(regmap_get_device(st->map), n,
+					   GFP_KERNEL);
 			if (str =3D=3D NULL)
 				return -ENOMEM;
 			if (strcmp(orient, "0") =3D=3D 0) {
-				strcpy(str, orient);
+				strscpy(str, orient, n);
 			} else if (orient[0] =3D=3D '-') {
-				strcpy(str, &orient[1]);
+				strscpy(str, &orient[1], n);
 			} else {
 				str[0] =3D '-';
-				strcpy(&str[1], orient);
+				strscpy(&str[1], orient, n - 1);
 			}
 			st->magn_orient.rotation[6 + i] =3D str;
 		}
=2D-
2.25.1

