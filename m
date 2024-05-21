Return-Path: <linux-iio+bounces-5149-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E84D8CA858
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 09:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0B7C1F215A2
	for <lists+linux-iio@lfdr.de>; Tue, 21 May 2024 07:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBD394D5B0;
	Tue, 21 May 2024 07:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQxvh4Uf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED41F482EE;
	Tue, 21 May 2024 07:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716275014; cv=none; b=W01/DiQ3c+6inOA4VYa1BlPqtYc4m6UtGDPN9zZ1siZSCmtj2ISc6khN6J94tndJvNvF64UjLcRa7X6QKwweMFzCfGutnosEEemCMiP8KkiTmvuHWuXz+9k8VUMNLwytNQYp6u/rbHNHG1xKfCjn0BkPxBnUlwy175PyoXNFP8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716275014; c=relaxed/simple;
	bh=W78xOUZOmKMQybBB10sYcYuLAnuxE6oCWILwuCswGSo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UpPFLhmcXNX5CBBKHGFphicQEUsqUntJnvKXo4Z+I/YN4oC2pNObXfjOr4R5siW7HjwpssYbtM8XsdfBnOXAnn4XvtYokb9k0JL6HSuGa7B+T/8VRSsii74OLbriP5LoO0RVkbjilp5XGe/2jaVS5nxNHftuDUp+mtJgKgLCNHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQxvh4Uf; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so8186708a12.3;
        Tue, 21 May 2024 00:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716275011; x=1716879811; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W78xOUZOmKMQybBB10sYcYuLAnuxE6oCWILwuCswGSo=;
        b=RQxvh4UfoDO7eMq2LNyiZRuqzq5rOu8vbcinWfo8n3yrx2iMlxX9V23OWgt764QeRH
         HMCcXL2CfPWnOxPM9arKIr27CtYYIgAW/jpdrH02cf6QoGGz/h9zwnehpFi/e6Ef1uGf
         kG7mvXBQQGEhnoBtHtltbiTDeryKf3NWcDaG6e+uLqssJ690S13j2gLRSZgbb4wtpOXc
         NC1nUgbIa96eJ4nXt6INYo0mEe6i2p+4CpfzpqemookUZT5wgTufaMZlSHBX6FKz1mmc
         gh2lIB5N+7hvXVfFr/zchRX8DSwQAjX0aA29K/ESHpeZ58MbZj6vsEt973UIdxYEKWtP
         eilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716275011; x=1716879811;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W78xOUZOmKMQybBB10sYcYuLAnuxE6oCWILwuCswGSo=;
        b=Ers/TdZ9aPdnQcaTypS3/ROM4u3NjIxRyPPy3/Q+xsSW/mNjhXWWt1afi5XOYshi7I
         DwAbfcPGd3kXQK2f/EatTW/V8k2zZXY5sON3av7cgaz4RAwF09Z+tie0C7SOp43nr0WF
         M5fmvlj2iFIwtIdI4wJbzrOlgpCn0fdJ4hiNrDug1U+WEEDUrEOyWZbJjWFaniZYgmFK
         /wqWdqtCCKlDnRWPyLPAxcg8dlVftmHgIJnYM67dwzzxJrAoH0Y0C35SO4vuIvQNEYW4
         beivepT7XhJVsWLNf/B3/ciD0ALRFNIUMGdU55k/Zz5WhSs2/+IJFLGMPb/EaOkYQ7dq
         EloA==
X-Forwarded-Encrypted: i=1; AJvYcCX0BT1ifd0/1WbY93cUC+J8BwnUD5TwdQTcoQ4Bxx2B5oreokPSTRXgg5Ftb9rc128KCWvXyCSRpPlVokfPuKZ0BtjushFeqlEvzbg7fPHQGLj0WXpy1DfGdsNKtZvHGCjeHy3pfarwFyLFArR3gSujMgaG1MnNH8B9XXmsYRhOIdEdYA==
X-Gm-Message-State: AOJu0YzvAFcij+CngUjsy8VkZOOHSCWKjZq5qR6o+shKLsPsf72Ngkya
	RnYa0w3aiMUO8GAsvDYUpm3o1+ZYnb9kRlpbi8obFIWRpAT+GX5c
X-Google-Smtp-Source: AGHT+IHP3aBOXM8g4YEaHEojj+mC+t8FVqMFj9KRZf01Rot23J/TsU0IchRswJMfRX/eknS+ziFrTA==
X-Received: by 2002:a05:6402:3488:b0:578:2677:7fd with SMTP id 4fb4d7f45d1cf-57826770eafmr30315a12.36.1716275011005;
        Tue, 21 May 2024 00:03:31 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733c323866sm16109624a12.87.2024.05.21.00.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 00:03:30 -0700 (PDT)
Message-ID: <4d226c3a3662374dca766b2a8f9f3479a63ddc39.camel@gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add docs for ad8460
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Jonathan Cameron
 <jic23@kernel.org>
Cc: Mariel Tinaco <Mariel.Tinaco@analog.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Marcelo Schmitt
 <marcelo.schmitt1@gmail.com>,  Dimitri Fedrau <dima.fedrau@gmail.com>,
 Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 May 2024 09:07:14 +0200
In-Reply-To: <CAMknhBE9mJUXsKYVwHb=6d3tVk9DiODWjqtzv9q+zSer5XqrqQ@mail.gmail.com>
References: <20240510064053.278257-1-Mariel.Tinaco@analog.com>
	 <20240510064053.278257-2-Mariel.Tinaco@analog.com>
	 <CAMknhBFXk07HbP_pPg5wkW-9Ah2-66kGzZFvcvBNrbjfguHb4g@mail.gmail.com>
	 <20240511172500.718fe12d@jic23-huawei>
	 <CAMknhBE9mJUXsKYVwHb=6d3tVk9DiODWjqtzv9q+zSer5XqrqQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-05-11 at 13:47 -0500, David Lechner wrote:
> On Sat, May 11, 2024 at 11:25=E2=80=AFAM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >=20
> > On Fri, 10 May 2024 12:28:19 -0500
> > David Lechner <dlechner@baylibre.com> wrote:
> >=20
> > > On Fri, May 10, 2024 at 1:42=E2=80=AFAM Mariel Tinaco <Mariel.Tinaco@=
analog.com>
> > > wrote:
> > > >=20
> > > > This adds the bindings documentation for the 14-bit
> > > > High Voltage, High Current, Waveform Generator
> > > > Digital-to-Analog converter.
> > > >=20
> > > > Signed-off-by: Mariel Tinaco <Mariel.Tinaco@analog.com>
> > > > ---
> > > > =C2=A0.../bindings/iio/dac/adi,ad8460.yaml=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 67 +++++++++++++++++++
> > > > =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 7 ++
> > > > =C2=A02 files changed, 74 insertions(+)
> > > > =C2=A0create mode 100644
> > > > Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > > >=20
> > > > diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad8460.y=
aml
> > > > b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > > > new file mode 100644
> > > > index 000000000..924f76209
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad8460.yaml
> > > > @@ -0,0 +1,67 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > > +# Copyright 2024 Analog Devices Inc.
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/iio/dac/adi,ad8460.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: Analog Devices AD8460 DAC
> > > > +
> > > > +maintainers:
> > > > +=C2=A0 - Mariel Tinaco <mariel.tinaco@analog.com>
> > > > +
> > > > +description: |
> > > > +=C2=A0 Analog Devices AD8460 110 V High Voltage, 1 A High Current,
> > > > +=C2=A0 Arbitrary Waveform Generator with Integrated 14-Bit High Sp=
eed DAC
> > > > +=C2=A0
> > > > https://www.analog.com/media/en/technical-documentation/data-sheets=
/ad8460.pdf
> > > > +
> > > > +properties:
> > > > +=C2=A0 compatible:
> > > > +=C2=A0=C2=A0=C2=A0 enum:
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - adi,ad8460
> > > > +
> > > > +=C2=A0 reg:
> > > > +=C2=A0=C2=A0=C2=A0 maxItems: 1
> > > > +
> > > > +=C2=A0 spi-max-frequency:
> > > > +=C2=A0=C2=A0=C2=A0 maximum: 20000000
> > > > +
> > > > +=C2=A0 vref-supply:
> > >=20
> > > It would be nice to make the property name match the pin name since
> > > there is more than one reference voltage input.
> > >=20
> > > refio-1p2v-supply:
> > >=20
> > > > +=C2=A0=C2=A0=C2=A0 description: Drive voltage in the range of 1.2V=
 maximum to as low
> > > > as
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 low as 0.12V through the REF_IO pin=
 to adjust full scale output
> > > > span
> > >=20
> > > I don't seen anything in the datasheet named REF_IO. Is this a typo
> > > and it should be REFIO_1P2V?
> > >=20
> > > > +
> > > > +=C2=A0 clocks:
> > > > +=C2=A0=C2=A0=C2=A0 description: The clock for the DAC. This is the=
 sync clock
> > > > +
> > > > +=C2=A0 adi,rset-ohms:
> > > > +=C2=A0=C2=A0=C2=A0 description: Specify value of external resistor=
 connected to FS_ADJ
> > > > pin
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 to establish internal HVDAC's refer=
ence current I_REF
> > > > +=C2=A0=C2=A0=C2=A0 minimum: 2000
> > > > +=C2=A0=C2=A0=C2=A0 maximum: 20000
> > > > +
> > >=20
> > > I see lots more pins on the datasheet, many of which should be trivia=
l
> > > to add bindings for (we prefer to have the bindings as complete as
> > > possible even if the driver doesn't implement everything). Potential
> > > candidates:
> > >=20
> > > sdn-reset-gpios: (active high)
> > > reset-gpios: (active low)
> > > sdn-io-gpios: (active high)
> > >=20
> > > hvcc-supply:
> > > hvee-supply:
> > > vcc-5v-supply:
> > > vref-5v-supply:
> > > dvdd-3p3v-supply:
> > > avdd-3p3v-supply:
> > >=20
> > > It also looks like there is a parallel interface for data, so I would
> > > expect to see an io-backends property that links to the PHY used for
> > > handling that.
> > >=20
> > Ultimately yes, but the parallel interface might require some decisions=
 on
> > binding that are non obvious until it's actually implemented. So maybe
> > don't need that bit from the start.=C2=A0 The rest I agree should be he=
re.
> >=20
> >=20
>=20
> Since the driver patch uses a DMA channel that isn't documented here,
> I am assuming that the parallel interface is being used so we do need
> to consider it now. :-)

AFAIU, the way this is designed, the parallel interface is directly connect=
ed to
the DMA IP controller. So, at this point there's really no use for the DAC
backend. We may have different designs in the future but no use case for no=
w.

- Nuno S=C3=A1

