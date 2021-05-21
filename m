Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4295F38CBB9
	for <lists+linux-iio@lfdr.de>; Fri, 21 May 2021 19:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhEURQG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 May 2021 13:16:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29888 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238078AbhEURQF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 May 2021 13:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621617282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0EumFKksjDikSz13aw1z4DlMrdgBtjs5Kx9HhT7YtI0=;
        b=Gh2OqwR1O8/GEQTPM/uXzdi+3KAz7Jbis+hTB+fTzS6wP3U00HWJMV7USXAPoRGXWdmiDj
        7S8M5N/zkDbKmDvSCmjAPwPx1FHV0J8rIVDqXFYLEZL5Oov750Z6Q6kqNqT3fPhpVWqjov
        DkQAT3VQHkdGpeqZrGaOKeHM0j15fIs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-yd4dNnUpPHisDRHoviwtOw-1; Fri, 21 May 2021 13:14:40 -0400
X-MC-Unique: yd4dNnUpPHisDRHoviwtOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 744BE8015F8;
        Fri, 21 May 2021 17:14:39 +0000 (UTC)
Received: from x1.localdomain (ovpn-114-187.ams2.redhat.com [10.36.114.187])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 808FF10013D6;
        Fri, 21 May 2021 17:14:37 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>, linux-iio@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org
Subject: [PATCH 8/8] iio: accel: bmc150: Set label based on accel-location for ACPI DUAL250E fwnodes
Date:   Fri, 21 May 2021 19:14:18 +0200
Message-Id: <20210521171418.393871-9-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-1-hdegoede@redhat.com>
References: <20210521171418.393871-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Some Yoga laptops with 1 accelerometer in the display and 1 in the base,
use an ACPI HID of DUAL250E instead of BOSC0200.

Set the iio-device's label for DUAL250E devices to a value indicating which
sensor is which, mirroring how we do this for BOSC0200 dual sensor devices.

Note the DUAL250E fwnode unfortunately does not include a mount-matrix.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 932007895f18..08966ee82e43 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -397,6 +397,17 @@ static bool bmc150_apply_acpi_orientation(struct device *dev,
 	acpi_status status;
 	int i, j, val[3];
 
+	/* Special case for devices with a "DUAL250E" HID */
+	if (adev && acpi_dev_hid_uid_match(adev, "DUAL250E", NULL)) {
+		if (strcmp(dev_name(dev), "i2c-DUAL250E:base") == 0)
+			label = "accel-base";
+		else
+			label = "accel-display";
+
+		indio_dev->label = label;
+		return false; /* DUAL250E fwnodes have no mount matrix info */
+	}
+
 	if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
 		return false;
 
-- 
2.31.1

