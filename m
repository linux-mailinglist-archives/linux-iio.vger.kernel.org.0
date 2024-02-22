Return-Path: <linux-iio+bounces-2910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED06A85FE33
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 17:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A7571C24686
	for <lists+linux-iio@lfdr.de>; Thu, 22 Feb 2024 16:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C8B15098C;
	Thu, 22 Feb 2024 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hODCkxC/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680773F8E2;
	Thu, 22 Feb 2024 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708619866; cv=none; b=pGSuhqCL+o5FtetA2FhBRDbaGdvZwWuQx9l1JKxMhMsljLW9HxVz9Jc9Jkbhrmk/Cn0sbowyovnQAA4FVqLR+9YQJWKOZ0/Mdkmnf2QJZyH8FApqI0cptnPkwaZzNYycmnN4RDeAlcCbKJSXQx87VUKbcITuV9xtucv+HA8VArE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708619866; c=relaxed/simple;
	bh=xPkfO/GDnVYxxjFHlmBNH8rDyiFVfGYZBsI7Mz1cJZ8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OcQs7xL69OiZvJSYBd8Kdnu1XraZSlE4ItMCC41xiTQ1aGVQo8VWm1nz2deGA2z8Yt4Ihm160zZ58Ef8cp44MRFFD5BwQYdqzcOULw3PmwJt67UzP7cd7wC9VMzvkTQkKCheJGCSvtzVVWBUwFj8ArbyNs21Vn/AFOmmhsdw7ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hODCkxC/; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5655c7dd3b1so91155a12.0;
        Thu, 22 Feb 2024 08:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708619863; x=1709224663; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xPkfO/GDnVYxxjFHlmBNH8rDyiFVfGYZBsI7Mz1cJZ8=;
        b=hODCkxC/kxJrl5MNUoW9LP0A88C7n8FX4MioBeSOO2Jmo3V4cx+tuO/5nI4GmU1qcp
         pXoqWqwhDnYmoNkTEbGFKx3VNBy1wyQKtlTcSuAMFPeClNTuAWEkMO16ouFCHbeNrujl
         LIVCvtC4x2tju6Tsjds33NzlRZDjoaovD43pucKM8rWUMKeBuLWzTEnTojCzwkm0rQCQ
         FyxZ/HIG3zPLW2DX8BqkPYYpxl5dRHJmJh9Thbl05NRcew82ec0gD8H8VHqU4tWQOw6O
         exD/AR94n1Z9mvi4SDpljSy43hq2szKnEmD6jAnkmvdW9r53Rdt5v1K7DsDToDwAADVe
         ZTWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708619863; x=1709224663;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xPkfO/GDnVYxxjFHlmBNH8rDyiFVfGYZBsI7Mz1cJZ8=;
        b=wyOc1AyZj7o0SZqtl7YTOVsc+MQ0DeDBm5f3CPxlvT7TnGCYRTBLzQ2FwtSGFc7T9z
         ft432SamgvVAzfQBuQyeqwIxvz7Zv84oBbbTFe18wOYFh58uQZWb3mOspKSmVv+94HH6
         JPau/0jfJPks0aL8BBVqNG5YlzteYGGKsZmdm+lSo1lMti0hFI4XRoT+XoflFU9AwVfF
         VFoJdEiWHvv2LN/ZwWeVpyNbtIMhWrZPLbKQrkU6oqANvieSjnGT9KVmGo0zl6GQG2m4
         bfzyHpuVTtF2yMUTePxbnFW10N79qfEfhsZL3s+/eXphTvRK0iXfZgHTSL/Vj8nlqJmc
         WHug==
X-Forwarded-Encrypted: i=1; AJvYcCUd791mrXdhWzxcjiIyy0AOgNubCUdliD7Sk9hNY0H38PaBCuZ4CB9MSKK2zqD43mtRG0W3H4gF1iX2SefP8KEgmo8yjd1+4lkf9Q==
X-Gm-Message-State: AOJu0YxsWe9VbssJZEZLNUBWpe+2YTCOn3KkQE4rws/x/Ng1AbQ3ODp6
	IMkvCyGnTI50bP+Ul/2a1DBuR+hzeaVUD4feiMa7VghcbK/LnY+0
X-Google-Smtp-Source: AGHT+IHiZxqXwNFn+RKeUqfTvHuSDxvfB0F7CZjlCIc7pQvstjdKNOnC547E6WyAmSllAGce1Nf9hA==
X-Received: by 2002:a17:906:7110:b0:a3e:feee:3a5b with SMTP id x16-20020a170906711000b00a3efeee3a5bmr3035703ejj.3.1708619862534;
        Thu, 22 Feb 2024 08:37:42 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id s10-20020a17090699ca00b00a3f9a10f792sm455050ejn.7.2024.02.22.08.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:37:42 -0800 (PST)
Message-ID: <f31abc7140dfa8477623d4fca8abece03d37926e.camel@gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: iio: temperature: ltc2983: document
 power supply
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Conor Dooley <conor@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, Jonathan Cameron
 <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>
Date: Thu, 22 Feb 2024 17:41:03 +0100
In-Reply-To: <20240222-component-stiffen-d046386433b3@spud>
References: <20240222-ltc2983-misc-improv-v1-0-cf7d4457e98c@analog.com>
	 <20240222-ltc2983-misc-improv-v1-5-cf7d4457e98c@analog.com>
	 <20240222-component-stiffen-d046386433b3@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-02-22 at 15:40 +0000, Conor Dooley wrote:
> On Thu, Feb 22, 2024 at 01:55:56PM +0100, Nuno Sa wrote:
> > Add a property for the VDD power supply regulator.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l | 2 ++
> > =C2=A01 file changed, 2 insertions(+)
> >=20
> > diff --git
> > a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yaml
> > index dbb85135fd66..8aae867a770a 100644
> > --- a/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l
> > +++ b/Documentation/devicetree/bindings/iio/temperature/adi,ltc2983.yam=
l
> > @@ -57,6 +57,8 @@ properties:
> > =C2=A0=C2=A0 interrupts:
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 vdd-supply: true
>=20
> Although technically an ABI break, should we make this supply required?
> It is, at the end of the day, required by the hardware for operation.
>=20

I thought about it but then realized it could break some existing users whi=
ch is
never a nice thing.

I recently (in another series - the IIO backend) went through some trouble =
to
actually not break ABI. Meaning, I had to do some not so neat hacking in th=
e
driver because Rob was more comfortable with not breaking ABI in DT. So, I
assumed he would not like for me to break it in here.

- Nuno S=C3=A1
>=20

