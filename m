Return-Path: <linux-iio+bounces-9230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A0196E98F
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D36A1F21518
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 05:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D81213699A;
	Fri,  6 Sep 2024 05:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBFgchSX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D93583A18;
	Fri,  6 Sep 2024 05:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725602071; cv=none; b=ZbKSmKu/b+blQYVSTNfXeJdtY5vsMt22xe+d+UeVXBoz8sPYGQOvkSEMTqgFVKs3xZk8IuGArk+jsVvZZan84jR9PxxbSMlle3c6O4AZLHrXKK4gZQqaUUO6+npUbqmQRyIf39ZcS0Sd8NMZbS9aHWhHjhv2lztBrFey7hK1EL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725602071; c=relaxed/simple;
	bh=K2Y32KYVhPONhkVtEmmllVKVoRhbx6py85QnU9RQD5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gxS5H3MiANPJ9xA1/rwHnx7lLL8QQsDfHMHaGSKx8tVl3s3jLPC+2jqgA0pk7RhqaZHEAHKeBklHi23wnO/6DxPx/VJBCQ75NFLhAUlt50bbnFOp0oBm07usTFauP6+dXkWNbeILMAr3wYpYQIYGzAtg/q7tOoVyHi1zShIG4+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBFgchSX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-42c5347b2f7so12864145e9.0;
        Thu, 05 Sep 2024 22:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725602067; x=1726206867; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IZLDQQOflzMEcjpdfYHCE6+0ZkcrCr/HOGDgSJ5EE0Q=;
        b=iBFgchSXgziPFqm779PdGZQsmKbBbreVOi8GNsioK6FUhrjv6UKqUknuhkRtu2NKul
         nj3LAYaG63D9eLM5WaCgxSLy4CDtGg0I1flrd/LcC3Hx3EGbgUhteapdr6mSgQ+73qBi
         4KKX7r+kEo0fdTA+oup21JoL2o0i1LtITEJe2KpxcJzEQEZ/mirNkuYDhh2eUjOjHMVm
         jk54NFTfY9IVogowr+iwycryasyDu34P6Tr7qsS789+4rFEeH80KdnH7xnw7DpsP8a4t
         eGwxzr+2n1HSn9A4Dx4T0C/4CYb9fthY/nfWHu1QCZlp97Oya+panAh+LW+gSxMoaXuk
         a7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725602067; x=1726206867;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IZLDQQOflzMEcjpdfYHCE6+0ZkcrCr/HOGDgSJ5EE0Q=;
        b=XBAA0tk0R6T3BE49TOPL7ZH3qTMFTLBWPZ/L9lICv+qvGQkxvUyuj/0z55ghtrHiCE
         8p6Io+5Wu3dpwZFL9oiROh9rVd9AtNlDassvh/H+dQVms9wG//Qrzp46qbbSlSr5xPe2
         xRSBaei4/tY6Iklc9Y+Qro+b5MUNQIYUnTUJ8E6TYFDZVdDH8kBa6V4E5RobwdNRyFP2
         /qZnP9YrFm0QWwOPGspktiAdgHD0nScQC09m1v8N366p99gNgBBIfsjqyozp+CXtaMro
         0uW2ZRMzo7QpMEWqR6EftkFakYZN7/HBs+F8qUqRdDM+lkwUGngS/E7g6+jOO8KFKQ4J
         GsQg==
X-Forwarded-Encrypted: i=1; AJvYcCW4tLnRsEVgxV+m2CCaWvBtQUwx+nwjvCbjriO74EoTEYVG5BIs9rNlaX6hdKHvDHMfNoc4/TMf3DMk@vger.kernel.org, AJvYcCWw2vFQOE+hwmP35b9LTj7fOp6uK+HeBQHsT87mXDdB3PA8G8oR78vD7SHHav7RyUodQL3sPiE/ZZrNxA9M@vger.kernel.org, AJvYcCXQe6K06v5b4tqNNKd9cnvB1aAaMWTcvLLzWfgzyhgsNJzkQbTrARuExd18RylqHkn+mWWd2oetyid1@vger.kernel.org
X-Gm-Message-State: AOJu0YzSVZ9OyTp+ft9iUSrzhpvsms1KAMb07N03Vz+1wYTFyqT/0ZL0
	oy+LRlAwpavdS8xet8h13sG9RTswMC/bjr4hlbLyNRnQUBrPn6R4
X-Google-Smtp-Source: AGHT+IFL+6MN7lyDrMqhEjEZ0g5GQ6E0vATrv7YI/axbNqZjwDInJN9t9su7fEDoC8UvTRtjLQDLKA==
X-Received: by 2002:a05:600c:5110:b0:424:ad14:6b79 with SMTP id 5b1f17b1804b1-42bb01aa1f2mr188973125e9.8.1725602067243;
        Thu, 05 Sep 2024 22:54:27 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ca4f6sm8725695e9.17.2024.09.05.22.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:54:26 -0700 (PDT)
Message-ID: <30210c25d4ee878a3399caf758de9342d1f83f20.camel@gmail.com>
Subject: Re: [PATCH RFC 3/8] iio: backend adi-axi-dac: backend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Jonathan Cameron
	 <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org,
 dlechner@baylibre.com
Date: Fri, 06 Sep 2024 07:54:26 +0200
In-Reply-To: <5ca7f8a8-7ef7-4dbd-8ed4-791976bba3ef@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
	 <20240831123418.6bef6039@jic23-huawei>
	 <fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
	 <20240903201614.08722f59@jic23-huawei>
	 <e7aacdc36be2bc11dc0e5ce5cf135482257d2a7d.camel@gmail.com>
	 <5ca7f8a8-7ef7-4dbd-8ed4-791976bba3ef@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 13:58 +0200, Angelo Dureghello wrote:
> Hi,
>=20
> On 05/09/24 12:49 PM, Nuno S=C3=A1 wrote:
> > On Tue, 2024-09-03 at 20:16 +0100, Jonathan Cameron wrote:
> > > On Mon, 2 Sep 2024 18:04:51 +0200
> > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > >=20
> > > > On 31/08/24 1:34 PM, Jonathan Cameron wrote:
> > > > > On Thu, 29 Aug 2024 14:32:01 +0200
> > > > > Angelo Dureghello <adureghello@baylibre.com> wrote:
> > > > > =C2=A0=20
> > > > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > > > >=20
> > > > > > Extend DAC backend with new features required for the AXI drive=
r
> > > > > > version for the a3552r DAC.
> > > > > >=20
> > > > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > > Hi Angelo
> > > > > Minor comments inline.
> > > > > > =C2=A0=C2=A0=20
> > > > > > =C2=A0=C2=A0 static int axi_dac_enable(struct iio_backend *back=
)
> > > > > > @@ -460,7 +493,13 @@ static int axi_dac_data_source_set(struct
> > > > > > iio_backend *back, unsigned int chan,
> > > > > > =C2=A0=C2=A0=C2=A0	case IIO_BACKEND_EXTERNAL:
> > > > > > =C2=A0=C2=A0=C2=A0		return regmap_update_bits(st->regmap,
> > > > > > =C2=A0=C2=A0=C2=A0				=09
> > > > > > AXI_DAC_REG_CHAN_CNTRL_7(chan),
> > > > > > -					=C2=A0 AXI_DAC_DATA_SEL,
> > > > > > AXI_DAC_DATA_DMA);
> > > > > > +					=C2=A0 AXI_DAC_DATA_SEL,
> > > > > > +					=C2=A0 AXI_DAC_DATA_DMA);
> > > > > Unrelated change.=C2=A0=C2=A0 If you want to change this, separat=
e patch.
> > > > Thanks, fixed.
> > > > > =C2=A0=20
> > > > > > +	case IIO_BACKEND_INTERNAL_RAMP_16:
> > > > > > +		return regmap_update_bits(st->regmap,
> > > > > > +				=09
> > > > > > AXI_DAC_REG_CHAN_CNTRL_7(chan),
> > > > > > +					=C2=A0 AXI_DAC_DATA_SEL,
> > > > > > +				=09
> > > > > > AXI_DAC_DATA_INTERNAL_RAMP_16);
> > > > > > =C2=A0=C2=A0=C2=A0	default:
> > > > > > =C2=A0=C2=A0=C2=A0		return -EINVAL;
> > > > > > =C2=A0=C2=A0=C2=A0	}
> > > > > > @@ -518,9 +557,204 @@ static int axi_dac_reg_access(struct iio_=
backend
> > > > > > *back, unsigned int reg,
> > > > > > =C2=A0=C2=A0=C2=A0	return regmap_write(st->regmap, reg, writeva=
l);
> > > > > > =C2=A0=C2=A0 }
> > > > > > =C2=A0=C2=A0=20
> > > > > > +
> > > > > > +static int axi_dac_bus_reg_write(struct iio_backend *back,
> > > > > > +				 u32 reg, void *val, size_t size)
> > > > > Maybe just pass an unsigned int for val?
> > > > > So follow what regmap does? You will still need the size, but it
> > > > > will just be configuration related rather than affecting the type
> > > > > of val.
> > > > > =C2=A0=20
> > > > void * was used since data size in the future may vary depending
> > > > on the bus physical interface.
> > > >=20
> > > I doubt it will get bigger than u64.=C2=A0 Passing void * is always
> > > nasty if we can do something else and this is a register writing
> > > operation.=C2=A0 I'm yet to meet an ADC or similar with > 64 bit regi=
sters
> > > (or even one with 64 bit ones!)
> > I think the original thinking was to support thinks like appending crc =
to the
> > register read/write. But even in that case, u32 for val might be enough=
. Not
> > sure. Anyways, as you often say with the backend stuff, this is all in =
the
> > kernel so I guess we can change it to unsigned int and change it in the=
 future
> > if we need to.
> >=20
> > Since you mentioned regmap, I also want to bring something that was dis=
cussed
> > before the RFC. Basically we talked about having the backend registerin=
g it's
> > own regmap_bus. Then we would either:
> >=20
> > 1) Have a specific get_regmap_bus() callback for the frontend to initia=
lize a
> > regmap on;
> > 2) Pass this bus into the core and have a new frontend API like
> > devm_iio_backend_regmap_init().
> >=20
> > Then, on top of the API already provided by regmap (like _update_bit())=
, the
> > frontend could just use regmap independent of having a backend or not.
> >=20
> > The current API is likely more generic but tbh (and David and Angelo ar=
e aware
> > of it) my preferred approach it to use the regmap_bus stuff. I just don=
't feel
> > that strong about it :)
> >=20
> > > > Actually, a reg bus write involves several AXI regmap operations.
> > > > > =C2=A0=20
> > > > > > +{
> > > > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > > > +
> > > > > > +	if (!st->bus_type)
> > > > > > +		return -EOPNOTSUPP;
> > > > > > +
> > > > > > +	if (st->bus_type =3D=3D AXI_DAC_BUS_TYPE_QSPI) {
> > > > > As below, I'd use a switch and factor out this block as a separat=
e
> > > > > bus specific function.
> > > > Ok, changed.
> > > > > =C2=A0=20
> > > > > > +		int ret;
> > > > > > +		u32 ival;
> > > > > > +
> > > > > > +		if (size !=3D 1 && size !=3D 2)
> > > > > > +			return -EINVAL;
> > > > > > +
> > > > > > +		switch (size) {
> > > > > > +		case 1:
> > > > > > +			ival =3D FIELD_PREP(AXI_DAC_DATA_WR_8, *(u8
> > > > > > *)val);
> > > > > > +			break;
> > > > > > +		case 2:
> > > > > > +			ival =3D=C2=A0 FIELD_PREP(AXI_DAC_DATA_WR_16, *(u16
> > > > > > *)val);
> > > > > > +			break;
> > > > > > +		default:
> > > > > > +			return=C2=A0 -EINVAL;
> > > > > Hopefully compiler won't need this and the above. I'd drop the si=
ze !=3D 1..
> > > > > check in favour of just doing it in this switch.
> > > > > =C2=A0=20
> > > > sure, done.
> > > >=20
> > > >=20
> > > > > > +		}
> > > > > > +
> > > > > > +		ret =3D regmap_write(st->regmap, AXI_DAC_CNTRL_DATA_WR,
> > > > > > ival);
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		/*
> > > > > > +		 * Both REG_CNTRL_2 and AXI_DAC_CNTRL_DATA_WR need to
> > > > > > know
> > > > > > +		 * the data size. So keeping data size control here
> > > > > > only,
> > > > > > +		 * since data size is mandatory for to the current
> > > > > > transfer.
> > > > > > +		 * DDR state handled separately by specific backend
> > > > > > calls,
> > > > > > +		 * generally all raw register writes are SDR.
> > > > > > +		 */
> > > > > > +		if (size =3D=3D 1)
> > > > > > +			ret =3D regmap_set_bits(st->regmap,
> > > > > > AXI_DAC_REG_CNTRL_2,
> > > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_SYMB_8B);
> > > > > > +		else
> > > > > > +			ret =3D regmap_clear_bits(st->regmap,
> > > > > > AXI_DAC_REG_CNTRL_2,
> > > > > > +						AXI_DAC_SYMB_8B);
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		ret =3D regmap_update_bits(st->regmap,
> > > > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > > > +					 AXI_DAC_ADDRESS,
> > > > > > +					 FIELD_PREP(AXI_DAC_ADDRESS,
> > > > > > reg));
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		ret =3D regmap_update_bits(st->regmap,
> > > > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > > > +					 AXI_DAC_TRANSFER_DATA,
> > > > > > +					 AXI_DAC_TRANSFER_DATA);
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		ret =3D regmap_read_poll_timeout(st->regmap,
> > > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 AXI_DAC_REG_CUSTOM_C=
TRL,
> > > > > > ival,
> > > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ival &
> > > > > > AXI_DAC_TRANSFER_DATA,
> > > > > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 10, 100 * KILO);
> > > > > > +		if (ret)
> > > > > > +			return ret;
> > > > > > +
> > > > > > +		return regmap_clear_bits(st->regmap,
> > > > > > AXI_DAC_REG_CUSTOM_CTRL,
> > > > > > +					=C2=A0 AXI_DAC_TRANSFER_DATA);
> > > > > > +	}
> > > > > > +
> > > > > > +	return -EINVAL;
> > > > > > +}
> > > > > > +
> > > > > > +static int axi_dac_bus_reg_read(struct iio_backend *back,
> > > > > > +				u32 reg, void *val, size_t size)
> > > > > As for write, I'd just use an unsigned int * for val like
> > > > > regmap does.
> > > > Ok, so initial choice was unsigned int, further thinking of
> > > > possible future busses drive the choice to void *.
> > > >=20
> > > > Let me know, i can switch to unsigned int in case.
> > > I would just go with unsigned int or at a push u64 *
> > >=20
> > > >=20
> > > > > =C2=A0=20
> > > > > > +{
> > > > > > +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> > > > > > +
> > > > > > +	if (!st->bus_type)
> > > > > > +		return -EOPNOTSUPP;
> > > > > > +
> > > > > > +	if (st->bus_type =3D=3D AXI_DAC_BUS_TYPE_QSPI) {
> > > > > It got mentioned in binding review but if this isn't QSPI, even
> > > > > if similar don't call it that.
> > > > It's a bit difficult to find a different name, physically,
> > > > it is a QSPI, 4 lanes + clock + cs, and datasheet is naming it Quad=
 SPI.
> > > > But looking the data protocol, it's a bit different.
> > > is QSPI actually defined anywhere? I assumed it would be like
> > > SPI for which everything is so flexible you can build whatever you li=
ke.
> > >=20
> > > > QSPI has instruction, address and data.
> > > > Here we have just ADDR and DATA.
> > > >=20
> > I'm not sure the instruction is really relevant for this. From a quick =
look, it
> > feels like something used for accessing external flash memory like spi-=
nors. So,
> > I would not be surprised if things are just like Jonathan said and this=
 is just
> > flexible as spi (being that extra instruction field a protocol defined =
for flash
> > memory - where one typically sees this interface)
>=20
> Ok, so QSPI is the hardware, and the protocol on it may vary for the targ=
et
> chip/application.
>=20
> Looks like DDR makes the 33MUPS rate reachable, and not all the controlle=
rs
> have DDR mode. Also some controllers are supposed to work with a QSPI fla=
sh
> (so with instructions), and likely this reason driven the need to use a=
=20
> custom IP.
>=20

I do understand the custom IP, I just don't understand why not using the sp=
i_engine
IP. Indeed maybe because of DDR (as that is already supported on axi-dac).

- Nuno S=C3=A1


