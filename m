Return-Path: <linux-iio+bounces-9981-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 673B398C6C4
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 22:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280BD2849ED
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 20:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4B61CF5CB;
	Tue,  1 Oct 2024 20:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGpoFo0w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2E71CF5CF;
	Tue,  1 Oct 2024 20:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727814122; cv=none; b=MoO0FIzdXnHwiV3LGL5n+6errqBohyL5qKAJRLfWhJkLw/XwisGYlV6M0g4LT8OrD23O0zKp08Jeb39HDtnBdVkR9v+QlsJHatXEZQ+rUIOjKEezM4klPQ9DLBgz6ghRMdMoiFWxf6pnFalWhf/dSTeDvr9Y50lN67TkNvQixyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727814122; c=relaxed/simple;
	bh=6FdgvinlhFTPyzFS1cRR4OBTLX5M2H3vaJ1nXi+ddos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+SyveIX8S01ZFUxLNAkDslPEb2N70lSLGsy/bzJRJWWjrLpWRyhP7/SLs7W+31AJ06M1p939yu7aHw+QN8N7k+cfQqISBF0QfgMkxGtpxxbWaLvCsdFyRZ5vvnBe06M6uWp6dZV8VfeparjSF9grumHGWjpEWwxJxcABz7puK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kGpoFo0w; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so21957025e9.1;
        Tue, 01 Oct 2024 13:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727814118; x=1728418918; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2AjnAb2fU4G/kpoYJbvKEuDGRJMSHdPRKJh3hKN4HM4=;
        b=kGpoFo0wtoc8xd5h0eHgZNANrLHUL4ctiErrX/71pzBe17Yb9ARi3qC2cZXlu71AF1
         +peHOPuISM4fxK22+4Lrwya+AvPtZOL4YvHh3v0k6x7g6qmR6hkwUNceU7Piql3fWJb/
         acEQ1cQpnZ4Y/2772s0sz7/vOGfBSnoiB1ZZjtuLvQMkcVe4MrV6crWzdN77Ah16WJ2k
         8pky3FTFGwofC5Cnt10HwuIUwrQR32i6TPDgO9GLq13tD0A2P8xI0OMHe5TOfXlGg5xX
         jEJig5OipaHblecHWXBDjfRucgF3/nB5gKGcPBkPhVVePqCTdM+vXfQytbOdLl1PzwOi
         tWrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727814118; x=1728418918;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2AjnAb2fU4G/kpoYJbvKEuDGRJMSHdPRKJh3hKN4HM4=;
        b=fCok/17SbFHpM25v4tlRCDkzFEM3UhYojp6EjIcVm98YUeasu3xoNRXNtC6fyan93z
         LqOktAa7G8LXXoeIa+3SSu9wGGRF/7HZLQo/tmSOsk4pmbFxL+UXpDbvYLxi3OAfP99j
         3a874M/+UgH+tfV328Q05eLmmwqyk/erNwQVK5KHSNr+8L0FCTafzpOZuZ62DxhRv3oT
         CLjD6e2VVM9YZTSzn8tXyDm3Qly936TBewbkUy6kTJQNcs6hAfu1SkwcpK1KG1a21j6m
         o822Iph6BoZdMvu3yx98WnPLnb91tdttCWXGlEMmh4b9/AhReGWkWNaEXx+H1fIEgKtj
         GlCg==
X-Forwarded-Encrypted: i=1; AJvYcCU9QDJGrND9khs3WNcNNMOhIvQ9PZ5f7OPsNlmNa6io98+xfN7oLrdDJovQ3kkbbWo5lRc+3pz4SNrDQYfu@vger.kernel.org, AJvYcCWRW0UUL99mIJs0AG4YpWj8SAwWu9YuCriHh6qlVlls/HdiThaIjSeCF7DnThTbBhAPeDnPPnbZgkxH@vger.kernel.org
X-Gm-Message-State: AOJu0YxnnECKGlQrbk0Y8dKrKlD4I1YezImlQnq8QLny4feOTvOB6xrw
	y5qxE4pYDPtHrwVNWTFxSued1ZP5gAo5M94cFZEblLqE+olfH43Jwi14ojA/
X-Google-Smtp-Source: AGHT+IGAEJ7v4r5lwzCjG6WtYFulkb3KxzrHOVLqH6D3v3U85UA1HsgjOFERjrQJ+9YYOAhy1xz6og==
X-Received: by 2002:a05:600c:358e:b0:42c:df54:18ec with SMTP id 5b1f17b1804b1-42f777ee3f9mr4438865e9.28.1727814118137;
        Tue, 01 Oct 2024 13:21:58 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-41f4-a392-01d5-d74d.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:41f4:a392:1d5:d74d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e96a55336sm188680935e9.47.2024.10.01.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 13:21:56 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 01 Oct 2024 22:21:19 +0200
Subject: [PATCH v3 6/9] iio: light: veml6030: drop processed info for white
 channel
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-veml6035-v3-6-d789f6ff147c@gmail.com>
References: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
In-Reply-To: <20241001-veml6035-v3-0-d789f6ff147c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727814089; l=1568;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=6FdgvinlhFTPyzFS1cRR4OBTLX5M2H3vaJ1nXi+ddos=;
 b=O/L27EDv0iYqC/1NBfcPqeNFaUtH/dE0y0voKVbrs+wLvQrLw4wTQW25bnbhL3qpoHI7YIFGr
 zvDrb0Lgs1DA9tYqcA12MEcgzDEcToKfuVx2MNBQuHgY1VsQdIZ4ul3
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The resolution of the WHITE channel is not provided by the manufacturer,
neither in the datasheet nor in the application note (even their
proprietary application only processes the ALS channel, giving raw
values for WHITE).

The current implementation assumes that both resolutions are identical,
which is extremely unlikely, especially for photodiodes with different
spectral responses.

Drop the processed information as it is meaningless.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/iio/light/veml6030.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index fe6d2f9a2e01..677374e401b3 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -210,7 +210,6 @@ static const struct iio_chan_spec veml6030_channels[] = {
 		.modified = 1,
 		.channel2 = IIO_MOD_LIGHT_BOTH,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
-				BIT(IIO_CHAN_INFO_PROCESSED) |
 				BIT(IIO_CHAN_INFO_INT_TIME) |
 				BIT(IIO_CHAN_INFO_SCALE),
 		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME) |
@@ -549,11 +548,6 @@ static int veml6030_read_raw(struct iio_dev *indio_dev,
 				dev_err(dev, "can't read white data %d\n", ret);
 				return ret;
 			}
-			if (mask == IIO_CHAN_INFO_PROCESSED) {
-				*val = (reg * data->cur_resolution) / 10000;
-				*val2 = (reg * data->cur_resolution) % 10000;
-				return IIO_VAL_INT_PLUS_MICRO;
-			}
 			*val = reg;
 			return IIO_VAL_INT;
 		default:

-- 
2.43.0


