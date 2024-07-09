Return-Path: <linux-iio+bounces-7458-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13A0E92B14B
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE9762825C6
	for <lists+linux-iio@lfdr.de>; Tue,  9 Jul 2024 07:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6B614374C;
	Tue,  9 Jul 2024 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqlOdBIy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5258827713;
	Tue,  9 Jul 2024 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720510648; cv=none; b=bjJM2QiKl2njvx1M7Nic8U3XnN9oM1eJDmTcUyF7TGZQgUOuF76/4aoyvvkdlfGXUEdr0r6p1KKE9xplwUHZ5f3puy5yzvwTKq5+lsc8b1NHzhiB5EQv56w6lxic/XCsxOEhp//2TPAdKSfSM8mD24J/z8OzxdUyKnuvYuAg8N4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720510648; c=relaxed/simple;
	bh=HyE1OC2jUz69RbLf+QbjEwXtvPn9VOx/T6a0hK703Co=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rVxSUV2qRQVewxFQOqFsC0eAl/FyFMflykLPgT3MvZ/JTWDbpfdkK/q1eNii0r+BUOPVcJUUX4xInPCbPjpIUqaZNHP5FUJ+mxpIFqAoX71YXICR0a17HgwboujFeR9HETdBiFpMXG/BOSiWRxFtPEPPqM6KLgeqb8CeSxf+ISA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqlOdBIy; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2ee910d6aaeso53860861fa.1;
        Tue, 09 Jul 2024 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720510645; x=1721115445; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gJblcrgCB69StiCEtXH3DZ/GYofswUEElGj+y5LAqrc=;
        b=dqlOdBIy3T1ujy5KSBThBeW3TzJu9lv6DKxYBcQtxLtfurTbhJ1MiTNQ07KZV7+IXo
         3OIRr/paFAnPf4a8eMasuDEb/R3/SD3I3cq85jKVMEUO5at0/xvoa5qc0OuFjD3tO5zC
         AwZs49ySZ5KjqQW2zejnVASd2oFWWdWjUvPIB1a/ihlRVrg11/nzwcGacdMjJkqWFlua
         PtgDtwD3HVsjP3JqZan6PnibLC8XuiAc5hQEWDdmJG19ftpdkVlgT32L/1M06Kz9T2sd
         pQdsb7eNRaUZljbP6KvNBac82kBJagY2GozJuZvRq6fM+JJKxoOZ5nXnAXjRLOLXjWW0
         xPsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720510645; x=1721115445;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gJblcrgCB69StiCEtXH3DZ/GYofswUEElGj+y5LAqrc=;
        b=JXYdjJXgYM+vce3xZKaS8ooJWfcYIDe7JY8QNbQR6B38TwVhCM32d2zXmJhvovcQ0p
         x2izwinsBR7cEIENZOvTSQXZX/aQ/rnLqYUN+3fElYap5HanS7IgBOtt9wEdme2gHEwX
         rWvmqpa/LDAOs+tXT5mtDK6PdZCTVhHuVedAMbxyUpsEYcpdRG2yZg6VEcoj3365V7FY
         GNFbbNm4B79aaM2e4ZteDGgEWc0mZmMDvEALD/f2ifnGC6gjIEor2alRxevYAWhhikAr
         JBOd+mgsHtCNLdHuS9s6Fv7a8PE1rsc2xhDxpwVuhal4cCPc+/C3Ex30bQHDM6DZSqv/
         QKgA==
X-Forwarded-Encrypted: i=1; AJvYcCVO+eYYpy3xqfkuvyIsxu7JgjeQwt8+YJKOgPVmB7mD0GtTy1E3yqMBKSfoQD2AIAr3wlxQ8eSCo2ZkuAl5ap5EcRNau2KgwjaYnpWiq7odRf+Fs2ECrdApiZGmJ/Cl4NkA8JDKzdPAgcqsIDrIKfgdCZO44ZbxoWnfHb7fd9pqsI74VzDK0pExxH6HuUj9ccAuvkucnn3Fnxq/cOdTWg==
X-Gm-Message-State: AOJu0YyQf4X9/PE7s57PAS01EbDBgqscgUUYr5Y8EgjhQqSJch2dlFmE
	jj6RL+NiW9o1KD28TXW6Hs102tiLADOVBBt/DKvWCXJaJ9Q5UWht
X-Google-Smtp-Source: AGHT+IF1DuvD0MmXmObeiIwlMnO3IreBxRQdx/tSoUTS0K1lrv/8qspqFspqy+cy1inG25V9c4HGcw==
X-Received: by 2002:a05:6512:31c8:b0:52d:b118:5063 with SMTP id 2adb3069b0e04-52eb99cc6camr965176e87.47.1720510645078;
        Tue, 09 Jul 2024 00:37:25 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:ee59:d953:f148:40ba? (p200300f6ef1cc500ee59d953f14840ba.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:ee59:d953:f148:40ba])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bd459e2csm737131a12.65.2024.07.09.00.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 00:37:24 -0700 (PDT)
Message-ID: <5c7fcaa93c8184dd62beeccccfa07e144042fdc4.camel@gmail.com>
Subject: Re: [PATCH v6 6/7] iio: adc: Add support for AD4000
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, broonie@kernel.org, 
 lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
  nuno.sa@analog.com, dlechner@baylibre.com, corbet@lwn.net, 
 marcelo.schmitt1@gmail.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Tue, 09 Jul 2024 09:41:18 +0200
In-Reply-To: <628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
References: <cover.1719686465.git.marcelo.schmitt@analog.com>
	 <628a85cb8cbee32ea7d2930c63e73f2ef449a800.1719686465.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-06-29 at 16:06 -0300, Marcelo Schmitt wrote:
> Add support for AD4000 series of low noise, low power, high speed,
> successive approximation register (SAR) ADCs.
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---

Hi Marcelo,

LGTM. Only one thing that needs to be addressed. With that,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/Kconfig=C2=A0 |=C2=A0 12 +
> =C2=A0drivers/iio/adc/Makefile |=C2=A0=C2=A0 1 +
> =C2=A0drivers/iio/adc/ad4000.c | 708 ++++++++++++++++++++++++++++++++++++=
+++
> =C2=A04 files changed, 722 insertions(+)
> =C2=A0create mode 100644 drivers/iio/adc/ad4000.c
>=20

...

>=20
> +	st->gain_milli =3D 1000;
> +	if (chip->has_hardware_gain &&
> +	=C2=A0=C2=A0=C2=A0 device_property_present(dev, "adi,gain-milli")) {
> +		ret =3D device_property_read_u16(dev, "adi,gain-milli",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &st->gain_milli);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to read gain
> property\n");
> +	}

The above is odd. Why not reading directly device_property_read_u16()? Skip=
 the
call to device_property_present().=C2=A0

But most importantly, you're not doing any validation on gain_milli which i=
s an
enum (by looking at the bindings). So in theory even 0 would be accepted wh=
ich
would lead to a divide by 0 later on. I would do:

if (chip->has_hardware_gain) {
	ret =3D device_property_read_u16(...)
	if (!ret) {
		/* validate here for a proper value /*
	}
}

You can also check for ret < 0 and -EINVAL to detect an invalid devicetree
parameter instead of completely ignoring return codes (but for non mandator=
y
properties one typically does not care much - up to you)

- Nuno S=C3=A1


