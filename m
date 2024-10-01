Return-Path: <linux-iio+bounces-9976-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BCA98C6B5
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5061C1F23D90
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CDC1CEAD0;
	Tue,  1 Oct 2024 20:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fK+AvEzj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E47C1CEAB7;
	Tue,  1 Oct 2024 20:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814101; cv=none; b=djS20nDvzlB9zcUCDtgXR+EIMKfE+O1fQrZPaEWIPEosTaPvF6OK85RStrMMzr+DB/BNSU7zPCvYh2kmAGn8rsci+81m+MKaHlE4oJBU4Meh/qz1ROQECfCCPThvrbLj1rLjnKiNCArTLt2f/C8k/wbreEtDhRI2UH5izNIvG9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814101; c=relaxed/simple;
	bh=1RsPKRPudkh/zaGzMI0PE1tFHEL/1QvupHlsrF3dUhg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JdU5lrCl72xPtI4CGrc1vrZemyacQrMPkyI+ywjG8M7OlVAVI193LAZlY7GJKIfpHvi5+lQ0s4BRYUf0xBM/NPMhdygqtzH58nqXVQNJ3nLKLsA1ZszWNeKO0Us0mMnULvB/8cFASyL/n8MAiS1hUjOVgGoeiqxfldPsDsfJD7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fK+AvEzj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42e748f78d6so49175175e9.0;
        Tue, 01 Oct 2024 13:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814098; x=1728418898; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HQ+uP1JQqGSRuWfHsOXrzhAA8JAtxqy8o2L56kWhkGk=;
        b=fK+AvEzjENxzg1Ft8xErVXYC7z9EQYl8OkwG9zY3suwPI6KvP4vJAWjhP4GIN+AeAV
         j47ifoIn6PUKcUxZyaVcdrnpciXns4Bl2tbF0nblSa1mKzYFAwc3RsSNxEFiJlxHga7Y
         JzZpvF35ffnO2YcgHEI9QU/KfXVRhQn/UucVpWr14qNVBqjrka6LTOQU/pIcCT8RL+rD
         jewXLFvHiAyPVg/q3jYPYdkaI5VKAxSDRXYE4Q0BmO3j3EYOw+Ky9IVt68ynagPlVNTu
         o6g/kRQF2xnflhFshNFbx4XtQ3m06yJrQZgos2BJs6IRuhCnPLkI3/V0Yu8gfsAbF5Ik
         J3UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814098; x=1728418898;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HQ+uP1JQqGSRuWfHsOXrzhAA8JAtxqy8o2L56kWhkGk=;
        b=AFKf/9qLCn2UWTFlv1IWrD8LjQQGJOX1OSe5k8UUpZP0ztht1n6qAKXqcnZp2Q+tOM
         8xFjp1vOFJLgrOT46DRdTmlelVK3yr/5C1vBrH09VTGhaae1W1AsrpKrnVsS509HHLkJ
         4dRs15NjLpId+gH+O3ePnOtNm5KhPwA5OfpUtWUp9+wLqAsmMzm5HFy/AxwOGhbaku9a
         QmR7Nj6BOzFRPA9NwyJQ4koIHXl9pqmqRL1buNmW/P6w63qNMuYvdkgAxLlzU21xTXxn
         eja8TKpMtVkO5dnD/1bTEdACf/E+r8g8RgzZtMLTOSsNdxo9Xj2CMrP2je4i+B5KhMs7
         g7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVCkosaQN8b4sEDIhIQKPbgOwHpTbB6P2pso7Qnkg9hAsB5zRCFes3zRsq/50IpNVMr+nk+CLtMQJEs@vger.kernel.org, AJvYcCVstSwqTuFm8YsP74WuX0wVygdvam8EnEAqEluNB4n1/OC8W8K1cMy84DLPleCZJ2GRruZCFnySMcyvSP+y@vger.kernel.org
X-Gm-Message-State: AOJu0YyJg8Ez6+KHEJVzn5yKU63T2n6g4dAFUXwkeiD4vEE3VDdpviWN
	foBGBKasvqw+D4BIfO5ibkDrX7afgiJZfcFVnppdoY5pRiEJNCPAVVroeHT6
X-Google-Smtp-Source: AGHT+IFsujAGwiUtUHctuq+0EM9Xdx6DX2hDtMlZsKqnFg8nTqRKzW2D4s5UbK8ECKth4OzdMROs4g==
X-Received: by 2002:a05:600c:4e8f:b0:428:1608:831e with SMTP id 5b1f17b1804b1-42f777ec6d4mr5592935e9.22.1727814098129;
        Tue, 01 Oct 2024 13:21:38 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:35 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:14 +0200
Subject: [PATCH v3 1/9] iio: light: veml6030: add set up delay after any
 power on sequence
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-1-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=1605;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=1RsPKRPudkh/zaGzMI0PE1tFHEL/1QvupHlsrF3dUhg=;
 b=wqn1lmrcPFug9Cyt7s5wSPx4GBCU0Kq1i9cZsfQ9n3LeReOEdT8Yz+IrAaQt1+l1lWdpv6mGO
 Zv9MCLoiJsXBtNIE/+SanrtYVh0kVdYolvu0iYRomS9/pu9NP2T6fCD
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The veml6030 requires a delay of 4 ms after activating the sensor. That
is done correctly during the hw initialization, but it's missing after
resuming.

Move the delay to the power on function to make sure that it is always
observerd. When at it, use fsleep() instead of usleep_range() as such a
narrow range is not required.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index 4c436c5e0787..94e38a983cf3 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -144,8 +144,17 @@ static const struct attribute_group veml6030_event_attr_group = {
 
 static int veml6030_als_pwr_on(struct veml6030_data *data)
 {
-	return regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
-				 VEML6030_ALS_SD);
+	int ret;
+
+	ret = regmap_clear_bits(data->regmap, VEML6030_REG_ALS_CONF,
+				VEML6030_ALS_SD);
+	if (ret)
+		return ret;
+
+	/* Wait 4 ms to let processor & oscillator start correctly */
+	fsleep(4000);
+
+	return 0;
 }
 
 static int veml6030_als_shut_down(struct veml6030_data *data)
@@ -767,9 +776,6 @@ static int veml6030_hw_init(struct iio_dev *indio_dev)
 		return ret;
 	}
 
-	/* Wait 4 ms to let processor & oscillator start correctly */
-	usleep_range(4000, 4002);
-
 	/* Clear stale interrupt status bits if any during start */
 	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
 	if (ret < 0) {

-- 
2.43.0


