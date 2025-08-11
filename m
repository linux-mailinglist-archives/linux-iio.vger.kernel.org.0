Return-Path: <linux-iio+bounces-22592-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C47B21474
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 20:32:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7F611893D03
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91822E2850;
	Mon, 11 Aug 2025 18:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VCQ9hLQN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6A82D47F1
	for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 18:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754937166; cv=none; b=Zed24Qo02EL2O69boBFD+wI7d78/q/5CiMStV+YwYItPv7cNrOsJOo2Q4TMgFA9Ds/BymxzGP8Oen9u2/sUi3ntHsBExtH8nZnq3gl230idYew6yMwmc4OzmVcIJ/fH05UcTbS1mXo7o09Tt+pcpxn3SXKltDm1PSWkT+h0Xc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754937166; c=relaxed/simple;
	bh=i92KrAXmkGnYQlja1zCEPVko6hhcZloXCLpvdvs61co=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kl3vRLYuZ5OEnr8Pu8KoF376mYtryzLI11/ndbbJgijjOthEsbFB6T6aYu5yDs8DD2B4/O7fMSUdJLCgy7wtSuaI213wm5xYIoo95XENZBCT22/kYFmojqFOwreOnrZPOIwaL8O01pmVegYu4r5dCSMfDYMmqIfZ6aEgs6JE20w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VCQ9hLQN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-2e95ab2704fso3995437fac.3
        for <linux-iio@vger.kernel.org>; Mon, 11 Aug 2025 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1754937162; x=1755541962; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LeTxH6JVzhuvOOHt8PDT/8nTwuTCFSD9kgIvJbyD4sQ=;
        b=VCQ9hLQNHSxdj3OFbhOBDZyODGlAJgb3BG0a+f/chz7+MbyKUrHTF5f89vq4SwkNTF
         cz5Ha3I8T9HRQKx5qhpz6E6RTM28XuX+7Q3hlRNYWfJTrdYfu2aeAwS/ID/k6gvEaxOC
         E9grKXgK+tsjNjFNCL6WItjcsB5tyP6MJBC1N1X5jHhBG8quwsawXdD+4bpvF2to1tkV
         8tHe8GCpt5KRJakMQBKGvR6JkA3ysh7cfV8G+PwkgFiO0AM+USTiBAYQyvCQp9SRg/C1
         ieNYQSuSvNd0m+5AIpOcF5JKEGIB1OH/PbZrBP1tGmchNyCboJ0DEnh4imOxzGOFQLps
         C1+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754937162; x=1755541962;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LeTxH6JVzhuvOOHt8PDT/8nTwuTCFSD9kgIvJbyD4sQ=;
        b=tErx6WC/QRzsla0x0UjtSzt9KRqERtxM1IXFvdKynMUkayjwzfn0rO879T+QLEzMRK
         ca8xrXGl9QxjJZW2hToBCKvwn6NcBxhmXW+KF/67ZEd93rXz8GBEkMc8i4sVkeCNGJe5
         p2pkkZP7lu6y+jcDOLK7QMWt1cmCMpeSIp3lti0X6cfmCWP/iLC7vBBybQukJRUmHt0K
         1knSgHjYaM70Ac+Zmu6TIA9m+z/hb0ftvj1NuEkaz9PNEMPxH6jRLjtdCrvDuB0NT5dp
         Vk41PtfX7ettLglYJ2hVXRDCxSWvmr4PFytcNv4QPoyXBIZx2d3yV4Y9VrcTZKOUSWbM
         KmzA==
X-Forwarded-Encrypted: i=1; AJvYcCUwTlRddM0Vh41F27v/jBDFkoIic9AKc5poi+2YSDJWHNHuYSFEk/U0y5Fiv1/+a4j6k8pHOMo8qfA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqC/VFoXABxX8sKTZqUfSxb8oYjgjMsGDZlBCM9GV6jUWHnUjS
	Jys9xKzj7KTtKpMRBekzMLQPTlZ073bOR7RtgErkvaQrJnrw9EWL9evMEmcrO3i6aGY=
X-Gm-Gg: ASbGncuJf96HaTk9v9vyfqnGOGcCVEZxt1TeA5WQ3nFaXwajzTWOBmZ8cxV3Xy5Jb3Y
	LQADS6gLIZin3S+4X/BL96DTzRajB4yRl5K1eKIrIFpIe8n/1xjJ6nhvcboTHukHbP2fv0Q7nVB
	KWVs2zQ7GEbvKeaDiI60U10ESblKuum93Va+vAGG8JCdsfrmBFosqFhZNcP67U3YC4h48HY2bh1
	NPVSJPFJNSXv7JaCNyAVZ+OjAIbqOWVHNyx38/XXutP9uqghKc0YOp5uaVBqLMw5w1nCTszKsV9
	6saVobTM34Apvtb6MQKjnCTtaylKDlsZBLmwFtkY5bzvK1avUMsbZh9oeHt+O+M0Z2XoodCtHJi
	2I659KiIiYluVO/KBdO/8IBlPdPB3PK4dJIxHLVk=
X-Google-Smtp-Source: AGHT+IGHlQRsOQLA9RN8I/CrgNHvt/H6WdqUKeIr/pzj0zxbQAM207v53to9+K03H7v4vJ+hcoVBaA==
X-Received: by 2002:a05:6870:8a27:b0:2ff:8ee5:d1f7 with SMTP id 586e51a60fabf-30c94e77364mr400690fac.1.1754937162356;
        Mon, 11 Aug 2025 11:32:42 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:1d00:4a4f:fe55:51b4:b5ba])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-30b8e3c9b32sm6232275fac.24.2025.08.11.11.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 11:32:41 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 11 Aug 2025 13:32:31 -0500
Subject: [PATCH] iio: adc: ad7380: fix missing max_conversion_rate_hz on
 adaq4381-4
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-v1-1-ffb728d7a71c@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAD43mmgC/x2NQQrCMBBFr1Jm7UCmiTR6FZEQkrGdRRPJSCmU3
 t3o4i8efN47QLkJK9yHAxpvolJLB7oMkJZYZkbJnWE049V4IhSpGHPqm6w3+JIdV1GVMuMa95B
 q2bj9LKHFD4dFsZZ+dtYTOrx5tuSIxjwR9Ma7cTf8+4/neX4BOid1VY8AAAA=
X-Change-ID: 20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-98e314112d71
To: Michael Hennerich <michael.hennerich@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
 Andy Shevchenko <andy@kernel.org>, 
 Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1143; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=i92KrAXmkGnYQlja1zCEPVko6hhcZloXCLpvdvs61co=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBomjdAStnk0tMGWQaRUeeDLLtlb0sbFDmq9mK+0
 tYbeGd/PfyJATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCaJo3QAAKCRDCzCAB/wGP
 wN5nB/9Wap7GFHeigPM5zdM9S8jvsd9EdolBlu6nPVi/x8znraa4c8l0NVO83kjtDtWDZtOGooR
 x9Bi7zje+jnMAY8H1fdh9Fxeg6pTqJBEQyuSVh3II63x18bu6e7B4jMYVI0xotunzJhHd/G+J3/
 VvogRIoYk/DLl2K8o1979zZSiYBlBjwpadx90gaMQROLCivEjLtbjuJQxu8BlbSu4ui3Wa0Lol3
 kuNoXmGnkmLp/gyGzXZyyLQwRu3uljn5C7CbvALuDY/9g+H5qWPRg4pbk52VjbbhP2KSrucY1wQ
 SZY+sx/2CdjR2c4NMqziQjl1yoUzCso/3t5WConwToIBvhOi
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

Add max_conversion_rate_hz to the chip info for "adaq4381-4". Without
this, the driver fails to probe because it tries to set the initial
sample rate to 0 Hz, which is not valid.

Fixes: bbeaec81a03e ("iio: ad7380: add support for SPI offload")
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/adc/ad7380.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
index 6f7034b6c266bd6075e0e2fd8d567c4490171e7b..fa251dc1aae6ab0a0d36792fa37b2cc22b99dfe6 100644
--- a/drivers/iio/adc/ad7380.c
+++ b/drivers/iio/adc/ad7380.c
@@ -873,6 +873,7 @@ static const struct ad7380_chip_info adaq4381_4_chip_info = {
 	.has_hardware_gain = true,
 	.available_scan_masks = ad7380_4_channel_scan_masks,
 	.timing_specs = &ad7380_4_timing,
+	.max_conversion_rate_hz = 4 * MEGA,
 };
 
 static const struct spi_offload_config ad7380_offload_config = {

---
base-commit: 80e8c3730645f6e097a79e99e658201530bc2881
change-id: 20250811-iio-adc-ad7380-fix-missing-max_conversion_rate_hs-on-ad4381-4-98e314112d71

Best regards,
-- 
David Lechner <dlechner@baylibre.com>


