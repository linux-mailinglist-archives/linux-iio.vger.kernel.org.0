Return-Path: <linux-iio+bounces-11536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE529B3D5D
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 23:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0F081C210BC
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F41920370E;
	Mon, 28 Oct 2024 21:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="xtSMFOXj";
	dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b="HlYtwajC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail.kernel-space.org (mail.kernel-space.org [195.201.34.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FD1202F85;
	Mon, 28 Oct 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.34.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730152432; cv=none; b=a7bXwi0zdIas+m3RhMskOZEyoLT4MmnE2fnbcexWQsGJCs7b4xMokX7itX8ySd2qLSQ0Km5wl2QnkDrwsHWUr+sPFy6Rafa7VqO4dVnKqNTc6bwze0W/l0Db7yyJEx6iPJDRaOwWbgLEYSWqY9X9+8Nm42WPVdIVnQI+AxeiaLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730152432; c=relaxed/simple;
	bh=s14ugGZfEyGqRUlsV5I338Zk51rUFMYI7CfMxdkb6dI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IdZZzDw15ksKVrCd+5YBjen2LsqWaKNm8XyuyHQ7PbAD28IMnJKMMkuHxdo7036Dp6aQl4tI3uRgaR7NyE42eR9RTAeLpru2RLp5EXK2bqVL2gXqllFfBe36JdMm4TphzfvDT6QMPDIDOGAu8RnhmhA0aaXsd90b1Pf7cjNLwdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org; spf=pass smtp.mailfrom=kernel-space.org; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=xtSMFOXj; dkim=pass (1024-bit key) header.d=kernel-space.org header.i=@kernel-space.org header.b=HlYtwajC; arc=none smtp.client-ip=195.201.34.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernel-space.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel-space.org
Received: from kernel-space.org (localhost [127.0.0.1])
	by kernel-space.org (OpenSMTPD) with ESMTP id 3fe57925;
	Mon, 28 Oct 2024 21:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=s1; bh=JSO1PW7olavWA0V+FiTgaMcUZLY=; b=xtSMFOXjzKNPg4s8Tf
	K1/lYSPKxtpfrymd1gj6gzgjGdKFFpujACrmg34FKpNGXCtDl4NlyTOxzYnjBBUC
	/3WO8wbKNsGmTc/axj1pqLuh1OsTDawRcj2xeYBUDnYXkZahKEW4MD4EaBy6K8/D
	QpYUtoifZS9eK2upSoAkbvZ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=kernel-space.org; h=from
	:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; q=dns; s=s1; b=tYU+s5wbA2aA3HdpO4wm0OLM4wl8Go0vA5exv2K3ZU/K
	Chg0zpR278J/Y+pcgJgCb5iXcUy5AYbuo9Ii9oYW2b1ZOG0m7NQqMEgl/DLzmJ4w
	94+wjpu0zwiUnAttOoyUk1RioNdozRVlYGz7zJo2M82rXSp21+ieQRUvg1aIMTM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel-space.org;
	s=s1; t=1730151478;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Ysn+2jFOQ1hXNVhHri93TEH3r/t9aAnVbCCxjgU648=;
	b=HlYtwajCzdIrC6A/vzu5iIDRvP/BPYSdWzY4GMcPz4VO/orzvk/b3ceZxeWY8VrNiAKSO+
	8CKTYz3ZYQ8ef9006QbaJVRRNhoALbJPAWY0xW9a9ZiP+vIDAXwfxe3TRHa9wi6XKAGiMt
	SORjHk+/apowGRnUvdmV4wqgHLVxL58=
Received: from [127.0.1.1] (host-95-245-34-85.retail.telecomitalia.it [95.245.34.85])
	by kernel-space.org (OpenSMTPD) with ESMTPSA id 59439acb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 28 Oct 2024 21:37:58 +0000 (UTC)
From: Angelo Dureghello <angelo@kernel-space.org>
Date: Mon, 28 Oct 2024 22:45:35 +0100
Subject: [PATCH v9 8/8] iio: dac: adi-axi-dac: add registering of child fdt
 node
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-8-f6960b4f9719@kernel-space.org>
References: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
In-Reply-To: <20241028-wip-bl-ad3552r-axi-v0-iio-testing-v9-0-f6960b4f9719@kernel-space.org>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dlechner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <angelo@kernel-space.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Change to obtain the fdt use case as reported in the
adi,ad3552r.yaml file in this patchset.

The DAC device is defined as a child node of the backend.
Registering the child fdt node as a platform devices.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 56 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 155d04ca2315..a49d233c28c0 100644
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
@@ -711,6 +714,36 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
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
@@ -852,6 +885,28 @@ static int axi_dac_probe(struct platform_device *pdev)
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
@@ -869,6 +924,7 @@ static const struct axi_dac_info dac_ad3552r = {
 	.version = ADI_AXI_PCORE_VER(9, 1, 'b'),
 	.backend_info = &axi_ad3552r,
 	.has_dac_clk = true,
+	.has_child_nodes = true,
 };
 
 static const struct of_device_id axi_dac_of_match[] = {

-- 
2.45.0.rc1


