Return-Path: <linux-iio+bounces-17711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1A7A7D00F
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 22:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24B0818880F4
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4C51B3934;
	Sun,  6 Apr 2025 20:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="do0g/yUD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A411A3172
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 20:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743969714; cv=none; b=Xs25qUtmSHr80JMjkO4w+Sc9Vfb+b2yqHCMo/bRqyny29HVmrlK1KecRZPaCwLrYRgAWA1RmSmW6DGEqf/t0Kuwyr+eIYar3hYIaYC1fMQps1JnQBE4wmvxjjCR24yZ0WpwkDYxvFybMPaotvTzT0EnJq4KZt8OYurIH82XD0Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743969714; c=relaxed/simple;
	bh=JTR/P3EkGZofvJK08o84UvnirFpKqEhg8gq395B9I70=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gCoMjgyGFSGhRnvpiYYI2yUrOao+IqtBhSNKFij5p4NDz+PF+WgWjYExVvWOhep8peaBIDfpzZF27ZJv4LGKzpaHUpGqKU5TnCth4eE/+121Lh1HvdMyjdjA+NLywOuxJ78FjWaPJbCIaxfVyAo2+ttLPDHHHp5HXGj/v3ypZM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=do0g/yUD; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3978ef9a778so503648f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 06 Apr 2025 13:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743969710; x=1744574510; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWlwiQDg0h2Z8rmTGPwySdCuGsBToV5oB+DTAJXaZkw=;
        b=do0g/yUDNfeJzZ5wYBFfoutJcxGWBxO/csMx0pdt0eEc8UK9B+IgqFY4nw+qR6E8Bi
         sPDFcwZQQDDsmCO9T3yVWzlKGA8qujuDQnfRAUvfCWy6BjegurzWmscAU3cNBcYPM0hM
         fQrz6ticrK9iJdPVXRNTV5KgTh5/Zkh1kJgwabKi+/4rLqCx6zAEqnAutkI7oi/oXC4J
         oj5jKoNq4MQbFh0DMarSRkq9BZ62C8WTKBRlUwmbQ19dpH4PwXc0zWBVyr8JeCTT+Wvq
         pWLM1VGGCRlPjp5XKPi1McHg2SjAdbPAin82IpNRJYMWuAw0T7m6WJ1mU0iyDAPPxCES
         s29w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743969710; x=1744574510;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oWlwiQDg0h2Z8rmTGPwySdCuGsBToV5oB+DTAJXaZkw=;
        b=LiU3gSgFYJC6y7eD0/c5vQrkJuq9FqRatbvXRlTQyZAhUvutTkdGTGOIsEO8u3rgHt
         nDvSS8r2BgYQtdcM4Oiy6W95VrkozVeo8/IJWD8Cm5QPErDDNIICtOfTzcBmdQgfhkwX
         KYzcDFtXGwmUW5Fd4QtO0MJAF1dvZ8I1EDfMwUEutqib5N1dfp3yjVz8h6Rit1UW9/Ex
         h6H5pUhishtAFxxkchzSs3dNtM0f5mVcLs8T2lQWvcrGgOjvYywGFS78/+PAgaBjLJjk
         8I/ipFNqpPVz/k877YFhgOE71DTPPT4/l1NMHu3WJ+JNak/55CfG9Yb0jZTHc0l2Vtt+
         4xSQ==
X-Gm-Message-State: AOJu0YyEeRKlLttTHfscinfchEOa1rcu8UNzG6SpRGytYjMh3chGNRJV
	dTF4WEJiV10LutgNhd72BdFVBFcvNlVsDk/SwmK9IC89cqv/E7c5pTuFKeM/hgNLieyZ+xHUemL
	0
X-Gm-Gg: ASbGnct7FWkWzwPESgi/S7df9CAJ9S2SHzNdl11FkvLCHWqVgOihWBsKBFXFo+Ktd27
	AdhRlTsvwFwrPeOK2J6sRr1B/7zbP7kITNiNgEVoW4QsXQfxLv9XpL95i/SDebzU+WK26hAjugq
	qbnD7cpP3rOAKzACPsQfd09PHZOJzxKbxjKw7400nV/WXP+3sAeZKxf3FGFMlrxYhYuarbisprl
	aq7GrRKohEDeud7qQC4hxyPTjgr4YJzX/eSKGGnVW69L7I5twzOM2AcSxaSF45la4dGnS1gufFG
	Vg/2Mf0K/ohvclOYo3QF7wBIbYP6EclaV29VNHitkzzqXavc4w2sTxDY18m+uCw=
X-Google-Smtp-Source: AGHT+IEZjB4MI6wC9+JoB/jO2g6h/C6OH9uFv3PiHq9NZtSTSQkamc0Yiv5WCgkk3m3FLqGD4ixTkg==
X-Received: by 2002:a05:600c:a4d:b0:43d:fa5d:2675 with SMTP id 5b1f17b1804b1-43ecfa5aa44mr35392475e9.9.1743969710316;
        Sun, 06 Apr 2025 13:01:50 -0700 (PDT)
Received: from [192.168.1.26] ([178.197.198.86])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c3020d98bsm10199924f8f.76.2025.04.06.13.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Apr 2025 13:01:49 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Sun, 06 Apr 2025 22:01:42 +0200
Subject: [PATCH 1/3] iio: accel: fxls8962af: Fix wakeup source leaks on
 device unbind
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250406-b4-device-wakeup-leak-iio-v1-1-2d7d322a4a93@linaro.org>
References: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
In-Reply-To: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1010;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JTR/P3EkGZofvJK08o84UvnirFpKqEhg8gq395B9I70=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBn8t2pUcGp11KcDBPbWINpnXNq1f8z1KQg5S0km
 HZ67mDWZfSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZ/LdqQAKCRDBN2bmhouD
 1zfEEACYo6+sMdke/FBBVYQRLHP+qNj5MfxwUFwuDCgH6dBgvPzD2DljR4eYT8v6/qxOcAafsEn
 FsLSPN+2ZqX9U2sAvePioblX5EhBn9chywso3k9ISsHhcdzxKFQcAS7KUM0HbEB8KWmh5FX1ijH
 HfFUlNK9uSE57jw19nRFYFNnAlA4VlXbtQzubeYiSz2hoRXwDu2V+TkssQ/AlW/yKgaz9tP9tjx
 7FCeXeKJpybmwbA2+kw8cGkA33x8lZgd7U2CwdFOjQ8uxL+ZDmypk3ck49VrXtl0c3i3WfDbWWt
 6pWYHQ4grirBQkBRquN6tRjpvpuG0oLmCKT3YwB8xUB0IJY6BlIvdH8rUPKvvKvOKtJUFHmAPtD
 VpGC3gnzoxM8xR+1X5Bq21KS2HVEnF/Y3XqUe1tcnuthYcbv2auhMRm3AdL8lhHafCLOnJvcikW
 vKHsZSCoo5POCsUGj077F68cJnw+FgKa1YIKKlYLMD9io2sh+5kfbnsuG/9wpXAzV3QkWC3iwgD
 goADtSNKF38JVatHDTbPnG449E24D7M/36949/OQRZG6KTOGVbwntV7Y5adgS5qDmImDsZ2pIKt
 k6mLLfhfkpnsIH3ybYQeetcsBtNkEomPfz5/fFgxgrGC2v27gAZ8ygJTOd1EDEuFst6medTHKoX
 jlevVgAf+BBUVXw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Device can be unbound, so driver must also release memory for the wakeup
source.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/iio/accel/fxls8962af-core.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/fxls8962af-core.c b/drivers/iio/accel/fxls8962af-core.c
index 48e4282964a0698d422df49739365648e19bdef6..bf1d3923a181798a1c884ee08b62d86ab5aed26f 100644
--- a/drivers/iio/accel/fxls8962af-core.c
+++ b/drivers/iio/accel/fxls8962af-core.c
@@ -1226,8 +1226,11 @@ int fxls8962af_core_probe(struct device *dev, struct regmap *regmap, int irq)
 	if (ret)
 		return ret;
 
-	if (device_property_read_bool(dev, "wakeup-source"))
-		device_init_wakeup(dev, true);
+	if (device_property_read_bool(dev, "wakeup-source")) {
+		ret = devm_device_init_wakeup(dev);
+		if (ret)
+			return dev_err_probe(dev, ret, "Failed to init wakeup\n");
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }

-- 
2.45.2


