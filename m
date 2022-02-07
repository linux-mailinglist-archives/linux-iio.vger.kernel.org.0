Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9976F4AC21B
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358588AbiBGO5E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343882AbiBGOi5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:57 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D9AC0401C4
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 82015100005;
        Mon,  7 Feb 2022 14:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S3Fim5e1TMGrcrMsknZCFLL1Or54y7GgfgrzQGmJ2J0=;
        b=dNdeWyJjBC9TKW6HF8nrCv1Ajb2DHvcWKzMcsPAI5bV/KO5Fgg57JHO/pmEmVDJyvYD24w
        itfY7wKz9aI4LHKGV9L00MTlmClAOs2NRZyg7Yy7CgssH6Z0NQmT+Az/oC21pvX8dMjFeF
        w5dpYWSE3fmpC1odkkQ8CfUCehnv4xDChbiavGnBHi4o/50el00i7usibILFlLYKrHudp9
        9VRA0PhmOGlekCkMdhnJrqp36zTvFzVAA6SyemNHuvyOukpzSyJ/VE2vAsrt3covSp5Xex
        RblZuL7b6JUd/3sQt58tw59QIgSmbGMnSzNa6iEEvy/6A9GkD8I7v4zZn3d48Q==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH v3 08/13] iio: st_sensors: Use iio_device_claim/release_direct_mode() when relevant
Date:   Mon,  7 Feb 2022 15:38:35 +0100
Message-Id: <20220207143840.707510-9-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220207143840.707510-1-miquel.raynal@bootlin.com>
References: <20220207143840.707510-1-miquel.raynal@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 .../iio/common/st_sensors/st_sensors_core.c   | 38 +++++++++----------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 665584e8bea4..543a7d88e317 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -555,32 +555,28 @@ int st_sensors_read_info_raw(struct iio_dev *indio_dev,
 	int err;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 
-	mutex_lock(&indio_dev->mlock);
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED) {
-		err = -EBUSY;
+	err = iio_device_claim_direct_mode(indio_dev);
+	if (err)
+		return err;
+
+	mutex_lock(&sdata->odr_lock);
+
+	err = st_sensors_set_enable(indio_dev, true);
+	if (err < 0)
+		goto out;
+
+	msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
+	err = st_sensors_read_axis_data(indio_dev, ch, val);
+	if (err < 0)
 		goto out;
-	} else {
-		mutex_lock(&sdata->odr_lock);
-		err = st_sensors_set_enable(indio_dev, true);
-		if (err < 0) {
-			mutex_unlock(&sdata->odr_lock);
-			goto out;
-		}
 
-		msleep((sdata->sensor_settings->bootime * 1000) / sdata->odr);
-		err = st_sensors_read_axis_data(indio_dev, ch, val);
-		if (err < 0) {
-			mutex_unlock(&sdata->odr_lock);
-			goto out;
-		}
+	*val = *val >> ch->scan_type.shift;
 
-		*val = *val >> ch->scan_type.shift;
+	err = st_sensors_set_enable(indio_dev, false);
 
-		err = st_sensors_set_enable(indio_dev, false);
-		mutex_unlock(&sdata->odr_lock);
-	}
 out:
-	mutex_unlock(&indio_dev->mlock);
+	mutex_unlock(&sdata->odr_lock);
+	iio_device_release_direct_mode(indio_dev);
 
 	return err;
 }
-- 
2.27.0

