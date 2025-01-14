Return-Path: <linux-iio+bounces-14356-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF630A10AE3
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:32:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EE163A91D8
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:32:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66D9E1BD9EA;
	Tue, 14 Jan 2025 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="oQTAmP0V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3273218EFCC
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868712; cv=none; b=Rxgc+Rs2MMU+7QKUxnS6adpzPCTF1hAeNsuCRZSQsBX+o/kSBj5KSgMGETqBXmuBgwYV3IDpnCj+ZwANucnJnMToHqQVJ1d7FLKzqBr23t/I8olckNg19zSpWxeSJ4juFJt6Nz0FN7DWoCd8wUFJZi36RJNqCxPLOicvdiyVItU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868712; c=relaxed/simple;
	bh=pSP5O2KpDcWDn/YPvUVk/p3yqEOsgwFMEHN2oKWfl2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sq+WXB9tWtJ+KHe4V8U8rtjHWcleRmPSxqSR+vrS0qoCvCgnwWOO9S2hhQn9ZwMlEhPC740V59xjdEWzAbzbU6h6MX8JfmyzvPcWv3PCXPDdPfQl9RtvB12cMMxVw3IbMq51gaN/QG6xYbYMxB2aR+yzY9jREZ0nJbMqXjAc7aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=oQTAmP0V; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-38a88ba968aso4664219f8f.3
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868708; x=1737473508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=79ELYnS/0cFQomhFXegbEFpd0OUlcm/1XJ4h0p0TxPA=;
        b=oQTAmP0VN/7YrYU0b6McFPgPIdRbtBGuuj+QZs7zFWMpc4Ys4B7A8DNhTO8k5qNSjE
         Tcov0GwTlyF1O3zTegRwtabcUiflWHbRUoG2/SzC78tRM4R211tRDCa+PudXefg4VALW
         VB++8ghIMHRVIma6U/wURV2BWFahXvuW1S23nyN0M5Uvs3jQIO+xDragxvQYE0RKkalD
         2OiqSM0U/nFNlDP4NNLc0VdZnu7Bto776vSc7om4bKqyf6Kdbl9UcKMNo0bayrD1AF0m
         iIIJcccdjzNa19ATmduCyDqw0VQ0IbpxlyyIN+6iPdzaBUqn1dRwJlQCWRoamSSQPzem
         28fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868708; x=1737473508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=79ELYnS/0cFQomhFXegbEFpd0OUlcm/1XJ4h0p0TxPA=;
        b=FWJo1TASfyWNc3ZtwJlOEZY3N8V3dsgqIuEFXMuooXAtY8ayogFrFarMrymlxF0JS9
         JztUReuJNzbwqKOFNsErh2dv9klP0HzYpXDUrbs4ZGCLBQ6E1318jbAXMWJd+k32ud8x
         kEIYlEcqSUrU1R0dV7Nb2FzFlQ4Cc+ApjlqiO1nK/qvihJpTbE6lsxaJo2ckN8cOOScM
         ebxQhw5fKLkM1HKroSJ/WtSRpPWGFECRJ+vV0yTRSRKQSDUn6X1SqrfulId/QpzwDa0Y
         GlbbpxgWkunsHRiWpanD7MMudmTdbgRkwGUNX9o5iwtGCKqCmUVZ+NZlJ38IeBExMq+t
         ClLw==
X-Forwarded-Encrypted: i=1; AJvYcCXOzFo5qu/TEaybYfI8fwEhIPCYQyJHc03y0f8r6LMMRVek8uHkLsGCqyZg8UGham9BDL9JtbYTTww=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgUrxmgCHYL1gDoyuo+RpXu7axWBUpaN/6CrzTuJ2GfqqaTba4
	8Cf7jaA3LI5HbZ0gKJDUVaX/6rgxJOUgc8GoPCHfLFdFLaE4yOqZ6vrTyB3LwaA=
X-Gm-Gg: ASbGncuEGDZ3MlmX157o6WtH1/WyI1WJSw5dH79ryu2CIsTMp5cGD9A9BdMFW3Glzmx
	F+GqKtjzsFMDlS+waAQcG7eKYWbunadQwOQ9ftYHaeCCTD+f3JSBjVi3DfrkM3okYDlPUjIP6Rq
	zNIwivDdbYn3LOhvw/CIQaTjZIguUiFMh1S7PqE8AnSqsnGdZlYELMGSVwt21xQitFSBsm0IaGX
	jA8AfiYTvgVJy1h5Orz2kVt08HGf8qvU3v7A1x4pdy9IpOLuXoRM/5fwAs=
X-Google-Smtp-Source: AGHT+IEQwIlC+JLtLtee+bYn5GDdoWVZ3hShcRyhT/V0Hier8yuFXFLUZ2GFZ3aUCqKCEmcFYWLBlw==
X-Received: by 2002:a05:6000:184e:b0:382:46ea:113f with SMTP id ffacd0b85a97d-38a872fc1b3mr23588975f8f.10.1736868707122;
        Tue, 14 Jan 2025 07:31:47 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:46 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:12 +0100
Subject: [PATCH v4 3/9] iio: dac: adi-axi-dac: modify stream enable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-3-979402e33545@baylibre.com>
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

Change suggested from the AXI HDL team, modify the function
axi_dac_data_stream_enable() to check for interface busy, to avoid
possible issues when starting the stream.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index b143f7ed6847..ac871deb8063 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -585,6 +585,14 @@ static int axi_dac_ddr_disable(struct iio_backend *back)
 static int axi_dac_data_stream_enable(struct iio_backend *back)
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
+	int ret, val;
+
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, val,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, val) == 0,
+				10, 100 * KILO);
+	if (ret)
+		return ret;
 
 	return regmap_set_bits(st->regmap, AXI_DAC_CUSTOM_CTRL_REG,
 			       AXI_DAC_CUSTOM_CTRL_STREAM_ENABLE);

-- 
2.47.0


