Return-Path: <linux-iio+bounces-11955-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0FD19BFADB
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 01:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6B70283E73
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 00:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3548F40;
	Thu,  7 Nov 2024 00:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E3O/Nc0C"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2A9610C;
	Thu,  7 Nov 2024 00:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940121; cv=none; b=GfA3hM9Gixw2b1ygPrQCtwi/aNk/POUDfbN73gL4vXPi6NOHNHhvJawJElUKagbSZWbMYPCaTkhS2IgeXfjVEnokTWLVEpDi46rg64FTHoBNnHTgpCXgv+ZMlesjGGw0jWaUFQ/7TkiVtLAr6uCC7BTfDN8j/EeUQu4o0m9X19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940121; c=relaxed/simple;
	bh=hAjtIWJwG97lfyLvJOP2RLBgMJSNdcuxF70ZTNCC4Sk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kyhC2H+l8sEhK3Z1KQbDGDdfR0gQcI9jRljFX/O3IV80fC+eaa01i3QWlPJo1TLsJ/aZGSChH31eS6/MZBFsxSK8Hh3SBkwUEQzoyZGnWnlXzSzbqEBdAKQ2Gn1pg52WxCyuOCxj1T0oN9kkz8rqXo1g2CGAznfw5pIHO+8lB3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E3O/Nc0C; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a850270e2so59888466b.0;
        Wed, 06 Nov 2024 16:41:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730940118; x=1731544918; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=66oG7Evm9+fKx2Sv7uu5FGZ2ExWy4GsOBS3MW/kR5U0=;
        b=E3O/Nc0C2qt/H4671GFMkuG8ybkmQCagXx5/vaHfSonBieTqepxmZKNv2TzE2iVkX2
         A6E+1mK34ZGb/oMkkkMu2D789TsiF1ZcnHW3dCjWxG3Dbbn+FWfreiMHmFmEzjwBe1Qz
         4o5OMKZkPuXLK0aUqwjIVgfIm2fztSULXyO8Th69FV7uuxnJvzKFjHdLCgtQf6duWmxR
         P2pw3Muv3bSkUm1PhabCcNP3XnAeNqKAeYFPVO97031z4b4XzjbACWDmGmMQTFqBmR/5
         YaHVJVJFOUXSlSKFA0msAWGFVsqDFOX3U4oPnbNhwdUebNRRVo/nFlPJorrffDYBbpq3
         rrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730940118; x=1731544918;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=66oG7Evm9+fKx2Sv7uu5FGZ2ExWy4GsOBS3MW/kR5U0=;
        b=SUtmpz+Kpftm6Tj8LKHKWpCKg9lNccpwQZrazxQipZjG5Je9T3FfYijuhPiCzIhhC1
         CQ7GIqjBx0gnMCqPd2fCeFQkrvLEidjiNE3UWKOupMGxagwt66crdaIjumiq7twmCJIR
         AaPjZv0esQQkp1/sOE5tekxH8wf5Otzm1MczPbKXtMJ0vWIXddyu1D4CS9YNPBn4kfvj
         5m0y80ggctZeoczLJwic3um4AcgYLLw06yRxLuBqVkE8b9Esq9WaPO/qpUIxvR1tPyi0
         n4Bi6ozok4kwSVZUVpuFfRNXyqUYrJViHo8Lta7ty65QdlFDt4NcKtZ6JMPTxkwDFmWr
         /IbA==
X-Forwarded-Encrypted: i=1; AJvYcCU5+AwawOZrXMLlTmyxN8IGyjiEVvX/O5BjAe+UbSxpcmIu17mzqKCUsH1bP/iC29LdiIxSJwIL28W3zhUY@vger.kernel.org, AJvYcCUOio0VNnOarw+V7kdE4kplAXNb74Y0ok50cL+UuzB5CexBnYFcX/C8XnNzAGAMjGDNUX1GGypjM0VN@vger.kernel.org, AJvYcCWJoHu1UVZnDCBKJBboCUyPVKbpggjTNKuiK5RfK3ViB1E+/ULKFMcsUbGneL3aXdqgOMJ4BTXyDo3L@vger.kernel.org
X-Gm-Message-State: AOJu0YzWKFMTe41ardi6DmgrA0PXBMj3mktPmPosuG/1gcbD6vIb/+ZJ
	apYlKxMIMm8dsATq+ZaoMBb5Vx86qDpWpBNw/aCry1Tt0F63GeDZFDdYTLUgro2LBHeoTtdWniA
	67cm5wCqbVgwQix6FAuVgsVM7dhQ=
X-Google-Smtp-Source: AGHT+IFcrzeVPHrPu3r5o/8SX2WmAgtljAMZ1fBMXVtmRh7kPMQ7Eay15HFqYWHFnPv0n8wziB8+N0K2wbH0aWKy27s=
X-Received: by 2002:a17:907:7ea9:b0:a9e:1fa0:d2f0 with SMTP id
 a640c23a62f3a-a9e6556fe06mr2153334266b.19.1730940118106; Wed, 06 Nov 2024
 16:41:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241106023916.440767-1-j2anfernee@gmail.com> <20241106023916.440767-3-j2anfernee@gmail.com>
 <fd4db31d-4e55-4f0e-a96d-d193c28fd784@kernel.org>
In-Reply-To: <fd4db31d-4e55-4f0e-a96d-d193c28fd784@kernel.org>
From: Yu-Hsian Yang <j2anfernee@gmail.com>
Date: Thu, 7 Nov 2024 08:41:21 +0800
Message-ID: <CA+4VgcJSt-LUNtH6TMpk7om+PbO1aQvmt1WHi-cYMxa8p+Um5A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] iio: adc: add Nuvoton NCT720x ADC driver
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com, 
	venture@google.com, yuenn@google.com, benjaminfair@google.com, 
	jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com, 
	javier.carrasco.cruz@gmail.com, andy@kernel.org, marcelo.schmitt@analog.com, 
	olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, 
	matteomartelli3@gmail.com, alisadariana@gmail.com, joao.goncalves@toradex.com, 
	marius.cristea@microchip.com, mike.looijmans@topic.nl, 
	chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com, 
	openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Dear Krzysztof Kozlowski,

Thank you for your response.

Krzysztof Kozlowski <krzk@kernel.org> =E6=96=BC 2024=E5=B9=B411=E6=9C=886=
=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=889:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> On 06/11/2024 03:39, Eason Yang wrote:
> > Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> >
> > NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up =
to
> > 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins fo=
r
> > independent alarm signals, and the all threshold values could be set fo=
r
> > system protection without any timing delay. It also supports reset inpu=
t
> > RSTIN# to recover system from a fault condition.
> >
> > Currently, only single-edge mode conversion and threshold events suppor=
t.
> >
> > Signed-off-by: Eason Yang <j2anfernee@gmail.com>
>
> ...
>
> > +
> > +static int nct720x_probe(struct i2c_client *client)
> > +{
> > +     const struct i2c_device_id *id =3D i2c_client_get_device_id(clien=
t);
> > +     struct nct720x_chip_info *chip;
> > +     struct iio_dev *indio_dev;
> > +     int ret;
> > +     u32 tmp;
> > +
> > +     indio_dev =3D devm_iio_device_alloc(&client->dev, sizeof(*chip));
> > +     if (!indio_dev)
> > +             return -ENOMEM;
> > +     chip =3D iio_priv(indio_dev);
> > +
> > +     if (client->dev.of_node)
> > +             chip->type =3D (enum nct720x_chips)device_get_match_data(=
&client->dev);
> > +     else
> > +             chip->type =3D i2c_match_id(nct720x_id, client)->driver_d=
ata;
>
> I believe there is a I2C wrapper for above.
>

Got it.

> > +
> > +     chip->vin_max =3D (chip->type =3D=3D nct7201) ? NCT7201_VIN_MAX :=
 NCT7202_VIN_MAX;
> > +
> > +     ret =3D of_property_read_u32(client->dev.of_node, "read-vin-data-=
size", &tmp);
> > +     if (ret < 0) {
> > +             pr_err("read-vin-data-size property not found\n");
>
> Please use dev_xxx in your driver code.

Got it.

>
>
> Best regards,
> Krzysztof
>

