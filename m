Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBCD1B8F4F
	for <lists+linux-iio@lfdr.de>; Sun, 26 Apr 2020 13:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgDZLDx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Apr 2020 07:03:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36435 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgDZLDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2020 07:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587898995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zci4D4v3HlWIjmVig8Pa2ZNuZ0x19ofFsfo6QhGjtJI=;
        b=CPspTjSMM94thyh8PdPrA6vA2OkBqtlxSAP8gq0Rx6j1z4ArYfDDsMFgdqi2iTESm7m2U2
        7BCU/WU5NM0Nkzzq8ITEwzcaSMzb6M9es9/+ZaV0Emi1WEi/Tk5qPPCD4K/zOT5ni4Xdo3
        HIMEeQRl22aUYnTFOnbt/8q3yIqdvb4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-390-19y_YxCiMzKI0YntwX-mkQ-1; Sun, 26 Apr 2020 07:03:13 -0400
X-MC-Unique: 19y_YxCiMzKI0YntwX-mkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 50C9B8015CB;
        Sun, 26 Apr 2020 11:03:11 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-112-32.ams2.redhat.com [10.36.112.32])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC35510013A1;
        Sun, 26 Apr 2020 11:03:08 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Kevin Tsai <ktsai@capellamicro.com>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 4/8] iio: light: cm32181: Change reg_init to use a bitmap of which registers to init
Date:   Sun, 26 Apr 2020 13:02:52 +0200
Message-Id: <20200426110256.218186-4-hdegoede@redhat.com>
In-Reply-To: <20200426110256.218186-1-hdegoede@redhat.com>
References: <20200426110256.218186-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

This is a preparation patch for reading some ACPI tables which give
init values for multiple registers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index e8be20d3902c..e31c1005b03d 100644
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
+	int init_regs_bitmap;
 	int calibscale;
 	int num_als_it;
 	const int *als_it_bits;
@@ -117,14 +114,17 @@ static int cm32181_reg_init(struct cm32181_chip *cm=
32181)
 	/* Default Values */
 	cm32181->conf_regs[CM32181_REG_ADDR_CMD] =3D
 			CM32181_CMD_ALS_IT_DEFAULT | CM32181_CMD_ALS_SM_DEFAULT;
+	cm32181->init_regs_bitmap =3D BIT(CM32181_REG_ADDR_CMD);
 	cm32181->calibscale =3D CM32181_CALIBSCALE_DEFAULT;
=20
 	/* Initialize registers*/
 	for (i =3D 0; i < CM32181_CONF_REG_NUM; i++) {
-		ret =3D i2c_smbus_write_word_data(client, cm32181_reg[i],
-			cm32181->conf_regs[i]);
-		if (ret < 0)
-			return ret;
+		if (cm32181->init_regs_bitmap & BIT(i)) {
+			ret =3D i2c_smbus_write_word_data(client, i,
+							cm32181->conf_regs[i]);
+			if (ret < 0)
+				return ret;
+		}
 	}
=20
 	return 0;
--=20
2.26.0

