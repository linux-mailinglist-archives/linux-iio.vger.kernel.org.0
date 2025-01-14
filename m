Return-Path: <linux-iio+bounces-14358-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB22A10AE6
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 16:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B42F23A93B7
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 15:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1C21474A2;
	Tue, 14 Jan 2025 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="EghShoJj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119A31B6556
	for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 15:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868713; cv=none; b=eik2ivkW54r6jeBgKIYukNj5Q54F8uDK3Jq3eU8QDb33MqAEvmt1wB0Ms7AR2e1uiIl4dPp5gRG802pKjFuYzP5508vP03Xq9gj22BL038NrzAhgDFQcNZHLoAL0QxDUkZYreMRR4fjjM2hCIVXWDkihokU8bxGe2t4MYtDre2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868713; c=relaxed/simple;
	bh=FGkqYiXXh/+bxSWU1J+RITwSb7AerkurSv9AeODl+PE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=abCugnRKU5ePqZh27BYulB0qnaZP2/31Xc8x0LHjYcpE79yHw2I3y2UROOpW3Z8qduh30kwBY1qsuyMBIaH5PChSaoRwG3tIqANHQmp8eSq1dB/pbC1puzeNMiT334nuGmsRP76QX3J/wE33sOCNDa2ayyZOZyCWXTrCiXEqX+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=EghShoJj; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385de59c1a0so2792465f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 14 Jan 2025 07:31:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736868710; x=1737473510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y9+dDQA2ZUdP/rTzes45J+HZpWx/w4e6GLVk9fKNwPA=;
        b=EghShoJjZC7n83byKz4XC64Hw+55eaDPWS7WLznth07smLO993wqkD1BymhlnNPf47
         ZXPsKdcF5TUIge0xRwITHGashAAM9fiM3+A/p6K1JzN76xBSD9lyzCQetYAfaBQh7Aiv
         fO2OEICszkf5SRzr/0X6N8odUxId2sv5sVi6jhOYRvuK6Xc5SD4l/t/+QxMUeTM9157K
         hI0/Q+xBVo0t6iHtqvM9aAHHgs3VOi/ty814uwj/pYiyKcI+o8kqui1VmfdLoy0UoC88
         AS2u29O3SPK9NAHEsN2Tib8K3glq5EFetRpqEVRgnA3Lqcj5WQAlKR0IQtt7MW/qYNEI
         /GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868710; x=1737473510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y9+dDQA2ZUdP/rTzes45J+HZpWx/w4e6GLVk9fKNwPA=;
        b=aXHH39ZnPzbgtqViXlHexBlERRzdip6RaQqXFmi+4mBQncGOTW0G/jLn8WsNdSBXRi
         D1lljBXuFZen4rMRwbzYegaYMBTOjia0zXma7n5C8P6yykLVfA2pVfv/IXNBcElAgoj5
         LIBi9emjRgCqGafVYx+crPljxc6MCfVIbT/U0ah6HwyVv+qFgm8QhXIoe/4nk2dA46W+
         wo2C1CVczvy7gA+YmmgPCw6eVhYfqXyCEoh3t1feSLp6NW/4cAQbbqSOZbR82mBKB1HB
         KDoMXxm11N8rolG+nCRja/ND7gBKna3B/vDnn7MVcEYIKAa5fbgFSnSQsVLyfcdRF9Ty
         3KGg==
X-Forwarded-Encrypted: i=1; AJvYcCXigwS0fplQIgE90ob0/ttQpYd0PmK+plK+obmNsfjPv9R53CrYGq/K52+rLgE/hRS+ASSIz7vDVEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YynkgQbs9vajjCB+BQr7vNMdBVYnIIxN4sFxtd5GL+OBagRc/ET
	F6HtxhRmeouztNNBSbVP4c283zTOnoIHLH6dBm/7cYDPRRI6oiBoA2qQRpZpBNc=
X-Gm-Gg: ASbGncv6VsLHvFZPkOtihGlB3UoVW5sMTOkI5ghRMg7wx2sVYFyPLutxmtVHdPPkOZW
	pHG+JPOOaqwXLUSzut9er4itKa4sdaVPIFUmItG30JRtTy2M+KPcmpTGrqhGaGghfQzAiuCdNx0
	smna3YO7QbENJsj40o8GwrT1CSTNNCCYebQddjYt/E0Bn5u3MaUyKWS0gqYUQN6K+xn8zhFAMoX
	JiSxe3/LYOIQkwLMc+5YM/aHlZXaRJtn0UWlj2pcsq/jVlStIiZ5OTLD+c=
X-Google-Smtp-Source: AGHT+IH7AnS8Xy0AvaKh32AoS3bdK4ykrox2/qO5FDmQaEgt2abKbZj4t9TCxwZlk0zyzle/K0RGGA==
X-Received: by 2002:a5d:6d83:0:b0:386:3864:5cf2 with SMTP id ffacd0b85a97d-38a8730497dmr19668664f8f.19.1736868710473;
        Tue, 14 Jan 2025 07:31:50 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e4b8116sm15049907f8f.79.2025.01.14.07.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:31:49 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Tue, 14 Jan 2025 16:30:14 +0100
Subject: [PATCH v4 5/9] iio: dac: ad3552r-hs: fix message on wrong chip id
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250114-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v4-5-979402e33545@baylibre.com>
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

Set a better info message on wrong chip id, fixing the expected value as
read from the info struct.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 8974df625670..6bf995b50395 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
 
 	id |= val << 8;
 	if (id != st->model_data->chip_id)
-		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
-			 AD3552R_ID, id);
+		dev_warn(st->dev,
+			 "chip ID mismatch, detected 0x%x but expected 0x%x\n",
+			 id, st->model_data->chip_id);
 
 	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
 	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,

-- 
2.47.0


