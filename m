Return-Path: <linux-iio+bounces-1509-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 731898285D3
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 13:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F8941C23F52
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jan 2024 12:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028A4381A4;
	Tue,  9 Jan 2024 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="at+1jlfn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C49374EB;
	Tue,  9 Jan 2024 12:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40d5336986cso37503945e9.1;
        Tue, 09 Jan 2024 04:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704802364; x=1705407164; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mMNZ6U9xhJphlHp5v2s5DXa2OoB2Q29EJqenq/hWQRk=;
        b=at+1jlfnUTU0sXh+Mv5cprc4OPCKWJw4TLQjtpbmbjs3evjv7vgq+RXA426LVBKXr1
         vvvWukhOLMuwE8xNGHqq39xb0fjvKvzSpShMEuUIXbfClbmnv8r8QrcoOQkFLAbffQ5i
         UBYyLcB9ls8kPLxC1foFimKP1tASvOBEAhQrizXQrprd2iTwORd992QM5yp1fQHIhI3A
         SytAgooOBV9ETAlXLuQ0ih/afj63Z2/evyysoa84w7wEtqRehcOofmpwhGrW96p/pLkH
         IdPhcKClokGUBLieFD4J8zF7YC/0AiqAgQWSfBBgvWzkPE2ggJ+x89U0mhRauVnhlmDl
         Fbcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704802364; x=1705407164;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mMNZ6U9xhJphlHp5v2s5DXa2OoB2Q29EJqenq/hWQRk=;
        b=RlEuI49aXNVcZ+Upw2Z331LvxB5eTy4t9n7lyqM1+RE7pItNlRhoElcngwbA4t6X1/
         /NaS+wtJ7S5xE+zyeJxBIyD9LAi+a3b167OVWIO1wL9SICLKfbw3bUqFagWXLOJcgFa4
         HRyOXCMA0rgqnoe19BsUUEtpTaOje1UgCd4szIMn0rwv5xEEHCY+4lTvua3eVoTy+JAf
         pbgv05BECmyKpT2/RQJqArXUSScZgU8rpai4PLVYhV2Uru5abZKM+qtR1mbaejwjhtzQ
         KADyja2RcC5pkHXsKqGe1UAtJHMVr/naE+kw+015FKo2x6dvzOYpTw1y5PqOujzdJzOn
         q6eg==
X-Gm-Message-State: AOJu0YwWGhQ7ow9B+W+GW1EexbNCdc0H2ZgwUQF7LjtGfiJ6gc6p8BIe
	mwgkofNdvKMbLx/Qzjwd64LJbHTJZFldNXVB
X-Google-Smtp-Source: AGHT+IFNUgb7ymra4xAKV2EikmvM207VJPkqFPR7x514SUPQZFztC+y1xUZmx8Kg3ZN+0WNmfp1lhw==
X-Received: by 2002:a7b:cc82:0:b0:40d:87e9:6efa with SMTP id p2-20020a7bcc82000000b0040d87e96efamr2482603wma.53.1704802363993;
        Tue, 09 Jan 2024 04:12:43 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id fc12-20020a05600c524c00b0040d5a9d6b68sm14751055wmb.6.2024.01.09.04.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 04:12:43 -0800 (PST)
Message-ID: <8085910199d4b653edb61c51fc80a503ee50131d.camel@gmail.com>
Subject: Re: [PATCH v4 6/8] iio: add the IIO backend framework
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>,  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Frank Rowand
 <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Tue, 09 Jan 2024 13:15:54 +0100
In-Reply-To: <20231226155904.043fee13@jic23-huawei>
References: <20231220-iio-backend-v4-0-998e9148b692@analog.com>
	 <20231220-iio-backend-v4-6-998e9148b692@analog.com>
	 <20231221174437.5935a5c3@jic23-huawei>
	 <f7df488b33c89ce7078c39a87ba1108fac5a10bd.camel@gmail.com>
	 <20231226155904.043fee13@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-26 at 15:59 +0000, Jonathan Cameron wrote:
>=20
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D devm_add_action_=
or_reset(dev, iio_backend_release, back);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (ret)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ret;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0link =3D device_link_add=
(dev, back->dev,
> > > > DL_FLAG_AUTOREMOVE_CONSUMER);
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!link)
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_warn("%s: Could not link to supplier(%s)\n",
> > > > dev_name(dev),
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0dev=
_name(back->dev));=C2=A0=20
> > >=20
> > > Why is that not an error and we try to carry on?=C2=A0=20
> >=20
> > I guess having the links are not really mandatory for the whole thing t=
o
> > work (more
> > like a nice to have). That's also how this is handled in another subsys=
tems
> > so I
> > figured it would be fine.
> >=20
> > But since you are speaking about this... After you pointing me to Barto=
sz's
> > talk and
> > sawing it (as stuff like this is mentioned), I started to question this=
. The
> > goal
> > with the above comment is that if you remove the backend, all the consu=
mers
> > are
> > automatically removed (unbound). Just not sure if that's what we always=
 want
> > (and we
> > are already handling the situation where a backend goes away with -ENOD=
EV)
> > as some
> > frontends could still be useful without the backend (I guess that could=
 be
> > plausible). I think for now we don't really have such usecases so the l=
inks
> > can make
> > sense (and we can figure something like optionally creating these links=
 if
> > we ever
> > need too) but having your inputs on this will definitely be valuable.
>=20
> I'm not keen on both trying to make everything tear down cleanly AND maki=
ng
> sure
> it all works even if we don't. That just adds two code paths to test when
> either
> should be sufficient on its own.=C2=A0 I don't really mind which.=C2=A0 B=
artosz's stuff

Agreed...

> is nice, but it may not be the right solution here.=20

There's pros and cons on both options...=C2=A0

For the device links the cons I see is that it depends on patch 3 for it to=
 work
(or some other approach if the one in that patch is not good) - not really =
a
real con though :). The biggest concern is (possible) future uses where we =
end
up with cases where removing a backend is not really a "deal breaker". I co=
uld
think of frontends that have multiple backends (one per data path) and remo=
ving
one backend would not tear the whole thing down (we would just have one non
functional data paths/port where the others are still ok).

Olivier, for STM usecases, do we always need the backend? I mean, does it m=
ake
sense to always remove/unbind the frontend in case the backend is unbound?

Maybe some of your usecases already "forces" us with a decision.=20

The biggest pro I see is code simplicity. If we can assume the frontend can
never exist in case one of the backends is gone, we can:

 * get rid of the sync mutex;
 * get rid of the kref and bind the backend object lifetime to the backend
device (using devm_kzalloc() instead of kzalloc + refcount.

Basically, we would not need to care about syncing the backend existence wi=
th
accessing it...
To sum up, the device_links approach tends to be similar (not identical) to=
 the
previous approach using the component API.

The biggest pro I see in Bartosz's stuff is flexibility. So it should just =
work
in whatever future usecases we might have. I fear that going the device_lin=
ks
road we might end up needing this stuff anyways.

Obviously, the biggest con is code complexity (not that bad though) as we a=
lways
need to properly sync any backend callback.

- Nuno S=C3=A1
>=20

