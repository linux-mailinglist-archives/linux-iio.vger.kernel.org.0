Return-Path: <linux-iio+bounces-27175-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F2BCCC0D7
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 14:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F801302BBBA
	for <lists+linux-iio@lfdr.de>; Thu, 18 Dec 2025 13:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78CE332E697;
	Thu, 18 Dec 2025 13:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UW2zVjdw"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891D313532
	for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766065225; cv=none; b=mOtdyz8ZEldl+XkWkrfxqd0zVbFlNmKFcckR6rx76PCzOSrmK/bMNs3kZiKfDjVbyxiLVeTq8qleHSgP/gUHpWCO+yhSvWkNMM2wWC4qXzsgStaOiWx4XG9JThxICtv+RlZV0OrU+lwk3sMyOkvGUwJDGlfv1TK/MH5BSmp3Xo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766065225; c=relaxed/simple;
	bh=wt91ASdyCp6VZCVmwsKqEaedlRObMd/aTKkZobma8g0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NeNLWMVCM9qbJE3hfSatk2lMwnHng3XLRR1W95HupnaKyE4dhomLk5fWHTFeZCmQSnkVDRiPnDOW62jWOMFvIDK2prysTB7WCTDWi3hlJj6vvD7ApXlRhXHn0Jd0enEx4BUD2HivvdyyCF6dh+UgrbCLgT7r0LBuEKslj3F2EOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UW2zVjdw; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso5925155e9.3
        for <linux-iio@vger.kernel.org>; Thu, 18 Dec 2025 05:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766065222; x=1766670022; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wt91ASdyCp6VZCVmwsKqEaedlRObMd/aTKkZobma8g0=;
        b=UW2zVjdw8CwHU/PU1o5lq31Rq5dVQACXhaDooiixi+0JGwQLJApBMtfbnXiH5MZVtd
         f2mMSoeGwi3X927edQhw5l5d5BQuxJ60PHsqs4wImagppG+J3qgy14D/Irrbvl8pRAnp
         CrxfqCsgrr5QXgSM12/EIynmc+OBVLEOc6wyYnY3NvW4GfcXNJZslylBYx24j9VgprG7
         TjJDeA2c1RdFS5QhFvAfyrm2RcSH8GBbhGEVNGCtjKUYrilREM9Q7klxTRXZDTjMOjgO
         qucNaz4Ylt3zWJh9+o3FYK4tdr2Bd7jffALTPy8JiOjwUq5GgxSsJh5SzrHYADj6ZHTP
         54ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766065222; x=1766670022;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wt91ASdyCp6VZCVmwsKqEaedlRObMd/aTKkZobma8g0=;
        b=U5aFXEqLTvqvTEeREfwSdir4sfVPfZ1J8lhjdt56OH6vvfi5IaaZajBssOD3ySLx1s
         UNnS0ZBl1Oi/NMxQiuYJlBG4NWCaCifqirdhtmnlnvp0qAIvOvVszyk9/D6TqgkTL8xX
         xCQGMf68xO6vtBwvVaDcamPqiLk2qA1RS+/9LZFKDrbFwUbLKvCgGSU7mwCsKmnL3RC7
         u+VrH7XwecoK6bokbj/44ff0YbChvmIiCUOYUmf4wVISH0O7VevTqsownhZJBbeWGtAV
         e41JIT287qFJ5djY1l8pV5AEF/9C2GCsVhZxaRYUkqSye6kjV0aBG5NGdNIpKHD8e6Ne
         YgpQ==
X-Gm-Message-State: AOJu0YxMSUHsrJ74UmwB3UQyTGF2DZuA4yRwTpgaZDEC0Iu4q2/l0PRE
	qJ+A+xLpnUL7pzWSdjsqEFvVq1YoZy58lbuoHKapjTe7Eeimnyhagfuf
X-Gm-Gg: AY/fxX4vhey6auRDhdxSTJAVWWlzEoUmqfAOWd4FUjKBlY7n5AYRgr+pr8+3ZKjesH5
	Zm34CThI24hADsKpOzgFgLw7kfmjXlquHZWIPBLVfHNKxIxtbPMmkmXd1I22GLNiwGXl4s3pPmT
	o9AyCPFq5UBjw//GX2tDMuECzPMSpSzWZHWlB7HdLt4xb3gwLYx7jCq83iLN0l3Uqpchk2smvdj
	WYtfvzb1NxaU91LAHyMVd3vSycbo862MItMOzjMJ+MT7xMaHDuypL6rke0K03TdAMRieFSSwKDC
	w84keFVB0FJAdTWM8IVwpKpXFn8qRJMGf65ywSzHGMFVLPPIZL/SSK60ionwrlOhSsH5NaElEWZ
	OFWPQujmBallBkHMCkCuxP++apjLgvOAoOL09kL97F4/ve50mMYTjYP/bE/vOraNKSpEEIRTPbT
	8Nu0kBzyYbgOI=
X-Google-Smtp-Source: AGHT+IEY6QwCtWeXrDeBDcewwQ1yJNQ5ZG4izZ7TCcH9tNOpc/xsiKolrhvB1X+SlA6RMHIMaQ+sFQ==
X-Received: by 2002:a05:600c:840f:b0:479:1a09:1c4a with SMTP id 5b1f17b1804b1-47a96378c50mr201507155e9.31.1766065221551;
        Thu, 18 Dec 2025 05:40:21 -0800 (PST)
Received: from [10.5.0.2] ([45.94.208.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47be2724fe8sm56401165e9.1.2025.12.18.05.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 05:40:21 -0800 (PST)
Message-ID: <055f9c79ab40a8a72e69b7c9cfa2a64292377f5e.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: adc: ad9467: make iio backend optional
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner	 <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>
Cc: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Thu, 18 Dec 2025 13:41:02 +0000
In-Reply-To: <5fa44e46-2d94-47dd-8429-9748aa28f908@vaisala.com>
References: 
	<20251216-b4-ad9467-optional-backend-v1-0-83e61531ef4d@vaisala.com>
	 <20251216-b4-ad9467-optional-backend-v1-2-83e61531ef4d@vaisala.com>
	 <2a265681ad73bebf1ad7aeea418fb9399b8350cf.camel@gmail.com>
	 <d2cfd1bb-0bc0-47c0-a68a-3967cd64878c@vaisala.com>
	 <c3ed08159082c15f8804c6963b4422bbbf2039ab.camel@gmail.com>
	 <5fa44e46-2d94-47dd-8429-9748aa28f908@vaisala.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-12-17 at 13:44 +0200, Tomas Melin wrote:
> [resend, I think there was some problem with my first reply]
>=20
> Hi,
>=20
> On 17/12/2025 11:26, Nuno S=C3=A1 wrote:
> > On Tue, 2025-12-16 at 15:39 +0000, Tomas Melin wrote:
> > > Hi,
> > >=20
> > > On 16/12/2025 14:56, Nuno S=C3=A1 wrote:
> > > > On Tue, 2025-12-16 at 11:40 +0000, Tomas Melin wrote:
> > > > > Not all users can or want to use the device with an iio-backend.
> > > > > For these users, let the driver work in standalone mode, not coup=
led
> > > > > to the backend or the services it provides.
> > > > >=20
> > > > > Signed-off-by: Tomas Melin <tomas.melin@vaisala.com>
> > > > > ---
> > > >=20
> > > > Which users? The only usecases (for all the supported devices) we h=
ave require
> > > > the FPGA backend. So do you have a specific usecase for a specific =
device? If so, I would
> > > > prefer an explicit boolean in the chip_info struture for the device=
(s) we know this
> > > > can happen (unless you have a usecase for all :)).
> > >=20
> > > This is generically for all the devices supported by the ad9467, not
> > > only a specific device. So it's about how this is used as part of the
> > > design.
> > >=20
> > > This is aimed at users that do not use the ADI HDL reference backend
> > > with these devices, but instead have custom backends suited for their
> > > own needs.
> >=20
> > Hmm, ideally I would then like to see the backend driver upstreamed...
>=20
> First of all, as I responded in another thread, there is certainly real
> use case behind this, I would not be suggesting it otherwise.
>=20
> Driver for custom backend would not be of any interest for mainline
> kernel as the IP would not be publicly available. So nobody could really
> use such a driver, nor would it be accepted. The default ADI backend is
> =C2=A0a different story, as it is available and documented.

I see.

>=20
> >=20
> > > In that case, we need to be able to skip the backend registration and
> > > register device as a standalone iio device.
> > >=20
> > > Hopefully this made the use case clearer?
> > >=20
> >=20
> > I mean, I don't love this and I'm not really sure I'm ok with it. These=
 are fairly
> > high speed devices which often do require an FPGA IP to handle the data=
 flow. Now
> > we can ignore the backend device (which is an essential piece) being it
> > expected or not.
> >=20
> > Or maybe we can just do something like regulators and get a dummy backe=
nd or just add
> > some fixed kind of backend. Bottom line is, it still seems the backend =
device is a core
> > piece in your design and we're just hacking around the driver in way th=
at conceptually
> > doesn't make sense to me.
>=20
> I considered the idea of dummy backend, but in the end it doesn't make
> much sense to me.
> These ADCs can work perfectly fine with a minimalistic custom backend
> that does exactly what the design needs, without the need for basically
> any configuration. So the ADCs rely on some sort of backend, ofcourse,
> but they are in the end standalone devices that can be integrated in
> many ways, the adi backend being only one such option.

There we have it. It relies on some external HW so conceptually the dummy w=
ould
make sense me. In the same way a device cannot work without power supply an=
d hence
we get the dummy regulator. But...

>=20
> Another problem with a dummy backend is that for example calibration
> cannot really work. It expects certain features from the backend to be
> available, etc. Similarly would a custom backend connected need to
> implemented exactly same test features as the backend now assumes.
>=20

The above is indeed cumbersome. I guess dummy is not what we would need but=
 something
like a fixed-backend that would implement all the ops in a dummy way. But t=
hat does not
make much sense and doesn't really scale.

I think my main complain is also that then we should add a devm_backend_get=
_optional() to make
the intent clear but unfortunately this driver is not the best candidate fo=
r that.

Anyways, I still don't love the idea of just ignoring it (given that some H=
W is indeed present)
but yeah. Not going to nack it either.

- Nuno S=C3=A1


