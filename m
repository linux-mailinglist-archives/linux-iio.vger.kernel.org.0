Return-Path: <linux-iio+bounces-18933-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9793AA5E92
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 14:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CEC59C2F3F
	for <lists+linux-iio@lfdr.de>; Thu,  1 May 2025 12:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F8C229B28;
	Thu,  1 May 2025 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="O50tyarb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9192253FD
	for <linux-iio@vger.kernel.org>; Thu,  1 May 2025 12:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746103126; cv=none; b=pVOtXtJHT/9XGDuCNUl73zV1573VwlWUtEGi/5kMZ+R9KF+YrJwKIVzgwdmPijJaJerXt80QdhEJYCPs74oEKIJBsypeQs3zFdYXttQsmhYZImzbDeRFueDfgyg3fjUsdBxsYbWEI15O6G5lX3vAOmTVfIoueLuAKTvE2Filz3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746103126; c=relaxed/simple;
	bh=4sxWwKfM9MM7i7HEgmm3EuU9czAYD4Fqqroj1jSsAKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P33Swxqd+qE7U7Q2aSx84rm3dyR6ohCuXz3uiwVG8Xk5l5TefIA9I5JrvFOCMaHpFXe4kypbeHTn/C7bZzMaTrSlvmq1B4BAU2u4l7mr/IF4LPKWVDckUxEk8Is6Q+lGur/1R4DBWyFE+5RvBxxzdCRwgw99Csz0mszEmuSim4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=O50tyarb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43d0c18e84eso3372735e9.3
        for <linux-iio@vger.kernel.org>; Thu, 01 May 2025 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746103123; x=1746707923; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sm7fH/v8m0Z+i39l/2fi4Am/T5LmhFAbr6DYK3zAgKE=;
        b=O50tyarbKm4Fll1hfAb+tLrCDMjkqWTQcVRKgk7+TSsC4HMRyt4ZgGVGhWExYEjYvR
         EKYVfZuUJ6SQxoqLiy+3tzLaIJ5/fYBL8MbNwzUTd6E/eBGyvZQQ/MzXhB27dmdxZBUx
         gu7mQm5vQ7ECFFOA4p8VY8XK20IdHMYCLXF6ZtD3kb+rHmhJsaGkBr2Z+49ERKaBWHly
         zWTDZTrGDFwvpcTxRxEYVUQYsHherSqvj/u8eTg+D7ASJ5/FmYzaJepZPxjDT4Wq7TLn
         OJJ/14CyoRgLKtVLb0YO5GGer2NNbDM39ylzoe1AK3l49YYvCEbW7DmuM5ii8jCHpTfP
         AOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746103123; x=1746707923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm7fH/v8m0Z+i39l/2fi4Am/T5LmhFAbr6DYK3zAgKE=;
        b=byoz1vrgaB71OwXoQ62jI7NkdamYUKoQydxBTk7yY1Xyed77NluRavMGWfP733SPo2
         oC7EJyrblhm8cDVbK2f3woBMuJ5sHD9tAXieG+ItundSoTbRPrKdDC2DE+tqGvDW45H1
         t1DVvGLBA9fP8bwUg4Y1BeANzdZDs0R20n7wZ6nP3Fu8Ru1AhZOp7KiU7IkiLZES1r/0
         tQzbTjJUtT+mnNvYHjF8DF9scTCfeGmZ+OMVSx/k6jLPKpNdPM+5tyzA+E4//XL5sA2j
         5/qUF0k7Xw/1dCz+4NjChawqOxiZkhCGs31b0ZC3IyiccSFKIazUXZlcZqz+VIvtYBmV
         z7Aw==
X-Forwarded-Encrypted: i=1; AJvYcCV2vAodaR8Dl/iqkkwfNsKQsmns1AO5DZ8y+OECe/O8M8k+G5ttkpBUMaRNf1bLPV9EtPQG2k7oFh0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2oHHp4KB/K9omt++IyO5AAPGxxtRoRsWEi5/BxJz3b7r503gR
	8HEURd7CWzJGL7LQEdiMPI64Njxc2Jxl5atHp0hpCLEifciQ99VEkiKJhe5fBuo=
X-Gm-Gg: ASbGnctWxZMRk2/pSl6njDlRMDj6M2K4ySy03WnpHgDI//xusn6PAFSAYbXcpotQyl8
	obSWfiGDKs6ug03xfzTl0HJFJUMxUAgXfmAXC+pCGIXOJQMWA1MjrACoKEhkaVXLKudYdCdUq1L
	JJ6Bw0fiH7QQlGW7QVLfmTtkqQr/80WB31AlrYxIVqY6n5U214fNmYGxDVjAxNxJ6Kgn42NV9AL
	RGP3TEBM42BavJgwVizroBlYGS3my41TwgYegYpmO0l51/KzUnpqTz5JeAuDINWhxJDMMfn3jkm
	XOxJXv0zmXJg+Yx5OpcpQHGflBYita5+0D3DquaZp1+rcUPTa8XYtAX+mPNmg5G8tGSaubIo/z0
	jk3JhyOI=
X-Google-Smtp-Source: AGHT+IH/kEW2qU0NPr09x71pmesuZI0svNhYFSmpO2QEjZI5N9EoSoHJzC02SedbPOuY7Q2caEVC+g==
X-Received: by 2002:a05:600c:1c1c:b0:43d:54a:221c with SMTP id 5b1f17b1804b1-441b7009073mr21364735e9.18.1746103123359;
        Thu, 01 May 2025 05:38:43 -0700 (PDT)
Received: from archlinux (host-87-8-31-78.retail.telecomitalia.it. [87.8.31.78])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-441b8a286b9sm10834395e9.28.2025.05.01.05.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 05:38:41 -0700 (PDT)
Date: Thu, 1 May 2025 14:37:31 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
Message-ID: <hrpkszwhww7zftp45ipbadwqmx36rrrnvdbfphj7xkbtnfegth@arou2htn22ec>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
 <aBIcgxcUHXRpd882@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBIcgxcUHXRpd882@smile.fi.intel.com>

On 30.04.2025 15:50, Andy Shevchenko wrote:
> On Tue, Apr 29, 2025 at 03:06:47PM +0200, Angelo Dureghello wrote:
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Add support for offset and phase calibration, only for
> > devices that support software mode, that are:
> > 
> > ad7606b
> > ad7606c-16
> > ad7606c-18
> 
> ...
> 
> > +	if (val2 < start_ns || val2 > stop_ns)
> > +			return -EINVAL;
> 
> Wrong indentation.
>

code is correct, i checked it since also checkpatch claims for bad
indentation, but i just have 1 tab after the "if".

Quite strange, where could be the issue here ?
 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

