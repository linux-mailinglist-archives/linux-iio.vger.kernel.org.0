Return-Path: <linux-iio+bounces-10696-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0B9A2FE6
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 23:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FBD1F23947
	for <lists+linux-iio@lfdr.de>; Thu, 17 Oct 2024 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585031D798B;
	Thu, 17 Oct 2024 21:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NK78/tqp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776521D63E4;
	Thu, 17 Oct 2024 21:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729201178; cv=none; b=Je5geK4/fwVZ7oEk69tX2qU4uMPBQ23RMeweVymBbhcQwlDI9moGgJw8qqDEEIGlqS+UeGKcyH3ooHmwg01ZtmDZYV0+guhu7HkpfmPfIlzVe4S5SLlPzDcwxwoPf+OYOsTurmiRaguE8dsZOTZdMh/Ro/lxk3pQpPh3WgkjIAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729201178; c=relaxed/simple;
	bh=slxiBNrlqeaocsJuYNANEU/ajIu9eRQoFxiHcqiRBk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=leG4IBdP7ato94qWVU1lTysdUi6RL+6ezAKqN3MuYifaTpZefK2kuX2LyZy708NBHNyhPSJd+6Cs/QR/9+nolDyApKmcF19YHDrroheSf/66A6CJNwad+EEzvMwCE4i22o9ii9cc+K5ANsfbWo8t8h7ANhrdhYYgdZGCxX6UqGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NK78/tqp; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43152b79d25so13784555e9.1;
        Thu, 17 Oct 2024 14:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729201175; x=1729805975; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdJ2cXyn1+L+rmE1Dj6EOWFK8um8PXX9Nodw40uyy/U=;
        b=NK78/tqpOf6g625QMjBSLOka2fwKEW89+zbSgqLn9bTCYYlXjttXmNQIc25++cAEKf
         pSPD/tIdTDg5uRSDFozaCwz0NH7OqQWpVs/1S5ZYkA4DeN4JpZMDPVPwTeLee3yCvfpZ
         0GgfcgpxOuaPJpOTkF4BWbW6jB14RxUsgNBNKCf/w02xpiRwELFeeVlK5E17CXNA1d3o
         nGPdeHPKo7m+zrf2K3gbsIFSY8MBZYKR3LsakdUBA/jhsfAz9JYrFiraCRevbC6H5Gm6
         9f/zBhLjlNCMDkwUyCleaTglofj0aCM9z5Bk+PTqCZn9aEJXf5bQQgWNyRAV3qQNwcVl
         mH5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729201175; x=1729805975;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdJ2cXyn1+L+rmE1Dj6EOWFK8um8PXX9Nodw40uyy/U=;
        b=uFc7UggAvCDLvwEojxFULMphFMAWUdLIhaaP4zkoog4yAMvx/SkrqW8Ow7Z2lrfU9a
         ujFqyOVX9mE4Qk/jN8Bwja+MElpgHOQfamxV3+BePmAomP5B50ogHkuAhseakuTQYWmK
         TgLRX21RnN5lVe+J+r10sBqde11/RlG+01VMH0H8VlWGbrrP+C0DmgOIOBrvUvH/Ls3x
         QYIOR6jCQZYUA6wZ3Jb9zvBq83QiKo8XzD37FKSabBQBWx3YrFbaeqewmZ8iSvj8cSr2
         KUl8sNz/aR1jd8Lv1+pS7v/AZObuR2gCWA5eFWU+90Rp2DK5oLzof/ChXMWl1i+zWMgG
         HMeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWsf1kLYoX+7LHiw0q9YOO4hImMs39lzUaEzxsmk3wMg0VrTXNv6nDkb5PPmZhXxlvLUSJ4Mzdh3sr0L8V@vger.kernel.org, AJvYcCWrLPIyJZQ1ulQFVMULS2d7WlOfno6s/y8ZU6QFrz9rixlCW8HzwF/BS+AgNA7uoZa1UodSGVihlYWc@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwfx8QyqVkwkszd4bNvj94c4MbxKjlvq5drVyNzPLifCAd0y1j
	gZ7c0O0EdruEnACg8V4rFznPROuOwW+k+LguFznX11hn7+dbJnH050EGDg==
X-Google-Smtp-Source: AGHT+IGYummoGPooYnT/q6pUWUuP5BSc5r1vEpoZ5LgR9nGJ35uQ5bISaN5qgNQ1GTBnrKb+KAQjWQ==
X-Received: by 2002:adf:f992:0:b0:374:c911:7756 with SMTP id ffacd0b85a97d-37eab6e46c4mr211895f8f.38.1729201174633;
        Thu, 17 Oct 2024 14:39:34 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-bb11-f817-987f-ea1f.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:bb11:f817:987f:ea1f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf06a73esm99874f8f.43.2024.10.17.14.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2024 14:39:34 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Thu, 17 Oct 2024 23:39:26 +0200
Subject: [PATCH 2/4] iio: light: veml6070: use field to set integration
 time
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241017-veml6070-integration-time-v1-2-3507d17d562a@gmail.com>
References: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
In-Reply-To: <20241017-veml6070-integration-time-v1-0-3507d17d562a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729201167; l=1537;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=slxiBNrlqeaocsJuYNANEU/ajIu9eRQoFxiHcqiRBk0=;
 b=HirTxUkuf9nvMr+RzRmporfD1Xkdr3AZrHGNTqMsRqxouL3XoBX2eOGVRh4+YNHWCuiI+0gV6
 k4g6uxS3Ao3AXKoq6pQ3p2dcZTFyoNz9aTRDKJQaFQ+h2bS+QGFY62n
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Define the integration time within the configuration register as a field
to easy its handling as an index, preparing the driver to support
configurable integration times.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6070.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/veml6070.c b/drivers/iio/light/veml6070.c
index 484b767df481..d11ae00f61f8 100644
--- a/drivers/iio/light/veml6070.c
+++ b/drivers/iio/light/veml6070.c
@@ -9,6 +9,7 @@
  * TODO: integration time, ACK signal
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
 #include <linux/mutex.h>
@@ -28,7 +29,7 @@
 #define VEML6070_COMMAND_RSRVD	BIT(1) /* reserved, set to 1 */
 #define VEML6070_COMMAND_SD	BIT(0) /* shutdown mode when set */
 
-#define VEML6070_IT_10	0x04 /* integration time 1x */
+#define VEML6070_IT_10	0x01 /* integration time 1x */
 
 struct veml6070_data {
 	struct i2c_client *client1;
@@ -172,8 +173,8 @@ static int veml6070_probe(struct i2c_client *client)
 		return dev_err_probe(&client->dev, PTR_ERR(data->client2),
 				     "i2c device for second chip address failed\n");
 
-	data->config = VEML6070_IT_10 | VEML6070_COMMAND_RSRVD |
-		VEML6070_COMMAND_SD;
+	data->config = FIELD_PREP(VEML6070_COMMAND_IT, VEML6070_IT_10) |
+		VEML6070_COMMAND_RSRVD | VEML6070_COMMAND_SD;
 	ret = i2c_smbus_write_byte(data->client1, data->config);
 	if (ret < 0)
 		return ret;

-- 
2.43.0


