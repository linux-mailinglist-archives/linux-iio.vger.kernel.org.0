Return-Path: <linux-iio+bounces-22175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59CE2B181AC
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 14:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C21F7B86ED
	for <lists+linux-iio@lfdr.de>; Fri,  1 Aug 2025 12:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880F42441B8;
	Fri,  1 Aug 2025 12:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abnwHNep"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5EA22F757;
	Fri,  1 Aug 2025 12:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754050970; cv=none; b=XROT2UXeEYzJVs7tlfQaHHqJUuasRbYCZwIGIvLo0XRj/1fOfo/VnAGkQHH08R6qLq7rHA8mgH1FgUT/hiOu2cxFXx/88d0lxZAx/DO8x2SyHeyUFRY7Btw3xXgrBoKNbzz7E0qzwNlqX9UQILVeqRw6N2MVV5SLhsaC3A/cqGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754050970; c=relaxed/simple;
	bh=bzERq35UflfY6eFmTKiax8WEQzsm3ZhIO0FuQsHY1ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uj6NllZBHmYjfjTzCZd1U4Cp+liOPJT4B0npHDZiifKH1bwOGlN8ekRc+RgNUWeClKqZpKTwpKlqbdM62p5JUkQpCGV/Wo66Hn/ab21ggSsJDIt0/4wJdLvZKmyJXiupiSRHUV7q6K3Dag2mgAmWTgCnmK7jOunJlN1EZ3h9DUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abnwHNep; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4589b3e3820so20729145e9.3;
        Fri, 01 Aug 2025 05:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754050967; x=1754655767; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uaHWBaZYQ4tDXu404cnGU1aB7qZM3leXUgZjdKQM6fc=;
        b=abnwHNepw8fHWtqBRsOdmKiN7wIfAyhtsE4E/hMPSN46IWexevqmp24tnHKEC0LMNU
         5oSGLQtZNd6EPQ/Hqcc0WxKVkUgMN4oKKFCBkEOS4/5Sp1XzA+L/fpG0zKBvF4DC0o4O
         pIS3fD7BfFBX/lA5O4WbJ8eT543tQYs4pP0m6VhLiEz1BSyucyIDsQYOcxy3U20+yC+w
         Lc34UVNCXFQbwI1pQqIdK7WUYTkBzQ1boMD3Y2LXheXLo0Qjvf111zCrcGBUqVl2jFo6
         bmpIEGKIlRBZKCaxG9N4CS77kjcDQuBxcC7AxrgZ3o5ALglEhowL0zyeAjs2mllIrzvn
         hORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754050967; x=1754655767;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uaHWBaZYQ4tDXu404cnGU1aB7qZM3leXUgZjdKQM6fc=;
        b=ZFk2u8QAwdx/FuQhaaxmsh8guno1U/OUQlmL2OOPxv26sjdw+dSRDGKRJnEW40XXHS
         HAk4IblMusn4tEu3mpXKEQGr/ir3GFzwY6HzRrb0zf7faj9hc09XOqkGtFvtX39QnG2l
         pYG0w08RMv1bbJQZEwGpuklYsZDX29JGPYk21IRbCAMRudAvj/g+pSQfwEGoNJGwTNJw
         J3tF6xqLUfHQXlKCm/kVTIFczDsVmWmfKAVimcEqaNNvSOf6bKaYDCwSwl47Cr7e5iOO
         LaVPMsxlxf7w3b/xFx2WSJCtZAB9o7tF9zvuvsMchA9M+IjqVYS1XWO+9mbuHu/0ocaE
         +UWw==
X-Forwarded-Encrypted: i=1; AJvYcCVYPGMAEhQLsZF/Nqn2JvKWm766xTwlyNbzqeNPBhzTebWDIxcUbk5hQoM67r9bEI2Z/NSCcJHEj0E=@vger.kernel.org, AJvYcCXR6sLTnW0V6OpWV/pN8X1fCD68Hg5ZTrA25hxPcZkvMPT2K+CoiVuWmNrl2DGGcNQZQIHoaaLYUUJmwH9+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywfrk2B2G6QyY57AslPMv5+mtnOZNvZ99A83jcPdblsIO4FayUo
	thHtmFjXTMw65NvUY5jyDkQr3+dQ6sd80utDGypBJput93GyyEt5WOWl
X-Gm-Gg: ASbGncvhPqoLl+YeiP2pA2tiRkAzpLeok8kvIOvTf5+D/7Q1Cux73u07K01mUaHNAtl
	dbli1u6R7mMWQR2pDXVf0+PwvwhVN6NReEIqBhuy49RnysXx9tgTc0qBDxx2vo/YqQLJqWjl30V
	Md8xakdlv8udwEpDm99rLcAp4hhpHohDivckypt6bcgAmIPBTglRsf0nfJRwX7tiBHgpZKwoaPZ
	EP47CpUMTFwRcpXFD18TaPCor+5s+f1i456FV+9bgialaSGqB+vkrYeSTFPC7hlnhg+wlLWPkdc
	GD1RCX/Co4Mt3LexhRjSaPWpW7UOapSZ/u9sOXzm3PIsYgb+dvLae3z4Mzm0ZHY/RZyk1iLXpWa
	6F8TpIGLsDI7PLA==
X-Google-Smtp-Source: AGHT+IED8BJulIObk541IsosanJpfJDcnk5dH8KcWwUeIdpbK2upnGxpXsbJWzIpClT9wLRTPI0CUw==
X-Received: by 2002:a05:600c:4f16:b0:455:ed0f:e8d4 with SMTP id 5b1f17b1804b1-458b302b518mr4955715e9.10.1754050966801;
        Fri, 01 Aug 2025 05:22:46 -0700 (PDT)
Received: from nsa ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c48105csm5766710f8f.64.2025.08.01.05.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Aug 2025 05:22:46 -0700 (PDT)
Date: Fri, 1 Aug 2025 13:23:02 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] iio: adc: ad7476: Simplifications
Message-ID: <nt4epgtqzptq3c35nz36qlpvkpzlabzpb7vd2jugbgg3gmman6@jipgkhkcfjr4>
References: <cover.1754041258.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1754041258.git.mazziesaccount@gmail.com>

On Fri, Aug 01, 2025 at 01:06:46PM +0300, Matti Vaittinen wrote:
> This series suggests some simplifications to the ad7476 ADC. It is
> currently 100% untested, and shouldn't be merged as is. I'd like to hear
> opinions on these changes before adding support to the ROHM BD79105 ADC.
> 
> Intention of the patch 1 is pretty trivial. I'd just like to hear if
> people think the enum + ID table approach is preferred over direct
> pointers to IC specific structs in SPI device's driver_data.
> 
> Real reason for the RFC version is the patch 2. It aims to clear the
> supply handling logic. I did also an alternate version which requires
> the names of the regulators to be provided in the chip_data:
> https://github.com/M-Vaittinen/linux/commit/cf5b3078feb17f9a0069b2c7c86f6d980e879356
> 
> I believe the version in the link --^
> is clearer, but it can potentially help people to add issues with supply
> enable ordering.
> 
> I can't still say if the patch 2 contained in this series is better, or
> if the one behind the link is better way to go. So, RFC it is :)
> 
> Matti Vaittinen (2):
>   iio: adc: ad7476: Simplify chip type detection
>   iio: adc: ad7476: Simplify scale handling
> 
>  drivers/iio/adc/ad7476.c | 376 +++++++++++++++++----------------------
>  1 file changed, 164 insertions(+), 212 deletions(-)
> 
> -- 
> 2.50.1
> 

With the suggestion given by Jonathan on the first patch:
(I also dunno there's someone with variable voltages...)

Reviewed-by: Nuno Sá <nuno.sa@analog.com>




