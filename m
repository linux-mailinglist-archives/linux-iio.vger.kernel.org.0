Return-Path: <linux-iio+bounces-10865-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AC619A690C
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 14:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4CE4B25CEF
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2024 12:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141581F9416;
	Mon, 21 Oct 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YMQyYUmX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6F21F8F04
	for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 12:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729514509; cv=none; b=KUk82T1eaJ93SNnT07Rn+RBq+pblu2fc2wNK1cV2ne7w13zMfokToPv+6XH06EH/Z5OxltyBAff1ojBK8CN4zEuhUUn7C2GhSB70lQb6KD/Th9+H+ndcKof9VaZnWbyWZkWLEp/ZHqjCZawAGu8lNMLdevvR+nU9Sq3p6Q3ZtIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729514509; c=relaxed/simple;
	bh=FcAs0kiOHRD1fvgyMKd2WJEXtRqjslAMwz3NIAN5It0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ic9lWjsh6M7wE1Np1cG0vjfyPO5S5dKR7R/XCP6qCCTHL7+oH2oxhK53X9y+kjFt4HPeU2R403CTAp4KJ+p5SUTIBtobMhLVKHpM3j4cSfOFqa926OjUt3rGmhXZqUC/20np6YiVYm2fz9dz0nENOJs6gbO9yh3p/rJeiJHawjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YMQyYUmX; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-37ed3bd6114so1930618f8f.2
        for <linux-iio@vger.kernel.org>; Mon, 21 Oct 2024 05:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729514505; x=1730119305; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LBP96gSZJELbHsXLNxR5YSM2dT8EQquriFqivC5gwA4=;
        b=YMQyYUmXYPFU8zEedCKj+g8bNyxuRoG4KVpJWWXPiNQfxHkuiV/EV6U1QQxZMDiwMd
         PuFknfiR9/egSeDYh7ML8/SFE3Mk8iSzBms0N7HQUBlVQS0s7q6fdIE1BbYBZYFI1KHO
         MzPDC3aqOlxAQchex8dHNRpQYAiWgQo8pnRoJFMG4nCJIKXmOSYqLIa3j2E/az2CyEeq
         OdHxXrozcNO7ZaovVhpSd26/u1neKiJrF5eKp06Vr3uCpngqSIjtgQemKkhSGdKJpONj
         2ZJSfIPa3TGkY3wmsiLjWr/TloEsO6/tLQJV20x/oOsZkBcpfomUi3SSO0sVrfMbF2S5
         AiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729514505; x=1730119305;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LBP96gSZJELbHsXLNxR5YSM2dT8EQquriFqivC5gwA4=;
        b=B8ceEs72T+o4VCYHyr5IbEiwIoRi1HjyYMySrIrzah3F60CHd39ADCQiQh9IyDYzGv
         14R60ZyDpW/ln5knjLbq5g482uB8rLAM44tpIyXJzPJCgbLaaLv576ALObWALQwfQWSz
         RuBggU+J/qLpbbvX7Bhn99JGmjn//6HwU2+xzlBnfKQHqfx+Ku9krejJqfGtG9EpU1uE
         tIMxCg6DcD/m5kdndS2epDDC/5ALX+AThHrGTpkflpN/RkR633ryD/chQuhjxwPoClPk
         5y4hwbA0+/+B8V1ng671G21ElVqGRBuGQcjRjVZy3k6tEmwCHU8LZO4R+T2IIlTfWAiL
         KXbg==
X-Gm-Message-State: AOJu0Yw7WSsS+AjrQt1/x0uxY1kEHDpO3LwMScW+K9DYvLpCTU3/Xi72
	xu44zpFG/ju8/bIeVUiLA1yuzc0ymUtxKiWk/7a6vtPaqW1OUBqNqPB3RtYzNqY=
X-Google-Smtp-Source: AGHT+IGM2/WfM0tOEBUv03Z9qDm3SI3Qo9VgfGIfH2z9fiR+i8m8qjF8I4XxedP9BQLYFF0OVpUo6g==
X-Received: by 2002:adf:ffc5:0:b0:37d:5338:872c with SMTP id ffacd0b85a97d-37ea2136f6emr6648486f8f.1.1729514505222;
        Mon, 21 Oct 2024 05:41:45 -0700 (PDT)
Received: from [127.0.1.1] (host-82-61-199-210.retail.telecomitalia.it. [82.61.199.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4316f5cc88esm55996075e9.46.2024.10.21.05.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 05:41:44 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 21 Oct 2024 14:40:18 +0200
Subject: [PATCH v7 8/8] iio: dac: adi-axi-dac: add registering of child fdt
 node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-8-969694f53c5d@baylibre.com>
References: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
In-Reply-To: <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change to obtain the fdt use case as reported in the
adi,ad3552r.yaml file in this patchset.

The DAC device is defined as a child node of the backend.
Registering the child fdt node as a platform devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 9d6809fe7a67..7f7ef3e219ba 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -29,6 +29,8 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 
+#include "ad3552r-hs.h"
+
 /*
  * Register definitions:
  *   https://wiki.analog.com/resources/fpga/docs/axi_dac_ip#register_map
@@ -97,6 +99,7 @@ struct axi_dac_info {
 	unsigned int version;
 	const struct iio_backend_info *backend_info;
 	bool has_dac_clk;
+	bool has_child_nodes;
 };
 
 struct axi_dac_state {
@@ -723,6 +726,35 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static void axi_dac_child_remove(void *data)
+{
+	platform_device_unregister(data);
+}
+
+static int axi_dac_create_platform_device(struct axi_dac_state *st,
+					  struct fwnode_handle *child)
+{
+	struct ad3552r_hs_platform_data pdata = {
+		.bus_reg_read = axi_dac_bus_reg_read,
+		.bus_reg_write = axi_dac_bus_reg_write,
+	};
+	struct platform_device_info pi = {
+		.parent = st->dev,
+		.name = fwnode_get_name(child),
+		.id = PLATFORM_DEVID_AUTO,
+		.fwnode = child,
+		.data = &pdata,
+		.size_data = sizeof(pdata),
+	};
+	struct platform_device *pdev;
+
+	pdev = platform_device_register_full(&pi);
+	if (IS_ERR(pdev))
+		return PTR_ERR(pdev);
+
+	return devm_add_action_or_reset(st->dev, axi_dac_child_remove, pdev);
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -865,6 +897,26 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	if (st->info->has_child_nodes) {
+		device_for_each_child_node_scoped(&pdev->dev, child) {
+			int val;
+
+			/* Processing only reg 0 node */
+			ret = fwnode_property_read_u32(child, "reg", &val);
+			if (ret)
+				return dev_err_probe(&pdev->dev, ret,
+						     "invalid reg property.");
+			if (val != 0)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "invalid node address.");
+
+			ret = axi_dac_create_platform_device(st, child);
+			if (ret)
+				return dev_err_probe(&pdev->dev, -EINVAL,
+						     "cannot create device.");
+		}
+	}
+
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -882,6 +934,7 @@ static const struct axi_dac_info dac_ad3552r = {
 	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
 	.backend_info = &axi_ad3552r,
 	.has_dac_clk = true,
+	.has_child_nodes = true,
 };
 
 static const struct of_device_id axi_dac_of_match[] = {

-- 
2.45.0.rc1


