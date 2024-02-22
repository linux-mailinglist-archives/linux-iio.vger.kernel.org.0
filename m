Return-Path: <linux-iio+bounces-2889-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11B8985F164
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 07:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B977F283822
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 06:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0FE1642B;
	Thu, 22 Feb 2024 06:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qg2ioOhL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688F1156DD
	for <linux-iio@vger.kernel.org>; Thu, 22 Feb 2024 06:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708582544; cv=none; b=De8qyny9CCa4+Db5wewR+MJWSn0OUlQwdcKgEVvRZry5hJKzHyP9minOtYALemxNdhaaMZAwJn+vj89BTJn9OXX3FTprFsQekiwsycAAUSk1E2SjN1xzsT1NXP6neOMh7ZdhvGMV/8MLHZEg/1p77TX5mI9GagP3P0i48S3JAC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708582544; c=relaxed/simple;
	bh=147XQMUnoCd0ClmleOOh7y1eD/64PzMzGWzhpazFC88=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Sv2tOcIB77swHfUCanLObeLbAbWZM7Jh3UOrOytBTjG/jjQaY2oJXNJZehYj/qJ9XiSnfJpvmRMH1oSDjVUFhHIYrHe7YoW2+l4qrFLC7atYISv5xkudjrZOGzHrc2C+bkJ/wj4lt2bsoFiCp4zJM6URyxFRI7TciCE31aL4IlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qg2ioOhL; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33d146737e6so4893552f8f.0
        for <linux-iio@vger.kernel.org>; Wed, 21 Feb 2024 22:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708582541; x=1709187341; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Keqkv8FCF48d/7NwrtNWQmmyXMR6yDkcE3iXVzsS2CA=;
        b=qg2ioOhLej8VBFYG6bIWCEblbou+E52U52LwnKmtW2qTcpapzvgG1uQB4Y+RkgzyJ3
         PLadEONcWamJgVK1IV6ZdCAkK3Vv9qvlF0QHnDXKTB6fDxNCDo1eg1x2vtaxrqupt3TJ
         mjzGqLfezcu3iOrBFJXOGi2zLS9DMS4JSiYkMPi8v7EKvlw+YmwOOlcKoWs8A3NqSVTo
         FQIISwwGed2DdWijc6GBem4jExxTn3uYxRof8f0+hmhDoH2JhgJ5LeaUaWiKe+vvNLUe
         ECCqsou/VeUV9Yv68V3SE/7spSt8yEmOUXK9jMMKXUM879QY4AFU0e3216OkSFl4vEe2
         cT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708582541; x=1709187341;
        h=in-reply-to:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Keqkv8FCF48d/7NwrtNWQmmyXMR6yDkcE3iXVzsS2CA=;
        b=k/pDSXA/rxY/rH09/WHyxqUj94ZMZ6nkmsnFoUPvnY368QNtD0xFgtHVfNyWe4W/80
         OGR4IlKddf60tZ7r07M7TzwbHc4BkXCPRxSXgBzrd3ofXPSrEAz4NTBVXGOnApWEHK2U
         ywzid1oLFPza5BZNGH9nw4KZdUj2Rf9R6cFAOv7Gldim5sDmx1QOAmXEOASa4Dp9Hv23
         K73vm7zogQDQZVil8vFAikdU1f9V6PcE5CN3eruNmV8XSGc0LTMx6E1Csy+84wyVtFzX
         weZRgEJG3ABHbqG2eFLPeCAI9ui8ZPbCvb6e+N7pdMGZXLF66HDDRPv6vwtUbM8h+KN0
         6L3g==
X-Forwarded-Encrypted: i=1; AJvYcCUWVPPD232V7I4stwh55oY1yI6LcHZCwFe5RU2oIM1KOF+IK6jdkhf4tec4acALZtp4N9ejgkayfRm0Hl1Z6foNvxxGdpTSZZR7
X-Gm-Message-State: AOJu0YwwHM+OfD8XqeSVk/jswoAbSojciWmZXG8tiJuFNJRUwdturPaj
	mtlZmVPGAUBtz14ddCiTPeX8XrYKthuoBjuYsJGfe9C3ZVqVhyL0GZrtEJScQDE=
X-Google-Smtp-Source: AGHT+IEN1UoorI8CvmFW/dCEroCtCwikt6G8NDq8DdZrsxY6xE2pIDqISjVhUBQtJyyfXAYziU/APg==
X-Received: by 2002:a5d:51d1:0:b0:33d:6554:e1f9 with SMTP id n17-20020a5d51d1000000b0033d6554e1f9mr4738440wrv.50.1708582540814;
        Wed, 21 Feb 2024 22:15:40 -0800 (PST)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id o18-20020adfcf12000000b0033b87c2725csm19183702wrj.104.2024.02.21.22.15.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 22:15:40 -0800 (PST)
Date: Thu, 22 Feb 2024 09:15:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH 2/2] iio: adc: ti-ads1298: prevent divide by zero in
 ads1298_set_samp_freq()
Message-ID: <c32c9087-86de-423b-8101-67b4a7f9d728@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5f393a87-ca8b-4e68-a6f4-a79f75a91ccb@moroto.mountain>
X-Mailer: git-send-email haha only kidding

The "val" variable comes from the user so we need to ensure that it's not
zero.  In fact, all negative values are invalid as well.  Add a check for
that.

Fixes: 00ef7708fa60 ("iio: adc: ti-ads1298: Add driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
I wrote this commit message in a very confident tone of voice and I have
spent a long time looking at this code so I'm reasonably sure this
patch is correct.  However, I'm not super familiar with this subsystem
so probably you should double check.

 drivers/iio/adc/ti-ads1298.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
index 67637f1abdc7..1d1eaba3d6d1 100644
--- a/drivers/iio/adc/ti-ads1298.c
+++ b/drivers/iio/adc/ti-ads1298.c
@@ -258,6 +258,8 @@ static int ads1298_set_samp_freq(struct ads1298_private *priv, int val)
 		rate = ADS1298_CLK_RATE_HZ;
 	if (!rate)
 		return -EINVAL;
+	if (val <= 0)
+		return -EINVAL;
 
 	factor = (rate >> ADS1298_SHIFT_DR_HR) / val;
 	if (factor >= BIT(ADS1298_SHIFT_DR_LP))
-- 
2.43.0


