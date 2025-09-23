Return-Path: <linux-iio+bounces-24364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D21B94F78
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 10:21:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF9248639E
	for <lists+linux-iio@lfdr.de>; Tue, 23 Sep 2025 08:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753ED2E92BC;
	Tue, 23 Sep 2025 08:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUgkHBd0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA6F31A04E
	for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758615667; cv=none; b=mcvPx03HC4esFO2NYgS6AHJTxXj2L7R5A2PwRen+pwt+nRrpuqQYKDnfelGbUF45RLVBUOMs+i1d9TDAw3iXBxUlvox2MpPDYrsPuHwCvlWoQ6PE9j3iMlqtYXlzxsgOj/v92BBpM+iwKdahl96Vc3pUbyd514r++KCu5mxef/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758615667; c=relaxed/simple;
	bh=f7re57QCz3hpnfyc8Rk+bIVfVD27d6HuiXpGIteeQ8g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dOus59rc6gkw3WUcZYQyJn3ledcP2uzYUEYomk4dN6fXsHgoAqjbz1ICLKz/YD0wjwxk0KvQ2i+8wmkuPrn7+4uTBPa+2gBNxX4GR4qBwbFk8qe+XrwyPtucdKVSjoq8aLqEceXCCcyQMT51EMeTje8n1Htom91ku7fKmJHayug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUgkHBd0; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso9090763a12.3
        for <linux-iio@vger.kernel.org>; Tue, 23 Sep 2025 01:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758615664; x=1759220464; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AhmhfqnvAeJncIKaG+WP0RlASLHv+hRZUaH7TN0Eo0g=;
        b=kUgkHBd0AY+fJQiPpOEzXj2x2J+obg+iLvnYEPBE5npRKj+Hnsyco+iuangYe77heA
         ksnpfZTD4aBfiMI0M14jksUh1CTLqWrLP54QUnQXddKEU2d1m1q6OEN5iSl57GAQEkdJ
         MWQaf+JbUr+H+NAkwV9ryr+H1fbS6jGQbw6ZKJaNhRU+8AlU2cuqcdNCIYOGgNJyroFi
         MbcpoBm4XguiugFcp8n0QDvbIPzuE9tXqyqLeeihW5hwBjfC0gpIkBxKRbk6FtJziJGV
         mydFdb//4I0bDBq4LWcFaSKm5GDkGM7QQiAX3xiyMoie8gMsYWI7QaTM5RZxiZx3ftHB
         +6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758615664; x=1759220464;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AhmhfqnvAeJncIKaG+WP0RlASLHv+hRZUaH7TN0Eo0g=;
        b=VznAJOm3NcdFLR++jldZrW5iqM4hGecQWBhu1l4DCb/yT/q2gJl9WIQpVY1imNNsoN
         c4oIFIShSpBvOUhtD9o13ADX+Bqf0XjGnl/swnIMxd6NNBRGbmd0W7/KYrRlgIPsIY8n
         XtZks8XPmqb3j6DGibXbHD5KVvwuy8MQMULmVHf4Cp5HJ2SC/I0OI52MwiPml5X48/kW
         dWz6kAcL5ne3eY30L0aVDBADsqu7brLWMaLncJNOqtBuPOi8Gdf36IllOkX9e294pWx4
         T5ZpxkC+IQ4+ddL3dEURapT1xBHfVmdU9NLPaZDi5LIZG1m6TYXLPagiT8S7skYZXZuo
         P/dw==
X-Gm-Message-State: AOJu0YxWakFqLUbc7ZyhxZ5Pq7sodkdPd3XH4CumGqcDmdZ8RARZp9Hw
	JgU++Ubaf0gaMgM4kNxbMSP0aYp3e4AP9sF6qQxmd77giEKLO5CpTtl2
X-Gm-Gg: ASbGncvrbN2j1eBgApAl5NtNCCNEv+X1R2AhBXMAHhRULTek76kQlN9udrwd1ShiL1v
	6ePF/mX974H35YpzIOmR+5lOOWHpdBreY02IO4eRReCEW6RyUrtvU8tKNsjh7BuxyGurSroiYpi
	z5rHmomP4BZrCdJEYr25Ehv7GTOZZLETYaac04j1o16GAWFrMsP5PxQPLZvfuADNBtw55FbepRS
	YorwEfjf1aMaUv9puHPxOG7aNON637Wvubuhl64PXwUxE6Ujorb5XU+iZh4f7npkwep7X+NNJhO
	l3UsVPOKTfyp2+ufIaH3JJ1Wrw/HElyTQLkMagbMn4it/NWu0i6qaaIL8plQvp/Y8wLvnC/jSuT
	XlPgz3l5keQNzl4ZUhveLPRt8
X-Google-Smtp-Source: AGHT+IGFMtMk1tU3B4zQBbIphTLmZaVJ9Ckxo/UCmlJ6T8uLNCcZMLmNfiD71dDZglBrDEV65/suyg==
X-Received: by 2002:a17:907:7611:b0:b30:2f6b:448f with SMTP id a640c23a62f3a-b302f6b47f2mr152382266b.25.1758615663347;
        Tue, 23 Sep 2025 01:21:03 -0700 (PDT)
Received: from [10.5.0.2] ([91.205.230.222])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b29961979e5sm676840966b.0.2025.09.23.01.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:21:03 -0700 (PDT)
Message-ID: <02c26151da7af1e05aecadf0e2ce20552c2908e0.camel@gmail.com>
Subject: Re: [PATCH 2/2] iio: dac: adding support for Microchip MCP47FEB02
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: David Lechner <dlechner@baylibre.com>, Ariana Lazar
	 <ariana.lazar@microchip.com>, Jonathan Cameron <jic23@kernel.org>, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	 <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 09:21:30 +0100
In-Reply-To: <3457c119-2f49-43a3-b96b-736b8f5de99b@baylibre.com>
References: <20250922-mcp47feb02-v1-0-06cb4acaa347@microchip.com>
	 <20250922-mcp47feb02-v1-2-06cb4acaa347@microchip.com>
	 <859d8472a8f9e8d28b890ad565f9d3ce11e162d5.camel@gmail.com>
	 <3457c119-2f49-43a3-b96b-736b8f5de99b@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-22 at 17:15 -0500, David Lechner wrote:
> On 9/22/25 3:10 PM, Nuno S=C3=A1 wrote:
> > Hi Ariana,
> >=20
> > Thanks for your patches. Some initial comments from me...
> >=20
> > On Mon, 2025-09-22 at 14:30 +0300, Ariana Lazar wrote:
>=20
> ...
>=20
> > > +static IIO_DEVICE_ATTR(store_eeprom, 0200, NULL, mcp47feb02_store_ee=
prom,
> > > 0);
> > > +static struct attribute *mcp47feb02_attributes[] =3D {
> > > +	&iio_dev_attr_store_eeprom.dev_attr.attr,
> > > +	NULL,
> > > +};
> > > +
> >=20
> > Not going to argue about the ABI for now but I don't think this is a
> > standard one? So
> > if acceptable you need an ABI doc.
> >=20
> Here's a random idea. (I would wait for Jonathan to weigh in first before
> assuming it is an acceptable idea though :-p)
>=20
> The config registers are pretty much going to be a one-time deal. So thos=
e
> could be written to only if they need it during probe.
>=20
> For the voltage output registers, we could add extra out_voltageY channel=
s
> that are the power-on output state channels. So writing to out_voltageY_r=
aw
> wouldn't change any real output but would just be written to EEPROM. This
> way these voltages could be controlled independently from the real output=
s
> and it uses existing ABI.
>=20
> In any case, it would be interesting to hear more about how this chips ar=
e
> actually used to better understand this EEPROM feature.

I didn't really looked at the datasheet so this can be totally wrong. But w=
e
have some LTC parts (mainly hwmon stuff) that are also packed with an EEPRO=
N.
AFAIU, the usecase in there is to have some defaults you can program in the
chips (and there's a feature we can enable so the chip can save things into=
 the
eeprom automatically). Now, in those drivers we don't really support doing
anything with the eeprom at runtime so I'm curious to see how this unfolds =
:)

- Nuno S=C3=A1

