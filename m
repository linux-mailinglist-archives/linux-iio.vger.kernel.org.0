Return-Path: <linux-iio+bounces-14359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D772A10AE8
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:33:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20A971883AFB
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5911D1730;
	Tue, 14 Jan 2025 15:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="C+CZ7QIk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 685B41C54B3
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868715; cv=none; b=guhrGCnXdKriZ80JF1B9+xiM1B9fKpKIvR1oEMY2m6r7E/XEOlKfyYTuLE8IAFE+qaWB7IO38yTYxYg5cd2oIB/qjkeNhd9+9swcAjMMxwnyRH9ylhzIpdHUSE7dYgzqR299AMD6wDlnUuIcL49ZyU823IX31dnAxyZeeuBZSXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868715; c=relaxed/simple;
	bh=UItI2hZUiFhSBtbcXWs4AMta6KQvhi9R1iJhmuA9Jg8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hmf4TyU5xScTUDJPoE/mTl7ZF7JKBK5JLIHbx4+EhNu2cGwY8cVYgZ09sdnyLdfF+4s537V4RqOZ/WRLd2ZWFQGJ5epPKt2ApPPaDEKtzQLgcEht5babJwuP2liegowhjCNOLuxGUANECaVQdBaDeWdQN76FfdTeh4PF1IR/9G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=C+CZ7QIk; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-38a34e8410bso2781558f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868712; x=1737473512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b7AD+wJ8IOjuFx6p9gLrTL8TthqHXj7sqaFRN+y4/jo=;
        b=C+CZ7QIkRs+xH/tlLX7fq2E+5f532SpB2pl9myceRlKJESfMHIRCuRmnRkbl8WT/Is
         kw5EF+hKWuys/xsZCDe/pMsZ1wjR7ykSXZSwJMq72ECs+vO6XdDXhJZJwgi1ItcW2vfj
         /AKw0VWrNSafO9dtHsx+lDuluyyjWmdi5VSzHbbfLDd3214AzN/G6oVY4nF0cYuu3Q6j
         hwig2zQyb/JrOh4t+hxoZ30Auz38MroSJfG2EH0Zbk+yW+w86fsT1aa0wxZaLmd/loPM
         D5LN/DcNPzX79fS1vqGSipHxn5gYELJBy4b/UUPot7LJ/oOdEsNoUXBIvtF2+4vo0zux
         Jk7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868712; x=1737473512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b7AD+wJ8IOjuFx6p9gLrTL8TthqHXj7sqaFRN+y4/jo=;
        b=V3sidu/JJ+sqhiezP5NzARRevoM/VEfPUBL3Q9LCYrRWWnAtJlMi0AIdRUltdMFQcO
         /I0ZU/y527X+0S8g7d1Anwl1kurmkjVfibN7TntbtxgGNtAQSvkPb0M0I0XfvieoUZv2
         C702cGVOm/Fgc58GAiKTDTG8RaYiCbVZ//KCTxo8/d4f20mlSXBiu3lwLDbLLv35ZcsV
         cV+YVk++M3DGeA9O6ytxVikDasqc/B7vVDRWaNYTkzG/105nMN9sVqdjtuzyi81nHIzM
         7JUaxiJ2CSZGkzyz99pS6vlYpwELPdA19BSUvgsTmyKUCPvF1rT8xoU3NQiZH9sHyhHd
         hk6g==
X-Forwarded-Encrypted: i=1; AJvYcCXhys7lkNqIBpef/z+lvujgOMthgtNFI90OaqVlzuzCpTtfeejwroq2RXPSfGd3/vpCMtZvP8PPC2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwltXZ82EsGH6kFTzpaVH0OLhII3G6vOnf1Bg/vP8V8rmEEXkA/
	vL7rkJ8fWY7naUUxGkdgMN8l9r4KMe3CkhiJqqonc8wmnF3+20cfCy+Aedmcres=
X-Gm-Gg: ASbGncuurXhfi5Rw26i1Y+1mEjUnFw12isz/0F0M3J+fVFZv6IxdRzDnxkRV6zx4frA
	0lrrzVTMkYmVrArChHG0jXh1bUOdRaiMOuOxk7KklM5733G5XFBpH3K/W2vrfNOyOYQFTDNntEi
	0vY659rwRqtVDshnH+fntxnTjZd9HEfLISKtLIL5ElYCFrxlDvYF+nhZ3s2BpwmUmcvPv7VEspx
	Tace6fOFNytEN0HsWN6oplyTafInjIiXV9TvxxIXTpb/+RAQsdhSZf5alY=
X-Google-Smtp-Source: AGHT+IEBdBTstRr21+IGJ+9lga2m4RjpAaan3Vw+TrGj1moJe+FA7MQSsGPvn31Jx0HzgkVxxzHBZA==
X-Received: by 2002:a5d:584d:0:b0:386:4a16:dad7 with SMTP id ffacd0b85a97d-38a872d2a33mr24271920f8f.10.1736868711783;
        Tue, 14 Jan 2025 07:31:51 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:51 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:15 +0100
Subject: [PATCH v4 6/9] iio: dac: ad3552r-hs: use instruction mode for
 configuration
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-6-979402e33545@baylibre.com>
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

Use "instruction" mode over initial configuration and all other
non-streaming operations.

DAC boots in streaming mode as default, and the driver is not
changing this mode.

Instruction r/w is still working because instruction is processed
from the DAC after chip select is deasserted, this works until
loop mode is 0 or greater than the instruction size.

All initial operations should be more safely done in instruction
mode, a mode provided for this.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 6bf995b50395..25ee716b57cd 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -137,13 +137,20 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	/* Primary region access, set streaming mode (now in SPI + SDR). */
+	ret = ad3552r_qspi_update_reg_bits(st,
+					   AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+					   AD3552R_MASK_SINGLE_INST, 0, 1);
+	if (ret)
+		return ret;
+
 	/* Inform DAC chip to switch into DDR mode */
 	ret = ad3552r_qspi_update_reg_bits(st,
 					   AD3552R_REG_ADDR_INTERFACE_CONFIG_D,
 					   AD3552R_MASK_SPI_CONFIG_DDR,
 					   AD3552R_MASK_SPI_CONFIG_DDR, 1);
 	if (ret)
-		return ret;
+		goto exit_err_ddr;
 
 	/* Inform DAC IP to go for DDR mode from now on */
 	ret = iio_backend_ddr_enable(st->back);
@@ -174,6 +181,11 @@ static int ad3552r_hs_buffer_postenable(struct iio_dev *indio_dev)
 
 	iio_backend_ddr_disable(st->back);
 
+exit_err_ddr:
+	ad3552r_qspi_update_reg_bits(st, AD3552R_REG_ADDR_INTERFACE_CONFIG_B,
+				     AD3552R_MASK_SINGLE_INST,
+				     AD3552R_MASK_SINGLE_INST, 1);
+
 	return ret;
 }
 
@@ -198,6 +210,14 @@ static int ad3552r_hs_buffer_predisable(struct iio_dev *indio_dev)
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
 
@@ -308,6 +328,13 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
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


