Return-Path: <linux-iio+bounces-10114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2ABB990357
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 14:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9053F1C216AC
	for <lists+linux-iio@lfdr.de>; Fri,  4 Oct 2024 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B42C20FAB1;
	Fri,  4 Oct 2024 12:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFVhCi9M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD9D148FF6;
	Fri,  4 Oct 2024 12:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728046465; cv=none; b=uY8swGAh9jenbXxP2OKP7hGFox5+IS0QDiVMoTnmJ8IbxkNHzkjzTrEa2ZHxU1AOU7ueykncJ+Quky6+rCVTf2faCeLf5lpxh7C+3H/G2V+eGXQB4hbB1uxVdFqEzgSwx65H8eB0qGt86yA2XqEVQWX5Ufw6J0yaucHx6DuImVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728046465; c=relaxed/simple;
	bh=scoEf+kQQ8o70PYJN/CMkKfJxUEnWdjSkGJRV4O1hIM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ijofhc7iGIz90QtJR/BYZPQOzshwOyMupM/YJEuwKJVv9zDZMUYP0TzcKWKVidVAg2FRy82zgdxjEpLrRJefaclMlsmxzfVSGkrl4oheTQshGI9I80zHF5BV5dddv2lCAZeVEmZpCJVoXDY+9y9nHz1Wa8PvSjYsWQSBHJ7Y8lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFVhCi9M; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37cfa129074so1549985f8f.1;
        Fri, 04 Oct 2024 05:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728046462; x=1728651262; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OkE24tdFnxW3nZI+5FIcOtn5bLZXY6cj+71W8xLv0ZI=;
        b=CFVhCi9MZJzG89ZfR243xYdH+HPtH9m+yLSaq5gHrsgFfRexyL2aJusYuWVoyYYKBk
         S6mSxPFEhDOThi1NL/T5Jp7WINESZXGenzhgVT7+G745hzKZ+TGItnnjGWpSIuzArr5k
         hvhSxqNr6E18sYVhlcJehEaNhY73NBxJEQ+Voz29BXmXvFjldlRyir0iTAvfN9PdY2Xe
         l+vBtEIQpDtgEy82tA1C98NodokCUC4NtLiTe6wykn5ED+z4xkye4c3WrIIIczIDS/1c
         Vq6qxpLBG7bUXMPCTg3jOxv0URBcT4hRmgAAT0v8yqcRynoh8qwOnUpyQBku8BUFV8rV
         +R2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728046462; x=1728651262;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OkE24tdFnxW3nZI+5FIcOtn5bLZXY6cj+71W8xLv0ZI=;
        b=pPJpJDbxU/ISWjU05UDuW0oUM6LC/dbBsYvteiWZ7XmFrwD689tOJJYvBA3wpRntqU
         doxI0bU1aQLhqGdwZy+ooBazS3scWL0lqKbcAmiGTWhKyX+CjdAjM/O6J9f2uDItYWeC
         o53LEykzD1L+4h3UqfcH+s51FVoFso6Iu5GfsaYshHBM/xOebq5OGjk1W2g532SMLwEG
         67WwGKk1i888qWWNhlXGDwFtrbsNRAh3FhwvNm9dQ5/S91UX8sRapnyvWtzAdrY1ms79
         ezs52puibolPcjMhZH81JXQXlGJe0/+uKmOIh7/WWxsoEvxhCTVG8/+/FQDm0X0TKL3O
         YFFA==
X-Forwarded-Encrypted: i=1; AJvYcCUjJA8eMx2lEAMRe4RqY1N0HqKccBNva1g4YBfd+lpcQI9tU79+8Pmf1lHDVh9z8jGX4IbeuiCCqXR6Es/s@vger.kernel.org, AJvYcCWipZ5zixzSmm2PGi4jbi10I2NjnPVnHFIhn+50P/iw404tuAe+02LanuzHQcFkdRnOKxNxIYdMNvFB@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4/1YyiHufJRNqKjVLCj7dI74PmsDLZ9xTerRdWczX/KAvA/W
	a93IeX1q9KXH6Y5ycjGyKGd3zhX6F0CeruK161tk9CsOMrJspbyK
X-Google-Smtp-Source: AGHT+IH2NxZqBSgVBXnK5eFnmjV1tpYIrpENzrIAU1o5rfWqLqywaR28L48fLM5SXVAsGYLIPUALzw==
X-Received: by 2002:adf:dd8d:0:b0:368:74c0:6721 with SMTP id ffacd0b85a97d-37d0e8de825mr1733676f8f.38.1728046461330;
        Fri, 04 Oct 2024 05:54:21 -0700 (PDT)
Received: from ?IPv6:2001:a61:34c9:ea01:14b4:7ed9:5135:9381? ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d0822b571sm3226763f8f.40.2024.10.04.05.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 05:54:21 -0700 (PDT)
Message-ID: <451aaf360690cf60704e8a2880e98501156bda73.camel@gmail.com>
Subject: Re: [PATCH v4 06/11] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Angelo Dureghello <adureghello@baylibre.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org, 
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Date: Fri, 04 Oct 2024 14:54:15 +0200
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-6-ceb157487329@baylibre.com>
References: 
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-6-ceb157487329@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-10-03 at 19:29 +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
>=20
> Extend backend features with new calls needed later on this
> patchset from axi version of ad3552r.
>=20
> The follwoing calls are added:
>=20
> iio_backend_ddr_enable
> 	enable ddr bus transfer
> iio_backend_ddr_disable
> 	disable ddr bus transfer
> iio_backend_buffer_enable
> 	enable buffer
> iio_backend_buffer_disable
> 	disable buffer
> iio_backend_data_transfer_addr
> 	define the target register address where the DAC sample
> 	will be written.
>=20
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> ---
> =C2=A0drivers/iio/industrialio-backend.c | 79 +++++++++++++++++++++++++++=
+++++++++++
> =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 17 ++++++++
> =C2=A02 files changed, 96 insertions(+)
>=20
> diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/industriali=
o-
> backend.c
> index 20b3b5212da7..d5e0a4da761e 100644
> --- a/drivers/iio/industrialio-backend.c
> +++ b/drivers/iio/industrialio-backend.c
> @@ -718,6 +718,85 @@ static int __devm_iio_backend_get(struct device *dev=
, struct
> iio_backend *back)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +/**
> + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate) mode
> + * @back: Backend device
> + *
> + * Enable DDR, data is generated by the IP at each front (raising and fa=
lling)
> + * of the bus clock signal.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_ddr_disable - Disable interface DDR (Double Data Rate) mo=
de
> + * @back: Backend device
> + *
> + * Disable DDR, setting into SDR mode (Single Data Rate).
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_ddr_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, ddr_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_dma_stream_enable - Enable iio buffering
> + * @back: Backend device
> + *
> + * Enabling sending the dma data stream over the bus.
> + * bus interface.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_dma_stream_enable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, dma_stream_enable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_enable, IIO_BACKEND);
> +
> +/**
> + * iio_backend_dma_stream_disable - Disable iio buffering
> + * @back: Backend device
> + *
> + * Disable sending the dma data stream over the bus.
> + *
> + * RETURNS:
> + * 0 on success, negative error number on failure.
> + */
> +int iio_backend_dma_stream_disable(struct iio_backend *back)
> +{
> +	return iio_backend_op_call(back, dma_stream_disable);
> +}
> +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_disable, IIO_BACKEND);
> +

I'm not sure if this is what Jonathan was suggesting... Ate least I don't r=
eally
agree with it. I mean, yes, this is about buffering and to start receiving =
(or
sending) a stream of data. But AFAICT, it might have nothing to do with DMA=
. Same as
.request_buffer() - It's pretty much always a DMA one but we should not tak=
e that for
granted.

So going back to the RFC [1], you can see I was suggesting something like s=
truct
iio_buffer_setup_ops. Maybe just add the ones we use for now? So that would
be.buffer_postenable() and .buffer_predisable(). Like this, it should be ob=
vious the
intent of the ops.

- Nuno S=C3=A1



