Return-Path: <linux-iio+bounces-9910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E24EF989B2D
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 115161C213F9
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 07:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4451552F6;
	Mon, 30 Sep 2024 07:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UU/fka+z"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8FC1F5EA;
	Mon, 30 Sep 2024 07:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727680560; cv=none; b=ULm3u/KmZ7rhC0cRlYSu4dx8HedU0Vk3N5xeFTCXVfkA49u9J+G7TApFNmz6P0rhgeM3aO1LiASiZJssFp7Ob8igh7p/+zZtC2ehIBlkLC3YTN8jK3A1IU0gsE1F/y5PrierYr+F1QMXsI3XuAzquS76WeWiRCEaNUvD6XRyYnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727680560; c=relaxed/simple;
	bh=B8/OuAWEpPC+Vr2VWQQcSU+ANnCvOIvV+6sAeco9H1U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jt7Wzeopkos+mM7MquMZ0TLwMtCJx6ClhM8VJwZuWZAc76KMwQBhP11kg6FtfcC+BYj6b+axG2/QsdLcHvgGMwIiVk4pV8Y4anAW4V9Ngusrf9lXUDL0QI5tAXCDBK2Jz7GiB99WpRpkA0QAXbd4rM5nwebMo+8qf91HsHMOwdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UU/fka+z; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42cbb08a1a5so37165075e9.3;
        Mon, 30 Sep 2024 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727680557; x=1728285357; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=B8/OuAWEpPC+Vr2VWQQcSU+ANnCvOIvV+6sAeco9H1U=;
        b=UU/fka+zO6MUgCJGnGkMxczXE8admEYx3Qw9GeoeDo0zbmYHHF28IpPipCVkhSHySA
         HXkScIQ3Osruat7FJSe4FAVKQstvRj0a/s/ZNNoBXzWmBwRSpNi3sHapWU0kTMqBQrYj
         tPdTH2x7B2o2AzRAXtkS6xwh958gyFVyR92a7Zrj5goSIs0MUV8uo4EsPu+Phbso05i+
         MwHq4SQ3btxL3jq74+gofHH5SoRKbnUVUUa69o8dmsE4ZdF9UaU8MdIoJ/xIgyX8Duvz
         18yIAF0yv1/Z/e9q/6hAY/qSdJTiiakmgcLAbk5JD9E+Q8LmaU6hrCjwSlrBz4iHZZWL
         /WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727680557; x=1728285357;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B8/OuAWEpPC+Vr2VWQQcSU+ANnCvOIvV+6sAeco9H1U=;
        b=Q/uW8O0uXxZE3YZQoDqMwUL/m3keXb5OBBr0PEwQHli7q2uECpAkK7MVMYVxHaZm8Z
         dPH4CSYWaMnoZy7ALiG0JBJykavyIpR33CKZM45Mb+non7hhmAxo8x329UU36R+/+L3s
         N80LKitpFNzh4B02PRzQQovcFZObC9lIQgvyHu4+v7Z0iLxrNBmVcDtnAS/f6NoVAu2D
         uId8MSfmgw3A2UeaeLWn3JdB7fcMDxfweD5RAx1iPmeQEvzOTv9aUdBvrH5udkD24HOx
         Mo4rBs5l7HzyndvaeaSKBDo0THJXI6zJ5aCycf9AMIQQLQ7oYVxuL+5NV7tJErx+q/5w
         gbJA==
X-Forwarded-Encrypted: i=1; AJvYcCUo30nnn5KiUOW7hy0HEcthvKvbG3NE5oPIGQhnH+FFlSBgwgL2QWVYapcH60Vj8OtohOY6llNXnEaP@vger.kernel.org, AJvYcCUy2v0KF24jx1ijTs08FS2HX/ZzbxMHKxtokJcLm177s9uHVSMIqLI3yk5v8DpUAZ4mjNSXmV9+PLj/0XgM@vger.kernel.org, AJvYcCV0iLRU60hz3m6rLvSfbWkBG9OA6rbnrNTFre3vF4v8uXawOQTPs+yw3NrLCbwZhKZ6TUbXVB3lrKbD@vger.kernel.org
X-Gm-Message-State: AOJu0YxlOknFI/vbzzDb7rNFjG5kSVnjC6SU/1KwYbT9AZU/31vt0gmm
	+htQ7kz3CQl84KbzcRQRnUD7vY0aQma0yV5n9tkmJpCS1/MP7X1w
X-Google-Smtp-Source: AGHT+IGSeoqJJbatx5Jak6fSjaOniGi9abB/PCyKRdIPYEV8dYvBSu1I9ZurBD7HiZW7PngFSNqcGw==
X-Received: by 2002:a5d:65d1:0:b0:367:9d2c:95ea with SMTP id ffacd0b85a97d-37cd5b1de71mr6285946f8f.56.1727680556585;
        Mon, 30 Sep 2024 00:15:56 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd56e65e4sm8242329f8f.61.2024.09.30.00.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 00:15:56 -0700 (PDT)
Message-ID: <ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>
Cc: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen	
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa	 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Olivier Moysan	 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Date: Mon, 30 Sep 2024 09:20:08 +0200
In-Reply-To: <20240929115919.0318034c@jic23-huawei>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-0-a17b9b3d05d9@baylibre.com>
		<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
		<gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
		<418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
		<e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
		<0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
		<fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
		<c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
		<28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
	 <20240929115919.0318034c@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote:
> On Sat, 28 Sep 2024 14:20:29 +0200
> Krzysztof Kozlowski <krzk@kernel.org> wrote:
>=20
> > On 25/09/2024 13:55, Nuno S=C3=A1 wrote:
> > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:=C2=A0=
=20
> > > > On 24/09/2024 14:27, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrote:=C2=
=A0=20
> > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:=C2=A0=20
> > > > > > > Hi Krzysztof,
> > > > > > >=20
> > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:=C2=A0=20
> > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo Dureghello
> > > > > > > > wrote:=C2=A0=20
> > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > >=20
> > > > > > > > > There is a version AXI DAC IP block (for FPGAs) that prov=
ides
> > > > > > > > > a physical bus for AD3552R and similar chips, and acts as
> > > > > > > > > an SPI controller.
> > > > > > > > >=20
> > > > > > > > > For this case, the binding is modified to include some
> > > > > > > > > additional properties.
> > > > > > > > >=20
> > > > > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.co=
m>
> > > > > > > > > ---
> > > > > > > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552r.yaml=
=C2=A0=C2=A0 | 42
> > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > =C2=A0 1 file changed, 42 insertions(+)
> > > > > > > > >=20
> > > > > > > > > diff --git
> > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.y=
aml
> > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.y=
aml
> > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > ---
> > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.y=
aml
> > > > > > > > > +++
> > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3552r.y=
aml
> > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types.yaml#=
/definitions/uint32
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> > > > > > > > > =C2=A0=20
> > > > > > > > > +=C2=A0 io-backends:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: The iio backend referenc=
e.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backend can be=
 found at
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > https://analogdevicesinc.github.io/hdl/library/axi_ad3552=
r/index.html
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > > > > +
> > > > > > > > > +=C2=A0 adi,synchronous-mode:
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting for exter=
nal synchronization
> > > > > > > > > signal.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP configuration=
 can implement a dual-IP
> > > > > > > > > layout,
> > > > > > > > > with
> > > > > > > > > internal
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for streaming syn=
chronization.
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > > > > +
> > > > > > > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > > > > =C2=A0=20
> > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 - custom-output-range-config
> > > > > > > > > =C2=A0=20
> > > > > > > > > =C2=A0 allOf:
> > > > > > > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > > > > > > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
mpatible:
> > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > +
> > > > > > > > > +=C2=A0 - |
> > > > > > > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible =
=3D "adi,axi-ad3552r";=C2=A0=20
> > > > > > > > That is either redundant or entire example should go to the
> > > > > > > > parent
> > > > > > > > node,
> > > > > > > > if this device is fixed child of complex device (IOW,
> > > > > > > > adi,ad3552r
> > > > > > > > cannot
> > > > > > > > be used outside of adi,axi-ad3552r).=C2=A0=20
> > > > > > >=20
> > > > > > > ad3552r can still be used by a generic "classic" spi
> > > > > > > controller (SCLK/CS/MISO) but at a slower samplerate, fpga
> > > > > > > controller only (axi-ad3552r) can reach 33MUPS.=C2=A0=20
> > > > > >=20
> > > > > > OK, then this is just redundant. Drop the node. Parent example
> > > > > > should
> > > > > > contain the children, though.=C2=A0=20
> > > > > > > =C2=A0
> > > > > > > > =C2=A0
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D <0x44=
a70000 0x1000>;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =3D <&da=
c_tx_dma 0>;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-names =3D=
 "tx";
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-backend-c=
ells =3D <0>;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =3D <&=
ref_clk>;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #address-cell=
s =3D <1>;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-cells =
=3D <0>;
> > > > > > > > > +
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 reg =3D <0>;
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 0>;=C2=A0=20
> > > > > > > > Use standard defines for GPIO flags.=C2=A0=20
> > > > > > >=20
> > > > > > > fixed, thanks
> > > > > > > =C2=A0
> > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 io-backends =3D <&axi_dac>;=C2=A0=20
> > > > > > > > Why do you need to point to the parent? How much coupled ar=
e
> > > > > > > > these
> > > > > > > > devices? Child pointing to parent is not usually expected,
> > > > > > > > because
> > > > > > > > that's obvious.=C2=A0=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > "io-backends" is actually the way to refer to the backend mod=
ule,
> > > > > > > (used already for i.e. ad9739a),
> > > > > > > it is needed because the backend is not only acting as spi-
> > > > > > > controller,
> > > > > > > but is also providing some APIs for synchronization and bus s=
etup
> > > > > > > support.=C2=A0=20
> > > > > >=20
> > > > > >=20
> > > > > > But if backend is the parent, then this is redundant. You can t=
ake
> > > > > > it
> > > > > > from the child-parent relationship. Is this pointing to other
> > > > > > devices
> > > > > > (non-parent) in other ad3552r configurations?
> > > > > > =C2=A0
> > > > >=20
> > > > > The backend is a provider-consumer type of API. On the consumer s=
ide
> > > > > (which
> > > > > is the
> > > > > driver the child node will probe on), we need to call
> > > > > devm_iio_backend_get()
> > > > > to get
> > > > > the backend object (which obviously is the parent). For that, 'io=
-
> > > > > backends'
> > > > > is being=C2=A0=20
> > > >=20
> > > > You described the driver, so how does it matter? Driver can call
> > > > get_backend_from_parent(), right? Or get_backend_from_fwnode(parent=
)?=C2=A0=20
> > >=20
> > > Well yes, just stating what the framework (also in terms of bindings)=
 is
> > > expecting. Of course that on the driver side we can paper around it t=
he
> > > way we
> > > want. But my main point was that we can only paper around it if we us=
e
> > > code that
> > > is meant not to be used.
> > >=20
> > > And, FWIW, I was (trying) replying to your comment
> > >=20
> > > "You can take it from the child-parent relationship"
> > >=20
> > > Again, we can only do that by introducing new code or use code that's=
 not
> > > meant
> > > to be used. The way we're supposed to reference backends is by explic=
itly
> > > using
> > > the proper FW property.
> > >=20
> > > Put it in another way and a completely hypothetical case. If we have =
a spi
> > > controller which happens to export some clock and one of it's periphe=
rals
> > > ends
> > > up using that clock, wouldn't we still use 'clocks' to reference that
> > > clock?=C2=A0=20
> >=20
> > I asked how coupled are these devices. Never got the answer and you are
> > reflecting with question. Depends. Please do not create hypothetical,
> > generic scenarios and then apply them to your one particular opposite c=
ase.
>=20
> I'll throw a possible clarifying question in here.=C2=A0 Could we use thi=
s
> device with a multimaster SPI setup such that the control is on a convent=
ional
> SPI controller (maybe a qspi capable one), and the data plane only goes
> through
> a specific purpose backend?=C2=A0 If so, then they are not tightly couple=
d and
> the reference makes sense.=C2=A0 Putting it another way, the difference b=
etween
> this case and all the prior iio-backend bindings is the control and datap=
lanes
> use the same pins.=C2=A0 Does that have to be the case at the host end?=
=C2=A0 If it
> does,
> then the reference isn't strictly needed and this becomes a bit like
> registering a single device on an spi bus or an i2c bus depending on who
> does the registering (which is down to the parent in DT).
>=20

So, we currently have two drivers (with a new one being added in this serie=
s)
for the same device:

1) A SPI one tied to a typical spi controller. This is the "low speed"
implementation and does not use backends;
2) The new platform device that is connected like this to the backend.

So yes, my understanding (but Angelo should know better :)) is that they ar=
e
tightly coupled. Putting it in another way, the new platform device is very=
 much
specific to this parent (and yeah, this is a very special usecase where con=
trol
and data planes are controlled by the IIO backend) and should not exist wit=
h it.

- Nuno S=C3=A1


