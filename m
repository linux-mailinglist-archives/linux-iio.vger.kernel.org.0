Return-Path: <linux-iio+bounces-2921-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 263BC860BED
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 09:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACBB1F24BD0
	for <lists+linux-iio@lfdr.de>; Fri, 23 Feb 2024 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E9A171AC;
	Fri, 23 Feb 2024 08:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="au1tOZ+V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EC4171B8;
	Fri, 23 Feb 2024 08:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676039; cv=none; b=gDX1ryU4hi7cGoO/q+EByV2urTInHtFK3v40etUm3fQpVSU9yZHxDFlI7UZpBtXX9ngwaoTNqdUQjo1N/Cag1MEJ7M8GcqdmOjRFJPnsf5plB6x7WdubOFiDNejuFsr1um9AXEaMROgLi/wBl8l/66E3Z4nOlP4KlXtQqHeBOMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676039; c=relaxed/simple;
	bh=JVSNT7wTGn9ub9sFBrLZXOKoSP1lL5F6e0EnQSp1JNM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rQ/en834jFi9nC/doUyrhlmQiL9D1ADkB2uynUxT3vs36PnMY4PVOvxDsS6A4PdD0xthNgHgMnBB+sGpmtsdijEazQR3YP/zYtwgCXQUy1GUllrZlj8+o7sY1pWq8sXNi9MUVyc+RZ3ETwAGEZ+fslN68sUuiItjnBtfnIHoV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=au1tOZ+V; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-564372fb762so631969a12.0;
        Fri, 23 Feb 2024 00:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708676036; x=1709280836; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JVSNT7wTGn9ub9sFBrLZXOKoSP1lL5F6e0EnQSp1JNM=;
        b=au1tOZ+V85kxTQ6sPTzPCDiBg7VoUIcCv+H43u+N7wzw03q9je3bmx6FOZQMaN6uiM
         paeQ2P4OQXf3rpuRJriO8UMdZJYE2wSgD2eyA9RYs5YXXwyo63WFRadhf/SsP9Xk0PHe
         G+zs32cAd3iRs/sFfDehTVazRgVlTNiwqQeVyCrP23O3HZ1dj++cv7ysqDJG0L2vn0FV
         L9SISS0COt/n6tnPxml6mTUM/ZzS0bSzOjMdTl3fABdoj27k/39ufUYTgzo5GELcD+29
         8zG6RHVUQnukJZMoONlRwYd9FJHvsyEOz/H+MCqnEOyZwXCHDPAbNhbiydP8k5/YGBL9
         ieOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708676036; x=1709280836;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JVSNT7wTGn9ub9sFBrLZXOKoSP1lL5F6e0EnQSp1JNM=;
        b=LC9LKvUXitXx5HAvlmWKSj2qUTYMoNZly8yoZ729w8kNaTjf5MKhsEg+ByTqN5hCQj
         nqKh2+OnZFyZxchKR6L7R7GDjhZ9vouNPESoSF4Z6F7IAPY9qDT+nvYySJIS1Nz7m8ei
         v3UzQWLLFbnllCl8m69KQvBucmuW3a8U31EWVeFaeMIe0LBWDwFwVHGHanZXdYCLY+fN
         pjMaRQo5jzqx7EHwR0sRgb3WdQw8zz53lL/Wct//uisowMTBkrKIoZaoXlKIXUWZDjeB
         1XWWihfSk0u3zU4p9S9DDrnDTjBinDeGsSrL0G2IWv/IDLAGpTJnUhl2wShKLhXTmlDc
         y2tA==
X-Forwarded-Encrypted: i=1; AJvYcCUYiFIsun/k7URPXin1Gbs9zFZuafRIGpPhVWenQH/3rUPsXpN/oxwNAZ429l0MDaHUzLMpnQ2LYhbEjqa07A1O3y0OeYcLx4sjcSKc4m0wdMac9l5iRXpV9kTnRIdUgjFotBUJbg==
X-Gm-Message-State: AOJu0YzvLEVOCKptQmmAfv7XCEUmvMNzoNROnLxiJJ5PV0OdIeXmxG0V
	4KrLJZ/aQjcFRPYSOS+qxsx7nWVC0ImAFW2WxkaDe9HUVa5b/ICs
X-Google-Smtp-Source: AGHT+IFjrnYOlFxMq2/FqTGqrIDQ00Kgutm32PhLYFUA33uWMTA/KEkrsvnIG5mEAXL9vADzt8nTHA==
X-Received: by 2002:aa7:da57:0:b0:564:7962:4545 with SMTP id w23-20020aa7da57000000b0056479624545mr702447eds.15.1708676035442;
        Fri, 23 Feb 2024 00:13:55 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id fe12-20020a056402390c00b00564fa936b2bsm2176762edb.94.2024.02.23.00.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 00:13:55 -0800 (PST)
Message-ID: <8409a5bc71b995e3b738b817a074cfb131c3b2b5.camel@gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Nuno Sa <nuno.sa@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>
Date: Fri, 23 Feb 2024 09:17:16 +0100
In-Reply-To: <20240222-lance-sprinkled-04a7650ca316@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	 <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
	 <20240222-component-stiffen-d046386433b3@spud>
	 <f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>
	 <20240222-lance-sprinkled-04a7650ca316@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-22 at 17:54 +0000, Conor Dooley wrote:
> On Thu, Feb 22, 2024 at 05:41:03PM +0100, Nuno S=C3=A1 wrote:
> > On Thu, 2024-02-22 at 15:40 +0000, Conor Dooley wrote:
> > > On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote:
> > > > Add a property for the VDD power supply regulator.
> > > >=20
> > > > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > > > ---
> > > > =C2=A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml | 2
> > > > ++
> > > > =C2=A01 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l
> > > > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l
> > > > index dbb85135fd66..8aae867a770a 100644
> > > > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml
> > > > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983=
.yaml
> > > > @@ -57,6 +57,8 @@ properties:
> > > > =C2=A0=C2=A0 interrupts:
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > =C2=A0
> > > > +=C2=A0 vdd-supply: true
> > >=20
> > > Although technically an ABI break, should we make this supply require=
d?
> > > It is, at the end of the day, required by the hardware for operation.
> > >=20
> >=20
> > I thought about it but then realized it could break some existing users
> > which is
> > never a nice thing.
>=20
> Could you explain what scenario it actually breaks a system (not
> produces warnings with dtbs_check)?

Oh, I guess I could not explain myself :). I did not meant breaking the sys=
tem
(I'm aware of the dummy regulator) but I meant exactly what you mention abo=
ve
about dtbs_check. Like, if someone already validated a devicetree against t=
he
current bindings, that same devicetree will fail to validate now right? And=
 I
had the idea that we should not allow that... If not the case, I'm perfectl=
y
fine in making the supply required.

- Nuno S=C3=A1

>=20


