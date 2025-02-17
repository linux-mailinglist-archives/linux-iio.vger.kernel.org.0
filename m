Return-Path: <linux-iio+bounces-15619-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE7CAA37EB2
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 10:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5943B570C
	for <lists+linux-iio@lfdr.de>; Mon, 17 Feb 2025 09:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E8D215F40;
	Mon, 17 Feb 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+6YlaKA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6C4215766;
	Mon, 17 Feb 2025 09:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739784746; cv=none; b=sXsQHKR5m+oFl0WzvrU9IEECysQeARqHtaU8ueHUGg3bCQlTXyJwvJEW3KvGwXtjdmOUO6H8ybcSAVupq0RCiZSBu5vs3XZbiOx3wmrVJfMl72QPqJF6ih1KsViE3n2+wVzvhvgNWfsgX606Q1DbbnRgGvBniJ0MbZBkHg/OgzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739784746; c=relaxed/simple;
	bh=HUlJWNcvr8rqj8RDvx4vwOPQLHal/5LBmOUDIQw1ARI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FdXlJ4iQ7R3WbM3XbtlBCc/9eDkLjgzC4BAMTDQ0bcT3nrailrePmU/pVZv6dyUH0PClmwhE0cra3/odnMKuP9bRhtVlTo2kPmjMrPf56cXmErPiWfP4HCm0fV7u2KKgUr23I+5IDCWh29IJpfAP08crGmmIskCBUDwcSZh/ki0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+6YlaKA; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb7a6ee2deso233735466b.0;
        Mon, 17 Feb 2025 01:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739784743; x=1740389543; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HUlJWNcvr8rqj8RDvx4vwOPQLHal/5LBmOUDIQw1ARI=;
        b=P+6YlaKA4m7w9R9WGJCtrxZyZyxD6KQm0Q+RaEvoxzHLblzX/Vi4CfqL5RJJPy1c1w
         T8qWAsueu8TTUcANT8ZrdaBu2x1xArfjrzkbtItfLLYOykpbrb52viAQlDYl0Ezb4rSH
         vT7ye8/ljs9bkWAR0JcHigg6nJ2DmNkDf0fPK3STd1C1vGe3n8AMJUOPNL/nCyDRnRnn
         wY9TClh873x7cnhqsJ/1ZuQyiZwa6RraU7T8HVzldtEEqPEaKIUcJf9wnzVSrM8UGi0s
         cXh5n6CNTtrBfNfW+vEQthwLHWCvxDGVGmqcJrpDf38zY3OZjsN/cyaYwc71MgD+53bD
         1IIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739784743; x=1740389543;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUlJWNcvr8rqj8RDvx4vwOPQLHal/5LBmOUDIQw1ARI=;
        b=TZGRybqc72qKeq/+iByBBo40A+fuyGXo/D1T3Mylw6DHwmrwxQ3Fpi63pf5Vk/WZ5Q
         nyuXS+1XIVoC9DD9kO16nIQA+9wMwfvjwYcF2HDZG8/briF82QzUYR4s9SvT/5AzzZ2P
         9k9NJybQ7NO4N0vcRbylo6TSUom4MBZKPNgCkV6PEkyU16LRhyUNZJ/wQHG36x6DHxfq
         yoeeXt70SMXQbWOeAfPYUWwYFC07OZlQ28jC25bDsZbzVMgE84HkR24o+6yAYQ7nrC7F
         vWf2MNe8tzTbKT+IVnDZUY4UEiooKrvBCcbjNqJsQKc8ZyCq0Hz5mqft+B01VR+f++Ke
         iqww==
X-Forwarded-Encrypted: i=1; AJvYcCU1fJHsEBIOpUWol1zsX7F6vHRycaBN3H/kd1kZDGEclg71ZhkwFvj2Y0/KF2FoqjnFoRvrainLn3uV1A==@vger.kernel.org, AJvYcCUPCZsKDUhRaL8gTqg9+ktBKWTK+vqYF/+1YPOxwIix6CHj9thgWHm/I0b/50TvH2lTh5F5bmr3ojbf@vger.kernel.org, AJvYcCVBZeXYh9EEBGq6R7ShIiKmEeDrobBcAYqfCEc2fedAQPXxEJXZ3vAIUNHVCm72zLMoJ7a8r4aoY96W@vger.kernel.org, AJvYcCVRSV7tWx8Ek9U19f3sxBWU8yw+vW9/k7wZ1PdXqI5osEUnj0HHyuoJVknDqU02yO7WCo464lROlHhUcJ7Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVUNVxRZPDLmROoZl8e9eTJnNUgaqp+KOIzYWVF5PY4PJujuU
	knbDx2fEo0+SWW3lCGRUA4AIY+HAEtmQyp5j3+XVbtvLIhqmsTVU6iMQi6FKucA=
X-Gm-Gg: ASbGnctu12UTKP+zhgyKeCfstw7Et99f58aLuVVLxeJ6VhD4xxF2eVc4rv6EZ12/R+O
	BLA1+258C9RnDrT9ZgQbTh5r4ebLilznq4DMUhDNJ255kr6OXv2j+tPkr5WA/nA09Rlko+gJ8Lv
	iHmOwCLX+gH1/7GRYT72Kb8Ztdu7UXFijKRhSRowsA++soibTdvn03CDfJWzaE/9Anp4c5LxMWZ
	9b3H3LdGHfFrI2uGFnfx8WRAsvIpZuBjwhTzSK7Os8g4gCniJhVbfPaBlQSLq91eGxyw+wT3ZEA
	ebV2O06VgMZV1I9kpKHhDh5PnScZM9fIgGHzY6Ci3tO+SYRwrbbw6wgsZxQivX8=
X-Google-Smtp-Source: AGHT+IFeH6Wktt/xfN2WBdLEobo9pLVyAWcoYAOXCOS3EAy5kk4fOKN+rE/Uo0oJPKzo/KUfKXgagQ==
X-Received: by 2002:a17:906:57cc:b0:abb:9a1e:47cb with SMTP id a640c23a62f3a-abb9a1e4826mr281763866b.55.1739784742437;
        Mon, 17 Feb 2025 01:32:22 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abbae3512a6sm4128766b.179.2025.02.17.01.32.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 01:32:21 -0800 (PST)
Message-ID: <bf069d43ed76b68c91130233b264089c3f7b2514.camel@gmail.com>
Subject: Re: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: "Paller, Kim Seer" <KimSeer.Paller@analog.com>, Linus Walleij
	 <linus.walleij@linaro.org>, Jonathan Cameron <jic23@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski	 <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,  "linux-gpio@vger.kernel.org"	
 <linux-gpio@vger.kernel.org>, "devicetree@vger.kernel.org"	
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>, linux-iio <linux-iio@vger.kernel.org>,
 Peter Rosin <peda@axentia.se>
Date: Mon, 17 Feb 2025 09:32:25 +0000
In-Reply-To: <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
References: <20250213-for_upstream-v2-0-ec4eff3b3cd5@analog.com>
	 <20250213-for_upstream-v2-2-ec4eff3b3cd5@analog.com>
	 <CACRpkdZR8X17Bn-i2anqjxf0Gk60V175F7Xfwytkhy7_K+LsSA@mail.gmail.com>
	 <880631da17a6d8ed4afe5a8c453fd4f7d0e4fca5.camel@gmail.com>
	 <CACRpkda+CDRMYKmjw7kewenkteLhPYb040E4B=ZG6pgdy=65pg@mail.gmail.com>
	 <PH0PR03MB71419BE3FCE2DAE8AB72B79EF9FB2@PH0PR03MB7141.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-02-17 at 07:02 +0000, Paller, Kim Seer wrote:
>=20
>=20
> > -----Original Message-----
> > From: Linus Walleij <linus.walleij@linaro.org>
> > Sent: Saturday, February 15, 2025 7:22 AM
> > To: Nuno S=C3=A1 <noname.nuno@gmail.com>; Jonathan Cameron
> > <jic23@kernel.org>
> > Cc: Paller, Kim Seer <KimSeer.Paller@analog.com>; Bartosz Golaszewski
> > <brgl@bgdev.pl>; Rob Herring <robh@kernel.org>; Krzysztof Kozlowski
> > <krzk+dt@kernel.org>; Conor Dooley <conor+dt@kernel.org>; linux-
> > gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> > kernel@vger.kernel.org; linux-iio <linux-iio@vger.kernel.org>
> > Subject: Re: [PATCH v2 2/2] gpio: gpio-adg1414: New driver
> >=20
> > [External]
> >=20
> > Let's check with Jonathan Cameron (IIO maintainer) on this as well.
> > He might have ideas.
> >=20
> > For reference, the datasheet:
> > https://www.analog.com/media/en/technical-documentation/data-
> > sheets/adg1414.pdf
> >=20
> > (By the way: add the datasheet to a special Datasheet: tag in the
> > commit please!)
> >=20
> > On Fri, Feb 14, 2025 at 2:17=E2=80=AFPM Nuno S=C3=A1 <noname.nuno@gmail=
.com> wrote:
> > > On Fri, 2025-02-14 at 00:25 +0100, Linus Walleij wrote:
> >=20
> > > > Now, the kernel does not have switch subsystem I think,
> > > > so this is something like a special case, so we might be
> > > > compelled to make an exception, if the users will all be in
> > >=20
> > > Exactly, since we could not find anything, the best fit seemed like t=
he
> > > gpio
> > > subsystem. I was the one suggesting it since a new subsystem for a si=
mple
> > device
> > > like this looked excessive. If we had more devices that would fit suc=
h a
> > > class
> > > of devices, maybe it would make more sense to start thinking on such =
a
> > > subsystem?
> > >=20
> > > > say userspace and make use of this switch for factory lines
> > > > or similar.
> > >=20
> > > Kim should know better again (about usecases) but I would also assume=
 this
> > is
> > > for userspace use.
> >=20
> > Actually the GPIO documentation Documentation/driver-api/gpio/using-
> > gpio.rst
> > even talks about this for userspace use cases:
> >=20
> > "The userspace ABI is intended for one-off deployments. Examples are
> > prototypes,
> > factory lines, maker community projects, workshop specimen, production
> > tools,
> > industrial automation, PLC-type use cases, door controllers, in short a
> > piece
> > of specialized equipment that is not produced by the numbers, requiring
> > operators to have a deep knowledge of the equipment and knows about the
> > software-hardware interface to be set up. They should not have a natura=
l fit
> > to any existing kernel subsystem and not be a good fit for an operating
> > system,
> > because of not being reusable or abstract enough, or involving a lot of=
 non
> > computer hardware related policy."
> >=20
> > If this is the usecase, like controlling an external switch for such th=
ings,
> > using the GPIO subsystem might actually be reasonable in my opinion,
> > (even if the DT bindings end up in their own category).
> >=20
> > If the switches control stuff related to computer machinery (i.e. integ=
rated
> > into a laptop to switch on/off the fans...) then no. So it depends on h=
ow
> > and where it will be used.
>=20
> In my case, this is a userspace use case. The ADG1414 was used to control=
 the
> ADMFM2000 Microwave Downconverter device. According to the ADMFM2000
> datasheet, it requires control over 14 digital pins, which can be set hig=
h or
> low [1].
> While these pins could be directly controlled using GPIO, the evaluation =
board
> for
> the ADMFM2000 is designed to use the ADG1414 switch for this purpose [2].
> ADG1414 is an SPI controlled switch that allows switching of these digita=
l
> control lines.
>=20

AFAICT the mux subsystem does not have any userspace so it would already no=
t fit
the above usecase. We could add a simple setter sysfs interface if Peter th=
inks
this belongs to the mux subsystem...

Let's see what Peter has to say about this.

What about misc devices? I mean, if there's no agreement...=20

- Nuno S=C3=A1


