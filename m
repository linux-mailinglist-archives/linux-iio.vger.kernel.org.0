Return-Path: <linux-iio+bounces-4287-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 870C28A4EFA
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 14:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16D251F22307
	for <lists+linux-iio@lfdr.de>; Mon, 15 Apr 2024 12:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48BA6996A;
	Mon, 15 Apr 2024 12:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKV1+nDU"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECC5CDD9;
	Mon, 15 Apr 2024 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713183928; cv=none; b=HK4crXWCPCSf0iwNWP+uKBzP4cRfDG/4w+3sp1xyBh4LbXF7fnjnKuv1STYkrg1smIW/4lZpD/c8RTsgavhquEZRupqOJzCvp7rsjdsQ3ir724DxhQDk4XxmKzERLjeLeQ9PCg8bOYNnFQHcRMyjtHud0tJy75IEyr6BRtjIRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713183928; c=relaxed/simple;
	bh=DkGbTCzmH4lbTPHFdRmzoPUxo8Dmex3DQlRvQkc3A7U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XvvqX+65JVO7O28Mhz242FmRImold3ceKgwG90tvtz2/FQQFQ+0jOnwUzNDZ9/emcJFeQJXXuVCfvzTUO0KgrttRRZpkaw85ISl6IaN04iWu1QyTKoGBUof82GW+e79b3DaaOd3o3l3eFdCe4gAppeIgoscJx7VT0HLBYpgzSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKV1+nDU; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5269c3f9c7so125283666b.2;
        Mon, 15 Apr 2024 05:25:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713183925; x=1713788725; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=T00tACFOsKvmwTpOl4/lsfV1UTNveaSdPv8EfyOvw6g=;
        b=lKV1+nDUM2Y1siX//AxneZVS8FZlUNC+IpPRHdaZr+7c5rJ8eXGix1/msP1tv6NW3O
         K0FMDHc65WxIqzM397jGNS0dtdKIiqMs5aPo8ShYKj5Up6sIgc2R0OkMQaTUIH91EOXj
         77AXZCGK+xLCDNzcVDvSnIBpPnuo0pIg7coPgg0AxzWzhfd32DkQrfUEh6zEe/sftaTG
         BYyZevs/oQvz+PR0gy+IjZnMUW1USnzuTwFSjMGN08F3vHhsoMXLYd6YRT5LQby8ZSA4
         oa3n1spuqUhMpvIAaBhWyDaFRHhlzrUHt4NR0jLHCjI6f/wT+oDEE+oN3qIw1qqgkIAd
         nobw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713183925; x=1713788725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T00tACFOsKvmwTpOl4/lsfV1UTNveaSdPv8EfyOvw6g=;
        b=oM6mWoETi8UMU9Mh7T7Z5Z2TbdvbCmK+JQ1j0hz4BXECmjDrXEANkmnQfyQxAWeT5o
         Pf8SAptcYyxQFk9dhZ0OOaCsR1MwkmEynOSk46GFddN6AoNocdx3ip7VzLyzsPaFTfN0
         PioJAKAjmi0lx8OwDKOaLcQ0I9o6aU8mC82QCbozrdK8LvvVniZuLK0HvmADdG2K8lLY
         +6HH2048ocVmB6PgRD3AHU6ql2TZ2oV8kstwXzrEAhZsEhB3Xyjd5ifWDPfdQJ5VFmOt
         yl/YWU9sqvYiwJkFL6RUDFQ9lxqamUjUj/GUsE7uHfaP5lU4S/hRKGD/uFMgsqUce/gl
         WkHg==
X-Forwarded-Encrypted: i=1; AJvYcCXmwFE21141xZS0d/v3i0HxpG0stcLW2fDMSSXv4Zxupk7A92VNVp5T16AJvVnT2QSNjuOVuaumP28+K9VbQpoTbXE4vL81EJpzag+D6gsZVlw6YrFTeU/EVniWdxyYwYlV2+osGA==
X-Gm-Message-State: AOJu0YyQ0eciVPbP7bbSpSgX9CVxXIUCTcUofzEQ0nVlCqgnS78rYPgT
	6Jvm+Qie//8fUuhCqtJOtgzuU9Wg4dI30KC7azxF869XAfT8JcqG
X-Google-Smtp-Source: AGHT+IEmBZFjzqeQvMclUlIml1JxnnV+WojM1ulS+yQzg1ja7C45UJbixhiXRhV/VzsPYXI9+JWJkg==
X-Received: by 2002:a17:906:6a1d:b0:a52:527a:63fa with SMTP id qw29-20020a1709066a1d00b00a52527a63famr4380914ejc.33.1713183925084;
        Mon, 15 Apr 2024 05:25:25 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id mb24-20020a170906eb1800b00a525609ae30sm2587651ejb.169.2024.04.15.05.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 05:25:24 -0700 (PDT)
Message-ID: <02f70ca66229cef97a9eaaacec84cbb62e51dfcd.camel@gmail.com>
Subject: Re: [PATCH v2 11/11] iio: dac: support the ad9739a RF DAC
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Dragos Bogdan <dragos.bogdan@analog.com>, 
 Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Olivier Moysan <olivier.moysan@foss.st.com>
Date: Mon, 15 Apr 2024 14:28:59 +0200
In-Reply-To: <20240413120007.1f430cb4@jic23-huawei>
References: <20240405-iio-backend-axi-dac-v2-0-293bab7d5552@analog.com>
	 <20240405-iio-backend-axi-dac-v2-11-293bab7d5552@analog.com>
	 <20240406174119.38b821ff@jic23-huawei>
	 <d99653ec9a40a16b088c425d5552de85892564fe.camel@gmail.com>
	 <20240413120007.1f430cb4@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-04-13 at 12:00 +0100, Jonathan Cameron wrote:
> On Mon, 08 Apr 2024 10:51:43 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2024-04-06 at 17:41 +0100, Jonathan Cameron wrote:
> > > On Fri, 5 Apr 2024 17:00:09 +0200
> > > Nuno Sa <nuno.sa@analog.com> wrote:
> > > =C2=A0=20
> > > > The AD9739A is a 14-bit, 2.5 GSPS high performance RF DACs that are
> > > > capable
> > > > of synthesizing wideband signals from DC up to 3 GHz.
> > > >=20
> > > > A dual-port, source synchronous, LVDS interface simplifies the digi=
tal
> > > > interface with existing FGPA/ASIC technology. On-chip controllers a=
re
> > > > used
> > > > to manage external and internal clock domain variations over temper=
ature
> > > > to
> > > > ensure reliable data transfer from the host to the DAC core.
> > > >=20
> > > > Co-developed-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > > > Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>=C2=A0=20
> > >=20
> > > The only thing I really have remaining questions on is the choice
> > > of chan_spec with altvoltage and voltage channels.=C2=A0 Why does tha=
t
> > > split make sense?=C2=A0 It's odd enough that some comments in the cod=
e would
> > > be a good thing to add.
> > >=20
> > > Jonathan
> > > =C2=A0=20
> > > > new file mode 100644
> > > > index 000000000000..9b91d66f826c
> > > > --- /dev/null
> > > > +++ b/drivers/iio/dac/ad9739a.c
> > > > @@ -0,0 +1,454 @@=C2=A0=20
> > > =C2=A0=20
> > > > +
> > > > +static struct iio_chan_spec ad9739a_channels[] =3D {
> > > > +	{
> > > > +		.type =3D IIO_ALTVOLTAGE,=C2=A0=20
> > >=20
> > > So this looks a little unusual. Perhaps some comments on why it
> > > is appropriate to have this channel.
> > >=20
> > > In reality there is only one channel I think?=C2=A0=20
> >=20
> > Yeah, I had this same discussion internally and was also thinking in ha=
ving
> > one
> > channel (just ALTVOLTAGE). I ended up doing it as we have done it inter=
nally
> > so
> > far. The reasoning is that we have two sources of data:
> >=20
> > ALTVOLTAGE: It's the internally continuous wave the backend can generat=
e.
> > That
> > is in fact alternate voltage.
> >=20
> > VOLTAGE: Is kind of what I call external source where we assume is just
> > typical
> > DAC data and that typically is VOLTAGE (but for a dac like this, I thin=
k it
> > may
> > very well be, if not most of the time, also alternate - the thing is, w=
e
> > can't
> > know for sure as we should be able to have both)
> >=20
>=20
> Ok. That makes some sense.=C2=A0 These are sort of different channels eve=
n if they
> come out of the same physical pin and the phase etc definitions only make
> sense
> for the DDS case.
>=20
> The operating mode being tied to only the VOLTAGE channel is a little odd=
 but
> I suppose it works=C2=A0 if we think of it as
>=20
> =C2=A0=C2=A0 DDS altvotage ----inputto----\=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 MUX -->=C2=A0=C2=A0 vol=
tage channel. --> pin.
> =C2=A0=C2=A0 DAC data=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ----input to---/
>=20

Exactly. That's pretty much the dance we have when enabling/disabling buffe=
ring.

> I we really wanted to make this complex, we'd use an actual IIO Mux for t=
hat
> but that is going to lead to a more complex driver for what is a bit of a
> special
> case so I don't think we need to do so.
>=20

Agreed...

I'm also not sure if you missed or just did not had the time but I already =
sent
v3 out last Friday :). I kept the two channels with a comment on it.

- Nuno S=C3=A1

