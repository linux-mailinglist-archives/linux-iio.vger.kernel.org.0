Return-Path: <linux-iio+bounces-9955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8584398B6A2
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 10:19:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A89241C2215A
	for <lists+linux-iio@lfdr.de>; Tue,  1 Oct 2024 08:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51701199252;
	Tue,  1 Oct 2024 08:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIuS9brh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37A38396;
	Tue,  1 Oct 2024 08:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727770777; cv=none; b=gX9jNf+vJsLE+2wVgiIvR/V2gS0hUoNiVlZk8l3HCfbhh66cOnqtK1yBYV3hbr2yij62AgPDJYwfYEXX1hwVZpIsHsydaY489ygRmpHbuHutJZ/zKPTRPM7hh02ftZmKWrTFL1JkUgyRrWJv4P2WYXaokG6Pgu7FyxPO4m5q0hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727770777; c=relaxed/simple;
	bh=XA6A99rSA6GSg0PZseoUxHeLdsLZcW4xVNZ5+mfZTiI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WgLnfU9kv4AD8/tcBz9AOirnb/ewrl0syH78FbZV3kk8QMQm/vcM8aSIW/kMkMwvc0NSTtjr1ycaECKOG1MPDtg/VBlXIdipE5NgwqjdJolOL4pzM+l53WB5ZtHIcorWFFxadJ0SE7yAHnDfDagHDpTLxZMJBs91jPwhyOyNbMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIuS9brh; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-37ce9644daaso1366928f8f.3;
        Tue, 01 Oct 2024 01:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727770773; x=1728375573; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XA6A99rSA6GSg0PZseoUxHeLdsLZcW4xVNZ5+mfZTiI=;
        b=jIuS9brhX9oErQZMvWla5b0VJzcVBLr9RYFOfGLbbgN5l92OwYoEFdVRqatZQOBMI3
         9OUSdo1ZIDgbFHfVN8E1uTkR2eTFmIm6/6tO1wRQUCTM6SWuXz6vEOsuE0claVWKX299
         But4ffYRpAJT/ZkFXyarhoQZCE8ttSV8XfJYJ0czvV1ttXNT3bcLnnK/zusOwo7z1GM0
         5h5/NduCeCOsSntC5eLOSIylDbuXisO5V9CVLhAJVhpqIUxC9ABwldMA/Qp1dabzOQFX
         AL+mC6ErL9BCLFbGhYqiOshYWRStkGKIsb7Tgqtr3hIrdpbtTalqVjSEYsj/xHVz2cMn
         EVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727770773; x=1728375573;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XA6A99rSA6GSg0PZseoUxHeLdsLZcW4xVNZ5+mfZTiI=;
        b=RiV0Wsc/VzWMTVGAhOXFiWZgIN3NMNH0HIj3P/ZTH5wjnr3RlucaZMtoxqP06pO8x8
         pE6zAoOpUQWdNzk5LVVsRwag+4u2AVZaYSzs1ca6ics3/sWNRFQPTV82WsgAOmS9w/nb
         jBYyZeOhF8CDcSK0KiJkrZcBNM1SDjr6YrNTLO9w24fCEdh/7ewIpo810bIK4B8AHIPj
         w4F8qSyseYaP2ZmaomQxzK30jG5wKhA0xRtHdJu1DFjWaeKjwnUnjA8TTeszig1hrBZb
         70pL43DhG2iy1nsOx3rtR4NJ1Fl9alBTjxyohFK56YD07OP9G9+PRE6aIXsc1PPusEbw
         EMDw==
X-Forwarded-Encrypted: i=1; AJvYcCUcoGDmYIPo15byqg2g/jvPVz6V3WARLQA07Lhq3aW7OmjvOwaLwK2YOK1hYgb5ALdFDYGngvpSx1hD@vger.kernel.org, AJvYcCWMyfNoRLYG+1d0eT9WMzL0HsjOxXhghwhHWq3eU+0X/fxVT9DpYTswD9ttWyJLlIRL7kdd8m8zREkIk4m3@vger.kernel.org, AJvYcCXGiyJtdMQej2302RjwoPOgxj9G0+BFu9v5NgbeujWb9RxzwUpRr6cFkqFlF4Edeln9M/JBvG9vA8A+@vger.kernel.org
X-Gm-Message-State: AOJu0YzyAgX7eXgcHILutEfghDPJQoxNunD4ib0ERNWNEnVzu5VTmQwy
	g2wMhSRTA8NzWr65MRdGyuKLI8SBztLaoSsijxQAiVPFvJlagdbz
X-Google-Smtp-Source: AGHT+IHPaAQykWILDKDS/COzgf9TI4xu5EwcJN9fsfRV9aA7ymACMu7Roo/bfg7hKUHTJJKICoUOSw==
X-Received: by 2002:adf:efc3:0:b0:37c:d0b5:6c16 with SMTP id ffacd0b85a97d-37cd5aec965mr8390601f8f.46.1727770772775;
        Tue, 01 Oct 2024 01:19:32 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef02:2700:7684:3ff1:6790:3866? (p200300f6ef02270076843ff167903866.dip0.t-ipconnect.de. [2003:f6:ef02:2700:7684:3ff1:6790:3866])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37cd575de8fsm11140853f8f.116.2024.10.01.01.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 01:19:32 -0700 (PDT)
Message-ID: <80eb0949508d31a55f2b8ab999210a7c7cd5cbe2.camel@gmail.com>
Subject: Re: [PATCH v3 04/10] dt-bindings: iio: dac: ad3552r: add io-backend
 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski
 <krzk@kernel.org>,  Lars-Peter Clausen	 <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa	 <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	 <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Olivier Moysan	
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 dlechner@baylibre.com
Date: Tue, 01 Oct 2024 10:23:45 +0200
In-Reply-To: <20240930160947.00007c8a@Huawei.com>
References: 
	<20240919-wip-bl-ad3552r-axi-v0-iio-testing-v3-4-a17b9b3d05d9@baylibre.com>
		<gojq6ardhvt6vcs2kawdhdn2cj6qbpzp4p5mjjgwsypuatm5eo@3u6k4q7le46s>
		<418a8a9b-3bcf-4b8f-92a0-619a3bf26ab5@baylibre.com>
		<e8af0f3f-a09c-42d7-b8ca-dd633539af73@kernel.org>
		<0279203b6cd9f1312d9c03654c262c04ac12fbd9.camel@gmail.com>
		<fa27dc74-7b1f-4ef5-81dc-cc434da4ff89@kernel.org>
		<c721861809c17776c0fe89ead331b6e2e6b9d4b4.camel@gmail.com>
		<28834db1-3e9e-47f4-b00e-a548589d77e9@kernel.org>
		<20240929115919.0318034c@jic23-huawei>
		<ae4cfdfb9880e0a833c105fcb9e9442ef04f461b.camel@gmail.com>
		<h7ajn5c7f4d7xtjd6jwayen2v5go2vyciwfebikoxlnksodvd2@4dph5nxigi56>
	 <20240930160947.00007c8a@Huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-09-30 at 16:09 +0100, Jonathan Cameron wrote:
> On Mon, 30 Sep 2024 15:22:01 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > On 30.09.2024 09:20, Nuno S=C3=A1 wrote:
> > > On Sun, 2024-09-29 at 11:59 +0100, Jonathan Cameron wrote:=C2=A0=20
> > > > On Sat, 28 Sep 2024 14:20:29 +0200
> > > > Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > > > =C2=A0=20
> > > > > On 25/09/2024 13:55, Nuno S=C3=A1 wrote:=C2=A0=20
> > > > > > On Wed, 2024-09-25 at 09:22 +0200, Krzysztof Kozlowski wrote:=
=C2=A0=C2=A0=C2=A0=20
> > > > > > > On 24/09/2024 14:27, Nuno S=C3=A1 wrote:=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > On Tue, 2024-09-24 at 10:02 +0200, Krzysztof Kozlowski wrot=
e:=C2=A0=C2=A0=C2=A0
> > > > > > > > > On 23/09/2024 17:50, Angelo Dureghello wrote:=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > > > Hi Krzysztof,
> > > > > > > > > >=20
> > > > > > > > > > On 22/09/24 23:02, Krzysztof Kozlowski wrote:=C2=A0=C2=
=A0=C2=A0=20
> > > > > > > > > > > On Thu, Sep 19, 2024 at 11:20:00AM +0200, Angelo
> > > > > > > > > > > Dureghello
> > > > > > > > > > > wrote:=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > > > > > > > >=20
> > > > > > > > > > > > There is a version AXI DAC IP block (for FPGAs) tha=
t
> > > > > > > > > > > > provides
> > > > > > > > > > > > a physical bus for AD3552R and similar chips, and a=
cts
> > > > > > > > > > > > as
> > > > > > > > > > > > an SPI controller.
> > > > > > > > > > > >=20
> > > > > > > > > > > > For this case, the binding is modified to include s=
ome
> > > > > > > > > > > > additional properties.
> > > > > > > > > > > >=20
> > > > > > > > > > > > Signed-off-by: Angelo Dureghello
> > > > > > > > > > > > <adureghello@baylibre.com>
> > > > > > > > > > > > ---
> > > > > > > > > > > > =C2=A0 .../devicetree/bindings/iio/dac/adi,ad3552r.=
yaml=C2=A0=C2=A0 |
> > > > > > > > > > > > 42
> > > > > > > > > > > > ++++++++++++++++++++++
> > > > > > > > > > > > =C2=A0 1 file changed, 42 insertions(+)
> > > > > > > > > > > >=20
> > > > > > > > > > > > diff --git
> > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3=
552r.
> > > > > > > > > > > > yaml
> > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3=
552r.
> > > > > > > > > > > > yaml
> > > > > > > > > > > > index 41fe00034742..aca4a41c2633 100644
> > > > > > > > > > > > ---
> > > > > > > > > > > > a/Documentation/devicetree/bindings/iio/dac/adi,ad3=
552r.
> > > > > > > > > > > > yaml
> > > > > > > > > > > > +++
> > > > > > > > > > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad3=
552r.
> > > > > > > > > > > > yaml
> > > > > > > > > > > > @@ -60,6 +60,18 @@ properties:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 $ref: /schemas/types=
.yaml#/definitions/uint32
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum: [0, 1, 2, 3]
> > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > +=C2=A0 io-backends:
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: The iio backend re=
ference.
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 An example backend =
can be found at
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > > > > > https://analogdevicesinc.github.io/hdl/library/axi_=
ad3552r/index.html
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > > > > > > > > > +
> > > > > > > > > > > > +=C2=A0 adi,synchronous-mode:
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 description: Enable waiting for=
 external
> > > > > > > > > > > > synchronization
> > > > > > > > > > > > signal.
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Some AXI IP configu=
ration can implement a dual-IP
> > > > > > > > > > > > layout,
> > > > > > > > > > > > with
> > > > > > > > > > > > internal
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wirings for streami=
ng synchronization.
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 type: boolean
> > > > > > > > > > > > +
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 '#address-cells':
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const: 1
> > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > @@ -128,6 +140,7 @@ patternProperties:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 - custom-output-range-config
> > > > > > > > > > > > =C2=A0=20
> > > > > > > > > > > > =C2=A0 allOf:
> > > > > > > > > > > > +=C2=A0 - $ref: /schemas/spi/spi-peripheral-props.y=
aml#
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0 - if:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 properti=
es:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 compatible:
> > > > > > > > > > > > @@ -238,4 +251,33 @@ examples:
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 };
> > > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 };
> > > > > > > > > > > > +
> > > > > > > > > > > > +=C2=A0 - |
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0 axi_dac: spi@44a70000 {
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compati=
ble =3D "adi,axi-ad3552r";=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > That is either redundant or entire example should go =
to
> > > > > > > > > > > the
> > > > > > > > > > > parent
> > > > > > > > > > > node,
> > > > > > > > > > > if this device is fixed child of complex device (IOW,
> > > > > > > > > > > adi,ad3552r
> > > > > > > > > > > cannot
> > > > > > > > > > > be used outside of adi,axi-ad3552r).=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > > > >=20
> > > > > > > > > > ad3552r can still be used by a generic "classic" spi
> > > > > > > > > > controller (SCLK/CS/MISO) but at a slower samplerate, f=
pga
> > > > > > > > > > controller only (axi-ad3552r) can reach 33MUPS.=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > OK, then this is just redundant. Drop the node. Parent ex=
ample
> > > > > > > > > should
> > > > > > > > > contain the children, though.=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > =C2=A0=C2=A0=20
> > > > > > > > > > > =C2=A0=C2=A0=20
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 reg =3D=
 <0x44a70000 0x1000>;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dmas =
=3D <&dac_tx_dma 0>;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dma-nam=
es =3D "tx";
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #io-bac=
kend-cells =3D <0>;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 clocks =
=3D <&ref_clk>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #addres=
s-cells =3D <1>;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 #size-c=
ells =3D <0>;
> > > > > > > > > > > > +
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dac@0 {
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compatible =3D "adi,ad3552r";
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reg =3D <0>;
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 reset-gpios =3D <&gpio0 92 0>;=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > Use standard defines for GPIO flags.=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > > > >=20
> > > > > > > > > > fixed, thanks
> > > > > > > > > > =C2=A0=C2=A0=20
> > > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 io-backends =3D <&axi_dac>;=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > Why do you need to point to the parent? How much coup=
led
> > > > > > > > > > > are
> > > > > > > > > > > these
> > > > > > > > > > > devices? Child pointing to parent is not usually expe=
cted,
> > > > > > > > > > > because
> > > > > > > > > > > that's obvious.=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > >=20
> > > > > > > > > >=20
> > > > > > > > > > "io-backends" is actually the way to refer to the backe=
nd
> > > > > > > > > > module,
> > > > > > > > > > (used already for i.e. ad9739a),
> > > > > > > > > > it is needed because the backend is not only acting as =
spi-
> > > > > > > > > > controller,
> > > > > > > > > > but is also providing some APIs for synchronization and=
 bus
> > > > > > > > > > setup
> > > > > > > > > > support.=C2=A0=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > But if backend is the parent, then this is redundant. You=
 can
> > > > > > > > > take
> > > > > > > > > it
> > > > > > > > > from the child-parent relationship. Is this pointing to o=
ther
> > > > > > > > > devices
> > > > > > > > > (non-parent) in other ad3552r configurations?
> > > > > > > > > =C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > The backend is a provider-consumer type of API. On the cons=
umer
> > > > > > > > side
> > > > > > > > (which
> > > > > > > > is the
> > > > > > > > driver the child node will probe on), we need to call
> > > > > > > > devm_iio_backend_get()
> > > > > > > > to get
> > > > > > > > the backend object (which obviously is the parent). For tha=
t,
> > > > > > > > 'io-
> > > > > > > > backends'
> > > > > > > > is being=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > You described the driver, so how does it matter? Driver can c=
all
> > > > > > > get_backend_from_parent(), right? Or
> > > > > > > get_backend_from_fwnode(parent)?=C2=A0=C2=A0=C2=A0=20
> > > > > >=20
> > > > > > Well yes, just stating what the framework (also in terms of
> > > > > > bindings) is
> > > > > > expecting. Of course that on the driver side we can paper aroun=
d it
> > > > > > the
> > > > > > way we
> > > > > > want. But my main point was that we can only paper around it if=
 we
> > > > > > use
> > > > > > code that
> > > > > > is meant not to be used.
> > > > > >=20
> > > > > > And, FWIW, I was (trying) replying to your comment
> > > > > >=20
> > > > > > "You can take it from the child-parent relationship"
> > > > > >=20
> > > > > > Again, we can only do that by introducing new code or use code
> > > > > > that's not
> > > > > > meant
> > > > > > to be used. The way we're supposed to reference backends is by
> > > > > > explicitly
> > > > > > using
> > > > > > the proper FW property.
> > > > > >=20
> > > > > > Put it in another way and a completely hypothetical case. If we=
 have
> > > > > > a spi
> > > > > > controller which happens to export some clock and one of it's
> > > > > > peripherals
> > > > > > ends
> > > > > > up using that clock, wouldn't we still use 'clocks' to referenc=
e
> > > > > > that
> > > > > > clock?=C2=A0=C2=A0=C2=A0=20
> > > > >=20
> > > > > I asked how coupled are these devices. Never got the answer and y=
ou
> > > > > are
> > > > > reflecting with question. Depends. Please do not create hypotheti=
cal,
> > > > > generic scenarios and then apply them to your one particular oppo=
site
> > > > > case.=C2=A0=20
> > > >=20
> > > > I'll throw a possible clarifying question in here.=C2=A0 Could we u=
se this
> > > > device with a multimaster SPI setup such that the control is on a
> > > > conventional
> > > > SPI controller (maybe a qspi capable one), and the data plane only =
goes
> > > > through
> > > > a specific purpose backend?=C2=A0 If so, then they are not tightly =
coupled
> > > > and
> > > > the reference makes sense.=C2=A0 Putting it another way, the differ=
ence
> > > > between
> > > > this case and all the prior iio-backend bindings is the control and
> > > > dataplanes
> > > > use the same pins.=C2=A0 Does that have to be the case at the host =
end?=C2=A0 If
> > > > it
> > > > does,
> > > > then the reference isn't strictly needed and this becomes a bit lik=
e
> > > > registering a single device on an spi bus or an i2c bus depending o=
n who
> > > > does the registering (which is down to the parent in DT).
> > > > =C2=A0=20
> > >=20
> > > So, we currently have two drivers (with a new one being added in this
> > > series)
> > > for the same device:
> > >=20
> > > 1) A SPI one tied to a typical spi controller. This is the "low speed=
"
> > > implementation and does not use backends;
> > > 2) The new platform device that is connected like this to the backend=
.
> > >=20
> > > So yes, my understanding (but Angelo should know better :)) is that t=
hey
> > > are
> > > tightly coupled. Putting it in another way, the new platform device i=
s
> > > very much
> > > specific to this parent (and yeah, this is a very special usecase whe=
re
> > > control
> > > and data planes are controlled by the IIO backend) and should not exi=
st
> > > with it.=C2=A0=20
> >=20
> > ad3552r device can be coupled to the axi-ad3552r controller or to a gen=
eric=20
> > spi controler.
> >=20
> > We have actually 2 drivers, SPI and platform (for AXI controller, in th=
is
> > patch).
> >=20
> > Scenario 1 (SPI):
> > ad3522r can hypotetically work with whatever simple spi controller that=
 can
> > read/write registers in raw mode. On simple SPI (CS, SCLK, MOSI), due t=
o
> > ad3552r
> > chip limitation of 66Mhz clock, the maximum 33MUPS (16 bit samples) can=
not
> > be
> > reached. Some QSPI DDR controller seems to be around, in that case, ad3=
552r
> > may work extending the SPI driver.=20
> >=20
> > Scenario 2 (AXI):
> > From an hardware-only point ov view axi-ad3552r IP acts as QSPI+DDR
> > controller
> > plus some additional features for stream synchronization.
> > From a sowftware point of view, really different from a spi controller
> > driver.
> > It's just a backend with APIes that can be called from the child driver=
.
>=20
> Potential? scenario 3 is the one that interested me.
>=20
> ad3552 double wired to a normal SPI controller (so like option 1) and
> to a an offload engine (so like option 2).=C2=A0 With a few pull up resis=
tors
> (cs and clk?) and some care it should electrically work I think.
> In that case we'd need the io-backend reference because the parent
> would be the option 1 like SPI bus and the io-backend would not be
> the parent.
>=20
> _______________________
> Host=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |----=
---------------\
> hard=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|----------------\=
=C2=A0 |
> QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=A0 =
|--------------\=C2=A0 | |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI CS=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |----------\=C2=A0=C2=A0=C2=A0 | | |
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |
> FPGA=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 | | |=C2=A0=C2=A0 |
> Soft=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MOSI=C2=A0=C2=A0=C2=A0 |----=
-------|---|-|-x---|
> QSPI=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SPI MISO 0-3|-----------|---|-x-=
----|=C2=A0 DAC
> Offload=C2=A0=C2=A0=C2=A0 SPI CLK=C2=A0=C2=A0=C2=A0=C2=A0 |-----------|--=
-x-------|
> with DDR=C2=A0=C2=A0 SPI CS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |-----------x--=
---------|
> _______________________|
>=20
> Makes all sorts of assumptions about the SPI controllers being designed
> for multi controllers on the same SPI buses but I'm not aware of a reason
> you can't do that.
>=20
> As the only control message that would need to go over the offload engine
> would be the exit DDR (I think) that might be hard coded into a slightly
> simpler soft IP along with the bulk data transfer stuff.
>=20

Not even sure if DDR would be a problem. Right now, I __think__ we need to
enable DDR both the peripheral and on the backend. On the peripheral we cou=
ld
use the control link on the non offload controller. On the offload controll=
er,
we would set it through IIO backend and that would be a backend config and =
not
go over the bus.

To make a correction on my previous reply to Krzysztof, the HW folks made s=
ome
experiments with the SPI ENIGINE IP (with the offload engine) but without t=
he
AXI DAC IP. So, effectively only one controller in place. That said, I'm al=
so
not seeing any reason why something like the above would not be possible.

- Nuno S=C3=A1


