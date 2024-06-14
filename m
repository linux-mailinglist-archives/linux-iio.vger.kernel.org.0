Return-Path: <linux-iio+bounces-6276-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7AE908E9F
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 17:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4FFA1F21498
	for <lists+linux-iio@lfdr.de>; Fri, 14 Jun 2024 15:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E597E17FADB;
	Fri, 14 Jun 2024 15:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9M/a33n"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB4F171082;
	Fri, 14 Jun 2024 15:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718378621; cv=none; b=c0Kvw69hJT3944ltd0LBR/Fw6MNAimCTYCrZCocIjazQByUl6J4rjk3iNeCuwo5fQ67wx40jjzPrARM4Kk3zz08irZJGaRJ6MY/RPS63OzoFLf+Iqj+IVi2DhWsK1R3QWd1RATtzcpz/aYwExyCP4ACAYdkxkIJwpSjevtCOF3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718378621; c=relaxed/simple;
	bh=rE3BnVtzjXG1HQP7KK8YhqFpU0yRwgn4LRCh3pJlmjQ=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6kw4fobGjd1ac0J1MLwoJcLtlUP5lkJ8SARJp8597xPlPQ3+ke0k+4KPYspxgFf1YQkZAB3LFgQtyxTJfpBmxADAgcjt6It9v0JYXPc1chnBGwKd7CswsVNOOCJ5leeNY0WYHZUFWfnKTF5qa8UUvbZCpA2Hau+1/uOstOPuxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9M/a33n; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-57a31d63b6bso3083897a12.0;
        Fri, 14 Jun 2024 08:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718378618; x=1718983418; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h9OdnYF4UyN/cVgcAYpH96GtKoeiuqLKBw2Oa4MGr/I=;
        b=S9M/a33nOlLwcomjzWg0IpGtxXhBPLtnzQPGGq40swiGATlKFrlHF0Xb1/1DgcgHC/
         MyCZ48nKHTSsHrk1YhwuZ51chRc9xWxWpTtDsa+9D/zLb4eDul99ESC24mPhTfwfH0UR
         dT7R95g1pzINdEMKmaKNG+RGwr/G3ORUNSO8LyYdHonXlodhuvHLvKPl8gPgiY/TkR5E
         ZPKRu+Id1pzjbLDgknOYUA4usWcTk5CNyq1Ft0O384XsV6CjoLRgnW9Ugx66Vv84z54E
         J12rmV87X8Gdr9H3+eUn5lw+hrz2NsXgn2pjAqBqm9xH7w+UFLBUG/ZgvqC7wOU60SCc
         4kVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718378618; x=1718983418;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h9OdnYF4UyN/cVgcAYpH96GtKoeiuqLKBw2Oa4MGr/I=;
        b=rNgGeij0P+3xfhO5hzM5Ui75mzlcvz1FDH4C789LVXMsClhJrp3QchWXC9EjX/8zcL
         bGogIhXCWw9TYI0rouPb4PD1BOuXqjNTD+wwbAMjuHqZpFqnXy5IVV7UzUtAJGDGg9Ym
         Oum8fbBBSbSgG0wXafzpkm+AG5H67oM6qZUE3VAFa0+KSghf91B9ECOiBaYCIVjXnfcw
         8MaOT9NBy8zmX37XDDK49IeWKus8YdkBQvoQfC5LuMJGbdEfDSXRA/jAEHrukFgYS3H2
         Hgb+1eoQIhb8PpVcYioTfuZ5RmQs7FSQJxyj2RG2M9kpZH+PyMRJnkfld0SHiNyzAAM7
         OJ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoGBHwHYgWbdxprFWsu2E1YoBxDFr2oeOHrsOyR9yZ3n58d0fbGDAC2hbEHh00HaJ2IJMr8VmXHkcfHqsvhJ91Ar6Ha0Fp5l94EsLsU01aNrpEgldykc7AnQrfBABMpgE1sBgkR9/xE+cbxr/fLBxjCVuVraMwTHEKJIQbo35SoCsZgw==
X-Gm-Message-State: AOJu0YwqILHcCVdOPQqXb0p0I92OPBslrwSVSmX2VB7IDYh5nFnghZ15
	9r6cHizIvrPLO8Bt3cDnWIzjZnv0AVHFwHMn5LkKXy32f9tx43YQ
X-Google-Smtp-Source: AGHT+IEjPDg40yfrzw//2lH7maNSEzK9o2sIQhEYuRNrAZF+ikJvot6sYR/NC4ZQqOamvU0MomxEXw==
X-Received: by 2002:a50:ab15:0:b0:57a:31eb:83da with SMTP id 4fb4d7f45d1cf-57cbd69c3b5mr2654930a12.30.1718378618109;
        Fri, 14 Jun 2024 08:23:38 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb72da708sm2408125a12.37.2024.06.14.08.23.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 08:23:37 -0700 (PDT)
Message-ID: <4e7e3080857b5822011734776de7456787dda546.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: frequency: adf4350: add clk provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 14 Jun 2024 17:23:37 +0200
In-Reply-To: <20240612130232.7692-2-antoniu.miclaus@analog.com>
References: <20240612130232.7692-1-antoniu.miclaus@analog.com>
	 <20240612130232.7692-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 16:02 +0300, Antoniu Miclaus wrote:
> Add clk provider feature for the adf4350.
>=20
> Even though the driver was sent as an IIO driver in most cases the
> device is actually seen as a clock provider.
>=20
> This patch aims to cover actual usecases requested by users in order to
> completely control the output frequencies from userspace.
>=20
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
> changes in v4:
> =C2=A0- rename macro to `to_adf4350_state`
> =C2=A0- do not expose ADF4350_FREQ and ADF4350_FREQ_REFIN if driver is us=
ed as clk
> =C2=A0=C2=A0 provider.
> =C2=A0- initialize flags with CLK_SET_RATE_PARENT
> =C2=A0drivers/iio/frequency/adf4350.c | 134 +++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 133 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4=
350.c
> index 4abf80f75ef5..8309ddfca9af 100644
> --- a/drivers/iio/frequency/adf4350.c
> +++ b/drivers/iio/frequency/adf4350.c
> @@ -19,6 +19,7 @@
> =C2=A0#include <linux/gpio/consumer.h>
> =C2=A0#include <asm/div64.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> =C2=A0
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/sysfs.h>
> @@ -36,6 +37,9 @@ struct adf4350_state {
> =C2=A0	struct gpio_desc		*lock_detect_gpiod;
> =C2=A0	struct adf4350_platform_data	*pdata;
> =C2=A0	struct clk			*clk;
> +	struct clk			*clkout;
> +	const char			*clk_out_name;
> +	struct clk_hw			hw;
> =C2=A0	unsigned long			clkin;
> =C2=A0	unsigned long			chspc; /* Channel Spacing */
> =C2=A0	unsigned long			fpfd; /* Phase Frequency Detector */
> @@ -61,6 +65,8 @@ struct adf4350_state {
> =C2=A0	__be32				val __aligned(IIO_DMA_MINALIGN);
> =C2=A0};
> =C2=A0
> +#define to_adf4350_state(_hw) container_of(_hw, struct adf4350_state, hw=
)
> +
> =C2=A0static struct adf4350_platform_data default_pdata =3D {
> =C2=A0	.channel_spacing =3D 10000,
> =C2=A0	.r2_user_settings =3D ADF4350_REG2_PD_POLARITY_POS |
> @@ -370,6 +376,12 @@ static const struct iio_chan_spec_ext_info adf4350_e=
xt_info[]
> =3D {
> =C2=A0	{ },
> =C2=A0};
> =C2=A0
> +static const struct iio_chan_spec_ext_info adf4350_clk_ext_info[] =3D {
> +	_ADF4350_EXT_INFO("frequency_resolution", ADF4350_FREQ_RESOLUTION),
> +	_ADF4350_EXT_INFO("powerdown", ADF4350_PWRDOWN),
> +	{ },

Do we really need powerdown? Dunno :). I would expect one of unprepare/disa=
ble to
take care of that. Moreover, imagine userspace powers down the device while=
 an in
kernel consumer was using it? Not cool right ehhe?

Even the frequency_resolution is arguable as that is also a DT property but=
 to keep
consistency why not? That one I can live with...

Also note that you're still not including the clock maintainers in the loop=
.

- Nuno S=C3=A1


