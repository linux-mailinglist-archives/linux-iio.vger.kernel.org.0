Return-Path: <linux-iio+bounces-19178-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E67AAA6EB
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 02:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC5167A8E7F
	for <lists+linux-iio@lfdr.de>; Tue,  6 May 2025 00:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522213316FD;
	Mon,  5 May 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSFBnDp9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065373316F1;
	Mon,  5 May 2025 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484550; cv=none; b=aeparMpGwgzE4QRTD8jhdKj3ML4JO7u1I7A6Ck747mgbEnSac4XuAEghA/ajLOWjsMElGWjnBm3Kq/X3MT0VISdeF0Sv7HrrIUA2JW/v5tXIELhc6vLgGHXAMYumTQcrpSP/kUr8zm2c9mxRAGKpBB+YIcOrJSbNqTxh6+U04PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484550; c=relaxed/simple;
	bh=T6X10xwBXaUmZ9mbJAPTwAX444ToawO00oOaPylJyLE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LqkCEnVxI22IyolyeoxQ3zjnBoobetKi4zX2WvOyq09B9dEbSq7/fU2uQHyIK9pq5nzR04xyFckM4WU+1qUQwPhdc536giKeNrWOe4ZcqWJ92RzIF9YeW06vjUYl/6K66CYw7DfCXwvJfE264OrESxBcP/aiFFrcia/kyj8/2A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSFBnDp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4C4C4CEE4;
	Mon,  5 May 2025 22:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484549;
	bh=T6X10xwBXaUmZ9mbJAPTwAX444ToawO00oOaPylJyLE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JSFBnDp94un7BitbdW3YxnPzUkyxSTG29PIlRgil2NvBA9raYXgBVL2eXj64rH/64
	 4N+pAleFjfjFFzCkB12MhfAxaN0bLa8V9lHZH8489E3bAIDmVxbbu75922awhYwyvS
	 K4cIzDilroaYhO1hPXn4VmuPYdVflg8CMx+k1olPTRC5OjXe7k4P4OHp+PdqwKAdaz
	 ZFogZ3NyxxaPNTT7L5GHLmNBERiwGBg702BCmc0XOknkb47a9VxWcICv0CH0UusYrd
	 WVZ1t32TZYSaucDcw5EAxBXBA9V2XfBaHDfp9H9Dv4GW8aAlgRRUdAEcKoaBiNTClN
	 ofBZNCCQTINYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Angelo Dureghello <adureghello@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Sasha Levin <sashal@kernel.org>,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 531/642] iio: dac: adi-axi-dac: add bus mode setup
Date: Mon,  5 May 2025 18:12:27 -0400
Message-Id: <20250505221419.2672473-531-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
Content-Transfer-Encoding: 8bit

From: Angelo Dureghello <adureghello@baylibre.com>

[ Upstream commit 8ab67b37b81dfaa00a25e95a5f5a020f374848bb ]

The ad354xr requires DSPI mode (2 data lanes) to work in buffering
mode, so, depending on the DAC type, target TRANSFER_REGISTER
"MULTI_IO_MODE" bitfield can be set between:
    SPI  (configuration, entire ad35xxr family),
    DSPI (ad354xr),
    QSPI (ad355xr).
Also bus IO_MODE must be set accordingly.

About removal of AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER, according to
the HDL history the flag has never been used. So looks like the driver
was including it by mistake or in anticipation for something that was
never implemented on HDL side.

Current HDL updated documentation confirm it is actually not in use
anymore and replaced by the IO_MODE bits.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Link: https://patch.msgid.link/20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-4-979402e33545@baylibre.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad3552r-hs.h  |  8 ++++++++
 drivers/iio/dac/adi-axi-dac.c | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.h b/drivers/iio/dac/ad3552r-hs.h
index 724261d38dea3..4a9e352341244 100644
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
index ac871deb8063c..bcaf365feef42 100644
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
 
@@ -722,6 +722,25 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static int axi_dac_bus_set_io_mode(struct iio_backend *back,
+				   enum ad3552r_io_mode mode)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ival, ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
+			AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE,
+			FIELD_PREP(AXI_DAC_CUSTOM_CTRL_MULTI_IO_MODE, mode));
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(st->regmap, AXI_DAC_UI_STATUS_REG, ival,
+			FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0, 10,
+			100 * KILO);
+}
+
 static void axi_dac_child_remove(void *data)
 {
 	platform_device_unregister(data);
@@ -733,6 +752,7 @@ static int axi_dac_create_platform_device(struct axi_dac_state *st,
 	struct ad3552r_hs_platform_data pdata = {
 		.bus_reg_read = axi_dac_bus_reg_read,
 		.bus_reg_write = axi_dac_bus_reg_write,
+		.bus_set_io_mode = axi_dac_bus_set_io_mode,
 		.bus_sample_data_clock_hz = st->dac_clk_rate,
 	};
 	struct platform_device_info pi = {
-- 
2.39.5


