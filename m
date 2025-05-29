Return-Path: <linux-iio+bounces-20001-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE82AC7ADC
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 11:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7769F4E5DBB
	for <lists+linux-iio@lfdr.de>; Thu, 29 May 2025 09:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCE321CC56;
	Thu, 29 May 2025 09:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="nJ+C3pL8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100A21ADD3
	for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 09:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748510163; cv=none; b=sqrivav/nah2nPiXSpgu5/zAL+ydQzTVbnAN6EwrlYGiVcSa6bo1665dHv/0imH7HKu/8UPODpzrXa0Kh3KURJm0yt7RSNT4UOzlqf8jfSQhjCr0pfmXhTUzaxRddfa9XX9OXGot0o5B0K8U6Y52re4WjrnSl/bNgp5t/uaB0lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748510163; c=relaxed/simple;
	bh=FOI2NlElQUAvYF3wBUa5TZiP2fxcwdHOkRWmLHfzir0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iQxwdgQSilMRajzwuwyi/+bATAiyMo3rOMe6MzfOTYv8yPjvp5wDHkGiNe54/B+mIkygHDNjMP8vkjzSblnYamduV+fd+i4nEIhNRt55PnSDNC10QUjp678RvGxeS0gFnwInrlsXjdcOeTffsng6nJJP4ElQ6b9uW2HQqeLvD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=nJ+C3pL8; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3a37d24e607so649983f8f.1
        for <linux-iio@vger.kernel.org>; Thu, 29 May 2025 02:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748510160; x=1749114960; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5KgxFGK8GpAJ4dN8Kp0qrb4U0fnu5EDWu0pgs+B0vI=;
        b=nJ+C3pL8OBAz5SnztXa0tT0fFl/S+zdUtlqDK1HAH7mMFhIdsNtFVjJwIkgJMbHg96
         dVpqurTypg8v5bI3NmCrWYbFnc+9aRIW2yyq+UkW3gy1I5LJWAr9SRhebbOa2eG/yAoH
         p/pT/6drv9rTy3FXPHajSWVW4A6b/zNUd/LKA2yunGTe7JBBOrw2th0s7fcel3XakaRy
         GkrDPE03ck+Cyn07znwf519tlnLcSzJJOiBchNeCl2p2+dzYl0ZVi5wmToY+QZWQpSKa
         W7SxroGHZZicxowTvCudJcgSUiRVNTHs9uZTj5PWXdwP1hlnuas5WeEZ+CAucsAKIAYR
         D8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748510160; x=1749114960;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5KgxFGK8GpAJ4dN8Kp0qrb4U0fnu5EDWu0pgs+B0vI=;
        b=xOJzSEAiM1SJgmsPkKU3uofUZ9LB4ieXb5Tykto2fhqHWUxHAB54+tjAYoA3DcEE8k
         2p7IqOtrywRNn1sZPMcntibnvosxsMJdgNh/jaRNOQhu3UZ9unrYNtJmsJcrH4VSlrwM
         JDklKbdg9CDxD4JhFkzSyUYW+wjKr6/LaBFFMGxuqT8VNd3CGXYa0uQVci0Y+0a4mfnS
         96BuaPJU3+niFVdNXscNKNgXut985oMOhBBbCilinIkbit2toNMMqgbxE2hnZ7vTQciM
         1ocNx2qRZp5ET0wfW0MV4an2ho2bzspmYGkood/WsVHRQu2Uc4JL60JK8wPphjLb00Vu
         KAPg==
X-Gm-Message-State: AOJu0YzrkCQBiBF4grW+V/juJGBl6TmVaZmzSUlujBjbQW/9rv38r9Et
	1OkvEvS0XPN9eA+8es4uuBC+GBlDz1hNgf+unwKLHBJqhOsCCXEqe0LTiGD4HSLIxmU=
X-Gm-Gg: ASbGncuIfR4s8ypKE7BV3JpJiUw3Lo57yNSAItBjZkFfrM3sdIELsuargmwDfoYHBBR
	P2e6msCdSz7k1o6doLTLdwZz136X6vzhbLnet5lnLij/Xg3R5i7UH+a9ZGu+K7yinVC2AZUULqJ
	sq2kPxEPTIShPQCHV8u2gYb+WSSiY1Ob9sqWADqyzqB418H7wLn0EIupDdQ68Fl7pWXKuC6z/wf
	fRLtKNXH0btlt905+5i/f4S6HVZANeZetdEW4Gs5nSIl+c/rbSDOajroQRnlZd57h9USPvwAQm5
	XX/gibRaXU1Bvgxf2SgAEaMpjRX3PmMQFqQ7zP/V3sjPjNtklZR/6kemUsAk7NmUusRzhrSlWnh
	4sGtYxtNSKvbwKtZ6FlBuX0mXU8jaQz4=
X-Google-Smtp-Source: AGHT+IEyGk5YUyGC2CgIHlQGEHVMKaTiSTSLXFk2d+0PJbxOk/oSmluEgZeTda147DVczcWuAAeLSQ==
X-Received: by 2002:a05:6000:26d1:b0:3a3:6f26:5816 with SMTP id ffacd0b85a97d-3a4cb489a52mr17871249f8f.36.1748510160104;
        Thu, 29 May 2025 02:16:00 -0700 (PDT)
Received: from [192.168.0.2] (host-80-116-51-117.retail.telecomitalia.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450cfc348bdsm14318475e9.33.2025.05.29.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 02:15:59 -0700 (PDT)
From: Angelo Dureghello <adureghello@baylibre.com>
X-Google-Original-From: Angelo Dureghello <adureghello@baylibre.org>
Date: Thu, 29 May 2025 11:13:55 +0200
Subject: [PATCH 2/2] iio: adc: ad7606: add enabling of optional Vrefin
 voltage
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250529-wip-bl-ad7606-reference-voltages-v1-2-9b8f16ef0f20@baylibre.com>
References: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
In-Reply-To: <20250529-wip-bl-ad7606-reference-voltages-v1-0-9b8f16ef0f20@baylibre.com>
To: Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Angelo Dureghello <adureghello@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=937;
 i=adureghello@baylibre.com; h=from:subject:message-id;
 bh=mPtkuRFlIF9kUIg6RF/x8q8TWHnV0+cp5WDL4t37AOI=;
 b=owGbwMvMwCXGf3bn1e/btlsznlZLYsiwUK3qFjppZ/5afINoCt8607Udqbb/M/9VTI6f9eaTs
 VT0voetHaUsDGJcDLJiiix1iREmobdDpZQXMM6GmcPKBDKEgYtTACZSqcXIMN9z8fyJvFZ3DqvV
 HP1wo37dGkG+GbFudSpz9xy+fORVCTPD/6Rj4QyGH39t8O+xPnXE7bPZOam/SoVsZ5YLr2uu8H3
 2kxMA
X-Developer-Key: i=adureghello@baylibre.com; a=openpgp;
 fpr=703CDFAD8B573EB00850E38366D1CB9419AF3953

From: Angelo Dureghello <adureghello@baylibre.com>

Add optional refin voltage enabling. The property "refin-supply" is
already available and optional in the current fdt dt_schema.

Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
---
 drivers/iio/adc/ad7606.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
index 3bbe9c05b5edbc11e8016c995c6ab64104836e7b..21e63260965c32988d0ab3b8bb1201aa2396f1ba 100644
--- a/drivers/iio/adc/ad7606.c
+++ b/drivers/iio/adc/ad7606.c
@@ -1335,6 +1335,10 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
 		return dev_err_probe(dev, ret,
 				     "Failed to enable Vdrive supply\n");
 
+	ret = devm_regulator_get_enable_optional(dev, "refin");
+	if (ret < 0 && ret != -ENODEV)
+		return dev_err_probe(dev, ret, "failed to get refin voltage\n");
+
 	st->chip_info = chip_info;
 
 	if (st->chip_info->oversampling_num) {

-- 
2.49.0


