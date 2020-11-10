Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B942AD7C9
	for <lists+linux-iio@lfdr.de>; Tue, 10 Nov 2020 14:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730270AbgKJNip (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Nov 2020 08:38:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46422 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730534AbgKJNip (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Nov 2020 08:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605015523;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SVnbTk+hfOm+spQSdQcWNoHZy9N+GiEB8bTrlx+8MxU=;
        b=YyTnMoz+y61PQqZxZ5J0uRbhZ781XHWqL8tth6rl98MFZqD3UQZAXFwSmDGjyMLLwNBYk5
        loDohvZmreQ8gOhmCe9gZaIurXVXKDWlQTk91gx3zvfA+Xt8uDlonjbjgVHpu+fMDZ3d86
        05ef66saPZg170CJ8gowKxryFOkJ24s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-ptFeDXdqPzOOo8du9gMXLQ-1; Tue, 10 Nov 2020 08:38:41 -0500
X-MC-Unique: ptFeDXdqPzOOo8du9gMXLQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 03328803F6A;
        Tue, 10 Nov 2020 13:38:40 +0000 (UTC)
Received: from x1.localdomain (ovpn-113-196.ams2.redhat.com [10.36.113.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 804006115F;
        Tue, 10 Nov 2020 13:38:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "russianneuromancer @ ya . ru" <russianneuromancer@ya.ru>,
        linux-iio@vger.kernel.org
Subject: [PATCH bugfix for 5.10 1/2] iio: accel: kxcjk1013: Replace is_smo8500_device with an acpi_type enum
Date:   Tue, 10 Nov 2020 14:38:34 +0100
Message-Id: <20201110133835.129080-2-hdegoede@redhat.com>
In-Reply-To: <20201110133835.129080-1-hdegoede@redhat.com>
References: <20201110133835.129080-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Replace the boolean is_smo8500_device variable with an acpi_type enum.

For now this can be either ACPI_GENERIC or ACPI_SMO8500, this is a
preparation patch for adding special handling for the KIOX010A ACPI HID,
which will add a ACPI_KIOX010A acpi_type to the introduced enum.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index beb38d9d607d..abeb0d254046 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -126,6 +126,11 @@ enum kx_chipset {
 	KX_MAX_CHIPS /* this must be last */
 };
 
+enum kx_acpi_type {
+	ACPI_GENERIC,
+	ACPI_SMO8500,
+};
+
 struct kxcjk1013_data {
 	struct i2c_client *client;
 	struct iio_trigger *dready_trig;
@@ -143,7 +148,7 @@ struct kxcjk1013_data {
 	bool motion_trigger_on;
 	int64_t timestamp;
 	enum kx_chipset chipset;
-	bool is_smo8500_device;
+	enum kx_acpi_type acpi_type;
 };
 
 enum kxcjk1013_axis {
@@ -1247,7 +1252,7 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 
 static const char *kxcjk1013_match_acpi_device(struct device *dev,
 					       enum kx_chipset *chipset,
-					       bool *is_smo8500_device)
+					       enum kx_acpi_type *acpi_type)
 {
 	const struct acpi_device_id *id;
 
@@ -1256,7 +1261,7 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 		return NULL;
 
 	if (strcmp(id->id, "SMO8500") == 0)
-		*is_smo8500_device = true;
+		*acpi_type = ACPI_SMO8500;
 
 	*chipset = (enum kx_chipset)id->driver_data;
 
@@ -1299,7 +1304,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	} else if (ACPI_HANDLE(&client->dev)) {
 		name = kxcjk1013_match_acpi_device(&client->dev,
 						   &data->chipset,
-						   &data->is_smo8500_device);
+						   &data->acpi_type);
 	} else
 		return -ENODEV;
 
@@ -1316,7 +1321,7 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = &kxcjk1013_info;
 
-	if (client->irq > 0 && !data->is_smo8500_device) {
+	if (client->irq > 0 && data->acpi_type != ACPI_SMO8500) {
 		ret = devm_request_threaded_irq(&client->dev, client->irq,
 						kxcjk1013_data_rdy_trig_poll,
 						kxcjk1013_event_handler,
-- 
2.28.0

