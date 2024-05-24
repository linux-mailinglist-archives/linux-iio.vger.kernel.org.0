Return-Path: <linux-iio+bounces-5262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1558CE481
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 12:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4025DB21202
	for <lists+linux-iio@lfdr.de>; Fri, 24 May 2024 10:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF3AB85C44;
	Fri, 24 May 2024 10:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="evgsMX2X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFD5385297;
	Fri, 24 May 2024 10:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716548202; cv=none; b=iDLkeZBUyrColqCv+hou+/LzI93eD3zQDQ/SYwV2gzR48yEjccJVLMCyxM7KHE8iDGaWsZlKN4BcPkj349FC9/wbpzMYVOGGEaQsg2ZxfL7SJdFYOQZ7GzY8nbagZt+AtnIN8RKBmbr00Q0BRsVsyf/T7qw2So5Vd+Ui0dFxq/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716548202; c=relaxed/simple;
	bh=qmNeRLIE7RaE8qTw7fneqeSRA7Haym+URuBv3R9ayz8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QAeXU+TDakMOL+0etFpHf/7bkLjcwQdw0FBApdJS141tsbvZo9/hXq7R9SVdMl/I46kE0DRFSg4KDx0Va5VfUsVQ16R47K6Xu4Xae3oBiwdvisLOJZUlGlQWgydnkphmhf73y8kt2lDP3bL6vcMYAkuQJ2oAwPwTGFev2aWwEOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=evgsMX2X; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52905ff2a9eso1245751e87.0;
        Fri, 24 May 2024 03:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716548199; x=1717152999; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chuncWI3kKMrdclSsL6Z1EFtDmOR9OUsvrlhc7fKux8=;
        b=evgsMX2XAFteOcihgGFJb7h1gW/u4/oXLksN+Gl4ur5QPYhF6cAOMphKsFzWB4YTHw
         bJ9QWYH9sG8Mj4FEXb+aTt6AifLvqRRq+FlXUaLUWwXJQum6KVm/6W3kP27alUZENMO5
         zvjRDTwTjNOGyNb73LJFZ3zzb8mu6BGlb6PaqX4lUzsRkvYJ97UA4QbTff6NZ8lR59Ac
         xu6r54trSmORQxwBoSSxhW6A5VER1NrZZOIwVggvNtc6ho1GXRflQ0sV6qpJ7JT5VzqX
         6mykVJcUTXrkDPpsn2w6ItJ1dgQArFuYSI/dRuYDvjLNGdX65XPJTugFTV72yIgUUC0j
         xPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716548199; x=1717152999;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=chuncWI3kKMrdclSsL6Z1EFtDmOR9OUsvrlhc7fKux8=;
        b=HiShJwxkkQrZKIjlwy9qSgmxsfbn/l+9y7gWm47RF5nXExyJExi5m3Ha7nMgDJTCTL
         sj2WQhQDH4Ar+EekoXXj0yxu4Dfmr5OTrmVAGfTQhADBx4uWJWhvx3i+xPchen2DGw7A
         JdmPnSeBpmsnuqurnkl3ULk2O6aMCAEJl4pjtHDEQT0wtjUItBmgAL7ePWhPFt/spBoJ
         vsLGVhHLDtavYaSU5do/3BXRazX5MWTsjbkaZ7azpH9lpAoEIdfEsEUts0YwQDjjJKj2
         4bY8kquf3SJBJBt9OkrgE3DR2FiMINm9tlk1TSixtcrpaBV70jpEGT3snUVOTgTlDcro
         CpZw==
X-Forwarded-Encrypted: i=1; AJvYcCUX72Pr/2JP2GERyXNBOAIJAJ4miZzSxbTrqRPuftBeANJ2bIvJNq1RlI1wzPc4OI8Ua2WnxRuNTRAe+QOCBcj8bELYZSOkNrKyR9PYZ6rIqu1A2cM+UJ1PdlZAtqYsJ7FnDui5ybZ4now5mMlO1MdfxJkWJLudF8tF/HCyh4tlRdF67Q==
X-Gm-Message-State: AOJu0YySkDXLDU4Kk0T3DGPKUzkvsLMUux6JlHyxraAKkw+W2IZR017W
	x6zcshU7bBJqepJoWxyImX111Q8kolYJzM2l+rVUc61ugNnIU7Cb
X-Google-Smtp-Source: AGHT+IFipF/spO+1+EZiCS8LaZjyLTxE12WvzYTcbipjiqvxRFxYrlw+PSeV5sgUTRO1tw1pkKoUeQ==
X-Received: by 2002:a05:6512:142:b0:51d:15ef:dc10 with SMTP id 2adb3069b0e04-5296528eb2bmr1023230e87.41.1716548198691;
        Fri, 24 May 2024 03:56:38 -0700 (PDT)
Received: from ?IPv6:2001:a61:35f9:9001:40df:88bb:5090:7ab6? ([2001:a61:35f9:9001:40df:88bb:5090:7ab6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4210897c6bbsm17537055e9.27.2024.05.24.03.56.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 03:56:38 -0700 (PDT)
Message-ID: <bdc88590fe3e54326c1edbe6f2b4ac2d8f453df4.camel@gmail.com>
Subject: Re: [PATCH v4 10/10] drivers: iio: imu: Add support for adis1657x
 family
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, conor+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Date: Fri, 24 May 2024 12:56:38 +0200
In-Reply-To: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
References: <20240524090329.340810-1-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-05-24 at 12:03 +0300, Ramona Gradinariu wrote:
> Add support for ADIS1657X family devices in already exiting ADIS16475
> driver.
>=20
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---
> changes in v4:
> =C2=A0- removed AIDS16575_HAS_FIFO flag and instead used has_fifo flag fr=
om adis_data
> =C2=A0- removed timestamp channel for devices which support FIFO readings=
 (adis1657x)
> =C2=A0- dropped the dev_attr.attr. from adis16475_fifo_attributes
> =C2=A0- reworked if (ret) as advised
> =C2=A0drivers/iio/imu/adis16475.c | 649 ++++++++++++++++++++++++++++++++-=
---
> =C2=A01 file changed, 579 insertions(+), 70 deletions(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 3bbf3e181e1a..f0eed75c4fb2 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -14,6 +14,7 @@
> =C2=A0#include <linux/iio/buffer.h>
> =C2=A0#include <linux/iio/iio.h>
> =C2=A0#include <linux/iio/imu/adis.h>
> +#include <linux/iio/sysfs.h>
> =C2=A0#include <linux/iio/trigger_consumer.h>
> =C2=A0#include <linux/irq.h>
> =C2=A0#include <linux/lcm.h>

...


> @@ -1264,20 +1582,30 @@ static int adis16475_push_single_sample(struct
> iio_poll_func *pf)
> =C2=A0	__be16 *buffer;
> =C2=A0	u16 crc;
> =C2=A0	bool valid;
> +	u8 crc_offset =3D 9;
> +	u16 burst_size =3D ADIS16475_BURST_MAX_DATA;
> +	u16 start_idx =3D (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 2 : 0=
;
> +
> =C2=A0	/* offset until the first element after gyro and accel */
> =C2=A0	const u8 offset =3D st->burst32 ? 13 : 7;
>=20
> +	if (st->burst32) {
> +		crc_offset =3D (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ? 16 :
> 15;
> +		burst_size =3D (st->info->flags & ADIS16475_HAS_TIMESTAMP32) ?
> +			=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16575_BURST32_DATA_TS32 :
> ADIS16475_BURST32_MAX_DATA_NO_TS32;

can we use the info in the adis_data struct rather than the conditional?

> +	}
> +
> =C2=A0	ret =3D spi_sync(adis->spi, &adis->msg);
> =C2=A0	if (ret)
> -		goto check_burst32;
> +		return ret;
>=20

...

>=20
> +static irqreturn_t adis16475_trigger_handler_with_fifo(int irq, void *p)
> =C2=A0{
> =C2=A0	struct iio_poll_func *pf =3D p;
> =C2=A0	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis16475 *st =3D iio_priv(indio_dev);
> +	struct adis *adis =3D &st->adis;
> +	int ret;
> +	u16 fifo_cnt, i;
>=20
> -	adis16475_push_single_sample(pf);
> +	adis_dev_lock(&st->adis);
> +
> +	ret =3D __adis_read_reg_16(adis, ADIS16575_REG_FIFO_CNT, &fifo_cnt);
> +	if (ret)
> +		goto unlock;
> +
> +	/*
> +	 * If no sample is available, nothing can be read. This can happen if
> +	 * a the used trigger has a higher frequency than the selected sample
> rate.
> +	 */
> +	if (!fifo_cnt)
> +		goto unlock;
> +
> +	/*
> +	 * First burst request - FIFO pop: popped data will be returned in the
> +	 * next burst request.
> +	 */
> +	ret =3D adis16575_custom_burst_read(pf, adis->data->burst_reg_cmd);
> +	if (ret)
> +		goto unlock;
> +
> +	for (i =3D 0; i < fifo_cnt - 1; i++) {
> +		ret =3D adis16475_push_single_sample(pf);
> +		if (ret)
> +			goto unlock;
> +	}
> +
> +	/* FIFO read without popping */
> +	ret =3D adis16575_custom_burst_read(pf, 0);
> +	if (ret)
> +		goto unlock;
> +

This jump is useless :). Either move the label before adis_dev_unlock() or =
ignore the
error code completely. It's the question of we should still do
adis16475_burst32_check() in case adis16575_custom_burst_read() fails. Like=
ly not...
=20
> +unlock:
> +	/*
> +	 * We only check the burst mode at the end of the current capture since
> +	 * reading data from registers will impact the FIFO reading.
> +	 */
> +	adis16475_burst32_check(st);
> +	adis_dev_unlock(&st->adis);
> =C2=A0	iio_trigger_notify_done(indio_dev->trig);
>=20
> =C2=A0	return IRQ_HANDLED;
> @@ -1367,6 +1799,14 @@ static int adis16475_config_sync_mode(struct adis1=
6475 *st)
> =C2=A0	u32 sync_mode;
> =C2=A0	u16 max_sample_rate =3D st->info->int_clk + 100;
>=20
> +	/* if available, enable 4khz internal clock */
> +	if (st->info->int_clk =3D=3D 4000) {
> +		ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16575_SYNC_4KHZ_MASK,
> (u16)ADIS16575_SYNC_4KHZ(1));
> +		if (ret)
> +			return ret;
> +	}
> +
> =C2=A0	/* default to internal clk */
> =C2=A0	st->clk_freq =3D st->info->int_clk * 1000;
>=20
> @@ -1444,34 +1884,67 @@ static int adis16475_config_irq_pin(struct adis16=
475 *st)
> =C2=A0	u8 polarity;
> =C2=A0	struct spi_device *spi =3D st->adis.spi;
>=20
> -	/*
> -	 * It is possible to configure the data ready polarity. Furthermore, we
> -	 * need to update the adis struct if we want data ready as active low.
> -	 */
> =C2=A0	irq_type =3D irq_get_trigger_type(spi->irq);
> -	if (irq_type =3D=3D IRQ_TYPE_EDGE_RISING) {
> -		polarity =3D 1;
> -		st->adis.irq_flag =3D IRQF_TRIGGER_RISING;
> -	} else if (irq_type =3D=3D IRQ_TYPE_EDGE_FALLING) {
> -		polarity =3D 0;
> -		st->adis.irq_flag =3D IRQF_TRIGGER_FALLING;
> +
> +	if (st->adis.data->has_fifo) {
> +		/*
> +		 * It is possible to configure the fifo watermark pin polarity.
> +		 * Furthermore, we need to update the adis struct if we want the
> +		 * watermark pin active low.
> +		 */
> +		if (irq_type =3D=3D IRQ_TYPE_LEVEL_HIGH) {
> +			polarity =3D 1;
> +			st->adis.irq_flag =3D IRQF_TRIGGER_HIGH;
> +		} else if (irq_type =3D=3D IRQ_TYPE_LEVEL_LOW) {
> +			polarity =3D 0;
> +			st->adis.irq_flag =3D IRQF_TRIGGER_LOW;
> +		} else {
> +			dev_err(&spi->dev, "Invalid interrupt type 0x%x
> specified\n",
> +				irq_type);
> +			return -EINVAL;
> +		}
> +
> +		/* Configure the watermark pin polarity. */
> +		ret =3D adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16575_WM_POL_MASK,
> (u16)ADIS16575_WM_POL(polarity));

Maybe in the if() statements, do polarity =3D ADIS16575_WM_POL(0|1) and her=
e use the
variable. Then, no need for the annoying cast.

> +		if (ret)
> +			return ret;
> +
> +		/* Enable watermark interrupt pin. */
> +		ret =3D adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16575_WM_EN_MASK,
> (u16)ADIS16575_WM_EN(1));
> +		if (ret)
> +			return ret;
> +
> =C2=A0	} else {
> -		dev_err(&spi->dev, "Invalid interrupt type 0x%x specified\n",
> -			irq_type);
> -		return -EINVAL;
> -	}
> +		/*
> +		 * It is possible to configure the data ready polarity.
> Furthermore, we
> +		 * need to update the adis struct if we want data ready as active
> low.
> +		 */
> +		if (irq_type =3D=3D IRQ_TYPE_EDGE_RISING) {
> +			polarity =3D 1;
> +			st->adis.irq_flag =3D IRQF_TRIGGER_RISING;
> +		} else if (irq_type =3D=3D IRQ_TYPE_EDGE_FALLING) {
> +			polarity =3D 0;
> +			st->adis.irq_flag =3D IRQF_TRIGGER_FALLING;
> +		} else {
> +			dev_err(&spi->dev, "Invalid interrupt type 0x%x
> specified\n",
> +				irq_type);
> +			return -EINVAL;
> +		}
>=20
> -	val =3D ADIS16475_MSG_CTRL_DR_POL(polarity);
> -	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> -				 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> -	if (ret)
> -		return ret;
> -	/*
> -	 * There is a delay writing to any bits written to the MSC_CTRL
> -	 * register. It should not be bigger than 200us, so 250 should be more
> -	 * than enough!
> -	 */
> -	usleep_range(250, 260);
> +		val =3D ADIS16475_MSG_CTRL_DR_POL(polarity);
> +		ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> +					 ADIS16475_MSG_CTRL_DR_POL_MASK, val);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * There is a delay writing to any bits written to the MSC_CTRL
> +		 * register. It should not be bigger than 200us, so 250 should be
> more
> +		 * than enough!
> +		 */
> +		usleep_range(250, 260);
> +	}
>=20
> =C2=A0	return 0;
> =C2=A0}
> @@ -1500,7 +1973,10 @@ static int adis16475_probe(struct spi_device *spi)
> =C2=A0	indio_dev->name =3D st->info->name;
> =C2=A0	indio_dev->channels =3D st->info->channels;
> =C2=A0	indio_dev->num_channels =3D st->info->num_channels;
> -	indio_dev->info =3D &adis16475_info;
> +	if (st->adis.data->has_fifo)
> +		indio_dev->info =3D &adis16575_info;
> +	else
> +		indio_dev->info =3D &adis16475_info;
> =C2=A0	indio_dev->modes =3D INDIO_DIRECT_MODE;
>=20
> =C2=A0	ret =3D __adis_initial_startup(&st->adis);
> @@ -1515,10 +1991,25 @@ static int adis16475_probe(struct spi_device *spi=
)
> =C2=A0	if (ret)
> =C2=A0		return ret;
>=20
> -	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> -						 adis16475_trigger_handler);
> -	if (ret)
> -		return ret;
> +	if (st->adis.data->has_fifo) {
> +		ret =3D devm_adis_setup_buffer_and_trigger_with_attrs(&st->adis,
> indio_dev,
> +								=C2=A0=C2=A0=C2=A0
> adis16475_trigger_handler_with_fifo,
> +								=C2=A0=C2=A0=C2=A0
> &adis16475_buffer_ops,
> +								=C2=A0=C2=A0=C2=A0
> adis16475_fifo_attributes);
> +		if (ret)
> +			return ret;
> +
> +		/* Update overflow behavior to always overwrite the oldest sample.
> */
> +		ret =3D adis_update_bits(&st->adis, ADIS16475_REG_FIFO_CTRL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16575_OVERFLOW_MASK,
> (u16)ADIS16575_OVERWRITE_OLDEST);

Slight preference for local variable to avoid the cast.

- Nuno S=C3=A1


