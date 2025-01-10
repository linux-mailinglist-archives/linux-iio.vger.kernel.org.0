Return-Path: <linux-iio+bounces-14091-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E466A08DE9
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2BB3A749F
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C27AA20C49E;
	Fri, 10 Jan 2025 10:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="okzMFdhb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B347E20C017
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504756; cv=none; b=X4HVQ617jwJ/OaKzJNakonVIWLMsmeNP4GWx/ryxG0JUG1J8yaX5luZTXyiqa3K41ty53q6omxcSmT/o8mj4W6nZYdESA5Txk0/6oNd03SCYpEP8xMItqd7pRJXiVGCPblmE3dvDZLynxgJKx8iqKDXlcjoQRpgTf9/N2i4CXUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504756; c=relaxed/simple;
	bh=DSWN/o0cgi3x6KUQNRx0A1I4b2JRVAVg3CF1OrlSau0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i0ZGfiJe8cUeoIgso2X08sTFAMuIw5ua9AnLM9vdooy28epPrU4RTS7pBjoutF6fWPrOhsEoGvqLXGqV0G+BVcoPYcJ6m8wJcJT2ROFnAfLo/JQsiVnEn5JPoWAFW+rt1nJLbsPv5/AyX5WjPQZ9PxylC38t/jniZy0QEB7BKV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=okzMFdhb; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3863494591bso1042129f8f.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504752; x=1737109552; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lH1+QRISrYTJQCkHtDpmUGDETZeTsT0d2K55FhuHdOs=;
        b=okzMFdhbkLkahVbLoQ14eXcVbLvvx8nzEm1oAngmOjuIQMPzn6zIYzAeuwqM73CzD4
         qG0ZtRAeaDuVQCkyQwwG9LOxINPKma0AEWB5/jlIJDwS9LaXRksQu1Le5+2/dvwALLE5
         rdQcz25IvHeGSWSqTWjqhsDYAnITk3FShpu1AD1eWYK9tdlYRLVvUl+OkRF2Y3rfUHaq
         zmXyU6zDJwg/1T5w0P+J2YDWJP9ygGoa4V12StGIaHwZxKyClfVLS9T1qudVK9kTtAj2
         xXES6aW7AVHQ0bEM68FnqSRg12qVytVkhxG4Ad2wuOgqLt62BQmrAYy1YdN7YpyqEB9C
         Y5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504752; x=1737109552;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lH1+QRISrYTJQCkHtDpmUGDETZeTsT0d2K55FhuHdOs=;
        b=UINzoQgAtHJ1vzNUn5/F91SmlH+RwEkb67akiZlKjLukcUbsZyEQf32ncMKfb2xD/d
         m0A4YvYHLyuREFGkvXNTxlTz/YAzsnHNL+QMAwQ40i3J7MFuxkABYLbHW0438xr8Gyfp
         t6Sp/E+13gHaG/WcnFr3RjvcXG/m8CQDeEndGiGy6K5hGoWpbeQVFtJciJC7riFe93zb
         DFgqoxHoUpdhrIeKJ6+WM7U/Yq8Ak0U/rp2iUphY8v8tuAOCK2QMBwXPtd/IJEmdYMcL
         LzObt5n4v+fbafNYpOlrRT2rGixa24Wu0qLqQmG7UyB2QrGLz8/V4FQSgfvXpddhsvNe
         HbnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNTwSJGtakJwIskzeh0NF9aW0xkpOscfds+FXArGW8eZgVk4gOAoqV9FW+XSExGm/DD1z2mAYOLZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz002qKKhuAa/dlpHNaYxL8t4wKreXLN0S9w7ecwyd2H01C6X9j
	H1U1YSRrRuS8Ru2IHLEo+EH8agZ/0jgXsQLeeDEwsVkYP/xvm5uwvV8WczXAnmE=
X-Gm-Gg: ASbGncu9ich2qcKh09VTcfx44K12dsK+2PaASY8g/FvozkcImOg7Mj0BqdZPlZPO6TZ
	qsZ9dVYlPcFFFSsUbGFnjzJKx5erOJV/NCVkdbKQUftyVMPeSCZRE0hJUOweYHsqpDc3vgRDQet
	18/dOvI6h2q7CBWCP2m8Pz1fHA/VPQaq0U90J3TPO2snY4sP2kDs8F/f0IVUJllAnfUyeHnwHfe
	LAWef2I6c0DWz6/Fpc/G3P4mQekfUu7YGdOa9x/1TKr5vP1uPvcLioC4hQ=
X-Google-Smtp-Source: AGHT+IE3++VQas4z/zJgn8dOh3EWyLSfjzOqCP0Tafv+3AGDb+Y5NSNOWs8Ujr3/PvFa0mPhc9Mqdg==
X-Received: by 2002:a05:6000:4b1e:b0:386:4034:f9a0 with SMTP id ffacd0b85a97d-38a87315be0mr8543043f8f.52.1736504752143;
        Fri, 10 Jan 2025 02:25:52 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:51 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:16 +0100
Subject: [PATCH v3 4/9] iio: dac: adi-axi-dac: add bus mode setup
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-4-ab42aef0d840@baylibre.com>
References: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
In-Reply-To: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-0-ab42aef0d840@baylibre.com>
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
mode, so backend needs to allow a mode selection between:
    SPI  (entire ad35xxr family),
    DSPI (ad354xr),
    QSPI (ad355xr).

About removal of AXI_DAC_CUSTOM_CTRL_SYNCED_TRANSFER, according to
the HDL history the flag has never been used. So looks like the driver
was including it by mistake or in anticipation for something that was
never implemented on HDL side.

Current HDL updated documentation confirm it is actually not in use
anymore and replaced by the IO_MODE bits.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.h  |  8 ++++++++
 drivers/iio/dac/adi-axi-dac.c | 22 +++++++++++++++++++++-
 2 files changed, 29 insertions(+), 1 deletion(-)

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
index ac871deb8063..bcaf365feef4 100644
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
2.47.0


