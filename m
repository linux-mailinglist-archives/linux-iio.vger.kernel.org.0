Return-Path: <linux-iio+bounces-7703-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC71934EED
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 16:11:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2020EB2116F
	for <lists+linux-iio@lfdr.de>; Thu, 18 Jul 2024 14:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D370214037F;
	Thu, 18 Jul 2024 14:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KA8jpdDd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87EE84DF5;
	Thu, 18 Jul 2024 14:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721311894; cv=none; b=nKiumujLb4U8HrX39+5VSVGrhVP4PVRkvn7iO+n6gDbPJwOpP8N/+FPdw+uQV231MjRLEDOFp3hi2m5MdXHXQ5otxl61Vu+iJ241atMFtEPU6cxv36N9w+DRLPcwqG8PSqugQehTsqW9lHBPuLxCtCjF/pvqJWPi1UrzV313u3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721311894; c=relaxed/simple;
	bh=2YZH8d86zhNoAXZsmN7Jy0uH6vk5sSR4tnolhTxPdZ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=de23nyOLMYJuajeRfCFGl/Kv8PmoBMWVfq17YP/BALlE4lA3xRywcJZ2vc0h6D+MFEHevsWIKwTWanW0HRSScFEHdm9YWrGvFLMTkVaYB0+xs6ys/lggdAbpUIq5HFTSV7eVSof+8SMsYHrkyysSgNCeECpUzguS2Xj2KVbhdIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KA8jpdDd; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-368440b073bso512963f8f.0;
        Thu, 18 Jul 2024 07:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721311890; x=1721916690; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gcgToNk8qcN02adscfnW/Yi93yP0U71w2F/FskS6Zwc=;
        b=KA8jpdDdMWsEehi3tXpBfnW+IQdzlqRCbTS5uYuKo+4Id+YH5ywSZFU5hkMA73GJSR
         gtXBADm+89kueQsyCiD771o85Xm/cea6GFapb3gccuvT6sjpVXY1zzIkXnxkM2ChbZH9
         46M9PNALUlHoBxL9seFxXj+IWcg3nJwD1vUg9TNdkrSoohW9afW+x39dATGB2sCJVC4D
         CIlDpwX91xnrb8WWr1W2VoabQgeliFslUD/HoWhIhDsOYqcKwnxHRcgUdDi4JQ+690iy
         YV1GYShI88eAMeun9ZtO0UY2yMC8I4j8LzlphiR9RcTPnEjmpLOLN9/3wByyPfb34Qoj
         dOAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721311890; x=1721916690;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcgToNk8qcN02adscfnW/Yi93yP0U71w2F/FskS6Zwc=;
        b=pOtyk1lHfpxLYLw/tGjU4xzc+eXlLrvB6RmO70lyNtfyDC5XxiWfMa/FfFi3BKJZKI
         syCMK3g9ulB8QCC2a68UPN7s8d+qQgReZFLsbMcoOSjHBd89FqdEw68wWrnnBmPj9L4p
         zwJ1hQgrwLdm7a88/n9/WVLWypgffC3UFzZ+xGKYDQDZXw0o4mfm6pg1LXLJ73yVHWWq
         LEm2rotNTQr+1/J6Y5eelh94ZbZdjMnITqS6NaLzVFLDTQo6Z+aZF3y7lqDKkAfuwLJr
         7GU/zD8Co3R3kPTN9Ht3vtKblLqeH8S40eSuaKjD3+XpxekZ+6e93HDisCmS3G0DpkTH
         2vrA==
X-Forwarded-Encrypted: i=1; AJvYcCXmIqp7QKX5ysLj7JoYvNCsMdiu5o65XtHGQebHlXK/DOxxiA1/rM7LC+vRtFuGaHI/HbqC81EXOG7WgWF7RWiMCoB6UoIoiASVpkckiWunVrpu6Te6z30ZQMxFAvr/5l5pxEts7SSd5WGp4xNDMM9mVFxWnqRgta70svhsVksmSY8FAg==
X-Gm-Message-State: AOJu0YxrZ/k2r9r85kb47CqsnBEKuj2b8SC9yO0CwUJ0cKrn2W+dgtYI
	JPQcsUQz42eA3bzCNT5y5CfPUaSVU8rn2HOzE1iKrkx2eUZYI9Pg
X-Google-Smtp-Source: AGHT+IG71+3aw2Jq5mJojFBWIZygGTLzj0MfAIrm7rByhpxnpNdP3dntB8pf7/cEMDYT/68KL+i7yw==
X-Received: by 2002:a5d:6449:0:b0:363:776:821b with SMTP id ffacd0b85a97d-3684b0c42e4mr2153591f8f.0.1721311889901;
        Thu, 18 Jul 2024 07:11:29 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:359b:e801:d44:32b3:6924:10d1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427d2b1e314sm15669765e9.26.2024.07.18.07.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 07:11:29 -0700 (PDT)
Message-ID: <5cf5e7d388813fca604b7fc5bdb3bb7296255217.camel@gmail.com>
Subject: Re: [PATCH v7 4/4] iio: adc: ad7192: Add clock provider
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jonathan Cameron
 <jic23@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Date: Thu, 18 Jul 2024 16:11:29 +0200
In-Reply-To: <20240717212535.8348-5-alisa.roman@analog.com>
References: <20240717212535.8348-1-alisa.roman@analog.com>
	 <20240717212535.8348-5-alisa.roman@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-18 at 00:25 +0300, Alisa-Dariana Roman wrote:
> Internal clock of AD719X devices can be made available on MCLK2 pin. Add
> clock provider to support this functionality when clock cells property
> is present.
>=20
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---

minor thing below you may consider if a re-spin is needed...

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7192.c | 92 +++++++++++++++++++++++++++++++++++++=
+++
> =C2=A01 file changed, 92 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 042319f0c641..3f803b1eefcc 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -8,6 +8,7 @@
> =C2=A0#include <linux/interrupt.h>
> =C2=A0#include <linux/bitfield.h>
> =C2=A0#include <linux/clk.h>
> +#include <linux/clk-provider.h>
> =C2=A0#include <linux/device.h>
> =C2=A0#include <linux/kernel.h>
> =C2=A0#include <linux/slab.h>
> @@ -201,6 +202,7 @@ struct ad7192_chip_info {
> =C2=A0struct ad7192_state {
> =C2=A0	const struct ad7192_chip_info	*chip_info;
> =C2=A0	struct clk			*mclk;
> +	struct clk_hw			int_clk_hw;
> =C2=A0	u16				int_vref_mv;
> =C2=A0	u32				aincom_mv;
> =C2=A0	u32				fclk;
> @@ -406,6 +408,91 @@ static const char *const ad7192_clock_names[] =3D {
> =C2=A0	"mclk"
> =C2=A0};
> =C2=A0
> +static struct ad7192_state *clk_hw_to_ad7192(struct clk_hw *hw)
> +{
> +	return container_of(hw, struct ad7192_state, int_clk_hw);
> +}
> +
> +static unsigned long ad7192_clk_recalc_rate(struct clk_hw *hw,
> +					=C2=A0=C2=A0=C2=A0 unsigned long parent_rate)
> +{
> +	return AD7192_INT_FREQ_MHZ;
> +}
> +
> +static int ad7192_clk_output_is_enabled(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +
> +	return st->clock_sel =3D=3D AD7192_CLK_INT_CO;
> +}
> +
> +static int ad7192_clk_prepare(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +	int ret;
> +
> +	st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +	st->mode |=3D AD7192_CLK_INT_CO;
> +
> +	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret)
> +		return ret;
> +
> +	st->clock_sel =3D AD7192_CLK_INT_CO;
> +
> +	return 0;
> +}
> +
> +static void ad7192_clk_unprepare(struct clk_hw *hw)
> +{
> +	struct ad7192_state *st =3D clk_hw_to_ad7192(hw);
> +	int ret;
> +
> +	st->mode &=3D ~AD7192_MODE_CLKSRC_MASK;
> +	st->mode |=3D AD7192_CLK_INT;
> +
> +	ret =3D ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +	if (ret)
> +		return;
> +
> +	st->clock_sel =3D AD7192_CLK_INT;
> +}
> +
> +static const struct clk_ops ad7192_int_clk_ops =3D {
> +	.recalc_rate =3D ad7192_clk_recalc_rate,
> +	.is_enabled =3D ad7192_clk_output_is_enabled,
> +	.prepare =3D ad7192_clk_prepare,
> +	.unprepare =3D ad7192_clk_unprepare,
> +};
> +
> +static int ad7192_register_clk_provider(struct ad7192_state *st)
> +{
> +	struct device *dev =3D &st->sd.spi->dev;
> +	struct clk_init_data init =3D {};
> +	int ret;
> +
> +	if (!device_property_present(dev, "#clock-cells"))
> +		return 0;
> +
> +	if (!IS_ENABLED(CONFIG_COMMON_CLK))
> +		return 0;
>=20

nit: This could be the first test to do. No point in calling
device_property_present() if CONFIG_COMMON_CLK is disabled. FWIW, the compi=
ler should
be smart enough to sort things out but it would still be better (for readab=
ility) to
have this first.

- Nuno S=C3=A1



