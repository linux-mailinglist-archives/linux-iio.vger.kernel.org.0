Return-Path: <linux-iio+bounces-11079-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572799AE047
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 11:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868D61C22189
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 09:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5954F1B3925;
	Thu, 24 Oct 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1NmFT0VQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CF31B6D06
	for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 09:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729761176; cv=none; b=qZg0045Ulf9EYYbOPZTu3uEhzbSd9v62dgIufR0rRX1OmW3sjfSz/3KdWZCwklyqUZCf6HnSGXngmAJ0s+fDZMXmBX6bYlLFNrp46KyFULoYlN2CWrs53sM+E1/TCwcuVr1GhCrcwW+aDf5+ErE1X5+lj3SS/wUWIkKPq4ZBgwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729761176; c=relaxed/simple;
	bh=n6B+DjS2nlSaMuuYUonULXAepr11BX8wK2roVoPsJ3o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IfHFarzw6sN0SKsZvatCydIXHxOnd/B4pLYQsJwNNRGgU1NC9Jbi+Fblc6x5IiLB+SL25w68d/ymUIoHlM4YVDHxEr7cRMEO3QG+HDX3NbPXe44ZJmtPQ2B15b2Ip0tmJ+KdwKOmKMZRaNrHMscbs/VDmXJ3+rBEXD7Av+hXqko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1NmFT0VQ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d473c4bb6so572296f8f.3
        for <linux-iio@vger.kernel.org>; Thu, 24 Oct 2024 02:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729761172; x=1730365972; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xPO7uddPmJGeRvDQ4DDNm675wgeGPQg+TX6wZtIY7Fc=;
        b=1NmFT0VQLB3HRxKOzIOz3k83izXhUrDPgdUuVCnisKTeieboFDcCb4p+7/VdFIblbZ
         mRyLklBao9aleVeR2yTyQ4bJE8+KOAb8JJRZG5krEpPWw9APxA2To09rjf43l7Du1/XX
         DgT+pBaT/bayqqVU32riMajVRrFG91Dd0tGo+Cr4CqsC7I1POL8OvCuClHN+JjyIdx3a
         V66rvF/7Arl05uqnwWt8KtQPyhQfTj0RmpH8xEyzHoTRRFACuUpOohx/fJoLP0bvH0Kh
         e/CBK/BOMUkek/uFj32IpjF0zL60jX8cvYOoaw+h4sRAH02Cn+4D5LH4maIBbcnQz213
         JvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729761172; x=1730365972;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xPO7uddPmJGeRvDQ4DDNm675wgeGPQg+TX6wZtIY7Fc=;
        b=klX6LFQvlSmxdGLfM2pg//ckjxP5tqZP1PiuJd7RLL89DHxv0/HNAeKVsbYMR7Ip2t
         y8IdMaju87pX+81pzncVZ+JyvU8jAWGMOZ33UKPcfrP15GGsnI73c7lSSqH9hShfMciz
         /jhPVcjImL7hg2k5/n144+/f4cXsMFJt1cD0jToDijJQmeD49qEeWm34z5BTZuJPuU+T
         1cvJ8gHgB3dbyIBhT/YVtVahg3wTBvijssJmlW8c/3yijtYqhKUvZfIL0Q1K2hGSiMNL
         HBuunxkgbDp2bR9MzZ3k+s81vnhuyBuKSSwNqmiQmWJpIerAFxFN/MI57j3fS65y3aL2
         87nA==
X-Gm-Message-State: AOJu0YwX2qoL0JtwGJuWrEvV6x2yNr0ccNtxRDtdbwDeG85cXrBCXrBQ
	/XvcUmCs39XxQGLnZr0CMJTdV68tpGXDuuetRDNpE4cubeTS/Fq0ggzmqDHWeDM=
X-Google-Smtp-Source: AGHT+IGaN73d/bgLeVCGlsGNxd+TOv2AHPR97BWrXwTr3MwJBwZ4zF+VJDI71VQ8iFHk0s2jf5QZwA==
X-Received: by 2002:a5d:438d:0:b0:37d:5042:c8de with SMTP id ffacd0b85a97d-37efcf06011mr4293964f8f.22.1729761171775;
        Thu, 24 Oct 2024 02:12:51 -0700 (PDT)
Received: from [192.168.1.64] (2a02-842a-d52e-6101-6fd0-06c4-5d68-f0a5.rev.sfr.net. [2a02:842a:d52e:6101:6fd0:6c4:5d68:f0a5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0b94071sm10843701f8f.89.2024.10.24.02.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 02:12:51 -0700 (PDT)
From: Julien Stephan <jstephan@baylibre.com>
Date: Thu, 24 Oct 2024 11:11:26 +0200
Subject: [PATCH 4/7] iio: light: veml6030: simplify code in
 write_event_config callback
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241024-iio-fix-write-event-config-signature-v1-4-7d29e5a31b00@baylibre.com>
References: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
In-Reply-To: <20241024-iio-fix-write-event-config-signature-v1-0-7d29e5a31b00@baylibre.com>
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

iio_ev_state_store is actually using kstrtobool to check user
input, then gives the converted boolean value to the write_event_config
callback.

Remove useless code in write_event_config callback.

Signed-off-by: Julien Stephan <jstephan@baylibre.com>
---
 drivers/iio/light/veml6030.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
index d6f3b104b0e6be8e095a1ad9f20acb81ce492630..95751c1015909cd80543a559673f435d1a168f68 100644
--- a/drivers/iio/light/veml6030.c
+++ b/drivers/iio/light/veml6030.c
@@ -826,9 +826,6 @@ static int veml6030_write_interrupt_config(struct iio_dev *indio_dev,
 	int ret;
 	struct veml6030_data *data = iio_priv(indio_dev);
 
-	if (state < 0 || state > 1)
-		return -EINVAL;
-
 	ret = veml6030_als_shut_down(data);
 	if (ret < 0) {
 		dev_err(&data->client->dev,

-- 
2.47.0


