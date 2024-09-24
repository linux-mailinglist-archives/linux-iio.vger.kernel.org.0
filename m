Return-Path: <linux-iio+bounces-9752-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1F9845E4
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB4B9B21E20
	for <lists+linux-iio@lfdr.de>; Tue, 24 Sep 2024 12:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081B1A704B;
	Tue, 24 Sep 2024 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cBG385Wo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C533F9D5;
	Tue, 24 Sep 2024 12:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727180876; cv=none; b=KOh1BJ8fSl7Glw5g6zLpNDMBSsmLSOdbksPtLmOWuvIF2+MRf3HVEB6F8K6k7TSu/H5Lot98HSbN78+qHfslP52dkN6S0DR1Nwku+QoymqEBd7y51LPmQTlJosOBbE2zGzNi+9WZ8SCQRWVj+fS4Ftf7jMQVzej+49+hbyZpKaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727180876; c=relaxed/simple;
	bh=ywLGceDCYf4x1vFhs+LV/hfPBu8Rv0mc+L+v9FY7oKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Yt196lsp45cVkXe7JuCcj/VvWAY/A5ImoGNCn3rh1vCYLaTBza1KX9E7Fr76lKXTLvL1eBQExZQfRPd50HIrffAW6t5/mlpQ7c/akg/gxWtxs8NlRbCNaOkpws8hamA7ll+WI2hLpx0/XYw+0Ye6kUMcSrfSuZZYcMH8xkk1MyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cBG385Wo; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a90349aa7e5so815971166b.0;
        Tue, 24 Sep 2024 05:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727180873; x=1727785673; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ywLGceDCYf4x1vFhs+LV/hfPBu8Rv0mc+L+v9FY7oKk=;
        b=cBG385WouZeWbaaYWNqg9SQhVk+gpvVIXOS20GER9oCZEu9fGhwXAQfa5Kp/8qbOao
         ePlga3cwem1O0kQIPHEGZD4rNW37d2KVaES5TvhohgdLNBrRjDqYiiORxSJNEIaQy1Zg
         dFmCygJ8gzJ4TpFvr33iGpoy29z05sZn1JujWGFDYEqLArNvQha9KaMdKDFvKRPSC3qB
         UmdpHsHQuJSJd9g6cTXpgvIb0hWkuN8/tOmKHpV5CDr+ys0vUor/vCqOdM5O/STCEcKl
         GbeV6mLPf8sV9lL6+vJLhJhkHzueNc1lPoadJXSWC4cwtvSHaoMVigw6Z5UhnYqNGg9L
         +4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727180873; x=1727785673;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ywLGceDCYf4x1vFhs+LV/hfPBu8Rv0mc+L+v9FY7oKk=;
        b=Q5fJ8FQ0Ftm6doiOwlRoY6rcAiPgC2I//xkoop+RrzGvwq7vSIkYwRyt2skZJ2mnsb
         J56pFoTLL22xc9Obl55hZHOY2xTT7e97TCJwru4WwT8d0tzPqypy/dS3A97sbpfcIX08
         bB2CEVtURWyQ3RN5SoYvOVp3fV320+ul5lle4xImlkwfcT+3cRPQhBXYx9TEZuEpnOcS
         MAlacAHhZu0unXGRkv4dXTOx/PZdenYT2saKNwsMP+xaN+o97t8GupccZnyREQAY0CHL
         AvA71kw/8iObpuUYy4QUQoXBC/MImsu8Mr3C5zZse1CM1OoEjIkVTOhL4yKFRUHouD1K
         xeQQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXRQXcyn6pxQVv1Yu2TV9IiTlMfg9mg0I+1yQPqf59Ad2g0DBwbSAO6wT8supIvjWUHOmR8QSmG48w@vger.kernel.org, AJvYcCVzDgPZTBsvl0X47URz9mqBEWMtTrB4tCNX1oSOaUHfI0sTfh+Yw6tf8uASNu3TCs1JdvLFiDAGFyPm@vger.kernel.org, AJvYcCX8CMZgEHEcMnpZBqu/xD1it15iP5cyPkNmudzIL3PpVNc4XIM8UBr4qovS8vQ0VbBBBp1kN6VXd1H7mPdk@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9pQJiHx3ZynYqlMS5BcLBca6dyWSNYtSk3MAtCQazhxbmetx+
	ITcMoFq6QLxxE2HG4CV6iMBCz55zXrGQ3NU7qOuBRnkzqcrIs8d+
X-Google-Smtp-Source: AGHT+IGC8mmHOtQXnCx9XFDEgguEDQcdTSD4aC6zAZs1r6ZrSKYGlkIjk8hEZUHlw5byqkTSB3wEZg==
X-Received: by 2002:a17:907:982:b0:a86:b923:4a04 with SMTP id a640c23a62f3a-a90d5924f6emr1525492166b.50.1727180872327;
        Tue, 24 Sep 2024 05:27:52 -0700 (PDT)
Received: from ?IPv6:2001:a61:341e:1201:c434:b5b1:98a6:efed? ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f340a0sm78853366b.38.2024.09.24.05.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 05:27:51 -0700 (PDT)
Message-ID: <0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Jonathan
 Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Olivier
 Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Date: Tue, 24 Sep 2024 14:27:51 +0200
In-Reply-To: <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
	 <20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
	 <gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
	 <418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
	 <e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:
> On 23/09/2024 17:50, Angelo Dureghello wrote:
> > Hi Krzysztof,
> >=20
> > On 22/09/24 23:02, Krzysztof Kozlowski wrote:
> > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello wrote:
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > There is a version AXI DAC IP block (for FPGAs) that provides
> > > > a physical bus for AD3552R and similar chips, and acts as
> > > > an SPI controller.
> > > >=20
> > > > For this case, the binding is modified to include some
> > > > additional properties.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml=C2=A0=C2=A0=
 | 42
> > > > ++++++++++++++++++++++
> > > > =C2=A0 1 file changed, 42 insertions(+)
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.=
yaml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > index 41fe00034742..aca4a41c2633 100644
> > > > --- a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.yaml
> > > > @@ -60,6 +60,18 @@ properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#/definitio=
ns/uint32
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> > > > =C2=A0=20
> > > > +=C2=A0 io-backends:
> > > > +=C2=A0=C2=A0=C2=A0 description: The iio backend reference.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backend can be found at
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > https://analogdevicesinc.github.io/hdl/library/axi_ad3552r/index.ht=
ml
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 adi,synchronous-mode:
> > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting for external synchr=
onization signal.
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP configuration can imple=
ment a dual-IP layout, with
> > > > internal
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for streaming synchronizati=
on.
> > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > +
> > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > =C2=A0=20
> > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
- custom-output-range-config
> > > > =C2=A0=20
> > > > =C2=A0 allOf:
> > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > > @@ -238,4 +251,33 @@ examples:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > +
> > > > +=C2=A0 - |
> > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =3D "adi,axi=
-ad3552r";
> > > That is either redundant or entire example should go to the parent no=
de,
> > > if this device is fixed child of complex device (IOW, adi,ad3552r can=
not
> > > be used outside of adi,axi-ad3552r).
> >=20
> > ad3552r can still be used by a generic "classic" spi
> > controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> > controller only (axi-ad3552r) can reach 33MUPS.
>=20
> OK, then this is just redundant. Drop the node. Parent example should
> contain the children, though.
> >=20
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44a70000 0x1=
000>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&dac_tx_dma 0=
>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D "tx";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-cells =3D <=
0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&ref_clk>;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cells =3D <1>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =3D <0>;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 compatible =3D "adi,ad3552r";
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reg =3D <0>;
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 reset-gpios =3D <&gpio0 92 0>;
> > > Use standard defines for GPIO flags.
> >=20
> > fixed, thanks
> >=20
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 io-backends =3D <&axi_dac>;
> > > Why do you need to point to the parent? How much coupled are these
> > > devices? Child pointing to parent is not usually expected, because
> > > that's obvious.
> >=20
> >=20
> > "io-backends" is actually the way to refer to the backend module,
> > (used already for i.e. ad9739a),
> > it is needed because the backend is not only acting as spi-controller,
> > but is also providing some APIs for synchronization and bus setup suppo=
rt.
>=20
>=20
> But if backend is the parent, then this is redundant. You can take it
> from the child-parent relationship. Is this pointing to other devices
> (non-parent) in other ad3552r configurations?
>=20

The backend is a provider-consumer type of API. On the consumer side (which=
 is the
driver the child node will probe on), we need to call devm_iio_backend_get(=
) to get
the backend object (which obviously is the parent). For that, 'io-backends'=
 is being
used. We do have another API called __devm_iio_backend_get_from_fwnode_look=
up() that
could be used with the parent fwnode and should work. However that was only=
 added to
keep backward compatibility in the first user of the IIO backend framework =
and it's
not really meant to be used again. We are aware this is awkward at the very=
 least [1]
but hopefully still acceptable.

[1]: https://lore.kernel.org/linux-iio/20240903203935.358a1423@jic23-huawei=
/
- Nuno S=C3=A1

