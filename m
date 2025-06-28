Return-Path: <linux-iio+bounces-21056-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EEB0AEC8C1
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:24:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FC033BAE2D
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3262724E01D;
	Sat, 28 Jun 2025 16:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ALMgVroO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9F321ABD5
	for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 16:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751127850; cv=none; b=Na43FswQWedW1LlVQ9bjGXA8NpZ9ct+eeH2LBg3s3rh24Kmd1mwNsAfplxqABe6gyZTldJMpyCCE901rC24GrWX0q5h1TOL2wsEA9E8OXqGs7VDadCqNZZJ8t2G8zwDcNUlcgsVlUPpOygbl1eDXJzT7NrtQuzjwKCyJnMY+yv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751127850; c=relaxed/simple;
	bh=iSuKG7xL2zIezZJqs/0EKGkbrvM3Fcaivu1h0EFXMc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pUh8mNt8tCrjq2D+MO3F2rRI7zdYNCjZg50Ts4u63JlXhV4zi06PIca5q00wvMyjYgUt8+hUan0q9xLwXyD8yJB9DhdNsjN2MeA/OR8aTVaIpBxJ46QdjrCgXa0HusDEe/7deUrulQUqcZz78ucajzDjnI0VdZJ8TZlfIzQItM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ALMgVroO; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-735a8be4ea9so205716a34.0
        for <linux-iio@vger.kernel.org>; Sat, 28 Jun 2025 09:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751127846; x=1751732646; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yuKegAJTNFPwTx2zM1+MlH9dZNraCGO8/+n0iphX90=;
        b=ALMgVroO8tuounSQy5JeHXxljzn7sFmhN9HeO515TJv9RQ3VPXtvOL13A34qILV0mO
         05LBtfoSmU6CcRRqDxAFZXQI1Ppc0oL/JceECUWbdMu1Z5AAMALWXwxG8nJsBgkumoq+
         tQMDsnroinBEB/kLa4Z1qjE4hUcIj3b0Jdcuyki13omJOc+f1RmdBZs/NzTCaNy9zrNk
         hWi/pBNORJfrD7cXtAF+2i/AuOtqDGBsRkNHZr7dPSUnakJZnb8D1hLPc/V1nCijJyLK
         TY84mSO0xaNIpFMachzfdLLXpdbHUoAPdSltCfMnUzKIlHN6/yoxx9qX2E6PRqYT6/j5
         Fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751127846; x=1751732646;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yuKegAJTNFPwTx2zM1+MlH9dZNraCGO8/+n0iphX90=;
        b=qEJxoGpVPqTUNM5rtM+jGl4HnXPr+hRjwaUHtkkZmdl2je4nSNY5xsvaMfw6ZVgb/3
         D6Ia5lVC18dpoQvCIhDaLT4jTrV/w61htwJreF8EfSp1gehQ0u4EziJDRFQd4IAkNUC+
         UZc3NHzUlNNRMKCtw7gIhXk+DqcUtRlUwJninvkgiE5+o+xpoYCFEJc9b2kzQp0M3rlm
         coIy3xlOulaid/0UyRITDYLyY0whrEcY8cgGjkWxC/XR3R/cU3XB1N7+wFg0QfpNhx+R
         VPj6+CIxw5TZ3eeslL+HMk6T6fR84jxdxrSZHiiUa9z7Js+jwjZ2V+Rp/CLsdtmAxGJw
         2E7w==
X-Gm-Message-State: AOJu0YxdKSNQZ7ev7UKh0XI6rkiRLWssk52H6vLURuZcrVcppms21cSS
	xzVTW+3bCI/LbHvQl4GonjJ+33Jl7W6qEpVF8KlF74ufpMyvuadEWBb8U5x9+0JQfi0=
X-Gm-Gg: ASbGncskzF9k7m1g26tA4U0qvdiclTYk/cWb0TnecZtAwlbB95DBa7WH9rvpi4Tnyyc
	wPq9691KOXQp4Q0MjRBNSzd5ED8uil2VrOZwM4sv4kOyS96S1wz/FTW0Uuh3/9Lwvexbzr5MRjc
	MmmBVDQJ39JNZZaweETUkijVlDyZ78/ZeFj0KGKAxsX9u8bpDWb1LkDzDsem47cp2AN+ztLCXbK
	lyTZe2+6N4C8iorz4ouVrluWGkYCWdxIsZqgjdo1HUPyAJhe8qDIwXY5AYfjWKh0ELBzJ/Sd9pj
	3/buwfCx9eGy3ibByQCkyuA42NL78UfHdWioTjXda9p/VLMHwTHrFm4sNWjr82PTCDC4
X-Google-Smtp-Source: AGHT+IGAW8XE14JUAf7URTWbLPcZB7/JZuexxwy/URYcCIHgFODS5hHe9mSTinxMdULMOojQAonKAw==
X-Received: by 2002:a05:6830:8313:b0:72b:9387:84b2 with SMTP id 46e09a7af769-73afc6d80f0mr3504117a34.27.1751127846497;
        Sat, 28 Jun 2025 09:24:06 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:3092:a48c:b0c6:cbf4])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb1039absm855991a34.54.2025.06.28.09.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 09:24:06 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Sat, 28 Jun 2025 11:23:58 -0500
Subject: [PATCH] iio: adc: axp20x_adc: make axp717_maps const
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250628-iio-const-data-7-v1-1-10008d0a4c2f@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAB0XYGgC/x3MQQqAIBBA0avErBvIgSy6SrQwHWs2GioRhHdPW
 r7F/y9kTsIZlu6FxLdkiaFB9R3Y04SDUVwz0EDjoGlGkYg2hlzQmWJwQs2kxp3Ik52hZVdiL8+
 /XLdaP+flPnRiAAAA
X-Change-ID: 20250628-iio-const-data-7-6e215b22f2c8
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=932; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=iSuKG7xL2zIezZJqs/0EKGkbrvM3Fcaivu1h0EFXMc0=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBoYBcfbXR51chamZ2IFLxR7M7daW3f13e2eQJAL
 cSD2p5djomJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaGAXHwAKCRDCzCAB/wGP
 wMJ4B/sGUijDkVBUfBlSZ8LPrc5ujx/fUsRLrv5MsOFLd5kzy74ki4ZrnU6Rx2Ap4h3l1HnHmys
 Iiu4o8MYC4H8alH/pV0U9FpWFa+5rRMEoDSlPG+ViwaYVGvkXXCkPf+zpekCxVqSU6IE2YV4GYU
 WY+WAno9MC84xk8382hIf9u7yGVgZUF/h0yHPi718+XxnQkWaVII0RzbLXDWMxtc0zHOLpWCzHP
 aIgmUqUZsZGMUkhany0sEV+T7U/XuQx04xgAzW+hTqC2RrYB0ZIyxacuyvTzEC+JHuz/jUWNA6f
 XbU533Z65qHZvZbNIlIXsSa64XBFTRjC7pHbAq6JvT3wO5+x
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add const qualifier to struct iio_map axp717_maps[]. This is read-only
data so it can be made const.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/axp20x_adc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 71584ffd36324800e23945df7984ac98ba88b793..bb290b5ee92d211f12bbb2a4b8f0dda87e09f4c5 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -173,7 +173,7 @@ static const struct iio_map axp22x_maps[] = {
 	{ }
 };
 
-static struct iio_map axp717_maps[] = {
+static const struct iio_map axp717_maps[] = {
 	{
 		.consumer_dev_name = "axp20x-usb-power-supply",
 		.consumer_channel = "vbus_v",

---
base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
change-id: 20250628-iio-const-data-7-6e215b22f2c8

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


