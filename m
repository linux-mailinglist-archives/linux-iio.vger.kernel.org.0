Return-Path: <linux-iio+bounces-14093-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D40BBA08DED
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 814C87A3D0A
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8DC20D4E9;
	Fri, 10 Jan 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="S1fOCyZM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83A20CCD3
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504760; cv=none; b=qI3CzEpygNx669YXgFBqBYSN2shdJQpgawW4ypAQZxDFES3BY1TVWvSYMMuv/NoYNjDQfDAfL3lEYC2dn+Ky5L8+/e291kHbT81L5zq9qzQPI0ivD8Ud39MtevO0wsO0JrYC2LkVGTNpTzOCVlWgdL3i9nZBVbyYQCaIQ0TxYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504760; c=relaxed/simple;
	bh=DnAjjx0PkSOieNJ5OJb2nk2Cce0Mvn+naUnXYCUW1PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W9AHrnG9oiw7cI1DcVj1Fqwto4ufcMSDC4iT5i7apmWtqtwD3L2gwfw480i5e4j0+HmIWgqpxd3CZo+xGREMF1moL7GYJnniel/u4hnoS5xqSDHHgMpUapPLmlKygdULrXf/+G39bfjPmKUolsSU02cxRynCcx1wuQYtUi7qzeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=S1fOCyZM; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-43618283d48so14110995e9.1
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504756; x=1737109556; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qABqYAhj0TrQzJxH7XVarpnbO7+OveXqYM2s3icznC4=;
        b=S1fOCyZMWePF7zwDB3hI05dTQpXzZ879uIuCyKopxdOgJf9AtSS5tp6PQeE2T6qC4U
         VSAehJqWQl5sE67izvqP0ZC2sXfvLLEue+712HCVf9ScLhzFQO+Zjwn+YiZjMCUDaRr2
         ufwmcy5463w1QaVXWdWj43kYje1NXmlDO1xX8ZPW/4pqpalatXGUNx+EfqR92SKHJiun
         hzYGHXrYrmpIr6z8r5xQifTyJt+SxQpIN1LVVwVXLXuc8MAVmae37zN51cbAAh/faM3d
         kkCFV+I221aBz8vPP2zUcpTjAbk8bL2PDV8kaNGNWOfRm8HC/vEQajGlVoFl4DvPuApU
         Yw8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504756; x=1737109556;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qABqYAhj0TrQzJxH7XVarpnbO7+OveXqYM2s3icznC4=;
        b=m5tq3hzjbHYQ0p3C/YVkqB/NtZr1jloLQrXL+1e2Fvi/QX03wJwIZxue4CRg8Y3N0x
         EhHacCPiWI0MA+h4x5y4cgFWC2nAlojWepdqRAAHzNnH7J6iILJBXYm4MtWz5dJl9pA9
         vj1djKlOcdduN2s1s9gmSJjzoCe2PvUV+BKQ/YbtqPVnd9puSGqjwVDKbnyX0c97/zo9
         X5CwNrRn+5H3NssltWgNNPKYJ6qlfwkRCiamQaqmjMFx8EEph6TctUVv7tlcETmmKr4L
         yeYeXIXL8zmM4e0IRV4SZMmBlExMMTcMRF3FKRONkO6e2YqZkNqnhlrZghoroJeizbh9
         nKmg==
X-Forwarded-Encrypted: i=1; AJvYcCUBMnDj94hviDl2WmNnGuE0kC0KOsxFErU0TWlvqKIUnqgs/HLKP9/TgoScFpm6mZ5aOD0WyQKqCN0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzK3UHOT/9cGR+waaCHrlsxrmWTuQOAgh9JSVIGSLJ9tz9JlABg
	EkaIQzWEv9RKqXHZ17va7rOpRyumCKz3zaAs3tu5BilCsmyhyPyFq6PVrFGkQzc=
X-Gm-Gg: ASbGncu8Q5uGyU9aaLUfi6rAfWLlaSkIvZHT2/2G6idRHYDdpIAm6Cmiadq6yyT+bdi
	gxnRIeK2bTF4N8VrvOtgJYUpqZKpE1k5NpDW8OFRDAb4DV1+IHpYmvCoP7CWtP6vxoQ2nFwSCCI
	Sw01hf1Kuq7py9FHla7HipmqCiy2HXhTpExc5lIa7xJE4ubZI0/YAgiFfSXaOB1T3A4vHFRIyr/
	7rQAOKcGAv93CkC9e0PMrhlcKDaw9QOfmpCHNg+p5XWS85HuBO3c6xZCbk=
X-Google-Smtp-Source: AGHT+IHVTtg/VQnGvUCRt2oKOr92lb02jK+IARgNZEIOjrxyoLmMhc1xHBMyeYvuSdonJxgo9+CMhA==
X-Received: by 2002:a05:6000:401e:b0:38a:4184:151c with SMTP id ffacd0b85a97d-38a8730ad01mr9040183f8f.27.1736504754872;
        Fri, 10 Jan 2025 02:25:54 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:54 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:18 +0100
Subject: [PATCH v3 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-6-ab42aef0d840@baylibre.com>
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

Use "instruction" mode over initial configuration and all other
non-streaming operations.

DAC boots in streaming mode as default, and the driver is not
changing this mode.

Instruction r/w is still working becouse instruction is processed
from the DAC after chip select is deasserted, this works until
loop mode is 0 or greater than the instruction size.

All initial operations should be more safely done in instruction
mode, a mode provided for this.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 27949f207d42..991b11702273 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -132,6 +132,13 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 		return -EINVAL;
 	}
 
+	/* Primary region access, set streaming mode (now in SPI + SDR). */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	if (ret)
+		return ret;
+
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_STREAM_MODE,
 				      loop_len, 1);
 	if (ret)
@@ -198,6 +205,14 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/* Back to single instruction mode, disabling loop. */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST,
+					   AD3552R_MASK_SINGLE_INST, 1);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -308,6 +323,13 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 	if (ret)
 		return ret;
 
+	ret = st->data->bus_reg_write(st->back,
+				      AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				      AD3552R_MASK_SINGLE_INST |
+				      AD3552R_MASK_SHORT_INSTRUCTION, 1);
+	if (ret)
+		return ret;
+
 	ret = ad3552r_hs_scratch_pad_test(st);
 	if (ret)
 		return ret;

-- 
2.47.0


