Return-Path: <linux-iio+bounces-21320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35757AF81E6
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 22:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A8735854E3
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 20:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140AA2BCF51;
	Thu,  3 Jul 2025 20:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HFQyc5HN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FCF29B21C;
	Thu,  3 Jul 2025 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751574129; cv=none; b=Ej6gRLIsOM5N1BENHOkBIjfPOK4TvnE3QQnuyIzUNhmDAZti0dZbWoFEOTy1IZ2OBAfUyJ8A7nOnO0u621iJzzFn3orGgbHZZAE7XxzOyYndrw/T6iaexMN0EqfO73re+TgaNl+mHKiIJPe4thMgFirQEM7Isib5an9GllTsF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751574129; c=relaxed/simple;
	bh=pXwrev0Wlewpdvm8JzYFeAW6vtWIxQ26LcMODJmbrp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qq/kHXyIJvJTD0ks1il8hfXeIJEA6xRVNnglEpdhg1BzgLK/IWxlzeoWfujUTj8qfkZy6YU3jm8lAgtJ2wEeniCb/SxQvt2hvDv8722tR64Yljj191eke/LfHd5y5L7URqd+ImYli89957CPmMW0rLH/ha90QSr4JmK/39TAlP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HFQyc5HN; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-4a9741b513eso4865751cf.1;
        Thu, 03 Jul 2025 13:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751574127; x=1752178927; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=a747o1y/RYYYigtxoWLdqE1IuHEAIgaSXmW9vjL8liQ=;
        b=HFQyc5HNZB7OJtjFhkf0Vn8A897A8uBluueLQpI2rKonXB2bVpyNS5KFqCShSGKg2k
         jcUL4QRT11zsJCEborWn+jwiDUyoSn8zBqR+6mkKGeY1k9RdigZ1EOxddoKDBa5cubaE
         kByHvv+CGTT0TOtBZavvMZtyZiHfm1MwSvfnZELEwXG4uK5YpJYbhd7N6V00e2mARQ7f
         1bBhEm5qhA2RS1fVY3OEyrX78BAbMndTmZUS4SELZirI5voI7Lrep4tnlFxNABsPAlZQ
         SOO9LOpRKq8HIz9mW83eCx9wfhom1kjpmOdcUj/qQ9ZjXv5yzLzYKAdYHfjYR/WjgV6f
         TdFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751574127; x=1752178927;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a747o1y/RYYYigtxoWLdqE1IuHEAIgaSXmW9vjL8liQ=;
        b=dvD+7KxMY7a6U0qXXMLTg4KenBNYZQTIfcS38H3KRwW0yMJXHxWF/IGmnWnFFnQFP3
         jMNK7RdISCV4fbU6UoFM29G3HEKuoFjQbdqYhAgL6WEliQ7QCnSBNIqXmuX5Mk6nppsG
         3a+5VVHj3aMqbpSQsV27kvKECMjSgJ1S9Bk8k/q7nYMgDZhjVTEwlSQ5H4tilwbaJXOs
         nTSfE1rEaz3OHbHY4ZQZ2VNJCO5xmtbNcRXH7533lzskdCbYY5/YvRYqFSRPPyi2LqBR
         CEDh9u9n5v5Z7WUVbFTuy6G9n9gOqxAbt295NtD4VUZ1xS1mTJK7sPddXtOBcUmwLf9Z
         JE6w==
X-Forwarded-Encrypted: i=1; AJvYcCUPxEwSVdlMVcV9i++ZUnEtBPHDj5vi/3ZkRQRH1c/teDNWHjli6XM1rE9WB5O7qcITv2guJ0RtmUEl2Q==@vger.kernel.org, AJvYcCV/n97EvE82RfAqlr2KoDdTQJslBgCFaRBqHJ0fMj8l6VWzY3otBJ2iNO16T9DYd0FMKTAKmEZ9Czr9@vger.kernel.org, AJvYcCWCKaYtZIczRQifurU2I35WqT8VCvLxj3n6nDfU7FKyUN7lt2Lt/LysFwDGfn0a0yko6jS+Y2ByjLo+@vger.kernel.org, AJvYcCWp/iKIGQGxWylX9vP/poeDd+zhXPhSIkmwlf22NSAjOIx0tI6rCsZT/lOMD3LHgpWRsWeJnIo1KeqHbwnw@vger.kernel.org
X-Gm-Message-State: AOJu0YwMTVBwODNNSkCXM7mgkG+LwN3+lIRHsEExExDJqRySFnGlz/ed
	TqfxVlQ6TEQ/+/nfgKKPEemhQYvAVmQQ5S9yRjVImSfXjDz4Hw4Rzwv6
X-Gm-Gg: ASbGncsx+DSLAbqhf3ewYzPTdqdfiFfkXGeiOzTecmdV5jO2UcCWcJkyQMWPPP5uuft
	+LTOUsxujSwh5nmKEL4+nAkFpzVfybSNu0+ab4jop/jpJ8saiUk8yqchNKQnzGnBjLehGGl5qlX
	Lmzg2SmjPyr6ZJdmv9vGKxEGjHxtwC1dOaEYWXc1T/NMKUTZjBuKia+6wnpE0NdEv4RzXEfMCsy
	V9eIUS+R+GfW5tadR84wKsrbBNTWcExI9soI4hYZdSJrSBiSBc3nbVI6ZeT36GRKQ9BKZ1x18bH
	HwUbSsUcgANaGZS110NNcoWRMnbi9LGcJWogb+Bus9lxkxjuSY0XzrPczfue+26Dp7vxuA==
X-Google-Smtp-Source: AGHT+IHVeU6RF37SlrnkPxVamS/XAdS3AhgW060ULgIeHYEa8MW9SZgsHl0vzD/V74sg/tHaGQiT7Q==
X-Received: by 2002:ad4:5610:0:b0:702:bd34:75c8 with SMTP id 6a1803df08f44-702bd3475cdmr53597746d6.5.1751574127123;
        Thu, 03 Jul 2025 13:22:07 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-702c4ccd346sm2894826d6.38.2025.07.03.13.22.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jul 2025 13:22:06 -0700 (PDT)
Date: Thu, 3 Jul 2025 17:24:07 -0300
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
Message-ID: <aGbm5zZMN4FIohM_@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1751289747.git.marcelo.schmitt@analog.com>
 <aGTpNNaW7cXC18Jt@smile.fi.intel.com>
 <aGUfapky2uh2tsFt@debian-BULLSEYE-live-builder-AMD64>
 <aGUi7r2dgnbqLOAH@smile.fi.intel.com>
 <aGWBgLLtOzVGwXek@debian-BULLSEYE-live-builder-AMD64>
 <aGaP-HBbIbfEoKlo@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aGaP-HBbIbfEoKlo@smile.fi.intel.com>

On 07/03, Andy Shevchenko wrote:
> On Wed, Jul 02, 2025 at 03:59:12PM -0300, Marcelo Schmitt wrote:
> > On 07/02, Andy Shevchenko wrote:
> > > On Wed, Jul 02, 2025 at 09:00:42AM -0300, Marcelo Schmitt wrote:
> > > > On 07/02, Andy Shevchenko wrote:
> > > > > On Mon, Jun 30, 2025 at 10:57:32AM -0300, Marcelo Schmitt wrote:
> 
> ...
> 
> > > > > >  6 files changed, 3601 insertions(+)
> > > > > 
> > > > > This is weird. At least patches 11 & 12 have '-' lines...
> > > > > 
> > > > Yeah, sorry about that. These ADCs are fancy such that the base driver is about
> > > > 1500 LoCs due to channel setup handling and support for multiple combinations of
> > > > voltage references and channel setups.
> > > > 
> > > > About the '-' lines, I will rework ad4170_parse_channel_node() on earlier
> > > > patches to avoid 3 line removals in patch 11. Patch 12 is only makes sense
> > > > after patch 7 and I think it would lead to '-' lines if coming before patch 10
> > > > since both increment the number of IIO channels. Anyway, I'll see how to further
> > > > reduce the number of lines being removed.
> > > 
> > > My point is that the above statistics is mangled and I don't know how I can
> > > trust the contents of this series if it already lied about that.
> > 
> > Looks like git format-patch summarizes the changes from all patches when
> > printing the statistics to the cover letter. Also, git format-patch doc [1]
> > says the 'changes' dirstat option (default behavior) doesn't count
> > rearranged lines as much as other changes.
> 
> TIL. Thanks for pointing that out.
> 
> > There are cover letters of other
> > patch sets where the number of '-' lines don't match the sum of lines
> > removed by each patch. [2] and [3] are examples of that.
> 
> That's different I believe due to the diff algorithm in use
> (btw, do you use histogramm?).

Nope, I was using the default diff algorithm to generate the patches.
I tried the --histogram option today but didn't notice any difference. Maybe
default and histogram output the same result for the ad4170 set.
I'll send v8 using histogram alg. Nevertheless, is there any preferred alg for
generating patches (so I can use what's best on next patch sets)? 

Thanks,
Marcelo

