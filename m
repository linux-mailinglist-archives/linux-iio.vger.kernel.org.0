Return-Path: <linux-iio+bounces-22514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2477AB1FABC
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 17:25:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4AE331782FB
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 15:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BEE268C55;
	Sun, 10 Aug 2025 15:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lrOJx0yK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840B8261574;
	Sun, 10 Aug 2025 15:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754839523; cv=none; b=CXD1kEnDbA6zscY5RTC/amq0fFBwN4PtoDYi5QpxGj3xPFygZ7tsvFszHY051yxBDuuw25/eyFtLB1714aE3U6x6aK98AcY6onZPC8ULlxVv1HU+IMDAvym7WkR48klMcR8leKzam75yRA3kFLCJ3wvs9Nk6OPVNKQwVLfT1aHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754839523; c=relaxed/simple;
	bh=UMvqByEItn8BzyUr0xJF4Yka6HVm+Xgl8P6natx8hVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K7sIWetEJNpWxjgCJ4wr5jqmH3DQ+bLm2K9xvI2w+XiZsgdeyp3IKFjEUt/Scv0Lv2TO8BcoOAexvK6uu/kL9h+iNs6DWZa53A3GmOnH3vfjB1c0I88tMMxb+NX5fUGRNJog6oeN2v/tHkrVRdxxhpo3C5bWGuMrV3xMsxH1tkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lrOJx0yK; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76858e9e48aso3218421b3a.2;
        Sun, 10 Aug 2025 08:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754839522; x=1755444322; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bbge+VDIe77Fv6MWmCP6vsbAEHbx9UcyfcckJVLyYm4=;
        b=lrOJx0yKi/c1IJlCRnCSiRnGJyy7xr275Um6jQuFkT7kkwn1kZXnD8HAZ07Ywo57hj
         lg5b2gObEnRZrPSToBv0VT6QJ0Obu4PxH2wWXKM4+UY9Is4qw33VHCh+q5QvU7W3atNf
         kQJlV505t6Sllebkf5U4CDZXn3kufzDKVeT1sIMX5fTbWsrFDer9h5yhJYvFNBdeSRwY
         KhQjC5X5zQDZ9kBGsffW9Frwfg/46ReKi3L9z6lJHMPyiYkAcux7IOWd0TPz4YuFu4K1
         gg2uWMCP1emnDtZAQLKYWE8Vd9qW9veDAYnpaJbpsWYrOF6NN483w6u1l4jPNBmGzQYc
         SL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754839522; x=1755444322;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbge+VDIe77Fv6MWmCP6vsbAEHbx9UcyfcckJVLyYm4=;
        b=DXRkphkzFhn9aNQp+Fmdk+n83BMHIm91c54ITAAzOD6P13p7R8px63gQ2SpyGWRDda
         /ZdUePgwmFvS8pqSgsaEOJ6gXXjIKZHXhbXXlq3Aum9Qg8OhX/ulCkwfiP9+HPxNrOvG
         9cSmXPFJxsqPbfFTGVEtH/BNE8XmI0afYUIKEOMWB6+AkD3+vYvv98gGaJGXiVw0kkgS
         04UYaeZTMiLr9KhazAAmAnodDsQ22Tz61KghLEemQ89I9A8VCBfS3FcouVLMsOvCT3F1
         TG9qKSWTpiV6kdvxNme9MhRRrmTPxGTsEG9/NlrtTjHX9KTjqcrPlClVDZ+oUa+tMv6O
         wLgQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYGtT7gbVx5eMKvjJBb2USpbpDifp2HUWvFG6EbM5Q4mH98QskRuf96MI79t/AXHApJ0qBY9Sg0Q1T@vger.kernel.org, AJvYcCXDPHHekr1s2IN478Dbz6nTNMb+McMJAzErUMoJBr6y2VfKDsde4iZOwCj6kGpQweyz9CtDS+xErbtEdAgC@vger.kernel.org, AJvYcCXP35d9kbrpnv+rGx+A0mhSVKQjmISsuYwePa+ZtAvzKmjXuSHvB/ItSwelJCP36pAQTg+zukGqT7U/@vger.kernel.org
X-Gm-Message-State: AOJu0YzHMjfu/Q0tzTD4sXJXBlwHF+2bf31qGWxEnk671DhW5pgKgUjV
	GOO5c/hgymKicXBhWaOm0jgqQo0oW08hryrl1fx1pzMqo04AC1nsUfnXTe7tNw==
X-Gm-Gg: ASbGnctfn/QG1sbnmOWWuO1yqW2r51KA5Rbb2SWpWvLlP5jjVPzw0cfbht4Dd3143zf
	umSsWD6/fzQDMMDVsglPjwgHRxLUSWc4l2tFFYHYwgOuw3/9GrtTe7jLcPiQ5ItdkMdpzB3E3va
	DRmocS2OHFoDCA9uL8BCfEu1T6wjofrHMsCFsZYNpwKu+Y43dq1qcSN0kocIJCoLEkfUXY0dvqK
	KEyRPbK6RQusnsieQS1hauI5hWJYCbN0L77uU8rBxpw7onSRk4NyVCnJCFtZ7BGSgNQjRQSDoXH
	bszBcZr4NB8gyRWrKJ7lZt1fYJjP6W1N5jDafrJ7EyI45ZXo3fyGqAntDP2OwtH4AxVwf80eYzq
	Y2Xzk84wd6j/llqEYlCqOv2iBHATFn9c=
X-Google-Smtp-Source: AGHT+IFVt75MGSUVNLrvYC9J2q8iS4INy9Bk3fwGppodCEWIylghqd2DBa0vqF0PZq56BsFJ7VQFxQ==
X-Received: by 2002:a17:902:ec83:b0:240:2145:e51f with SMTP id d9443c01a7336-242c1fd9244mr148275215ad.3.1754839521723;
        Sun, 10 Aug 2025 08:25:21 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241d1ef66dfsm251807485ad.29.2025.08.10.08.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 08:25:21 -0700 (PDT)
Date: Sun, 10 Aug 2025 12:25:35 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] Documentation: ABI: iio: add sinc4+lp
Message-ID: <aJi579-FQwLtWnVF@debian-BULLSEYE-live-builder-AMD64>
References: <20250808141020.4384-1-antoniu.miclaus@analog.com>
 <20250808141020.4384-5-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808141020.4384-5-antoniu.miclaus@analog.com>

On 08/08, Antoniu Miclaus wrote:
> Add new filter type to the sysfs-bus-iio ABI documentation:
> - "sinc4+lp" for Sinc4 + Low Pass Filter
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v3:
>  - change from "sinc4+iir" to "sinc4+lp" for better generic naming
>  - remove "dsp" filter type
>  Documentation/ABI/testing/sysfs-bus-iio | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 28f51e4cc367..caafdd88c601 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2309,6 +2309,7 @@ Description:
>  		* "sinc5+pf1" - Sinc5 + device specific Post Filter 1.
>  		* "wideband" - filter with wideband low ripple passband
>  		  and sharp transition band.
> +		* "sinc4+lp" - Sinc4 + Low Pass Filter.
>  
Not entering the discussion about what would be a proper name for the filter but,
since we had a patch putting filter ABI doc in alphabetical order.
https://lore.kernel.org/linux-iio/20250710-iio-adc-ad7137-add-filter-support-v1-4-acffe401c4d2@baylibre.com/
I guess we keep the docs organized by adding "sinc4+lp" between "sinc4"
and "sinc4+sinc1" (if keeping that filter name of course).

>  What:		/sys/bus/iio/devices/iio:deviceX/filter_type
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_type
> -- 
> 2.43.0
> 
> 

