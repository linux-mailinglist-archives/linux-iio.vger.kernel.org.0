Return-Path: <linux-iio+bounces-20745-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582FADD63A
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 18:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527D61944EAB
	for <lists+linux-iio@lfdr.de>; Tue, 17 Jun 2025 16:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABDD23815F;
	Tue, 17 Jun 2025 16:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3op10iv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB6822DF80;
	Tue, 17 Jun 2025 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750177041; cv=none; b=A01Ogq5qleH5krrzqOfD8YpRPkD9hVhPpZMletJhJ4uVaSZiMFtsuyRpxacPotzVpHTGfE0g7kHelzffTJuRdcgdJVV/Vf8wpzjQgARHCtvwOD5Sx5yEomDJuU6dAeQ1H3fmsuXex8bgV7ws6mNBcHmCSqrAmn8W8bjnkKm2wcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750177041; c=relaxed/simple;
	bh=oecCs2PWJBNrb+O9Kzm5FEOBYJVbUn0UtcA+nBuBlwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tvnrug7tfRNgeUBX33OdlH731Mn6g/XBLwK65n+9Mn8uBiyWh99ORZZCPDc3dznFgMWZ8gFZPgqvEBAw6I0M6oI5iMvtHEGgifOB5zUFq22Hvjxy7ViHmBSP2cvobXyrbUla/rAaUJLdvPPJU4aWXT8SFarxd+oJI2xYF68s7fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3op10iv; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a528e301b0so793478f8f.1;
        Tue, 17 Jun 2025 09:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750177033; x=1750781833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W4IRp8lOuDYBi74yqX5sUOj7piA7uY8U+OIdNTvBqxM=;
        b=c3op10iv82zBJB6s77v42N0VmDeB9yM3+lASgetDtrgRF09OaRgVtBCyGelDJb/25D
         atohHJBoxuFFMalAroKNJwcWCM2PQhgtJKezW6TF03JGYmf50rK401waq5yHw9eweqas
         5TL7wlHzQGKAkhYlAQrujuFVpdA2ktBa5D8I8dagifShfPMuzkdMNJVPI0ym8KgjAmtp
         qG8GhebGlFy03WcFBFt68gh12KG+vHpPicBvV8DLeHZk1C1B7BFu9MgJAweExCdB0lM+
         5qK2OfBujeBRNcxscwpoeAYyk/HOtAlhVkZjShe/5L8WANrQ2bwEP3ZC689HlxNxlooB
         rPkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750177033; x=1750781833;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W4IRp8lOuDYBi74yqX5sUOj7piA7uY8U+OIdNTvBqxM=;
        b=g8Z3Znc4h9yutQ6c0pZL1UCKHuvj67Dme5RDYhPsRR7XDlEwptg/fUCqXBcS/kHBXa
         P/yOBKJ8zlYdUrg8A2QVf2egOatzV0oWicY6CO0bJoeITWvj9dCmjdnJIccde+8X0r8t
         eOYAk5cbz6Jy2YjW+qKwfjwIpvlWBaYEaj338yG0/fKIFiQZqY3OPDcymz72ukWM5/mP
         keF8Xb1kbSDAsXQ0YYouctDsxprSTIgedE/pdvAPG3ZBi1iP48+fUGJvpkxQAnKizCST
         neDjOwJaxrzAh2ngxjI1mxMbBjsJ+psOsLRACODDzWjUxsDn0ucSJHYbfGrQgM6iB77T
         YnrA==
X-Forwarded-Encrypted: i=1; AJvYcCUVppdb9PP67pMRiGtJZ5io8uSgo4dK3k6B9MmefXTI5/FM4Rienzq/BcRRTO+3tIUjEM2GadOHRX1MgA==@vger.kernel.org, AJvYcCV1rqZh94MNAQaNkbcX1UQ7Gkn3V+fcCt6eEcViw0ZCOZPoAnEYPhCCOeqEw1WF7tCxEEg4dpXeHfC9@vger.kernel.org, AJvYcCVjQEZmFKaM+4RqgGEmcyLKc0LvEfkxyej8gYn4czvIOefCroZ4voOlaIijgSJBQ9o5AnCKLvWbtQ2OeEpY@vger.kernel.org, AJvYcCXf3xvtwNDmKAkl+ettmR7H88bNwK/iIIPMPqcfdki0aPQIS+NEU+q5VjIXLzeIaynUdFPnmO/jOn7W@vger.kernel.org
X-Gm-Message-State: AOJu0YxzCp8NBiOrmzsltpqU6VgvUgIL+gSV0l61PYoVqYLteB3v2fia
	Z3wefmsms6o6lX2EuKUg8R4MT4wprdzhqMQG2ynK2baED18bPcHZ69aD
X-Gm-Gg: ASbGncsrMdUrNTU4F28lNUgt51tj/vT2OnnmV4FKkrOVLsB3VGXLZaU7d4ZbaeoZGFm
	5FHd6Q64TxVZBCPERkuGbHV1N/HZPmSW4Td97V4uns7ZwqcpEZDlWlPL5RAElTw8ulstwzcwgMu
	chcCXLBpDE6tr3U1Gxac3CnOy2Q3Tsss0ZTCMEYZoMLoagDdgKM2KWAV/rkdJ+MjQaeXJxDCIul
	W4FaEnZR1draXhxc2Werdc9iglus06ZKT+Mz09OomCb1m3Y9R5K+e6dxfKIaNUVCAJPMOEQhJyj
	zoNTNmvvfoZMLUOCYzsbh+voOGsyFGPhbf60HOM0MAyVyelmpMY0xu2KnMJ13Bevnk8vSzwJqNv
	S5Y8GHDw=
X-Google-Smtp-Source: AGHT+IHy4HYvP0zCPs29Z6Pt9vtjdN3X2LsRWCcO9xNMOK3GaEZ/sae43xY5py7YO0nSTpfphfLHSA==
X-Received: by 2002:a05:6000:40cb:b0:3a5:78f6:c7c1 with SMTP id ffacd0b85a97d-3a578f6d4f8mr3102801f8f.1.1750177032732;
        Tue, 17 Jun 2025 09:17:12 -0700 (PDT)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a568b48564sm14185037f8f.82.2025.06.17.09.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 09:17:12 -0700 (PDT)
Date: Tue, 17 Jun 2025 13:17:05 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
	Michael.Hennerich@analog.com, marcelo.schmitt@analog.com,
	jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v11 11/11] iio: adc: ad7768-1: add low pass -3dB cutoff
 attribute
Message-ID: <aFGVAWi7CZAy0E8k@JSANTO12-L01.ad.analog.com>
Reply-To: aEwd4cS7j0Vvypg8@smile.fi.intel.com
References: <cover.1749569957.git.Jonathan.Santos@analog.com>
 <804d66f1858014d7278aec3344d81c223661e878.1749569957.git.Jonathan.Santos@analog.com>
 <aEwd4cS7j0Vvypg8@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEwd4cS7j0Vvypg8@smile.fi.intel.com>

On 06/13, Andy Shevchenko wrote:
> On Wed, Jun 11, 2025 at 08:52:03AM -0300, Jonathan Santos wrote:
> > Ad7768-1 has a different -3db frequency multiplier depending on
> > the filter type configured. The cutoff frequency also varies according
> > to the current ODR.
> > 
> > Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> > the user which bandwidth is being allowed depending on the filter
> > configurations.
> 
> > +/* -3dB cutoff frequency multipliers (relative to ODR) for each filter type. */
> > +static const int ad7768_filter_3db_odr_multiplier[] = {
> > +	[AD7768_FILTER_SINC5] = 204,		/* 0.204 */
> > +	[AD7768_FILTER_SINC3] = 262,		/* 0.2617 */
> > +	[AD7768_FILTER_SINC3_REJ60] = 262,	/* 0.2617 */
> > +	[AD7768_FILTER_WIDEBAND] = 433,		/* 0.433 */
> 
> Just to be sure, is it 0.433 or 0.4333(3) actually? Sometimes datasheets have
> rounding that even may lead to problems (see TSC issues for some of the Intel
> CPUs in the past). That's behind my question.
> 

Every reference I have specifies it as 0.433, so I believe that is it.

> > +};
> 
> ...
> 
> > +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> > +		temp = st->samp_freq * ad7768_filter_3db_odr_multiplier[st->filter_type];
> > +		*val = DIV_ROUND_CLOSEST(temp, 1000);
> 
> MILLI? KILO/ MICRO/MILLI? ...?
> 

Yes, MILLI.

Thanks,
Jonathan S.

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

