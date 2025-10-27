Return-Path: <linux-iio+bounces-25489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60319C0E928
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 15:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D6619C16A1
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13856296BB6;
	Mon, 27 Oct 2025 14:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoBKbX10"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BA9261581
	for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 14:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761576500; cv=none; b=c19hBdygZGqTCXwShNKrE1qtBU3Mt+Pg+kZH85RipLIB/N6k+cL6QxL2LQhRtrybe838uKmaPuDW+liQtN37+vu3Cln94ry2Y7uVJIM+awkEZwgPwNyn85sPX+CvMcn244aAnbMOEIFeTyet3IMLYdve4Nt7HiAjWyucOGuwY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761576500; c=relaxed/simple;
	bh=6/aYoUQSkAZbwd9+QXDbxqsqu7jMVd+14d65oZtGiZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h+3/K00aqc7l1bb4Z1yu6njsScMFll9biqVY/J1kRwFwK/MTJMSIWLrJchS+ZCfeYkLHyu1cG0drhu+YsouSkK7kjHmyJVF4Jb9egG8yG8qTYmKKuXbMKD8LoQZu5Jj53wU8DEaGA/kYrh5Mr0CqCyZoVse0dxii8OBOGB9IEwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoBKbX10; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso39465605e9.0
        for <linux-iio@vger.kernel.org>; Mon, 27 Oct 2025 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761576496; x=1762181296; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zygoCpzphFB2uhMNp3Gp2dYO9osLJcEQsz/2WuF2KM4=;
        b=PoBKbX10nxTlAlAIhheTtLczbbxI8XWVOpwYlV5JOh69C+GHeuEvPkFZDGqmPRrJwZ
         hFmFnmMIWozHTUH9hwZ2d0DjgsmYsxi2syEeMA/i1dUXTn0HumbP7gMLc565Ad/f6ytk
         vUdALicN2lca8yvkVpT3m3D+9QM+UZPno//3PbJtpCVxC0lINWVYig8b8An6e+JnfgFR
         abvNKj9hvQLZMIswoV3xNUJvEaYABWQdRwfrfMn9ny4HGEq9sk9PF3Cb+H1m1JTHXCuI
         VgEFn5+1lXZxF9K+N41RIE4pQdoSnBvQTyE248sqgOnYU5ZG84GD2sBwc1ulXi88+WrS
         rdpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761576496; x=1762181296;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zygoCpzphFB2uhMNp3Gp2dYO9osLJcEQsz/2WuF2KM4=;
        b=KOkdg+R5hZc8/BDxW+wL6frq38aaQOtZtun8fDromtx5ciSY2uYfsJPmmScD9ip4e/
         4gCw4Q/UGfYBWq/wxDtCJi+zypA1mVP5WnLqy1EVHBk8etgPtNlDZFqx8I5QKmLsVlVu
         WfXQ46b3k2ZOFKkPNZahsupfneJKrh7ovH+arWfBKQrFD6V7RKwJQsXB6WpIG5KwJ9o5
         q14lZB8OLjqIsdSByXsxjr1a1wDlnRuoui/l7VRf+jChGqbP+UPeWVWzG1UOXsUjIeoT
         0bCIUjGD1iq1bfkL1PXvZ9HANL20EI2Fn8LTqtHdZTBFSBQg7ogl4yR6UBLRz51ciGMi
         T+fA==
X-Forwarded-Encrypted: i=1; AJvYcCWAtCnR3vPQWM7B0RnlR466DaHCkeSR7uFXwzjfgifCONf2pBR9euHutjqLbY5CtEi5+HMNKzXDCRw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1UaCu6M9K7YeZ4XJjwBJ/iDQCXYEWn0xN5hGwGtr/LP+/iRuo
	tbzj7wzRGenlyoCPJt58zctkt4BV9cg7hZcMYTtRfbFlR9YD0lA92Xt/
X-Gm-Gg: ASbGncsgViO4AbyB5Yy9NKF1eXOmC5uHFAOcEE/cu69rdF9nUNbAj6DVe7Ib/pRCWnv
	yQ9b5rlLDhv1VCHyJDHLpXufwwT5MVlxBOPVNXVKhPa3gikMHxZxKiHN57RASmHe6hlqNZiGMtM
	TeuN2ud2dSNnXaB1mchAQy1BPLD6/e1UM55yRHGumMyVMFicXoOMXGyRvjlrRp3cNnDo+bI9It+
	vfWOkE4SvEtScBxtla/tfADs9/KypqwzrjplJUGQwSTHAzv/VMGyVeq2jsBrsUJu1qUpzJqp0ka
	L+AIx0Dr0jyldM7QL0NR4yHQ2KC+xBSQabcJIHWgS0zvmFD3nIGbw4VmDSYj2cg2g2wETd6lNqY
	ohGfpOlVobRPCC0SU5ubEIr/BLqqVWPlG4qyuqrE8TPiBEoST0BLJIM4igWiYP+66D7i+PcOy1w
	Sa96dkVfRTy1caePgf2BI=
X-Google-Smtp-Source: AGHT+IHXcznJ/RjVrwiQP8/NATnTGGZmftQnkk/PQ+IpbTShD+td5osO5VosOf0EXPa24mv6i1B5vA==
X-Received: by 2002:a05:600d:41cf:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-475d2ec5554mr88663125e9.21.1761576495991;
        Mon, 27 Oct 2025 07:48:15 -0700 (PDT)
Received: from [192.168.1.187] ([161.230.67.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475dd489fa4sm136341305e9.16.2025.10.27.07.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 07:48:15 -0700 (PDT)
Message-ID: <ffb2512aad9bec33b0fe27035f88e79636362645.camel@gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: dac: Document AD5446 and
 similar devices
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron
	 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Andy Shevchenko
	 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Date: Mon, 27 Oct 2025 14:48:50 +0000
In-Reply-To: <20251023180831.000026ca@huawei.com>
References: <20251023-ad5446-bindings-v2-0-27fab9891e86@analog.com>
		<20251023-ad5446-bindings-v2-1-27fab9891e86@analog.com>
	 <20251023180831.000026ca@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-10-23 at 18:08 +0100, Jonathan Cameron wrote:
> On Thu, 23 Oct 2025 14:01:37 +0300
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > Add device tree binding documentation for the Analog Devices AD5446
> > family of Digital-to-Analog Converters and compatible devices from
> > Texas Instruments. There's both SPI and I2C interfaces and feature
> > resolutions ranging from 8-bit to 16-bit.
> >=20
> > The binding covers 29 compatible devices including the AD5446 series,
> > AD5600 series, AD5620/5640/5660 variants with different voltage ranges,
> > and TI DAC081s101/DAC101s101/DAC121s101 devices.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Hi Nuno,
>=20
> Thanks for filling in this missing doc.=C2=A0 I wonder what else is old
> enough that we still don't have docs? Guess I should check when
> I'm next bored enough (so that's not happening any time soon ;)

Yeah, wouldn't be surprised if there's some more ADI old stuff hanging arou=
nd.
This caught my attention since I saw that out of tree patch adding support =
for a
new device (with no real reason for not being in tree).

>=20
> > ---
> > =C2=A0.../devicetree/bindings/iio/dac/adi,ad5446.yaml=C2=A0=C2=A0=C2=A0=
 | 138
> > +++++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 8 ++
> > =C2=A02 files changed, 146 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > new file mode 100644
> > index 000000000000..90fc8ca053fe
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > @@ -0,0 +1,138 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/dac/adi,ad5446.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices AD5446 and similar DACs
> > +
> > +maintainers:
> > +=C2=A0 - Michael Hennerich <michael.hennerich@analog.com>
> > +=C2=A0 - Nuno S=C3=A1 <nuno.sa@analog.com>
> > +
> > +description: |
>=20
> Trivial but don't need the | as hardly matters if these get formatted
> differently.

Sure.

>=20
> > +=C2=A0 Digital to Analog Converter devices supporting both SPI and I2C
> > interfaces.
> > +=C2=A0 These devices feature a range of resolutions from 8-bit to 16-b=
it.
>=20
> ...
>=20
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 940889b158eb..dae04c308975 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -440,6 +440,14 @@ W:	http://wiki.analog.com/AD5398
> > =C2=A0W:	https://ez.analog.com/linux-software-drivers
> > =C2=A0F:	drivers/regulator/ad5398.c
> > =C2=A0
> > +AD5456	DAC DRIVER
> Tab seems odd here.=20
>=20
> Hmm. For a lot of ADI drivers we have entries that would look like
> ANALOG DEVICES INC AD5456 DAC DRIVER
>=20
> Any reason for formatting it like this?

Ok, time to come clean :)

Bindings were AI generated and then I just cleaned the obvious problems (cl=
early
I did not payed too much attention to the boilerplate stuff - lesson learne=
d).

- Nuno S=C3=A1

>=20
> > +M:	Michael Hennerich <michael.hennerich@analog.com>
> > +M:	Nuno S=C3=A1 <nuno.sa@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	https://ez.analog.com/linux-software-drivers
> > +F:	Documentation/devicetree/bindings/iio/dac/adi,ad5446.yaml
> > +
> > =C2=A0AD714X CAPACITANCE TOUCH SENSOR DRIVER (AD7142/3/7/8/7A)
> > =C2=A0M:	Michael Hennerich <michael.hennerich@analog.com>
> > =C2=A0S:	Supported
> >=20

