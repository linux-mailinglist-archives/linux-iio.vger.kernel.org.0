Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A8351BC6BF
	for <lists+linux-iio@lfdr.de>; Tue, 28 Apr 2020 19:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgD1R36 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Apr 2020 13:29:58 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33477 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728577AbgD1R35 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Apr 2020 13:29:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588094996;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MokJhYQfZkwA5aWDgmtqE721QUM4Xa11rqTt+C4uNts=;
        b=YVdhlQ67KvCdYjUsRkqGXrifY6KtijyDR0RFVxeox0e88NvBrnY0J0nZlzKQZ+WRybIEo/
        FHVutQKo4rC2TfCrO5DKL1N8pC0WPPPnvvVVAoP+XuRYyWySZQvCzJX0PG8bUpDi6vR30w
        ZFEGuZGLAk4cO0jxUAgjH9OoR4i6hqU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-xCRCshAXMMK8ETyuxZ_Xbw-1; Tue, 28 Apr 2020 13:29:54 -0400
X-MC-Unique: xCRCshAXMMK8ETyuxZ_Xbw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F17F805725;
        Tue, 28 Apr 2020 17:29:52 +0000 (UTC)
Received: from x1.localdomain.com (ovpn-114-62.ams2.redhat.com [10.36.114.62])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F6B25C220;
        Tue, 28 Apr 2020 17:29:48 +0000 (UTC)
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
Subject: [PATCH v3 08/11] iio: light: cm32181: Use units of 1/100000th for calibscale and lux_per_bit
Date:   Tue, 28 Apr 2020 19:29:20 +0200
Message-Id: <20200428172923.567806-8-hdegoede@redhat.com>
In-Reply-To: <20200428172923.567806-1-hdegoede@redhat.com>
References: <20200428172923.567806-1-hdegoede@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Use units of 1/100000th for calibscale and lux_per_bit. The similar
cm3232 driver already uses 1/100000th as unit for calibscale.

This allows for higher-accuracy and makes it easier to add support
for getting device-specific calibscale and lux_per_bit values from
a device's ACPI tables, as the values in the ACPI tables also use
1/100000th units.

This units change means that our intermediate values in cm32181_get_lux()
may get quite big, change the type of the lux variable to a u64 to
deal with this.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/light/cm32181.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index bcea669d20cb..1ad7d4582d1c 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -45,11 +45,11 @@
 #define CM32181_CMD_ALS_SM_MASK		(0x03 << CM32181_CMD_ALS_SM_SHIFT)
 #define CM32181_CMD_ALS_SM_DEFAULT	(0x01 << CM32181_CMD_ALS_SM_SHIFT)
=20
-#define CM32181_MLUX_PER_BIT		5	/* ALS_SM=3D01 IT=3D800ms */
-#define CM32181_MLUX_PER_BIT_BASE_IT	800000	/* Based on IT=3D800ms */
-#define	CM32181_CALIBSCALE_DEFAULT	1000
-#define CM32181_CALIBSCALE_RESOLUTION	1000
-#define MLUX_PER_LUX			1000
+#define CM32181_LUX_PER_BIT		500	/* ALS_SM=3D01 IT=3D800ms */
+#define CM32181_LUX_PER_BIT_RESOLUTION	100000
+#define CM32181_LUX_PER_BIT_BASE_IT	800000	/* Based on IT=3D800ms */
+#define CM32181_CALIBSCALE_DEFAULT	100000
+#define CM32181_CALIBSCALE_RESOLUTION	100000
=20
 #define SMBUS_ALERT_RESPONSE_ADDRESS	0x0c
=20
@@ -204,15 +204,15 @@ static int cm32181_get_lux(struct cm32181_chip *cm3=
2181)
 	struct i2c_client *client =3D cm32181->client;
 	int ret;
 	int als_it;
-	unsigned long lux;
+	u64 lux;
=20
 	ret =3D cm32181_read_als_it(cm32181, &als_it);
 	if (ret < 0)
 		return -EINVAL;
=20
-	lux =3D CM32181_MLUX_PER_BIT;
-	lux *=3D CM32181_MLUX_PER_BIT_BASE_IT;
-	lux /=3D als_it;
+	lux =3D CM32181_LUX_PER_BIT;
+	lux *=3D CM32181_LUX_PER_BIT_BASE_IT;
+	lux =3D div_u64(lux, als_it);
=20
 	ret =3D i2c_smbus_read_word_data(client, CM32181_REG_ADDR_ALS);
 	if (ret < 0)
@@ -220,8 +220,8 @@ static int cm32181_get_lux(struct cm32181_chip *cm321=
81)
=20
 	lux *=3D ret;
 	lux *=3D cm32181->calibscale;
-	lux /=3D CM32181_CALIBSCALE_RESOLUTION;
-	lux /=3D MLUX_PER_LUX;
+	lux =3D div_u64(lux, CM32181_CALIBSCALE_RESOLUTION);
+	lux =3D div_u64(lux, CM32181_LUX_PER_BIT_RESOLUTION);
=20
 	if (lux > 0xFFFF)
 		lux =3D 0xFFFF;
--=20
2.26.0

