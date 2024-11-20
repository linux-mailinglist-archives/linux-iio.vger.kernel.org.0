Return-Path: <linux-iio+bounces-12441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 290FE9D4393
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 22:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB79CB2485C
	for <lists+linux-iio@lfdr.de>; Wed, 20 Nov 2024 21:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A21CB528;
	Wed, 20 Nov 2024 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="dHuSg9Tq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 896F51CB32F
	for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 21:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732138458; cv=none; b=f3nB9p+H1TgAf1Ggdwjx8utR4Geb00xm8jA4rXD4w4xyMJwh+aRN5y09LJA1u+F9DTTs+yv8/qOxZ0r3SjTRnKtVklFj11WfuTXKMyrtzh6SgoNnNNtTZvfZfQoyUN8Fl4qfopz3VN01Vb44rJFjFc667AMJon0TjQfNNq6h+ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732138458; c=relaxed/simple;
	bh=/Whh0lLO/yI7/FPmO+jIOLQNQF0tPIusHK4fVYMh/RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=own42kXWgi3YAhHmi+zA5HPFbm9Y1ZDKVjsdThrM3mdpcD+PABcNRovbySSd01M6Rlf15SFVnZRJtGXw/9m0fhybgprZwVXI018T0WZiBbB4EAsD349Oy15sO6qaCx5CtgOGL44LRbsAnOZZfdX6hYhlfjpb4PhGwB5fEiRaMuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=dHuSg9Tq; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5ee58c5c2e3so137681eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 20 Nov 2024 13:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1732138456; x=1732743256; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cxS2Z0C5wIvgTQSNU8Qu3dmatgrBAAmj1e5pgYj3js0=;
        b=dHuSg9TqOdo09fewDAsy7NY8cehS9cgCTVdERzvUHYqGr85ZyTQ1evMmMz2w63X08d
         mlgUK7wNno9VXsLTRsY6RRviD/rqv541w26z66X5bPM+sqi9YahxkoY3OgPiXbd/29VB
         +K3MlHv75BKuQG6RtcqYBLTF5CrkD1RTCnIIjkF/JMuEomkZ903j3PHeoS9/4IqsS+6I
         jKgL/TqO41iXr4RZnMI/qN29L8QM4+bOBJrHk0M2TIQGc7hKY06sDstWA+4M8FTqPyrt
         9aihtzA5qGot4OvcK1bpXGPF9MuzxJgAx2hYp/5j/I5bypyQMG0BbyEJgSueCy3baWrc
         D/dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732138456; x=1732743256;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxS2Z0C5wIvgTQSNU8Qu3dmatgrBAAmj1e5pgYj3js0=;
        b=L/m665EL/8KsUu/p35UoBDgpQs2BbpNwkgEI9Pob4h5LohbIjWo4ExBGNR9hGkB1Bc
         ja8HMPuodkYMC7TwnxZl+OC82coRJGodqsMSwTnDZvrPpQcrMcdgSeFYkVj8eXx6kdnq
         EcQTHbVDer1GN8F5x7SFqBoSpUTzSt7pRyU/Gl+bqpRTA6wByfgXwYBePLYHIXpqDG9M
         mDIElK9QAVubEMqzkGrix2O4rxFrOqq0MLjbFNhtwsEA0Urr4zp59qs2zzxBVI8tQQqJ
         biJrzVkywQzXcAeJeJAlFgzNMc425c+6L+xCJko2gx2IWNG6DtjBzSKmBwc9fW7uMRzO
         YreA==
X-Forwarded-Encrypted: i=1; AJvYcCVki8zehCdX4gFpl0OaD0XAhiKbF0pQRgaDM1ax08IfuVYGDzmE15qXsBW139GO4nWsiXUMUR1X5Ug=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4F3zv7++03zVuZJTAYJPigd0l2E/UxcKsiMQI5zGzV9zSn1Wj
	XHO6iy8rV/nrve+hiXffDpf/cmNWu4stDkTYckMhleyl88r3OvWFMoQdeMGlmao=
X-Google-Smtp-Source: AGHT+IF2lB8QgTcV4vegaXvpiMgWjD/98kXniLRx2lPUYn1xYr2NIjkpvUWFO1Od3RLDELoRjuQ/NA==
X-Received: by 2002:a05:6870:ac85:b0:296:e46b:8d09 with SMTP id 586e51a60fabf-296e46bd876mr3947193fac.12.1732138455757;
        Wed, 20 Nov 2024 13:34:15 -0800 (PST)
Received: from [127.0.1.1] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29651852c27sm4487365fac.2.2024.11.20.13.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2024 13:34:15 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
Date: Wed, 20 Nov 2024 15:33:34 -0600
Subject: [PATCH 11/11] iio: dac: max5821: use
 devm_regulator_get_enable_read_voltage()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-iio-regulator-cleanup-round-6-v1-11-d5a5360f7ec3@baylibre.com>
References: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
In-Reply-To: <20241120-iio-regulator-cleanup-round-6-v1-0-d5a5360f7ec3@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>
X-Mailer: b4 0.14.1

Simplify the code by using devm_regulator_get_enable_read_voltage().

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/iio/dac/max5821.c | 36 ++++--------------------------------
 1 file changed, 4 insertions(+), 32 deletions(-)

diff --git a/drivers/iio/dac/max5821.c b/drivers/iio/dac/max5821.c
index 18ba3eaaad75..b062a18be5e7 100644
--- a/drivers/iio/dac/max5821.c
+++ b/drivers/iio/dac/max5821.c
@@ -32,7 +32,6 @@ enum max5821_device_ids {
 
 struct max5821_data {
 	struct i2c_client	*client;
-	struct regulator	*vref_reg;
 	unsigned short		vref_mv;
 	bool			powerdown[MAX5821_MAX_DAC_CHANNELS];
 	u8			powerdown_mode[MAX5821_MAX_DAC_CHANNELS];
@@ -295,11 +294,6 @@ static const struct iio_info max5821_info = {
 	.write_raw = max5821_write_raw,
 };
 
-static void max5821_regulator_disable(void *reg)
-{
-	regulator_disable(reg);
-}
-
 static int max5821_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -321,32 +315,10 @@ static int max5821_probe(struct i2c_client *client)
 		data->powerdown_mode[tmp] = MAX5821_100KOHM_TO_GND;
 	}
 
-	data->vref_reg = devm_regulator_get(&client->dev, "vref");
-	if (IS_ERR(data->vref_reg))
-		return dev_err_probe(&client->dev, PTR_ERR(data->vref_reg),
-				     "Failed to get vref regulator\n");
-
-	ret = regulator_enable(data->vref_reg);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to enable vref regulator: %d\n", ret);
-		return ret;
-	}
-
-	ret = devm_add_action_or_reset(&client->dev, max5821_regulator_disable,
-				       data->vref_reg);
-	if (ret) {
-		dev_err(&client->dev,
-			"Failed to add action to managed regulator: %d\n", ret);
-		return ret;
-	}
-
-	ret = regulator_get_voltage(data->vref_reg);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"Failed to get voltage on regulator: %d\n", ret);
-		return ret;
-	}
+	ret = devm_regulator_get_enable_read_voltage(&client->dev, "vref");
+	if (ret)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to get vref regulator voltage\n");
 
 	data->vref_mv = ret / 1000;
 

-- 
2.43.0


