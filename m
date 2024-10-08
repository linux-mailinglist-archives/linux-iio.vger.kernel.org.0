Return-Path: <linux-iio+bounces-10334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBFAF99539A
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19FF41C25702
	for <lists+linux-iio@lfdr.de>; Tue,  8 Oct 2024 15:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FF171E0DCB;
	Tue,  8 Oct 2024 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2aQEEhzN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACA11E0B8B
	for <linux-iio@vger.kernel.org>; Tue,  8 Oct 2024 15:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728402305; cv=none; b=o3bz6nd/xM4yc82YZJJKaiqw4tbPTwXd9UzWcYpo1foHmWYUAKo/KbzlS1hRPHH8rAk+HRHQ+Z3vjob8EXo1CtkVzp4ugztJACBbU2/q2eNXmxDV8fbMBaRpT6MGbm9U4ST+lYxlIVl7EeN71keYQWNDPYLajohB62UaO6oXwsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728402305; c=relaxed/simple;
	bh=oVBsJqn/AvE56D2S6kVn7RApm8mO3KrtDZZVK89hK7M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+4/dLoqv1SHdKR1cwIytM5aEk2lH0eEPvbcP3D96GpHIi+vrc4ebxdjua+BKT6kzMfKm09Oyj+32rpwY8TBuYw1z8S1T8Nakq3mphrpoK5KcipG/zeCDE0Vp4MmKGmClChvdo18oAvm3B78PQhaSKHM/mmli0m4sOsz2WV++A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2aQEEhzN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-430576ff251so3220225e9.0
        for <linux-iio@vger.kernel.org>; Tue, 08 Oct 2024 08:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1728402301; x=1729007101; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bbelPJURc0Qo14/gAixY0bohF8WhC7LFbvL3eTZ4rd4=;
        b=2aQEEhzNVnzaUEdGYgis+pG4lV+KnujMXXvqo/L/8g98ofHm1R/mkKyjt4SlFHpSkJ
         erV6W220X1GvcHoxM3x6vxsLKyJHBfeNQfp47vUfKlBk/hQ5KQjQ+Zx5+ZlpG5yJQ0UD
         ad0kgSbmia3g9i8UbtZeV8FANC8DOgtX1pMBv2vgBQMTExf7vop18sprRo1wpNcHKvAh
         ORy43Uf0nTRuW+URhdJGprh0lePiWT7hNy0szvOlwEGNgeHvYWdk7Ss9cihLds8kFaU8
         Ff+Njr56e3xVLYUxAQUxWcAGvhHuFHwy4aLXF1B5+1Coe6w0LS703V3aQrAX9Wik9am8
         imKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728402301; x=1729007101;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbelPJURc0Qo14/gAixY0bohF8WhC7LFbvL3eTZ4rd4=;
        b=JQ9Vaq2XmeKwmTyiXz3bNlYb4GOt9fG0/8jzdnOh7yKouiXuB0z3Vd8XJemMpIFVR5
         1Zo6wmKQ25FxWTAINvHhHI6HALzyYH2jRbqhVAXHpJDVPBxdZDhFDXjmzXyC7rMcysvu
         4IppF8oQWvu6jzE9T9ge6np+80NfPfv+dHrzKtxipj/Xh5HTDiD/5Qj+deDEUXdSHedd
         iH+5bEsgEblwRwpK5NE7P88qsZlYEskgb6ikUSFr2yTe3Z14ULUT/n+BbEts95GwoLlv
         foIYZtllGufE8P14zxtpaxdzSSdVoUWEgRxGHG//6LWp1rmuoddCtyF/sCt5kFGFQfTF
         qn1g==
X-Forwarded-Encrypted: i=1; AJvYcCUkvV4XEbvXiU93ux8o5qR9HbMEWBzG1Qi5TUwMsA3bRflsEIbuYIqcjKL5n9Qf2S0d2zWrhbpJoDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YySjyK0pknRC38F76E5kxrUULP4Q6FP6d6KZPW5BvKVTPX3klDf
	PC9k0elPTrUe7TKUt/s/0fw3ZTKdaU1K6f5ynrTWcsPTRnph5RPEPWuVuPgsfWY=
X-Google-Smtp-Source: AGHT+IFOq9JRDmt8Gehc04UjC3HBBxMR6du/qX+O5gNpNaBTqBviThtjoi8LjMjD/1TypknrJQ7wbA==
X-Received: by 2002:a05:600c:198c:b0:42c:bdb0:c61e with SMTP id 5b1f17b1804b1-42f85aae2damr127558255e9.13.1728402301418;
        Tue, 08 Oct 2024 08:45:01 -0700 (PDT)
Received: from [127.0.1.1] (host-79-54-25-3.retail.telecomitalia.it. [79.54.25.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f86b1d826sm129591215e9.26.2024.10.08.08.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 08:45:00 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 08 Oct 2024 17:43:33 +0200
Subject: [PATCH v5 01/10] iio: dac: adi-axi-dac: fix wrong register
 bitfield
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-1-3d410944a63d@baylibre.com>
References: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
In-Reply-To: <20241008-wip-bl-ad3552r-axi-v0-iio-testing-v5-0-3d410944a63d@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, dletchner@baylibre.com, 
 Mark Brown <broonie@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.1

From: Angelo Dureghello <adureghello@baylibre.com>

Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.

Both generic DAC and ad3552r DAC IPs docs are reporting
bit 5 for it.

Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
Cc: stable@vger.kernel.org
Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>
---
 drivers/iio/dac/adi-axi-dac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
index 0cb00f3bec04..b8b4171b8043 100644
--- a/drivers/iio/dac/adi-axi-dac.c
+++ b/drivers/iio/dac/adi-axi-dac.c
@@ -46,7 +46,7 @@
 #define AXI_DAC_REG_CNTRL_1		0x0044
 #define   AXI_DAC_SYNC			BIT(0)
 #define AXI_DAC_REG_CNTRL_2		0x0048
-#define	  ADI_DAC_R1_MODE		BIT(4)
+#define	  ADI_DAC_R1_MODE		BIT(5)
 #define AXI_DAC_DRP_STATUS		0x0074
 #define   AXI_DAC_DRP_LOCKED		BIT(17)
 /* DAC Channel controls */

-- 
2.45.0.rc1


