Return-Path: <linux-iio+bounces-24502-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F77BA61ED
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD36317F256
	for <lists+linux-iio@lfdr.de>; Sat, 27 Sep 2025 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EE9276028;
	Sat, 27 Sep 2025 17:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfyIgGMm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AAE28682;
	Sat, 27 Sep 2025 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758993231; cv=none; b=GkfPaMJodvGCXhTLTQdO1XM3NWxNuMpT9TU0QpzDjhuZz6vQ9x/2bnFSi7W89ajnRVOrpvjdNF65cuKVsGYniq6GG/LkHkpXV7Zl9MhDwc5uOxDh9PNlrRD/5+8CZh+vaxdPwfyxdEkFvM6ph/gQroETtwYxnE/yWs5EHDGlL4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758993231; c=relaxed/simple;
	bh=qKk32KgPPAiHwNA1Q/NiC9Fb0B/e+2xep6x+hhwksRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pIE+zu3Rjf4W3vhBFPNXEP+3Nk9CsKB2HsWTn6b4SboAlwSnELNYrDsIwa0CPO6L33yjDW1pYSvUxSOZHtn7G2HVaDeckkVweU+FYwWp8VbvUAMIPhwet56lHbTJ73VqHdMDe+ODXb1R8cwI/xnjelBxcbXB61Qjkt5RFvZQbSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfyIgGMm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F593C4CEE7;
	Sat, 27 Sep 2025 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758993230;
	bh=qKk32KgPPAiHwNA1Q/NiC9Fb0B/e+2xep6x+hhwksRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DfyIgGMmg711E/beQ3BfTcThDwriXiPRFTI5TGaKokwY4LCrdxiLm8dJolysx+0s8
	 CpZOiyD7HsPeOZPFqEGEYlJBvvOpJMa1RrgeLtZV+9yL6Y5aZpVKuqskSUY79jCfvY
	 CbhgTEVWvnHHkH2nWoSUlGchvOdAu0788RzQRyRdTMgVBNlFcFNkXjujo30HP/cIby
	 uJmabZ5omGI62pEjaXPzFJro+UurBQof9shAgvcs4LPNHjrLZFEN2AtjSRWurGMsA5
	 3prwAVVtKrnIawaa3DPIJoIvzdcheYJM2+IZ73GfmyIwD9Z6vUQh7bjRLpBeYtV/UD
	 5rBV2fVRmd3ag==
Date: Sat, 27 Sep 2025 18:13:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Ariana Lazar 
 <ariana.lazar@microchip.com>, Nuno =?UTF-8?B?U8Oh?=  <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring  <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley 
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
Message-ID: <20250927181341.58c106d3@jic23-huawei>
In-Reply-To: <02c26151da7af1e05aecadf0e2ce20552c2908e0.camel@gmail.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
	<20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
	<859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
	<3457c119-2f49-43a3-b96b-736b8f5de99b@baylibre.com>
	<02c26151da7af1e05aecadf0e2ce20552c2908e0.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 23 Sep 2025 09:21:30 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2025-09-22 at 17:15 -0500, David Lechner wrote:
> > On 9/22/25 3:10 PM, Nuno S=C3=A1 wrote: =20
> > > Hi Ariana,
> > >=20
> > > Thanks for your patches. Some initial comments from me...
> > >=20
> > > On Mon, 2025-09-22 at 14:30 +0300, Ariana Lazar wrote: =20
> >=20
> > ...
> >  =20
> > > > +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_=
eeprom,
> > > > 0);
> > > > +static struct attribute *mcp47feb02_attributes[] =3D {
> > > > +	&iio_dev_attr_store_eeprom.dev_attr.attr,
> > > > +	NULL,
> > > > +};
> > > > + =20
> > >=20
> > > Not going to argue about the ABI for now but I don't think this is a
> > > standard one? So
> > > if acceptable you need an ABI doc.

store_eeprom is existing ABI and documented in sysfs-bus-iio (2 drivers imp=
lement it from
a quick grep)


> > >  =20
> > Here's a random idea. (I would wait for Jonathan to weigh in first befo=
re
> > assuming it is an acceptable idea though :-p)
> >=20
> > The config registers are pretty much going to be a one-time deal. So th=
ose
> > could be written to only if they need it during probe.
> >=20
> > For the voltage output registers, we could add extra out_voltageY chann=
els
> > that are the power-on output state channels. So writing to out_voltageY=
_raw
> > wouldn't change any real output but would just be written to EEPROM. Th=
is
> > way these voltages could be controlled independently from the real outp=
uts
> > and it uses existing ABI.

In some devices I've come across, the eeprom write is a 'store all current =
settings'
rather than individual register writes. For that a set of extra channels do=
esn't work.

Also eeproms have very limited write cycles so you really don't want to mak=
e this
too easy to do and we want to shout it's an eeprom.=20


> >=20
> > In any case, it would be interesting to hear more about how this chips =
are
> > actually used to better understand this EEPROM feature. =20
>=20
> I didn't really looked at the datasheet so this can be totally wrong. But=
 we
> have some LTC parts (mainly hwmon stuff) that are also packed with an EEP=
RON.
> AFAIU, the usecase in there is to have some defaults you can program in t=
he
> chips (and there's a feature we can enable so the chip can save things in=
to the
> eeprom automatically). Now, in those drivers we don't really support doing
> anything with the eeprom at runtime so I'm curious to see how this unfold=
s :)

Usecase for DACs is that on power on (usually at board power up not driver =
load)
they will start outputting the saved values.  That might well be part of so=
mething
fairly critical such as fan control or trip points so you don't want to wai=
t for
the driver to load. The driver on an eeprom equiped part should not configu=
re
anything on probe but rather just report back what was already there.

Userspace can then modify those values and 'commit' them via store_eeprom
to apply on next power cycle as well as now (in some cases only on next pow=
er cycle).

Jonathan


>=20
> - Nuno S=C3=A1


