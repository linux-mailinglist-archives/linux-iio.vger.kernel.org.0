Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E5A1BA94A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 17:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbgD0PvV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 11:51:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45059 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728478AbgD0Pu6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 11:50:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588002657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uVbZSaI2POy6fJtwh+hojPBmfthgWVtJ9egPhBMBtdg=;
        b=XU+4Fl7igzUvxGqMh1DmrmGFPwKC6MZaOwkRawctoNIldxIqveI6IZVLdHluksa28WLTXm
        zH7BJNU91q0VfxhCY2s2F7kgQeTP5++tWz309pY2kwv9+jmABgLOJGfXPFnItTIwvbLbCG
        uOYza9IYj0p23XIBlHlK/rFkzu1I/Cw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-F3ejC_FSN4yQldq6iUzilg-1; Mon, 27 Apr 2020 11:50:52 -0400
X-MC-Unique: F3ejC_FSN4yQldq6iUzilg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5538C835B40;
        Mon, 27 Apr 2020 15:50:50 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-38.ams2.redhat.com [10.36.114.38])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C704660BEC;
        Mon, 27 Apr 2020 15:50:47 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v2 4/8] iio: light: cm32181: Change reg_init to use a bitmap of which registers to init
Date:   Mon, 27 Apr 2020 17:50:33 +0200
Message-Id: <20200427155037.218390-4-hdegoede@redhat.com>
In-Reply-To: <20200427155037.218390-1-hdegoede@redhat.com>
References: <20200427155037.218390-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a preparation patch for reading some ACPI tables which give
init values for multiple registers.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Use unsigned long for init_regs_bitmap
- Use for_each_set_bit()
---
 drivers/iio/light/cm32181.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 4c26a4a8a070..194aa5a0ad08 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -26,7 +26,7 @@
 #define CM32181_REG_ADDR_ID		0x07
=20
 /* Number of Configurable Registers */
-#define CM32181_CONF_REG_NUM		0x01
+#define CM32181_CONF_REG_NUM		4
=20
 /* CMD register */
 #define CM32181_CMD_ALS_DISABLE		BIT(0)
@@ -53,10 +53,6 @@
=20
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
=20
-static const u8 cm32181_reg[CM32181_CONF_REG_NUM] =3D {
-	CM32181_REG_ADDR_CMD,
-};
-
 /* CM3218 Family */
 static const int cm3218_als_it_bits[] =3D { 0, 1, 2, 3 };
 static const int cm3218_als_it_values[] =3D { 100000, 200000, 400000, 80=
0000 };
@@ -71,6 +67,7 @@ struct cm32181_chip {
 	struct i2c_client *client;
 	struct mutex lock;
 	u16 conf_regs[CM32181_CONF_REG_NUM];
+	unsigned long init_regs_bitmap;
 	int calibscale;
 	int num_als_it;
 	const int *als_it_bits;
@@ -117,12 +114,13 @@ static int cm32181_reg_init(struct cm32181_chip *cm=
32181)
 	/* Default Values */
 	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D
 			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
+	cm32181->init_regs_bitmap =3D BIT(CM32181_REG_ADDR_CMD);
 	cm32181->calibscale =3D CM32181_CALIBSCALE_DEFAULT;
=20
 	/* Initialize registers*/
-	for (i =3D 0; i < CM32181_CONF_REG_NUM; i++) {
-		ret =3D i2c_smbus_write_word_data(client, cm32181_reg[i],
-			cm32181->conf_regs[i]);
+	for_each_set_bit(i, &cm32181->init_regs_bitmap, CM32181_CONF_REG_NUM) {
+		ret =3D i2c_smbus_write_word_data(client, i,
+						cm32181->conf_regs[i]);
 		if (ret < 0)
 			return ret;
 	}
--=20
2.26.0

