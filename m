Return-Path: <linux-iio+bounces-927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4398135A7
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 17:05:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64CD0282AFE
	for <lists+linux-iio@lfdr.de>; Thu, 14 Dec 2023 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46E5EE86;
	Thu, 14 Dec 2023 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LmORkqBk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B45115;
	Thu, 14 Dec 2023 08:05:24 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so957984366b.1;
        Thu, 14 Dec 2023 08:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702569922; x=1703174722; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mDx4djFt+HB6slDlKvu83QV+9rQVdjRvEW1nepVJpG4=;
        b=LmORkqBkn+MpbUOEMLBsNbav9MlA7i3r7gV7Ctl/ldBC44Zov5vQqxUS68/isuFKFh
         bWNtgvS95PBgdYJDOxOSfGL1w0QEzOThxEg7oCCWaxWmW7/2Pq65zAAJcVslRdbvNfR2
         BZFKhnFiVXaY/Ev5t+lN9HpXL3dQkE5OJE9RT3S9mx4lDwS+r3kIDMa1z3QJ6k4BBwXV
         BIop6gl3L7pnJeZUQrJfm5MQ9vsWy6YqDJBOd/xHKfGVXDWruhmKUtmUJ8DHt6h/e9HM
         ZHkpRbpMIJ7OVtwoUpqsPxpI2z/SvQeT4p9J2rick5ZBguVL01SyQ3rxtmws4sFT09Ta
         HZmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702569922; x=1703174722;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mDx4djFt+HB6slDlKvu83QV+9rQVdjRvEW1nepVJpG4=;
        b=eRiFZRwsBa1pGy/tiFBXHtfnEGvEyqTfIJtrmpurqdyrGslGZrzz3gPRywo4YPtLh2
         5+iZh8gdOxJ2oHjkf6GO1bTo6SlGdrFdlyQwW9d/pRiSbnAPfqIazQ+Nw+sTQTyMEct8
         Bx+LqcfY38RpfDQ+97FGm/pTG6OnE3TN54pEema1MLi9HnetuRDICTHl3jed7eUunSe9
         XLMUD2jeaMrORgcZm5wr6sSCq7K5gkxnzgZm94c+EE7LGZpwoDw1P3Dc9yi0qM6DEHlO
         Q1k8/hA+53PnH6q5omBuhkRxa1NkUKgE/DFqYZYtVT4b3GyvySbPZFYDUh0VsUxV+mKZ
         Ke+Q==
X-Gm-Message-State: AOJu0YwWtYYtcIWkbiyNUjALnGVhsXEreq1SHKAW3Ru9zX4TbnRpcwkG
	Z+axzXqC2vEjHFh0vkJMSEk=
X-Google-Smtp-Source: AGHT+IH5gI+oZL2kgO47xwqIJvEtLv5TWNloc6ImBroBZYq58/dCChJrQ2D3ugsTXErddm+T9OuMWg==
X-Received: by 2002:a17:906:51c2:b0:a23:45c:5ca with SMTP id v2-20020a17090651c200b00a23045c05camr1240238ejk.0.1702569922083;
        Thu, 14 Dec 2023 08:05:22 -0800 (PST)
Received: from ?IPv6:2001:a61:3456:4e01:6ae:b55a:bd1d:57fc? ([2001:a61:3456:4e01:6ae:b55a:bd1d:57fc])
        by smtp.gmail.com with ESMTPSA id wb8-20020a170907d50800b00a1cb351dd4fsm9599480ejc.9.2023.12.14.08.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 08:05:21 -0800 (PST)
Message-ID: <fa03e4138fe2c8c7e7f619e11f149701c39445e4.camel@gmail.com>
Subject: Re: [PATCH v3 0/8] iio: add new backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Date: Thu, 14 Dec 2023 17:05:20 +0100
In-Reply-To: <20231214141600.GA224419-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231214141600.GA224419-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 08:16 -0600, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 04:02:31PM +0100, Nuno Sa wrote:
> > v1:
> > =C2=A0
> > https://lore.kernel.org/linux-iio/20231204144925.4fe9922f@jic23-huawei/=
T/#m222f517
> > 5273b81dbfe40b7f0daffcdc67d6cb8ff
> >=20
> > v2:
> > =C2=A0https://lore.kernel.org/r/20231208-dev-iio-backend-v2-0-545095189=
5e1@analog.com
> >=20
> > Changes in v3:
> > - Patch 1:
> > =C2=A0* Use proposed generic schema [1]. Also make it a required proper=
ty;
> > =C2=A0* Improved the commit message.
> > - Patch 2:
> > =C2=A0* Improved commit message.
> > - Patch 4:
> > =C2=A0* Namespace all IIO DMAENGINE buffer exports;
> > =C2=A0* Removed unrelated new line removal change.
> > - Patch 5:
> > =C2=A0* Namespace all IIO backend exports.
> > - Patch 6:
> > =C2=A0* Set backend.h in alphabetical order;
> > =C2=A0* Import IIO backend namespace.
> > - Patch 7:
> > =C2=A0* Don't depend on OF in kbuild anymore;
> > =C2=A0* Import IIO backend namespace.
> >=20
> > For the bindings patches, I tried not to enter into much details about
> > the IIO framework as I think specifics of the implementation don't care
> > from the bindings perspective. Hopefully the commit messages are good
> > enough.
> >=20
> > I'm also aware that patch 1 is not backward compatible but we are
> > anyways doing it on the driver side (and on the driver the property is
> > indeed required). Anyways, just let me know if making the property
> > required is not acceptable (I'm fairly confident no one was using the
> > upstream version of the driver and so validating devicetrees for it).=
=20
> >=20
> > Keeping the block diagram in v3's cover so we don't have to follow link=
s
> > to check the one of the typicals setups.=20
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --------------------------------------
> > -----------------
> > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | -----------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 ------------
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0 FPGA |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0 ADC=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |------------------------| | AXI ADC |---------| DMA CORE |----
> > --| RAM |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0| (Frontend/IIO) | Serial Data (eg: LVDS) | |(backend)|---------|=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |----
> > --|=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |------------------------| -----------=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ------------
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> > =C2=A0------------------=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 --------------------------------------
> > -----------------
>=20
> Why doesn't axi-adc just have an io-channels property to adc? It's the=
=20
> opposite direction for the link, but it seems more logical to me that=20
> axi-adc depends on adc rather than the other way around.
>=20

We are not interested on a single channel but on the complete device.=C2=A0=
From the axi-
adc point of view, there's not much we could do with the adc channel. I mea=
n, maybe
we could still do something but it would be far from ideal (see below).

The opposite direction is exactly what we had (look at patch 2) just with a=
nother
custom property. The problem with that is that we would then need a bidirec=
tional
link (we would need to callback into the provider and the provider would ne=
ed to
access the consumer) between consumers and providers and that would be far =
from
optimal. The bidirectional link would exist because if we want to support f=
undamental
things like LVDS/CMOS interface tuning we need to set/get settings from the=
 axi-adc
core. And as Jonathan suggested, the real data is captured or sent on the c=
onverters
(ADC or DACs) and that is why we have the IIO device/interface in there and=
 why we
call them "frontends". In ADI usecases, backends are these FPGA cores provi=
ding
"services" to the "real" high speed converters. To put it in another way, t=
he real
converter is the one who knows how to use the axi-adc core and not the othe=
r way
around. That's also one of the reasons why it would be way more difficult t=
o handle
things with the opposite link. That's how we have done it so far and the me=
ss we have
out of tree is massive :sweat_smile: We ended up doing raw writes and reads=
 on the
axi-adc MMIO registers from the converter driver just because we had to con=
figure or
get something from the axi-adc device but the link was backwards.

> And if there's another consumer in the chain, then a node could=20
> certainly be both an io-channels consumer and producer.
>=20

This should also be possible with this architecture. A node can be both a b=
ackend
(provider) and a consumer and we have an out of tree design that fits this =
(that I
surely want to upstream after the foundations are done).

> The architecture of the drivers seems odd to me. It looks similar to=20
> making a phy driver handle all the state and protocol with the host=20
> controller being a backend.

In this case, it's not really a controller. It's more like an extension of =
the device
because we need a way to handle the high sample rates this ADCs can do. The=
n we can
also do test tones with the backend which is useful for interface tuning (a=
s
mentioned above).

To give you a bit more context,=C2=A0I'm adding the generic property becaus=
e we will have
more users for it (from ADI - the next should be the axi-dac core) but STM =
is also
interested in this (likely the next user).

Hope this makes it a bit more clear...

- Nuno S=C3=A1


