Return-Path: <linux-iio+bounces-21242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE4AF5B73
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 16:44:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2495B4A066D
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 14:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371613093B0;
	Wed,  2 Jul 2025 14:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7fJak/R"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EF307AE8;
	Wed,  2 Jul 2025 14:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751467482; cv=none; b=DQ8zwHdWL5m62vUe6gqm4H2Pg52XWlojIMFalNkcoFx+//hsHvCFy+6OY0uUuNgTzBL1eXX8bDSBKUT54CggCMeagCVdKc2/jq1eyBYCQFR+OZAhWvepVtttEU7XrNV+jb5GB3UfTYBVxtl6qzYBMx6PiSlYDWebShj9Rwwa/WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751467482; c=relaxed/simple;
	bh=dIhZkNW3gjEURrt2LwtYenbRsdX0gVg1dIBAdJYfSgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGrchqS22kfFnglWe6zA1qZQwF1zFQSPmFaJzQnfBqPvFcg7BtwFuOAsl7Aql2yiY1rh0TdGYYaai9eqK39kM5OZmHi3+69qwAL20o2ktOqU1hk8XJ9cQmPrGG/RtNeRUdkE8UJmRIpRB/18hsh9Yi4u/rckfsEPsl/iE0Tnig4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7fJak/R; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7d3cc0017fdso488724685a.3;
        Wed, 02 Jul 2025 07:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751467479; x=1752072279; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lVAUHsF9DNYSa/iYiugjbpYggI5LGAKgst70gtbBVuQ=;
        b=O7fJak/RjWVRz1KYw2g/xdaxguuFW/HJZPcOaj5pEj9ID0Qgqdzyx7Vtybt7VPREDZ
         qj9SNcbmP4DWL1SPB7iLZWe7iNHy4oArNGB0tEz1tcKNzTphbnYK6ChWj7NWelQ5G3LG
         BOwEz0kwx0zb5m1Hwk5KQfOlVht9ts5iaOM7noUW+INQ0ytSQhp8+SNxINioHCkaf/Yo
         AkaMKk8RREl2n7X5AlC3RzVgg3BHHqjxQCCW4Zfdeyia06hr3G9ZZ1MQPbE9RBxaA13B
         vjVc7lUJDJDaNDWj734UvZqCj9tXqCMAZOZG56+SvD/RA2gyQKoN1uSd+0kKOvKNZTzH
         +6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751467479; x=1752072279;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lVAUHsF9DNYSa/iYiugjbpYggI5LGAKgst70gtbBVuQ=;
        b=DRhoaa86/7qcOsrq6LmvnNexiirTp+sh8KR0yXailrGm78zB26uHgC9obBb9eIeBRP
         MnjCKUkWBdJ2Oj2ozE6bSkxRmJwlYbsWiFE4Qzsw+l3M30OGQlUkkCnp6kjhdsWLTbNQ
         EdKLc7c0ixt/0kgp0QXTvgJIm5LmQ4kMKxjAaKwPUYApz3BS8nYdJvwmjkGE2CNiu4uy
         naHfQB26pr86gP/pfxQmftZgTXAH86hybe7DANYaKVBPhy0cYUyP1IQkOyixlYz7RIS5
         gN8Xl5i8/UMw6wzWDiCB8xyblJpOhUAox1VSLZDFiLWik8MiPLpoGL6dpKX3WY7XfaUa
         ZfDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMP1KHwL4ZZby8FA3dSLzNxQ1aA60GDFhnrys1xDzTVVhJni0YVvptu9Ai2DnS4lkmT8WknSJuMbQ=@vger.kernel.org, AJvYcCXUXBD8xFmPxrTNphIr2oJ4OY3dMewTieHY40GLZsP8eli9fG6JoEvAarTTTHGzq3iSBxwlhmxTedkLXgXY@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDMeJhUkxEESehK8jYZeLgBctmqw7V6Oi+KbVzPAL4tRKM3yk
	J5cKryVFf0e9/64wE9lsdFawSIcbl27MZqseRQGWkUujjtWDlaeCvRWD
X-Gm-Gg: ASbGncs/6a1IxEF54lN53oSid4foXxFNYSkTyZfnEVZ0e1NrbL32tHYOWmqc1hvYrGk
	o2GCEEKtQSk7JQlT2VkmMvd9I1LY71Yn6BWBj/IqGOT5BagZh6vI3XRzu6knRSOBxMs2HrIaX4C
	ExyuGP5l7TcaxkmJwvUbpqS/TFfyXIoJw4RYUDBpUDKIJeq7tD2KFNE52lpyvvdQKbNmsKNPDmD
	7MbK81INux4Yd8B6//kgF4hlf5nbbWxw2ZYgVbajtoNDA566LWCeeaX7T2iWXMOaHihT9sEfXVc
	IZKcdvya8j9xkr8a2dLBxnT/aBOhP0/Y4U/2fl12rDzNkO0JqcL2x+zlcsR4Fce49cb1Pg==
X-Google-Smtp-Source: AGHT+IEUUzQZ77xkfyRexb4hYyJNdV0cwKqIdsWyojwhD5PuT/fqb0HqrNPfKT4SY2N7KTfvoOQ7tQ==
X-Received: by 2002:a05:620a:4711:b0:7d4:4b7d:fc66 with SMTP id af79cd13be357-7d5c4725221mr506896585a.18.1751467479088;
        Wed, 02 Jul 2025 07:44:39 -0700 (PDT)
Received: from localhost ([2804:30c:b15:b200:425a:de22:1d7f:2d4b])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7d453bc5b00sm663795285a.92.2025.07.02.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 07:44:38 -0700 (PDT)
Date: Wed, 2 Jul 2025 11:46:38 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ad4000: don't use shift_right()
Message-ID: <aGVGTn3zFV1CuSQp@debian-BULLSEYE-live-builder-AMD64>
References: <20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-iio-adc-ad4000-don-t-use-shift_right-v1-1-041c2d6c3950@baylibre.com>

On 07/02, David Lechner wrote:
> Drop use of shift_right() macro for unsigned value. The shift_right()
> macro is intended for signed values and is not needed for unsigned
> values.
> 
> This was found by a static analysis tool [1].
> 
> Link: https://github.com/analogdevicesinc/linux/pull/2831/files#diff-c14a34a6492576d22e7192cc0f61ad0083190aeb627191596fe12462f0c6f21aR557 [1]
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>

>  drivers/iio/adc/ad4000.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad4000.c b/drivers/iio/adc/ad4000.c
> index 5609a7845b6f50b5818613170df6b234f8f0c496..fd3d79fca78581e51bb904d0bcfeda3d3663ea25 100644
> --- a/drivers/iio/adc/ad4000.c
> +++ b/drivers/iio/adc/ad4000.c
> @@ -554,7 +554,7 @@ static void ad4000_fill_scale_tbl(struct ad4000_state *st,
>  	val = mult_frac(st->vref_mv, MICRO, st->gain_milli);
>  
>  	/* Would multiply by NANO here but we multiplied by extra MILLI */
> -	tmp2 = shift_right((u64)val * MICRO, scale_bits);
> +	tmp2 = (u64)val * MICRO >> scale_bits;
>  	tmp0 = div_s64_rem(tmp2, NANO, &tmp1);
>  
>  	/* Store scale for when span compression is disabled */
> 
> ---
> base-commit: 6742eff60460e77158d4f1b233f17e0345c9e66a
> change-id: 20250702-iio-adc-ad4000-don-t-use-shift_right-bda6e41152b6
> 
> Best regards,
> -- 
> David Lechner <dlechner@baylibre.com>
> 
> 

