Return-Path: <linux-iio+bounces-5438-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C46C8D3655
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 14:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5184B22B4A
	for <lists+linux-iio@lfdr.de>; Wed, 29 May 2024 12:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFEE180A97;
	Wed, 29 May 2024 12:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUiQi4Jm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F5B3B295;
	Wed, 29 May 2024 12:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716985492; cv=none; b=Gky0zRxC3RClADBOY+0GvbvHkJMvaC8dXt3DY9Bwx8aYxbABXriKnoyMel1B9pDsfJASJMCs1JnWsGtUoE2Rkgq0X+fE1mlDAm3yTAYJSnaaAIKg8Vn93P8tce9pQKV3nZzB8u2+T7GyWgU6uBjhEAaY2uCKdGCCP4bC6cxwPbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716985492; c=relaxed/simple;
	bh=5k2igmC9BNRYQO2B7n6mK2fHZbf7GH7+WMxkHErFkMg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XIs9RgBvx2diGaGc3LKvRkz/zoPTcd51cvC5i//RD86NyuOx5zsXgr6YCebXDgnyx0WyqhS5b/n4uNgo+4DTOiZcBdQ/bYT0kT+y9X92AUOLgUKY+ziSIAM2RkKQlt4hQ3yHhJob8iBW1iL8NUNUFeK7ZmG9/yIckP1L94WCt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUiQi4Jm; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57a033c2ec2so837497a12.2;
        Wed, 29 May 2024 05:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716985489; x=1717590289; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1BGUURdb71Iwan/r2WINcWCavtNA9TZrXo/NoqBxB/E=;
        b=lUiQi4Jm/viCR3sqyiwb1BejPMEA8O6smmmh6OMNXuc3qp06TYhtUm+AKvgGz/2tt6
         8VJ6ELpZ00qSflDcRxUktkiqs45BXq2Zek+n6RAiaUmlJbV6mOxLexuV3WNAFUWl6c0U
         WQhQuUj1W736SbfhFI+BcHgTl/amtpWxK2zqrJ8NsremEVfok0QPXfyuBZvnY0PSGuMb
         sACWyibuxVaEsuzNh3c4qOtAveQZyyXN7JyE80fS8bsjHltD3E5Rhr1BehNzYLn5CphI
         t5/Q6awm14MIYyME1BRIv2qlZwaBPFyJ6rhySDNDPbawDAeN9UXgMopWYteDQnPHzaxq
         9Tww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716985489; x=1717590289;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1BGUURdb71Iwan/r2WINcWCavtNA9TZrXo/NoqBxB/E=;
        b=L7g7sogKsv27g6ctB+ozEBXaVU6zKWvoJ06tj99siMozuqFiqkrtfpDUKvkYWptdqh
         6ebUVdxvTqOlp2FIGctr53fs6m08osrw30YL319WftiMJe9JFLj7dG8uns/lqL7QU1ME
         qdeA7tqFALQwW7xZvjD0jOBjulWdl/ARJGL1BRWZ7vKlJ4Q04QmtwEUF/EQCT6qesgXF
         F7kHqus0xzmOOlMZkHvyQvf/gvdxZREYY+jgBY2ZXYVRlkSxpbIJ40Tm83B/fq42yXBj
         25eh/y/Sys4vcbsP35B2L3NMzulWQo1An432+6pSsKB4wsqW1tPBv88VjetseJz1rrtX
         y0Xg==
X-Forwarded-Encrypted: i=1; AJvYcCW+Z3Gs/QvsE3/tCflwkwk+8R1tDMrOPtDTe9QbYxCUXD2ME9zIJTraPoGKhLitC8OZjECKOw1HTnNBcZOf6UWw+WrOXn4hZkG17Nx5A0KILmWPzaE2wnakCVneYVxmab7MVjQPZNq+ae7E4Qq08ofMur+PyPdNYVntYWdon3IpM66pPQ==
X-Gm-Message-State: AOJu0YxSpUbO/Eb3IRyRe2iret+IpvZzuM83p6Le6pjsCRVpWHyXRNF2
	A2l0TDF0wa8Gfn/1nrnRMpk+/+IJSSoWAqcij8+ltYoAMHmnUo0O
X-Google-Smtp-Source: AGHT+IHDa3Ov9X29+zq6lA106ILLxqETz6YpgroNUP7XNxLs8iz1teZqys1cgDDMeVBFptuQUDC90g==
X-Received: by 2002:a50:ab53:0:b0:578:6198:d6ff with SMTP id 4fb4d7f45d1cf-5786198d83amr8526645a12.33.1716985488914;
        Wed, 29 May 2024 05:24:48 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-579ced17435sm4592710a12.53.2024.05.29.05.24.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 05:24:48 -0700 (PDT)
Message-ID: <2c5d3a53010055c2b996a5b8938c465884834b72.camel@gmail.com>
Subject: Re: [PATCH v3 2/6] iio: adc: ad7173: refactor channel configuration
 parsing
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 David Lechner <dlechner@baylibre.com>,  linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org, Dumitru Ceclan
 <mitrutzceclan@gmail.com>,  Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Wed, 29 May 2024 14:24:48 +0200
In-Reply-To: <20240527-ad4111-v3-2-7e9eddbbd3eb@analog.com>
References: <20240527-ad4111-v3-0-7e9eddbbd3eb@analog.com>
	 <20240527-ad4111-v3-2-7e9eddbbd3eb@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-05-27 at 20:02 +0300, Dumitru Ceclan via B4 Relay wrote:
> From: Dumitru Ceclan <dumitru.ceclan@analog.com>
>=20
> Move configurations regarding number of channels from
> *_fw_parse_device_config to *_fw_parse_channel_config.
>=20
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: https://lore.kernel.org/all/20240303162148.3ad91aa2@jic23-huawei/
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> Signed-off-by: Dumitru Ceclan <dumitru.ceclan@analog.com>
> ---

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/adc/ad7173.c | 29 +++++++++++++++++------------
> =C2=A01 file changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index ebacdacf64b9..9e507e2c66f0 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -913,7 +913,23 @@ static int ad7173_fw_parse_channel_config(struct iio=
_dev
> *indio_dev)
> =C2=A0	struct device *dev =3D indio_dev->dev.parent;
> =C2=A0	struct iio_chan_spec *chan_arr, *chan;
> =C2=A0	unsigned int ain[2], chan_index =3D 0;
> -	int ref_sel, ret;
> +	int ref_sel, ret, num_channels;
> +
> +	num_channels =3D device_get_child_node_count(dev);
> +
> +	if (st->info->has_temp)
> +		num_channels++;
> +
> +	if (num_channels =3D=3D 0)
> +		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
> +
> +	if (num_channels > st->info->num_channels)
> +		return dev_err_probe(dev, -EINVAL,
> +			"Too many channels specified. Maximum is %d, not including
> temperature channel if supported.\n",
> +			st->info->num_channels);
> +
> +	indio_dev->num_channels =3D num_channels;
> +	st->num_channels =3D num_channels;
> =C2=A0
> =C2=A0	chan_arr =3D devm_kcalloc(dev, sizeof(*indio_dev->channels),
> =C2=A0				st->num_channels, GFP_KERNEL);
> @@ -1008,7 +1024,6 @@ static int ad7173_fw_parse_device_config(struct iio=
_dev
> *indio_dev)
> =C2=A0{
> =C2=A0	struct ad7173_state *st =3D iio_priv(indio_dev);
> =C2=A0	struct device *dev =3D indio_dev->dev.parent;
> -	unsigned int num_channels;
> =C2=A0	int ret;
> =C2=A0
> =C2=A0	st->regulators[0].supply =3D
> ad7173_ref_sel_str[AD7173_SETUP_REF_SEL_EXT_REF];
> @@ -1067,16 +1082,6 @@ static int ad7173_fw_parse_device_config(struct ii=
o_dev
> *indio_dev)
> =C2=A0
> =C2=A0	ad7173_sigma_delta_info.irq_line =3D ret;
> =C2=A0
> -	num_channels =3D device_get_child_node_count(dev);
> -
> -	if (st->info->has_temp)
> -		num_channels++;
> -
> -	if (num_channels =3D=3D 0)
> -		return dev_err_probe(dev, -ENODATA, "No channels specified\n");
> -	indio_dev->num_channels =3D num_channels;
> -	st->num_channels =3D num_channels;
> -
> =C2=A0	return ad7173_fw_parse_channel_config(indio_dev);
> =C2=A0}
> =C2=A0
>=20


