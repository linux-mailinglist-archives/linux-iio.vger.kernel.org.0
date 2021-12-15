Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D553E475B98
	for <lists+linux-iio@lfdr.de>; Wed, 15 Dec 2021 16:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243834AbhLOPNv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 15 Dec 2021 10:13:51 -0500
Received: from relay12.mail.gandi.net ([217.70.178.232]:42523 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243824AbhLOPNu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 15 Dec 2021 10:13:50 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 60D1A200004;
        Wed, 15 Dec 2021 15:13:49 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 05/10] iio: st_sensors: Use iio_device_claim/release_direct_mode() when relevant
Date:   Wed, 15 Dec 2021 16:13:39 +0100
Message-Id: <20211215151344.163036-6-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211215151344.163036-1-miquel.raynal@bootlin.com>
References: <20211215151344.163036-1-miquel.raynal@bootlin.com>
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

Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 .../iio/common/st_sensors/st_sensors_core.c   | 28 +++++++++----------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 1de395bda03e..e57e85c06f4b 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -549,26 +549,24 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
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
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
-		err = st_sensors_read_axis_data(indio_dev, ch, val);
-		if (err < 0)
-			goto out;
+	msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+	err = st_sensors_read_axis_data(indio_dev, ch, val);
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

