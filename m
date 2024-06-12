Return-Path: <linux-iio+bounces-6192-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D67EE90519A
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 13:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0BB1F224E9
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2024 11:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 877EB16F0ED;
	Wed, 12 Jun 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JXTTvfkn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939FD16D4D3;
	Wed, 12 Jun 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718193024; cv=none; b=uuWkpgkVr7SVCrxsZDDpqsVv2RbkyrOuqqdbMAJJf6mPKzCS48/jCszclse3a+XxMdGdi1UQmSKCHd8RiPXQUkjQpv3Q0mAoFICY651xH2Fiy1+lLvpeG4Cpylhcs1jyoCXyv4w5RLNdMsVZelXbMteM3Bo2n7NgWIS7dCt6m4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718193024; c=relaxed/simple;
	bh=3eKOWjrVJava8YNnTU7U4+iYN/4hSdOslNxJluc1cYs=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryomiZ7/HZ4q1IaDKSZLCZGLqUSLcQ3l0we08s6huCC1fyjBxa8NihFwT5fC88d/5j385RJNGwbL6GKkgCj73CELhVWfUGHyBh1E0OlQIqT1TZcQi68SexJzSQvWI6zEJgGu5ql1nAd68rK0IkA8xUkD9acEIHc97vquoBmRCTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JXTTvfkn; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a6efae34c83so518055666b.0;
        Wed, 12 Jun 2024 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718193021; x=1718797821; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FTZ1hyJcf6QF0wQ81I5HTj1gs6efTfWrUVdJjnNkCg=;
        b=JXTTvfkn/ZThcfO6yUefOvkPwjsFwZjcpZiHPGt2kpy//lZp8a1FYIM3SZVjpQUjDU
         DcougL/BW2aNOFALmbHZ/ClA758OYxcoDPlVC1mg1gm4hdhQ/NKGKrv9eMObrD2T7LTP
         /8VHabwzSR2dDShi6iTj43senAVt3x2RfkS9MNOFYK7F58pW/teY8enSxC4oo+g9hmeV
         5qXSuWXR1lWTbrJVXEoP7nrADrEALK5oELW+MTdAljrt7MGP7D39c9kTV/kCDiD5iJum
         3jp8Wq+pO/hqoWMsOHwBIOxWQweK6igeT6z3hQ2v0srURsstv4zay5OqfR3I2xD14Prv
         RYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718193021; x=1718797821;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6FTZ1hyJcf6QF0wQ81I5HTj1gs6efTfWrUVdJjnNkCg=;
        b=h/SIv3XO+Z8uaxcl7ZeKhxwXefpiCYgt3eKcbhSS6o7icFn34PYdhKYt4ec5HAfhbf
         CFQnRqVDAf7CmEtSUXQ1I0t9SLkf/Vhbj0auWh4iZRBTrvA6JAqvL3IW/c4WQlyGvPJ2
         hxLij/Ax6RQORde2OHkUgbAavH2n/fKZM/W09h/RXkWRnrK0yk4bOz3uqBoSCkGw34Vu
         IrO3/5e2kRnfl8Zars2xtsaj/6W/BUMtEwlvgrbJwznYRb9o1O3rrH2MRXLQ3HILVkw7
         3vRZUCVtaHD0h20pkzuzBhDDTqF+lLLTGf4PuZBIJ7fTpbv/kSJys+0VeyXmEmZzGp9H
         kuNw==
X-Forwarded-Encrypted: i=1; AJvYcCU3gmsOBLPV9R+WFpFDJko0VHMyVWdzt09asGgXbcynG0XW4+WpAcp6jCBPYe8i6ov1vWiDdYwpn/K83kvtgBgp46pVRjHkiecQCf/Qo+QQu6sS78kqdECd3LLxHyBOOb1fsyuzOQaERwKW4hUiOIY513JA1milBO3NtO6C42S94i6qwg==
X-Gm-Message-State: AOJu0YzwWSsO2gkJmdy3KmncCXnUBIc0d/aOc/Fosn/N71KY3noleuva
	KuKiOH7Wfk2Ud3FaNRQLGtfpUgG0h8doLR8r+tbsZJuT0vs73JHr
X-Google-Smtp-Source: AGHT+IHaFPqZF682IyxegQxDj1aKjCaUc+FExsq1xSH8oq6DTf27dquNCAbDGoQHjmPS7nuxLnzYRw==
X-Received: by 2002:a17:906:9a9:b0:a6e:372c:cc5e with SMTP id a640c23a62f3a-a6f47fd6f28mr82582966b.61.1718193020451;
        Wed, 12 Jun 2024 04:50:20 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1c:c500:994e:fbde:478:1ce1? (p200300f6ef1cc500994efbde04781ce1.dip0.t-ipconnect.de. [2003:f6:ef1c:c500:994e:fbde:478:1ce1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f0c410d31sm553091566b.73.2024.06.12.04.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 04:50:20 -0700 (PDT)
Message-ID: <b9c974265111887e7a944cb9e854e86cc8bcd47c.camel@gmail.com>
Subject: Re: [PATCH v3 2/2] iio: frequency: adf4350: add clk provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 12 Jun 2024 13:54:07 +0200
In-Reply-To: <20240612104554.66851-2-antoniu.miclaus@analog.com>
References: <20240612104554.66851-1-antoniu.miclaus@analog.com>
	 <20240612104554.66851-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Antonium

On Wed, 2024-06-12 at 13:45 +0300, Antoniu Miclaus wrote:
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
> changes in v3:
> =C2=A0- use container_of to directly access the adf4350_state structure.
> =C2=A0drivers/iio/frequency/adf4350.c | 118 +++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 118 insertions(+)
>=20
> diff --git a/drivers/iio/frequency/adf4350.c b/drivers/iio/frequency/adf4=
350.c
> index 4abf80f75ef5..f716f744baa9 100644
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
> +#define to_state(_hw) container_of(_hw, struct adf4350_state, hw)
> +

nit: to_adf4350_state() would be neater...

> =C2=A0static struct adf4350_platform_data default_pdata =3D {
> =C2=A0	.channel_spacing =3D 10000,
> =C2=A0	.r2_user_settings =3D ADF4350_REG2_PD_POLARITY_POS |
> @@ -264,6 +270,10 @@ static ssize_t adf4350_write(struct iio_dev *indio_d=
ev,
> =C2=A0	mutex_lock(&st->lock);
> =C2=A0	switch ((u32)private) {
> =C2=A0	case ADF4350_FREQ:
> +		if (st->clkout) {
> +			ret =3D clk_set_rate(st->clkout, readin);
> +			break;
> +		}

So, apparently you forgot or decided otherwise to not go with the suggestio=
n of
not including the IIO interface (at least he channel one - debugfs could be
maintained I guess) or with the more in the middle approach Michael suggest=
ed.
Just not allowing ADF4350_FREQ and ADF4350_FREQ_REFIN.

Hence, I would expect at least some justification to keep the above in your=
 v3
changelog. Also note that keeping ADF4350_FREQ_REFIN while being a clock
provider seems pointless and maybe even be wrong (as the clock framework sh=
ould
take care of the parent clock). This also brings another question... see be=
low

...

>=20
> +static int adf4350_clk_register(struct adf4350_state *st)
> +{
> +	struct spi_device *spi =3D st->spi;
> +	struct clk_init_data init;
> +	struct clk *clk;
> +	const char *parent_name;
> +	int ret;
> +
> +	if (!device_property_present(&spi->dev, "#clock-cells"))
> +		return 0;
> +
> +	init.name =3D devm_kasprintf(&spi->dev, GFP_KERNEL, "%s-clk",
> +				=C2=A0=C2=A0 fwnode_get_name(dev_fwnode(&spi->dev)));
> +	device_property_read_string(&spi->dev, "clock-output-names",
> +				=C2=A0=C2=A0=C2=A0 &init.name);
> +
> +	parent_name =3D of_clk_get_parent_name(spi->dev.of_node, 0);
> +	if (!parent_name)
> +		return -EINVAL;
> +
> +	init.ops =3D &adf4350_clk_ops;
> +	init.parent_names =3D &parent_name;
> +	init.num_parents =3D 1;

Shouldn't we set CLK_SET_RATE_PARENT in init.flags?

- Nuno S=C3=A1



