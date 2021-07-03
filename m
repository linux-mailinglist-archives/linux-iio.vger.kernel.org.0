Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAE3BA7DA
	for <lists+linux-iio@lfdr.de>; Sat,  3 Jul 2021 10:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbhGCIpT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Jul 2021 04:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhGCIpR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Jul 2021 04:45:17 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D656C061762;
        Sat,  3 Jul 2021 01:42:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:
        Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PcaF3iNFdy45vSe79yOejDShPKLFK8srNP61lqCrY68=; b=W5rLdN/qve2ZVAttZWWbzruvhy
        BUWzTY8oI62itwlpxylIVQZDZWAn6HPjDrZsnC2OX4hPsrjIsBk+WMk4GQFZlPrl5yN4pjmCqgXyE
        4vnpQmAALPktsGKr+5Ylm5Od75ELpBLDV9pQmiAlZrth4hSoISQiuucalmkMmvVUNSeA=;
Received: from p200300ccff37da001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff37:da00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEW-0006OC-QL; Sat, 03 Jul 2021 10:42:40 +0200
Received: from andi by aktux with local (Exim 4.92)
        (envelope-from <andreas@kemnade.info>)
        id 1lzbEW-0008Hf-FE; Sat, 03 Jul 2021 10:42:40 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     lee.jones@linaro.org, robh+dt@kernel.org, jic23@kernel.org,
        lars@metafoo.de, sre@kernel.org, andreas@kemnade.info,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-pm@vger.kernel.org,
        leonard.crestez@nxp.com, letux-kernel@openphoenux.org
Subject: [PATCH 3/4] iio: rn5t618: Add devicetree support
Date:   Sat,  3 Jul 2021 10:42:23 +0200
Message-Id: <20210703084224.31623-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210703084224.31623-1-andreas@kemnade.info>
References: <20210703084224.31623-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Add devicetree support to be able to easily get the channels
from another device.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/iio/adc/rn5t618-adc.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/rn5t618-adc.c b/drivers/iio/adc/rn5t618-adc.c
index 7010c4276947..feba19f91574 100644
--- a/drivers/iio/adc/rn5t618-adc.c
+++ b/drivers/iio/adc/rn5t618-adc.c
@@ -12,6 +12,7 @@
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/mfd/rn5t618.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/completion.h>
 #include <linux/regmap.h>
@@ -218,6 +219,7 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 	init_completion(&adc->conv_completion);
 
 	iio_dev->name = dev_name(&pdev->dev);
+	iio_dev->dev.of_node = pdev->dev.of_node;
 	iio_dev->info = &rn5t618_adc_iio_info;
 	iio_dev->modes = INDIO_DIRECT_MODE;
 	iio_dev->channels = rn5t618_adc_iio_channels;
@@ -242,9 +244,19 @@ static int rn5t618_adc_probe(struct platform_device *pdev)
 	return devm_iio_device_register(adc->dev, iio_dev);
 }
 
+#ifdef CONFIG_OF
+static const struct of_device_id rn5t618_adc_of_match[] = {
+	{ .compatible = "ricoh,rc5t619-adc", },
+	{ .compatible = "ricoh,rn5t618-adc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, rn5t618_adc_of_match);
+#endif
+
 static struct platform_driver rn5t618_adc_driver = {
 	.driver = {
-		.name   = "rn5t618-adc",
+		.name = "rn5t618-adc",
+		.of_match_table = of_match_ptr(rn5t618_adc_of_match),
 	},
 	.probe = rn5t618_adc_probe,
 };
-- 
2.30.2

