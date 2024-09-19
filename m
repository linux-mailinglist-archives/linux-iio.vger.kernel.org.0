Return-Path: <linux-iio+bounces-9647-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9AE897C702
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 11:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F661F247FD
	for <lists+linux-iio@lfdr.de>; Thu, 19 Sep 2024 09:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70F619DF5C;
	Thu, 19 Sep 2024 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XuGsU8RH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CB019D89E
	for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 09:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726737712; cv=none; b=hQwqJDhxYYQfcuTVBUTv4YiDaWmeRzyUcRmR78gFf0RGF2l8QoujR7OgVXdFR9HL7hNTdWFvLyrFfO73glzPpdxQTruB3+cgBvAS8m8cED/CYLa/AUy/6aOVRUWWASY2Lf9mEtQUxFYuez/ftI/IAfovlGZNn/lxOt6LltJW0E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726737712; c=relaxed/simple;
	bh=wTh4ZX/Lq4bxELrDl4dLXCSoDZv2J7fQ9IPUziM5on0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CqYyJdfhXnnSE8FRDI4m57A+iCKJZYtDRdefmG51LCjrbTfmdVR2JliDPsIYJurEj7XmBR/uNe11D95cbi9nlcySZwRLS3em4axs0eV2uo4upYNsTEq8f6x9BXAvRD6xUbbu6+kZy6RyIDBj0Y2N1jE0ooARFKWDgyg/NjbTBaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XuGsU8RH; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3770320574aso345497f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Sep 2024 02:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1726737709; x=1727342509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDBUjP1+gjd3K5h0oG5X/MTM074M3dAHmKYG+rdovVU=;
        b=XuGsU8RHmZy85fUTRkuCspmKvGIghq1qVeejrjM5BC4zp/UPiApGrjew28m1eZ7EjD
         kTS2r8UFnp2EBLgI5mfJP6AnFJrBBR+SSKSa6ihTMmTHkzF+U615OeIoBgMekxvv057g
         IDEGokjSMP331HwUGqjkXyzYK7XH2r3rb3Ngn3UVtISm04VIZnJpBh9hu0pGFeZxYXUp
         sdpOu+XT40mSjjL5L8kMPX7s4+s6U/6/M9Ymf0ACHza9Y2vah1EbnHDi6+S/J1UqzpeO
         X9ktsZhdlWCPd8YoH3vu5x94OiHKAznpSN+0zEQjgPw1kUf+3fEx6g5jYBfvNP0cHhx1
         PcJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726737709; x=1727342509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDBUjP1+gjd3K5h0oG5X/MTM074M3dAHmKYG+rdovVU=;
        b=ryspcfiwSnDzuVn8aFeg4NOMD0IpvucWe6J8S6vHqtZ+fkUVH7u90tPbBleNW5owHY
         p9sizgEI7ZkMvDlaYM3957N8tgxIEX4+FtBtADFyMXgpDNPL6uihInxWZ3HBFAnzw1/w
         nKrIXO50IUGmysJdqcJ2UP5sNpzMMN8F0ynFnJ5qRVdCRg9hziOg9Da3eJ/g1HymWM3q
         xay1mGxRMx3MJPYeivbbnlJMt8hTf3m+aGQktJS6/Yl7YqVGU0ZUJ6vE0EUCODcpdJBj
         USEDcTgQ8aZSfA2+CkpvLY1M0RUOOTykxCQI8VtqP2S93ysI+RwHZT4Rmq7pDdWwaOrI
         X7wg==
X-Gm-Message-State: AOJu0YwRv4yl2P0innlblnmVwRLmH8dWMX+8qa10kQCKyRmRcT8qMCKb
	+cQtf+WRPdbQGivsAkV1Z0PfJisJnAtLDmj7PqQQ96W2PagsBHfpcloKphUMlM0=
X-Google-Smtp-Source: AGHT+IHxdr7iojwOBs/10Ra5p+6qT9Z1ZPpg9lcLP/NKiiCl3mLdNMdiNRDGvTctoAV4LaU/+V/Xag==
X-Received: by 2002:a5d:4ec4:0:b0:374:c10c:83b3 with SMTP id ffacd0b85a97d-378c2d624a2mr13291883f8f.54.1726737708814;
        Thu, 19 Sep 2024 02:21:48 -0700 (PDT)
Received: from [127.0.1.1] (host-80-117-99-70.retail.telecomitalia.it. [80.117.99.70])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e75468413sm16889465e9.45.2024.09.19.02.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Sep 2024 02:21:48 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 19 Sep 2024 11:20:06 +0200
Subject: [PATCH v3 10/10] iio: backend: adi-axi-dac: add registering of
 child fdt node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-10-a17b9b3d05d9@baylibre.com>
References: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
In-Reply-To: <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dlechner@baylibre.com, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change to obtain the fdt use case as reported in the
adi,ad3552r.yaml file in this patchset.

The DAC device is defined as a child node of the backend.
Registering the child fdt node as a platform devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 52 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 3ca3a14c575b..2afc1442cd5a 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/mod_devicetable.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/ad3552r-axi.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
@@ -109,6 +110,8 @@ struct axi_dac_info {
 struct axi_dac_state {
 	struct regmap *regmap;
 	struct device *dev;
+	/* Target DAC platform device */
+	struct platform_device *dac_pdev;
 	/*
 	 * lock to protect multiple accesses to the device registers and global
 	 * data/variables.
@@ -757,6 +760,32 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg,
 	}
 }
 
+static int axi_dac_create_platform_device(struct axi_dac_state *st,
+					  struct fwnode_handle *child)
+{
+	struct ad3552r_axi_platform_data pdata = {
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
+	st->dac_pdev = pdev;
+
+	return 0;
+}
+
 static const struct iio_backend_ops axi_dac_generic_ops = {
 	.enable = axi_dac_enable,
 	.disable = axi_dac_disable,
@@ -791,13 +820,22 @@ static const struct regmap_config axi_dac_regmap_config = {
 	.max_register = 0x0800,
 };
 
+static void axi_dac_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct axi_dac_state *st = dev_get_drvdata(dev);
+
+	if (st->dac_pdev)
+		platform_device_unregister(st->dac_pdev);
+}
+
 static int axi_dac_probe(struct platform_device *pdev)
 {
 	struct axi_dac_state *st;
 	void __iomem *base;
 	unsigned int ver;
 	struct clk *clk;
-	int ret;
+	int ret, val;
 
 	st = devm_kzalloc(&pdev->dev, sizeof(*st), GFP_KERNEL);
 	if (!st)
@@ -871,6 +909,17 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	device_for_each_child_node_scoped(&pdev->dev, child) {
+		/* Processing only reg 0 node */
+		ret = fwnode_property_read_u32(child, "reg", &val);
+		if (ret || val != 0)
+			continue;
+
+		ret = axi_dac_create_platform_device(st, child);
+		if (ret)
+			continue;
+	}
+
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -901,6 +950,7 @@ static struct platform_driver axi_dac_driver = {
 		.of_match_table = axi_dac_of_match,
 	},
 	.probe = axi_dac_probe,
+	.remove = axi_dac_remove,
 };
 module_platform_driver(axi_dac_driver);
 

-- 
2.45.0.rc1


