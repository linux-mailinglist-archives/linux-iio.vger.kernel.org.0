Return-Path: <linux-iio+bounces-27682-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 11579D1BF07
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 02:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AE6230081A4
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 01:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2E028504F;
	Wed, 14 Jan 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKyPhD9v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618A61946BC
	for <linux-iio@vger.kernel.org>; Wed, 14 Jan 2026 01:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354368; cv=none; b=O/cm+050M6Zii81s+AgxiDVcrlZCJwR8Y1ZOykHaO87vUaT5ExHnPeCTr68TypM0jXwAQ6AHP6D+4tmJN5rqU9fEsTflC0wUngKhpOmEIFZDHfC+w/nm1NGIknWweqgjHYuGVHTILeZ0oxRrgOI4M4bVGMmPkCsZVjuWyXvlHaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354368; c=relaxed/simple;
	bh=N243u3X5fWK7S8yKjYYX9anKFwVrzaMHzyFIHXTErGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPCfyX+tdg5yuAxspQZKiUfEmFsQzaBJNm+Ppp6hvpJ4CVz0zWC6VwZuiXgeQVtnaY5rEUsPw6afBVvXkFKF4zsSmhPNCpmNaoolgF5uBsoVa1yD+kYyWqXm8BP2LmT0tUy4ZoqXbQe67AJmsaZqCCrBRrTLhMaFiXnQJQ2IykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKyPhD9v; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-5efa33b2639so1513395137.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Jan 2026 17:32:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768354366; x=1768959166; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zsefdc+MwhFoGG+CTzZehxsHmkCHIHGx4tMK4gMxl68=;
        b=KKyPhD9vGTEG2CrE5KAWrdSnVNEp3SofYHwNZSLEq6xZRTsVXiqzcsbun9zUjL7qR0
         PXig0UYVplN0dPZCcG01egfeqS7yngwlEKu1G6jOBsKqZBrGWa0ccj3OdENR/PPctMda
         cqDCAJdLowr05eUUwYBhcchv2gv9ebw2VYqH/AEqnjRtQ1JKl+k47flGCXdYP0Gsp9ng
         BkYPFAgvZk8JrWTfDe4OaCHHHpnHHEMjVyPWVcyOmJ2g16R6H2DQyZIn0qQI/qALwG40
         VPQwhLo4U1oYcX5ljLnhNxCcr//nWRLL3zwqVT2UEck2jliCaeNj4BwB+NJ/A7d4m5xh
         FORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768354366; x=1768959166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zsefdc+MwhFoGG+CTzZehxsHmkCHIHGx4tMK4gMxl68=;
        b=sVETjkSS9WyNpCLjhyyY8CGqJIFh0pltJwQnq+hB36ZKThClMgQEWs8DbZtmu42t/P
         0Bc4QSXBykph+NjNZAG3z20Q0/86zvsxukQqFQ41/AdMIVZZ0ry2I/kiq/Q0aH0UbNEX
         WmiSFiohU/21wJ6EtdK7gzA5Me/NpI9sX7i2feo44UITSwD2su8E12TdooZYqM17HoH1
         JrSdGqPG0VBB36e7I3LCJBx1tc3BIAb8VSzhGuIh0A7TiQiOCWcJ41NicHFtzRV5juoK
         q2CQVPSHBL0UPhn9g78OlElqRrucFaR3oXZf+SQKfNhOKfOgqZhzovLcD1LGdxEHoxw2
         ILaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5PJsLh6esPru1jlbCq2eeHO+kVkZ64sqieA19yJQCPVsAbvCHpUav4kbyQTgrOlMqk4Zakp/Jy5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+fZ/2DbBW7WsyLdc9e8mCfd6SVxTLMfbiGpcw5rOW8YQBXZz9
	B/py50gS3lvFAP0LTgcicti4MbeTwiaj+lZ2Guh8u/0duyF2DMzAxZRS
X-Gm-Gg: AY/fxX4ePDhMq/eucrtX/yR1vaF3LG+ggcrnscdx7/rgij5i5ic59XvWi7n7KSDgL6e
	flqtORXqxgUeBq0TGN6GLN7QVsOAqd/mwulv90skzV5WKQtvVn0EOaDavimc5a+gehKOwiiWSUy
	nINOquk1lQYoVxf0V+C1bbU2hEW9vnz/86pdfckmAOmJ+Vt0yzDFsxBwJtnxgkLhTm/D7/p64it
	W15De+0TE/lXXRXc7wWcMbxExz5hh6MS28c3Vj3aDzcfaAa8Mq5hzJPtbsMcI3skTyM5OBYa2vZ
	AD6XxtA09vH8y8OJpKEKyHYgljCow0bFPMTeWVIuCtsxDThlVRl0T+pJjtWCWL4Vm4xyMwahFBg
	a1AOTw8/13e7HlpUBsSCHJmw47EvueH3aL0eEXpUYolEFORv29XfduBxaOyyP43fk8lU0lIDBLR
	+tkvIgfiq3Tk+Xvcy3dpU=
X-Received: by 2002:a05:6102:d90:b0:5db:cba0:941 with SMTP id ada2fe7eead31-5f17f6310cfmr410757137.38.1768354365977;
        Tue, 13 Jan 2026 17:32:45 -0800 (PST)
Received: from localhost ([2804:30c:2766:a500:b70:8c42:f792:bef6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-5efaf4b2963sm11548954137.13.2026.01.13.17.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 17:32:44 -0800 (PST)
Date: Tue, 13 Jan 2026 22:34:32 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 3/6] staging: iio: ad9832: convert to devm_mutex_init()
Message-ID: <aWbyqKxgs4dV1fkx@debian-BULLSEYE-live-builder-AMD64>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
 <20251230203459.28935-4-tomasborquez13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251230203459.28935-4-tomasborquez13@gmail.com>

On 12/30, Tomas Borquez wrote:
> Use devm_mutex_init() for automatic resource cleanup when the device
> is removed or probe fails.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
> ---
>  drivers/staging/iio/frequency/ad9832.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
> index 35d8d51d5c2b..4bb203a67046 100644
> --- a/drivers/staging/iio/frequency/ad9832.c
> +++ b/drivers/staging/iio/frequency/ad9832.c
> @@ -310,7 +310,9 @@ static int ad9832_probe(struct spi_device *spi)
>  		return dev_err_probe(dev, PTR_ERR(st->mclk), "failed to enable MCLK\n");
>  
>  	st->spi = spi;
> -	mutex_init(&st->lock);
> +	ret = devm_mutex_init(&spi->dev, &st->lock);
Can use just 'dev' instead of '&spi->dev' after the update from patch 1.

With that
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize mutex\n");
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->info = &ad9832_info;
> -- 
> 2.43.0
> 
> 

