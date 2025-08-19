Return-Path: <linux-iio+bounces-22994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78330B2C806
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 17:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED604586BEF
	for <lists+linux-iio@lfdr.de>; Tue, 19 Aug 2025 15:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128D280A2C;
	Tue, 19 Aug 2025 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFbsku04"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C802A280033;
	Tue, 19 Aug 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755615662; cv=none; b=ob6hAzUxbMjWO4/DS9LVySA4E2A8w3/EKCUgon0IS486ywI679jVT+kxIMSgtqHnlLzeMQu3XYnL7vpKMJDWZU4eJwjx+8yFpHnsu1wLhkbzXWyHnDt0/cRx3/bt3WVCyC5yb3pVIn5R1GS4UH93skjylpDZsHuCw+zzEMuf45Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755615662; c=relaxed/simple;
	bh=5RpsWVB0n0bphyQyLM5I1WxpQHwU0IHdjHBWA35pyWY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rR6xtZTqtVKxJk5xbSir8xWIMPfm+a/djZhqelZZY+RPDtKfDf6KB/lBMGWTvYdXoioLNMXqZyCCkkSqQm19Hfs8xxmgpQN4aroI7AXHHHWgdvIoA/ekzaEVdyOZUgFu1EY5jMkTt/WG7Jd4Hc8bfLjroupEIzJemKiHqcoRrVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFbsku04; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3b9df0bffc3so3631778f8f.1;
        Tue, 19 Aug 2025 08:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755615659; x=1756220459; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h8WEap3IwD1NSco90tPoqFQ0hlFvq3zg4DyIPbT8+y8=;
        b=FFbsku04HfrW1rWt5DU81M+ieG/yVxXe16MaSbCjYUqLZXFb6OeTeMnjrFaTOw2Ypw
         3B/XbOtHd2zov9Yh6SPWOKCKyGgpuGsCK/tTTjlZ8rd+lW9xoJRR+u/990XiDpdz5L4m
         Z01W6QGrEY+KheBl9RaahhzUvVJGVVEQKJs2yc+XotDNhKfPpr5TghIegx3yje/kk7je
         5iiNtQmwcodO1TIoWFbQsu5CdC6y5JbnaOiIYdQiBAQ3U1UWwT/jpRPeJEGMHTXFTF69
         xt+vPK88DOaOAxdclCa5qVm41UW094OMpxaoKp5k/F0F8tZN+eWa+ltvKetKRG69br6B
         Mppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755615659; x=1756220459;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h8WEap3IwD1NSco90tPoqFQ0hlFvq3zg4DyIPbT8+y8=;
        b=UKitDVc+QIWhE+t+5A1/zW8eB/+q4bgmHL+HaSeIt3E/15b0Td/S4V4O5HmTctiDTZ
         jMEvoOZSUfyl4Dp48J19jbRJvjuzX12rkUzJdLi0xEeBEIqJ3CIUiiRVU8L5yRoDlptB
         9qVnWmm8+upDeBqArk8Wv+PGinZ+EDpv7VHlg/6L078qUaiMe6ur5EeolEFUaqifHKrs
         1zhXVHJKiIhSHIaIwnkUxaiWXfdXoSG/E+9t2jMlWAS2+W+Jcl+VN762cP97epKu6RfV
         yrIUrCClrJbP9w5WqoFjNcQTNTjHtJhph/tHP91SN7sQNx9RgGz7g67Xu/mcdNjRf9ny
         6rwA==
X-Forwarded-Encrypted: i=1; AJvYcCVaSdkcfVZ3zc0luFCxhrE/eTnkv4doxhJ/BK2N0vOsD+16ijouwi065sZ+LuPuvvTcHcRND1UGO4M=@vger.kernel.org, AJvYcCVpT/mJWdYkRy/066cQtRZaEI0XLl2LBzrDXRIiBQac486IPvCvXQMJL8xK4bQ9H13hmiX4XrgGG1vTVi8v@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81Xw1nLxEUQexiIvdn2vz4H0WqWAPSpFabL/X4QRyL6jO+9pv
	dPPZRHla8AXErztLzT7itPUT6h9Obofcnj/JwrSSTszA7wVDi1Mxz7cF
X-Gm-Gg: ASbGncsmbSIwzKI+shkHllczRh9VOv/yKuK9xd4QtdfefQahwKQxajP08re+VP+ClRI
	7xN5wZr8A1WZ13iUfNQ4Pnj+XIgRThN3PEyRyKFAip+x+FUDZtF4g4UhkFdiqB/VOuhbVt03+gC
	KkAGcJ+jPJG3/LaEzjrfpZQO4ZVGIuxmEZlYbtYtJrdwnhMJgMn+30wfqp4HX7ozERqBFObWkLe
	MCUARkBJQ0sfKygSlppGkUQaQ7NwuXP4kkmPszM7vq/2fO5on3r4jLP1U9tDSApSxPDY0ylpaXg
	z+wNH97fQkSsK2sjvryD8azVpe2OUsvygt9GcIW8lDc8GlZmxSQuNLoYoZFJqLxbrGZz5+QvDMo
	vg+5gHt+PZ2vN+nz+tRw=
X-Google-Smtp-Source: AGHT+IFQ/Wz9NMqV3EvDIM7pmIbPfTuCUm8GbWIbDx6xEi3yYqIM6OxDad3PmKCCQKJ6HgsFaVlGQg==
X-Received: by 2002:a5d:588d:0:b0:3b8:d360:337f with SMTP id ffacd0b85a97d-3c0ec756374mr2234545f8f.51.1755615658550;
        Tue, 19 Aug 2025 08:00:58 -0700 (PDT)
Received: from pc ([165.51.6.90])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3c0771c1715sm4344520f8f.36.2025.08.19.08.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 08:00:57 -0700 (PDT)
Date: Tue, 19 Aug 2025 16:00:53 +0100
From: Salah Triki <salah.triki@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: salah.triki@gmail.com
Subject: [PATCH v2] staging: iio: adc: ad7816: Drop unnecessary
 dev_set_drvdata() call
Message-ID: <aKSRpTuwA0P-ZaUS@pc>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Remove the call to `dev_set_drvdata()` and the associated comment
since private data is never read.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
Changes in v2 :
   - Remove spi_set_drvdata() and outdated comment as suggested by David
     Lechner
   - Update commit title and message

 drivers/staging/iio/adc/ad7816.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7816.c b/drivers/staging/iio/adc/ad7816.c
index 4774df778de9..172acf135f3b 100644
--- a/drivers/staging/iio/adc/ad7816.c
+++ b/drivers/staging/iio/adc/ad7816.c
@@ -359,8 +359,6 @@ static int ad7816_probe(struct spi_device *spi_dev)
 	if (!indio_dev)
 		return -ENOMEM;
 	chip = iio_priv(indio_dev);
-	/* this is only used for device removal purposes */
-	dev_set_drvdata(&spi_dev->dev, indio_dev);
 
 	chip->spi_dev = spi_dev;
 	for (i = 0; i <= AD7816_CS_MAX; i++)
-- 
2.43.0


