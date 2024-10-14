Return-Path: <linux-iio+bounces-10561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D17299C6DC
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 12:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82C021F21052
	for <lists+linux-iio@lfdr.de>; Mon, 14 Oct 2024 10:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3745D19E7F3;
	Mon, 14 Oct 2024 10:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="f3ePl3cR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F2A19C548
	for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728900591; cv=none; b=txPMy13SvujeCQvZ0HczwWgeeA+q2vz+ZSlZDA00QFPVoGnRlcxa4XyJPaZJYUKbWnTr+oTemnUzCCUCYn/bBg2kghpvR0Y6vYLaJo7ctam97UzrOCsUyyi1/7FOwVC9Q0pU16u/qjqWWcc3CMwyNgt+ASXI0H9Orn/YkDA2RB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728900591; c=relaxed/simple;
	bh=hUhx+tvYi47jQoSXDvgX4coJm17v9UceFQPwKhKQI64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ELgk52fvERQJIA0drRPMaJa2pc4NbGHeAnSgX5tF2Ef5TiFlGK9BTpc92C0v0qyHDcyqj7+mEBTATY2T5MoqUCa1v0pqFyrNpbIoOGcXoHBO6ktXbY1dulJAACVeO/kafQAn22LEONNiMZHJw2vTV5zTHWWFJhZeq9HHoVgAyDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=f3ePl3cR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-43115b31366so37706755e9.3
        for <linux-iio@vger.kernel.org>; Mon, 14 Oct 2024 03:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728900587; x=1729505387; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cgPxxBkzLK3FAX+hb0rCBt3sAxL4kx844/NCgxHuNGA=;
        b=f3ePl3cRtlBtkh2vt1jRBFteWg3+kChtSSy8V+R6eKfmBDTkJ9CmORMVEDCMKPrTXk
         5OLKatpAsnQbxHeDDyCwm+5qP1CJjHGwDjZo38zWvs1dUw/fS81NYGJCyg9mZFpiclEs
         iWoXqR7sYkduYZ1lunI45MOm0n9OyXx8yLtgMxGEjgTnkMfV9cUumgGE1Xduap7zeVZt
         tciImXpS+13WSfPlRdtfyliEVDqb+uXYjJDRgGUt2U6r4EjmCzMjGPdIkv1D/1xGgFvs
         JAb4dAhhHQuKFBlFY3sIdG2w6iou5L5W2vK8TjEtyD41sZUNO4WolGGedtUs6hsWNCmm
         kdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728900587; x=1729505387;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgPxxBkzLK3FAX+hb0rCBt3sAxL4kx844/NCgxHuNGA=;
        b=SgRI2uJLn98gzTN9tj9HDo5URcXrYudYbzNWSkAV8mwJFdzF3N5s1IbjRUSYdP1Ea4
         /w5egW8I/Aqn7SzYTdS3IuNJq3ytU4VXaxBgv60fbF1RtPVC+Ouw3nElYbPeQi4lkOeK
         2j+EeVjRgCkb7M/Am7zLZIO9HHT6rwjZ4FJByLyesKyz5MrTGXQaH8H5rqnb41NHBrFb
         wCIHsGkhkCe0zF8ueE9Atk2jHdjdds7W5D/hZDqph7cG9qQ6D1CCFdttVyEnlT6MyCMw
         XSdN8vkGls1kcJH6HFse3HiEXaP7G7YiWJpX0c07EAAxPtrIv1b8xAvUWloEcbv7tmyt
         to6Q==
X-Gm-Message-State: AOJu0YxiK8gzp3lBzkS85e/Bk6IDoVycw9hONYFofL5g1zp2FguH9eRG
	/fxBowgeNwFcRutXtUVlyaHOk2YWTEbWnDKBUsTUKHH4KpTZzWCNYzZiawfNCkE=
X-Google-Smtp-Source: AGHT+IGU8XDKwR1oSsXn7gbKxdE0BPtraSLs/+RkoPDcJF/ZZBiXrgLdjAWA+4fCD54l7kysRAGfdg==
X-Received: by 2002:a05:6000:e85:b0:37d:4d21:350c with SMTP id ffacd0b85a97d-37d551e1303mr6575967f8f.13.1728900587314;
        Mon, 14 Oct 2024 03:09:47 -0700 (PDT)
Received: from [127.0.1.1] (host-79-45-239-138.retail.telecomitalia.it. [79.45.239.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b7ee0afsm10969352f8f.102.2024.10.14.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 03:09:46 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Mon, 14 Oct 2024 12:08:14 +0200
Subject: [PATCH v6 8/8] iio: dac: adi-axi-dac: add registering of child fdt
 node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-8-eeef0c1e0e56@baylibre.com>
References: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
In-Reply-To: <20241014-wip-bl-ad3552r-axi-v0-iio-testing-v6-0-eeef0c1e0e56@baylibre.com>
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
index b887c6343f96..f85e3138d428 100644
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
@@ -738,6 +740,39 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static void axi_dac_child_remove(void *data)
+{
+	struct platform_device *pdev = data;
+
+	platform_device_unregister(pdev);
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
+	device_set_node(&pdev->dev, child);
+
+	return devm_add_action_or_reset(st->dev, axi_dac_child_remove, pdev);
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -874,6 +909,24 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	device_for_each_child_node_scoped(&pdev->dev, child) {
+		int val;
+
+		/* Processing only reg 0 node */
+		ret = fwnode_property_read_u32(child, "reg", &val);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+						"child node missing.");
+		if (val != 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+						"invalid node address.");
+
+		ret = axi_dac_create_platform_device(st, child);
+		if (ret)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+						"could not create device.");
+	}
+
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),

-- 
2.45.0.rc1


