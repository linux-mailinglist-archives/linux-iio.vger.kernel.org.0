Return-Path: <linux-iio+bounces-10259-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F509924F6
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 08:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F321C22365
	for <lists+linux-iio@lfdr.de>; Mon,  7 Oct 2024 06:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1114149C6A;
	Mon,  7 Oct 2024 06:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3eTCLxE"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41442077;
	Mon,  7 Oct 2024 06:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728282989; cv=none; b=fUM2Kc7N1qMXtbZtlC14DNrqqXPkQbw2DB9T8HASfeYRhSMW9k4p83OhcPSbOyHAok+jgRC9HNHivq4JSgynBu8p2s9k0cL77lyMnqE3O6O0QE2Fh8witf4bDRrDNzGjigpsn626YEKsC2o/2IoZbE1NUayoI6XdXo0VKz7JMEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728282989; c=relaxed/simple;
	bh=V1FTY2Ydo/5UAlGpdE2brQSYat0HtGt/u2196dtNvdM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Nhxf1kmQkILLfqQjMxE9zAaVFvpqdp98pbtKtI5+Bp1SRrknSMmTmglwZZmNPJGAzW2Z1eiCZ8ZGWvGqwWSr7cbkiYu7e13WfHm1eZgSeTGEqExfGmpZLuHpK/zwG4CPZKm94gzFwuGKue/lQpg8FfOJyoYygfi1w1JvGKFnt9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P3eTCLxE; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so41717615e9.1;
        Sun, 06 Oct 2024 23:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728282986; x=1728887786; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9KcozfzNrGtm7Jg1OYS7XiKGq1hLVUj14VPQXzuz+A=;
        b=P3eTCLxE6SHpu/7fg/MzM6h42N69AIHXt1xMmAXhOXaoQvLck2wQcydZNumd2i9vVF
         tzGi7Y9zU3ciTnFeFyV+pnuAFMpIuSb8M7uoQsz4DL1vnUxw3tPRnoyXBI2tdRKmx7FI
         KxzeuiIYZjXI80R40Zn+ITfJTXwMcHOfHwdq/fWvo01sMtR91Zs5Xvh6w94ZH+xR05oj
         U/4/6ao8CfUoNrmKHMVSAcVfKaZtBE5PBID1rYO1tW1lT1TkjbxQVa401LSTnBm9KawL
         3Aarz7AxoJCjyW7K/cHuDI7vo0EU/JJ2t79NQp/wjqPySZGSEgm+26x8q95a5YDdHBIQ
         4vhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728282986; x=1728887786;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9KcozfzNrGtm7Jg1OYS7XiKGq1hLVUj14VPQXzuz+A=;
        b=plzKLUnxNo08HXZ+U3ct2Cgfdu2XlWwFXZ4cRKpwtqfYOc9vyoNyac2Mued8imd3xV
         aKEtdlOmSPqOTM7uJqaV/UUDKaHg6G8jFlRnL4yiGQs4jkEX4te+FeNHy36fOjq5yI1r
         5fa6HpVwyfHWFU6KC402CZ7er/l+Nys401XYvJhXwbddYG/i062mTUABylDJnEBFQeQq
         0JWrMWxwSbB5BD4GtDx7+OEU067/zkIVn4TjoWsqxxbH5Jv27MyhGEVS/zzGEyf8FF5C
         cD75RGepsL6mrC+vPXHEmrTKgB8E/4IUR3CM0hMZRZNWoneujLn5eR73nCUTapF3HJG9
         /nLw==
X-Forwarded-Encrypted: i=1; AJvYcCUjdfDYzQL/7EAbs8Q9yT/4SWpMAMIjztPxHe3JRWCM8v3Zb/mQRM+QH1PRJiyUXXeR+AKV9M0Ru64ZMQG0@vger.kernel.org, AJvYcCXA8r0zVWvHimQF2gtaTf+howejoChrY66Xg3cprTMHfvZe9nUXcLFbL/HQHFIgosUUULtMwAJFngF0@vger.kernel.org, AJvYcCXhf9V1XXTwIHklidsB/3MTqVOTTS4DMVCfjcu6wswRbMsVPFvwfehx3yA06g+WU37pNRe4gVuir6WY@vger.kernel.org
X-Gm-Message-State: AOJu0YzVKl3M4j7Y5Y4vSDkJ0/M0Zp5CZrIEBp5RdDsreeueq5MOJctq
	xBkH09cGmNzf15C4j0OPEqkT5JaWfg5f+rmlSH439iOFBfxBbSrS
X-Google-Smtp-Source: AGHT+IEw/5B8YbIpJr3VwDEnkgsouDIKsZG+w5d9K1o6B2P+dukfh5MjAgLA2xt3xrgfvK2BzjBaQw==
X-Received: by 2002:a5d:457b:0:b0:37c:ffdd:6d55 with SMTP id ffacd0b85a97d-37d0e6bb7cdmr5535922f8f.11.1728282986040;
        Sun, 06 Oct 2024 23:36:26 -0700 (PDT)
Received: from nsa.fritz.box ([2001:a61:34c9:ea01:14b4:7ed9:5135:9381])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f89ed91b8sm64819615e9.41.2024.10.06.23.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Oct 2024 23:36:25 -0700 (PDT)
Message-ID: <081d981d5afe1216e387e93005ddaf57f5e4bd99.camel@gmail.com>
Subject: Re: [PATCH v4 06/11] iio: backend: extend features
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Angelo Dureghello
	 <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>
Date: Mon, 07 Oct 2024 08:36:25 +0200
In-Reply-To: <20241006144841.08fb2102@jic23-huawei>
References: 
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	 <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-6-ceb157487329@baylibre.com>
	 <451aaf360690cf60704e8a2880e98501156bda73.camel@gmail.com>
	 <ihkd45xlg3hejchdw6ksmuzoxu3cazmx5rd4d4zca7xl4rfcrd@krururfftdlx>
	 <20241006144841.08fb2102@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-10-06 at 14:48 +0100, Jonathan Cameron wrote:
> On Fri, 4 Oct 2024 15:45:21 +0200
> Angelo Dureghello <adureghello@baylibre.com> wrote:
>=20
> > Hi Nuno,
> >=20
> > On 04.10.2024 14:54, Nuno S=C3=A1 wrote:
> > > On Thu, 2024-10-03 at 19:29 +0200, Angelo Dureghello wrote:=C2=A0=20
> > > > From: Angelo Dureghello <adureghello@baylibre.com>
> > > >=20
> > > > Extend backend features with new calls needed later on this
> > > > patchset from axi version of ad3552r.
> > > >=20
> > > > The follwoing calls are added:
> > > >=20
> > > > iio_backend_ddr_enable
> > > > 	enable ddr bus transfer
> > > > iio_backend_ddr_disable
> > > > 	disable ddr bus transfer
> > > > iio_backend_buffer_enable
> > > > 	enable buffer
> > > > iio_backend_buffer_disable
> > > > 	disable buffer
> > > > iio_backend_data_transfer_addr
> > > > 	define the target register address where the DAC sample
> > > > 	will be written.
> > > >=20
> > > > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > > > ---
> > > > =C2=A0drivers/iio/industrialio-backend.c | 79
> > > > ++++++++++++++++++++++++++++++++++++++
> > > > =C2=A0include/linux/iio/backend.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 17 ++++++++
> > > > =C2=A02 files changed, 96 insertions(+)
> > > >=20
> > > > diff --git a/drivers/iio/industrialio-backend.c b/drivers/iio/indus=
trialio-
> > > > backend.c
> > > > index 20b3b5212da7..d5e0a4da761e 100644
> > > > --- a/drivers/iio/industrialio-backend.c
> > > > +++ b/drivers/iio/industrialio-backend.c
> > > > @@ -718,6 +718,85 @@ static int __devm_iio_backend_get(struct devic=
e *dev,
> > > > struct
> > > > iio_backend *back)
> > > > =C2=A0	return 0;
> > > > =C2=A0}
> > > > =C2=A0
> > > > +/**
> > > > + * iio_backend_ddr_enable - Enable interface DDR (Double Data Rate=
) mode
> > > > + * @back: Backend device
> > > > + *
> > > > + * Enable DDR, data is generated by the IP at each front (raising =
and
> > > > falling)
> > > > + * of the bus clock signal.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ddr_enable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ddr_enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_enable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_ddr_disable - Disable interface DDR (Double Data Ra=
te) mode
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disable DDR, setting into SDR mode (Single Data Rate).
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_ddr_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, ddr_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_ddr_disable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_dma_stream_enable - Enable iio buffering
> > > > + * @back: Backend device
> > > > + *
> > > > + * Enabling sending the dma data stream over the bus.
> > > > + * bus interface.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_dma_stream_enable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, dma_stream_enable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_enable, IIO_BACKEND);
> > > > +
> > > > +/**
> > > > + * iio_backend_dma_stream_disable - Disable iio buffering
> > > > + * @back: Backend device
> > > > + *
> > > > + * Disable sending the dma data stream over the bus.
> > > > + *
> > > > + * RETURNS:
> > > > + * 0 on success, negative error number on failure.
> > > > + */
> > > > +int iio_backend_dma_stream_disable(struct iio_backend *back)
> > > > +{
> > > > +	return iio_backend_op_call(back, dma_stream_disable);
> > > > +}
> > > > +EXPORT_SYMBOL_NS_GPL(iio_backend_dma_stream_disable, IIO_BACKEND);
> > > > +=C2=A0=20
> > >=20
> > > I'm not sure if this is what Jonathan was suggesting... Ate least I d=
on't
> > > really
> > > agree with it. I mean, yes, this is about buffering and to start rece=
iving (or
> > > sending) a stream of data. But AFAICT, it might have nothing to do wi=
th DMA.
> > > Same as
> > > .request_buffer() - It's pretty much always a DMA one but we should n=
ot take
> > > that for
> > > granted.
>=20
> Agreed. The stream bit works, the DMA is more tenuous.=C2=A0 Maybe *data_=
stream_enable()
> is generic enough.
>=20
> > >=20
> > > So going back to the RFC [1], you can see I was suggesting something =
like
> > > struct
> > > iio_buffer_setup_ops. Maybe just add the ones we use for now? So that=
 would
> > > be.buffer_postenable() and .buffer_predisable(). Like this, it should=
 be
> > > obvious the
> > > intent of the ops.
> > > =C2=A0=20
> > ok, thanks,
> >=20
> > so something as :
> >=20
> > struct iio_backend_setup_ops {
> > 	int (*buffer_postenable)(struct iio_backend *back);
> > 	int (*buffer_predisable)(struct iio_backend *back);
>=20

For me the above is ok as it goes in line with what we currently have. But =
I was not
aware that Jonathan was not 100% with that naming :). So, *data_stream_enab=
le() also
seems like a good fit to me (and I agree it's more clear about the intent o=
f the
function). To sum it up, I'm fine with either option.

- Nuno S=C3=A1





