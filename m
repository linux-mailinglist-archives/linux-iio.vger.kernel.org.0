Return-Path: <linux-iio+bounces-14507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805F4A170FA
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 18:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E8D0161263
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jan 2025 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A341494CC;
	Mon, 20 Jan 2025 17:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHp+3BbO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5E91E9B31;
	Mon, 20 Jan 2025 17:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737392847; cv=none; b=W6GwgCKcfihEN1An2CUbE3LhMPrkAZRRJ3fDRSUyj64tSJ0AVpXKYyEbK8oqL/H1ZXNO365naQ2+ECdBqNyQt0U9LxXL+DUkVEyIQb7b+0HYdi9WV+5WoSjuKXL+mr+Z1jBa5NroTMiMIcDwNhI2xcFNwuenF76r1od9+5tM9Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737392847; c=relaxed/simple;
	bh=K57gTztk19FEzr6GFIw5QFx4++pL6sLNHUc8cq/peJE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hpDeQoBHMJpsKPRzRKTn20GEuXbIFGvk8w9JLlZmKGHH+AWR6EujLVqmSirHo015aoz1VjvmpHssk7kLLeXoXGAgj4yj1Cftdy6oRs/uRSgDRtTzVhkXSN8vrgMTiTs1b+71MjC7sHCJBh4P5Miy6qY7vVuj+3ihIFjMqTJ0W9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHp+3BbO; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43624b2d453so52023135e9.2;
        Mon, 20 Jan 2025 09:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737392844; x=1737997644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9LAdR60UOxrymmhmA6BLg8DI5SQPSh99z4uw9K6lnHs=;
        b=FHp+3BbOGOxi917MG5RpmOiB5xNkT9bJOERBJQbRRbrDiaOu/hZ58y/e1BJgaPUkx5
         ULcCpWsnyOvVJvRyl8P8iEzci59rg+6BtamHJ1DVi0lsEgQcpG1DQ5lMkjUq92XHops5
         30WfFV8JnjtEhCVehc8PbO+rSpnbpOoKC9kt4qpA875aSRLiYBhrcxZrBqEwP5si1jp+
         ixDiNQoSf8dCpSTGfhDHfRp7uqM3Ph/m5uxBNXct7UrurVcDO4/vpOHbscz2fiVCH8ff
         Hyxanpq9U+61+NbvqGdPfbkHKaiOhVngfg7FEiQWywwIGe/PYDgOrb4zjOuH4H7ZhcYe
         V97g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737392844; x=1737997644;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LAdR60UOxrymmhmA6BLg8DI5SQPSh99z4uw9K6lnHs=;
        b=iVDoFyiC/dz+Eil5kWSmj3VRI0kAp5q9ocszMbKvY5+ORFt5llW6hYKqRRTk1V367/
         oSBppa+c3q4CHQJBguosiXNTfd01hzxgo7qz7XKyOfdNJhhtWNUzo0rhf4ZqEc3OmKZX
         U2f0VnIaGpt2jBAbL9SM/bJOwhVJZVwb2RshYzkrGH+SUuDYDq2jVqsdJ8bonoA51KJF
         Q530OgYicA7aQWa5KIlb2Zk8NqZuJt5OoXhBLB61ZyZiZ0eR6VYSZd+utE2sefMV+WAz
         wq6lpKLIvbKobsCt7rb1Pon7n3QnVPfXO9ep+pSSWrPSyFTyN2ng89FCjKPR/4mOYibx
         7uqA==
X-Forwarded-Encrypted: i=1; AJvYcCXsZPCsP/9uJGCgUiFhRq+jXU361w1vOMxEsSJeN32lKK04ZvWt3JQ+/MvgUtOYjxDx8z4puNNUo/i35aQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcLy0FxCyK2F8o1BRK/IwDgqP5oHcTPv9BTYH7E3o23H4dOehk
	JmrCdTzKi4JjqCbxRFETWxq/Gt0bWsOECx/4RYTU8AylUAItgEJk
X-Gm-Gg: ASbGncvFmiH29Gkm0zvRk3RO1b6g1jWxMSzXkzr7/vV9JYVeig3rOr29UtqBsmbZ+re
	tmU9BCzcWmJc5Seo7/0U4Lfg7cmNbzfz/lCVlgT9aAKuCEfQF42TnAMgZyf8PmhdpLkDzpguVzf
	Vr/+bgW0D4OBGMYXBYnreZ5Rd/65BN6qXmb8Bk8lnQToSiJugGYoo+bowLGGTDd5eab2opqT7Al
	Bxg7QgODhyM2dENknAoM1akX++OqAQs8G8PJW+1cf92RpX66s/UZmgFMMyPA8+yuz2gE0KoyOXB
	sruxtH0Z8GmY1LwPxp8epHXzob51h6je8ah2jwv7mA==
X-Google-Smtp-Source: AGHT+IEQAVBNhoP2MiyDseQlrGzBSWpRYehOF2elUtpmwfHfT7CotRwlWZAJ/jBl/1dGzUdXHIdlPA==
X-Received: by 2002:a05:600c:1386:b0:434:f739:7cd9 with SMTP id 5b1f17b1804b1-438913cf349mr120816955e9.9.1737392843954;
        Mon, 20 Jan 2025 09:07:23 -0800 (PST)
Received: from ?IPv6:2001:818:ea8e:7f00:2575:914:eedd:620e? ([2001:818:ea8e:7f00:2575:914:eedd:620e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c753cc1fsm210806895e9.39.2025.01.20.09.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jan 2025 09:07:23 -0800 (PST)
Message-ID: <105894947f288f0b877f69d58e5d9b4a095e6e2b.camel@gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7173: add openwire detection support
 for single conversions
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Guillaume Ranquet <granquet@baylibre.com>, Lars-Peter Clausen
	 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron
	 <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 20 Jan 2025 17:07:24 +0000
In-Reply-To: <20250120-ad4111_openwire-v4-2-e647835dbe62@baylibre.com>
References: <20250120-ad4111_openwire-v4-0-e647835dbe62@baylibre.com>
	 <20250120-ad4111_openwire-v4-2-e647835dbe62@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-01-20 at 15:10 +0100, Guillaume Ranquet wrote:
> Some chips of the ad7173 family supports open wire detection.
>=20
> Generate a level fault event whenever an external source is disconnected
> from the system input on single conversions.
>=20
> Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> ---

LGTM... Just one small nit. In any case:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 166
> +++++++++++++++++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 166 insertions(+)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index
> 11ff148cb5a315d32485acf04b8d6f7d0fb6e5fa..a2ea8f7ae8e61f1f3cdfba795551de2=
db96b
> 8d60 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -35,6 +35,7 @@
> =C2=A0#include <linux/units.h>
> =C2=A0
> =C2=A0#include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/iio/triggered_buffer.h>
> @@ -102,6 +103,7 @@
> =C2=A0
> =C2=A0#define AD7173_GPIO_PDSW	BIT(14)
> =C2=A0#define AD7173_GPIO_OP_EN2_3	BIT(13)
> +#define AD4111_GPIO_GP_OW_EN	BIT(12)
> =C2=A0#define AD7173_GPIO_MUX_IO	BIT(12)
> =C2=A0#define AD7173_GPIO_SYNC_EN	BIT(11)
> =C2=A0#define AD7173_GPIO_ERR_EN	BIT(10)
> @@ -149,6 +151,7 @@
>=20

...

>=20
> +
> =C2=A0static int ad7173_fw_parse_channel_config(struct iio_dev *indio_dev=
)
> =C2=A0{
> =C2=A0	struct ad7173_channel *chans_st_arr, *chan_st_priv;
> @@ -1375,6 +1528,7 @@ static int ad7173_fw_parse_channel_config(struct ii=
o_dev
> *indio_dev)
> =C2=A0		chan_st_priv->cfg.bipolar =3D false;
> =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> =C2=A0		chan_st_priv->cfg.ref_sel =3D AD7173_SETUP_REF_SEL_INT_REF;
> +		chan_st_priv->cfg.openwire_comp_chan =3D -1;
> =C2=A0		st->adc_mode |=3D AD7173_ADC_MODE_REF_EN;
> =C2=A0		if (st->info->data_reg_only_16bit)
> =C2=A0			chan_arr[chan_index].scan_type =3D ad4113_scan_type;
> @@ -1442,6 +1596,7 @@ static int ad7173_fw_parse_channel_config(struct ii=
o_dev
> *indio_dev)
> =C2=A0		chan_st_priv->chan_reg =3D chan_index;
> =C2=A0		chan_st_priv->cfg.input_buf =3D st->info->has_input_buf;
> =C2=A0		chan_st_priv->cfg.odr =3D 0;
> +		chan_st_priv->cfg.openwire_comp_chan =3D -1;
> =C2=A0
> =C2=A0		chan_st_priv->cfg.bipolar =3D fwnode_property_read_bool(child,
> "bipolar");
> =C2=A0		if (chan_st_priv->cfg.bipolar)
> @@ -1456,6 +1611,17 @@ static int ad7173_fw_parse_channel_config(struct
> iio_dev *indio_dev)
> =C2=A0			chan_st_priv->cfg.input_buf =3D st->info-
> >has_input_buf;
> =C2=A0			chan->channel2 =3D ain[1];
> =C2=A0			chan_st_priv->ain =3D AD7173_CH_ADDRESS(ain[0],
> ain[1]);
> +			if (st->info->has_openwire_det &&
> +			=C2=A0=C2=A0=C2=A0 ad7173_validate_openwire_ain_inputs(st, chan-
> >differential, ain[0], ain[1])) {
> +				chan->event_spec =3D ad4111_events;
> +				chan->num_event_specs =3D
> ARRAY_SIZE(ad4111_events);
> +				chan_st_priv->cfg.openwire_thrsh_raw =3D
> +					BIT(chan->scan_type.realbits -
> !!(chan_st_priv->cfg.bipolar))
> +					* AD4111_OW_DET_THRSH_MV
> +					/ ad7173_get_ref_voltage_milli(st,
> chan_st_priv->cfg.ref_sel);
> +				if (chan->channel < st->info-
> >num_voltage_in_div)
> +					chan_st_priv->cfg.openwire_thrsh_raw
> /=3D AD4111_DIVIDER_RATIO;
> +			}

If you need to send another version for some reason, might be worth it to
implement a simple helper for the above to improve code readability.

Maybe is just me but that 'chan_st_priv->cfg.openwire_thrsh_raw =3D' is fai=
rly
unreadable :)

- Nuno S=C3=A1
>=20

