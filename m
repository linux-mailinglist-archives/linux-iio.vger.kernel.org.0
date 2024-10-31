Return-Path: <linux-iio+bounces-11705-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D359B7E66
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 16:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7CF71C22050
	for <lists+linux-iio@lfdr.de>; Thu, 31 Oct 2024 15:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A35F1BD4F1;
	Thu, 31 Oct 2024 15:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XSXiAnZ0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A57D1BC097
	for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730388440; cv=none; b=tv71h3K06vhEiYj3T7ZCNz8jprTSh+G1rbwyjoFfFU9ASibpgkYUr1P+mNP2CTOH6KKANz3FYSAmQj98f2IPbSstVd8NXyxkG+jGjMqoo2mZ4HSkDz9Nwidz2Mg3BM5yaCtv22JXGofk5U3EgTcmcfEOvP/FXV07nCc2EKQPMic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730388440; c=relaxed/simple;
	bh=moWckWL94S/Tv0TXodewyrJjYwSZW6cdVNw+DrAM8xg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TFQhR39NhZMjOxtQk1lpHY0itMHSdThFqXYIu6xmb/gXaSGGKHTcgy1/+4hh+03fqhOxwjvX1fwAkxAIVQJYT/4XuKSeYmM3EiUae+5bOdJXlgSabXCq1Wi2BwUlaJNdH32b9hX+hqsxtF4LRmxry0hRRmobXtfZvs3T9J6R0dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XSXiAnZ0; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d63a79bb6so733201f8f.0
        for <linux-iio@vger.kernel.org>; Thu, 31 Oct 2024 08:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730388436; x=1730993236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=91AV8uDRorYbhW21+smtHmhnNIXchkEJXBaZcxgDOnE=;
        b=XSXiAnZ0PmUjM3wMXt0Z8wKFtElFZbGOx+GiwD0SudgVRMlE+qF/F2ZVwPOwkc+iX1
         YWDbflxSE4duteGjrSK/DcfCHyXvqXT9IVznw/JDzeBkpnK8F20KPPsftaHu1yBP9VN6
         EtU1B755U97UpougXJtI1GNiv0WVbQYKvKMtQlHL98+vz8TNTULG/sslkbH9s42BCUq7
         YGnjYivSoPuEYSn2vWq3zdvvjT8BrfETwacZPQ9VEvxyfunvRFArIhWygRacU30nMQpV
         AUgn1T2OP7N4G9nnNdMUfG6ctgItflcXiHB02OQ31LQ85EqKKvRl+Y9xFmZTwhb3bMoX
         26Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730388436; x=1730993236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=91AV8uDRorYbhW21+smtHmhnNIXchkEJXBaZcxgDOnE=;
        b=D+YmASjr7ewaPqDc428h6TP10IDWlawJkuRE9pbTZYtT4tbDSyEGA3wT93TeGu0NKb
         sl5W3MOb2KhK9+G6VQOVmxKF5m85fC13p+k/nrD4ON28sWmrA4mpvGy3Jd36sdu36dk4
         JZ726A8S9Nexxnmg2m8QaBkWlQdyeORerpyYshrsARtG/eXQI06lzCxVlIXOL/XAbTCD
         G2dbsGhIaU1zyUGOdmhPXxPZqohTf3BEtljmHA4wXTdeGVbwL+2hfP9SIwq8XyWt70Y2
         ojm4SF2xohIPT01rfxUNJ0O5P7GXZ3BkDy6OqaMy7rnj9WnnDzNwUXQ1/hucWPfF92yb
         X2Mg==
X-Gm-Message-State: AOJu0YzYEdSH3j/EUpyET6zUyz9ui5FlmNu7Almdg69SicP9zG7ISupe
	84S6KWyL1dapY9xP6ZyfijOtXq1rFGxkr6UKV231S3cthbtaknWueYLGLcpkf5E=
X-Google-Smtp-Source: AGHT+IF/NKLNlGsRd/1UMFl9TQ3C8cdSO5qCxZ9mwQG+PgwUSTDjp5JjuM36PcnisykqTLYhpsYWjA==
X-Received: by 2002:a05:6000:4006:b0:37d:3171:f2d4 with SMTP id ffacd0b85a97d-381bea1c0f9mr3497430f8f.43.1730388436559;
        Thu, 31 Oct 2024 08:27:16 -0700 (PDT)
Received: from [192.168.1.64] (2a02-8428-e55b-1101-1e41-304e-170b-482f.rev.sfr.net. [2a02:8428:e55b:1101:1e41:304e:170b:482f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5bf429sm29399475e9.12.2024.10.31.08.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 08:27:16 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 31 Oct 2024 16:27:04 +0100
Subject: [PATCH v2 09/15] iio: accel: sca3000: use bool for event state
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241031-iio-fix-write-event-config-signature-v2-9-2bcacbb517a2@baylibre.com>
References: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
In-Reply-To: <20241031-iio-fix-write-event-config-signature-v2-0-2bcacbb517a2@baylibre.com>
To: Mudit Sharma <muditsharma.info@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, 
 Anshul Dalal <anshulusr@gmail.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Cosmin Tanislav <cosmin.tanislav@analog.com>, 
 Ramona Gradinariu <ramona.gradinariu@analog.com>, 
 Antoniu Miclaus <antoniu.miclaus@analog.com>, 
 Dan Robertson <dan@dlrobertson.com>, 
 Marcelo Schmitt <marcelo.schmitt@analog.com>, 
 Matteo Martelli <matteomartelli3@gmail.com>, 
 Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>, 
 Michal Simek <michal.simek@amd.com>, 
 Mariel Tinaco <Mariel.Tinaco@analog.com>, 
 Jagath Jog J <jagathjog1996@gmail.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, 
 Kevin Tsai <ktsai@capellamicro.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, chrome-platform@lists.linux.dev, 
 Julien Stephan <jstephan@baylibre.com>
X-Mailer: b4 0.14.2

Since the write_event_config callback now uses a bool for the state
parameter, update the signatures of the functions it calls accordingly.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/accel/sca3000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/sca3000.c b/drivers/iio/accel/sca3000.c
index 36cbfcbba04d6920ba68bebd70d21bc3898a044d..3fb0f386c3db603714a746c28be36ee78d1b2a6a 100644
--- a/drivers/iio/accel/sca3000.c
+++ b/drivers/iio/accel/sca3000.c
@@ -1158,7 +1158,7 @@ static int sca3000_read_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
+static int sca3000_freefall_set_state(struct iio_dev *indio_dev, bool state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret;
@@ -1181,7 +1181,7 @@ static int sca3000_freefall_set_state(struct iio_dev *indio_dev, int state)
 }
 
 static int sca3000_motion_detect_set_state(struct iio_dev *indio_dev, int axis,
-					   int state)
+					   bool state)
 {
 	struct sca3000_state *st = iio_priv(indio_dev);
 	int ret, ctrlval;

-- 
2.47.0


