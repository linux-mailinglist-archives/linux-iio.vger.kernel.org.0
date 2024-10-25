Return-Path: <linux-iio+bounces-11268-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2949AFF03
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 11:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40055284A50
	for <lists+linux-iio@lfdr.de>; Fri, 25 Oct 2024 09:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CD71FBF66;
	Fri, 25 Oct 2024 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="lA1tg0Eh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C211F8180
	for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 09:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729849873; cv=none; b=Mijsz0avIvL2kSHvBKlBuwULboak6tK1fuBEXlyLL36NWlTBjN6O2Abx7QmsBfir9sdLk0bG/wVQE0RUToXnOIbIO8Dny7zl9oAJt6fKECDV60otCmWFqpqPuR78snRuAOlJ2M967oHCWA3od7LWmGO7A8/PYiuqNpVU3tk0J/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729849873; c=relaxed/simple;
	bh=qkX0nl5rvNFAD4t3iDzIThyb/2D3UDTKreCfkCePaGQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eqfhuHAvSU2VMB9rMZZ/lIMm2CclOgQM79w7n3HcmAyyIWfkTVmP2sqhF1B1Zv3FhZnQz3+9G4kYSZ7O7LpkC1GY4oIl4tV7O7aP4TAJVMaEZE7UeMfFq9p2PeHGTMIb6orEt1MIzTKbxrgOIM2V+/XNDMWHvG64VSNou36d6Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=lA1tg0Eh; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-43155afca99so19829335e9.1
        for <linux-iio@vger.kernel.org>; Fri, 25 Oct 2024 02:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729849869; x=1730454669; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/aYRx10LIx18s/5vpjDGgULjxldPzrrAdUjt9qoc4a4=;
        b=lA1tg0EhCp6dO/I9egv8EA6rqK5v5UKRopaxlzw/CCC+vuhqwi8BhgIcEgCAVsk30U
         J6tgfhaSfiC9Y7x6nIuM9+ygZyY0fIr7znJEKTZ9uBOqc0bkcdaTXfN0N8BRlV09EWQP
         whCWCoikJtiCtJfI3MAEqQ9HBqVSZ0miFMnV2GsxdexoV+ahKaH7CashNJVW8+/c2EH8
         8IaLPN8Ck8PMDeOow48W2nJtfK7Njcw+RM9SZCVtfv7msRebn6pAGydqDxpyOUT3r+c9
         69PT0R10ybEyuRPtyde7q2yn/kUngvs1C8UpuJVanT6xl+A4+FZZeJ+aZY/kO8OeVHDE
         fTnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729849869; x=1730454669;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/aYRx10LIx18s/5vpjDGgULjxldPzrrAdUjt9qoc4a4=;
        b=otFvqahpdBAOdt9itX+5+R4ZHXvjAzNl7ueRnIYPY8aQda4kf12nYMito/WYytL2XH
         5ZYM4MJnAENJfuqPX+7QY2DWpLTu0Q4aUeURyNkNBqNxA/MxCwVqCfTicmuMON1T38G4
         nJgAk+rXdqbcCUWGpHzgkkyY+K6hwdCt2gx/IgxuGFe0PX+joRhurZuhVOcFB/V6mSp+
         0HGg6qUtCuOm/PImKKMoht5mUFi6do3id2F7GablSNp69Ca//ZCORJ4Mhv6HJtN1MZRj
         2PNzSXdqU87V+MrUE4vKNMxJOhbM+G2ENfMkPF7GG1lc5XChvP2n3azsiFpdHpveATzB
         X8uQ==
X-Gm-Message-State: AOJu0Yzdj2ZnBusNdwiMYwCcG8wMr6HrR2jgZoKfq32p1vDrIkCryIKg
	ku7i7ddG6DT84T1fMcajQq1dLErwk9UBewZx59Iw+bdek9C0Z65zjoS2Hj9lhI56/3qBbBaq6g2
	+meBFaURb
X-Google-Smtp-Source: AGHT+IHmwWsFrbMw/Bs+MM2teeITRSFYRP5Geof+tpjdxm9iyQ5zs+9wro7UoDvxoKjOKk3Hp1Cmvg==
X-Received: by 2002:a05:600c:35d5:b0:431:52da:9d89 with SMTP id 5b1f17b1804b1-4318b5b0cf5mr36654655e9.1.1729849869003;
        Fri, 25 Oct 2024 02:51:09 -0700 (PDT)
Received: from [127.0.1.1] (host-79-41-194-153.retail.telecomitalia.it. [79.41.194.153])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431935f6df1sm12895085e9.35.2024.10.25.02.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:51:08 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 25 Oct 2024 11:49:41 +0200
Subject: [PATCH v8 8/8] iio: dac: adi-axi-dac: add registering of child fdt
 node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-8-74ca7dd60567@baylibre.com>
References: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
In-Reply-To: <20241025-wip-bl-ad3552r-axi-v0-iio-testing-v8-0-74ca7dd60567@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 dlechner@baylibre.com, Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change to obtain the fdt use case as reported in the
adi,ad3552r.yaml file in this patchset.

The DAC device is defined as a child node of the backend.
Registering the child fdt node as a platform devices.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 148e40a8ab2a..dc9f881bf9ce 100644
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
@@ -699,6 +702,36 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
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
+		.bus_sample_data_clock_hz = st->dac_clk_rate,
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
@@ -840,6 +873,28 @@ static int axi_dac_probe(struct platform_device *pdev)
 		return dev_err_probe(&pdev->dev, ret,
 				     "failed to register iio backend\n");
 
+	device_for_each_child_node_scoped(&pdev->dev, child) {
+		int val;
+
+		if (!st->info->has_child_nodes)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+					     "invalid fdt axi-dac compatible.");
+
+		/* Processing only reg 0 node */
+		ret = fwnode_property_read_u32(child, "reg", &val);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+						"invalid reg property.");
+		if (val != 0)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+						"invalid node address.");
+
+		ret = axi_dac_create_platform_device(st, child);
+		if (ret)
+			return dev_err_probe(&pdev->dev, -EINVAL,
+						"cannot create device.");
+	}
+
 	dev_info(&pdev->dev, "AXI DAC IP core (%d.%.2d.%c) probed\n",
 		 ADI_AXI_PCORE_VER_MAJOR(ver),
 		 ADI_AXI_PCORE_VER_MINOR(ver),
@@ -857,6 +912,7 @@ static const struct axi_dac_info dac_ad3552r = {
 	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
 	.backend_info = &axi_ad3552r,
 	.has_dac_clk = true,
+	.has_child_nodes = true,
 };
 
 static const struct of_device_id axi_dac_of_match[] = {

-- 
2.45.0.rc1


