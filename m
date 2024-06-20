Return-Path: <linux-iio+bounces-6610-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 968B090FF97
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 10:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1871AB2757C
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 08:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610DE1A4F2F;
	Thu, 20 Jun 2024 08:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FbPcbL/Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C94D40858;
	Thu, 20 Jun 2024 08:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718873512; cv=none; b=p/By9Y4Qp3rC8oTtiqUDSt6Ilab7HGtD2j+aBqVlsE3wQolMCdqssMiWEsY9ChKkufx3mcHlnWJgF8z6ZsXRpqaTR/lwFFZFKoNFCEwnUYCEXYZl3TRCvmxEkUwzECjNoaZ6+o1X82/80NKDJJWYaIp3oI0CtyR+rh6MW38k6Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718873512; c=relaxed/simple;
	bh=2TvpXXhOk9nqvvpL7r4WYpLMcH8C6BL3/fs1sCKRmQI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZdh6Abph4Oatu4st4Dp3c6SoLZW2xmpfHpQ19jpjGalyL8BncVCO2VP+lCsT4KPLnO5O54SW0MKdOW3R52RQLHr4PkEVgpPRGISf+HaSN54aYqhjIAG9MI10lcyGIRR8IyiIpHlkLrVWtc7FvC6uORAvfTBMhgnl5iP/lxx5dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FbPcbL/Z; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718873510; x=1750409510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2TvpXXhOk9nqvvpL7r4WYpLMcH8C6BL3/fs1sCKRmQI=;
  b=FbPcbL/ZCijGAftAWywDTHH/0YYZXHnJAPzwNG9UmDjrPn2Z13rGuFH3
   NTrjh/qIlDFihgar8uSpKdVmdmJ6RgW30977qEWEoVsOX2QY0yHNNNE2f
   ZD249eUohEXOIfz8bcc9TCo5QoO56NSUMyRzad7oeV9f3q9Hn3XaAdS4h
   oTGyhFpnaH4cp3+L1ReMqqUJsmCMm2J5IJQzpERogNFdCyWoCJtbpAemx
   4JFwzbo96FbDKKBvPDZtZEmIkEYHPVaMP9iZEEBvUjHnS/nh+ABAzfK8N
   IaaNn/4QefW0LKeUAQWbiJbSeAb5OTBALjAFRwjWoyYoJdIrIO+d7OnER
   Q==;
X-CSE-ConnectionGUID: 56ZSahdTSAWG5kTlegWLxQ==
X-CSE-MsgGUID: n5KP9bTySkmIbaRvewCWMg==
X-IronPort-AV: E=Sophos;i="6.08,251,1712646000"; 
   d="asc'?scan'208";a="28910098"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Jun 2024 01:51:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 20 Jun 2024 01:51:25 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Thu, 20 Jun 2024 01:51:22 -0700
Date: Thu, 20 Jun 2024 09:51:03 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Olivier MOYSAN <olivier.moysan@foss.st.com>
CC: Conor Dooley <conor@kernel.org>, Arnaud Pouliquen
	<arnaud.pouliquen@foss.st.com>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <alsa-devel@alsa-project.org>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/8] dt-bindings: iio: dfsdm: move to backend framework
Message-ID: <20240620-custody-jailbreak-6540620d6570@wendy>
References: <20240618160836.945242-1-olivier.moysan@foss.st.com>
 <20240618160836.945242-5-olivier.moysan@foss.st.com>
 <20240618-footwear-impotence-5284985a609d@spud>
 <4734e915-9ea7-4e65-a9ef-bc1e88c40e76@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NJFxl4lrwoiFDjYE"
Content-Disposition: inline
In-Reply-To: <4734e915-9ea7-4e65-a9ef-bc1e88c40e76@foss.st.com>

--NJFxl4lrwoiFDjYE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:03:44AM +0200, Olivier MOYSAN wrote:
> On 6/18/24 20:10, Conor Dooley wrote:
> > On Tue, Jun 18, 2024 at 06:08:30PM +0200, Olivier Moysan wrote:
> > >       allOf:
> > >         - if:
> > >             properties:
> > > @@ -199,9 +264,19 @@ patternProperties:
> > >                 description:
> > >                   From common IIO binding. Used to pipe external sigm=
a delta
> > >                   modulator or internal ADC output to DFSDM channel.
> > > +              deprecated: true
> > > -          required:
> > > -            - io-channels
> > > +          if:
> > > +            required:
> > > +              - st,adc-channels
> > > +          then:
> > > +            required:
> > > +              - io-channels
> > > +
> > > +          patternProperties:
> > > +            "^channel@([0-9]|1[0-9])$":
> > > +              required:
> > > +                - io-backends
> >=20
> > Why is this here, rather than with reg above? Only some channels require
> > a backend?
>=20
> The io-backends property is required only when we use st,stm32-dfsdm-adc
> compatible. In other words, when we are in an analog use case. In this ca=
se
> the channel is a consumer of a backend (typically a sd modulator)
> In an audio use case (compatible st,stm32-dfsdm-dmic) the backend is not
> required.

Ahh, I think the hunks and indent confused me here. What you're doing is
making io-backends required based on the compatible, but what I thought
you were doing was trying to make io-backends required in channels if
st,adc-channels was set.

Thanks for the explanation,
Conor.

--NJFxl4lrwoiFDjYE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZnPtdwAKCRB4tDGHoIJi
0j93AP44jgZe6b+HBEZ4omA3y0tvrLry/EB6akIV7NR8Vap5igEAg+cGLKESOy+o
Zt9PvSP8qWdePXuj43/CfT/7C1OO8go=
=JkF+
-----END PGP SIGNATURE-----

--NJFxl4lrwoiFDjYE--

