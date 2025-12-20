Return-Path: <linux-iio+bounces-27253-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D551CCD27A1
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 05:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D5CA301227C
	for <lists+linux-iio@lfdr.de>; Sat, 20 Dec 2025 04:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3EB62D1914;
	Sat, 20 Dec 2025 04:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O8bUffGI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A93156236
	for <linux-iio@vger.kernel.org>; Sat, 20 Dec 2025 04:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766206287; cv=none; b=NoqP6nB9V8T23Fjw4rCV7VTLUSbbJxjXeGDZKP32zx9O9W+4ReL81H+eMbOTTFf4MxXnaNw0itsMFO4tlcg+IyWWIy5xz1ASFk1kwBva7Y8OGpMY+AZBgPrhROTh7o4SBraQ7F3H+YJlx6ZpFgKu0xt/Zf42TwPRVefoIBzprKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766206287; c=relaxed/simple;
	bh=4lttTiT7yHtS61u4orrfa3+e7yCTVNEY0StrUm6YAKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgkHVmTQnDGBFbqLz1FQVBbqOhfhKYGTXzZXLswactosQsc9m4l5zaYpaY8TvIkoX7hZq0q3E4pTFjpOXBM+RTB4i85ByXRttUxGDMGlqv38rdxcv1xTEBnBxR5IYBZhCy7AJnR15tuCeZ/i01ejF3FUpc9ldPvcjrj8OdhdrCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O8bUffGI; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29f2676bb21so30230175ad.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Dec 2025 20:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766206285; x=1766811085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=37wqG5R217LEgGPeH7cKdi378+O5Rod8oTAHyv2jg3g=;
        b=O8bUffGI7qQtEM+7UYybhdPe3d7se/tZsMW4WL3yWA6VFqp0wTJG7Rycuv9r/1ussE
         0yQd15KUZTH2hZkcsrY7NNb8m7Ml3ad62Nby/UxBaK404Vdj5M9JxYy2ea82W8ox7D6o
         1qtzaBbzeyF13vjocW0TH5jonOLGalqwexQa/wB1ilAxwAoPnSYFKYCWauCZC9nPyReJ
         9nufmCdNnUQ/tSJxZWtMtbBgU3aT4vMmBIlCMzTbAEL7xHHWYh6OjHzRe34WbL+GR/AA
         0RdxLSFYkkzv5NB0l7CVB7/rb5zMtMNpPj89cRwAA9HYB3qE+C6kLxF+4qEOXs+KJPKb
         fghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766206285; x=1766811085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=37wqG5R217LEgGPeH7cKdi378+O5Rod8oTAHyv2jg3g=;
        b=joRoGT4fdLNrolv+FpH/aB9K1g8kZDNyQ+83isV32aQJgAGJa4ingSZwj4/sKe/JNO
         x1bB670+Pvu7jhu4N9b+hWAq9DmQQsGtrf2qAqTHopH6kL5BcZtc4rfJfOKpTNsY/7AD
         ixDWHoyT50met15LioCwGIUoyYdOR1q5PYn0Q/TsYjFJVGTzoG6u6wlXn29BMi+TV1l0
         Ytz0tv1ydBe2V2MqmLTJlD+8rA1erdsh9q8CG6b1mUEaHfMR0kjOTstJ6vp+dV2l9nTT
         NZJigBZ9cJLhmI6R7KQ+syfK12RI2j6gmgahxgNuIXH8cvUtXg1I/gzMcq1m+DsTIY1t
         l8Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUT9795RuyOn8mgokwUPu9Ya8gIypyb8UlVhLYYPDocFWgnaopyJiGWSfvAVmXrbwLE/vWipgzgpGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUhgH/IEe14s+EntVREnWDNYGSqDX3yF5hbC3DKDlsBsgCDINn
	lV5cf2e5wh285QBURzHVOzj3+cCpDUeuspRxMjl4ygBxe8mREbU69TX2GHtshg==
X-Gm-Gg: AY/fxX6FCtTSexPKJTNHV6UpmrGo91c3SeUStNcBeR0QYKPLUKUwigCjH0ObKW0hTs5
	AQUNrqBLnKv4rg9ACnfvsNrKixCdJZ8l22YRYyz/5lLZf5+OHzos2zJoFo8kilpJYKTOd2ANzBD
	jFDxVuOa9enhldviAELPNNTsCuG0mJFu9dkHMKfvxMQbFqKB9nZNMY50xsXTcQvusfn+YDYMoMm
	vhJnJTWKtpexHTkA0Kk8ZXi3H7g4fr8VAQdbjKIdKl4IAieyfPYxfT0FEfJ84f4uPjLWVswNq3G
	/nUwFOA18Itg1u38wZmjSObn677ud+AalodqQ6JQ8uoVWs8CP4wwf3lp3kw5v10as1KBf2Km+kL
	iMd4C5vB7w+tRFF6u/87uauiB3o3e7w4m8Q67Z3ZeMsuoHnXrjeHAzY+Cp9C+wApSXpEQ4/zg/e
	19Jfe95pH7f5BQMqv+7MYY6Pz3S24lDw==
X-Google-Smtp-Source: AGHT+IGyRHJgViYFO8d9rrlcvo3odYPp3UwIjCjAQ5KdThHOq/24uUyKSTiqrsFDjB+caPsYO/D2Bg==
X-Received: by 2002:a05:7022:3715:b0:119:e569:f624 with SMTP id a92af1059eb24-121722e041dmr3961118c88.29.1766206285161;
        Fri, 19 Dec 2025 20:51:25 -0800 (PST)
Received: from localhost ([2804:30c:165b:7000:d59:b973:da75:f845])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1217253c058sm15831628c88.11.2025.12.19.20.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Dec 2025 20:51:24 -0800 (PST)
Date: Sat, 20 Dec 2025 01:53:05 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andreas Klinger <ak@it-klinger.de>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 10/14] iio: pressure: mprls0025pa: cleanup pressure
 calculation
Message-ID: <aUYrsUVKmQX7Czy7@debian-BULLSEYE-live-builder-AMD64>
References: <20251218-mprls_cleanup-v1-0-b36a170f1a5c@subdimension.ro>
 <20251218-mprls_cleanup-v1-10-b36a170f1a5c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218-mprls_cleanup-v1-10-b36a170f1a5c@subdimension.ro>

On 12/18, Petre Rodan wrote:
> A sign change is needed for proper calculation of the pressure.
> The value of the affected element is zero for all official MPR sensors
> covered in the datasheet.
> 
> The change will however ensure a correct calculation if a custom chip
> is used (and if honeywell,pmin-pascal != 0 in the device tree overlay).
I don't think this should be relevant to the commit log. Correct calculation
should be supported regardless of what is in firmware.
Was pressure data read buggy before? If so, this patch needs a Fixes tag.

> 
> Also due to the fact that raw pressure values can not be lower
> than output_min (400k-3.3M) there is no need to calculate a decimal for
> the offset.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
> ---
>  drivers/iio/pressure/mprls0025pa.c | 26 +++++++++++---------------
>  drivers/iio/pressure/mprls0025pa.h |  2 --
>  2 files changed, 11 insertions(+), 17 deletions(-)

