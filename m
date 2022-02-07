Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3484AC222
	for <lists+linux-iio@lfdr.de>; Mon,  7 Feb 2022 15:58:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358775AbiBGO5G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 7 Feb 2022 09:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343996AbiBGOi5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 7 Feb 2022 09:38:57 -0500
Received: from relay11.mail.gandi.net (relay11.mail.gandi.net [IPv6:2001:4b98:dc4:8::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CF7C0401C7
        for <linux-iio@vger.kernel.org>; Mon,  7 Feb 2022 06:38:53 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 5734A100008;
        Mon,  7 Feb 2022 14:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1644244732;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W0mqKMVbNyVGieN5RcjNyDrMxC5upQJnBV58qIvJzSA=;
        b=pH7hUMMg/olz75H1aeecgbttcbvpGBrWDc899tvJxDHz99IOyZiJkt1XHT3Y/QPIfziZxj
        /jPWyQx4Bi0NnkxPl/H3lUefJK3ACLpRWb7ASeN2UJKiWCh3LFHFF8oDqby+yAWzNdpo8m
        6jhD5+eOIMethdcDN/gUqEdoIy9MD0JUGIAZVr7jLRNIN0cy05Kg/XEOZopazUgD/hLOO/
        UoIg8tVC/zZ/9u5dSIr4g8xZABfPl3tiXIiGRIhXYrqtCQnoB/noQMqJEljnQIaUSuz/i0
        kM+DRbaDg968oVYXG5w3VcZFiOkjbFxvnuvi1KQcP5/x/Ic7ErvBc79TUI6Cpw==
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [PATCH v3 10/13] iio: core: Hide read accesses to iio_dev->currentmode
Date:   Mon,  7 Feb 2022 15:38:37 +0100
Message-Id: <20220207143840.707510-11-miquel.raynal@bootlin.com>
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

In order to later move this variable within the opaque structure, let's
create a helper for accessing it in read-only mode. This helper will be
exposed to device drivers and kept accessible for the few that could need
it. The write access to this variable however should be fully reserved to
the core so in a second step we will hide this variable into the opaque
structure.

Cc: Eugen Hristev <eugen.hristev@microchip.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/iio/accel/bmc150-accel-core.c |  4 ++--
 drivers/iio/adc/at91-sama5d2_adc.c    |  4 ++--
 drivers/iio/industrialio-core.c       | 11 +++++++++++
 include/linux/iio/iio.h               |  1 +
 4 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index e6081dd0a880..0ecded6d87df 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -1525,7 +1525,7 @@ static int bmc150_accel_buffer_postenable(struct iio_dev *indio_dev)
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 	int ret = 0;
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
@@ -1557,7 +1557,7 @@ static int bmc150_accel_buffer_predisable(struct iio_dev *indio_dev)
 {
 	struct bmc150_accel_data *data = iio_priv(indio_dev);
 
-	if (indio_dev->currentmode == INDIO_BUFFER_TRIGGERED)
+	if (iio_device_get_current_mode(indio_dev) == INDIO_BUFFER_TRIGGERED)
 		return 0;
 
 	mutex_lock(&data->mutex);
diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
index 854b1f81d807..b764823ce57e 100644
--- a/drivers/iio/adc/at91-sama5d2_adc.c
+++ b/drivers/iio/adc/at91-sama5d2_adc.c
@@ -1117,7 +1117,7 @@ static int at91_adc_buffer_prepare(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, true);
 
 	/* if we are not in triggered mode, we cannot enable the buffer. */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/* we continue with the triggered buffer */
@@ -1159,7 +1159,7 @@ static int at91_adc_buffer_postdisable(struct iio_dev *indio_dev)
 		return at91_adc_configure_touch(st, false);
 
 	/* if we are not in triggered mode, nothing to do here */
-	if (!(indio_dev->currentmode & INDIO_ALL_TRIGGERED_MODES))
+	if (!(iio_device_get_current_mode(indio_dev) & INDIO_ALL_TRIGGERED_MODES))
 		return -EINVAL;
 
 	/*
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index 64381d0a3d01..f8fcfe12dfa2 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -2071,6 +2071,17 @@ void iio_device_release_direct_mode(struct iio_dev *indio_dev)
 }
 EXPORT_SYMBOL_GPL(iio_device_release_direct_mode);
 
+/**
+ * iio_device_get_current_mode() - helper function providing read-only access to
+ *				   the @currentmode variable
+ * @indio_dev:			   IIO device structure for device
+ */
+int iio_device_get_current_mode(struct iio_dev *indio_dev)
+{
+	return indio_dev->currentmode;
+}
+EXPORT_SYMBOL_GPL(iio_device_get_current_mode);
+
 subsys_initcall(iio_init);
 module_exit(iio_exit);
 
diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
index faabb852128a..31098ffa7dc9 100644
--- a/include/linux/iio/iio.h
+++ b/include/linux/iio/iio.h
@@ -550,6 +550,7 @@ struct iio_dev {
 };
 
 int iio_device_id(struct iio_dev *indio_dev);
+int iio_device_get_current_mode(struct iio_dev *indio_dev);
 bool iio_buffer_enabled(struct iio_dev *indio_dev);
 
 const struct iio_chan_spec
-- 
2.27.0

