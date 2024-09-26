Return-Path: <linux-iio+bounces-9799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A88987743
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 18:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B05B24DBF
	for <lists+linux-iio@lfdr.de>; Thu, 26 Sep 2024 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A80F15B122;
	Thu, 26 Sep 2024 16:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RBRa3QKr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAA015A4B0;
	Thu, 26 Sep 2024 16:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727366927; cv=none; b=D4NlYVpFUqdrlUAPud2aWnC/OLMG8dYoTvlds9c5u9pUJIyUYOgJMsVupYGgPyM2ycOJM6sXmFVoVpWwACR34eay/k5GQbCCMoUUbCduGmFKzXsGESDvYwpJfHMbuCkyUH9lPaYhfvsJxKxIGgDp0+cmSmZMqcn8X6B7xlVSO4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727366927; c=relaxed/simple;
	bh=+7rr+FCJ6AKEfSNXljsUP6cpWRBmO490u2jfv3txKV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fhuKVQvbDTNr8hWk20RmoxzyzAUcfCuNUayMySlLhNvKm+vssm4pA85vtIXlOwNuUs76Gz67JzxpgPBYqQXTdRmROr7ePpoMVkHnyYSXYX7XAHciJNR4Wrrdik7J+912Lh13cRxzv2wGbDYGzIJZyNwCmqx299md5D+Z2Iw+jMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RBRa3QKr; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5365cf5de24so1613069e87.1;
        Thu, 26 Sep 2024 09:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727366923; x=1727971723; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i5gKs28PIZ9OJchaPijaHDwFlIvvXwx3mdFdZLIkcJU=;
        b=RBRa3QKrr0EtWmL+Sm5KynmP3zeh1Bg/WzoMVSod3Gdvkj328GlK8x26gfLHTSsmHP
         rnyko5bJyd1m4SlBqMo47tRuFeLu0HYsMbXY37lO1egOa/XnoeAGZRWgqMwTdyRF+qvZ
         SLhl6war8Pv4O75A+UJc4LvamHp080egXojuaNzVfIZgnYYwjPcRMAHZW1/iCjp+omza
         ucCoymERp9TI/zTOxiW5Bc6/IsISHT6Q01QqnlXYT0Y/hA+/cXQ1c20qgfT0TzbM5TrP
         hItiU+r0GNI7RhMMRNzGh6zS+gjS7P2HdMGqzWVKViwVHBd3k0B1zKpcYPWtimwu8T6B
         NzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727366923; x=1727971723;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5gKs28PIZ9OJchaPijaHDwFlIvvXwx3mdFdZLIkcJU=;
        b=wsD1Y0EO4IPximPOuyDSvQhlymUCWgxUBk+3OJ0+GyWrWjtl46biH2Y309wdaNbRYR
         vxE+ErlXQiiEDdFPp/Ri9INZGCYgeVEqKJpoW/R84VTED7rdkm2zmWBI7CjlwFQTpQuS
         spgrr77WgbHq0bab+TqFKFUS+nwoIsKF8/AmjJuPdkvzEDkN+ml5Ks55/7m+hCKhX2m9
         2vBAqhMemSbn8NfAirBbMshQG/G2Vp0+WaSTr1Dubaz/dnBFIFYbqvc+10WQsTr9lfJY
         w6eQ9Pe5nSEeJcXB1ptAAqlwm4OUCqZA/D+C1WukCEabUw3Fn85HnOntsqP8GgEJAGBv
         xz8w==
X-Forwarded-Encrypted: i=1; AJvYcCUjH8D4mdOuJsY3ZPAUgYW8767Li4L/Stm1yEhtpwCWXGLArTJJmwWfFEj+bakO0jAiiBvmfXwB/iS5Nd0J@vger.kernel.org, AJvYcCXB1MjqWpmJQKXsXoHFUrhEjfDYeKTS4zrnS7ejOk/dx3HHIglI9BstYPDdjnhvtSUn1JVLijBf7ME=@vger.kernel.org
X-Gm-Message-State: AOJu0YzckzXwstsAVz5VnRWNuuj+clqV9K7DSootay88n2bzVHiu+tFx
	0dXsvOPj+apf9xRDneqxVc2y+RZFxVZSPsFHlwN7B8RZPatO8Usj0iH4Bafk
X-Google-Smtp-Source: AGHT+IGLWzwtVsVoERLcNZJXmgDmyiGB9Y0BA8D4DZOrd3E+mXlHlQRe8hXYareII+TVH+5IvvXpAA==
X-Received: by 2002:a05:6512:118e:b0:536:a4d8:916d with SMTP id 2adb3069b0e04-5389fc4d0d6mr73847e87.34.1727366922442;
        Thu, 26 Sep 2024 09:08:42 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-6d88-4cd9-a9d4-f267.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:6d88:4cd9:a9d4:f267])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm13947966b.78.2024.09.26.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2024 09:08:40 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 26 Sep 2024 18:08:37 +0200
Subject: [PATCH 1/4] iio: adc: qcom-pm8xxx-xoadc: use scoped
 device_for_each_child_node()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240926-iio_device_for_each_child_node_scoped-v1-1-64ca8a424578@gmail.com>
References: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
In-Reply-To: <20240926-iio_device_for_each_child_node_scoped-v1-0-64ca8a424578@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727366918; l=1388;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=+7rr+FCJ6AKEfSNXljsUP6cpWRBmO490u2jfv3txKV4=;
 b=sqgXoB41yns5o3RxNgTQxLX7a9d1ns38jgO9CICIOPLIHhpk3IrwcW0xk/EqE/0KHISg3Zupw
 NRY4WuSZt3QB53sR21L3VYD5YsVriYRanA8iMQlfuAM4Q7yT0YwUlxi
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Switch to device_for_each_child_node_scoped() to simplify the code by
removing the need for calls to fwnode_handle_put() in the error path.

This prevents possible memory leaks if new error paths are added without
the required call to fwnode_handle_put().

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/adc/qcom-pm8xxx-xoadc.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/qcom-pm8xxx-xoadc.c b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
index 9e1112f5acc6..311e9a804ded 100644
--- a/drivers/iio/adc/qcom-pm8xxx-xoadc.c
+++ b/drivers/iio/adc/qcom-pm8xxx-xoadc.c
@@ -821,7 +821,6 @@ static int pm8xxx_xoadc_parse_channel(struct device *dev,
 
 static int pm8xxx_xoadc_parse_channels(struct pm8xxx_xoadc *adc)
 {
-	struct fwnode_handle *child;
 	struct pm8xxx_chan_info *ch;
 	int ret;
 	int i;
@@ -844,16 +843,15 @@ static int pm8xxx_xoadc_parse_channels(struct pm8xxx_xoadc *adc)
 		return -ENOMEM;
 
 	i = 0;
-	device_for_each_child_node(adc->dev, child) {
+	device_for_each_child_node_scoped(adc->dev, child) {
 		ch = &adc->chans[i];
 		ret = pm8xxx_xoadc_parse_channel(adc->dev, child,
 						 adc->variant->channels,
 						 &adc->iio_chans[i],
 						 ch);
-		if (ret) {
-			fwnode_handle_put(child);
+		if (ret)
 			return ret;
-		}
+
 		i++;
 	}
 

-- 
2.43.0


