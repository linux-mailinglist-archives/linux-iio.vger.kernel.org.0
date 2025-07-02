Return-Path: <linux-iio+bounces-21232-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C24AF14BD
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 13:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E35C71C41B45
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 11:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE54326A090;
	Wed,  2 Jul 2025 11:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6V1V95K"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10A9267713;
	Wed,  2 Jul 2025 11:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751457525; cv=none; b=cMSqCNxUorsK2f8LVsGodY0pmPdQwfjoBJIEvzVexCsKVf4M8b9y1hohhFOoZZGiSdjOdgYa5iSIvqAvT/pJI1BtOnQ1bTfRCmR6GgK1Yo7BsWqBLlOmpkF/iyFKniRbaVVmhv63dqv30xCmrBXPjZqkbEHXD+O1CsS9XH2rqZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751457525; c=relaxed/simple;
	bh=j4zaQk3443uwBFzN3RZeEtxMq4iWxUJyfn0v7hoCR7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6ELi/JM05pl8etXcWcnPEzT+CHMMZaxk2e0yGa3EcosWRrvZfnnh7bvBuE31ekoNiqavhWFgY2Ep/fd5V4BUF7UfWDdzxkktprkAnx9a7/VF6ZK+Pd0wOIFyyADRwqtBGx5TgZg7ZWZZARSCYKmMvb6Dh53zWsd5sQU2fI0xfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S6V1V95K; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso75306006d6.3;
        Wed, 02 Jul 2025 04:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751457523; x=1752062323; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AHdUSz6zdOBXdzjVDNzo7fcMdTxOR8Umz2c1aHrjcZM=;
        b=S6V1V95KSpxBoT11m3dXCJWoc/ikc2fGEE+OQwKmRchFCnjwzFqC7J/ukzlkVwf5X6
         bKztY/adz+RtTGU18DUTFBpSZwPGkA1b9yAmuR03TwX2noIv078U3JYE/RVGdXtEri52
         xxJQR0tEqPKfeZYNjE4OBwGfZFzyt//AQ7M7DwL9XiFzYZqCPNTHxzKZMG+4NYKMddFD
         fNWh+XLXfjT4yDnOKUG2dwnnU/8NDRpwuzRjhqVHUEi6Fh2kpScKeOHohYKxr7iy6QSz
         yU3Pt52lThaQ0vp4BrR8o8/BEnw4wLkM9v763St49R/LZrZuYIyjBG8BlkJvhV9Z9dul
         nfsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751457523; x=1752062323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AHdUSz6zdOBXdzjVDNzo7fcMdTxOR8Umz2c1aHrjcZM=;
        b=dhcJswMZOrni8oB6e3Q6a/vrEVOLTJWlpAMJiH913CVsozsRkkfeFA4CzZ0bbVCdyM
         rDHFTZlRctpx2Nwn4VaZZsmyJL2sUfqZTPkWkgrrYw/CkqRK83gEbw/Q4GC3a+j6kYFx
         DDlLZz+erAfxPlMJpBURr05DFi38j0Q+oFj/0wOA2PzzsHiKg17/no5tMfkTn1dEjTJp
         XKWWYYDKaFyftVgG0yzeyFVEEUbCRIJxttO59aG4W1Jty7GEvAiBEynhRpEkmr4nnJNc
         egLTgzkoMFH/DU/HBElCpGO/lpb8q5K3WdljdPIjzSi6vKfSDYmtMEMwz2gOu+eUHz11
         ooQw==
X-Forwarded-Encrypted: i=1; AJvYcCVaSqwyY+o99abdteEKkfKWuxgSQ+q5MjZmvASqciBKAloLx/hy9owPUHwpvCKXfYniqHJ0GQouqBEZbQ==@vger.kernel.org, AJvYcCWRfn8dXV8EbATrI4HoOKOq6CJV8EvvyKPGBdDFUCzj/Mp/OdmdFWig9DYvbgrjNxbYULTqDd0QFYXP@vger.kernel.org, AJvYcCX4BJ4pdmWR611CsJjdyPWZkJM+e5CkO/clXNUlib/Fq2BiMQ4HmTnt1Jj8qkoG2/Ff8JoZJhAnLibI4YAX@vger.kernel.org, AJvYcCXNaj3tveLLg3cfWhIX38d8fQMCbygX2frlYOrVAT1zeUIP5wHKc6kCyJH9hP2nGbpUjMhsG1nu2EjH@vger.kernel.org
X-Gm-Message-State: AOJu0YwHr3fsb2TCV2OQzJwdKYtDed3jtvog52//3SZk/LbNxlM/CleL
	3cRCzJYQ72yL1gLVmJ6RvC8m0lYHbs8syUT15UZgD6rBDfqhra1t28eO
X-Gm-Gg: ASbGncuC2c6hk9zGazZwJW0OIlSGeM4vPMEHLJutRTTB4flR/cruXZ+AwLGJTG21c5N
	6iX66ysQsLScc/C9MU0kBMOPWoDCs0QukpYtJiDsnGjngl4EYWw6dCKCRv94pGeeInyKPmISD4T
	bP4CTH6oxEgvViP2Szj2s/BsPSz/4b9eKqwNlukxJzS/77M68F5T+QgxYI11zfuxAInT4pBN5DB
	PTvh35hzGGSrbGKZqgOQtK1j3V442NkjhopoW+XHEcv6pzi5jk3Y9K0BvBFa7CtElvoEbfMlbtc
	co1FYuOyHjrmI2RJsI411sdOrnKyM0AUZcVp1EL5Nu8RJV96zq+51zPPYEfN8y9yi6MU1w==
X-Google-Smtp-Source: AGHT+IEf0/M+lgmZ5heO4bWoN5HQq4mwLRCA+lYJli7e01rqSm4ANHsGq8i+pZuPVqMEdYxF2RE6Tg==
X-Received: by 2002:ad4:5dc2:0:b0:6fa:a0af:7644 with SMTP id 6a1803df08f44-702b1be899amr39658716d6.27.1751457522760;
        Wed, 02 Jul 2025 04:58:42 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6fd7730b726sm98600096d6.114.2025.07.02.04.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 04:58:42 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:00:42 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, jic23@kernel.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, broonie@kernel.org, lgirdwood@gmail.com
Subject: Re: [PATCH v7 00/12] iio: adc: Add support for AD4170 series of ADCs
Message-ID: <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
 <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGTpNNaW7cXC18Jt@smile.fi.intel.com>

On 07/02, Andy Shevchenko wrote:
> On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:
> > Hello,
> > 
> > AD4170 support v7 comes after testing the driver with even more variations of
> > channel setups. Signal offset and amplification can be tricky to grasp at times.
> > 
> > Thank you to all reviewers of previous versions. This intends to comply with all
> > comments and suggestions to v6.
> > 
> > Same amount of patches than v6.
> 
> ...
> 
> >  6 files changed, 3601 insertions(+)
> 
> This is weird. At least patches 11 & 12 have '-' lines...
> 
Yeah, sorry about that. These ADCs are fancy such that the base driver is about
1500 LoCs due to channel setup handling and support for multiple combinations of
voltage references and channel setups.

About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
after patch 7 and I think it would lead to '-' lines if coming before patch 10
since both increment the number of IIO channels. Anyway, I'll see how to further
reduce the number of lines being removed.


Best regards,
Marcelo

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

