Return-Path: <linux-iio+bounces-18505-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35888A967E8
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E727F3B50B6
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 11:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC6527C173;
	Tue, 22 Apr 2025 11:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXsYaron"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E52627BF9E;
	Tue, 22 Apr 2025 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745321956; cv=none; b=R+mg9R80kRVhdNyNn8tThspsqeuDP9TxFBQHw1/M74AC7z06BYxh8DONut+XRl98Q1xNx9kot6LopoTVQCDuVmvVQbRgfNdmj1AsfgCwPTJBgsbtmhghle0307iKUZiVZHhtyX/7DLFOZnEt7O99WoG0IbUYrsY74BN1ZRjIYmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745321956; c=relaxed/simple;
	bh=V0fiBlJiMhecwbrp2gzKMAwZZAcXyq3WcYQRSyXq/8w=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MvSqDp7DSOYRKZ66XCke7VSCJjxlt6maDjayUzeMb+O3FRQ+7PNzmiiHiMxXwIbidWTD+iuEo5oTeXb444FeeP+BjtzDF0++7lmAHAewaTJSylRPzak8jfzt7vzV/BA0wfzAqeIsRUlCjkZ9GQhRSPdr0MTVKEYhbtmGBCV5DXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXsYaron; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39129fc51f8so4309638f8f.0;
        Tue, 22 Apr 2025 04:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745321952; x=1745926752; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QcQU91gLit/RYTgtNMl88tWmoApG6AJcqQ2H3jwM7wg=;
        b=gXsYaronmFxpnY1mTICg5iNRNfqMdxaKQIGY10J3QwMiW1J7kgU7KPEm79wesa6ByW
         sLX1VYFDw7pFi1PsZV+joQQs/g3cydoc1uMR0tnwGhlz8SnxktCn0WNvIDeLhfyLJcvP
         aBzOHoc82KpZc0MDTjuaLD2mN/0WJ07yPrsgzjuvYglG4TyyBPR82TixFBtZ4mcNmuUD
         PJNPdCYZxGWniPxff2XzJQwRFE0CqL2nVHervPzGxKvECmoTtdy+2wJGS1oEPI0GSi08
         JG2Xoo1Fx2/6oN8QB1PwpQghJjpavxD9Jn3a0yWBRCwioo53O87BVSRZd7sVSTxift3o
         hezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745321952; x=1745926752;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QcQU91gLit/RYTgtNMl88tWmoApG6AJcqQ2H3jwM7wg=;
        b=SMR5Y9Msp+6wtsaOMz/0poCLU1t9MjvusufVYnGOXbtBQ1SzM/8izh1xPYUHO8TxLY
         86BD9K7da3p7paV35d3T/uPNBIHwOs1WXLbekRFW4ObhBxA5sVbagw7uPhUReL456wvb
         BaSuDdpx5tg991pj4pDi+vP4xo+Js0wrFg2uWEHbndDaLz/fFYidTXDv045y65LEMN/E
         zj+h/Y8fz9vNJ7jhaDKUbLNU8t3WoW23uK5quSgY/pfsTEzxrZnbrj+VHyhul9b1+h2P
         XFLzPi+BTLs3WHwhnH6TskuSPSLa1JMQJfAHbejpqr0L1S5qk+Xlb7YM7eDqyarZ6yN/
         x9NQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtWPgbpQ2XnhagjKjbQarSO4QnSk4ytQ7uWrQPTqsxJEmUiAZ8Pm5ilX0o4WyqnQ7IvpRjd67yo0eB@vger.kernel.org, AJvYcCW7E4aOqdm3dchLKvI0k+/KN0MFJ986xxdpAbi0F805RV4EOUIcczPYr/QKzQotuEW96uAB5N8l5IKU@vger.kernel.org, AJvYcCXZ6kETroBjO3o/GYu0JJCss9K97Jem7NS0FuX8RkUL6+pL4DbajItCSMFali6TFJgLtrBhQNb/OhMMiToJ@vger.kernel.org
X-Gm-Message-State: AOJu0YyLOF/jEEdiX+7VIk1AmgUgdhyCkbAntAA2h6w+F/85U/vKCoXP
	keQtrZ4jIqwymCHQUw8KeHrOxe2eELZBemLwQeaRO13jiSxf6w8T61ngKQQ/
X-Gm-Gg: ASbGncvr1weBzW4cxjioJcsou9937oXrwlQ6DGcQTmLj2oO0qMnobKjIFS2c9wP4m0p
	l3gRO/je+lo+Doy7juqQx6eDmAgQXPmDnwkXM7HOlocablHUhK9F+835iohimJ37n24c8rvuxD/
	NpxCtNs0EyGhi5Rat9WLz3WCbTE6zTHW9m+I2XjvWgFTm8t8NOKr8mBriVuiW6GjvD8zMU60A+Y
	o0et69n8T8sJlkLdSNV1Hz26YjGXUVcFGyKLRRLCKBCVkSY2Eb1h40adHNLZEPyXbstBrYibPNp
	eLgT9wPNwezLBt8weT7DL04IxBlscD9cRwaDrFXS13R4xR8LeHVcbB77cDYg87bx0oAeswcamQn
	enQ7oj0udPrPM6oKQY/MDO94=
X-Google-Smtp-Source: AGHT+IEB1HFfaiHetaJlonxbc3U/9mRR65mPIsN+O2wz1rUtZ6/yXit/VZEBJhRk+eROXOOpDdyRAg==
X-Received: by 2002:a05:6000:2287:b0:391:466f:314e with SMTP id ffacd0b85a97d-39efba461c4mr12189523f8f.16.1745321952371;
        Tue, 22 Apr 2025 04:39:12 -0700 (PDT)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39efa43c079sm15191114f8f.50.2025.04.22.04.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 04:39:11 -0700 (PDT)
Message-ID: <f2f0ef05a738a16083d686a246499788b6d353d2.camel@gmail.com>
Subject: Re: [PATCH v2 13/13] iio: adc: ad4080: add driver support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, "jic23@kernel.org"	
 <jic23@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "conor+dt@kernel.org"	 <conor+dt@kernel.org>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>,  "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Tue, 22 Apr 2025 12:39:15 +0100
In-Reply-To: <CY4PR03MB3399B23673D9C3210C8CE9B99BBB2@CY4PR03MB3399.namprd03.prod.outlook.com>
References: <20250411123627.6114-1-antoniu.miclaus@analog.com>
		 <20250411123627.6114-14-antoniu.miclaus@analog.com>
	 <4e7100b945e542f675c6a506bc6431ad46cf6d84.camel@gmail.com>
	 <CY4PR03MB3399B23673D9C3210C8CE9B99BBB2@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-04-22 at 08:12 +0000, Miclaus, Antoniu wrote:
> > > +	int ret;
> > > +
> > > +	guard(mutex)(&st->lock);
> > > +	if (st->num_lanes =3D=3D 1)
> > > +		ret =3D regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > > +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK);
> > > +	else
> > > +		ret =3D regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +				=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > > +				=C2=A0=C2=A0 AD4080_INTF_CHK_EN_MSK |
> > > +				=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret =3D iio_backend_data_alignment_enable(st->back);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	do {
> > > +		ret =3D iio_backend_sync_status_get(st->back, &sync_en);
> > > +		if (ret)
> > > +			return ret;
> > > +
> > > +		if (!sync_en)
> > > +			dev_dbg(&st->spi->dev, "Not Locked: Running Bit
> > > Slip\n");
> > > +	} while (--timeout && !sync_en);
> > > +
> > > +	if (timeout) {
> > > +		dev_info(&st->spi->dev, "Success: Pattern correct and
> > > Locked!\n");
> > > +		if (st->num_lanes =3D=3D 1)
> > > +			return regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +
> > 	=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> > > +		else
> > > +			return regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +
> > 	=C2=A0=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > > +					=C2=A0=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > > +	} else {
> > > +		dev_info(&st->spi->dev, "LVDS Sync Timeout.\n");
> > > +		if (st->num_lanes =3D=3D 1) {
> > > +			ret =3D regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +
> > 	=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK);
> > > +			if (ret)
> > > +				return ret;
> > > +		} else {
> > > +			ret =3D regmap_write(st->regmap,
> > > AD4080_REG_ADC_DATA_INTF_CONFIG_A,
> > > +
> > 	=C2=A0=C2=A0 AD4080_RESERVED_CONFIG_A_MSK |
> > > +					=C2=A0=C2=A0 AD4080_SPI_LVDS_LANES_MSK);
> > > +			if (ret)
> > > +				return ret;
> > > +		}
> > > +
> > > +		return -ETIMEDOUT;
> >=20
> > So, first the things that I don't really get (also the hdl docs need to=
 be
> > improved FWIW):
> >=20
> > * It seems that we can have data alignment or data capture synchronizat=
ion
> > through an internal AMD FPGA technique called bit-slip or an external
> > signal,
> > right? In here, it seems that we only use bit-slip and never disable it=
. Is
> > that
> > really the goal?
> >=20
> > * This whole process seems to be some kind of calibration at the interf=
ace
> > level, right?
> >=20
> > * What's the point of the conv clock? Is it only used to get the sample
> > rate? If
> > so, the hdl docs are misleading as it seems that it can be used instead=
 of
> > bit-
> > slip for data capture alignment?
> >=20
> > Now, speaking about the backend API's, it looks like that
> > iio_backend_self_sync_enable() and iio_backend_data_alignment_enable()
> > could be
> > merged into one API. From what I can tell,
> > iio_backend_data_alignment_enable()
> > just enables the bit-slip process but that likely does nothing unless t=
he
> > SELF_SYNC bit is also set to bit-slip, right? In fact, we could think a=
bout
> > a
> > more generic (less flexible though) API like:
> >=20
> > * iio_backend_intf_data_align(back, timeout_us), or
> > * iio_backend_intf_calib(back, timeout_us), or
> > * iio_backend_intf_data_capture_sync(back, timeout_us)
> >=20
> > On the backend side, you could then enable bit-slip and do the status r=
ead
> > (with
> > timeout) and return success or an error code.
> >=20
> > The above seems to be pretty much what you're doing but in just one API=
 that
> > makes sense to me.
> >=20
> > Of course that the following questions still come to mind:
> >=20
> > * Do we need to disable bit-slip after we're done (still fits into the =
one
> > API
> > model)?
> > * Do we need a meaningful API to change between the syncing/alignment
> > methods?
> > External signal vs bit-slip?
> >=20
> > The above is key to better think of an API. Right now it feels that you=
're
> > just
> > adding an API for every bit you want to control in this process...
> >=20
> > If we end up needing more flexibility for this, we can also consider th=
e
> > existing iio_backend_data_sample_trigger() API. I know is abusing a bit=
 and
> > a
> > stretch but in the end of the day the whole thing is related with align=
ing,
> > syncing, calibrating the interface for properly sampling data. Even bit=
-slip
> > (while not a traditional external trigger) looks like some kind of self=
-
> > adjusting, data-driven trigger mechanism to establish the correct start=
ing
> > point
> > for capturing data. So having two new enums like:
> >=20
> > IIO_BACKEND_SAMPLE_TRIGGER_EXT_SIGNAL,
> > IIO_BACKEND_SAMPLE_TRIGGER_BIT_SLIP // or maybe a more generic name
> > like
> > s/BIT_SLIP/INTERNAL
> >=20
> > I do not think the above is that horrible :P... But I would really like=
 to
> > get
> > more opinions about this.
>=20
> There've been some update on the HDL side changing a bit the behavior:
> - bitslip_enable is removed, instead the `sync` bit is used which is alre=
ady
> part
> =C2=A0 of the adc common core.
> =C2=A0SYNC:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit enables capture synchroniza=
tion. When activated, it initiates
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 an HDL process that aligns the sampl=
e's most significant bit (MSB)
> based
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 solely on the captured data, without=
 considering the AD4080's CNV
> signal.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit is self-clearing and should=
 be toggled whenever
> synchronization
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 is needed (e.g., at boot or after up=
dating the sampling rate).
>=20
> The SELF_SYNC bit was removed.
>=20
> SYNC_STATUS bit (which is also part of the common core) has the following
> behavior:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 This bit indicates whether the sample's MS=
B alignment has been correctly
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 performed and the capture is synchronized.=
 If successful, this bit will
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be set to 1.

So this looks like it would fir in first approach of just one new backend A=
PI
right?

What about the CNV signal? Is that something we can fully control on the
frontend driver (though it also seems that signal is an output of the backe=
nd
device)?

Thx!
- Nuno S=C3=A1

