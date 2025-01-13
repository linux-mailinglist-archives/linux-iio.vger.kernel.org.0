Return-Path: <linux-iio+bounces-14264-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C006A0B2C8
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 10:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDD667A0FBF
	for <lists+linux-iio@lfdr.de>; Mon, 13 Jan 2025 09:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970F12397BF;
	Mon, 13 Jan 2025 09:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tj+vE0u/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3EE14A09C;
	Mon, 13 Jan 2025 09:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760589; cv=none; b=u4Bt82l3d90B+KXKqnkWNkZbMDZ/GHuuYFCn2032dk+EFm4BtDvoGOAEITZb2MwrzlxkCZehw/1CEMUkP/Ppc/01yaWwQfazPEL/LycgO5M0gf5L7PeBcdKh7vDzhLtlJLCSl/MpKERPKVJolsL2Su1N/CBq6Ch6YK6PldFkMQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760589; c=relaxed/simple;
	bh=uuhhoIuboHPWhczc/6YMTwUy8feTwWUv8uqp0LqwNug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QcpyEe7MHYUnB0j9fdugow2tz3j7ZGg/X4PUG9qB6eb+gA0dUahmonBDtHCwk5rNeV6iYv1DEL33LkJJbM/IGqse+KsdQ3MP4ED+ROFPVejTR05msGJ0MTeN5rV/dqVAzGbad3K5IZdLs5VSkXgcXaopThCpzuwzPF8srUbzv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tj+vE0u/; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-436202dd730so28277245e9.2;
        Mon, 13 Jan 2025 01:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736760586; x=1737365386; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=p0cX2s6y1CpgFWbk714th6XfIo828EXlRRcCeLbR80U=;
        b=Tj+vE0u/BCHN6XFw8nryqIakkZsFvGuh2x/Z0isolFf6PBREwK9zirag9Q9PGi4rYI
         n8Idai5GsSW9OTD3KHg0lN9iFSNR71cLpuT7qzyRrb2NR1UIXFU92j/IXMpRakrGpd9L
         l8/wPBM8Qlk8HfBswJ7isMtRT3pp075bQVGWFczZlk7tvKj9g4K2po8Hpl9lVBF8pHgb
         kFWEMghtct74icFFKsJOAipSg/Q86/rg4TC9B/BAUSsouQAVDt6k8a+KKKhS5LDz4wGo
         zJBK9S0O+tgPwrCuAVgnoZHqZtGVowvNS+0d5P/YK6u1Jx/zlria2MIwQlY36AsIwgTB
         bE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736760586; x=1737365386;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p0cX2s6y1CpgFWbk714th6XfIo828EXlRRcCeLbR80U=;
        b=tGaRK9MWTwoSo0hms5c4Ig+JpAkCXDdXP9/BSCQPtSTBWVM/lZTJq+qxkNq5wqaaIq
         8WcnMbO0CrA/bDNLXCbOX1u/GQRKikFLPjmwlJ6WgN7qEv+KHxIClo/LdtfzJbEVWmg3
         CSa5cHGgl1g4u5/2EBdkXyogk8n4FUhoa84//nUfyqlK52RiqxW/fz4GF3x9evH745yq
         HK08ON3rwHyF533ZBIgESnb8QFq4TNY+vNJmfzZi08/Q3ZD8DI/fYkpJ/6woBvYkV9wc
         RwRf+JfmUCk2OwaD6nK+6kkBeA/lYU63LTWG/sfOzjWIrxKYqgeRAjChBKKm83jT79sQ
         EK5A==
X-Forwarded-Encrypted: i=1; AJvYcCUlUVUHzEuwFlwxfHGBqyToJuHKY3GhhudRyMGJEFseWJi0qmzFMfdjv9XLWC4tXTBa7KKZm5WPpEtZ@vger.kernel.org, AJvYcCVBmMCpGFYUi1m2PJBu6t8BUnAr46CGzIKg7xuHwNrxVDPCFnpxdbgNCuYzmBq9xewaz3+DrDYNEK/uDNaG@vger.kernel.org, AJvYcCW28XHV7WYNjDUE1EKha1UItkQgtgaRZGIFMfKTvjz2wys0/85ePoJUpOCIzGPRyXbnzh3MQJr0jisz@vger.kernel.org, AJvYcCX3NbDV7pa5g/GucaXiSNbzdR/Jf9Kg5Pfsevf8EYz2X+5qVTJzsQI+7dLwXaSG4avTIYh4xja5w4/3@vger.kernel.org
X-Gm-Message-State: AOJu0YxS54j98LhwHqDDGO3WxFyrNCI09g05zUYArgaGq3YHfC4/wy/I
	zGLrrlcDhIEreV5jAA8mbjHr9MPP8SXqSLAzAaQrf7AKjO5FqYde
X-Gm-Gg: ASbGncv+f9pH8YTRdscZ2U/y0qG8PHn12z+TFBuHsnWIKfo79iAXA1BOeoBzm5DAxia
	RZ1JCM4iLfWWpyevKuRUe+0pv1JD6qFmmvbYen0O/cFrZPFk0Z09ZlyiwWF5emJ1wCfMOofm0OF
	IZVYTCSG1TcGZW4zdbvlkJ8B/eNUSn7ezOw96YDn4SZA5mZRKQOsKQlJ7bBpFHj+vt7NywbW8s5
	h71E7Nl048/GZbPH1VykZCLYuCHqVpnizCua9S0BDPNL8UlrUTpov8H9DMpseq2SUDnAtchEQXi
	joKKnA7S7R2tD25aQZUjNhimM8m1
X-Google-Smtp-Source: AGHT+IEi6E132aBc5zotFnSPKgF4a2PYwlIZFpppWVMgdMhRO0HF+t4W3CnCbYcOa6CRz1H7P7+qPA==
X-Received: by 2002:a05:6000:2a3:b0:388:e2a6:ba81 with SMTP id ffacd0b85a97d-38a87355917mr17953620f8f.47.1736760585678;
        Mon, 13 Jan 2025 01:29:45 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2df2faesm172831695e9.26.2025.01.13.01.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 01:29:45 -0800 (PST)
Message-ID: <7a6290b673d8d9492418365392b2554e310ef557.camel@gmail.com>
Subject: Re: [PATCH v4 4/6] dt-bindings: iio: Add adis16550 bindings
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Robert Budai
 <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu	
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>,  Lars-Peter Clausen	 <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley	
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano	
 <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Date: Mon, 13 Jan 2025 09:29:44 +0000
In-Reply-To: <20250112154836.47feeea8@jic23-huawei>
References: <20250110074254.38966-1-robert.budai@analog.com>
		<20250110074254.38966-5-robert.budai@analog.com>
	 <20250112154836.47feeea8@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2025-01-12 at 15:48 +0000, Jonathan Cameron wrote:
> On Fri, 10 Jan 2025 09:42:52 +0200
> Robert Budai <robert.budai@analog.com> wrote:
>=20
> > Document the ADIS16550 device devicetree bindings.
> >=20
> > Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > Signed-off-by: Robert Budai <robert.budai@analog.com>
> > ---
> >=20
> > 4:
> > - applied styling changes to the bindings file
> > - restricted sync-mode to intervals 1-2=20
> >=20
> > =C2=A0.../bindings/iio/imu/adi,adis16550.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 96 +++++++++++++++++++
> > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 9 ++
> > =C2=A02 files changed, 105 insertions(+)
> > =C2=A0create mode 100644
> > Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/adi,adis16550.ya=
ml
> > b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > new file mode 100644
> > index 000000000000..e7ccf3883e55
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/imu/adi,adis16550.yaml
> > @@ -0,0 +1,96 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/imu/adi,adis16550.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices ADIS16550 and similar IMUs
> > +
> > +maintainers:
> > +=C2=A0 - Nuno Sa <nuno.sa@analog.com>
> > +=C2=A0 - Ramona Gradinariu <ramona.gradinariu@analog.com>
> > +=C2=A0 - Antoniu Miclaus <antoniu.miclaus@analog.com>
> > +
> > +properties:
> > +=C2=A0 compatible:
> > +=C2=A0=C2=A0=C2=A0 enum:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,adis16550w
> > +
> > +=C2=A0 reg:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 spi-cpha: true
> > +
> > +=C2=A0 spi-cpol: true
> > +
> > +=C2=A0 spi-max-frequency:
> > +=C2=A0=C2=A0=C2=A0 maximum: 15000000
> > +
> > +=C2=A0 vdd-supply: true
> > +
> > +=C2=A0 interrupts:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 reset-gpios:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RESET active low pin.
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > +=C2=A0 clocks:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +=C2=A0=C2=A0=C2=A0 description: If not provided, then the internal clo=
ck is used.
> > +
> > +=C2=A0 adi,sync-mode:
> > +=C2=A0=C2=A0=C2=A0 description:
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Configures the device SYNC pin. The fol=
lowing modes are supported
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 - output_sync
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1 - direct_sync
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 2 - scaled_sync
>=20
> A little more on these would be good.=C2=A0 They are 'weird' options
> that are not commonly seen so help the reader out.
>=20
> For scaled_sync don't we need information on the scale for it to be usefu=
l?
> If we had that then a value of 1 would mean direct sync and wouldn't need
> another control.=20
>=20
> I'm not fully understanding the usecases for this.
>=20
> If we have a say a pulse per second input, the control of the scale shoul=
d
> be userspace anyway.=C2=A0 So maybe this maps to the input clock that we =
can elect
> to
> use and control the effective frequency of by using scaled sync?

I guess you likely already saw it in the driver. The scale value is
automatically set by the driver depending on the desired ODR (sampling
frequency).

>=20
> I'm not sure what pulse sync is. Grepping the datasheet didn't give me
> anything that seemed related.=C2=A0=C2=A0 The sync pin is input only so I=
'm also
> not sure on output sync.

I think this is a copy paste from the adis16475 bindings. For this device, =
it
seems we only have:
 * internal clock;
 * external:
   * direct mode
   * scaled mode

But yeah, as you pointed out I think we do not need the binding. The presen=
ce of
an optional input clock plus the frequency should be all we need in order t=
o set
the desired configuration. It should also be possible to add the allowed ra=
nges
to the external input clock in the bindings...


- Nuno S=C3=A1



