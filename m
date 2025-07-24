Return-Path: <linux-iio+bounces-21986-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 493E0B10E7B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 17:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CF651C28322
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 15:18:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0843F2E975A;
	Thu, 24 Jul 2025 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoPzUSrn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA79347D5;
	Thu, 24 Jul 2025 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753370313; cv=none; b=ew+O15E5/6mE5V5cEaQ8fi32mIquEBnZsI3b3mSS61ERfAkYbnbQR6+ilp2F43JEZQ7DGtdbLbAxcIOvBja5sgFMM1JkNq6iS3P/AgpviOqAb2Ko712nM16MskAkHV8ibKmOITLczL6yjuiKvNESab6kRXnvmNR5RqAUVJ2EANw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753370313; c=relaxed/simple;
	bh=+bp6pfjFYbsKUp64YHHqLCc5uIl+4qZHCE84GxhUcHU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J2tkXIktfDJHUfglU/jWDkPEjfvFKWLzVyEayF1MSKiPndc+VuFVJ/njZ336dap5qOFOAOPpyeUTfI3Yiifjm43CblzqRLCQpcT4uvDA7V6v2gdFcwNQqtoR0fKdpDFFWbAs0gVHsege1VtRlMpHXyhwXKETFIlAB3nXGm4nmf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoPzUSrn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B19C4CEED;
	Thu, 24 Jul 2025 15:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753370313;
	bh=+bp6pfjFYbsKUp64YHHqLCc5uIl+4qZHCE84GxhUcHU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LoPzUSrn6r1oXxb3kNWN4MtXMDylnjukws8Eed4h76plciZYjuQdZKsPSyXZ+PRCs
	 eIjt7QadV3qJM0q1SD5SBIqf6ZEq8Nt3zsXTV+pdJEAnj9SEpBnOKnrKdAStVn8ld8
	 vPe95RerhCKQdJai2hXcUGkECzpmsqM7Z4yEpoV8YqdPDFEI8eg9aGzzUJCZfgT4E0
	 /GzO3OZotadoLxuBlYAWpt6jv09cHslne3hPY0KfRCyhRJQdsS3VJycJtBNG1aSqSf
	 pYjJjVlF2eaivil87NuFLKdBfd353lhVQH3/uenQQXSZ0ugrEdft7ZD9tZWnXBF6xj
	 murJ3JuU0V2zg==
Date: Thu, 24 Jul 2025 16:18:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bough Chen <haibo.chen@nxp.com>
Cc: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Nuno S?
 <noname.nuno@gmail.com>, Primoz Fiser <primoz.fiser@norik.com>, David
 Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn
 Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
 <festevam@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "upstream@lists.phytec.de"
 <upstream@lists.phytec.de>, "andrej.picej@norik.com"
 <andrej.picej@norik.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration
 properties
Message-ID: <20250724161820.66e37f6c@jic23-huawei>
In-Reply-To: <DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
	<20250710073905.1105417-2-primoz.fiser@norik.com>
	<2bcd758b-c2d0-488a-8ead-ec7fb39f93e2@baylibre.com>
	<20250713160247.0f22bbfe@jic23-huawei>
	<de2c8e15-14e9-4c61-9a13-97ef1ec567a4@norik.com>
	<6b32118a13e9e28b7cf12152af33642c76367c34.camel@gmail.com>
	<20250721093847.GD4844@nxa18884-linux.ap.freescale.net>
	<DU0PR04MB9496FCE8DF07CD0E270B72AF905DA@DU0PR04MB9496.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Jul 2025 09:09:06 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > Sent: 2025=E5=B9=B47=E6=9C=8821=E6=97=A5 17:39
> > To: Nuno S? <noname.nuno@gmail.com>
> > Cc: Primoz Fiser <primoz.fiser@norik.com>; Jonathan Cameron
> > <jic23@kernel.org>; David Lechner <dlechner@baylibre.com>; Bough Chen
> > <haibo.chen@nxp.com>; Nuno Sa <nuno.sa@analog.com>; Andy Shevchenko
> > <andy@kernel.org>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; Shawn Guo
> > <shawnguo@kernel.org>; Sascha Hauer <s.hauer@pengutronix.de>;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Fabio Estevam
> > <festevam@gmail.com>; linux-iio@vger.kernel.org; imx@lists.linux.dev;
> > devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-kernel@vger.kernel.org; upstream@lists.phytec.de;
> > andrej.picej@norik.com
> > Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: imx93: Add calibration =
properties
> >=20
> > On Mon, Jul 14, 2025 at 05:11:31PM +0100, Nuno S? wrote: =20
> > >On Mon, 2025-07-14 at 07:56 +0200, Primoz Fiser wrote: =20
> > >> Hi all,
> > >>
> > >> On 13. 07. 25 17:02, Jonathan Cameron wrote: =20
> > >> > On Thu, 10 Jul 2025 10:46:44 -0500
> > >> > David Lechner <dlechner@baylibre.com> wrote:
> > >> > =20
> > >> > > On 7/10/25 2:39 AM, Primoz Fiser wrote: =20
> > >> > > > From: Andrej Picej <andrej.picej@norik.com>
> > >> > > >
> > >> > > > Document i.MX93 ADC calibration properties and how to set them.
> > >> > > >
> > >> > > > Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> > >> > > > Signed-off-by: Primoz Fiser <primoz.fiser@norik.com>
> > >> > > > ---
> > >> > > > ??.../bindings/iio/adc/nxp,imx93-adc.yaml???????????? | 21
> > >> > > > +++++++++++++++++++
> > >> > > > ??1 file changed, 21 insertions(+)
> > >> > > >
> > >> > > > diff --git
> > >> > > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-
> > >> > > > adc.yaml
> > >> > > > b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > >> > > > index c2e5ff418920..d1c04cf85fe6 100644
> > >> > > > ---
> > >> > > > a/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
> > >> > > > +++ b/Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.y
> > >> > > > +++ aml
> > >> > > > @@ -52,6 +52,27 @@ properties:
> > >> > > > ???? "#io-channel-cells":
> > >> > > > ???????? const: 1
> > >> > > > ??
> > >> > > > +?? nxp,calib-avg-en:
> > >> > > > +?????? default: 1
> > >> > > > +?????? description:
> > >> > > > +?????????? Enable or disable calibration averaging function (=
AVGEN).
> > >> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
> > >> > > > +?????? enum: [ 0, 1 ]
> > >> > > > +
> > >> > > > +?? nxp,calib-nr-samples:
> > >> > > > +?????? default: 512
> > >> > > > +?????? description:
> > >> > > > +?????????? Selects number of samples (NRSMPL) to be used duri=
ng =20
> > calibration. =20
> > >> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
> > >> > > > +?????? enum: [ 16, 32, 128, 512 ] =20
> > >> >
> > >> > Allow 1 as a value and drop the enabled above.???? Averaging over 1
> > >> > sample is same as no averaging and gives simpler binding.
> > >> > =20
> > >> > > > +
> > >> > > > +?? nxp,calib-t-sample:
> > >> > > > +?????? default: 22
> > >> > > > +?????? description:
> > >> > > > +?????????? Selects sample time (TSAMP) of calibration
> > >> > > > +conversions in ADC
> > >> > > > clock cycles
> > >> > > > +?????? $ref: /schemas/types.yaml#/definitions/uint32
> > >> > > > +?????? enum: [ 8, 16, 22, 32 ]
> > >> > > > +
> > >> > > > ??required:
> > >> > > > ???? - compatible
> > >> > > > ???? - reg?? =20
> > >> > >
> > >> > > This seem like things that should be set at runtime rather than
> > >> > > in the devicetree. Unless there is some justification on why
> > >> > > these values depend on how the chip is wired up? =20
> > >>
> > >> It depends how ADC 1.8V Vref is wired up, especially how noisy it is.
> > >> =20
> > >> >
> > >> > Further to that, I'd like to see some explanation of why we care to
> > >> > change it at all. Is it ever a bad idea to enable averaging and
> > >> > pick a large number of samples for calibration? =20
> > >>
> > >> This is a snippet from the i.MX93 TRM, chapter Analog-to-Digital
> > >> Converter (SAR_ADC) describing calibration steps:
> > >>
> > >> 1. Wait for deassertion of functional reset.
> > >> 2. Configure SAR controller operating clock (MCR[ADCLKSE] =3D 0).
> > >> 3. Bring ADC out of Power-down state (MCR[PWDN] =3D 0).
> > >> 4. Configure desired calibration settings (default values kept for
> > >> highest accuracy maximum time).
> > >> ??? MCR[TSAMP]: Sample time for calibration conversion ???
> > >> MCR[NRSMPL]: Number of samples in averaging ??? MCR[AVGEN]: Averaging
> > >> function enable in calibration 5. Run calibration by writing a one to
> > >> MCR[CALSTART].
> > >> 6. Check calibration run status in MSR[CALBUSY]???wait until
> > >> MSR[CALBUSY] =3D 0; alternatively, MSR[ADCSTAT] can be used to check
> > >> status.
> > >> 7. Check calibration pass/fail status in MSR[CALFAIL] field. If
> > >> MSR[CALFAIL] =3D 1 then calibration failed. Detailed status can be
> > >> checked in CALSTAT.
> > >>
> > >>
> > >> See point 4).
> > >>
> > >> Not sure why would there be an option to configure i.MX93 ADC
> > >> calibration parameters if one use-case (max accuracy max time) to
> > >> rule them all?
> > >> =20
> > >
> > >Sometimes HW guys just want to give you some options. Does not mean we
> > >have to use them all :).
> > >
> > >I guess what Jonathan is interested in, is to understand in what
> > >conditions the defaults are no good for the calibration? If we can have
> > >a set of values that should pretty much always work, no need to further
> > >complicate the bindings or the driver. =20
> >=20
> > Just my understanding, it is hard to use one fixed settings to fit all =
kinds of
> > conditions.
> >=20
> >                  Noise induced from PCB tracks  Electro- magnetic noise
> > 		     |                           |
> > 		     V                           V
> >  ---------
> > |SOC(ADC)|   <---------------------------------<- (~) external Signal
> >  ---------
> >                  ^                 ^
> >                  |                 |
> >              I/O coupled noise    Internal noise
> >=20
> >=20
> > So OEM A's board may needs different settings compared with OEM B's boa=
rd. =20
>=20
> The noise on Vref did impact the calibration, we did get report from cust=
omer, and IC guys suggested to do like the following patch, what's your com=
ments?
>=20
> https://patchwork.kernel.org/project/linux-iio/patch/20250423-adcpatch-v1=
-1-b0e84c27ae98@nxp.com/

To me warning and accepting a failed calibration is better than tweaking se=
ttings.

The reason is I'm still failing to understand why we should (for example) r=
educe the
time over which the signal is averaged.  Why would that make it more likely=
 to pass
in some noise conditions than another set?  It might increase the chance of=
 passing
I guess, but it's still likely to fail sometimes.

Jonathan

>=20
> Regards
> Haibo Chen=20
> >=20
> > Regards,
> > Peng
> >  =20
> > >
> > >- Nuno S?? =20
> > >> On the other hand, public TRM doesn't give much more information and=
 =20
> > >> > =20


