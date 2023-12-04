Return-Path: <linux-iio+bounces-560-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C426A802F47
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 10:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7586C280A50
	for <lists+linux-iio@lfdr.de>; Mon,  4 Dec 2023 09:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E05B1DFC3;
	Mon,  4 Dec 2023 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ho/CWHb5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC001A5B8;
	Mon,  4 Dec 2023 09:51:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62704C433C9;
	Mon,  4 Dec 2023 09:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701683479;
	bh=WapbCRUO3S/NfgvTtNfLjSDYaTDi8m3kUjYU8vSz9Y0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ho/CWHb52u731UYrS+MGise5+SKq+Vd+/HDabnoaxmGy7NhtTnq3I07gZxjWWyNFE
	 dB/7eI+Nt2ZH4LJpFIZqd+QrDmKQHyeazYhRyvNV5mjrEGmm6MilxbKeFVolQE2eaD
	 Td6nyZoDPbH/obVmxld9N5tGDYu4Js7Wy5KSd/AwsTHax0ygxPtco6VXy5V6ipofyP
	 PX7G5rRMCVX+788vN4xYj2MZjNwgRZ5eJp4U8foNdMicj16ZgcoTXKPVy6VNI6TU2B
	 H/GvYz77z7XF63giEkSSZRECDMxSchpIIIP6ZBoF9j7A7xX23P5kZ9IRocK/qHsCRc
	 FBqUI9JloHDXw==
Date: Mon, 4 Dec 2023 09:51:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Paul Gazzillo
 <paul@pgazz.com>, Matt Ranostay <matt@ranostay.sg>, Stefan Windfeldt-Prytz
 <stefan.windfeldt-prytz@axis.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light
 Sensor
Message-ID: <20231204095108.22f89718@jic23-huawei>
In-Reply-To: <e995ee76-7dc3-4a4a-80a3-fca1ac7c5a9f@gmail.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
	<20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
	<20231028162025.4259f1cc@jic23-huawei>
	<2974aa13-796c-49ef-bef7-fd7f3f9b7f49@tweaklogic.com>
	<20231106111355.2f8dfaa1@jic23-huawei>
	<307f93f9-2a41-4704-ac4f-8d1e427e5060@tweaklogic.com>
	<e995ee76-7dc3-4a4a-80a3-fca1ac7c5a9f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 6 Nov 2023 14:10:43 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 11/6/23 14:04, Subhajit Ghosh wrote:
> > On 6/11/23 21:43, Jonathan Cameron wrote: =20
> >> On Tue, 31 Oct 2023 19:08:08 +1030
> >> Subhajit Ghosh <subhajit.ghosh@tweaklogic.com> wrote:
> >> =20
> >>>> Scale on the intensity channel is interesting...=C2=A0 What are the =
units?
> >>>> There tend not to be any well defined units for intensity (as opposed
> >>>> to illuminance).=C2=A0 There may be gain on the signal, but it won't=
 be=20
> >>>> in untils
> >>>> that map directly to a scale userspace should apply.=C2=A0 This is o=
ne of=20
> >>>> the
> >>>> rare reasons for using the HARDWARE_GAIN element of the ABI.
> >>>>
> >>>> A tricky corner however as relationship between raw value and=20
> >>>> hardwaregain
> >>>> is not tightly defined (as it can be really weird!) =20
> >>> Hi Jonathan,
> >>>
> >>> Thank you for taking time for reviewing and clearing all my tiny=20
> >>> doubts and
> >>> queries especially for the dt and versioning part. Much appreciated.
> >>>
> >>> In the above case, should I not expose scale for the "clear" channel?=
=20
> >>> Rather,
> >>> how should I expose the "clear" channel to userspace? =20
> >> What is the scale?=C2=A0 What units to you get after applying it? =20
> > The scale is in Lux. The output after applying is Lux. =20
>=20
> Hi Subhajit,
>=20
> I am by no means an expert here but maybe you could check if the channel=
=20
> should be of type 'illuminance'? (To me 'Lux' sounds like an unit of=20
> illuminance rather than intensity).

Absolutely. Light measurements are 'weird'. Lux is a measurement of
light as if the human eye were looking at it. Unfortunately light sensors
don't have the same sensitivity curves as the eye so instead they tend
to do it either by some careful choice of filters, a horrible approximation
based on assumption of day light, or most commonly by combining the inputs
of several different light sensors.

Clear normally means sensitive to both visible light and infrared which
means you need to remove the infrared part to get closer to human
eye response.   Thus in other light sensors, we can't assign standard
units to the intensity channels (and so don't provide a scale).
We just don't have enough information to work out what they are measuring.
In theory we could provide the full sensitivity curve (usually somewhere
in the datasheet) but they can be complex multi-peak things so we don't
so far.

Jonathan


>=20
> Yours,
> 	-- Matti
>=20


