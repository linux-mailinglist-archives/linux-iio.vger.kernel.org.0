Return-Path: <linux-iio+bounces-19821-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90346AC1F31
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D373C7BA1D0
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CA3224AF9;
	Fri, 23 May 2025 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FLGYCwPI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1157B2222B8
	for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747990962; cv=none; b=tEqmAPMVuaH3BJz5xkuVMo/4bnwSrTg9+NOPiInkhjh636vY9G0Xm1ldImi9vFphfK609iIlzRwG+I9nI40um7t6TBs+Yvo5Ol8VQ1d0OY0/RztEbnhvjLfZVimqN/6cN9vRgfwDZKi8D0wViKwdq6DxOy4n+0Vx94/herSboTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747990962; c=relaxed/simple;
	bh=VGmVlLv/g0NSChA5cTCx5HI2+YgjvT8aXwQeEVYqWkw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFw++3OBnA0/UOc7naAmveJKAACs9B8k7lEc3z74VAUNnxlJOknaFFsOr484hD1XNe9NKA7c8uYHIIgKAHG884LM7ZYN0zK7U12WOLwecwbgpzqL1s8wcOguLAAJ1G6PPI/QiH1GosSseAhgoM26jUAmUwXKjuaKg2Tpnq0/4I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FLGYCwPI; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3a361b8a664so6951358f8f.3
        for <linux-iio@vger.kernel.org>; Fri, 23 May 2025 02:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1747990957; x=1748595757; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uNsJvlRDFjThPSOtGOteiq+PCHwiQFN7KKK0wuA2YaI=;
        b=FLGYCwPIbJnQ5T9lL5rvaJgXnOlsBdTkCYdXhPsAB0ZUxOPXcc2tQsZ05gd9MIQEWr
         x/g1SCZG48OcuUgo7CExH0uu/Mc6dTVelENDgT+9PfpxgSsDOarJXMIF3Xug85Rd9CHI
         TPvB93xMNgzh8ZTveVNA2QoSeq7ban+4biy5nat8B/JD3jtjhy0Z6xRTxx9M37REQmxf
         dJ5gLzXH6M+Fu1UNgaDnWNXJJelPqi6/VauM+Nbvndu85gn0iLzFGTiFRsuEWPaLRP2o
         m0QLzUDUaGPkLjPLA+Ywvlitrx6yacVwQ7Q29AMTMo0Oo6e2R4wR7Iv279oA7tcXVziR
         hV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747990957; x=1748595757;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uNsJvlRDFjThPSOtGOteiq+PCHwiQFN7KKK0wuA2YaI=;
        b=ixfUtFn4Qw2hdveZZmNLm1Pc19EKccO0KJCFe78xIf3jU/hRqI5BYJBuYq25QSU4CU
         1A7pa00tXVlt6Vi/IgA1jt1YfWu7sVq2RmRYoHrbJff9+Ft+OmhaQ3E9tdwe3grAxc1M
         dbP7rrWV4HTknWtDGga0ijCMKHKU+fzSeP27CfxjhnFxv6RAt+hW50B0Q//ofUInswMj
         PjsD7BAQc3ZfTGi7IWqlQEi0EqixKTejr9ZgZR06YqF+jl7bcqHpDEWN/ZYG17TxliQh
         cxJE80j9YCjcqFcl4Xi+1Man0HkRE3Xz0xcakIUqDiYn8QsAWu9nqZdxEawhvfVu/0+s
         gUuw==
X-Forwarded-Encrypted: i=1; AJvYcCV5QrfDVSPPXmMexBJ+E6yOWK9gmgusPMGy7M9WDf2KU1aqWwc9uB5ojiS+dH6SJSDFouYmikRiOoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIrOOqkfJTUN2A5lxxzOGOrSLtxSi1WwPCZJz5JcQ6HilVkYuo
	yzz02oo5Ht/IxK/ORm5AuD5K17lJEx3klQ1Ifbq4p8i05AtJNxnbT702ZwoEGf6kVBw=
X-Gm-Gg: ASbGncv860m56pzGYdHO0A2p5C/sdjaheKBjf8mFTthxIySux5d3nr2MY2V6VAKRfA6
	7WyDg/r/PbmhL6lgVDwy9mb9OA+Du/kRdVWREQDHLopz7L/gCFa+FNg2CVIvUfnBPKmwYQN4pF2
	jAGIv32ifAXshgFbV7T1TVM9VHuQe9V4mJzO7Mso1GUMIbR6HUsbrMQ3qSdyQAyXTmLX/vHfxJh
	wrrhUUOJy3lGuDxw3enzEagT6mcVkqRxFgwFhQpgtQR58s+3ZoDiRrxUC2CEal7V3QT5GdgwQcK
	nFSVHk+6WWc0GfQd/eYZLr65a5vf/Iq5zqHVwV4P41RaCydgiSgdgQFM4zG+BYLLfNZIvke15WA
	p2DQnOXwMorKgU2fLM2aOQsGLTT1ZfHanA0M=
X-Google-Smtp-Source: AGHT+IHrv/0Am2o/Cwc2NPGsVz+BDLqWvyUZRI3yS33HkECUWVudaOgyHY6MciP6XrQElNGui4KaAA==
X-Received: by 2002:a05:6000:1883:b0:3a0:7d39:c23f with SMTP id ffacd0b85a97d-3a35c821990mr24768606f8f.21.1747990957326;
        Fri, 23 May 2025 02:02:37 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-447f24b6471sm134043205e9.24.2025.05.23.02.02.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 02:02:36 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 23 May 2025 11:00:51 +0200
Subject: [PATCH v3 1/2] iio: dac: adi-axi-dac: fix bus read
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250523-ad3552r-fix-bus-read-v3-1-310e726dd964@baylibre.com>
References: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
In-Reply-To: <20250523-ad3552r-fix-bus-read-v3-0-310e726dd964@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1333;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=9pHPKsKzptvjYiQOA8UzTeuM77FIRRsobVc0fiDL1Ac=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsgwsEyZ2OWzV1FgL2dKvMgVlZsTGQrktLobFre6aaxtE
 Z2WvuxxRykLgxgXg6yYIktdYoRJ6O1QKeUFjLNh5rAygQxh4OIUgIm8e8XwT9u3q5j/J/uvLIm3
 rK+Uu4I6RRdu5djx/tys/td7r+twtDL8FQndrLxVgrfD5MVE18fMTxpk1ioGejyqcS8Lu7vij+Y
 zLgA=
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Fix bus read function.

Testing the driver, on a random basis, wrong reads was detected, mainly
by a wrong DAC chip ID read at first boot.
Before reading the expected value from the AXI regmap, need always to
wait for busy flag to be cleared.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/adi-axi-dac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 8ed5ad1fa24cef649056bc5f4ca80abbf28b9323..5ee077c58d7f9730aec8a9c9dff5b84108b3a47e 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -760,6 +760,7 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 {
 	struct axi_dac_state *st = iio_backend_get_priv(back);
 	int ret;
+	u32 ival;
 
 	guard(mutex)(&st->lock);
 
@@ -772,6 +773,13 @@ static int axi_dac_bus_reg_read(struct iio_backend *back, u32 reg, u32 *val,
 	if (ret)
 		return ret;
 
+	ret = regmap_read_poll_timeout(st->regmap,
+				AXI_DAC_UI_STATUS_REG, ival,
+				FIELD_GET(AXI_DAC_UI_STATUS_IF_BUSY, ival) == 0,
+				10, 100 * KILO);
+	if (ret)
+		return ret;
+
 	return regmap_read(st->regmap, AXI_DAC_CUSTOM_RD_REG, val);
 }
 

-- 
2.49.0


