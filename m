Return-Path: <linux-iio+bounces-14090-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 446CEA08DE5
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE9C3A4A4B
	for <lists+linux-iio@lfdr.de>; Fri, 10 Jan 2025 10:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D37A20C038;
	Fri, 10 Jan 2025 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ureUcsLt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7466320B215
	for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 10:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736504754; cv=none; b=NomBRIrc719zcx9qTvxqgxo32061WR5R2kENynvOlaw5EKO8azprgIfwbBvcxRLNXK7y34M5/hFWdNloAaIGpad9Dy4OyKSRxfeIPdAYlUeLI970pCbBjTvHnrTRSVf7H2ZUeMj6DQORtuEUjlBRsocxplf5+kPBMckqK3B2GN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736504754; c=relaxed/simple;
	bh=h6TjUogOr8G2ArhkLLAgjQA6se+8ftza7DkNnQZNqFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L7C7gQLZV60lwjFn5onsyv0T1vYBXpu1kEHuv7fHqH/Zo3T/Q2XVWwL2RxA4n3WJ2gM8Nz81IFPlt8HVdv/BLazHl1LSdKRq7wNSbh9cjAc4KFDTAqGyBzoMSUoy26YmF4PMnDuap7gYUcoOgNvgQdM/aISBtsdW4MDkbbWtF1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ureUcsLt; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385e1fcb0e1so1036466f8f.2
        for <linux-iio@vger.kernel.org>; Fri, 10 Jan 2025 02:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1736504751; x=1737109551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2Vf/r8AjrH4xqsFpa+mVu0wFfb25pyxBmrDXflBiTGw=;
        b=ureUcsLtcv53+kWai3Fe6HZBto+it7DL2EdmMCXr4zVJHJb8SY5sgUwhNlCyhRmvxf
         nQ1Nar1ZgdiBSXpU3e43KGyeVBsny0jKgLs4P6TtAgf2xeZkRzjD79MJnisWQSOQ09Ei
         5wSOL0DwOYWGC3apAojz61g45/g+9n610YbVV3FU0IvyDGolknlkPMNKNAZpHg1YaqFH
         7BgmMbMPhelPK3AIixEYEuqDF4J+TMUmFh0f7EiTlArML+UgtnmuCuHmmSSGJGNL6oCy
         S4HDMuvCvNkkdVkyoHqjd48pxCyiCFb+qx+Z/Xvpx7UxDAv6PL9EM3J21AaR9wt5G3S5
         KXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736504751; x=1737109551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Vf/r8AjrH4xqsFpa+mVu0wFfb25pyxBmrDXflBiTGw=;
        b=cJgAiSdvgf+D9N/BzihQf3IZlj1HhWbffwu7E+DXmY4NSMjjQHOQdYr2ExmUxgiUBa
         mXQCWN1dal1w/ETdWzvO8k8k4Sum8KNgJygP5mhBPcrfohONedAsrfN1eotv5OmSqUbi
         dwwP003EAd22SSu3aBocSu3txB+j7kPXTk4tXfjIbO7TkVNGAZHzxmbC7mRmKZVJj3o5
         tz0WZXmPvqKA4u/tCDYz7xjBq1W+HutHYt+rK3qFjinK6lWT0xvrsFlsk5DI1nh3AyVO
         855Uk7SNdskGcTS85Ljn/fBZIVqMEhj3IVpTcswSTDlshCvoATcZtOCjWPRCpOxwnlkA
         bUqg==
X-Forwarded-Encrypted: i=1; AJvYcCVlJwPGYDKselq2xr9Z22LutfouduJAf7lxLVUHKy9Ukn0xbltzvGbiRoJr+Fxo7QV3dw4c/96ItrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1zSwDlscxf5y/6eR4103Jao5di2qL58jp0dp+R5QxmrjxOvOw
	6unil1ELDK06Y70VIJbJ9zRVFiIGoA+OOATjpxj7cG1dkLHXBeRkkY1jCwImJbs=
X-Gm-Gg: ASbGncvho9752LnN9pFiOmMqapjo5yUBwQdsCQPnLnVBkyNikQfLn5KV+qYotniWhtw
	/CBB9r3rztnx0EAx4rC4zcSNqxx1hgOAsI1Nuo3Vmj/gCBLvTpn/BvHl9AAIq3Fvdc5Y7vteDtW
	PSur2GIetL3cB5rvMFSKIpSLAFxKlLRy6KxMfJHc15iNe2OFJ+OGqQv/WiZC8kKwUW6N4kImwCT
	6kArnFlviQiYanao0n+autnL1cxc2/CSN3ALNzpD4RAiPQ4Kq+DmKe5Psk=
X-Google-Smtp-Source: AGHT+IEgQfMCXod30H10ecsy4cPLhjVsKghHNktGHr/r89eUKsk5O137W3pmpAMmF8b11ri+VzGJ8Q==
X-Received: by 2002:a05:6000:2a3:b0:385:e30a:e0f7 with SMTP id ffacd0b85a97d-38a87309cedmr8799140f8f.22.1736504750816;
        Fri, 10 Jan 2025 02:25:50 -0800 (PST)
Received: from [127.0.1.1] ([87.13.70.66])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a8e37d085sm4246430f8f.13.2025.01.10.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 02:25:50 -0800 (PST)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Fri, 10 Jan 2025 11:24:15 +0100
Subject: [PATCH v3 3/9] iio: dac: adi-axi-dac: modify stream enable
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250110-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v3-3-ab42aef0d840@baylibre.com>
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

Change suggested from the AXI HDL team, modify the function
axi_dac_data_stream_enable() to check for interface busy, to avoid
possible issues when starting the stream.

Fixes: e61d7178429a ("iio: dac: adi-axi-dac: extend features")
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


