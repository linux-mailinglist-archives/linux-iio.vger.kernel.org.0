Return-Path: <linux-iio+bounces-14966-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA40DA27281
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 14:13:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73D663A171E
	for <lists+linux-iio@lfdr.de>; Tue,  4 Feb 2025 13:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE073211482;
	Tue,  4 Feb 2025 12:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6pH99Ra"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216C420DD67;
	Tue,  4 Feb 2025 12:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738673624; cv=none; b=LmIW35ZWcXz8Ej+z64oIPvGtUuYBOh5xI81t1i+kZ/8mW3ZK9j7w+F/kUEIpEvZZalTrT+PGEOnQsUOrjd90KkGkpoM/M8ease5WVYK9uiuakOIsawLzDC6s9/AhOY/VU0V3u7x30hKSn7rftvh2lsiYOSNa2rFpxFaSIhAGjkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738673624; c=relaxed/simple;
	bh=7BQ9RhX7kRie+2xXImgH4XuQTTR4nleY0QtIcrxjQJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJv656/5G6FlQJ47QfJZ0mPbexEQFYmHjP46CiK97JS/a6icGM2M92y9oCPkJ8zh2f5MzM+C1fjKkAWHMSjLDy54/kz08iWedXWOVsLg9OFVj1H8CQa+vb25gutpXQSljJI6nF5VE8LgpdbiGVDzEKAQ0haUVHo7/fjitJ8JS3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6pH99Ra; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f9d74037a7so134329a91.2;
        Tue, 04 Feb 2025 04:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738673622; x=1739278422; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V4DowdxS4hE/b8ECBDt5Wg6MxdKt7w5XETTlNleB8bI=;
        b=D6pH99RaetVcBbUgnyzyvtXDKYm9CM97r8Hpi6MF0nXCesgl+GkZtYwh8RH9LWSrMG
         Qr2naQFeCC99ubw4kw855yuk5dKR5/0uM/CyoWKWLQLNbpNBDvjDhXtr8jFTbEoF1Pot
         Tse5e4xCwKi/s9jRGsbidhwuJE9hfbIO83WYFyziLjXLhNxtpU8eyc8hssgfLaPvUPDw
         rSmEOwUAC1FW31ROtkkEolj5LXpE1NuuRvEo8HxhO7q1gGb4usa8U0M7PoNKmi0/z2BX
         iuvctbRyKYTjaC8AGAl1dCp28D0d2a7NgWSV9+KuxxukcCVddR2C4zqqmW7s2tQATDH2
         HjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738673622; x=1739278422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V4DowdxS4hE/b8ECBDt5Wg6MxdKt7w5XETTlNleB8bI=;
        b=DA2L3sn5uwza9/QYXJ8YED9bnidcfhZQ1jaUn4RuXVICDt7HWBMJw0BbeA1IwyOPtM
         iEYXLXkuPzPyHrhm46WwAR3gQ3nRNvQzGJdWwbJnDQ3qBsCSpjjNBdkwiXYMbnsoXnej
         lsA7k3Aa+07oqUW7u93/wM/wKsYA/yoKy6HikhYXZxPWk+qclOH308bfZjwCsQxMXJRk
         7h4CTgRAhsZqr68rBPGt3CpiwVLlRcbHZi01M63KQwJBTyXyVLte5gj++lfYboxfpCgP
         NE+uA1Jka2nVZEM+RwiXycr4kBXUSC/PFG8t+yXIrx6NQB4KWtGSI0F+jOnaWtwoUgNy
         oW5w==
X-Forwarded-Encrypted: i=1; AJvYcCUxJOg+2fBT2bstmVhzMDYtarFS3QMIbqGe9O8431gnk6slODmInbV7suo+2cHitGDJvdRo4wgYy+zVeeXM@vger.kernel.org, AJvYcCW7KXqW8j6Riyg70LZmZFQhjDTOFBlUdva4lUADDJ1nGif0vuh+0vEJvv7Xlp+oCLZrOTTmpVWFcQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOu+eterUq9ruBwXNb9wWxbtLVTJKEAAp5Afw3sTSsxkkc6IKj
	QUNd1PBkIJUtbA3iumAZSiYpna6fwxxkyiRNTA9G8x+UZrUH/Tgn
X-Gm-Gg: ASbGncvxPLrsv0upbGSLSS7zljJbZWdkpR7+KDufkvsvGWL2VjM5ASno6JyyFgWjBYb
	babzmP6KQmmZqkEGJIUQhccRdl/fELZnSU4o1d/qd4HcJWp2djZZ6OSVWOqyZne5y2o15tPwNYY
	rJP81Rj9kBQ3pBFtTohZ+hK0FY2VLaU1PABYD1gg2hUheYrjNycr0hzLFevDSCFTv490zBRMBYD
	X2MLQiZBDkSUOfvlepisMemW3sDd/ZgmpAZgt2IW7QpDwcDtAb1AEHnI2GQCXd0NvitOmAzW+TY
	wymQbvIx6/XTLOstSlRjHettTA==
X-Google-Smtp-Source: AGHT+IGVuC/qCVKUl8RHDjEwYiwWTKNrtZ48h5Nq/IVglmGk84a+BIgeQOgyNApTAyl2DCHEuJbGRQ==
X-Received: by 2002:a17:90b:538e:b0:2ea:3d2e:a0d7 with SMTP id 98e67ed59e1d1-2f83ac00d18mr40449787a91.15.1738673622296;
        Tue, 04 Feb 2025 04:53:42 -0800 (PST)
Received: from localhost ([2804:30c:4042:6b00:ec80:71ac:dccc:2753])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de33200f2sm93897175ad.242.2025.02.04.04.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2025 04:53:41 -0800 (PST)
Date: Tue, 4 Feb 2025 09:54:25 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, cosmin.tanislav@analog.com,
	jic23@kernel.org, lars@metafoo.de, granquet@baylibre.com,
	u.kleine-koenig@baylibre.com
Subject: Re: [PATCH v3 2/3] iio: adc: ad4130: Add filter_type attributes
Message-ID: <Z6IOAX8m-Jt4aZgt@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1738608986.git.marcelo.schmitt@analog.com>
 <77e5eb540e5d425016ea77a641e16cd31a2a761a.1738608986.git.marcelo.schmitt@analog.com>
 <2f71bc82-c2c4-46d0-ae39-abfa4f2e8dc4@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f71bc82-c2c4-46d0-ae39-abfa4f2e8dc4@baylibre.com>

On 02/03, David Lechner wrote:
> On 2/3/25 1:11 PM, Marcelo Schmitt wrote:
> > Make filter control also available through filter_type attributes which are
> > now standardized in main IIO ABI documentation.
> > 
> > Suggested-by: David Lechner <dlechner@baylibre.com>
> > Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> > ---
> > Hi David, I forgot to ask if you wanted it, but I've added a suggested-by tag
> > for your advice on v2.
> 
> OK with me. :-)
> 
> > 
> > Thanks,
> > Marcelo
> > 
> >  drivers/iio/adc/ad4130.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
> > index de32cc9d18c5..66097ff65740 100644
> > --- a/drivers/iio/adc/ad4130.c
> > +++ b/drivers/iio/adc/ad4130.c
> > @@ -942,6 +942,9 @@ static const struct iio_chan_spec_ext_info ad4130_filter_mode_ext_info[] = {
> 
> I suggest to add a comment here to say that the duplication is intentional and
> the filter_mode attributes are for backwards compatibility.
> 
Okay, will do.

> >  	IIO_ENUM("filter_mode", IIO_SEPARATE, &ad4130_filter_mode_enum),
> >  	IIO_ENUM_AVAILABLE("filter_mode", IIO_SHARED_BY_TYPE,
> >  			   &ad4130_filter_mode_enum),
> > +	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4130_filter_mode_enum),
> > +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_TYPE,
> > +			   &ad4130_filter_mode_enum),
> >  	{ }
> >  };
> >  
> 
> With that...
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

