Return-Path: <linux-iio+bounces-16544-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E0A57A6A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:21:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 709121893344
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 13:21:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94881CDFD5;
	Sat,  8 Mar 2025 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLqNth7O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C441CAA67;
	Sat,  8 Mar 2025 13:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741440047; cv=none; b=cuVCV/fOdpdwnORwMogltKymKtkdJUhWg7KQr31/4/FUNVu4ZCDG52yMWcrocFLuMMsGnwoGdlIKLd9ko1ae2RTsJZT59hOQKtSTZSqEUKID9ThhlWmDYd7iwz17/UC2obqpAdnnFiYD1uSIRgzT0Ufc9GpjN7yM5+RXd5684L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741440047; c=relaxed/simple;
	bh=wkOj3hbpP+iM5nyzE4S8ZbPON7SYqYnTwu7lhZtPdm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vt+ER6ZDZ67BzFW5cKH6Lv2hH1aXgc3FaFZJud5lorLUmTDZ+OUVCjGm//95WFMrpTXCldbwwq4FIqU4LZ+3sn/l0+K75pPIL4shseCuD68NiH5SAdLIesTo1If07iMeXYGgmMfeLM8fAVunT9tv7za/wsFQhSj5qY0pkj/QeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLqNth7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8813AC4CEE0;
	Sat,  8 Mar 2025 13:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741440046;
	bh=wkOj3hbpP+iM5nyzE4S8ZbPON7SYqYnTwu7lhZtPdm0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gLqNth7OJQX1YXEFhCK/Vp0FuuOWrTwBfXoWJW/pzC5OV7AnJwVfNoE+UgGimolMU
	 /0OVtlbkaAw7LmuApwzFw8MeBmJiVe6edYvYD9mXXXN9vrar2TiakpZRCh9m0cmfue
	 TVJuuhszRj6LSf60xj7jXnbSi5hv0Wk0k3tVMqq45ByOxgOP62VefttYyKGz70Xwyt
	 viuBZwJlSri5nWwaaTuB/dj1BGgKxuZ/eySEbryuoMSXeOzeRVNVFiHIJCHJdKl0cC
	 qaLnpy2EBVLh0E+GqXcEyiq6QOj8g7Wzh7+KGeqfYhGpUhLrrIO1OTcG6f42lnS+Ky
	 hHAaN7dk2VPuA==
Date: Sat, 8 Mar 2025 13:20:37 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 marcelo.schmitt@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linus.walleij@linaro.org, brgl@bgdev.pl,
 lgirdwood@gmail.com, broonie@kernel.org, dlechner@baylibre.com,
 jonath4nns@gmail.com
Subject: Re: [PATCH v4 06/17] Documentation: ABI: add wideband filter type
 to sysfs-bus-iio
Message-ID: <20250308132037.69999683@jic23-huawei>
In-Reply-To: <Z8rqWR7OKZMIcmB6@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
	<b390ec6d92dd742ace93bd8e40a0df4379b98e23.1741268122.git.Jonathan.Santos@analog.com>
	<Z8rqWR7OKZMIcmB6@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Mar 2025 09:45:13 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 03/06, Jonathan Santos wrote:
> > The Wideband Low Ripple filter is used for AD7768-1 Driver.
> > Document wideband filter option into filter_type_available
> > attribute.
> > 
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---  
> 
> LGTM
> 
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> 
> FWIW, ADAQ7768-1 datasheet provides more info about what wideband should mean
> for these devices.
> "The wideband filter offers a filter profile similar to
> an ideal brick wall filter, making it ideal for frequency analysis."
> The proposed doc seems to portray that to some extent.

Always a bit tricky to come up with filter docs that are specific
enough but not too specific as to be useless for other devices.
I think this is a reasonable balance.

Applied (note I haven't picked up any of the dt bindings in last
few patches yet as all are somewhat dependent on the trigger-sources
one by context at least!)

Jonathan

> 
> > v4 Changes:
> > * None.
> > 
> > v3 Changes:
> > * None, since we still did not agree on a better name for this filter type.
> > 
> > v2 Changes:
> > * Removed FIR mentions.
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> > index f83bd6829285..9b879e7732cd 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio
> > @@ -2291,6 +2291,8 @@ Description:
> >  		* "sinc3+pf2" - Sinc3 + device specific Post Filter 2.
> >  		* "sinc3+pf3" - Sinc3 + device specific Post Filter 3.
> >  		* "sinc3+pf4" - Sinc3 + device specific Post Filter 4.
> > +		* "wideband" - filter with wideband low ripple passband
> > +		  and sharp transition band.
> >  
> >  What:		/sys/.../events/in_proximity_thresh_either_runningperiod
> >  KernelVersion:	6.6
> > -- 
> > 2.34.1
> >   


