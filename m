Return-Path: <linux-iio+bounces-7089-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6C591D3E9
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 22:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 344342810D4
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jun 2024 20:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3109F38F83;
	Sun, 30 Jun 2024 20:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLfQOfW8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59503200C1;
	Sun, 30 Jun 2024 20:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719779281; cv=none; b=mXK2+Gz/nzgfZw0BTxD0gRCe0twV2d16zRXxbbs9fjajaApdaL5pmt9PE+0sCx/W9+kKLt8NkSNjTw/1B8upMd1pVmUgnUe+skDKLF/ELxnWeXeVG4WxYjcQC7Z5/IIFcq/u+DBpFxHA72AREs/3CARyeVgmcLN2hikkFrXbFLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719779281; c=relaxed/simple;
	bh=eh24Fn0OQLDATZ/WrcHHiBOxwxaQ5w+YGHQI8glKSLk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaXlizGgQCn4+yR4kiHQ5dEgouCG3VjWhVgZzniDaaFSDXmV9VsVu5xf7g1QKOgGeULhms88BrIf0ynQ4u3F8uOYYd60BOv8nSWg1dZfyMbU3tWPjSz2r25/CY+M3w+pAR+yLycfs5f4wpHs5pH7KAc1wnE02kseu4LzIYS9g1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MLfQOfW8; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d106e69a2so2352944a12.0;
        Sun, 30 Jun 2024 13:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719779278; x=1720384078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xxYfoRNH8+gZbvCeiU6K9uk+NT3SVOKJIheDqF1Y3ME=;
        b=MLfQOfW8JRfqOvm70PjIeJMpQzgn7As9yqCGxnAUNXeO27BRVIsWiNbjBk24fLF0Fa
         UyWREO6JG9SQuU/leFaD00T0/WYvmoh8YANkJEvkmIO1oDMNVYuKrCiBfaYfkfdrHUZu
         cq3/vZsDxNNnPwPY6Zly8U9Gbjk6yqSazqKLQlv1QluhFUrP47wum132pBEDMcyfLLvd
         M9M7PnX546QWSdTSGIbixRYslqh6l3JyxPufHXzg/rjdnXwiunKO2QfXFgjEvEyouSlp
         10kExPz7ID6ORDktoCfYUVWSVLaHz1UbBsPhjZWuAGdyEuYw7LAbKVdZj3q8BumX+rNI
         QhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719779278; x=1720384078;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xxYfoRNH8+gZbvCeiU6K9uk+NT3SVOKJIheDqF1Y3ME=;
        b=aFT8bXSfC780xZ71YCRaxGINr5mdVh3IJCayJb5nT5KXkK/8Gkj+5QppKbAcP6cPqs
         h9I4VCFaDkvBQRhgsoJuRRUZZ9Bj/UeENMOZ0J/lV/wz/fWDFjA0xyZxuI9XByduqPae
         IRR3MNWEjyipqG5bQILfHLkdQL908XGq3pmtUrAJzVcGIi+qbXtKZOqDfjtTO+vMpuJg
         SqRj+bWD/I172o/hip1Sss6qXRijRPQkOI/tCMDecGgd825hiSKRV/cU3JzYAT9N7Yc3
         4v0PYmy39087Gz82Wh25wiaCIggamD5rSxfgtDKC2PzfxMaLig/wRX0q3yQRBEdi9ZG7
         LhvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUj4LEgY2Z4SJDbAv6yrQZrzVkZ7gHHwrz501f7sHWOvLvdfgBh3/NkMooMAJ7Ga7EbTaV3N4BbJfnWr1cxICN+BKDliQS7FWcgTkD/ubiJShpGpehmzy70G/how+s27ZN4hZIlYtzv
X-Gm-Message-State: AOJu0Yz4NOXA6ijGlQmEt9AouNZRpCjvR/fhrtrVLFbaLWb9L8yxSe4a
	THA5okNMFPKs5kL0qZdVnZKmTS7Wb1ZaxCtEGDU9tbXrZFtDRqpr
X-Google-Smtp-Source: AGHT+IE2GJm7hnKIbz1C/jl+MRzbLWte+mcaYJw1LPVn0Yysx+dXwUYGkK1nZNGEyE9n9D7Fj6lBRQ==
X-Received: by 2002:a50:cdd8:0:b0:582:7394:a83d with SMTP id 4fb4d7f45d1cf-5865c1f976amr5627778a12.12.1719779277523;
        Sun, 30 Jun 2024 13:27:57 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:427:8e07:6fdd:d397])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-586150377d5sm3561970a12.84.2024.06.30.13.27.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 13:27:56 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Sun, 30 Jun 2024 22:27:54 +0200
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	petre.rodan@subdimension.ro, mazziesaccount@gmail.com,
	ak@it-klinger.de, ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
	tgamblin@baylibre.com, ajarizzo@gmail.com, phil@raspberrypi.com,
	579lpy@gmail.com, andriy.shevchenko@linux.intel.com,
	semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/3] iio: pressure: bmp280: Minor cleanup and triggered
Message-ID: <20240630202754.GB185141@vamoiridPC>
References: <20240628171726.124852-1-vassilisamir@gmail.com>
 <20240630112342.4ab1f021@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240630112342.4ab1f021@jic23-huawei>

On Sun, Jun 30, 2024 at 11:23:42AM +0100, Jonathan Cameron wrote:
> On Fri, 28 Jun 2024 19:17:23 +0200
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > Changes in v9:
> > 
> > Patch 1/3:
> > 	- In bmp580_temp_coeffs, instead of *1000/2^16, now we have *125/2^13
> > 	  to avoid overflows, as it was proposed.
> > 	- Type casting to (s64) to temperature read in the read_raw_impl
> > 	  function was removed as well as it is no longer needed.
> > 
> > Patch 3/3:
> > 	- Renamed "buffer_handler" to "trigger_handler" to keep consistency
> > 	  with the rest of the drivers.
> > 	- Added new iio_channel_spec for bmp580 in order to use IIO_LE and
> > 	  real_bits = 24.
> > 
> > v8: https://lore.kernel.org/linux-iio/20240617230540.32325-1-vassilisamir@gmail.com/
> 
> This seems fine to me now, but I'd like a final 'we didn't break anything' from
> Adam before i pick it up.  Once bitten, twice shy and all that ;)
> 
> J
> 

Hi Jonathan,

Perfect! Let's see what Adam has to say as well.
Thanks for the very helpful reviews :)

Cheers,
Vasilis

> 
> > 
> > Vasileios Amoiridis (3):
> >   iio: pressure: bmp280: Generalize read_*() functions
> >   iio: pressure: bmp280: Add SCALE, RAW values in channels and
> >     refactorize them
> >   iio: pressure: bmp280: Add triggered buffer support
> > 
> >  drivers/iio/pressure/Kconfig       |   2 +
> >  drivers/iio/pressure/bmp280-core.c | 643 +++++++++++++++++++++++++----
> >  drivers/iio/pressure/bmp280-spi.c  |   8 +-
> >  drivers/iio/pressure/bmp280.h      |  34 +-
> >  4 files changed, 589 insertions(+), 98 deletions(-)
> > 
> > 
> > base-commit: 3341d69268accb5294b569ec37e55212a8a28ac5
> 

