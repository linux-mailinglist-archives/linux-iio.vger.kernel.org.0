Return-Path: <linux-iio+bounces-17408-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA323A7638E
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37BB8167510
	for <lists+linux-iio@lfdr.de>; Mon, 31 Mar 2025 09:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF921DED40;
	Mon, 31 Mar 2025 09:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbxfz0nQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04F1DE3AA;
	Mon, 31 Mar 2025 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414544; cv=none; b=bWhZ2pYaAbWuqN3WsJ0XQoyLryZDKK4SMtiwfv6G0H2wBpO5K/JFyAb3gE1ttH9lhk4Li/gFbLj2W13fBE27RRW2Kcz++cAjTpD4h2fEOdVyAzBYB7VHSsBEqZMP8iIiJB3SNTwdedNlOu9Nnv395zV4UvrXJv0K2TiCIDGTnDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414544; c=relaxed/simple;
	bh=9MmRAQT7FkmG5GtAiYqFguUGDYdzNTFv3scMm94gPxo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xga5kIpTOE6WD6MELP60+XqFNNm7+aZgy36x0bmv5NY3eqPhXvDy5Wx+mAe6v1r3z025zjJTsJUusOf7x+EQmL2quuvaPLYJOYaXY7hALlWP/WSVMXlO54jdAHPeUnPhbRb0t3rIPJgPWP7vflirIXqMZtkoAiK2Cn31uczuB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbxfz0nQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE06CC4CEE3;
	Mon, 31 Mar 2025 09:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743414543;
	bh=9MmRAQT7FkmG5GtAiYqFguUGDYdzNTFv3scMm94gPxo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rbxfz0nQRvHl/a30jPVpQGtLtt86XG3ULJs/CF+eZZkMtvUNiYuJh+0G2eln3liVH
	 KAdkt7f1vTHW5uvqtzm+lcoaDP/ejYuYkP6okHVEwImHA1skjNbh/pPQyw9kOupmBD
	 z08ZVkGlbczdSo5q7zrupGuOmHaQgAFF7B0gIGr+8PhbjuZg118Rf90ZT9uhLPsrPw
	 yv5OgKyCX3o88F/x1xODN1IkZvfTiF3yvEEFsx1ndYH7BQBHKuOk7MUK7DPuydzxZP
	 R67Qy4dU8pw+stj/MfU2o9e1u6NKKgvq0amXF03neIgSaESwh7kySTzLpsAZt/O04t
	 kDZtyJqm8WbYg==
Date: Mon, 31 Mar 2025 10:48:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, Matti Vaittinen
 <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland
 <samuel@sholland.org>, Nuno Sa <nuno.sa@analog.com>, David Lechner
 <dlechner@baylibre.com>, Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Guillaume Stols <gstols@baylibre.com>, Dumitru Ceclan
 <mitrutzceclan@gmail.com>, Trevor Gamblin <tgamblin@baylibre.com>, Matteo
 Martelli <matteomartelli3@gmail.com>, Alisa-Dariana Roman
 <alisadariana@gmail.com>, Ramona Alexandra Nechita
 <ramona.nechita@analog.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v10 3/8] iio: adc: add helpers for parsing ADC nodes
Message-ID: <20250331104849.3eb748a8@jic23-huawei>
In-Reply-To: <4d66b3b5-bfcb-42f0-9096-7c448c863dfc@gmail.com>
References: <cover.1742560649.git.mazziesaccount@gmail.com>
	<f1d8b3e15237947738912c0d297b3e1e21d8b03e.1742560649.git.mazziesaccount@gmail.com>
	<Z-mnNtYLkwsTYjMh@debian-BULLSEYE-live-builder-AMD64>
	<4d66b3b5-bfcb-42f0-9096-7c448c863dfc@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Mar 2025 08:39:35 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Hi Marcelo,
> 
> Thanks for the review!
> 
> On 30/03/2025 23:19, Marcelo Schmitt wrote:
> > Hi Matti,
> > 
> > The new helpers for ADC drivers look good to me.
> > I am now very late to complain about anything but am leaving some minor comments
> > below that can be completely ignored.
> > 
> > Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> > 
> > Thanks,
> > Marcelo
> > 
> > On 03/24, Matti Vaittinen wrote:  
> >> There are ADC ICs which may have some of the AIN pins usable for other
> >> functions. These ICs may have some of the AIN pins wired so that they
> >> should not be used for ADC.
> >>
> >> (Preferred?) way for marking pins which can be used as ADC inputs is to
> >> add corresponding channels@N nodes in the device tree as described in
> >> the ADC binding yaml.  
> > Not sure it's preferred to have ADC channels always declared in dt. That
> > question was somewhat also raised during ADC doc review [1].  
> 
> I had missed that doc and the review. Interesting read, thanks for 
> pointing it :)
> 
> We did also do a bit discussion about this during the review of the 
> earlier versions. I am not sure if we found an ultimate common consensus 
> though :)
> 
> A recap as seen through my eyes:
> 
> - It is preferred to have either _all_ or _none_ of the channels 
> described in the device tree.
> https://lore.kernel.org/all/20250201162631.2eab9a9a@jic23-huawei/
> 
> - This, however, is not _always_ required to be followed, and it may be 
> impractical in some cases:
> https://lore.kernel.org/linux-iio/6f6e6550-5246-476f-9168-5e24151ab165@baylibre.com/#t
> 
> - We do have bunch of existing drivers which we need to support. With 
> some very different approaches to bindings.
> https://lore.kernel.org/linux-iio/20250302032054.1fb8a011@jic23-huawei/
> 
> 
> My _personal_ thinking is that:
> 
> This means that we can't hide the binding parsing in the IIO-core. We 
> can't go and change the channels in existing drivers.
> 
> But, we can provide helpers (like this one) for drivers to use. I also 
> believe we should still try to have common (and preferred!) approach for 
> the _new_ drivers. Eventually, the new ones will be majority. Some of 
> the old ones die, and if we keep same practices for new ones, the old 
> ones will become rare exceptions while majority follows same principles ;)
> 
> > In short, ADC
> > channel may and may not be declared under ADC dt node. ADC bindings often don't
> > enforce channels to be declared. On IIO side of things, many ADC drivers just
> > populate channels even if they are not declared in dt.
> > The ADCs you are supporting in the other patches of this series seem to require
> > dt declared channels though.
> > 
> > [1]: https://lore.kernel.org/linux-iio/20250118155153.2574dbe5@jic23-huawei/
> > 
> > Would something like
> > 
> > A common way of marking pins that can be used as ADC inputs is to add
> > corresponding channel@N nodes in the device tree as described in the ADC
> > binding yaml.
> > 
> > be a good rephrasing of the above paragraph?  
> 
> Yes, if we don't want to guide new drivers to either have all usable 
> channels, or no channels in the device tree.
> 
> I think Jonathan said he'll be rebasing this to rc1. I am a newcomer and 
> I should not enforce my view over more experienced ones ;) So, feel free 
> to reword the description as Marcelo suggests if you don't think we 
> should prefer one direction or the other.

I've gone with Marcelo's suggestion because I don't want to be too specific
here given the complex history.   We can absolutely encourage the all or
nothing description going forwards though as it is logical in the vast
majority of cases.


> 
> >>
> >> Add couple of helper functions which can be used to retrieve the channel
> >> information from the device node.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >>  
> > ...  
> >> +static inline int iio_adc_device_num_channels(struct device *dev)
> >> +{
> >> +	return device_get_named_child_node_count(dev, "channel");
> >> +}  
> > I wonder if this function name can eventually become misleading.
> > 
> > In Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml we have
> > temperature sensor with channel nodes named after external hardware connected to
> > the sensor, leading to channels having different node names. Can anything like
> > that ever be accepted for ADC bindings?  
> 
> My initial thinking is that the hardware which is connected to the ADC 
> should have it's own node - and there should be only a reference from 
> the ADC to the other hardware's description. I think the connected 
> hardware should not be a property of the ADC channel.
> 
> Anyways, the current ADC binding (bindings/iio/adc/adc.yaml) says the 
> node name must be channel[@xxx] (which, I believe makes sense as it 
> makes it easier to understand device-trees for ICs which may provide 
> other nodes but ADC channels too).
> 
> properties:
>    $nodename:
>      pattern: "^channel(@[0-9a-f]+)?$"
>      description:
>        A channel index should match reg.
> 
> Yours,
> 	-- Matti


