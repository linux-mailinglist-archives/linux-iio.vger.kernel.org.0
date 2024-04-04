Return-Path: <linux-iio+bounces-4050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C98CD8983C2
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 11:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 544581F23F6B
	for <lists+linux-iio@lfdr.de>; Thu,  4 Apr 2024 09:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81EF73539;
	Thu,  4 Apr 2024 09:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkB8AvJ2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E1674267
	for <linux-iio@vger.kernel.org>; Thu,  4 Apr 2024 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712221849; cv=none; b=Sp3wJJC0gDf+i9VZ7eOOYSZm4aMXBYicvoj4NktMJxIa6mHACd5tnzld1YIcnjt/I/6Va8qyK6VKGdP+jJFfue8+nWHtymXBj44RR13LFAOknRLk2+XbBnAfD9wfO/kfz1jZ/TfpKhEDVqydogbC6e7L6kuLO7UcW+m4unZAMXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712221849; c=relaxed/simple;
	bh=uOmDR0YVnBD/XKULHF3XckHK2Io3i1HD23BhOGC4q4w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UQsY/vAwLZpqTgoi6Ld1ZxG2W7aPdPnRkKja43UibdARa8rq5uG3rNi/ofMFj1BvY0HPKV/K3VC0usYbgsnrxPmYyeIELvx1OftsLqs2IOQjGPFsHYonvaYNy2AhvlrWjIXdZtsXnvtmHeTskRXTmOkk/cWuqOIqrMn6FMpMKvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RkB8AvJ2; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4a387ff7acso89620066b.2
        for <linux-iio@vger.kernel.org>; Thu, 04 Apr 2024 02:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712221846; x=1712826646; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ThYkdGJu6ijkcKgVHL2rXM5Z33Ha6JWY0tFAUj9+0MI=;
        b=RkB8AvJ2vi1ExdtnSM9zuJPx0ZHzDGdOjGI2b8jnSlfET6wumnswI6C2EkxMwqDCpO
         hht2WAKfmPUlzVmUtxqV6pt7YM/JtHYPMcHvHmJscAUM/IpMiYE1wiSw1nONEphisZ6G
         OQEl74qbX7EiuEpXI/k4b/LVWjlhUZqvIosybJ0wtIcWO34nDOQDgOGTw0PFC0enpuQj
         pAbNY4fgzsI61EMrwGb8Rcs143+bWu12U57Z2FvmcRbT89kBNOTejmNvOyrMnySuHRnm
         dNjqO2eJGLeTq/bb2PWKe/sQFhsy77klS6p59y43U3kr4L1J/LxZtHJLbTMH0T01/UWE
         m1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712221846; x=1712826646;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ThYkdGJu6ijkcKgVHL2rXM5Z33Ha6JWY0tFAUj9+0MI=;
        b=CMIwEKXihFAf6ImoKxcj11WC+nBmAfkAkiV7FHZ2k2ZMQ3rZm5+QkWWOqmcMK1UEuy
         kgkNpkwewKsTnlVWTItFS96iyJTeZNAUoMvZQjZOPFNoB82h677Qpf0G+pSa+DHp47fC
         LYyIAyWxmRUXxthDtN7CVKUcY9d3ccmQP8qGybw20+EkMDLcqavFno9vn6LDDoUxSTT5
         IJ+Z+ONmHFMngiGVL8FVt+HTtVRw6B5Rs/GIB+yuB1SWFYZoRy9/YiZ22AqIXFSSL5Ew
         JrbqYcXbVmsChO1+yIe1mHW4O1Ck68gkcHU7rokoTBWjsZyRav24FYQ+vWjiv7dBita+
         GpJw==
X-Forwarded-Encrypted: i=1; AJvYcCXnMLSHVr8tWsYUXPQcALswWWYZI+VC07fKQvPPbDvshRl4Hlu9DXNsMek4cgW8sC/N/vXVqTkYxCF/xbc5dYlpkWQja7m5dDWv
X-Gm-Message-State: AOJu0Yyjq555edkiOvpWelU7NOzfG1lA+sORX1nZcZ9pcjgGmEJdbXMN
	k/0CBS/L3y1BtTtTHDKf41WJk1QsPdprPYLFm8q4RfDYjYNeqsly17aQxpQ/Bwj6pi6l
X-Google-Smtp-Source: AGHT+IHsHX3owVVcrb9E/Y0Qzz/AAMMQdPGmBNwitF1DP5Yv4Ut+qe6tKJ2ViJoq/UGGKME6C0R4MA==
X-Received: by 2002:a17:906:8313:b0:a51:87d6:219 with SMTP id j19-20020a170906831300b00a5187d60219mr845960ejx.36.1712221845944;
        Thu, 04 Apr 2024 02:10:45 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef1b:2000:15d4:fc17:481e:8afe? (p200300f6ef1b200015d4fc17481e8afe.dip0.t-ipconnect.de. [2003:f6:ef1b:2000:15d4:fc17:481e:8afe])
        by smtp.gmail.com with ESMTPSA id h23-20020a170906591700b00a517e505e3bsm1045823ejq.204.2024.04.04.02.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 02:10:45 -0700 (PDT)
Message-ID: <2f506f64a1b3dc0b7eccead4bac04869d55c52d2.camel@gmail.com>
Subject: Re: [PATCH v6 7/8] iio: dac: ad3552r: Use
 device_for_each_child_node_scoped()
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Nuno
 =?ISO-8859-1?Q?S=E1?=
	 <nuno.sa@analog.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Cosmin Tanislav <cosmin.tanislav@analog.com>, Mihail Chindris
 <mihail.chindris@analog.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Tomislav Denis <tomislav.denis@avl.com>, Marek Vasut <marex@denx.de>,
 Olivier Moysan <olivier.moysan@foss.st.com>,  Fabrice Gasnier
 <fabrice.gasnier@foss.st.com>, Lad Prabhakar
 <prabhakar.mahadev-lad.rj@bp.renesas.com>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Marijn Suijten
 <marijn.suijten@somainline.org>, Marius Cristea
 <marius.cristea@microchip.com>, Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>
Date: Thu, 04 Apr 2024 11:14:17 +0200
In-Reply-To: <20240330185305.1319844-8-jic23@kernel.org>
References: <20240330185305.1319844-1-jic23@kernel.org>
	 <20240330185305.1319844-8-jic23@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-03-30 at 18:53 +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
>=20
> Removing the goto err; statements also allows more extensive use of
> dev_err_probe() further simplifying the code.
>=20
> Cc: Mihail Chindris <mihail.chindris@analog.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Hmm, Mihail is no longer in ADI... I'll see what other drivers he's
"maintaining" and default them to me.

Anyways,

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> =C2=A0drivers/iio/dac/ad3552r.c | 51 +++++++++++++++---------------------=
---
> =C2=A01 file changed, 19 insertions(+), 32 deletions(-)
>=20
> diff --git a/drivers/iio/dac/ad3552r.c b/drivers/iio/dac/ad3552r.c
> index a492e8f2fc0f..e14a065b29ca 100644
> --- a/drivers/iio/dac/ad3552r.c
> +++ b/drivers/iio/dac/ad3552r.c
> @@ -880,7 +880,6 @@ static void ad3552r_reg_disable(void *reg)
> =C2=A0static int ad3552r_configure_device(struct ad3552r_desc *dac)
> =C2=A0{
> =C2=A0	struct device *dev =3D &dac->spi->dev;
> -	struct fwnode_handle *child;
> =C2=A0	struct regulator *vref;
> =C2=A0	int err, cnt =3D 0, voltage, delta =3D 100000;
> =C2=A0	u32 vals[2], val, ch;
> @@ -949,53 +948,45 @@ static int ad3552r_configure_device(struct ad3552r_=
desc
> *dac)
> =C2=A0		return -ENODEV;
> =C2=A0	}
> =C2=A0
> -	device_for_each_child_node(dev, child) {
> +	device_for_each_child_node_scoped(dev, child) {
> =C2=A0		err =3D fwnode_property_read_u32(child, "reg", &ch);
> -		if (err) {
> -			dev_err(dev, "mandatory reg property missing\n");
> -			goto put_child;
> -		}
> -		if (ch >=3D AD3552R_NUM_CH) {
> -			dev_err(dev, "reg must be less than %d\n",
> -				AD3552R_NUM_CH);
> -			err =3D -EINVAL;
> -			goto put_child;
> -		}
> +		if (err)
> +			return dev_err_probe(dev, err,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "mandatory reg property
> missing\n");
> +		if (ch >=3D AD3552R_NUM_CH)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "reg must be less than %d\n",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 AD3552R_NUM_CH);
> =C2=A0
> =C2=A0		if (fwnode_property_present(child, "adi,output-range-
> microvolt")) {
> =C2=A0			err =3D fwnode_property_read_u32_array(child,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 "adi,output-
> range-microvolt",
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 vals,
> =C2=A0							=C2=A0=C2=A0=C2=A0=C2=A0 2);
> -			if (err) {
> -				dev_err(dev,
> +			if (err)
> +				return dev_err_probe(dev, err,
> =C2=A0					"adi,output-range-microvolt property
> could not be parsed\n");
> -				goto put_child;
> -			}
> =C2=A0
> =C2=A0			err =3D ad3552r_find_range(dac->chip_id, vals);
> -			if (err < 0) {
> -				dev_err(dev,
> -					"Invalid adi,output-range-microvolt
> value\n");
> -				goto put_child;
> -			}
> +			if (err < 0)
> +				return dev_err_probe(dev, err,
> +						=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid adi,output-
> range-microvolt value\n");
> +
> =C2=A0			val =3D err;
> =C2=A0			err =3D ad3552r_set_ch_value(dac,
> =C2=A0						=C2=A0=C2=A0
> AD3552R_CH_OUTPUT_RANGE_SEL,
> =C2=A0						=C2=A0=C2=A0 ch, val);
> =C2=A0			if (err)
> -				goto put_child;
> +				return err;
> =C2=A0
> =C2=A0			dac->ch_data[ch].range =3D val;
> =C2=A0		} else if (dac->chip_id =3D=3D AD3542R_ID) {
> -			dev_err(dev,
> -				"adi,output-range-microvolt is required for
> ad3542r\n");
> -			err =3D -EINVAL;
> -			goto put_child;
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "adi,output-range-microvolt is
> required for ad3542r\n");
> =C2=A0		} else {
> =C2=A0			err =3D ad3552r_configure_custom_gain(dac, child, ch);
> =C2=A0			if (err)
> -				goto put_child;
> +				return err;
> =C2=A0		}
> =C2=A0
> =C2=A0		ad3552r_calc_gain_and_offset(dac, ch);
> @@ -1003,7 +994,7 @@ static int ad3552r_configure_device(struct ad3552r_d=
esc
> *dac)
> =C2=A0
> =C2=A0		err =3D ad3552r_set_ch_value(dac, AD3552R_CH_SELECT, ch, 1);
> =C2=A0		if (err < 0)
> -			goto put_child;
> +			return err;
> =C2=A0
> =C2=A0		dac->channels[cnt] =3D AD3552R_CH_DAC(ch);
> =C2=A0		++cnt;
> @@ -1021,10 +1012,6 @@ static int ad3552r_configure_device(struct ad3552r=
_desc
> *dac)
> =C2=A0	dac->num_ch =3D cnt;
> =C2=A0
> =C2=A0	return 0;
> -put_child:
> -	fwnode_handle_put(child);
> -
> -	return err;
> =C2=A0}
> =C2=A0
> =C2=A0static int ad3552r_init(struct ad3552r_desc *dac)


