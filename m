Return-Path: <linux-iio+bounces-934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205AC8142F1
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 08:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460AF1C20A0A
	for <lists+linux-iio@lfdr.de>; Fri, 15 Dec 2023 07:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18901094D;
	Fri, 15 Dec 2023 07:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7ayEIDH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3486107BD;
	Fri, 15 Dec 2023 07:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a22f59c6ae6so47200466b.1;
        Thu, 14 Dec 2023 23:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702626539; x=1703231339; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1FNDrj9UX9g1aWvgwvWexI55++xpGzhEI1jwvmfC1VU=;
        b=F7ayEIDHWrL1fERkFEBlfUqw8s6d9M6RfGDqXlCFOYhRIxzRZnGRVlqY9qtFTtpbYL
         DjAm3wqEStJIEWkRHQjJ/RHf8PQdkpIuRQ9DZ0xTTrki3AePkhFcFJn3UUSKrRQSjYRk
         GetFauvEwjx9nnl/N9DDC8WzmWBn1ZtWUl28perTmqiB8DkE6IxyB6dQRuIuNBUiW1hY
         pE2q6KKhjE0qzI3MIYgYcrqSWZguEfgv/3l5BrlhT8cxujqdgB4wsb6MjREkqTOZAyL+
         ewtgpv7gVP9UBwBSMaEZuryDhpEAcXFKKFEeGiED2iH3XROgqtkui/lSdagXr4+JIfHk
         7GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702626539; x=1703231339;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1FNDrj9UX9g1aWvgwvWexI55++xpGzhEI1jwvmfC1VU=;
        b=QKmbUiGNxV+kSn6ROQZbNuZcPxRS+DDT3xVc/MBshxTj9aEILT1CRMjorcTDJZqMCJ
         tLHmyBnkZB4s0WdbJ8IDmimB5R3QGmS4e9NQHCoIPQ/spvJ7yHaXe0plVWdPxfHAsHsQ
         g107feDOyhosrywTEqmQTGTzzr7j3kh8UY3Fuzv7rW0dLAPiPecL/TDti+pYfSF9Qvhh
         NMczZjAb/MZ37TwWACK08iEZUrNhiQvTlEevSElF4UrRW3+fUdsF3zVZrTfP23nQmb4W
         ZBNjh2TgnDB5Mc55WoX7CRnsXgoZ+B61Bj6RO0BoJeIc2qtARXfCGZjybSeOpMIxcwYH
         6nag==
X-Gm-Message-State: AOJu0YxIosz3FdeE28kl0Soqtdox1f+/9xHnuciPfa1VSwJpatdtB4L5
	yJo9orl8vAlG6Sw3RBY912c=
X-Google-Smtp-Source: AGHT+IHlKN6sQj44Z4W8JCHTq2chQ4DY+RM0aiPu/nz7rh4i4AVo0Ozv4I13GJrONt3ijaf5etEXRA==
X-Received: by 2002:a17:907:cb2a:b0:a19:d40a:d266 with SMTP id um42-20020a170907cb2a00b00a19d40ad266mr2318282ejc.306.1702626539097;
        Thu, 14 Dec 2023 23:48:59 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id tk7-20020a170907c28700b00a1d1ebc2206sm10454450ejc.72.2023.12.14.23.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 23:48:58 -0800 (PST)
Message-ID: <4cefa6ee8770d5f5cced1ef45c0b99dbe1ed9109.camel@gmail.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: adc: ad9467: add new io-backend
 property
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Rob Herring <robh@kernel.org>, Nuno Sa <nuno.sa@analog.com>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Jonathan
 Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>,  Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
Date: Fri, 15 Dec 2023 08:52:02 +0100
In-Reply-To: <20231214170510.GA492798-robh@kernel.org>
References: <20231213-dev-iio-backend-v3-0-bb9f12a5c6dc@analog.com>
	 <20231213-dev-iio-backend-v3-1-bb9f12a5c6dc@analog.com>
	 <20231214170510.GA492798-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 11:05 -0600, Rob Herring wrote:
> On Wed, Dec 13, 2023 at 04:02:32PM +0100, Nuno Sa wrote:
> > The ad9467 will make use of the new IIO backend framework which is a
> > provider - consumer interface where IIO backends provide services to
> > consumers. As such, and being this device a consumer,=C2=A0 add the new
> > generic io-backend property to the bindings.
> >=20
> > Signed-off-by: Nuno Sa <nuno.sa@analog.com>
> > ---
> > =C2=A0Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml | 5 +++=
++
> > =C2=A01 file changed, 5 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > index 7aa748d6b7a0..74e6827cbd47 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,ad9467.yaml
> > @@ -44,6 +44,9 @@ properties:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pin that controls the powerdown mo=
de of the device.
> > =C2=A0=C2=A0=C2=A0=C2=A0 maxItems: 1
> > =C2=A0
> > +=C2=A0 io-backends:
> > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > +
> > =C2=A0=C2=A0 reset-gpios:
> > =C2=A0=C2=A0=C2=A0=C2=A0 description:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Reset pin for the device.
> > @@ -54,6 +57,7 @@ required:
> > =C2=A0=C2=A0 - reg
> > =C2=A0=C2=A0 - clocks
> > =C2=A0=C2=A0 - clock-names
> > +=C2=A0 - io-backends
>=20
> New required properties are an ABI break. Please justify this in the=20
> commit message.
>=20

Yeah, I know... I'll further comment on the cover and depending on the
conclusion we get I'll justify it (or not if not needed) in the message.

- Nuno S=C3=A1

