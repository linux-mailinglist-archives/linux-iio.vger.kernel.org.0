Return-Path: <linux-iio+bounces-13720-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0E9F91E7
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 13:05:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3355316CB1C
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 12:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901FC1C4A1B;
	Fri, 20 Dec 2024 12:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2uM9Cz/S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94E81C07CB
	for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2024 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734696328; cv=none; b=V9Rb4ab4uWmcrU/VB5Z6d/P8fHCjHHHhARM6zbYO02jGGRztMK8QSqOOUe57NIuxPmg0SgkKyi3Er4TPyeMKlQG0YaotKcRtNZPogHfcpikGlez9UlQEiSRVfsbXiNTl7MTEU0h2OXRkc6bQweeRKgzDe5XesCakipY1orsrISg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734696328; c=relaxed/simple;
	bh=OZBBSDeW7DnEv6n8+6rOsW4Zul6+s8HRmT9hVRXc7oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGHf9SEvgRTdpuA5KpfDBN5pkyKu9sAmWSG2LvQ+MdbephHWWzOZCVsz1E+rka+D4A/atuWzwvz+UQXRK9WprWEGCMptoabP27LhC4vydWU8MQEaTZkQWtYloh2MmqsivPVIhMWJjqKt8boJHhYLuOtdp1E14s4IAPClbkl9wt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2uM9Cz/S; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43621d27adeso12537595e9.2
        for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2024 04:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734696323; x=1735301123; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GCXKmY+MCGkyet8cjqKPZKqriDwLLIrDQxCbyQYAuEg=;
        b=2uM9Cz/SsHt8mGbjFhRI2N+x2/ardafJb9YJcVL46EkZ7gxbvPp4J1VFytA2zE3IBs
         b6Qv8s9QnDg+KuuZHKwt8DNyMhsdk3G7eJqPuJ8QbEuqRwWzf2j4gydHdhPhg8O57r4g
         Zw4rrdoDQiNFRQ49iT4WsOdHaxaTJRTokLkvNfeTzeeK1NDB9Q+eSO4RxH0LLb1urnih
         HZyYaWXncrswQTm1lGlBjE8LRFqY8/+Vp5IN1MIGrCaZI/EZ/WB8/aojvyjaXnDLEMFk
         rXt1MEL+ku+r0Qfjrb36fb3Lk9+wpvufdJNO6NUMinWagZ+iBnmUbbD53vsx3QhpGN9S
         X+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734696323; x=1735301123;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCXKmY+MCGkyet8cjqKPZKqriDwLLIrDQxCbyQYAuEg=;
        b=aRw3q6ech+cAzb71s8FbqqesfJ3onh9WFkw3O66OeAQYMt30hhnF/YDUeu7K2//+Bx
         /qqi0UiNBm3oYiTlqN5GzVxXEXpmlFX+pVU9ONPhD7Rp2Q1OnuKXl/YE8bRp22BxUySe
         GkTHjxQAM1DXoParYLYjhaWkADoV/yXNF7g3ctbkOlyMYyJhbH300azv0uF/VSg2UAvR
         /B3GZ9fgvb+vfG+AmfgUVSCcOwB+9aJJLN4hSALIRwMkfvwCkMW3nr1mls3JGMt/8fPN
         7K4eafsyTnWKtY5Nkkmi5XwthUyaKv05Bn2Xcot6pIMgNfVS4dsgBqj+YDF7A+Ve9Ucs
         oM5A==
X-Forwarded-Encrypted: i=1; AJvYcCWEYaX3WUd7u0ESzOKkeRp4oLnu2xt/tgFfwh6AJuz3KhgwtP3rem8Snre1QzF1+qxAQ6YaqC8zCg4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxW6/i0U6A6WRZPeLG2h3D52ggvXuEF95vL4qpWwVCh1iXOzdvx
	0xbdO1/2oiLXchGfVsHq0vE/wEh2iOKKGr4FnukqfNBAUFJVTLX7Poh/PHURqmM=
X-Gm-Gg: ASbGncvyBO/xgdGPACjTWuRH53v8tCi0oMqswlcpfn4jo0KKVNK5cHqKC4Z7kqE/NgF
	3sq7Sqfi9YAkMzT/J9cTkfoac3CpCq68QIXIDGNm9AeerlEH+8tH+OQD4DAxB0it9o80IJKqnX0
	jxEcUAjb37G+Hj+YEylbfQAIi6oJB2WPXyuWqepHUvRKXWoktHgs4pdw6dZ40UAnTfyoO1Ag5Zl
	4clHD5C89wCc3U37EX450FcJ3qEsfVdKddTm17kdDYcoD+wyEU=
X-Google-Smtp-Source: AGHT+IG9e9gquYAYx998C6Z58rPhjZ3d7+8rug+BHo+0YVA5ve8koj35pN0GHAt0z1+Z38MCnST/fg==
X-Received: by 2002:a5d:5848:0:b0:385:df2c:91aa with SMTP id ffacd0b85a97d-38a221f2fe9mr2774709f8f.7.1734696323019;
        Fri, 20 Dec 2024 04:05:23 -0800 (PST)
Received: from dfj ([79.17.239.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c89e357sm4001037f8f.72.2024.12.20.04.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:05:22 -0800 (PST)
Date: Fri, 20 Dec 2024 13:03:48 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, 
	Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: Re: [PATCH 4/8] iio: backend: add API for interface configuration
Message-ID: <6uqmmmdg3gtn5idq35pcs34bjpxcrje2kfr4lboreloij6zzrs@qshqtslkpmp2>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
 <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-4-856ff71fc930@baylibre.com>
 <b5a773858a71e6929667fc73b9384908ca3ff313.camel@gmail.com>
 <20241219164233.087ff9cb@jic23-huawei>
 <20241219165115.23717a71@jic23-huawei>
 <94efa413-5fa9-4014-86c2-331442e9d42e@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94efa413-5fa9-4014-86c2-331442e9d42e@baylibre.com>

On 19.12.2024 11:01, David Lechner wrote:
> On 12/19/24 10:51 AM, Jonathan Cameron wrote:
> > On Thu, 19 Dec 2024 16:42:33 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> >> On Tue, 17 Dec 2024 11:13:59 +0100
> >> Nuno Sá <noname.nuno@gmail.com> wrote:
> >>
> >>> On Mon, 2024-12-16 at 21:36 +0100, Angelo Dureghello wrote:  
> >>>> From: Antoniu Miclaus <antoniu.miclaus@analog.com>
> >>>>
> >>>> Add backend support for setting and getting the interface type
> >>>> in use.
> >>>>
> >>>> Link:
> >>>> https://lore.kernel.org/linux-iio/20241129153546.63584-1-antoniu.miclaus@analog.com/T/#m6d86939078d780512824f1540145aade38b0990b
> >>>> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> >>>> Co-developed-by: Angelo Dureghello <adureghello@baylibre.com>
> >>>> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> >>>> ---
> >>>> This patch has been picked up from the Antoniu patchset
> >>>> still not accepted, and extended with the interface setter,
> >>>> fixing also namespace names to be between quotation marks.
> >>>> ---
> >>>>  drivers/iio/industrialio-backend.c | 42
> >>>> ++++++++++++++++++++++++++++++++++++++
> >>>>  include/linux/iio/backend.h        | 19 +++++++++++++++++
> >>>>  2 files changed, 61 insertions(+)
> >>>>
> >>>> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industrialio-
> >>>> backend.c
> >>>> index 363281272035..6edc3e685f6a 100644
> >>>> --- a/drivers/iio/industrialio-backend.c
> >>>> +++ b/drivers/iio/industrialio-backend.c
> >>>> @@ -636,6 +636,48 @@ ssize_t iio_backend_ext_info_set(struct iio_dev
> >>>> *indio_dev, uintptr_t private,
> >>>>  }
> >>>>  EXPORT_SYMBOL_NS_GPL(iio_backend_ext_info_set, "IIO_BACKEND");
> >>>>  
> >>>> +/**
> >>>> + * iio_backend_interface_type_get - get the interface type used.
> >>>> + * @back: Backend device
> >>>> + * @type: Interface type
> >>>> + *
> >>>> + * RETURNS:
> >>>> + * 0 on success, negative error number on failure.
> >>>> + */
> >>>> +int iio_backend_interface_type_get(struct iio_backend *back,
> >>>> +				   enum iio_backend_interface_type *type)
> >>>> +{
> >>>> +	int ret;
> >>>> +
> >>>> +	ret = iio_backend_op_call(back, interface_type_get, type);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	if (*type >= IIO_BACKEND_INTERFACE_MAX)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	return 0;
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_get, "IIO_BACKEND");
> >>>> +
> >>>> +/**
> >>>> + * iio_backend_interface_type_set - set the interface type used.
> >>>> + * @back: Backend device
> >>>> + * @type: Interface type
> >>>> + *
> >>>> + * RETURNS:
> >>>> + * 0 on success, negative error number on failure.
> >>>> + */
> >>>> +int iio_backend_interface_type_set(struct iio_backend *back,
> >>>> +				   enum iio_backend_interface_type type)
> >>>> +{
> >>>> +	if (type >= IIO_BACKEND_INTERFACE_MAX)
> >>>> +		return -EINVAL;
> >>>> +
> >>>> +	return  iio_backend_op_call(back, interface_type_set, type);
> >>>> +}
> >>>> +EXPORT_SYMBOL_NS_GPL(iio_backend_interface_type_set, "IIO_BACKEND");
> >>>> +
> >>>>  /**
> >>>>   * iio_backend_extend_chan_spec - Extend an IIO channel
> >>>>   * @back: Backend device
> >>>> diff --git a/include/linux/iio/backend.h b/include/linux/iio/backend.h
> >>>> index 10be00f3b120..2b7221099d8c 100644
> >>>> --- a/include/linux/iio/backend.h
> >>>> +++ b/include/linux/iio/backend.h
> >>>> @@ -70,6 +70,15 @@ enum iio_backend_sample_trigger {
> >>>>  	IIO_BACKEND_SAMPLE_TRIGGER_MAX
> >>>>  };
> >>>>  
> >>>> +enum iio_backend_interface_type {
> >>>> +	IIO_BACKEND_INTERFACE_SERIAL_LVDS,
> >>>> +	IIO_BACKEND_INTERFACE_SERIAL_CMOS,    
> >>>
> >>> The above are apparently not used in the next patch so I would not add them now.  
> >>>> +	IIO_BACKEND_INTERFACE_SERIAL_SPI,
> >>>> +	IIO_BACKEND_INTERFACE_SERIAL_DSPI,
> >>>> +	IIO_BACKEND_INTERFACE_SERIAL_QSPI,    
> >>>
> >>> I'll throw my 2 cents but it would be nice to have more feedback on this. I'm
> >>> not completely sure about the xSPI stuff in here. We treated the QSPI as a bus
> >>> both for control and data in which we also add child devices. And we've been
> >>> adding specific bus operations/configurations through the 'struct
> >>> ad3552r_hs_platform_data' interface. So, I'm wondering if this should also not
> >>> be set through that interface?  
> >>
> >> Maybe - kind of hard to tell until we actually have code.
> >> I'd go for kicking them into the long grass for now if they aren't used and
> >> just dropping them from this patch.  If we ever need them,easy to bring back
> >> and then we should have a justification for why!
> > 
> > oops. Misread. Obviously Nuno was saying the ones above aren't used, not the
> > SPI ones...  I don't feel strongly either way on setting these via
> > this generic interface, or via the other path.
> > 
> > Jonathan
> > 
> >>
> >> J
> >>
> >>
> >>>
> >>> LVDS/CMOS still looks slightly different to me...
> >>>
> >>> - Nuno Sá
> >>>
> >>>
> >>>   
> >>
> >>
> > 
> 
> I'm the one that suggested doing it this way to Angelo, so I'll chime in
> with my thinking. In Angelo's previous series where we added IIO backend
> support for this family of chips, in the devicetree discussion, we
> considered the possibility of two SPI controllers, one for register
> access and one for the high-speed streaming provided by the backend.
> Since the dual and quad SPI here is for IIO backend (the high-speed sample
> data interface) is what made me think we should put the control here rather
> than putting it in the platform data interface.
> 
> Since this is new HDL, maybe we could avoid this issue altogether and
> tweak the implementation in the FPGA a bit. Clearly we had the AD3552R
> working without needing to poke this registers, so why can't we do the
> same for the new chip? In other words, make these things a compile time
> option in the HDL rather than a runtime option?

The purpose of the new HDL is to support all the devices of the family,
(DSPI/QSPI) just acting on axi MULTI_IO_MODE.

Thinking to this a bit better, changing MULTI_IO_MODE is not exactly changing 
"interface" type so maybe is more appropriarte to use a patform data
"bus_mode" function.

New ad354x chips do not have QSPI pin, so no chance to access the whole
primary + secondary area in DSPI without changes in configuration registers,
as done before with ad355xr.

Regards,
angelo


