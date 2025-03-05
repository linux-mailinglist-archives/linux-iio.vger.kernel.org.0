Return-Path: <linux-iio+bounces-16434-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28101A5040F
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 16:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BA4117331B
	for <lists+linux-iio@lfdr.de>; Wed,  5 Mar 2025 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F73F2512F2;
	Wed,  5 Mar 2025 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4TqhQuj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71F52512D7;
	Wed,  5 Mar 2025 15:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741190368; cv=none; b=cKGQKbEGKiPhDhuMCBxV3++/vAlQltZ8hG0OknInDUDaliozY1g4FerH3vMQ6GZhc4S7l9ZvYeSrst1pZ56kBvf1cMR4tP3PiCFvG38pQ95QsTfyoLHy5Mtf9vxazafaYkivkLdL6Zl+N68gAluSttzhFklu+f6M5OM+X8qa1v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741190368; c=relaxed/simple;
	bh=y43NBX9/dEA3UbtBX620A2NwPamDY1IzbS/4LLP6ao4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHop3ezakkcjG60PZnH+EkTSRRn7RIsUIulfkZ25A89KCfQQ+StmHYdcf4otj+xaF1pIet8HI0mZhZupnH5Mw7t9rHAJs2ZDoW3r5fbPEXa5xGTVfzWkGLV/WhQeF4f3pS8DAfZXOzCH8cWWQbZO4ZhGPEN+rna4T+80MMOoHaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4TqhQuj; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22401f4d35aso9902475ad.2;
        Wed, 05 Mar 2025 07:59:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741190366; x=1741795166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AbttPQ2//vu2JOzFy7P226VnKJBZhveO8Ra+kZ4Mt3M=;
        b=U4TqhQujzHP6K39jjLIzk8eYDZsCWEMnR/ThLC/rqXLozmw7glxyE9xFNSZ88MS7Qv
         OZmpKU337hpeq8PhQA6KOY4oefmEaYRx+ioegp+UPyBfnerxwfKZwSWYsLQ+ynvMlB87
         jYnzI5XU2UpcAgx2QJfi7bdldXDyN6U3MESuiBKBk8r0QgdwPBEbXTKKbv0+/88lBPj7
         j6B++G5LLqimO99NKNkf2kenEbXxJUyM1O1r78AuMDAESPuHWszmV+c8HV6NQEYMOMug
         YP6imDqmk+kRPhpoFPRwCg+8e+C3K62RGaIG9Aa8tU40daHnyrOliZo9q5FJoiFiMiA9
         CPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741190366; x=1741795166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AbttPQ2//vu2JOzFy7P226VnKJBZhveO8Ra+kZ4Mt3M=;
        b=radk5APNmQXe+EtehbibHnsYXGCQm48EGgCAM7HEgwBv/d2wKapusG45bFvaCYgr83
         50FbnRgKxoajJBfnUdOkrtjYj4Tk4E0RofWmU6nIQIArbNXVfB2kmjqY6n8p6FPYGqYl
         hrnceC52/jZdvCC/rLuG4R+xnYHavtCME8XumKMLBJkyFuuFQJD70joC5y5t3I3N5X3P
         yzDWp57AwvG9gGcSZncLFBhe9VLinTif2FVjrL21rKLb0Vj5wJsCqnsPQNBHT9Sk0xz4
         cu8DlHbzt/txPGiPUuwX4uoC9guHhKrhJ6UaItESmBloLO4Fg7BxXceyJqb+w26JjlTW
         7RuQ==
X-Gm-Message-State: AOJu0YwvmPAV8jnSJmbhYyJLyk+CtntdDlzIIyLn8MgGcA5pMHlqkV9B
	RD0jE355/1hp4Q1dKlXBurfl/FRB4viiFOlSPS6vQ4yIHfAc2jsqMjYG0BZ0tls=
X-Gm-Gg: ASbGncuealjba4q370iV7HUruUvFraCkSdc0mHHGxFIC19nnShM0ynW1MK+eiO1ZAiZ
	nTrchdZbiu0gebrvQ/Mv1BsRDFY908dJA5zLPUPnU9X6BcJJvUV54f40AfdEnKAsgfefEKfHLKc
	slo1B6vLM85/nqEVupP38L81mI0lbv1EYNQ3ZWQ93sAOcydxEF3/TIEiUWoPZZRz7HPrkr+G60T
	Jrv/AF2/HArbjBw3uvFFin5G6qSZZuUp6n7tPtpmEY0IjsITVKuNK9EbBxfJyx4ONnQ0R19VUwd
	bBqRFEyqsoXrRQ5+Wp1Z9PZoQue8D93i4zuIXw8dct/Cy/yZVzjKChVSPgjGDRI6GrQ=
X-Google-Smtp-Source: AGHT+IFRsSdTIXQKmtW0X087x3MBdawJhi4fi22hKHtJpyG3BYGckMszeQxUjNr/HzcoMS/Ufnw1FQ==
X-Received: by 2002:a17:903:2452:b0:224:78e:4ebe with SMTP id d9443c01a7336-224078e5203mr4297495ad.33.1741190365953;
        Wed, 05 Mar 2025 07:59:25 -0800 (PST)
Received: from fedora.am.students.amrita.edu ([175.184.253.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223501f9d96sm114914245ad.54.2025.03.05.07.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 07:59:25 -0800 (PST)
From: Siddharth Menon <simeddon@gmail.com>
To: linux-iio@vger.kernel.org,
	marcelo.schmitt1@gmail.com,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	linux-staging@lists.linux.dev,
	lars@metafoo.d,
	Siddharth Menon <simeddon@gmail.com>
Subject: [PATCH 2/2] iio: accel: adis16203: remove spi_set_drvdata()
Date: Wed,  5 Mar 2025 20:59:12 +0530
Message-ID: <20250305155712.49833-4-simeddon@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250305155712.49833-2-simeddon@gmail.com>
References: <20250305155712.49833-2-simeddon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The driver does not use spi_get_drvdata() anywhere.

Suggested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Signed-off-by: Siddharth Menon <simeddon@gmail.com>
---
 drivers/staging/iio/accel/adis16203.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16203.c b/drivers/staging/iio/accel/adis16203.c
index ac4b28bcd766..ec21365bb391 100644
--- a/drivers/staging/iio/accel/adis16203.c
+++ b/drivers/staging/iio/accel/adis16203.c
@@ -268,8 +268,6 @@ static int adis16203_probe(struct spi_device *spi)
 	if (!indio_dev)
 		return -ENOMEM;
 	st = iio_priv(indio_dev);
-	/* this is only used for removal purposes */
-	spi_set_drvdata(spi, indio_dev);
 
 	indio_dev->name = spi->dev.driver->name;
 	indio_dev->channels = adis16203_channels;
-- 
2.48.1


