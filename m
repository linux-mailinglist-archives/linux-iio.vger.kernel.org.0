Return-Path: <linux-iio+bounces-2777-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B116185A50F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 14:46:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE703B225C0
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 13:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DC0364AC;
	Mon, 19 Feb 2024 13:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDIeFQEx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5042C848;
	Mon, 19 Feb 2024 13:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708350361; cv=none; b=mqKoNfH4fWvKIrICqmjzcZ2PZfj9MTnVNDKrqV8y56rOeGdVBpImfkdiT1ZGVPEdTGst440Ulwu/0ME7HqNgn/Ak2/CrlvbsSArZ4DqOpSkti+dM7XhtT1j3jIIYfqyvDoYWLSZD8J4xOI/auDnmgyn1e5h+xPjPOQ8gRCdqGoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708350361; c=relaxed/simple;
	bh=LVRTwEd+DLA5yoWWO1QyoAikwulsSgVa5Hj+jZY0/KU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ov2sL9IV3aAy4WjkuBWxrU0pmVcGAN3zvdZQge3ALOSJTK4BOP8dwGkLIipODin0U8pyYdPmAa5VXI+Q10RbQl5fGhrqkeheYJxEBfjUUtGgyWUQeTNQ665njiggpzLae+u5tLKXKoqtKwTjGBbJ0OxPe0deWB2n95Ugf2M93K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDIeFQEx; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4186348a12.3;
        Mon, 19 Feb 2024 05:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708350357; x=1708955157; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/jg6Jw6XVlwGHC6wg4qyCUXEftgbjGUXyrYMQCE+eOs=;
        b=PDIeFQExfXgWjaIlE3CqGPAzlc0YQpf90TPIkayJp61AlpKgQK0EMYF5dGEGUQZZPa
         8uf6NIhYZtlYt+lt3hQHkfSPZVTwnyEXLELiIsRIspUzEzqt/v2J7+MPzoXJkmrkUkHn
         BLjopXOnOmV2nbupznaBNC4fyaP/nFjJlM/lCdLiA7L+pWWLb8M7O6X5qJmUSvq8bsn9
         bpRLRUqwLNF5cdz8YXzR5KnkgBx+u/ZPwnWK0QrbEU5L4vrRvJjyn5s+L2O5cqHUtWaO
         z6IuphuIcWh4lvYRwDbGBkVdOQF+3g653gRfzQxcCYbP89CIFSsX799hehgJkQewL5kh
         TXgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708350357; x=1708955157;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/jg6Jw6XVlwGHC6wg4qyCUXEftgbjGUXyrYMQCE+eOs=;
        b=CUOG3KwPYAete+B49jRlGimmTCc3yIuOWfbs3U5OeiaH3ilBQUC9Ef4vUpoj60RnmO
         /LoYIdLQxaLAWploAKJQx7fRhhc1eemAMnFZVKxJrKc1eYBnmHAfWqXKgwQ232HjsJZ3
         7df7XMCCPFZx58O78Ub3Q9Oil3FLGpymIGXIvsG2zJtrblpStTcChUnjq9JU02kVirV5
         BO+XRvIKMWeUKPyeIV0JDbZ5zpsufvqZcuQN7pBKFhFcwzcDwBABMQotcmbSvRBAjPVc
         c15qUPgtKOv21HxLzsjkkjbUV2kxAHYGgsfB3d02Npi0Dq2AhLTyh5m7IihDIFuEURCl
         YeCw==
X-Forwarded-Encrypted: i=1; AJvYcCUeRkNvPL6p7J1Rvh/KusOgq4Y+6qp9y0dWFICHZ4GCLWcw0jkpDFX804SwUcXjIcSxz+5OfVD28JgdsXHrYDMtYlIfEzFCwhEI81vhbBEAhJKTjLrfHxMQWs0+3RfKllQeRkv36A==
X-Gm-Message-State: AOJu0YzxfQsskgM0030VpvuyhEDe5IiJ/ozPjOJkgwqODA42qB95KsMB
	TZYEVhmDpFQ3rUZrR4klj1HA92Z02oZRQ4aAeRmUhyjDpc2wnaF/
X-Google-Smtp-Source: AGHT+IG3aji4Ty3GEIJP9dbRMwyuvWwZbf3vrpfTuIDHxuukCje4SvBwS71gN000mbnquJt4Wn0cHw==
X-Received: by 2002:aa7:d98e:0:b0:564:1ecc:ffb1 with SMTP id u14-20020aa7d98e000000b005641eccffb1mr3817601eds.39.1708350356513;
        Mon, 19 Feb 2024 05:45:56 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id x16-20020a056402415000b005644e4fdf36sm1708994eda.6.2024.02.19.05.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Feb 2024 05:45:56 -0800 (PST)
Message-ID: <ce7ba8c4178fa05125bb91f35e3bf8c2a28098e7.camel@gmail.com>
Subject: Re: [PATCH v4 15/15] iio: dac: ltc2688: Use
 device_for_each_child_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Julia Lawall <Julia.Lawall@inria.fr>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Mihail Chindris <mihail.chindris@analog.com>,
  Rasmus Villemoes <linux@rasmusvillemoes.dk>, Tomislav Denis
 <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,  Olivier Moysan
 <olivier.moysan@foss.st.com>, Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>,  Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Date: Mon, 19 Feb 2024 14:49:17 +0100
In-Reply-To: <20240217164249.921878-16-jic23@kernel.org>
References: <20240217164249.921878-1-jic23@kernel.org>
	 <20240217164249.921878-16-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-02-17 at 16:42 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
>=20
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Tested-by: Nuno Sa <nuno.sa@analog.com>
Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> v4: Moved alignment changes back to patch 4.
> v3: Tweaked the alignment after comments from Andy.
>=20
> =C2=A0drivers/iio/dac/ltc2688.c | 24 ++++++------------------
> =C2=A01 file changed, 6 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index fc8eb53c65be..b71df03fc13b 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -746,26 +746,21 @@ static int ltc2688_span_lookup(const struct
> ltc2688_state *st, int min, int max)
> =C2=A0static int ltc2688_channel_config(struct ltc2688_state *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *child;
> =C2=A0	u32 reg, clk_input, val, tmp[2];
> =C2=A0	int ret, span;
> =C2=A0
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		struct ltc2688_chan *chan;
> =C2=A0
> =C2=A0		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> -		if (ret) {
> -			fwnode_handle_put(child);
> +		if (ret)
> =C2=A0			return dev_err_probe(dev, ret,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get reg property\n");
> -		}
> =C2=A0
> -		if (reg >=3D LTC2688_DAC_CHANNELS) {
> -			fwnode_handle_put(child);
> +		if (reg >=3D LTC2688_DAC_CHANNELS)
> =C2=A0			return dev_err_probe(dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "reg bigger than: %d\n",
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 LTC2688_DAC_CHANNELS);
> -		}
> =C2=A0
> =C2=A0		val =3D 0;
> =C2=A0		chan =3D &st->channels[reg];
> @@ -786,12 +781,10 @@ static int ltc2688_channel_config(struct ltc2688_st=
ate
> *st)
> =C2=A0		if (!ret) {
> =C2=A0			span =3D ltc2688_span_lookup(st, (int)tmp[0] / 1000,
> =C2=A0						=C2=A0=C2=A0 tmp[1] / 1000);
> -			if (span < 0) {
> -				fwnode_handle_put(child);
> +			if (span < 0)
> =C2=A0				return dev_err_probe(dev, -EINVAL,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 "output range not
> valid:[%d %d]\n",
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 tmp[0], tmp[1]);
> -			}
> =C2=A0
> =C2=A0			val |=3D FIELD_PREP(LTC2688_CH_SPAN_MSK, span);
> =C2=A0		}
> @@ -800,17 +793,14 @@ static int ltc2688_channel_config(struct ltc2688_st=
ate
> *st)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &clk_input);
> =C2=A0		if (!ret) {
> =C2=A0			if (clk_input >=3D LTC2688_CH_TGP_MAX) {
> -				fwnode_handle_put(child);
> =C2=A0				return dev_err_probe(dev, -EINVAL,
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 "toggle-dither-input inv
> value(%d)\n",
> =C2=A0						=C2=A0=C2=A0=C2=A0=C2=A0 clk_input);
> =C2=A0			}
> =C2=A0
> =C2=A0			ret =3D ltc2688_tgp_clk_setup(st, chan, child,
> clk_input);
> -			if (ret) {
> -				fwnode_handle_put(child);
> +			if (ret)
> =C2=A0				return ret;
> -			}
> =C2=A0
> =C2=A0			/*
> =C2=A0			 * 0 means software toggle which is the default mode.
> @@ -844,11 +834,9 @@ static int ltc2688_channel_config(struct ltc2688_sta=
te
> *st)
> =C2=A0
> =C2=A0		ret =3D regmap_write(st->regmap, LTC2688_CMD_CH_SETTING(reg),
> =C2=A0				=C2=A0=C2=A0 val);
> -		if (ret) {
> -			fwnode_handle_put(child);
> +		if (ret)
> =C2=A0			return dev_err_probe(dev, -EINVAL,
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0 "failed to set chan
> settings\n");
> -		}
> =C2=A0	}
> =C2=A0
> =C2=A0	return 0;


