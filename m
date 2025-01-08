Return-Path: <linux-iio+bounces-14029-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CB6A0636C
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 18:31:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F79C188A35B
	for <lists+linux-iio@lfdr.de>; Wed,  8 Jan 2025 17:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34F7202C2E;
	Wed,  8 Jan 2025 17:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="e0A3ZUXs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F6452010E5
	for <linux-iio@vger.kernel.org>; Wed,  8 Jan 2025 17:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736357439; cv=none; b=jxIrAXdcGT29OQH/A6oujhZRGRW/Qt8Ma4h47/z5UEs6GJPdVvRPZIMCqIYUVJyp6KTDHANLxKsre3Y1svEVrz7h3mkzoZrSynJn2JA6Q6DtO3006EYJrtN/gdaFPWzO2weh55ZUi6sQHhvJJg4jZkP4yRWD59X8GnvJ/4aTbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736357439; c=relaxed/simple;
	bh=XfnaLwPbwvEvqLzRap/jhDwdzzaCiSDrFwR+woVVJDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G1IWXm8yYNI2aa/SsAWTknbcdUYlZhyJvt8ju3wcKWcYB76oRoDeg2DUay9CFzQndrQrYBdX9nTBo0c5Kd1MvZD1hIhLHwXKkocNtwRaVHkWch5HvNBfPqZxf3kbnKz5lr7MxqXPUxuCJ/MmbhPsUiB7UstDg/4sVBgC7BRVuwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=e0A3ZUXs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3862d161947so8220f8f.3
        for <linux-iio@vger.kernel.org>; Wed, 08 Jan 2025 09:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736357436; x=1736962236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4FQcFBx5V6lkdkVoqAqgUJ0fqMpy++8oGzKM6couGQY=;
        b=e0A3ZUXsdRCigPCDpEehbVPj2edMD7Lj0pw4dVJXADJ9JCXSMSLQXZBbdVSZgFA4Kk
         OuEEHaNm7Ls1xsUDgIWoUOH/CyLRQLXK/7NxQpMc9rbj0NMvuCTqwgmFJTp+fYt8ayQp
         OoKE3Los04hj1sbyd6MWXILVh51bXz5g3+TIo6y3Cf/7SZfLaTTM7HWC3lEDiO8GShLk
         5j+RJvBEachfHrrYDsYUIfQ6QxRsQR6EeGt8oJxgHVCa2a/ysGbDRqBEVpKpbE44Xdlv
         jVEvjvyc92DLHM4kufqAEJK+e3XNoD6uasVx4TkhCBSDfBGuHxfzhSqr7Rhkf/fcwQSN
         zagg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736357436; x=1736962236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4FQcFBx5V6lkdkVoqAqgUJ0fqMpy++8oGzKM6couGQY=;
        b=OjzUEgCeqt2dxiXb7YFAJ7cWjMPFOFx2omRzFPRdBcFeqp2yHAgOv+xzui9YpERvLe
         qvcMvgwPYFGz1B4bF9Fs/gq4PMLSMCZvONZ5X1nutyqHanV+LRFdt8zHjlhe6J6t+rRo
         +JWmI/fFphKZWx8hILLCuj44UqeRbGiSwjtraZqWG4+IyPzK1PUBRYD93EYkdnoRfbC2
         VUHdKZYxThODpKRVRW7RaluOKzFEbzNcLDjZP9/k/f3OwpyeV0JAkYLYN3episH0BD4V
         OyIhDaI6tDWcZe7Xnru3yhl3fhUMTC/4b/H5Mjt49EG7gGeKMNqN08JJiP/Vq6cugpFh
         6RMg==
X-Forwarded-Encrypted: i=1; AJvYcCWPrKQMMaTrcjTqzEn2QFovms/OjqnSC5QIoj+gJWRM/Q2U1hqCiulduqzu8Yf2k/2VSxEaL83EjuU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzcfr71FXZn8H//p5IXEzJ9LogRwr+cxKqhJVMoWIigu+MNmxSY
	Y4ItrrTKu8Ncy6m91UeKY7k19FIp7DnneLWBL0JS8Z1qmeAF/LTHTdNsFQ7C0+E=
X-Gm-Gg: ASbGncsRT0ci0Znv8kJrGp64WosNoDniZZHiq6Ay61mbxR+WoQE9L4qMdpEN9RYT6SF
	MoQW+117XYsfiCGXD/0fz57AGFj8Bf2ccFhKpQVuxH/fXiZQQILcJUdP1eWnnO4nElRO3EWb5Vi
	afsbo+QNha1YRqi7LM0TQyyyzdmVlKKMwYZKTuJh/II0YNpM0eHA0WUZsVeqPdCHut3HREh0s13
	eb/hkc5tJri217eT5z8yF/febiS9kbUCR/953kPoK5/y9I39DEPVk8+CN0=
X-Google-Smtp-Source: AGHT+IGgfxt16ev6MsDtJ/+I4o/+V+kvxrkDi2iioXLqcSIuCoTFprBTGUC4euEkcvZinBrYpakpsg==
X-Received: by 2002:a05:6000:4102:b0:38a:8afe:9530 with SMTP id ffacd0b85a97d-38a8afe9557mr194371f8f.33.1736357436006;
        Wed, 08 Jan 2025 09:30:36 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8330d4sm52782599f8f.29.2025.01.08.09.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 09:30:35 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Wed, 08 Jan 2025 18:29:18 +0100
Subject: [PATCH v2 4/9] iio: dac: adi-axi-dac: add bus mode setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-4-2dac02f04638@baylibre.com>
References: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
In-Reply-To: <20250108-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v2-0-2dac02f04638@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Mihail Chindris <mihail.chindris@analog.com>, Nuno Sa <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

The ad354xr requires DSPI mode (2 data lanes) to work in buffering
mode, so backend needs to allow a mode selection between:
    SPI  (entire ad35xxr family),
    DSPI (ad354xr),
    QSPI (ad355xr).

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.h  |  8 ++++++++
 drivers/iio/dac/adi-axi-dac.c | 26 +++++++++++++++++++++++++-
 2 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.h b/drivers/iio/dac/ad3552r-hs.h
index 724261d38dea..4a9e35234124 100644
--- a/drivers/iio/dac/ad3552r-hs.h
+++ b/drivers/iio/dac/ad3552r-hs.h
@@ -8,11 +8,19 @@
 
 struct iio_backend;
 
+enum ad3552r_io_mode {
+	AD3552R_IO_MODE_SPI,
+	AD3552R_IO_MODE_DSPI,
+	AD3552R_IO_MODE_QSPI,
+};
+
 struct ad3552r_hs_platform_data {
 	int (*bus_reg_read)(struct iio_backend *back, u32 reg, u32 *val,
 			    size_t data_size);
 	int (*bus_reg_write)(struct iio_backend *back, u32 reg, u32 val,
 			     size_t data_size);
+	int (*bus_set_io_mode)(struct iio_backend *back,
+			       enum ad3552r_io_mode mode);
 	u32 bus_sample_data_clock_hz;
 };
 
diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index d02eb535b648..79ca158c1ad9 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -64,7 +64,7 @@
 #define   AXI_DAC_UI_STATUS_IF_BUSY		BIT(4)
 #define AXI_DAC_CUSTOM_CTRL_REG			0x008C
 #define   AXI_DAC_CUSTOM_CTRL_ADDRESS		GENMASK(31, 24)
-#define   AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER	BIT(2)
+#define   AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE	GENMASK(3, 2)
 #define   AXI_DAC_CUSTOM_CTRL_STREAM		BIT(1)
 #define   AXI_DAC_CUSTOM_CTRL_TRANSFER_DATA	BIT(0)
 
@@ -725,6 +725,29 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static int axi_dac_bus_set_io_mode(struct iio_backend *back,
+				   enum ad3552r_io_mode mode)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ival, ret;
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+				 AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
+				 FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+				       AXI_DAC_UI_STATUS_REG, ival,
+				       FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+				       10, 100 * KILO);
+
+	if (ret == -ETIMEDOUT)
+		dev_err(st->dev, "AXI read timeout\n");
+
+	return ret;
+}
+
 static void axi_dac_child_remove(void *data)
 {
 	platform_device_unregister(data);
@@ -736,6 +759,7 @@ static int axi_dac_create_platform_device(struct axi_dac_state *st,
 	struct ad3552r_hs_platform_data pdata = {
 		.bus_reg_read = axi_dac_bus_reg_read,
 		.bus_reg_write = axi_dac_bus_reg_write,
+		.bus_set_io_mode = axi_dac_bus_set_io_mode,
 		.bus_sample_data_clock_hz = st->dac_clk_rate,
 	};
 	struct platform_device_info pi = {

-- 
2.47.0


