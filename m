Return-Path: <linux-iio+bounces-14341-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 929EFA101E2
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 09:19:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CD983A7644
	for <lists+linux-iio@lfdr.de>; Tue, 14 Jan 2025 08:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB96924333D;
	Tue, 14 Jan 2025 08:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJxNVr8I"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EAF2343B6;
	Tue, 14 Jan 2025 08:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736842762; cv=none; b=GPy1Gp26vwEqtagYWFnKKMEk4mDDxeFxw7tBI7NFzEo0FGIvsz9iIXXsZ7XVAIgY96rL8Z7BZm9mNxC/Zl6H3KclAbkiAR02BslaOmgKAZuHw6k432Ghyy0Uor4mWzY5vhdWLtFAQ99108ltUS7VAqAPy8thYV7enArXamv4XTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736842762; c=relaxed/simple;
	bh=bikrOWAqC1i+P8t9ckTPqH7CKB6ZM6dowebuYFwUxfE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIyvdKMKDkl/+SqU1iTRhHgET79/0AriJt+ppc4alPjyJmFQARRcjxcwDXvI7PuwpErMyHbu6hFq9BvPNg19jFq2UJ0rRuKYE/VqGkONKhTe7g5ZD24+tSVVtKUM1WNmy5F0Gm8952Ft/bG3V0l0PoXk4SYqZZvcoRFplsi3pfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJxNVr8I; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3863494591bso2755138f8f.1;
        Tue, 14 Jan 2025 00:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736842759; x=1737447559; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bikrOWAqC1i+P8t9ckTPqH7CKB6ZM6dowebuYFwUxfE=;
        b=TJxNVr8II54M3ZibbijjsDLQp8XdGsqX1DrfCEZNbWPZNsN7sBjno0iAZItnAaKICI
         8QlF6KHJCCA6RupFPwkFsbwm8M/54PIZtN9P3Z/UtwQB07faIVCzEy19bdy7mH8TLumk
         Ny12qwhW3FKxVCxJ+silFnLAdRtZQ0K8rPdvB7ZPIkQKecLtjLO+vW9FUk7FSYygCZ6M
         kjdZqWgXQZtNaHvtpwUg2/gb6aHqCVVxH7s/L7k4VPGpIS9vJc9yTvIsJB4xaIepbB0K
         v4TT3+TQBNX/fWttrwP1C4Fax2kQpf2GaXRNceoRihDluR27m0eH3TE7ypAD1lOm6Hzh
         2HSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736842759; x=1737447559;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bikrOWAqC1i+P8t9ckTPqH7CKB6ZM6dowebuYFwUxfE=;
        b=SyMUuii9azY3uqvEZ8+zispLkgksyvrZJrvPO6/KZzjEw8ecjThes4V1tyW0F0yxDY
         6fsLUAL2yTDwlcDfAl+Gsqyf4XC1E8P1sa2nhI07AiXylhtWBhsSoZj9cPH5EQ/xWg+p
         kOfkT5Ag0bLZuVreyqREDtCKR11HrkIitcAmN5f8IYKnoaCOjannp61FpmZtmYPftrky
         r7djCQL2HXZMO89KCEqTvLaNGVCRhch/3HNN1X2bPIVEGtUT42M/12RbVi0NQKp6SsA3
         l7WDpMR4sloxksVgYVpdmRe+6eas45JeGnZRWeSwubv08cF2laiVCDXC69BMVSHWf/HR
         siRw==
X-Forwarded-Encrypted: i=1; AJvYcCUWKFc713KBg+4YA2ZpmRWq+2z4J2iGfbQQQyYHDAhyJddaSzHMjGgM6ptCdr7Pzd7KiXGCHgFdo6w8@vger.kernel.org, AJvYcCUz5sWE9KO91Vk3cULNJUOgI9trLy0xml+pmO5goFZnSQeQ2GGd+fCEv/BsROFtb9JJHL8ZhhlYlmsgMVMt@vger.kernel.org, AJvYcCWvjMEK260Hehut3EXa/s+6DSTsIbrrVY3UPjyGeko4OtdkFIfKRy5pIETSQOAkAfjH3wOWkT3zaAPi@vger.kernel.org, AJvYcCXqB82GGzXmkLNc3i/u8H1euatmDL+UGGH1Pts0ikgPsHl5K1/tBwCu46fpfm17SZuB+5UdZe/u2DIu@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/zCm6vU1x22oSN+CbyIsYDjvxQ91HI2wh3bAaClCkQzHnrEbD
	15YRXF8dY2+3/ZOr+g3TIk435VIHnUJlV8ly0k9Jme5knWJwTPmK
X-Gm-Gg: ASbGnctgujWaAqHMwNXKPUOhvcVWoGyUUFEapohPCg5b6g7d46V32Tp/s8VAKbuuq+8
	mUZc64GvChaezQYU/eCwSoTuy8/2HbPBzwgCJ2haaN2uDFUJ/3ijgnbULTFAFMANFfXdQFSVlZf
	C+DOiDo24BGTXEYTuUwOdtUnXlCgvfZarnXVz6K0ZtrKaz1jM7jjUd6+S+0+o+Sc9L2FcHaVi8J
	0cJgMBhCjOR0t++PNFmBCzKfXHkp/ywLmL9kkTmhRTGNcm/V9SrJY0HIGFyDdnw1DPvUwPQyZlZ
	LkWV2g09ARFCpm3c4olEt/35iA3k
X-Google-Smtp-Source: AGHT+IFEwtFMaeziLByVam0N5p11X8uRTgjhFOXabwC7pRfCSi5HfU758A//id0fUQ5xhCpoySmqQQ==
X-Received: by 2002:a5d:64cb:0:b0:385:ee40:2d88 with SMTP id ffacd0b85a97d-38a872d2a11mr21146494f8f.3.1736842758568;
        Tue, 14 Jan 2025 00:19:18 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e9df958dsm166267925e9.17.2025.01.14.00.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 00:19:18 -0800 (PST)
Message-ID: <f2565ff63e13af297d0af3be60ccdf9dbe517d18.camel@gmail.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Budai, Robert" <Robert.Budai@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: "Sa, Nuno" <Nuno.Sa@analog.com>, "Gradinariu, Ramona"	
 <Ramona.Gradinariu@analog.com>, "Miclaus, Antoniu"
 <Antoniu.Miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano	
 <lanzano.alex@gmail.com>, "linux-iio@vger.kernel.org"	
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"	
 <linux-doc@vger.kernel.org>
Date: Tue, 14 Jan 2025 08:19:17 +0000
In-Reply-To: <d9bc40ab79a24045ae9ff627ff5d302a@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
			<20250110074254.38966-5-robert.budai@analog.com>
		 <20250112154836.47feeea8@jic23-huawei>
	 <7a6290b673d8d9492418365392b2554e310ef557.camel@gmail.com>
	 <d9bc40ab79a24045ae9ff627ff5d302a@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-13 at 14:22 +0000, Budai, Robert wrote:
>=20
>=20
> > -----Original Message-----
> > From: Nuno S=C3=A1 <noname.nuno@gmail.com>
> > Sent: Monday, January 13, 2025 11:30 AM
> > To: Jonathan Cameron <jic23@kernel.org>; Budai, Robert
> > <Robert.Budai@analog.com>
> > Cc: Sa, Nuno <Nuno.Sa@analog.com>; Gradinariu, Ramona
> > <Ramona.Gradinariu@analog.com>; Miclaus, Antoniu
> > <Antoniu.Miclaus@analog.com>; Lars-Peter Clausen <lars@metafoo.de>;
> > Hennerich, Michael <Michael.Hennerich@analog.com>; Rob Herring
> > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Conor Dool=
ey
> > <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; Alex Lanzano
> > <lanzano.alex@gmail.com>; linux-iio@vger.kernel.org;
> > devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > doc@vger.kernel.org
> > Subject: Re: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
> >=20
> > [External]
> >=20
> > On Sun, 2025-01-12 at 15:48 +0000, Jonathan Cameron wrote:
> > > On Fri, 10 Jan 2025 09:42:52 +0200
> > > Robert Budai <robert.budai@analog.com> wrote:
> > >=20
> > > > Document the ADIS16550 device devicetree bindings.
> > > >=20
> > > > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > > > ---
> > > >=20
> > > > 4:
> > > > - applied styling changes to the bindings file
> > > > - restricted sync-mode to intervals 1-2
> > > >=20
> > > > =C2=A0.../bindings/iio/imu/adi,adis16550.yaml=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 96 +++++++++++++++++++
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 9 ++
> > > > =C2=A02 files changed, 105 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > >=20
> > > > diff --git
> > a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > new file mode 100644
> > > > index 000000000000..e7ccf3883e55
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > > > @@ -0,0 +1,96 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id:
> > https://urldefense.com/v3/__http://devicetree.org/schemas/iio/imu/adi,a=
dis
> > 16550.yaml*__;Iw!!A3Ni8CS0y2Y!74KHajr7iKZQ7Ld5deb4LytVFckO_Og8tIG
> > Ukf233OLregM6AqtN-v-IBRfAn-4Z1tC0bwbcEpNO7Glv8YjiXWI$
> > > > +$schema: https://urldefense.com/v3/__http://devicetree.org/meta-
> > schemas/core.yaml*__;Iw!!A3Ni8CS0y2Y!74KHajr7iKZQ7Ld5deb4LytVFckO_
> > Og8tIGUkf233OLregM6AqtN-v-IBRfAn-4Z1tC0bwbcEpNO7GlvNAV5ERI$
> > > > +
> > > > +title: Analog Devices ADIS16550 and similar IMUs
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > > > +=C2=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > > +=C2=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > > > +
> > > > +properties:
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550w
> > > > +
> > > > +=C2=A0 reg:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 spi-cpha: true
> > > > +
> > > > +=C2=A0 spi-cpol: true
> > > > +
> > > > +=C2=A0 spi-max-frequency:
> > > > +=C2=A0=C2=A0=C2=A0 maximum: 15000000
> > > > +
> > > > +=C2=A0 vdd-supply: true
> > > > +
> > > > +=C2=A0 interrupts:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 reset-gpios:
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RESET active low pin.
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +=C2=A0=C2=A0=C2=A0 description: If not provided, then the internal=
 clock is used.
> > > > +
> > > > +=C2=A0 adi,sync-mode:
> > > > +=C2=A0=C2=A0=C2=A0 description:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Configures the device SYNC pin. The=
 following modes are supported
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - output_sync
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 - direct_sync
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 - scaled_sync
> > >=20
> > > A little more on these would be good.=C2=A0 They are 'weird' options
> > > that are not commonly seen so help the reader out.
> > >=20
> > > For scaled_sync don't we need information on the scale for it to be
> > > useful?
> > > If we had that then a value of 1 would mean direct sync and wouldn't =
need
> > > another control.
> > >=20
> > > I'm not fully understanding the usecases for this.
> > >=20
> > > If we have a say a pulse per second input, the control of the scale s=
hould
> > > be userspace anyway.=C2=A0 So maybe this maps to the input clock that=
 we can
> > elect
> > > to
> > > use and control the effective frequency of by using scaled sync?
> >=20
> > I guess you likely already saw it in the driver. The scale value is
> > automatically set by the driver depending on the desired ODR (sampling
> > frequency).
> >=20
> > >=20
> > > I'm not sure what pulse sync is. Grepping the datasheet didn't give m=
e
> > > anything that seemed related.=C2=A0=C2=A0 The sync pin is input only =
so I'm also
> > > not sure on output sync.
> >=20
> > I think this is a copy paste from the adis16475 bindings. For this devi=
ce,
> > it
> > seems we only have:
> > =C2=A0* internal clock;
> > =C2=A0* external:
> > =C2=A0=C2=A0 * direct mode
> > =C2=A0=C2=A0 * scaled mode
> >=20
> > But yeah, as you pointed out I think we do not need the binding. The
> > presence
> > of
> > an optional input clock plus the frequency should be all we need in ord=
er to
> > set
> > the desired configuration. It should also be possible to add the allowe=
d
> > ranges
> > to the external input clock in the bindings...
> >=20
> >=20
> > - Nuno S=C3=A1
> >=20
> Will drop this binding than and add a frequency one that is dependent on =
clock
> with specified ranges.
>=20

Note I would not add a new binding if there's no standard one. My previous
comment can be misleading... I see there is a 'clock-frequency' property in=
 the
clock schema but descriptions says it's legacy and apparently for fixed-clo=
cks.
So maybe not suitable for this case?

- Nuno S=C3=A1

