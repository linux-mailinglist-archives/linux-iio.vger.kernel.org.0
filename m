Return-Path: <linux-iio+bounces-7526-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C65E092F5B7
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 08:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54716283563
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2024 06:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4243913D601;
	Fri, 12 Jul 2024 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7TKs2gb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40AC013B2A8;
	Fri, 12 Jul 2024 06:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720767190; cv=none; b=HzOw/gTt2W1dzKLQ2lSu4GIp498AXTXzFaLpwN5ikRePLTZtEfsN8UQoY5yDrY0AX57CyHIUPo2YCuTiLM/2y7xH11HBL4SQGQEjeG0p+hqyDkOSfL5QIJonRlDdLcPlRWmJc6GCiwWFLkhlE0ArB8ZSEDNPLUZ+huJjNCNcYz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720767190; c=relaxed/simple;
	bh=O5VBXpqJ+9U+4H7Q/wM6kgTXFMevkRjYnuE++Y3XvrE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iIHSCA9ubwx1NWxDX05MpWsmXQX2pas6OxnUVzSklKum3mVwfwN2d+PFyN22zmN0yh/Gf2ulh1wxZlWXtalnffSeyvxJLz1RM8nGu93KfoPpmDo24RScUVqxOBerOrnIMNyUSvDU6cykft/gAXIhJ4xv1xsDbRSZTkH6nLTUW1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e7TKs2gb; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a77d9217e6fso218701066b.2;
        Thu, 11 Jul 2024 23:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720767186; x=1721371986; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XXFbQXPtGb/+GNQzqGBVwiqUU8qK0zWwlp6dRJu4EPY=;
        b=e7TKs2gbGSc/Br9AcqK2VD8eTqvktVkyPprzFpXYKY3+cu1wsH5v+azVY/KSvplUXv
         WrWzYQjbV36JWIZOOCi8Y+0fgt489PJ272FR0i+EVk2hsl9Kj1bt9YwUvrUajgInrQY8
         vJVJb4vcXhY3g/kQHHJVBnUJNcCaqSLZ647rsPiKNXTHckjuu7D6G7+R73YqV7eXD/Ye
         3r0UwZldLgUZ/2rLrsctm5KHHBxiOO4rQZ3ul11GktT0uSv0sV68OmZNMI2rRQMEGDef
         5fzHeCHCp47JrZe0jIAv+UTHfdENVn0hJ7Jd5VcM5asJX2Vu+/bvpZaDf5S2eachBZM6
         hVFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720767186; x=1721371986;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XXFbQXPtGb/+GNQzqGBVwiqUU8qK0zWwlp6dRJu4EPY=;
        b=Sq4issAsTbqp+kjL/9B8Pq2ds3lYQ6zH31e5spVxguSpIBJf1zzmPiQcMz489LTTXK
         /wGmJcJxyZ8eHYfti/xMXeeXeOi0dcXWYjYnmUH5cQF/OYVYmou0XlD6pol/GjP56rmP
         2sfiQEv0JTAEtgnNE3zNitR9kLnrsr9kaQghuNXBzrkXCQgiVVQXtwEgG5frIfwNFU4W
         zWMnOGt2UDYZUcmt0BnlBQss/3mxQ4l64tTuXEySg/UW0U7KPX/7nq4w99m/2hgHqrwx
         6iq2G1G772uEwom5CSaBPcWbjckHJFCd5pprftwgnmhdsebJTZhO1/Bc5O4wRemp39Ul
         32XQ==
X-Forwarded-Encrypted: i=1; AJvYcCUS54gm/tPOFCCxx1+8WYPmRjsmyhJlWbcoIEEtX5TxRscQSIu3m4JRIZ0e5giZfijKsFRw37M3A+AKJf7eilnl57NtjQEiQ9iPkH9EP07RXBdvpFsbHORrWqs3RG92IF5aFvN3n1iuXLas7NXa1EutS4JeQowS6tD2mgow1Gmp2BWUww==
X-Gm-Message-State: AOJu0YzlFRrm6hnbnrVwsYBEpF7lxkkNSIuC/5SOQJzp8qP+XIMVvfE1
	aFxPlKWrCuYl0hpmaTRFZs35Iq1Vws0UDDgxAXaExx4ePmvJ9sw0
X-Google-Smtp-Source: AGHT+IFCJKh4sLArYjTnbB0nGhUrzlB2tvngFTC7NTzAQMeZzbab4y1gGt01y8cztsXxNaiOErShrQ==
X-Received: by 2002:a17:906:3c1a:b0:a77:cd4f:e4ef with SMTP id a640c23a62f3a-a780b89f428mr652622866b.63.1720767186147;
        Thu, 11 Jul 2024 23:53:06 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a86f636sm315628666b.208.2024.07.11.23.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 23:53:05 -0700 (PDT)
Message-ID: <468b5725d0f191c20ada9524ecb7da8a48d56d97.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
	 <Jonathan.Cameron@Huawei.com>, "Tinaco, Mariel" <Mariel.Tinaco@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>, "Hennerich, Michael"
 <Michael.Hennerich@analog.com>,  Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>, Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>, Nuno Sa <nuno.sa@analog.com>
Date: Fri, 12 Jul 2024 08:57:00 +0200
In-Reply-To: <733f4f7b-53b2-46c1-8bf8-5ed357adab30@baylibre.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	 <20240510064053.278257-3-Mariel.Tinaco@analog.com>
	 <20240511174405.10d7fce8@jic23-huawei>
	 <SJ0PR03MB62241801F72B21EEC9CDCCBD91D42@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240628194546.2f608365@jic23-huawei>
	 <SJ0PR03MB62246270CC24E70732D0288F91DA2@SJ0PR03MB6224.namprd03.prod.outlook.com>
	 <20240708170504.00006c9d@Huawei.com>
	 <ccce603d36fa2fd590b563955bcd2cda085773e5.camel@gmail.com>
	 <733f4f7b-53b2-46c1-8bf8-5ed357adab30@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-11 at 16:31 -0500, David Lechner wrote:
> On 7/11/24 4:20 AM, Nuno S=C3=A1 wrote:
> > On Mon, 2024-07-08 at 17:05 +0100, Jonathan Cameron wrote:
> > > On Mon, 8 Jul 2024 05:17:55 +0000
> > > "Tinaco, Mariel" <Mariel.Tinaco@analog.com> wrote:
> > >=20
> > > > > -----Original Message-----
> > > > > From: Jonathan Cameron <jic23@kernel.org>
> > > > > Sent: Saturday, June 29, 2024 2:46 AM
> > > > > To: Tinaco, Mariel <Mariel.Tinaco@analog.com>
> > > > > Cc: linux-iio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > > > > kernel@vger.kernel.org; Lars-Peter Clausen <lars@metafoo.de>; Rob
> > > > > Herring
> > > > > <robh@kernel.org>; Krzysztof Kozlowski <krzk+dt@kernel.org>; Cono=
r
> > > > > Dooley
> > > > > <conor+dt@kernel.org>; Liam Girdwood <lgirdwood@gmail.com>; Mark =
Brown
> > > > > <broonie@kernel.org>; Hennerich, Michael
> > > > > <Michael.Hennerich@analog.com>;
> > > > > Marcelo Schmitt <marcelo.schmitt1@gmail.com>; Dimitri Fedrau
> > > > > <dima.fedrau@gmail.com>; Guenter Roeck <linux@roeck-us.net>
> > > > > Subject: Re: [PATCH 2/2] iio: dac: support the ad8460 Waveform DA=
C
> > > > >=20
> > > > > [External]
> > > > > =C2=A0=20
> > > > > > > > +};
> > > > > > > > +
> > > > > > > > +static int ad8460_get_powerdown_mode(struct iio_dev *indio=
_dev,
> > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 const struct iio_chan_spec
> > > > > > > > *chan) {
> > > > > > > > +	return 0;=C2=A0=20
> > > > > > >=20
> > > > > > > Why have the stubs in here?=C2=A0=20
> > > > > >=20
> > > > > > Should I move the stubs to a different place in the code or rem=
ove
> > > > > > them altogether since there is only a single powerdown mode
> > > > > > available=C2=A0=20
> > > > > Ah. I'd not really understood what was going on here.=C2=A0 This =
is fine as
> > > > > is.
> > > > > =C2=A0=20
> > > > > > > AD8460_HVDAC_DATA_WORD_HIGH(index),=C2=A0=20
> > > > > > > > +			=C2=A0=C2=A0=C2=A0 ((val >> 8) & 0xFF));=C2=A0=20
> > > > > > >=20
> > > > > > > bulk write? or do these need to be ordered?=C2=A0=20
> > > > > >=20
> > > > > > For this I used bulk read/write this way.
> > > > > >=20
> > > > > > static int ad8460_set_hvdac_word(struct ad8460_state *state,
> > > > > > 				 int index,
> > > > > > 				 int val)
> > > > > > {
> > > > > > 	u8 regvals[AD8460_DATA_BYTE_WORD_LENGTH];=C2=A0=20
> > > > > regmap bulk accesses (when spi anyway) should be provided with DM=
A
> > > > > safe
> > > > > buffers.
> > > > > Easiest way to do that is add one with __aligned(IIO_DMA_MINALIGN=
) to
> > > > > the
> > > > > end of the ad8460_state structure.=C2=A0 Possibly you'll need a l=
ock to
> > > > > protect it -
> > > > > I
> > > > > haven't checked.=C2=A0=20
> > > > > >=20
> > > > > > 	regvals[0] =3D val & 0xFF;
> > > > > > 	regvals[1] =3D (val >> 8) & 0xFF;=C2=A0=20
> > > > >=20
> > > > > That is an endian conversion so use appropriate endian function t=
o
> > > > > fill it
> > > > > efficiently and document clearly what is going on.
> > > > >=20
> > > > >=20
> > > > > 	put_unaligned_le16()
> > > > > =C2=A0=20
> > > > > >=20
> > > > > > 	return regmap_bulk_write(state->regmap,=C2=A0=20
> > > > > AD8460_HVDAC_DATA_WORD_LOW(index),=C2=A0=20
> > > > > > 				 regvals,=C2=A0=20
> > > > > AD8460_DATA_BYTE_WORD_LENGTH); }=C2=A0=20
> > > > > >=20
> > > > > > =C2=A0
> > > > > > > > +}=C2=A0=20
> > > > > =C2=A0=20
> > > > > > > > +	state->regmap =3D devm_regmap_init_spi(spi,
> > > > > > > > &ad8460_regmap_config);
> > > > > > > > +	if (IS_ERR(state->regmap))
> > > > > > > > +		return dev_err_probe(&spi->dev, PTR_ERR(state-
> > > > > > > > >regmap),
> > > > > > > > +				=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to initialize
> > > > > > > > regmap");
> > > > > > > > +
> > > > > > > > +	ret =3D devm_iio_dmaengine_buffer_setup_ext(&spi->dev,
> > > > > > > > indio_dev,
> > > > > > > > +"tx",
> > > > > > > > +=C2=A0=20
> > > > > > > IIO_BUFFER_DIRECTION_OUT);
> > > > > > >=20
> > > > > > > Ah. I take back my binding comment. I assume this is mapping =
some
> > > > > > > non standard interface for the parallel data flow?=C2=A0=20
> > > > > >=20
> > > > > > Yes, the HDL side doesn't follow yet the standard IIO backend f=
rom
> > > > > > which this driver was tested=C2=A0=20
> > > > >=20
> > > > > Hmm. I'd like to see this brought inline with the other iio backe=
nd
> > > > > drivers if
> > > > > possible.=C2=A0=20
> > > >=20
> > > > Does this mean that we would need to implement an AXI IP core on th=
e
> > > > FPGA side to be able to test this?
> > >=20
> > > Don't think so.=C2=A0 That framework is meant to support any equivale=
nt IP.
> > > So whatever you have should be supportable. Maybe it's somewhat of a =
stub
> > > driver though if there isn't anything controllable.
> > >=20
> > > It's Nuno's area of expertise though +CC.
> > >=20
> >=20
> > Hi Jonathan,
> >=20
> > Yeah, I did reply David (IIRC) about the very same question. In the
> > design/HW Mariel
> > is working on the DAC is directly connected to the DMA core which is ha=
ndled
> > already
> > by a proper dma controller driver. So in this case I'm really not seein=
g the
> > backend
> > need right now (maybe in the future we may have another design for this
> > device that
> > could justify for a backend device but no idea on that).
> >=20
> > As you mention, we could very well do a stub platform driver so we can =
use
> > the
> > backend framework (like dma-backend or something) that could pretty muc=
h be
> > a stub
> > for the DMA controller. But is it worth it though? We'd actually be "ly=
ing"
> > in terms
> > of HW description as the DMA is a property of the actual converter.
> >=20
> > - Nuno S=C3=A1
> >=20
> >=20
>=20
> I'm a bit inclined to agree with Jonathan here. I could see someone in th=
e
> future,
> wanting to, e.g., use DMA + a GPIO controller for the parallel interface =
if
> they
> didn't have an FPGA. So it seems a bit more future-proof to just always u=
se
> the
> IIO backend framework for the parallel interface.

I do agree it's more future but guessing usecases is not something I tend t=
o
like much (often just results in code that never gets __really__ used). We =
can
very well take care of it when a usecase pops up and we have an actual devi=
ce
that can be represented by a backend :).

>=20
> FWIW, I don't think it would be "lying" since the io-backend DT node woul=
d be
> representing physical parallel bus between the DMA controller and the ADC
> chip.

To me, it's really a stretch having a backend with the only reason (op) of
requesting the DMA channel. I still think you're pushing to much and going
around with wording to justify for the DMA property :). The parallel bus is=
 part
of the DAC and directly connects to the DMA data lines so it really looks t=
o me
the dma is a property of the actual DAC.

That said and Mariel can help here, I did not really looked into the design
myself and I'm just stating (or what I understood) what Mariel told me. But=
 if
there's some other piece of HW sitting between the DMA and the bus then it =
would
be easier for me to agree even if we don't have any real control over that
device.

> But if DT maintainers are OK with the idea that a DMA channel can be dire=
ctly
> wired to an external chip, I guess I won't complain. :-)

That's the case in here so I don't see why it should be a problem :). It's =
the
same with the axi-dac/adc. It's all inside the FPGA but different cores/IPS=
.

FWIW, I'm ok if we go the backend direction even if I don't fully agree wit=
h it
(at least with the understanding I have so far about the design). I definit=
ely
want to see more users of it but I also don't think it should be a rule for=
 any
fairly high speed converter to have a backend associated.

- Nuno S=C3=A1


