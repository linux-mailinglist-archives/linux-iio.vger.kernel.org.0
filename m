Return-Path: <linux-iio+bounces-7276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 921539269E2
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 23:05:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7DAE1C23E2F
	for <lists+linux-iio@lfdr.de>; Wed,  3 Jul 2024 21:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136DD194083;
	Wed,  3 Jul 2024 21:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="muMwDa94"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E308191F85;
	Wed,  3 Jul 2024 21:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720040700; cv=none; b=frIrur8y2B82I1V4eAFeaBWh0AdLHor6G8QVJGexLEy1AiM54QKIK2owtEHIlnqi9SZhLWPoa64S59nnvvPyzTqqD7fUgKNDs5Moyp4y5AgGYWrl9zqD+lgd0ceRNxy/jVjDGyGapQSDA6O9UCcxINORxazhVdaJiOkfG6nHo8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720040700; c=relaxed/simple;
	bh=9Thw3nyqCMLe1fbX91LTA7mRJinzJdqXzhuvlXc6cj0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EXfBkMGlrqCFZB4Msu8Wk9InJwV3gsM5Y9c2sgXSh8605pQrqeTPodVOrBOxfX2erDbh3dEXgez5kJh+dd8lA2lRGKilznbrgA5vaAFiWip0NBzbkClHN3z4JmJO3F2XqDSS5Nh4n58we/At1/d5T/EKIFIWFDnfup4ICQJ0Sq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=muMwDa94; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ee794ec046so22067231fa.2;
        Wed, 03 Jul 2024 14:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720040697; x=1720645497; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IsM5uxfiopxbzTC6eyj1SNKvlNUYuJ73SSV0Yy8/1XU=;
        b=muMwDa94RNRs4laZb7C31KQF3N36apONwr5Qbo0T9Om8h7oI2WT4WvInl0F+zHKMzO
         KYOrXBRQT+GZ8Y5s9FPOJWe+k131HVx4mvzyJ1EJvG1Uft5PZtpk34FFMsiqLiKD12DY
         vR+UiBMzXl18MDXT9P2tTVrA1eu9pDGb+a/50druSh1xGjRZW2Ar8Re63LEDrLe84MdT
         GJrdPK0YfBWcVh/lLhgRheDdTwavoHZHtuE1Cg8Pk/YPvcwYYTBJLuFJaKhPqHj1AzlJ
         miX47WeLGim8K08A7tzlvwIODNq5ahPO7yYKSkIA2yLATz3TZoDDzu6ODLojZNXYQpUt
         p8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720040697; x=1720645497;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IsM5uxfiopxbzTC6eyj1SNKvlNUYuJ73SSV0Yy8/1XU=;
        b=ZAH54TFWme5aiQm72fjg29e1mYgVzT7fXeWZI0Fy2h/NNpLq7Fo9g6PVhRUhbjY1qV
         h08//WqAz0DTGkt9VZVaMwZ8C1A1hv6pnSJ4/sd+mR+04qHG7nmJxF1qU9wUAMM9rf+5
         ckkntQJBGIKxai/Je8l6kYEUqwkM3IsD5tf5vSEf0UGZhjQ0T1HpFc8tK4n8v78Dk0oW
         yIPBN20FA917QHM1VFXe/0F6gP+KSvzyWjDVQ3xsFBq2p8WuBFKiRJFC+2HOW4aV/S9R
         btYLjKO6YmFzisw8Zbzmr+cHGlj85xx84unuGBtAvvOPhoiIAYpueUF/q0aTDb+CwK4s
         1Zww==
X-Forwarded-Encrypted: i=1; AJvYcCU5GFOXeLEi4A4q6cdXbLw6lyNjmXF12RP+Il0A8SIq8Ai/rFpF1+GFlV66vazPszOfWU+UwnPpl1zahAfNLr/ldbpeE73InVP3B1gT
X-Gm-Message-State: AOJu0Yzcw4FdGtZdP55l9raM1/1Fy3Q5juiWTHZd937D0I/NTp0Nte4i
	ekEPWIhZvdKgSAnuDFZkZKEl3g86IS5yEOwX1hfGFRIetXb7mnol
X-Google-Smtp-Source: AGHT+IGRcrKrQLozh68yKhBCUK09gmUitNlKgh6tNTQkNzaACHhF45hxdu5dSDoPWSzHDRwn6xfH+Q==
X-Received: by 2002:ac2:4e07:0:b0:52e:9407:ddcd with SMTP id 2adb3069b0e04-52e9407dee1mr3033265e87.18.1720040697511;
        Wed, 03 Jul 2024 14:04:57 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-37.cable.dynamic.surfer.at. [84.115.213.37])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b0971d2sm249676355e9.31.2024.07.03.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 14:04:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 03 Jul 2024 23:04:45 +0200
Subject: [PATCH 02/10] iio: accel: bma400: Constify struct regmap_bus
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240703-iio-cont-regmap_bus-v1-2-34754f355b65@gmail.com>
References: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
In-Reply-To: <20240703-iio-cont-regmap_bus-v1-0-34754f355b65@gmail.com>
To: Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Linus Walleij <linus.walleij@linaro.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720040691; l=818;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=9Thw3nyqCMLe1fbX91LTA7mRJinzJdqXzhuvlXc6cj0=;
 b=ej6NqlCWn1QXw4ITODtMxyTmidggl+0jQ0pPMduUwLudPS50zwDzCGT6ydX7p9ad0+uSrd2Q5
 oi1ejZnCgzUAq8rTL4ptW5uPQrOT1FAbEdN3sqgp4HmbiezHl8SkmgB
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

`bma400_regmap_bus` is not modified and can be declared as const to
move its data to a read-only section.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/accel/bma400_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/bma400_spi.c b/drivers/iio/accel/bma400_spi.c
index ec13c044b304..765d8c4a4c4d 100644
--- a/drivers/iio/accel/bma400_spi.c
+++ b/drivers/iio/accel/bma400_spi.c
@@ -53,7 +53,7 @@ static int bma400_regmap_spi_write(void *context, const void *data,
 	return spi_write(spi, data, count);
 }
 
-static struct regmap_bus bma400_regmap_bus = {
+static const struct regmap_bus bma400_regmap_bus = {
 	.read = bma400_regmap_spi_read,
 	.write = bma400_regmap_spi_write,
 	.read_flag_mask = BIT(7),

-- 
2.40.1


