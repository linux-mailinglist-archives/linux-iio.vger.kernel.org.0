Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD4A38DC01
	for <lists+linux-iio@lfdr.de>; Sun, 23 May 2021 19:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhEWRCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 23 May 2021 13:02:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46546 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231883AbhEWRCp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 23 May 2021 13:02:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621789278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVGXMjLiC7xJMKkO+bCUodvmQ8D5BHN26j1IUBeIueA=;
        b=Kl5ERS+JUsD5N4w8nNeTXvAkeP2DRQRDtsClq63pp6fskbHbN6tn6jwqwYK0oeimwTXhMW
        wzHoNp3Nd+7lhMs55nWYKMDeAccGhyedHXf3V2xjEvctqQELcRCL4QEzzWCCnGFfj1W/Df
        Ghk7Pe2qFsfstUs4TTMW5SzM/eaf0Oo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-355-4a-1x-ySOhqf8XAuHbUdbw-1; Sun, 23 May 2021 13:01:15 -0400
X-MC-Unique: 4a-1x-ySOhqf8XAuHbUdbw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5E1A800FF0;
        Sun, 23 May 2021 17:01:13 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-61.ams2.redhat.com [10.36.112.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A44F25D9F2;
        Sun, 23 May 2021 17:01:12 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy@infradead.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org
Subject: [PATCH v2 4/9] iio: accel: bmc150: Add support for dual-accelerometers with a DUAL250E HID
Date:   Sun, 23 May 2021 19:00:58 +0200
Message-Id: <20210523170103.176958-5-hdegoede@redhat.com>
In-Reply-To: <20210523170103.176958-1-hdegoede@redhat.com>
References: <20210523170103.176958-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The Lenovo Yoga 300-11IBR has a ACPI fwnode with a HID of DUAL250E
which contains I2C and IRQ resources for 2 accelerometers, 1 in the
display and one in the base of the device. Add support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
- Rewrap some comments at 80 chars limit
- Use acpi_dev_gpio_irq_get() instead of acpi_dev_gpio_irq_get_by()
---
 drivers/iio/accel/bmc150-accel-i2c.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel/bmc150-accel-i2c.c
index f7cb40f481ef..41b4c9e22d60 100644
--- a/drivers/iio/accel/bmc150-accel-i2c.c
+++ b/drivers/iio/accel/bmc150-accel-i2c.c
@@ -24,6 +24,7 @@
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
 	{"BOSC0200"},
+	{"DUAL250E"},
 	{ }
 };
 
@@ -36,21 +37,24 @@ static void bmc150_acpi_dual_accel_probe(struct i2c_client *client)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&client->dev);
 	struct i2c_client *second_dev;
+	char dev_name[16];
 	struct i2c_board_info board_info = {
 		.type = "bmc150_accel",
-		/*
-		 * The 2nd accel sits in the base of 2-in-1s. Note this name is
-		 * static, as there should never be more then 1 BOSC0200 ACPI
-		 * node with 2 accelerometers in it.
-		 */
-		.dev_name = "BOSC0200:base",
+		.dev_name = dev_name,
 		.fwnode = client->dev.fwnode,
-		.irq = -ENOENT,
 	};
 
 	if (acpi_match_device_ids(adev, bmc150_acpi_dual_accel_ids))
 		return;
 
+	/*
+	 * The 2nd accel sits in the base of 2-in-1s. The suffix is static, as
+	 * there should never be more then 1 ACPI node with 2 accelerometers.
+	 */
+	snprintf(dev_name, sizeof(dev_name), "%s:base", acpi_device_hid(adev));
+
+	board_info.irq = acpi_dev_gpio_irq_get(adev, 1);
+
 	second_dev = i2c_acpi_new_device(&client->dev, 1, &board_info);
 	if (!IS_ERR(second_dev))
 		bmc150_set_second_device(client, second_dev);
@@ -118,6 +122,7 @@ static const struct acpi_device_id bmc150_accel_acpi_match[] = {
 	{"BMA222E",	bma222e},
 	{"BMA0280",	bma280},
 	{"BOSC0200"},
+	{"DUAL250E"},
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, bmc150_accel_acpi_match);
-- 
2.31.1

