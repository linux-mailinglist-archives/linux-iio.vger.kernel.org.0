Return-Path: <linux-iio+bounces-14357-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CB2A10AE2
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79518162D85
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CE11C2324;
	Tue, 14 Jan 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="h/w/dpAF"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C43519066D
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868712; cv=none; b=GJ0V3FGDsuD93F7GdScJtoaZo3xXY7IZWLK+3Uefc4oAgZMKmatdWk98r1TpzejWMAenzEavTYPkvVaOJlKHKz+oMSDFhg6/kubQMELevCQwGV6V4xeSdFx5h6jlwK+/f7zV8dkwpMFCf4Q9xgGpu+j5t41ga9cgWtHeseIGVHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868712; c=relaxed/simple;
	bh=M6naqnLCM4ZXUGO/uUploLBwKizmZEKciSJDiKFWV0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=llzBulPA4ksWuPEQ6NsGzEabTQRwoKT19zJxSE4xCJ61fnm9KP7RANNbORKDlpDVggCp1MrKIj9tEiJGaF/S1UqqJRoDTwcqYJVUEXQaOzKdMnFexaEmgtF0KQ33Mljh3B7+bjustJ41fv1WsOMYjN25PGs+SPrp9NfVXfR5EV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=h/w/dpAF; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so40519895e9.1
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868709; x=1737473509; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/d4iBZJ3r931DOCGukuu/0h9Or44VrIVD3hzoFAX6nY=;
        b=h/w/dpAF6EFGk6sg9pebrS2lLNC+55gD4hcy2KPfr96LptWOY0KyiRk+FOdz7FkwAu
         NfKn0I09y0StokeTwGy4WC7TLcptwmaj15QPdZKRQsUfSzDxMtcm/+T+tvt8/ZzN88j5
         gNYc0YMD4upkNBluiPYrIpq69wtvgDRQlm/Pe26FFH2ZTd/xJ60kT4JV07Gcw+aJQsWd
         cDphIHPApaToUHkr52YFCvHWA1n8gZRQu1HLaFo9AKcncJlHvp4geLJvNIUPzADSTj9L
         BRWcAevPsiuweor2Zc3yK4T1T53XQ3Hve83fUYiJcYmvjOLA/9XQPQCgASbMPji8kLNL
         ceYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868709; x=1737473509;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/d4iBZJ3r931DOCGukuu/0h9Or44VrIVD3hzoFAX6nY=;
        b=sGMN1h+eex/aCdq9w6QJ1s8d00eLBS1xJ1ttO4c9JXk6EWX/Y2c886Q+NKk+ccW/Uo
         j7+QzJGlXL8DucppAD3W9abFXug0oeXTMQZSY18xYmQWHhyISIw5g5UNLDhnF1BKLMVD
         OcZdW+ZLOkI6XbgXlzC6clLVPJSc3R3l5M3BoSkozF05Cc+336hsO6o5JyNTP61a23Ai
         JBoFpAn70Oqpbe8TECsw2iSoiQXeHq9Cen0Y4xA8GPJL/pN3yXBlUqupKWILxCoRnToc
         +pU2OuyGpwhnbi/ZIAUu/sQpRbSE8bgZa1MAHHvk4aSfw+SPuZmgn5FnssS42TQfYe/F
         OVNA==
X-Forwarded-Encrypted: i=1; AJvYcCXrEGw90k42gFhY5dgUxXHihammX2bBOE7nR4TYBEXM1Ft1+vXL8UcEaZysNvy4XBJFcpZ8AOM93rM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LyYgdNdlNWJvnyyqlYkkKEfxograkwFFTcVY4VwuBevVf7m7
	7piMBK9jfZ4tdn7SGhy5uYBTecAyZhhJpjgCl8u0+iahdsKmwrwXJkymqnEAAPg=
X-Gm-Gg: ASbGncsTrI9iMi4TPN6UVyHzaayxXxrj/Tk2mVHgWTk+PnVAZiyQIIuFnQq6GCmSEjx
	uak2E9yzR3YINRaoozY4T3Vx0d0qC06aY7hYvayimiRpRjl50TA2u8DAeqzmDd0PnhlyQVnoX+s
	vrN7iofgI1hwybgyWFJjummBYSqvLTz6HqOq2W8QB3tu6NiH4GoyKkoPS2Os4W5skwWENnvoMN8
	/EoKhqtjaTR+FEUG54SyQYkHgeMybJ1crhX7npflZhViLbGftM+fA4apBw=
X-Google-Smtp-Source: AGHT+IFms9UiV+PF4o0FViAbBpzFXZQSmkQPq9Fro0GWF4ObbRaN0Lk34b6EYD+QAzvkkhtkVZRtzw==
X-Received: by 2002:a5d:6484:0:b0:385:f092:e00 with SMTP id ffacd0b85a97d-38a87355760mr21235499f8f.50.1736868708533;
        Tue, 14 Jan 2025 07:31:48 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:47 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:13 +0100
Subject: [PATCH v4 4/9] iio: dac: adi-axi-dac: add bus mode setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-4-979402e33545@baylibre.com>
References: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
In-Reply-To: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-0-979402e33545@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Nuno Sa <nuno.sa@analog.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

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
---
 drivers/iio/dac/ad3552r-hs.h  |  8 ++++++++
 drivers/iio/dac/adi-axi-dac.c | 25 ++++++++++++++++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

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
index ac871deb8063..ac4c96c4ccf3 100644
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
 
@@ -722,6 +722,28 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 
+static int axi_dac_bus_set_io_mode(struct iio_backend *back,
+				   enum ad3552r_io_mode mode)
+{
+	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ival, ret;
+
+	if (!(mode >= AD3552R_IO_MODE_SPI && mode <= AD3552R_IO_MODE_QSPI))
+		return -EINVAL;
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
@@ -733,6 +755,7 @@ static int axi_dac_create_platform_device(struct axi_dac_state *st,
 	struct ad3552r_hs_platform_data pdata = {
 		.bus_reg_read = axi_dac_bus_reg_read,
 		.bus_reg_write = axi_dac_bus_reg_write,
+		.bus_set_io_mode = axi_dac_bus_set_io_mode,
 		.bus_sample_data_clock_hz = st->dac_clk_rate,
 	};
 	struct platform_device_info pi = {

-- 
2.47.0


