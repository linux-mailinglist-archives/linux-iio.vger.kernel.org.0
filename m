Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 934B03BBC41
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jul 2021 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhGELje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Jul 2021 07:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbhGELje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 5 Jul 2021 07:39:34 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5978FC06175F;
        Mon,  5 Jul 2021 04:36:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=207qmaruKG1Uhm2EpxrEUEqkgkjKutc9zN4dvlzoT14=; b=H1vyRaH8hmZReoHe3rhuuVLaVI
        lm/brm+cOVYVMf+Y9umIyYhcCSKCymJr7ZXgSz0w4VVyexWenqwHvnIzpEgBBvNB/CPfAAM7jSbZ7
        +MChe50hUJH6bJ9i4D1RWsf2r/1QBLi4FBg4CJl8mgl42nG8R3R6gIjBF3E/LQd5chqM=;
Received: from p200300ccff0e44001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff0e:4400:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuE-0007Cs-5Q; Mon, 05 Jul 2021 13:36:54 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1m0MuD-0007XG-TN; Mon, 05 Jul 2021 13:36:53 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     jic23@kernel.org, lars@metafoo.de, sre@kernel.org,
        andreas@kemnade.info, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: [PATCH v2 1/2] iio: adc: rn5t618: Add iio map
Date:   Mon,  5 Jul 2021 13:36:36 +0200
Message-Id: <20210705113637.28908-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210705113637.28908-1-andreas@kemnade.info>
References: <20210705113637.28908-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add iio map to allow power driver to read out values as a consumer.
This approach does not block later addition of devicetree support
which would be helpful if there is an in-kernel consumer for AIN0/1.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes in v2:
- provide consumer mapping via iio_map instead of devicetree

 drivers/iio/adc/rn5t618-adc.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 7010c4276947..c56fccb2c8e1 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -16,6 +16,8 @@
 #include <linux/completion.h>
 #include <linux/regmap.h>
 #include <linux/iio/iio.h>
+#include <linux/iio/driver.h>
+#include <linux/iio/machine.h>
 #include <linux/slab.h>
 
 #define RN5T618_ADC_CONVERSION_TIMEOUT   (msecs_to_jiffies(500))
@@ -189,6 +191,19 @@ static const struct iio_chan_spec rn5t618_adc_iio_channels[] = {
 	RN5T618_ADC_CHANNEL(AIN0, IIO_VOLTAGE, "AIN0")
 };
 
+static struct iio_map rn5t618_maps[] = {
+	IIO_MAP("VADP", "rn5t618-power", "vadp"),
+	IIO_MAP("VUSB", "rn5t618-power", "vusb"),
+	{ /* sentinel */ }
+};
+
+static void unregister_map(void *data)
+{
+	struct iio_dev *iio_dev = (struct iio_dev *) data;
+
+	iio_map_array_unregister(iio_dev);
+}
+
 static int rn5t618_adc_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -239,6 +254,14 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = iio_map_array_register(iio_dev, rn5t618_maps);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_add_action_or_reset(adc->dev, unregister_map, iio_dev);
+	if (ret < 0)
+		return ret;
+
 	return devm_iio_device_register(adc->dev, iio_dev);
 }
 
-- 
2.30.2

