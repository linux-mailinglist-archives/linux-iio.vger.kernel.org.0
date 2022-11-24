Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA66381C8
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 00:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKXXjW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 24 Nov 2022 18:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiKXXjV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 24 Nov 2022 18:39:21 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F928114
        for <linux-iio@vger.kernel.org>; Thu, 24 Nov 2022 15:39:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net; s=s31663417;
        t=1669333151; bh=+8OOqYEUTsfi8H6g215fSm9TUlssi2B+nqbTWLIQ4As=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h+a+sshScMqdvnQJIjJLjHzclCdMPrusNIthVENPKDiMbmCVZLG93Qn0PMuTlzgF0
         2O8pEP4Q7fKL3/pgbendoxEJG9qsB1hKC6CO3jd52mrsanB+ZrGd1SuURoV7QZO9QL
         6bCGhyAp5MVioRmnFKViHezmCbnt4n8hDar+U4y4NsQeRz5XZy5q1ljtqZNTfOGvyL
         tWY2Me2x32ok1lgCLlR5m3eapRctnEP6DwZddbT2AVwTmu5PWLeFP299/ZuG+ycPpb
         QDqb7RBGxs0YM2HYV29shEASs1Cnqi7cEnDwx5KPVq0/hng6/I9FugWF/nY8GisxCc
         u8sJ45K07m8/Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([95.223.45.67]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MacOQ-1oS3C11pFa-00c6e5; Fri, 25 Nov 2022 00:39:11 +0100
From:   Philipp Jungkamp <p.jungkamp@gmx.net>
To:     Jiri Kosina <jikos@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Philipp Jungkamp <p.jungkamp@gmx.net>
Subject: [PATCH v4 2/4] HID: hid-sensor-custom: Add LISS custom sensors
Date:   Fri, 25 Nov 2022 00:38:39 +0100
Message-Id: <20221124233841.3103-3-p.jungkamp@gmx.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221124233841.3103-1-p.jungkamp@gmx.net>
References: <20221124233841.3103-1-p.jungkamp@gmx.net>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YZqrFCYAp0YlLltYKPVCXgace1TkEdx1kP6ZZw2DdmFQMyrGsb0
 5gR2B1YCs28lenrFq/T7n8cEHi2GcoFvoNPl3dkS0fRKFrxQ9GQskv/lvX1tcVJv3xAoaHy
 2tYLEhVwJdLHt4xGcSfj6vRGWVeiBELhxCTVcba3nnQUULmtJ1i84v67+H+ItrjSHl64QxT
 yId2h1hdNN9QJ1Abjn8lw==
UI-OutboundReport: notjunk:1;M01:P0:bb9et17/9HM=;+Vov9dJBSznBgmMh/l+ePkFO+Me
 J+jRz/Z5JUuiHddSHiheS7WEdGd+RL7Vo4farfrYLidHB4PHwU6R/lxtzyLELBE4YYDdYkWdk
 UsCu2gjsYek/Q7XO0xhP1tICp/s5j7x6K/ZffsFTc0JSoA51piId8IyYgCRb4d3w2PgcCKZ9k
 XzJMaGV00Sy7WVFAcPZQr78Fb9tMg+XAFN2R2+bPOsE4DrQYqEY0P9+tMVxvW2gyNyTBurU11
 MDHVFO7LpXwjWrpoQNrv41vFUqFNkKcPfiPsSEcmjaDSsNPML4yu3oGoEnyF6eUX7AYSyqr3e
 DZECzz1L3TXZIq0Pn7pACbTWDibr1LKELTI7MM/L+okH9B222NviYTSrDtSMd0AKb8+KPUIqb
 r4L1AaR2MZT6X/MiWYxNw/UDqCHSZ1BIItdsmdJzRlZo6ie2PBxnlomDOM5xDK5Gkn7YLerbV
 CmA9D72VCmo6Hr+4Kj3eFlwEVmkciFzdfWhGK2aZDVRDXUXp5NZVDQxiN0gIQDEW7AgW3++ap
 wUi+IvWgD5l2zhZyjxakfSHPeN8EmLDgl8syOM4SIdjqSTIP9x6SowjqYYMl4QnrUjIWrShY4
 tsu96Usnxmse7T6e8RToQdyulKQPryOPykVUfLTFM9/HT9EKCg0gXodm/RX1i+nqfLzMfOIAc
 1idrCFd0lx5DcHYGVjZDh2mnkhFmq4tHNKhnazT3KUy6VmEJvos0jufKTdUkpl0wR3k1tx0Tb
 oXD+qK0312RprmEFCFhI3r7O9/+RzXKGSzI3flbusVs0OW4PyB8Qr4SBeZ7J7YAeI/TlpfXYC
 zPs0mLhldZVEjCbHdusC8EtkZMqnsE6t8G/DOAIySX6+jYTM9ZI3ls3v8V+Su4zLZGSj3/rjS
 3RZYvV0NtGqVDlS+P42bk6O7O4rXa1catUmDxvCiImz+noMjfjIxlCA1ocOu77DoMaUz9480P
 bcKz0FbpjUJtSy+bW79rJB2qBSw=
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add the Lenovo Intelligent Sensing Solution (LISS) custom sensors to the
known custom sensors.

Signed-off-by: Philipp Jungkamp <p.jungkamp@gmx.net>
=2D--

v2:
- Create this 'noop' patch that just adds the LISS sensors to the custom
  sensor match table.

v3:
- Add missing 'Signed-Off-By'

v4:
- No change.

 drivers/hid/hid-sensor-custom.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-cust=
om.c
index 734c6bde68fe..7c6e2e795753 100644
=2D-- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -782,6 +782,29 @@ static const struct hid_sensor_custom_match hid_senso=
r_custom_known_table[] =3D {
 		.luid =3D "020B000000000000",
 		.manufacturer =3D "INTEL",
 	},
+	/*
+	 * Lenovo Intelligent Sensing Solution (LISS)
+	 */
+	{	/* ambient light */
+		.tag =3D "LISS",
+		.luid =3D "0041010200000082",
+		.model =3D "STK3X3X Sensor",
+		.manufacturer =3D "Vendor 258",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
+	{	/* human presence */
+		.tag =3D "LISS",
+		.luid =3D "0226000171AC0081",
+		.model =3D "VL53L1_HOD Sensor",
+		.manufacturer =3D "ST_MICRO",
+		.check_dmi =3D true,
+		.dmi.matches =3D {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+		}
+	},
 	{}
 };

=2D-
2.38.1

