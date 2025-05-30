Return-Path: <linux-iio+bounces-20033-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3126EAC8926
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 09:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF5F4E26A8
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 07:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60752165EA;
	Fri, 30 May 2025 07:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TwvbsS9d"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720781EF363
	for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748590705; cv=none; b=n8IRAoY5/gdJz6gBTq6wAaWVhSwcyBDepV4ATjzwYPaUrC5GdF7XgecrphN3wYP2xZJmq8D3Z6OmoGJGSe30InSSzHuesIVTXySwrgAeCV5Bj2baFWli7zLtJp5ck0H4A0Vip2VgouErJMEX4mtVY//a+13lxPhKHxCF4mM0RK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748590705; c=relaxed/simple;
	bh=iQgrvOqRA70LGQbw+GLCqJWS7MwZcGOXx4QpLJML8B4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NhN712tChHeqUR4Sk68qXDPAGmnrSDk6pQqEUkYM7VY8fULZdvRr8RovASDllKY32WI40EBGdhInxOg/B/gqR5fnV6NVEZhCK4ZghtfMBsRwhbSAzwgdFhz/wEVMyGj6+QCmtYGLVDKeWu4fn5j6vnMzXy6sX2hjkQB8pOXk6eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TwvbsS9d; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a36efcadb8so1513220f8f.0
        for <linux-iio@vger.kernel.org>; Fri, 30 May 2025 00:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748590702; x=1749195502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LfnbZiQbAmqPKSfMf+Mq18rGvap4moTa+Dp1DimkkJE=;
        b=TwvbsS9d3VlOo3x6Q//jbKnLl5Vx4QDTxknbDZXit1vgjNBupa+rTyv9V6VEIT43tT
         YZdImqytpkQBbO7cs5TPqbthDEj6MOsC0m3xzz39H3+juQJbXll1iU2a+/E5hma12GxV
         7hTu/o+eqjw10KGJdF91MrJkn50gBgR9q5YsVw0CTintje57+ZisT38Ff+8lhsLiOUPY
         ySHAF8DG7ZvdLn1F4z9gzenTSnXBnu1PXNSbjE1ApByfKuwZqsSVwkR4Ak7/3UI1GMgg
         R5JZm2K6bHQsOzZeW6PJrVkgLGUMEG5HEsliGC+OERW1BV7cjCTz1yNVKKimTwvg/ugv
         ayFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748590702; x=1749195502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LfnbZiQbAmqPKSfMf+Mq18rGvap4moTa+Dp1DimkkJE=;
        b=PzdG20Neq2ksgUAHKrTjIB3CHJkhOO28IQui46iR/NWE3rAstvZtsXO3jGjtCa09J0
         Ta42/1wy2eRtd49km9RxjMA7CCjMW4SSpHY9nmR/cSUKqSN6XnXgGeAey/h1XrAAxiFu
         r4O2esw3+dpINLdEB4AfQMBPc+eFEjChffXOMUTZraZ8FXiwGV38+X6GWL2K5vD5hB6x
         NWyBn2WayT+BPzvI15KbHbg8RbxDPRwwYSP+VepZOV4AUw0xYMRJR1IpkkSp31wyRtXn
         armTWvNQYyDcN6HsEvY3OrNt14eiUoR2CI6BWcryEoWw4C4yjpvU4Ew6XRprMjEYwIca
         X/ww==
X-Forwarded-Encrypted: i=1; AJvYcCXE1Qo2/DeHZtoEXek5D3f/wug9x9jSPPUoJpiTD5tdLGMGgRiynL2p0srkEKPHYB+hBDHGXUcS7ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxlrc8Qdg5Sfn6PJuIOzDyZD4fo7XB6zb+9Zhe8/kFWZ/dn0Loq
	AVo+FMpYyrz/uL5LfVGgbdDF7nijET/gA27k+QPnenhPWxUzyO29AMwoFuB7PsKH+GQ=
X-Gm-Gg: ASbGncsdfQi6Tlw1NZhhdmaZ5WTlf1kLoDUxj42iDCy5YtohGGBsI2V24oK3oWPAuXK
	aR/Iw0PGjSE+6qXsufHxQbB7E0t9sb/cNRuShd67sTbifwoOPgkQC7LmvretUc8M6U4DJtKpaRW
	a2oMPO/pUH8gU3qANUPvFyTAZjzHDBgKP2N62dV4njCfvkg5+G2vYiF0WT8jKbjcK97JAvuFlu+
	jMj6IUzCJhv1oHVSgL+4kOqaMPLdqd93mfFkCujaZB0kjdFJqN+GiwqUi77HFSAMInVLLSA1SX8
	WROYgnWwwhhl/bdKkmKT+a8hmhDZmoT/XZLbkhOVlYcJ/uD17ee8ZkrMHYzwTO9JHo+CAWoLCd3
	xKsAmv2m7MR+0cZMgUrIMUjPw9EzPcw==
X-Google-Smtp-Source: AGHT+IE9MXHewsFsO65gOCbyBARWfhxCc3GiAp4JhYo92c97qkhscjKdSO1/x+TgAzn1ycE2rzPEIA==
X-Received: by 2002:a05:6000:4212:b0:3a4:e1d2:9a7a with SMTP id ffacd0b85a97d-3a4f7aa591fmr1586687f8f.46.1748590701612;
        Fri, 30 May 2025 00:38:21 -0700 (PDT)
Received: from archlinux (host-80-116-51-117.pool80116.interbusiness.it. [80.116.51.117])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4f009758esm4057600f8f.75.2025.05.30.00.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 00:38:20 -0700 (PDT)
Date: Fri, 30 May 2025 09:36:57 +0200
From: Angelo Dureghello <adureghello@baylibre.com>
To: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Subject: Re: [PATCH v7 1/6] Documentation: ABI: IIO: add calibconv_delay
 documentation
Message-ID: <lj2jhnuggbpil5ogler7uruhf5uv5u6lnrs5jxgsvxiy5lq2fd@kwmvftbyozkl>
References: <20250526-wip-bl-ad7606-calibration-v7-0-b487022ce199@baylibre.com>
 <20250526-wip-bl-ad7606-calibration-v7-1-b487022ce199@baylibre.com>
 <aDbmTaX1d0HCx8V2@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDbmTaX1d0HCx8V2@smile.fi.intel.com>

Hi Jonathan,

If all the rest is ok and there is no need for v8, could you maybe adjust
to 6.17 on acceptance ?

Thanks a lot,
regards
angelo

On 28.05.2025 13:32, Andy Shevchenko wrote:
> On Mon, May 26, 2025 at 12:03:16PM +0200, Angelo Dureghello wrote:
> > 
> > Add new IIO "convdelay" documentation.
> > 
> > The ad7606 implements a phase calibation feature, in nanoseconds.
> > Being this a time delay, using the convdelay suffix.
> 
> ...
> 
> > +KernelVersion:	6.16
> 
> You need to bump to 6.17 if it's not a fix.
> 
> ...
> 
> > +KernelVersion:	6.16
> 
> Ditto.
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

