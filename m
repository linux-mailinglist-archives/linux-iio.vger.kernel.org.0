Return-Path: <linux-iio+bounces-18685-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E65A9DAB9
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 823337A1691
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 12:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1EE2F24;
	Sat, 26 Apr 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JSZu9biw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF44322E;
	Sat, 26 Apr 2025 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745670771; cv=none; b=PFUBfC1NbPyynmXxhpremjS+BOB1k79QMggVYRD4v6fQ9zyR9tNJX3AQLfoMt4TNqJ2j/9d3H913w+QHbffdYXMgeOeWfprzRrTQzj7ti9pamEhb7UKEznZWa9YVl5wW5NvQs/78ISwkG31EsmOz9ulxI6+O1arM4GCPo9Jcd9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745670771; c=relaxed/simple;
	bh=kYRWP9F1X54xHhWxMgVlZK6lr+cRk3emxfKCNO5t184=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PTrvFW0dvtTYPin0mSChFeSXWEkD+EcReM6AFEu3UjBX/CgY8Fzg01DenhxzcK9xLZrrJBPCPGGOKKRshbjugV/muuJLsFIh6VhReIoUSrL6fx5teQf5FM+6cG2/eX+KGL6NH4GwOwOh15vXurWL4J27glU9kt1jr5na8EWnXyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JSZu9biw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92D9FC4CEEA;
	Sat, 26 Apr 2025 12:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745670771;
	bh=kYRWP9F1X54xHhWxMgVlZK6lr+cRk3emxfKCNO5t184=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JSZu9biwIXUTO0YKWYhmWh8FcY/aLhiAemo7n8gJ3NnuBQ4xsrheAnsBGZIeNfJZN
	 QO3QDSBqrG752oCEncefVUVExFUFwNXm87wecJcxB/AL/ZFEFOw9dlkI0z2trEHapT
	 gF7miHsprC2N770X/JG/HxWjkHMlOvKTL/5z7OyiyNO2vYUcwiwZCAckTacC+ixiPn
	 YtIQTrGm5M46del/FJ+tnt3ETVhAIsxCO6ZJXgdxzmJdjXKVFrwnjxtL2c8/fw1O07
	 1XI1RJcctbBoxN1OtTjo6NaKd8JHiWlpHauRZ3dGQtCyzUJe4v1PEyGlLXhIH3btMJ
	 tKqEACnzFTiAQ==
Date: Sat, 26 Apr 2025 13:32:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Alisa-Dariana Roman <alisadariana@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 1/1] iio: adc: ad7192: Refactor filter config
Message-ID: <20250426133241.7d14c776@jic23-huawei>
In-Reply-To: <6d0ff620-ec1a-4b17-9b5d-b9c48078271a@baylibre.com>
References: <20250425132051.6154-1-alisa.roman@analog.com>
	<20250425132051.6154-2-alisa.roman@analog.com>
	<6d0ff620-ec1a-4b17-9b5d-b9c48078271a@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 25 Apr 2025 10:43:29 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/25/25 8:20 AM, Alisa-Dariana Roman wrote:
> > It is not useful for users to set the 3db filter frequency or the
> > oversampling value. Remove the option for these to be set by the user.

I'm curious.  Why isn't it useful?

> > 
> > The available arrays for 3db filter frequency and oversampling value are
> > not removed for backward compatibility.
> > 
> > The available array for 3db filter frequency is dynamic now, since some
> > chips have 4 filter modes and others have 16.  
> 
> The available array only makes sense if the matching attribute is writeable.
> As mentioned in my reply to the cover letter, I think we should keep it
> writeable for backwards compatibility. But we don't need to extend it to allow
> writing new options, so keeping the previous available array seems fine to me.
> 
> > 
> > Expose the filter mode to user, providing an intuitive way to select
> > filter behaviour.
> > 
> > Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

> > +static const char *const ad7192_filter_modes_str[] = {
> > +	[AD7192_FILTER_SINC4] =			"sinc4",
> > +	[AD7192_FILTER_SINC3] =			"sinc3",
> > +	[AD7192_FILTER_SINC4_CHOP] =		"sinc4+chop",

Is chop really a filter? I had to look it up and to me at least it
seems like it isn't even though one thing it does is remove
some types of noise.  It also removes linear offsets (some types
of filter kind of do that, but the affect of chop smells more like
a calibration tweak than a filter)  

Maybe we need a separate control for chop, rather than trying to
force it through our already complex filter type attributes?


> > +	[AD7192_FILTER_SINC3_CHOP] =		"sinc3+chop",
> > +	[AD7192_FILTER_SINC4_AVG2] =		"sinc4+avg2",
> > +	[AD7192_FILTER_SINC3_AVG2] =		"sinc3+avg2",
> > +	[AD7192_FILTER_SINC4_CHOP_AVG2] =	"sinc4+chop+avg2",
> > +	[AD7192_FILTER_SINC3_CHOP_AVG2] =	"sinc3+chop+avg2",
> > +	[AD7192_FILTER_SINC4_AVG8] =		"sinc4+avg8",
> > +	[AD7192_FILTER_SINC3_AVG8] =		"sinc3+avg8",
> > +	[AD7192_FILTER_SINC4_CHOP_AVG8] =	"sinc4+chop+avg8",
> > +	[AD7192_FILTER_SINC3_CHOP_AVG8] =	"sinc3+chop+avg8",
> > +	[AD7192_FILTER_SINC4_AVG16] =		"sinc4+avg16",
> > +	[AD7192_FILTER_SINC3_AVG16] =		"sinc3+avg16",
> > +	[AD7192_FILTER_SINC4_CHOP_AVG16] =	"sinc4+chop+avg16",
> > +	[AD7192_FILTER_SINC3_CHOP_AVG16] =	"sinc3+chop+avg16",
> > +};  
> 
> We need to make these match the values already defined in the ABI docs as much
> as we can.
> 
> I see in the datasheets that there is a REJ60 bit in the MODE register, so I
> would expect to see "sinc3+rej60" in this list as well.
> 
> We already have "sinc3+sinc1" that is defined as 'Sinc3 + averaging by 8' so

hmm. That definition is odd.

> "sinc3+avg8" would be redunant. And given that this driver already uses
> the oversampling_ratio attribute to control the avg2/8/16, I'm wondering if we
> can keep that instead of introducing more filter types.

Tricky bit is whether the device changes the output rate (as needed for oversampling)
or whether it is applying the filter but retaining full output data rate.

Not sure which is happening here.  Given we previously had oversampling I guess
the datarate was affected?


> 
> I also wonder if "sinc3+pf1" could be used for "sinc3+chop" since it is defined
> as a device-specific post filter. Or make the case that "chop" is common enough
> that it deseres it's own name.
> 
> I'm not the best expert on filters though, so I'm sure Jonathan will have some
> better wisdom to share here.

Not a lot.  Too long since I last went anywhere near filters, so beyond agreeing
that we should stick to existing ABI where possible I don't really have any
useful guidance here.




