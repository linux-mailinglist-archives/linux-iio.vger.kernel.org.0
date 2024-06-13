Return-Path: <linux-iio+bounces-6243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC9C9076F9
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 17:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5022B215E5
	for <lists+linux-iio@lfdr.de>; Thu, 13 Jun 2024 15:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C076712EBC2;
	Thu, 13 Jun 2024 15:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="BAy1YTb4"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C4612D757
	for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718293209; cv=none; b=sdXT9WGYHv7gso4JGxsnFg02mWKlnOlUpetfZR3vB4BKtn1njEIY9R9wctdmjzJHprMDXfh8VEkQd4T3grH7W4uo9f4lOmA+5ouAypsI82QGvt5b1BuUdB1a+L9lbVpTtr1xeqbV/qKRz0fB/KobEVaEz+xLBMmS1c7eAPEpk84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718293209; c=relaxed/simple;
	bh=9F1r6fMIFpJ191wYDdUBAIvKyGxNR2C6pRAql0oKqts=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ew2QaFVk3a5t4xQdUdpjFTLMrPj5zwAHkCXlQSdoSHQUDpBly35otWpr8Hc2KzoLUpzBKfD2icqyZM1ygWyz4n7Uouj3McuUHGpLyQJnXduKTQCbGmynC+R89ujM4mDiBE5YOD+fHm5dBN47XKNaR9YqzbHYlbg7ALGPiJbcWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=BAy1YTb4; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f64ecb1766so9812215ad.1
        for <linux-iio@vger.kernel.org>; Thu, 13 Jun 2024 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1718293207; x=1718898007; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xwy4ZY2fAWTX1/LToOManh4tRSUd/QcHGpIvOCyd04I=;
        b=BAy1YTb4UEYcyYqCq7lSSP6QIcUKB5sTVUHBFFnGpxJsdrAZqa8ZCYd1ldA5mMn3Hd
         oertl/8J9wejs5dn01ilMxowuus9+GYqvS6i80jATwcTMJbKD2QiePAXLFwxM3n3pF4G
         E4t7QqJfW081JS067WCI+RGWWcGbkcpgCzlSxnMcLmj8YcoHUk+msZ9eNYHZuKflBv+3
         vKPDbwAEo71PGGlMRdQeW2ev2z2DXwyvbyS9+aUzhgRQ/kHiJn70Zuohaovb+11JI5hN
         rbKeXoATpblGa0G7Bj3vKVEKAzeH6u/smcC90yUZXCUB4DVYx+UOG6kZc5YdPMC5gX0V
         eHLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718293207; x=1718898007;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xwy4ZY2fAWTX1/LToOManh4tRSUd/QcHGpIvOCyd04I=;
        b=mKW/boDAW6RAPvVLMp4M62IChMlfgCo/3/9Gk6T89u689fYTW7JM3f8UkvNRrQVYkv
         mArorEVX9t3NnnO9IXr8GNZnuhEJ+c4xpxKZPa3DEEgobef8c57Iv8G4/FUuo3de8nAO
         9zrOgwkxt3Y7blPbzlkkCFRlubXNmF4JYSJpM5D8+SvD6ph6CMvoqm1POVvEPFx7dzVX
         fBTM7OPVHrdo+LgCORnsGVPf75v0g4tLleWcT5SK/tVJEqNnykxZ98Zuck/vNfIsMxo8
         HMSQizhz2t4yecZWzpVThID1ham+CjX1z+7Ac76UBmjAR1z4cct1xxFPp1bo8yLSucQU
         3tdw==
X-Gm-Message-State: AOJu0Yx+Hl3rrDWIj02nl5alZOQqIOWGiiJCgWtzjLrIPNUjNY3MBvQk
	B92uNHmTWhKLh53Y7uOG5SpMh9DOfMg7wVKHLotS2CsVp8kjgVd7DncsPN9yB4kwiGcROcGvDeE
	8rYmE0Q==
X-Google-Smtp-Source: AGHT+IE/0tI7V5L5N9Fj8xnZggEloUyrVKwpFhYrdA5bCC2+3AA/uiDpTVRVp2vytiKGlTIlnv3cvQ==
X-Received: by 2002:a17:902:e84f:b0:1f7:1579:6d9e with SMTP id d9443c01a7336-1f8629feefbmr87225ad.58.1718293206902;
        Thu, 13 Jun 2024 08:40:06 -0700 (PDT)
Received: from hagisf.semfio.usp.br ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e55d7dsm15372295ad.14.2024.06.13.08.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 08:40:06 -0700 (PDT)
From: Fernando Yang <hagisf@usp.br>
To: linux-iio@vger.kernel.org
Cc: Fernando Yang <hagisf@usp.br>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Eduardo Figueredo <eduardofp@usp.br>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 1/3] iio: adc: ad7266: Fix variable checking bug
Date: Thu, 13 Jun 2024 12:39:18 -0300
Message-Id: <20240613153920.14647-2-hagisf@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240613153920.14647-1-hagisf@usp.br>
References: <20240613153920.14647-1-hagisf@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ret variable was not checked after iio_device_release_direct_mode(),
which could possibly cause errors

Fixes: c70df20e3159 ("iio: adc: ad7266: claim direct mode during sensor read")

Signed-off-by: Fernando Yang <hagisf@usp.br>
---
 drivers/iio/adc/ad7266.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
index 353a97f9c..13ea8a107 100644
--- a/drivers/iio/adc/ad7266.c
+++ b/drivers/iio/adc/ad7266.c
@@ -157,6 +157,8 @@ static int ad7266_read_raw(struct iio_dev *indio_dev,
 		ret = ad7266_read_single(st, val, chan->address);
 		iio_device_release_direct_mode(indio_dev);
 
+		if (ret < 0)
+			return ret;
 		*val = (*val >> 2) & 0xfff;
 		if (chan->scan_type.sign == 's')
 			*val = sign_extend32(*val,
-- 
2.34.1


