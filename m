Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86AAA3125E0
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:10:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBGQKl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:10:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229565AbhBGQKk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 11:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612714153;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MBboiUZbc91zVzy6Nb09GeB6C3V6W4cRZI7KJVW1XK8=;
        b=dTyZAkNcAXswklo3fCxBKcCuxLv6t6+wE0DrNqLor34hmyJh9jHZYt0HOZ1CjO7QOtUKo+
        xPZuF1x4jo56eYwD7bmdz6mg4cC1olp/2FvFqx5oVp+8TtcB+re4Cpx4QnxaNXC7glI1Xu
        ZOz4yhwt3713GXp0FK9HjNS51mIMTqs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-B7rm4nzfPyu1byIDcDAB5g-1; Sun, 07 Feb 2021 11:09:11 -0500
X-MC-Unique: B7rm4nzfPyu1byIDcDAB5g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9E88310066F1;
        Sun,  7 Feb 2021 16:09:10 +0000 (UTC)
Received: from x1.localdomain (ovpn-112-86.ams2.redhat.com [10.36.112.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 405481346F;
        Sun,  7 Feb 2021 16:09:07 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
Subject: [PATCH 3/3] iio: accel: kxcjk-1013: Set label based on accel-location on 2-accel yoga-style 2-in-1s
Date:   Sun,  7 Feb 2021 17:09:01 +0100
Message-Id: <20210207160901.110643-4-hdegoede@redhat.com>
In-Reply-To: <20210207160901.110643-1-hdegoede@redhat.com>
References: <20210207160901.110643-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some 2-in-1 laptops / convertibles with 360° (yoga-style) hinges,
use 2 KXCJ91008 accelerometers:
1 in their display using an ACPI HID of "KIOX010A"; and
1 in their base    using an ACPI HID of "KIOX020A"

Since in this case we know the location of each accelerometer,
set the label for the accelerometers to the standardized
"accel-display" resp. "accel-base" labels. This way userspace
can use the labels to get the location.

This was tested on a Medion Akoya E2228T MD60250.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/kxcjk-1013.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 849eb79fc537..1e7ca666c77a 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -1331,7 +1331,8 @@ static irqreturn_t kxcjk1013_data_rdy_trig_poll(int irq, void *private)
 
 static const char *kxcjk1013_match_acpi_device(struct device *dev,
 					       enum kx_chipset *chipset,
-					       enum kx_acpi_type *acpi_type)
+					       enum kx_acpi_type *acpi_type,
+					       const char **label)
 {
 	const struct acpi_device_id *id;
 
@@ -1339,10 +1340,14 @@ static const char *kxcjk1013_match_acpi_device(struct device *dev,
 	if (!id)
 		return NULL;
 
-	if (strcmp(id->id, "SMO8500") == 0)
+	if (strcmp(id->id, "SMO8500") == 0) {
 		*acpi_type = ACPI_SMO8500;
-	else if (strcmp(id->id, "KIOX010A") == 0)
+	} else if (strcmp(id->id, "KIOX010A") == 0) {
 		*acpi_type = ACPI_KIOX010A;
+		*label = "accel-display";
+	} else if (strcmp(id->id, "KIOX020A") == 0) {
+		*label = "accel-base";
+	}
 
 	*chipset = (enum kx_chipset)id->driver_data;
 
@@ -1385,7 +1390,8 @@ static int kxcjk1013_probe(struct i2c_client *client,
 	} else if (ACPI_HANDLE(&client->dev)) {
 		name = kxcjk1013_match_acpi_device(&client->dev,
 						   &data->chipset,
-						   &data->acpi_type);
+						   &data->acpi_type,
+						   &indio_dev->label);
 	} else
 		return -ENODEV;
 
-- 
2.30.0

