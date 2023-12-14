Return-Path: <linux-iio+bounces-930-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0323881372B
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 18:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6651F21749
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 17:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575863DCA;
	Thu, 14 Dec 2023 17:03:34 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAB28E;
	Thu, 14 Dec 2023 09:03:30 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-58d956c8c38so5325506eaf.2;
        Thu, 14 Dec 2023 09:03:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702573410; x=1703178210;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/qvXC0V/IaX6oFDIV8ZjMo7+59JzsGITQfrsI4ipBT4=;
        b=aSIvsk2IawON7Yg0CI0leq1CTg0WPfhJED8i+PwbHhYK/MLQM/RUzQ+x9igppFlxVn
         33xlrkPPjQLfLTW7eMC6TWUSAwsI40Y1pIp0TmKu1VTqyWEavkSiYCnzl2VBIgZjQhuy
         gQNrKBjmLfI39gy41BjIFyVwzLHpfj7Bljp3AptXgc5fsa2tHkc2Rty453a159a2X3Go
         DRekgEvNBusTZBNrZODPHelfIKsBFIaVLq8qmv0ggDeWt9BUsAMcF0eKqYywDVEJSU4y
         ZTX5nfyde/HgO4Tk8rjiLfsa87UeY804mX08yxjZzPeUFnWWTQP+lGKuwHreks2LmskC
         EZ4A==
X-Gm-Message-State: AOJu0Yyqr9r+CEswy8yvlHwldWYewWsoajYs9ea1fBlR11Y4esSLw27X
	b2HwsxcFXUGn7YD0gB4DxA==
X-Google-Smtp-Source: AGHT+IEyHe0f0QD/eSgA+PZeFlz1x8D95y9PVo65kNNLu2rCkX9vB67IjW8PLveDqnfwYJJpbmBdrA==
X-Received: by 2002:a05:6820:16a2:b0:58d:981e:bc5c with SMTP id bc34-20020a05682016a200b0058d981ebc5cmr7655733oob.7.1702573409724;
        Thu, 14 Dec 2023 09:03:29 -0800 (PST)
Received: from herring.priv ([2607:fb91:e6c7:a40:1c2d:b875:912d:c28])
        by smtp.gmail.com with ESMTPSA id i29-20020a4a929d000000b0058a3c5d590bsm3567221ooh.7.2023.12.14.09.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:03:29 -0800 (PST)
Received: (nullmailer pid 492444 invoked by uid 1000);
	Thu, 14 Dec 2023 17:03:26 -0000
Date: Thu, 14 Dec 2023 11:03:26 -0600
From: Rob Herring <robh@kernel.org>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
Message-ID: <20231214170326.GA458046-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
 <20231214141600.GA224419-robh@kernel.org>
 <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>

On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno Sá wrote:
> On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:
> > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:
> > > v1:
> > >  
> > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/T/#m222f517
> > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > 
> > > v2:
> > >  https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e1@analog.com
> > > 
> > > Changes in v3:
> > > - Patch 1:
> > >  * Use proposed generic schema [1]. Also make it a required property;
> > >  * Improved the commit message.
> > > - Patch 2:
> > >  * Improved commit message.
> > > - Patch 4:
> > >  * Namespace all IIO DMAENGINE buffer exports;
> > >  * Removed unrelated new line removal change.
> > > - Patch 5:
> > >  * Namespace all IIO backend exports.
> > > - Patch 6:
> > >  * Set backend.h in alphabetical order;
> > >  * Import IIO backend namespace.
> > > - Patch 7:
> > >  * Don't depend on OF in kbuild anymore;
> > >  * Import IIO backend namespace.
> > > 
> > > For the bindings patches, I tried not to enter into much details about
> > > the IIO framework as I think specifics of the implementation don't care
> > > from the bindings perspective. Hopefully the commit messages are good
> > > enough.
> > > 
> > > I'm also aware that patch 1 is not backward compatible but we are
> > > anyways doing it on the driver side (and on the driver the property is
> > > indeed required). Anyways, just let me know if making the property
> > > required is not acceptable (I'm fairly confident no one was using the
> > > upstream version of the driver and so validating devicetrees for it). 
> > > 
> > > Keeping the block diagram in v3's cover so we don't have to follow links
> > > to check the one of the typicals setups. 
> > > 
> > >                                            --------------------------------------
> > > -----------------
> > >  ------------------                        | -----------         ------------
> > >       -------  FPGA |
> > >  |     ADC        |------------------------| | AXI ADC |---------| DMA CORE |----
> > > --| RAM |       |
> > >  | (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|          |----
> > > --|     |       |
> > >  |                |------------------------| -----------         ------------
> > >       -------       |
> > >  ------------------                        --------------------------------------
> > > -----------------
> > 
> > Why doesn't axi-adc just have an io-channels property to adc? It's the 
> > opposite direction for the link, but it seems more logical to me that 
> > axi-adc depends on adc rather than the other way around.
> > 
> 
> We are not interested on a single channel but on the complete device. >From the axi-
> adc point of view, there's not much we could do with the adc channel. I mean, maybe
> we could still do something but it would be far from ideal (see below).

Will this hold up for everyone? Could there be a backend device that 
handles multiple ADCs? IOW, do you need #io-backend-cells? It's somewhat 
better if we add that up front rather than later and have to treat 
missing as 0 cells. It is also the only way to generically identify the 
providers (well, there's also 'foo-controller' properties, but we've 
gone away from those).


> The opposite direction is exactly what we had (look at patch 2) just with another
> custom property. The problem with that is that we would then need a bidirectional
> link (we would need to callback into the provider and the provider would need to
> access the consumer) between consumers and providers and that would be far from
> optimal. The bidirectional link would exist because if we want to support fundamental
> things like LVDS/CMOS interface tuning we need to set/get settings from the axi-adc
> core. And as Jonathan suggested, the real data is captured or sent on the converters
> (ADC or DACs) and that is why we have the IIO device/interface in there and why we
> call them "frontends". In ADI usecases, backends are these FPGA cores providing
> "services" to the "real" high speed converters. To put it in another way, the real
> converter is the one who knows how to use the axi-adc core and not the other way
> around. That's also one of the reasons why it would be way more difficult to handle
> things with the opposite link. That's how we have done it so far and the mess we have
> out of tree is massive :sweat_smile: We ended up doing raw writes and reads on the
> axi-adc MMIO registers from the converter driver just because we had to configure or
> get something from the axi-adc device but the link was backwards.

The direction (for the binding) doesn't really matter. It doesn't 
dictate the direction in the OS. In the ad9467 driver, you can search 
the DT for 'adi,adc-dev' and find the node which matches your node's 
phandle. It's not exactly efficient, but you are doing it once. It would 
also prevent the DT ABI break you are introducing.


> > And if there's another consumer in the chain, then a node could 
> > certainly be both an io-channels consumer and producer.
> > 
> 
> This should also be possible with this architecture. A node can be both a backend
> (provider) and a consumer and we have an out of tree design that fits this (that I
> surely want to upstream after the foundations are done).
> 
> > The architecture of the drivers seems odd to me. It looks similar to 
> > making a phy driver handle all the state and protocol with the host 
> > controller being a backend.
> 
> In this case, it's not really a controller. It's more like an extension of the device
> because we need a way to handle the high sample rates this ADCs can do. Then we can
> also do test tones with the backend which is useful for interface tuning (as
> mentioned above).
> 
> To give you a bit more context, I'm adding the generic property because we will have
> more users for it (from ADI - the next should be the axi-dac core) but STM is also
> interested in this (likely the next user).
> 
> Hope this makes it a bit more clear...

Yes, thanks.

I generally ask for 2 users on new common bindings. I've accepted too 
many only to have the 2nd user come in a month later and need additions. 
An ack on the binding from the STM folks would be nice here. And 
Jonathan too.

Rob

