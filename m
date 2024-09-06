Return-Path: <linux-iio+bounces-9229-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 799D196E98A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 07:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044F31F23E82
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 05:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B361386B3;
	Fri,  6 Sep 2024 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTmUVWlx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C32941B;
	Fri,  6 Sep 2024 05:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601992; cv=none; b=LEbxkM6Bd7fvgSw+wOiT57bgnXMscX177+ktHwaPbsGqdPvtXWox8xB82RxQ+NrBk/YywYbOOULwZL4QPQXNJccifVTwP+JSF3TCbdrFSAkSkBLj2ZUaFLri0sQqp1HxmB8QHjkqleKHMc/ukQjBdlrAbXun8qYxCahJ1qZGlhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601992; c=relaxed/simple;
	bh=gAjzJv5PGHFk/ryG44fQsdeZnIEKduBsuqQEbZ5a724=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k3tdvGgmvLrpWI+Boc+mgvvKuCH4GdQBrOG2/7p7iBkqdKd+ItX6AlcL8rCV+fLq4oP6014QH3IDpwBOasNmwFSIJZJGRICV+w/vssNo0J2e47o8mx0yysAA7+5x659+BXeHsGeH1xkLiDK97KIgOQsGk/xw/Xruw2JPhRJfkFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTmUVWlx; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-371ba7e46easo965197f8f.0;
        Thu, 05 Sep 2024 22:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725601988; x=1726206788; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tf8iGnJdwoEXqLisGcPmBEPiWtgVTeRBZ7+/tZ8nUQc=;
        b=BTmUVWlxdEvgLrfJ619tft198hUtHzAJnL35WEClosDlPdoglbZemiv+P1VfVEBqMJ
         m30BvDTuIbMU8hA6YLy+gd5MXnvJ8sFy8+0iU5GlEZ2vQr4eOu43jh77so75RGVq2rgx
         4X44k3obNxbfkA6MmDNQkGkGZj3pandwxOa/N/k5afqckk4FcTFn1XMqKgHpnmnPVCYK
         QPMc+7wnqJLQnjpBAu20XvI6nUNKc1arkjYppEIZyMMhpb4N551A8ATJxNNIvetCQeiU
         SLCN9DVmIep3l6cwH4gej68NN8KVGLa7GxX/fDlelT4dCoLGOmma8zAJrfHgfGSwa2vz
         ap1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725601988; x=1726206788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tf8iGnJdwoEXqLisGcPmBEPiWtgVTeRBZ7+/tZ8nUQc=;
        b=Fh9U3rOkpajmL9QcrtPwztvhrucQLQOj7qzeCX75f015zj5QAG9Fn28Xts/+0ES5J4
         AhDitYpUzbqUPErllXtRONX/Q+i5I136MweHb4ta554MYRaz3zAKJjEj0hMFPIDECVKd
         6NZOsbO6DynvJsFms0rx6807zRtJg9Eiin4IR0gb6FmtAmIaKOvwc7T6UcYVvPrcs7VR
         751bqQxECEzOM7Df28dpRlZpSOCh+qJnSZh6NS0enxM0FqB3Od7pGjGWSrk2njmSVcmh
         z1wHTpcHTzjEp3pS6zadWWhecwBjVJ5apWoqe5fh3e3vIY2frldkDwV/XBwC2G3LkhJw
         cInw==
X-Forwarded-Encrypted: i=1; AJvYcCUjhYfMy7OkXQkJJ6oA6Sv6NAFWs+1dS58dYdaUTUjubQO0Ucdhg/e6JPFrLLygGT2Q522TBNNbUaqJ@vger.kernel.org, AJvYcCV9b8m2h+V7CKd8FsYB+cpOeuaejStmDoiTvUM8/PUJerWBk8PLEyQfT0j6Aoy22pJfWcghA8gTu6w+I6Zh@vger.kernel.org, AJvYcCWEMOXQTi/NgxxUt22vqGNVckWb6Fy1aPcM0RQsLc3+Bby80dykwX2zKaCJV3c1cHb7h/EhjV2mk4h2@vger.kernel.org
X-Gm-Message-State: AOJu0YxT76kkMkHE0KlQqQWP6jAjpG119p6+AhWxcuWmfBSM5Rt0Ivse
	m97zhq2xzJvTbFJehVUqq2wmLoDJ+GaDcf0821hjS3ghfnIUTf3Y
X-Google-Smtp-Source: AGHT+IGV4RbQDDRXGwecVHCI7PCfCdWwq347Yeb3bdK9yZjp0nBEWI1Vi4mj54vxkX3+Z2mSmsyZNQ==
X-Received: by 2002:a5d:4b47:0:b0:371:9362:c286 with SMTP id ffacd0b85a97d-378895c5b69mr797195f8f.4.1725601986729;
        Thu, 05 Sep 2024 22:53:06 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:341e:1201:c434:b5b1:98a6:efed])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05d23e5sm8653745e9.22.2024.09.05.22.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 22:53:06 -0700 (PDT)
Message-ID: <d9e4852f4ff935c151e31c938ff5f00335437713.camel@gmail.com>
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
Date: Fri, 06 Sep 2024 07:53:05 +0200
In-Reply-To: <ad1a8507-49df-49c6-a285-8adb407ad7a1@baylibre.com>
References: <20240829-wip-bl-ad3552r-axi-v0-v1-0-b6da6015327a@baylibre.com>
	 <20240829-wip-bl-ad3552r-axi-v0-v1-3-b6da6015327a@baylibre.com>
	 <20240831123418.6bef6039@jic23-huawei>
	 <fd68cda2-f523-49fd-943b-c07dbb461799@baylibre.com>
	 <20240903201614.08722f59@jic23-huawei>
	 <e7aacdc36be2bc11dc0e5ce5cf135482257d2a7d.camel@gmail.com>
	 <ad1a8507-49df-49c6-a285-8adb407ad7a1@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-09-05 at 14:11 +0200, Angelo Dureghello wrote:
> Hi,
>=20
> sorry forgot to reply about the regmap,
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
>=20
> regmap idea seems really nice and a better style.
>=20
> Honestly, if possible, would not go for it right now.
> The main reason is that i am on this work from months and it would=20
> require a quite
> big rework (also rearranging more common code, retest, etc) while i am=
=20
> trying to
> finalize a first driver.
>=20

While I understand your reasoning, I can't really agree with it if we feel =
regmap is
the better solution. It makes no sense to add something knowing that it wil=
l removed
in the next couple of weeks. Actually (and I'm guilty of that too :)), when=
 we say
things like that, odds are we're just leaving things like this.

> If you agree, this could come in a second "cleanup" patchset, but at=20
> least i can
> provide an initial support for ad3552r.
>=20

Having said the above, I'm not going to NAK this approach even if it's not =
my
favorite one :)

- Nuno S=C3=A1
> > >=20


