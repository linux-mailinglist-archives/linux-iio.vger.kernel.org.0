Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD354A728F
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 15:02:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343678AbiBBOCS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 09:02:18 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:52309 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiBBOCR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 09:02:17 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 46F8820000E;
        Wed,  2 Feb 2022 14:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1643810537;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xjNnM5ZQRbSwPYJsttNpBGWE+RopWUU+rbrZfO0abDk=;
        b=a4zzFL0AcZDGBoyVVZ7K1R20gt5+Kd0SqzVrfrup9bJ/NTkWiRpACbugjprIi7EcLuYYXD
        IBV3KO3QPJezxPX1Hhdv+pWFmh56oO8+4vdXrTfkm6flZgDmF7pUfCMubpCK6LRMqI10kr
        ZpgPoGY+IgDfEuQICKb//NMYB5Qffo0ImAN2njQvGXhHNV1A6fG0SoO3Ysv+CI0F/UkUH1
        +wfugylXfqjRo1XC5ey0V0VOI1GpPrBzbVGzYKt864Q7VVozi7Reu5gNRsGPvFe6yujuga
        VFREVTtQLSViPjO/oybGotGny6pD+LtS1ODFzmdQwwNHr8GnTw1VZ+4TD2LVag==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v2 07/12] iio: st_sensors: Use iio_device_claim/release_direct_mode() when relevant
Date:   Wed,  2 Feb 2022 15:02:03 +0100
Message-Id: <20220202140208.391394-8-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220202140208.391394-1-miquel.raynal@bootlin.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

The st_sensors_core driver hardcodes the content of the
iio_device_claim_direct_mode() and iio_device_release_direct_mode()
helpers. Let's get rid of this handcrafted implementation and use the
proper core helpers instead. Additionally, this lowers the tab level
(which is always good) and prevents the use of the ->currentmode
variable which is not supposed to be used like this anyway.

Cc: Denis Ciocca <denis.ciocca@st.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 32 +++++++++----------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index d0419234a747..e61622e3bc85 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -559,28 +559,26 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		err = -EBUSY;
+	err = iio_device_claim_direct_mode(indio_dev);
+	if (err)
+		return err;
+
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
 		goto out;
-	} else {
-		err = st_sensors_set_enable(indio_dev, true);
-		if (err < 0)
-			goto out;
 
-		mutex_lock(&sdata->odr_lock);
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
-		err = st_sensors_read_axis_data(indio_dev, ch, val);
-		mutex_unlock(&sdata->odr_lock);
-		if (err < 0)
-			goto out;
+	mutex_lock(&sdata->odr_lock);
+	msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+	err = st_sensors_read_axis_data(indio_dev, ch, val);
+	mutex_unlock(&sdata->odr_lock);
+	if (err < 0)
+		goto out;
 
-		*val = *val >> ch->scan_type.shift;
+	*val = *val >> ch->scan_type.shift;
 
-		err = st_sensors_set_enable(indio_dev, false);
-	}
+	err = st_sensors_set_enable(indio_dev, false);
 out:
-	mutex_unlock(&indio_dev->mlock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return err;
 }
-- 
2.27.0

