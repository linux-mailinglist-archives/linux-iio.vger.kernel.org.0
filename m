Return-Path: <linux-iio+bounces-952-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79D53814B99
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 16:19:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75931F24C68
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 15:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD909364CD;
	Fri, 15 Dec 2023 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKwcK5jQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B2C36AE0;
	Fri, 15 Dec 2023 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3364c9ba749so596220f8f.1;
        Fri, 15 Dec 2023 07:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702653521; x=1703258321; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bReu3nchqS3FQW3gT7j6BqGRoQfnrrmXS8aRtC2FXlI=;
        b=hKwcK5jQNUfQQszR4BxpaspUJpamyHYH811TxQdhwFRc6fOIq4WM6nOqZL2O+NE11W
         K/ohL8So8kW1i4yhsxTLoNERL3roWNEDgjLzRt5OBPrJPOpPA5bseOd2qlQ95IwuXaW4
         8AttFuE8jhm1NVZYM/jJ8BYOcQbKrp++NpXyx2VsxLq5qlXQWoZg0H7Yf+ArWU5OnIlH
         WwIK24xX4Zg1R2n3Zfvt+sL5K++ZJmJSTS9vPRyTXtgajnvW241d8EkBJdXSWNq4tLH3
         vx1Mlv2CdjGe/P9XmPS14tepuxXtEPBOChzis0fmPX6+d+ouBzBL3wwHwAWyH6+yKwsF
         Jhtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702653521; x=1703258321;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bReu3nchqS3FQW3gT7j6BqGRoQfnrrmXS8aRtC2FXlI=;
        b=P+y7/3vEbbLQtccTBsKajdVxlPk+kYtxM4ht1HGPUA+Kkwt9urBRQUdi5dImnXa8J5
         eIj435a6uULkenycuNSVnfvhkwSaeSqB8lrePirTXuSG0rLEWQBlsShlx5Vi2L7vGoDS
         aL5a2vqfBNNdbRHR4vhtIg4a5mJFIjflw0lf5JnGEJ3ikr2mPXP5W21KgqYIbY6sL9Hw
         OJfpHeWjHcqhgkaJEsqNpOO10hlKzMwMrLT+vV4reMNNBNKIui6l1JKyMZzzpjV/Llek
         H9zCQwBbtXJsGmW1icRXXrPBTVapLyJ6FoiDWghMdZ9VD3TlfltzwWDi2nn/PdfjTR3C
         LiJA==
X-Gm-Message-State: AOJu0YxWSeoEELFFBY/8+xM+7971r4Zmh9xj7TtngZ5cnDh4c6z7pXkr
	nrvxGGcSMeyQ18ci4qf8Kmg=
X-Google-Smtp-Source: AGHT+IHfkMcW8fkoZcFB/3ZkF/qHct/G/9F/JDk/25vOHO7RsAbLhV5pYsizG6gOr5vUF5soqAI6eA==
X-Received: by 2002:a05:600c:138b:b0:40c:4ece:a2ea with SMTP id u11-20020a05600c138b00b0040c4ecea2eamr1936654wmf.102.1702653520165;
        Fri, 15 Dec 2023 07:18:40 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id m14-20020a05600c4f4e00b0040b30be6244sm29441692wmq.24.2023.12.15.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:18:39 -0800 (PST)
Message-ID: <dfe28945b33ddfd1258586b825e5eb3866ee28d8.camel@gmail.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, devicetree@vger.kernel.org, 
 linux-iio@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Fri, 15 Dec 2023 16:18:39 +0100
In-Reply-To: <20231214170326.GA458046-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231214141600.GA224419-robh@kernel.org>
	 <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
	 <20231214170326.GA458046-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 11:03 -0600, Rob Herring wrote:
> On Thu, Dec 14, 2023 at 05:05:20PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:
> > > On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:
> > > > v1:
> > > > =C2=A0
> > > > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-hua=
wei/T/#m222f517
> > > > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> > > >=20
> > > > v2:
> > > > =C2=A0
> > > > https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-5450951895e=
1@analog.co
> > > > m
> > > >=20
> > > > Changes in v3:
> > > > - Patch 1:
> > > > =C2=A0* Use proposed generic schema [1]. Also make it a required pr=
operty;
> > > > =C2=A0* Improved the commit message.
> > > > - Patch 2:
> > > > =C2=A0* Improved commit message.
> > > > - Patch 4:
> > > > =C2=A0* Namespace all IIO DMAENGINE buffer exports;
> > > > =C2=A0* Removed unrelated new line removal change.
> > > > - Patch 5:
> > > > =C2=A0* Namespace all IIO backend exports.
> > > > - Patch 6:
> > > > =C2=A0* Set backend.h in alphabetical order;
> > > > =C2=A0* Import IIO backend namespace.
> > > > - Patch 7:
> > > > =C2=A0* Don't depend on OF in kbuild anymore;
> > > > =C2=A0* Import IIO backend namespace.
> > > >=20
> > > > For the bindings patches, I tried not to enter into much details ab=
out
> > > > the IIO framework as I think specifics of the implementation don't =
care
> > > > from the bindings perspective. Hopefully the commit messages are go=
od
> > > > enough.
> > > >=20
> > > > I'm also aware that patch 1 is not backward compatible but we are
> > > > anyways doing it on the driver side (and on the driver the property=
 is
> > > > indeed required). Anyways, just let me know if making the property
> > > > required is not acceptable (I'm fairly confident no one was using t=
he
> > > > upstream version of the driver and so validating devicetrees for it=
).=20
> > > >=20
> > > > Keeping the block diagram in v3's cover so we don't have to follow =
links
> > > > to check the one of the typicals setups.=20
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----------------------------------
> > > > ----
> > > > -----------------
> > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 | -----------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ------------
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0 FPGA |
> > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |------------------------| | AXI ADC |---------| DMA CORE
> > > > |----
> > > > --| RAM |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > =C2=A0| (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|------=
---|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > |----
> > > > --|=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > > > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |------------------------| -----------=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------------
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |
> > > > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ----------------------------------
> > > > ----
> > > > -----------------
> > >=20
> > > Why doesn't axi-adc just have an io-channels property to adc? It's th=
e=20
> > > opposite direction for the link, but it seems more logical to me that=
=20
> > > axi-adc depends on adc rather than the other way around.
> > >=20
> >=20
> > We are not interested on a single channel but on the complete device.=
=C2=A0>From the
> > axi-
> > adc point of view, there's not much we could do with the adc channel. I=
 mean,
> > maybe
> > we could still do something but it would be far from ideal (see below).
>=20
> Will this hold up for everyone? Could there be a backend device that=20
> handles multiple ADCs? IOW, do you need #io-backend-cells? It's somewhat=
=20
> better if we add that up front rather than later and have to treat=20
> missing as 0 cells. It is also the only way to generically identify the=
=20
> providers (well, there's also 'foo-controller' properties, but we've=20
> gone away from those).
>=20

For the axi-adc backend, it's very unlikely. The way the core connects to t=
he
converters is through a serial data interface (LVDS, CMOS or JESD in ADI us=
ecases).
This interface is not really a bus so it's kind of a 1:1 connection. Now, i=
n more
complicated devices (like highly integrated RF transceivers) what we have i=
s that we
have multiple of these cores (one per RX/TX port) connected to the frontend=
. So,
effectively 1 frontend could have multiple backends. So, yes, your first "d=
oubts" are
not that "crazy" as this is also not the "typical" provider - consumer rela=
tionship.
However, for all of what I've said in the previous email, even in these cas=
es,
thinking in these cores as the provider, makes things much more easier to h=
andle.

However, the above is just ADI usecases. In theory, yes, it can be very pos=
sible for
another backend other than axi-adc to have multiple frontends connected so =
I guess we
can make #io-backend-cells already available in the schema.

For the axi-adc bindings this would be 'const: 0', right?

>=20
> > The opposite direction is exactly what we had (look at patch 2) just wi=
th another
> > custom property. The problem with that is that we would then need a bid=
irectional
> > link (we would need to callback into the provider and the provider woul=
d need to
> > access the consumer) between consumers and providers and that would be =
far from
> > optimal. The bidirectional link would exist because if we want to suppo=
rt
> > fundamental
> > things like LVDS/CMOS interface tuning we need to set/get settings from=
 the axi-
> > adc
> > core. And as Jonathan suggested, the real data is captured or sent on t=
he
> > converters
> > (ADC or DACs) and that is why we have the IIO device/interface in there=
 and why
> > we
> > call them "frontends". In ADI usecases, backends are these FPGA cores p=
roviding
> > "services" to the "real" high speed converters. To put it in another wa=
y, the
> > real
> > converter is the one who knows how to use the axi-adc core and not the =
other way
> > around. That's also one of the reasons why it would be way more difficu=
lt to
> > handle
> > things with the opposite link. That's how we have done it so far and th=
e mess we
> > have
> > out of tree is massive :sweat_smile: We ended up doing raw writes and r=
eads on
> > the
> > axi-adc MMIO registers from the converter driver just because we had to=
 configure
> > or
> > get something from the axi-adc device but the link was backwards.
>=20
> The direction (for the binding) doesn't really matter. It doesn't=20
> dictate the direction in the OS. In the ad9467 driver, you can search=20
> the DT for 'adi,adc-dev' and find the node which matches your node's=20
> phandle. It's not exactly efficient, but you are doing it once. It would=
=20
> also prevent the DT ABI break you are introducing.
>=20

Hmm, I think I see your idea. So you mean something like
devm_iio_backend_get_optional() and if not present, then we would look for =
nodes
having the 'adi,adc-dev' property and look for the one pointing at us... Th=
en, we
would need another API in the backend to look for registered backends match=
ing that
fwnode. Right?

I mean, I guess this could work but we would already have to start a fresh =
framework
with API's that are not really meant to be used anymore other than the ad94=
67 driver
(not devm_iio_backend_get_optional() because sooner or later I think we'll =
need that
one). We are already breaking ABI in the driver and I'm still fairly confid=
ent no one
is really using the upstream driver because it's lacking support for device=
s and
important features (not even in ADI fork we're using it).

Anyways, if you still insist on having something like this (and feel more c=
omfortable
in not breaking DT ABI), I can see how this would look like in the next ver=
sion...

>=20
> > > And if there's another consumer in the chain, then a node could=20
> > > certainly be both an io-channels consumer and producer.
> > >=20
> >=20
> > This should also be possible with this architecture. A node can be both=
 a backend
> > (provider) and a consumer and we have an out of tree design that fits t=
his (that
> > I
> > surely want to upstream after the foundations are done).
> >=20
> > > The architecture of the drivers seems odd to me. It looks similar to=
=20
> > > making a phy driver handle all the state and protocol with the host=
=20
> > > controller being a backend.
> >=20
> > In this case, it's not really a controller. It's more like an extension=
 of the
> > device
> > because we need a way to handle the high sample rates this ADCs can do.=
 Then we
> > can
> > also do test tones with the backend which is useful for interface tunin=
g (as
> > mentioned above).
> >=20
> > To give you a bit more context,=C2=A0I'm adding the generic property be=
cause we will
> > have
> > more users for it (from ADI - the next should be the axi-dac core) but =
STM is
> > also
> > interested in this (likely the next user).
> >=20
> > Hope this makes it a bit more clear...
>=20
> Yes, thanks.
>=20
> I generally ask for 2 users on new common bindings. I've accepted too=20
> many only to have the 2nd user come in a month later and need additions.=
=20
> An ack on the binding from the STM folks would be nice here. And=20
> Jonathan too.
>=20

Olivier, could we get an ack on the bindings patch? Do you also have any id=
ea about
how long it would take for you to send patches so we have another user of t=
he schema?

On my side, it might very well take a month or so (given we have holidays n=
earby) as
the axi-dac core is more complex than the axi-adc. Bah it might take less t=
han a
month to have the first version of it posted in the lists but I can't make =
any
promises.

- Nuno S=C3=A1


