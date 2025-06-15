Return-Path: <linux-iio+bounces-20687-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC517ADA454
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 00:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06DD67A2AB4
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jun 2025 22:22:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B94528032E;
	Sun, 15 Jun 2025 22:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8KRZUr5"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E5A16A395;
	Sun, 15 Jun 2025 22:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750026191; cv=none; b=hrz63/Torvdxiuob3RWpqgTKmf/tN2TD3vLcGqpuUvW1yv0JsC9ni3Pte6AsvjZyh9mSfMruJi99A5Hg2Dxi097S8YOB1eW9Lvvr5rsl2lRXGIpOhow+aezT7r7sAeS1fwGwjUYcAPuBEIGhev6Ni64ZXe337jhnjprnxPEzsTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750026191; c=relaxed/simple;
	bh=OcSzxWcylbf9O9uMPY784h9WuCm/MYyruFaYVs4CfFA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IZfhhc80SbBAvs18QGb81/rpm9izucf+sM4qDAWj304xkr36hQ8UbQA574LJtflSRk08PPjX39sx1UwXVXlEdHOruYMSVKHo6yqkSOmm6jk+9R9u9+AoyW97sxpgakyI9Y1ucGZ5lwG4bI6rgb6hQCR39w8Oz09NsqNoLXq/E6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8KRZUr5; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ad89c10dfabso109807966b.0;
        Sun, 15 Jun 2025 15:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750026188; x=1750630988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P6yHXBtbTqJtfka5dx4vNKxwWBJhinite9xksxFtKWw=;
        b=m8KRZUr5oTtdwPujpL8vWNayi4KaS5uI8XRTAJFZUvpIADQd8hy6cqSM1tGam4GEHF
         ud797eBrbZ5f7Md428sa7L+9mVRtTl3+ZDX/RCouVYwNXpcDPnv8VogRivn8ytVjzFQu
         bAgTo8cE+X3H/ckU+uINzLIZgGGiJiTsZ5NJWGuCtSRB1hgK+2/j+rki56KppHn9INYG
         YtAxVFATSPvYb8lwmYNq+cM9lRXhiqc7XM41f98HSrBfHkPRb47HgOdAa+4L1VDpU6NE
         gW7KH8foBmKYVQjVmIFrlUBDEfmwVRUUHCVRfChldjl7Wc/ceNgnCT8MiXa/hkhKFO0g
         uR0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750026188; x=1750630988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P6yHXBtbTqJtfka5dx4vNKxwWBJhinite9xksxFtKWw=;
        b=luF8IzF20Ddst0XR0YAUr3QVN2x6e+teToxq7zJhXwIeTh41j6RBzB1p2Wo3RPFv9S
         rDZ2g1WxmOJZJ9P5gndfhqGb3EanyQkX3h7IZfMlYgcI2yjtnUp2Ub4fefnl1sO7SQpH
         WywD1g17TCqo30H5XZu7EFnhyZyKSGb0y+QPDNMCvO9kiMKbfezGs/3UZdWoNnW9nQDX
         hPd3qtYKOl0I7gh6rnJ2Eq77eTMabr6Jiz/aveBMXqNvpBKjuRufFE2tTMPDaKlTLud7
         RrM51v2/jckPO4cgYzea6UTrnjdq/2SvMPkxy3XL6GPNFposXHBq0MUL+gunBXYiu2jV
         SC7g==
X-Forwarded-Encrypted: i=1; AJvYcCV0L9D3OGk0AW3uqhyRblqh5iQCWghcDQs1P6fHgTHPDZvyMo2vVRLySCB3DqwPgXkV3QGVSRCy16t0iyu9@vger.kernel.org, AJvYcCVZUoZMunyqwg1gMBcIESkco5GjA1fnt2evKa42bzL58o+3K4RASBpafy32a77plqp9X7IC+nrOJKjY@vger.kernel.org, AJvYcCVbhjlLi55DeK4EwPhKAM6Wtw6F5b1pWE8/YJfjG8M/W0sI1naYuZgsqtQk8+G4vMzFTth9CPb0ouU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpj8SlyxetLVCMS+TZoMEn7LMK83NawNo1BHvvkT5w8QRGkOOc
	OCmcelmVZ6hcpCkuqq9SjUcnntp1KzXcwAVjz97UIRmzBhbLc/iAjifSHBgBSQ==
X-Gm-Gg: ASbGncsUxBwWoe116rtCyu3pbdLMpxEocK9h7yI8PlpyO1hBbkQTGHKZtnjYJS+0IXg
	V16Cb/MpKOw2SlLJ1S/7gHUPLrw+iGvtMf1Oui5AE7X8AMfF2xgadiyRHa8m3CxmxR7I0TCQdB3
	PpdVQMvs5Mz94mipc4kKg950Q/sTC1hBvByLibzXwqEg6EaTxCvAcR9AECOQoJOO/SSRWOwtT85
	E7Ab9w0XjL65saWLBRoDo1bc8Ur78Y2UeNpQ46Um6UbLgDH1uQhoKHRFp6hfmTGwgwAup/KKFHD
	FxiHDsw1Zx0flhVwUHzBcLjw6zfL7g1JpN/mk0Dv+AJ6uaPKWYIxRYAoSGZz6Ngk1eGiBeA/Wau
	A4i9f/e7vUd8YtPCtSr/8vPvyvIIoSaXm1FV/6fuS8Yg=
X-Google-Smtp-Source: AGHT+IGPm/dy11DrihiPe93ZRWMDPohUokRWcDe3USXe7mGw7ypUnYnuu0i7rqAwFd6fbg4th9ix1g==
X-Received: by 2002:a17:906:c10c:b0:ad8:aa3a:772b with SMTP id a640c23a62f3a-adfad5a2dcamr244629466b.15.1750026187666;
        Sun, 15 Jun 2025 15:23:07 -0700 (PDT)
Received: from localhost.localdomain (84-72-156-211.dclient.hispeed.ch. [84.72.156.211])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-adf8b393ea8sm412692766b.159.2025.06.15.15.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Jun 2025 15:23:07 -0700 (PDT)
From: Lothar Rubusch <l.rubusch@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lucas.p.stankus@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	bagasdotme@gmail.com
Cc: l.rubusch@gmail.com,
	linux-iio@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/8] iio: accel: adxl313: add function to enable measurement
Date: Sun, 15 Jun 2025 22:22:52 +0000
Message-Id: <20250615222258.117771-3-l.rubusch@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250615222258.117771-1-l.rubusch@gmail.com>
References: <20250615222258.117771-1-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Refactor the control of measurement and standby modes for the sensor.
Instead of directly writing to the register, encapsulate this operation
in a dedicated function that handles enabling and disabling measurement.
This approach will reduce code duplication wherever sensor configuration
changes are required. In subsequent patches, measurement mode will be
set to standby as part of this process.

Additionally, simplify the control mask to include only the measurement
bit. The sleep bit governs a different behavior—putting the sensor into
sleep mode, not just standby for configuration—and is currently unused.
Therefore, there's no need to include both the sleep and measurement
bits in the same mask.

Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
---
 drivers/iio/accel/adxl313.h      |  3 +--
 drivers/iio/accel/adxl313_core.c | 10 +++++++---
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 2bc86ac8ffd4..6958a00f5e8f 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -37,8 +37,7 @@
 #define ADXL313_RATE_MSK		GENMASK(3, 0)
 #define ADXL313_RATE_BASE		6
 
-#define ADXL313_POWER_CTL_MSK		GENMASK(3, 2)
-#define ADXL313_MEASUREMENT_MODE	BIT(3)
+#define ADXL313_POWER_CTL_MSK		BIT(3)
 
 #define ADXL313_RANGE_MSK		GENMASK(1, 0)
 #define ADXL313_RANGE_MAX		3
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 39f16f97bb4a..99a7f3755031 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -64,6 +64,12 @@ bool adxl313_is_volatile_reg(struct device *dev, unsigned int reg)
 }
 EXPORT_SYMBOL_NS_GPL(adxl313_is_volatile_reg, "IIO_ADXL313");
 
+static int adxl313_set_measure_en(struct adxl313_data *data, bool en)
+{
+	return regmap_assign_bits(data->regmap, ADXL313_REG_POWER_CTL,
+				  ADXL313_POWER_CTL_MSK, en);
+}
+
 static int adxl312_check_id(struct device *dev,
 			    struct adxl313_data *data)
 {
@@ -398,9 +404,7 @@ static int adxl313_setup(struct device *dev, struct adxl313_data *data,
 	}
 
 	/* Enables measurement mode */
-	return regmap_update_bits(data->regmap, ADXL313_REG_POWER_CTL,
-				  ADXL313_POWER_CTL_MSK,
-				  ADXL313_MEASUREMENT_MODE);
+	return adxl313_set_measure_en(data, true);
 }
 
 /**
-- 
2.39.5


