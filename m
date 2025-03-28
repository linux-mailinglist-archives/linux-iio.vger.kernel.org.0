Return-Path: <linux-iio+bounces-17304-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40046A7452C
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 09:15:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C65AB1730AA
	for <lists+linux-iio@lfdr.de>; Fri, 28 Mar 2025 08:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96657212FA5;
	Fri, 28 Mar 2025 08:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c2pMp3sH"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6DA3212B2D;
	Fri, 28 Mar 2025 08:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743149700; cv=none; b=h5+aSayAtaAbLpuEFbV3oxh02BJGP8YoH6Bxq57f87F+ITn+0aPAbkY6j9PoVPmqqDozO1NZ19Qah3Rf1blhPFV3HEhMGujucqV8MV2CWC3fF9L/OzINseKy9poSzzgNI3IRHhG1K+kpcChxND1QCMkTg+ivVU7uVe7cJVcwHAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743149700; c=relaxed/simple;
	bh=8ZgbTgI+i9iB/QPxGSmX2e5HNl4K3UiwDzivn8gxjQg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XEHMgSSpN6cceWsuuHZpYUOj22wDwQGaq2QoFVdBPfotUgnP/c61VfXR27fzFFRqb1WOJlmt+nehlRQVQQXzcRc7gUgoFCJU58TMaONDYSORbJrJdyp7WXkzesjIBKi/KjEbMkFri3+l2FH2S+HcXJpkbrT3ROLcKRH+zCXRNqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c2pMp3sH; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cf05f0c3eso12880285e9.0;
        Fri, 28 Mar 2025 01:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743149696; x=1743754496; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZL4qLXS6QYd3HqnhaE47rdilc273GV1+TxxUjMhHCmU=;
        b=c2pMp3sHVRR5eTIpz6dCS0BQhsPdyMDb2JeDPeW8j5pUaR60Uc/AnWFvstcVT02h94
         dqqNZ7AUGnLmjSIomF3iHEJi2gmsf4az0APhNO5A0XywWsiM8oWKE7tewW5SBtLDJSwI
         79WB12iNfSxVt9yjkkId6m1rAni2vb7G0FNPDLu+mpqMkGR8LDw+Wg01hRO7RNEn4L/w
         tcIcm+GTVWqQdy0JgbdZ9lFjDAGhNieDYN74u9KH8updbVcylpHWm+2pub5Y5LES1T4b
         cJSFNfyW598Yl4+yuxj0QtyOazVpqbA8wfzRYVbvhGoIooEeUb1LfR65Ohtn6pK9BXjJ
         7+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743149696; x=1743754496;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZL4qLXS6QYd3HqnhaE47rdilc273GV1+TxxUjMhHCmU=;
        b=ifyfN4UqAt/kVI9zhuQkcOGntsuZiFSyUUvjrpu2wyGv0rd5HWlM5XvyeWClIu3i3C
         VoLnYok2DJpbfCOAEU63B/+STLvQBQm9JJccFyWEDlKcfdWzONF5zTEiSC7gWqCEPYFg
         ZTQ5RZU5OZylzsEmfpCPsQ3hAFK/XituOtU2M3JGT52UQbaGeermfPajexn02LY5W1b5
         knaiAI92gRE0h9xP6xPzU7E4Dukd4z46SpdTsMUN8RnrroYx2P/meBHW9iI4CBMzgIgT
         CWfyO2VQWMs8FJd+oIbrgpiR8VjuVhknumWoCnALPQebTAMYiEjaG/plJVuUqBNHLSav
         Q8tw==
X-Forwarded-Encrypted: i=1; AJvYcCUHB8dJTiYr76xnPDNJFFgYo2OJxvt3cJZGlUrVM4+w9ftXtUca23vc24hu+Jg7krl4s4Zp6/k5ARSLJA46@vger.kernel.org, AJvYcCXgDodGTnsU9NLPe5aU5nljJyfAueWxXUI1b7rM4FhotHJiBJ3fsd9X5HyITlFSIHbazUmioLtKPCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsRZ090ZeUrm5/wns91RM3Wgw868U5q9k3pMLSClLWZfbsnrWI
	fO33DHLVVpG3nzXqOlU3If5tKOanBosLqgwJOpDuz1yQvxGUZkJc
X-Gm-Gg: ASbGncsITdLLOfAJt6kpaYQNzyz1PpVV9Y9oew0OTIBSI5lKln2df1FcrCZug4q7n9/
	9UsRaQHfDDJlFdWYTpbWm/ndbBQdCllhsus6J4n44jKqQ9PYZbLLLNk6atyJQTH3Qa3DvpqYhtP
	Jho2oNX+OTdNKrRqsyV95FCLirLrYrwxQhEJ+GVS3VQadhcVqSC29yH0Xl3fN+L05KABK9atlQt
	JF0OBp4r1hJXYdmSP8o6xN7XJg3ar9MHCNWeGxBREe+xEcjkWudRqfm7eJYEMAWKiLlVjWpt5Wo
	bo7g5/D1zZYqnZbcbJHRHjpBuEM81ztomeSz5rIEPo+bpIMDao7gm/43uBxdGVd5dNgZxngpCmp
	+679fl0vZ3mReg5pf/iIFpmCbp9euYg==
X-Google-Smtp-Source: AGHT+IFeTRFSxmnFQ2RzD6Bjj41XdFTReWZamUx1ibzs3Anho5bP8JCi6PWThMPu6PPG2kzvGAz9Bw==
X-Received: by 2002:a05:600c:1d82:b0:43c:fffc:786c with SMTP id 5b1f17b1804b1-43d8506f1bemr68209395e9.19.1743149695668;
        Fri, 28 Mar 2025 01:14:55 -0700 (PDT)
Received: from ?IPv6:2001:818:ea56:d000:56e0:ceba:7da4:6673? ([2001:818:ea56:d000:56e0:ceba:7da4:6673])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b7a4351sm1872979f8f.98.2025.03.28.01.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 01:14:55 -0700 (PDT)
Message-ID: <88c86ac453ccf968422350d788ab35fd55dd8496.camel@gmail.com>
Subject: Re: [PATCH 3/4] iio: dac: adi-axi-dac: add data source get
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Lars-Peter
 Clausen <lars@metafoo.de>, Jonathan Corbet <corbet@lwn.net>, Olivier Moysan
 <olivier.moysan@foss.st.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>
Cc: linux-iio@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Mar 2025 08:15:12 +0000
In-Reply-To: <20250321-wip-bl-ad3552r-fixes-v1-3-3c1aa249d163@baylibre.com>
References: <20250321-wip-bl-ad3552r-fixes-v1-0-3c1aa249d163@baylibre.com>
	 <20250321-wip-bl-ad3552r-fixes-v1-3-3c1aa249d163@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2025-03-21 at 21:28 +0100, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Add data source getter.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/dac/adi-axi-dac.c | 27 +++++++++++++++++++++++++++
> =C2=A01 file changed, 27 insertions(+)
>=20
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.=
c
> index
> 892d770aec69c4259de777058801c9ab33c79923..a6abd828ebdb34800cc08a2151e52a9=
acda9eba1
> 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -514,6 +514,32 @@ static int axi_dac_data_source_set(struct iio_backen=
d *back,
> unsigned int chan,
> =C2=A0	}
> =C2=A0}
> =C2=A0
> +static int axi_dac_data_source_get(struct iio_backend *back, unsigned in=
t chan,
> +				=C2=A0=C2=A0 enum iio_backend_data_source *data)
> +{
> +	struct axi_dac_state *st =3D iio_backend_get_priv(back);
> +	int ret;
> +	u32 val;
> +
> +	ret =3D regmap_read(st->regmap, AXI_DAC_CHAN_CNTRL_7_REG(chan), &val);
> +	if (ret)
> +		return ret;

Is chan something that we can validate? Do we reliable know max number of c=
hannels?

> +
> +	switch (val) {
> +	case AXI_DAC_DATA_INTERNAL_TONE:
> +		*data =3D IIO_BACKEND_INTERNAL_CONTINUOUS_WAVE;
> +		return 0;
> +	case AXI_DAC_DATA_DMA:
> +		*data =3D IIO_BACKEND_EXTERNAL;
> +		return 0;
> +	case AXI_DAC_DATA_INTERNAL_RAMP_16BIT:
> +		*data =3D IIO_BACKEND_INTERNAL_RAMP_16BIT;
> +		return 0;
> +	default:
> +		return -EINVAL;

More of a nitpick comment but I would some other error code. This is not re=
ally an
"Invalid argument" situation. Maybe -EIO as the HW is giving something unex=
pected? or
ENOTSUPP (likely not exactly like this)...

- Nuno S=C3=A1

> =C2=A0	.ddr_disable =3D axi_dac_ddr_disable,
> =C2=A0	.data_stream_enable =3D axi_dac_data_stream_enable,
>=20


