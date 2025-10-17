Return-Path: <linux-iio+bounces-25164-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6E6BE6148
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 04:08:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B27E54E5A57
	for <lists+linux-iio@lfdr.de>; Fri, 17 Oct 2025 02:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B5D1F30A4;
	Fri, 17 Oct 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pn+XXUkB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABBB8F7D
	for <linux-iio@vger.kernel.org>; Fri, 17 Oct 2025 02:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760666910; cv=none; b=mzGim1NBsKTBsrg8WuJncyERm5pq+c5eZsJvBbBU11BiCnYzgsW8oR/ZzbAOvn4NXXDGgwlQq+YpYw+RKcLpZKbwPU4G4Y4y0qkXLOqoCix4fsXTbX+URqgGKC3pHa8K3T85niAcYFvQwy3ipgFmkuF/vbWJC8De/hxsG50LVI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760666910; c=relaxed/simple;
	bh=uFyNlaBM4GquxmWXZXnlDpJbJJ0E7RwkmEFm9e3w4Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQpx8v6ZtdhT6eLJVRKwFRFE8abcSGJv9pFjZDV2GXyhSn895N7/dISI828lOG1jJ6dItg5AIJp5J+4VJTpXgyqdpFyZR4y0FFrJuMWDJJgREM7gmgzBrd2dThVnehoewEkdwQFLBh/e3hbER9iH3jLsfVnr2sanioWM84/Ek+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pn+XXUkB; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-794e300e20dso2169451b3a.1
        for <linux-iio@vger.kernel.org>; Thu, 16 Oct 2025 19:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760666908; x=1761271708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MxhH6lw9EEPxSD0k2eQCgE+8zTFFn25q7lomjcD/Htk=;
        b=Pn+XXUkBQMPeTkdpibsJ9rEtke6m1f8xG7FaMt26tXhLRKse9FkE9BXnfHoN+MGaF9
         K3cSFmHSwh5uOdTZLbnIH2XKNV8XoZkPU7D9yT2o53Q/Q+D17mefUE3D81TGQVaOAW/Z
         Kq+xVUBW7pVOhPAmX7nL1SknY4Njg0EVMMrl+COVCmC5SQvy8WW+6Rc1TPYym9h2XRny
         rPoN7CwY4XVSvsIx03D5ue/7Qe4hJj0P/q7fNlhkaBkz+BIt8zEXygYRcLV37A7UUfgz
         NZZCkvKj08vaQTBSdKhD5lOfXRw3Ov0oqiUUW34m9fvCWNwsQBgsVJpVlJMsQDCWgfh1
         GRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760666908; x=1761271708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MxhH6lw9EEPxSD0k2eQCgE+8zTFFn25q7lomjcD/Htk=;
        b=GPDHfPiv1NdfTSSS6aJhRJcC+GwOaBhekFjLU3O5TH0fmS9ewtjnfQgWjCGM7xyEQW
         WETFooeuajEaf6oy+z8WJHrWzyhL9OdVGFyHd/WST0SImbwWKyvSNb0gYeUAtBFJhFXj
         vvZ7Qc72W5+glqXvUW2wf6O223F/HpEhaCoVXQUy3MEApYg9i0rMi3w+tY0llPpTjUSP
         rwx6QbCnFQwMknSaFDN7qt8baMn904R9NPj2IG8QGlJ6zfQeTRLqv4rHeDP7JfR0EvM/
         tw7l8MrTqMQSLCZ6nO3/nQK7tVRteh56uBXsykcrXuns/7/LEVvx/endcevmn7h+W2JA
         UrPA==
X-Gm-Message-State: AOJu0YylLxjvYpI9knlNzTP3FRDYpgWfw+bO5EC6s5bilSbim65NngDt
	uAdc6LPa7WvDPjwCGyAES0OmFdxFNzYOo+eXs5qtYWUKpPL4NzqncjAK
X-Gm-Gg: ASbGnctE6e7zsGdP3Ns8NkF6NhZudjUZtvARtSf7Rqm7GTMiKpJan1Y2/TQ90IGwGOE
	sNtYMORH9c7B42mZrFXrL5xqqPtS+IcZXobNuK75es/hcGP3KJAq4x5QwbOD8eWjGL9o6lPmRv0
	K9uBDvy0SQtCkgpUDU7u1OlW6HfI8UGSOO2biKuHNEOfLzea4+WxNBFBghVv0TrlFUB3yvTofa8
	iKkxa56GA3RxSDxSCk2iUziCDrZRFyRtSR9gY8WLG496ZYh+WjhB1kV91ZLhVuR87WqSsEsMJo+
	OWO42xr94J1NncBGZSdm9DpJNiZzpANxIVqfjZGNY5BjSrc23SDaxn1qd5zB41bqJ6oTVvYdt+V
	vAKbnAqidQqG/bpoVDR6VJjJImHIPgEo1mscfw81SVSKFdT/QGOJqdnBjA0DU9Oa0wYjfjznvjD
	/6FITNb3z101x2cd+/5KwY
X-Google-Smtp-Source: AGHT+IGRk1XqmxqYB3GmxV+aJHnx95/Cb2yrslxtxSmrQaVgzp3J2jwQ+Wo8JdgXxNL7955wC+OXaQ==
X-Received: by 2002:a17:903:1a23:b0:271:9b0e:54c7 with SMTP id d9443c01a7336-29091af3a9cmr78700785ad.11.1760666907920;
        Thu, 16 Oct 2025 19:08:27 -0700 (PDT)
Received: from localhost ([2804:30c:402b:1a00:ec78:db53:a246:207a])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-29099aaf693sm45021675ad.80.2025.10.16.19.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Oct 2025 19:08:26 -0700 (PDT)
Date: Thu, 16 Oct 2025 23:09:31 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v13 2/2] iio: adc: max14001: New driver
Message-ID: <aPGlWznNdrPma4jZ@debian-BULLSEYE-live-builder-AMD64>
References: <830368e5bc303faf04f542268acb95e99d0d1cde.1760502331.git.marilene.agarcia@gmail.com>
 <2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e0e5fadeb3083a79a31776d9e996b865c1b1f5f.1760502331.git.marilene.agarcia@gmail.com>

On 10/15, Marilene Andrade Garcia wrote:
> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers
> more features, like a binary comparator, a filtered reading that can
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush
> comparator that triggers the inrush current. There is also a fault feature
> that can diagnose seven possible fault conditions. And an option to select
> an external or internal ADC voltage reference.
> 
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.
> 
> Co-developed-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
> Signed-off-by: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
> Tested-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

Hmm, I don't know why, but I would have given a different order to the tags
Reviewed-by: M. S. <...> # new tag
Tested-by: M. S. <...>
Co-developed-by: K. S. P. <...>
Signed-off-by: K. S. P. <...>
Signed-off-by: M. A. G. <...>

Swapping tag lines will probably not be a reason for a v14, though.

Cheers,
Marcelo

