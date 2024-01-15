Return-Path: <linux-iio+bounces-1676-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6760782D731
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 11:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F75F1C2184F
	for <lists+linux-iio@lfdr.de>; Mon, 15 Jan 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3A3FBF4;
	Mon, 15 Jan 2024 10:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LC9iWwfY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E102BAFD;
	Mon, 15 Jan 2024 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33677fb38a3so8260544f8f.0;
        Mon, 15 Jan 2024 02:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705314194; x=1705918994; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w08VG52rt+523ovbnuusv/QsOehpoyYMQf8O98TfTPM=;
        b=LC9iWwfYKYVbfmNR4Ke7i7zSd6CPtf8h53q3aGIOBc3Vw1AgHNVXXTkFLShCXMsZV4
         EhBFal3x/+vCZy1HfdMypgkt7A2Zg0jbc75+KYqJqtEdIpHyab319JKE0ib7vu0gFaW+
         tM6MW7BiqgpeyWaEnFlsyMRz1xHAiGTdOhgWC39gugvyvOfjQUA4fIOVObOk2+p189dH
         PChxvpyb5Mq4OOdwco2m+X7O71Gj8Iu+IUorGw47ARowmNvg1MGQglc63afE+Ka2sziV
         IXoWxg/rU4hRGVYU147O5idMkwvBcl9+XD9l3j6cETU8oF6fLfGLMa8FksX6ii8CrGgk
         du6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705314194; x=1705918994;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w08VG52rt+523ovbnuusv/QsOehpoyYMQf8O98TfTPM=;
        b=gCXsei2waZC+9FaPQvV+WKom31d3x3w2HWOD5dLnWhv0QZOWp1B4LJiY9xXQ0Soxlr
         M5PfcfsvH7nlxZFlZ9uiHRbwJU3898kVB5KVlSKfH/atjZI6LxlEbkdXvpBENG5A49dN
         i85mtI/gMRqXKMwdePYGw3vJgsAB/h7bGf6BQr1Gk+WjPsC57M+p2t+QW3zzRlOjp7Rj
         pG2nE/R96hsehkd+AOkyYiWe3rc/I8fiBR2L5MlrGNbgF6UPh/aJ/9Oon2DU6I1YrHsK
         LWm5ZtMEU8Gb3fFjyAr9dpXlz/t5vGyxBwQjQVBWjL+mJ1X2IFqOhs2Hct/NP2GXYKvS
         w0CQ==
X-Gm-Message-State: AOJu0Yy2Jif/3r/sY/LPkiV4JHh0TrZ2zcCfB6o8qrkqrtOsA36KE/1P
	68rwX44G3VcK7+zoz4wKeVs=
X-Google-Smtp-Source: AGHT+IF4Nifcgl+qRhP7xlKMpbFEQC3A55CJnaLyZRax+6s/9KIrWJqkpz06EwcLD6pR1mqEATZ2yg==
X-Received: by 2002:a05:600c:2203:b0:40e:4803:72ca with SMTP id z3-20020a05600c220300b0040e480372camr2680182wml.228.1705314193763;
        Mon, 15 Jan 2024 02:23:13 -0800 (PST)
Received: from ?IPv6:2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47? (p200300f6ef1b2000944ccbc71e1c2c47.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:944c:cbc7:1e1c:2c47])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c0a0a00b0040e486bc0dfsm19520260wmp.27.2024.01.15.02.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 02:23:13 -0800 (PST)
Message-ID: <ba1486e52fbf53e6199515df28b8e138b9bc3913.camel@gmail.com>
Subject: Re: [PATCH 12/13] iio: dac: ltc2688: Use __free(fwnode_handle) to
 replace fwnode_handle_put() calls
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, "Rafael
 J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, Heikki
 Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus
 <sakari.ailus@linux.intel.com>
Cc: Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Cosmin Tanislav
 <cosmin.tanislav@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>,  Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Mon, 15 Jan 2024 11:26:25 +0100
In-Reply-To: <20240114172009.179893-13-jic23@kernel.org>
References: <20240114172009.179893-1-jic23@kernel.org>
	 <20240114172009.179893-13-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-01-14 at 17:20 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> This use of the new cleanup.h scope based freeing infrastructure allows
> us to exit directly from error conditions within the
> device_for_each_child_node(dev, child) loop. On normal exit from that
> loop no fwnode_handle reference will be held and the child pointer
> will be NULL thus making the automatically run fwnode_handle_put() a
> noop.
>=20
> Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Just one minor comment on my side. With that:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

I might be able to give this a quick test. Let's see if I can find the time=
 for
it :)

> =C2=A0drivers/iio/dac/ltc2688.c | 23 ++++++-----------------
> =C2=A01 file changed, 6 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ltc2688.c b/drivers/iio/dac/ltc2688.c
> index fc8eb53c65be..e8add3636af9 100644
> --- a/drivers/iio/dac/ltc2688.c
> +++ b/drivers/iio/dac/ltc2688.c
> @@ -746,7 +746,7 @@ static int ltc2688_span_lookup(const struct ltc2688_s=
tate
> *st, int min, int max)
> =C2=A0static int ltc2688_channel_config(struct ltc2688_state *st)
> =C2=A0{
> =C2=A0	struct device *dev =3D &st->spi->dev;
> -	struct fwnode_handle *child;
> +	struct fwnode_handle *child __free(fwnode_handle) =3D NULL;
> =C2=A0	u32 reg, clk_input, val, tmp[2];
> =C2=A0	int ret, span;
> =C2=A0
> @@ -754,18 +754,14 @@ static int ltc2688_channel_config(struct ltc2688_st=
ate
> *st)
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
> @@ -786,12 +782,10 @@ static int ltc2688_channel_config(struct ltc2688_st=
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
> @@ -800,17 +794,14 @@ static int ltc2688_channel_config(struct ltc2688_st=
ate
> *st)
> =C2=A0					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &clk_input);
> =C2=A0		if (!ret) {
> =C2=A0			if (clk_input >=3D LTC2688_CH_TGP_MAX) {

We can now remove the brackets...

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
> @@ -844,11 +835,9 @@ static int ltc2688_channel_config(struct ltc2688_sta=
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


