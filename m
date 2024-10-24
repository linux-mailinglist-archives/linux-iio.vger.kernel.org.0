Return-Path: <linux-iio+bounces-11101-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7A69AE501
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 14:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D84B1F218BF
	for <lists+linux-iio@lfdr.de>; Thu, 24 Oct 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A9E1D5AA8;
	Thu, 24 Oct 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnX1VYn+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF551714C9;
	Thu, 24 Oct 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729773465; cv=none; b=C9DjyvSdAmpgoeZT0L+c2tKxYDpo3AGHDuGTv26PoO8LtaW3eiajjfYGkfyjWMQNjmQkPRj4t+dr0i2TPbkiHpW08hNyylrTEKkg4VgCbWl9MBvWsZehfTMawu8S8WbIjimo3tpuxgs+sjcvmgyT8kFJuXy9Ne73FbE65PVnldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729773465; c=relaxed/simple;
	bh=NhUrbZLETYw0l+YLK1g63xDF45OXmFDWZDTSDxwx0p8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ko1Zcu6iGXHBvbks8mD6Fie6vrurq7HE+IkCINfKFLFqslhSVQMykpVTrWgzz2Q7GGWjJqqF5cBfdbK004US6Oa0ITfkSLlvEbkgx+LBULOM6DarmBdoXYfG/My3Q7U9j/8BAQUnHuMKNtIp9gEF4Llyvay55mzMpDt5IvtaGLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RnX1VYn+; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-539ee1acb86so970495e87.0;
        Thu, 24 Oct 2024 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729773461; x=1730378261; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NhUrbZLETYw0l+YLK1g63xDF45OXmFDWZDTSDxwx0p8=;
        b=RnX1VYn+x2BQnvtGQjD0EOd2gKzaHjRIKbbTsmDf9KcYwmWzI1lyRzzfn+8wqM4Pxo
         bxxZkzC8JhcyXjQIJ5DM0f4nn41q/4gbgvpHyLyRQqIEyG5dhafjHMZHzpawxGxRzXBF
         8/JXmfLKcZUuvMvLZ9NolIGuSJmPhbWtJm2V1dhCKsYJBUO8uVYJfF2cGGX5AgXt8aF9
         4RnX5cquLvuJvMl5aWOFc3PwG3DIzP2VCjUp00BDwAOT2ZBOGI2UyGguTFeuSOxEupRH
         HhReb+ROPo2YHoXSYh1ikle3rO6PnvdUiuxfthkErOHsrbiUFTzG0mn/fte7UJBygRCP
         R50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729773461; x=1730378261;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NhUrbZLETYw0l+YLK1g63xDF45OXmFDWZDTSDxwx0p8=;
        b=hDe5fdxlm3WrxTFObsGDvNpwXS+OYhyiKyeWiKl5nK/BlhqlXKyiWmgtv+cJgn/2Yy
         zJQlhY1UTsQ53FftXTy2b8uObP79FZZANu7Ca51t0QlQJlQi1i4GvHDWRa92DlhSuFZM
         IPKUgRX1wYXjL/Xzhl2nMo4sOYpPADMdL4QejDq+pVeNB3grQFEfbBG0nqNF3P1eKkbF
         WnogQvZLj5NBoilvoSmaj2o+GqLYqyapoWEPv4duz4np/jtPpvlWHb02ACUk1M2DwLi4
         rnV3zTLn08nRC0BuXcMmej1uZjXbKpXshLWTnFd6/4ZynzhWOXfgFEXGIKGSFHQbZk8l
         P5mg==
X-Forwarded-Encrypted: i=1; AJvYcCWM6j2J2f3SMf6840e6jdrnSldoZaDLJlJPfXfPQzGNAuRt0vpFQP/e4Np58aqYCZ5vrtra66eRZul7rAj8@vger.kernel.org, AJvYcCX702kJrshlngmXuzpvFh5lOdOZCkvfvTsDTYNELrBw3a7Y3iQr9oX6HQ9kADOMYjLSHD+y9qKxyjrW@vger.kernel.org, AJvYcCXFT1D2hZpewEOnS3vS4S0N5clGTIGfcqghAvWmTjA773SIABk5+Kt7g1Q+0ANsiWhBpDvCoOMN0S5Z@vger.kernel.org
X-Gm-Message-State: AOJu0YwThTZC+f8ETd/HbdzcZVFpVnCuRFkuW8bLIIW7Bk7lPvsMLlyA
	Y17vEtpD9AtQU3XDBPkcH2JZ6U+2uTNPu6WgNIzhPVZuQSWEXhKv
X-Google-Smtp-Source: AGHT+IFJaactRWklQ9v1NMNih5bM2Vb4gQ6jaWEHSvyCRoZXlN6xWOOqiI+TJ4EeT9kvB/FAToUUgQ==
X-Received: by 2002:a05:6512:131e:b0:539:e282:ce9e with SMTP id 2adb3069b0e04-53b1a3a39f1mr3079304e87.60.1729773461292;
        Thu, 24 Oct 2024 05:37:41 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b500sm5664022a12.13.2024.10.24.05.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 05:37:41 -0700 (PDT)
Message-ID: <6c2f188fc04ea957c842fe595951039244c43b7e.camel@gmail.com>
Subject: Re: [PATCH v7 2/8] dt-bindings: iio: dac: adi-axi-dac: add ad3552r
 axi variant
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Conor Dooley
	 <conor@kernel.org>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dlechner@baylibre.com,  Mark Brown
 <broonie@kernel.org>
Date: Thu, 24 Oct 2024 14:37:40 +0200
In-Reply-To: <zfggfhasl3njyux5n44j2au4dlyjlngbtt4fps2xqzpngbwn42@72icpspkogtz>
References: 
	<20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-0-969694f53c5d@baylibre.com>
	 <20241021-wip-bl-ad3552r-axi-v0-iio-testing-v7-2-969694f53c5d@baylibre.com>
	 <20241022-flagpole-subject-51e68e81e948@spud>
	 <zfggfhasl3njyux5n44j2au4dlyjlngbtt4fps2xqzpngbwn42@72icpspkogtz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-24 at 11:28 +0200, Angelo Dureghello wrote:
> Hi Conor,
>=20
> On 22.10.2024 18:22, Conor Dooley wrote:
> > On Mon, Oct 21, 2024 at 02:40:12PM +0200, Angelo Dureghello wrote:
> > > From: Angelo Dureghello <adureghello@baylibre.com>
> > >=20
> > > Add a new compatible and related bindigns for the fpga-based
> > > "ad3552r" AXI IP core, a variant of the generic AXI DAC IP.
> > >=20
> > > The AXI "ad3552r" IP is a very similar HDL (fpga) variant of the
> > > generic AXI "DAC" IP, intended to control ad3552r and similar chips,
> > > mainly to reach high speed transfer rates using a QSPI DDR
> > > (dobule-data-rate) interface.
> > >=20
> > > The ad3552r device is defined as a child of the AXI DAC, that in
> > > this case is acting as an SPI controller.
> > >=20
> > > Note, #io-backend is present because it is possible (in theory anyway=
)
> > > to use a separate controller for the control path than that used
> > > for the datapath.
> > >=20
> > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > ---
> > > =C2=A0.../devicetree/bindings/iio/dac/adi,axi-dac.yaml=C2=A0=C2=A0 | =
69 +++++++++++++++++++++-
> > > =C2=A01 file changed, 66 insertions(+), 3 deletions(-)
> > >=20
> > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.ya=
ml
> > > b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > index a55e9bfc66d7..0aabb210f26d 100644
> > > --- a/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,axi-dac.yaml
> > > @@ -19,11 +19,13 @@ description: |
> > > =C2=A0=C2=A0 memory via DMA into the DAC.
> > > =C2=A0
> > > =C2=A0=C2=A0 https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> > > +=C2=A0 https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/in=
dex.html
> > > =C2=A0
> > > =C2=A0properties:
> > > =C2=A0=C2=A0 compatible:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-dac-9.1.b
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,axi-ad3552r
> > > =C2=A0
> > > =C2=A0=C2=A0 reg:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > @@ -36,7 +38,12 @@ properties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: tx
> > > =C2=A0
> > > =C2=A0=C2=A0 clocks:
> > > -=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > +
> > > +=C2=A0 clock-names:
> > > +=C2=A0=C2=A0=C2=A0 minItems: 1
> > > +=C2=A0=C2=A0=C2=A0 maxItems: 2
> > > =C2=A0
> > > =C2=A0=C2=A0 '#io-backend-cells':
> > > =C2=A0=C2=A0=C2=A0=C2=A0 const: 0
> > > @@ -47,7 +54,31 @@ required:
> > > =C2=A0=C2=A0 - reg
> > > =C2=A0=C2=A0 - clocks
> > > =C2=A0
> > > -additionalProperties: false
> > > +allOf:
> > > +=C2=A0 - if:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 c=
onst: adi,axi-ad3552r
> > > +=C2=A0=C2=A0=C2=A0 then:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/spi/spi-controller.yam=
l#
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 2
> >=20
> > Is this maxItems required? It matches the outer maximum.
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 items:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 const: s_axi_aclk
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=
 const: dac_clk
> >=20
> > The names are the same in both cases, you can move the definitions
> > outside of the if/then/else stuff and only constrain it here.
> >=20
> thanks, could you maybe have a look if it's ok now ?
> (maxItems not needed for a const list)
>=20
> =C2=A0 clocks:
> =C2=A0=C2=A0=C2=A0 minItems: 1
> =C2=A0=C2=A0=C2=A0 maxItems: 2
>=20
> =C2=A0 clock-names:
> =C2=A0=C2=A0=C2=A0 items:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: s_axi_aclk
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - const: dac_clk
> =C2=A0=C2=A0=C2=A0 minItems: 1
>=20
> =C2=A0 '#io-backend-cells':
> =C2=A0=C2=A0=C2=A0 const: 0
>=20
> required:
> =C2=A0 - compatible
> =C2=A0 - dmas
> =C2=A0 - reg
> =C2=A0 - clocks
>=20
> allOf:
> =C2=A0 - if:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const:=
 adi,axi-ad3552r
> =C2=A0=C2=A0=C2=A0 then:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/spi/spi-controller.yaml#
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 minItems: 2
> =C2=A0=C2=A0=C2=A0 else:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clock-names:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1

I guess in this case it could even be clock-names: false. One does not make=
 much
sense.

- Nuno S=C3=A1



