Return-Path: <linux-iio+bounces-1125-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6491B81A0EE
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 15:17:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE08A1F21B8B
	for <lists+linux-iio@lfdr.de>; Wed, 20 Dec 2023 14:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFC38DDD;
	Wed, 20 Dec 2023 14:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BRDNau60"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED38F82;
	Wed, 20 Dec 2023 14:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5AA1C433C7;
	Wed, 20 Dec 2023 14:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081855;
	bh=8iJAKkOxn0a+mkGUza4LxIQgZ+AV7pW6OI583SY1dAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BRDNau60LhCTuWfdeUv2WUroSKfh39MJhGJ+BxPv14T4+jIbcQqRX3nPjn55L9TP6
	 tiLZDi4KUyN3jTKCv2Db0k/JnN5rYxwWuuvYe/4xOS/Kl2mSMvJmq10pBR20FopCjV
	 lXgPZ301PonTxZnZEX6wD2rZuh9a+Qv3o1Rz45aO/1kjfZEwIoVfDrbunmy3r9JD3P
	 RpP8vLXBViftrEOYuwicZn5D+ecVGVvdSfmNCfsRHaeDS8BKRfkNoM2oJPEY6pulii
	 6kkri7UVUe59LMxE1/ub1JyJL/vxQ3Dv1gi+/UDWiETmzTTnoBYCq4zhuFV2Ib7sRM
	 xYUtoYO0+Khbw==
Received: (nullmailer pid 155474 invoked by uid 1000);
	Wed, 20 Dec 2023 14:17:33 -0000
Date: Wed, 20 Dec 2023 08:17:33 -0600
From: Rob Herring <robh@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
Message-ID: <20231220141733.GA145578-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
 <20231214141600.GA224419-robh@kernel.org>
 <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
 <20231214170326.GA458046-robh@kernel.org>
 <dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
 <20231217140412.237511b8@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231217140412.237511b8@jic23-huawei>

On Sun, Dec 17, 2023 at 02:04:12PM +0000, Jonathan Cameron wrote:
> On Fri, 15 Dec 2023 16:18:39 +0100
> Nuno Sá <noname.nuno@gmail.com> wrote:
> 
> > On Thu, 2023-12-14 at 11:03 -0600, Rob Herring wrote:
> > > On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno Sá wrote:  
> > > > On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:  
> > > > > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:  
> > > > > > v1:
> > > > > >  
> > > > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f517
> > > > > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > > > > 
> > > > > > v2:
> > > > > >  
> > > > > > https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.co
> > > > > > m
> > > > > > 
> > > > > > Changes in v3:
> > > > > > - Patch 1:
> > > > > >  * Use proposed generic schema [1]. Also make it a required property;
> > > > > >  * Improved the commit message.
> > > > > > - Patch 2:
> > > > > >  * Improved commit message.
> > > > > > - Patch 4:
> > > > > >  * Namespace all IIO DMAENGINE buffer exports;
> > > > > >  * Removed unrelated new line removal change.
> > > > > > - Patch 5:
> > > > > >  * Namespace all IIO backend exports.
> > > > > > - Patch 6:
> > > > > >  * Set backend.h in alphabetical order;
> > > > > >  * Import IIO backend namespace.
> > > > > > - Patch 7:
> > > > > >  * Don't depend on OF in kbuild anymore;
> > > > > >  * Import IIO backend namespace.
> > > > > > 
> > > > > > For the bindings patches, I tried not to enter into much details about
> > > > > > the IIO framework as I think specifics of the implementation don't care
> > > > > > from the bindings perspective. Hopefully the commit messages are good
> > > > > > enough.
> > > > > > 
> > > > > > I'm also aware that patch 1 is not backward compatible but we are
> > > > > > anyways doing it on the driver side (and on the driver the property is
> > > > > > indeed required). Anyways, just let me know if making the property
> > > > > > required is not acceptable (I'm fairly confident no one was using the
> > > > > > upstream version of the driver and so validating devicetrees for it). 
> > > > > > 
> > > > > > Keeping the block diagram in v3's cover so we don't have to follow links
> > > > > > to check the one of the typicals setups. 
> > > > > > 
> > > > > >                                            ----------------------------------
> > > > > > ----
> > > > > > -----------------
> > > > > >  ------------------                        | -----------         ------------
> > > > > >       -------  FPGA |
> > > > > >  |     ADC        |------------------------| | AXI ADC |---------| DMA CORE
> > > > > > |----
> > > > > > --| RAM |       |
> > > > > >  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|         
> > > > > > |----
> > > > > > --|     |       |
> > > > > >  |                |------------------------| -----------         ------------
> > > > > >       -------       |
> > > > > >  ------------------                        ----------------------------------
> > > > > > ----
> > > > > > -----------------  
> > > > > 
> > > > > Why doesn't axi-adc just have an io-channels property to adc? It's the 
> > > > > opposite direction for the link, but it seems more logical to me that 
> > > > > axi-adc depends on adc rather than the other way around.
> > > > >   
> > > > 
> > > > We are not interested on a single channel but on the complete device. >From the
> > > > axi-
> > > > adc point of view, there's not much we could do with the adc channel. I mean,
> > > > maybe
> > > > we could still do something but it would be far from ideal (see below).  
> > > 
> > > Will this hold up for everyone? Could there be a backend device that 
> > > handles multiple ADCs? IOW, do you need #io-backend-cells? It's somewhat 
> > > better if we add that up front rather than later and have to treat 
> > > missing as 0 cells. It is also the only way to generically identify the 
> > > providers (well, there's also 'foo-controller' properties, but we've 
> > > gone away from those).
> > >   
> > 
> > For the axi-adc backend, it's very unlikely. The way the core connects to the
> > converters is through a serial data interface (LVDS, CMOS or JESD in ADI usecases).
> > This interface is not really a bus so it's kind of a 1:1 connection. Now, in more
> > complicated devices (like highly integrated RF transceivers) what we have is that we
> > have multiple of these cores (one per RX/TX port) connected to the frontend. So,
> > effectively 1 frontend could have multiple backends. So, yes, your first "doubts" are
> > not that "crazy" as this is also not the "typical" provider - consumer relationship.
> > However, for all of what I've said in the previous email, even in these cases,
> > thinking in these cores as the provider, makes things much more easier to handle.
> > 
> > However, the above is just ADI usecases. In theory, yes, it can be very possible for
> > another backend other than axi-adc to have multiple frontends connected so I guess we
> > can make #io-backend-cells already available in the schema.
> 
> I'd like ultimately to consider making this work for new instances of
> dfsdm devices (separately front end ADC that spits out a modulated signal that a host
> controller then turns into something useful). In those cases we might well see a mix
> of front ends connected to one backend (at least in theory - not sure anyone would
> build such thing outside of an eval board).
> 
> Adding the flexibility from the start would be sensible. So I agree with Rob here.
> 
> > 
> > For the axi-adc bindings this would be 'const: 0', right?
> > 
> > >   
> > > > The opposite direction is exactly what we had (look at patch 2) just with another
> > > > custom property. The problem with that is that we would then need a bidirectional
> > > > link (we would need to callback into the provider and the provider would need to
> > > > access the consumer) between consumers and providers and that would be far from
> > > > optimal. The bidirectional link would exist because if we want to support
> > > > fundamental
> > > > things like LVDS/CMOS interface tuning we need to set/get settings from the axi-
> > > > adc
> > > > core. And as Jonathan suggested, the real data is captured or sent on the
> > > > converters
> > > > (ADC or DACs) and that is why we have the IIO device/interface in there and why
> > > > we
> > > > call them "frontends". In ADI usecases, backends are these FPGA cores providing
> > > > "services" to the "real" high speed converters. To put it in another way, the
> > > > real
> > > > converter is the one who knows how to use the axi-adc core and not the other way
> > > > around. That's also one of the reasons why it would be way more difficult to
> > > > handle
> > > > things with the opposite link. That's how we have done it so far and the mess we
> > > > have
> > > > out of tree is massive :sweat_smile: We ended up doing raw writes and reads on
> > > > the
> > > > axi-adc MMIO registers from the converter driver just because we had to configure
> > > > or
> > > > get something from the axi-adc device but the link was backwards.  
> > > 
> > > The direction (for the binding) doesn't really matter. It doesn't 
> > > dictate the direction in the OS. In the ad9467 driver, you can search 
> > > the DT for 'adi,adc-dev' and find the node which matches your node's 
> > > phandle. It's not exactly efficient, but you are doing it once. It would 
> > > also prevent the DT ABI break you are introducing.
> > >   
> > 
> > Hmm, I think I see your idea. So you mean something like
> > devm_iio_backend_get_optional() and if not present, then we would look for nodes
> > having the 'adi,adc-dev' property and look for the one pointing at us... Then, we
> > would need another API in the backend to look for registered backends matching that
> > fwnode. Right?
> > 
> > I mean, I guess this could work but we would already have to start a fresh framework
> > with API's that are not really meant to be used anymore other than the ad9467 driver
> > (not devm_iio_backend_get_optional() because sooner or later I think we'll need that
> > one). We are already breaking ABI in the driver and I'm still fairly confident no one
> > is really using the upstream driver because it's lacking support for devices and
> > important features (not even in ADI fork we're using it).
> > 
> > Anyways, if you still insist on having something like this (and feel more comfortable
> > in not breaking DT ABI), I can see how this would look like in the next version...
> 
> See how it looks. If it means removing the need to convince Rob then it's probably easier
> to write the code than try and talk him around ;)  Can happily stick a bit deprecated
> note next to the binding and the code.

I only point out ABI breaks and require they are justified in the commit 
message (basically stating what you state above). Otherwise, I don't 
care if I don't use the platform.

> > > > > And if there's another consumer in the chain, then a node could 
> > > > > certainly be both an io-channels consumer and producer.
> > > > >   
> > > > 
> > > > This should also be possible with this architecture. A node can be both a backend
> > > > (provider) and a consumer and we have an out of tree design that fits this (that
> > > > I
> > > > surely want to upstream after the foundations are done).
> > > >   
> > > > > The architecture of the drivers seems odd to me. It looks similar to 
> > > > > making a phy driver handle all the state and protocol with the host 
> > > > > controller being a backend.  
> > > > 
> > > > In this case, it's not really a controller. It's more like an extension of the
> > > > device
> > > > because we need a way to handle the high sample rates this ADCs can do. Then we
> > > > can
> > > > also do test tones with the backend which is useful for interface tuning (as
> > > > mentioned above).
> > > > 
> > > > To give you a bit more context, I'm adding the generic property because we will
> > > > have
> > > > more users for it (from ADI - the next should be the axi-dac core) but STM is
> > > > also
> > > > interested in this (likely the next user).
> > > > 
> > > > Hope this makes it a bit more clear...  
> > > 
> > > Yes, thanks.
> > > 
> > > I generally ask for 2 users on new common bindings. I've accepted too 
> > > many only to have the 2nd user come in a month later and need additions. 
> > > An ack on the binding from the STM folks would be nice here. And 
> > > Jonathan too.
> > >   
> > 
> > Olivier, could we get an ack on the bindings patch? Do you also have any idea about
> > how long it would take for you to send patches so we have another user of the schema?
> > 
> > On my side, it might very well take a month or so (given we have holidays nearby) as
> > the axi-dac core is more complex than the axi-adc. Bah it might take less than a
> > month to have the first version of it posted in the lists but I can't make any
> > promises.
> 
> For the driver side of things I'd like at least 2, preferably 3 users before merging.
> We have more flexibility to rework things as any issues will probably be internal
> interfaces, but I'd rather wait if we are going to have 3 users within another month
> or 2.

Really, for the binding, I'm fine with participation in the upstreaming 
of this (i.e. reviewing and/or testing on another platform) and a 'this 
works for us' on the binding.

Rob

