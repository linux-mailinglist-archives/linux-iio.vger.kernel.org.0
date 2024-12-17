Return-Path: <linux-iio+bounces-13571-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E979F48CC
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 11:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5917188CEA0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Dec 2024 10:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311931E1A05;
	Tue, 17 Dec 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV/TeKiz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6281DDC3F;
	Tue, 17 Dec 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431095; cv=none; b=CsiBzV8MzUM7WGhwqxq38aH7jSYRDlZqmyU8U+YSz0BYIqfOgnKntpbTAFkrmnSYEXJ7Qc3JB6i4nTySMZeQ+CF5+BRu76wt5RqroC4f9Y01HpUNUuZxa4gVyVaNyg7PwINQjQpd8S+UNLq6fWqv3M4ckcQWtinEjueueUeZvL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431095; c=relaxed/simple;
	bh=+Aa0th8kh0P6t4FCykKGXHsokpj0s2HU61ILwAEDgPI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=snB8rJHCOJbsKqKmVhtMPug4OKoeDrSv2RwHklizpDmdO8ffcS6kTnUuPfmsCvGZJDW9rcoHEcEZRJ5CG0YzH4eNr5He6u7ztaljzPKtvARqSM3GUzIzoaF7qlOLb9SGqjUS0O4aeKRcKpysKqTVoPZhKLPQJgDS3YDMWlBroMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV/TeKiz; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a9a68480164so837335466b.3;
        Tue, 17 Dec 2024 02:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734431091; x=1735035891; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JR9XVy0Hb3CmbHmmeBUaM7gXQckI5M4bLOdawixwPYA=;
        b=iV/TeKiz8qJ8QC5R0NwskYPY7gZroRPid8ilrULTLXGEXAO+jmdW3j3O01PWcYw7dE
         HLGnVFDIhFg0FpNXTWkk73aJPPuwL3OyXiUXrgDGwaSHVG/KKSMtg0is+cW1wUPIynS3
         MFbkvjpeEaK1RBMGnm1dNj5CJ2dUz9I9sN4u22VKamdzFm6YsKp3Fhp00NitARyKlOSl
         uv6pWsu8B41BnOh913GWPM6xwlmsKRZfj1yfhNSM9aYD5MIW8lhy6dkJBVJg1dkOo4nY
         txKp8xh9BXrWGUzHJjUfdN+6eZgU/31xla0AXzbfKMJh/qWnhgZdPxC815XeQAuudw51
         5R8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734431091; x=1735035891;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JR9XVy0Hb3CmbHmmeBUaM7gXQckI5M4bLOdawixwPYA=;
        b=E5D3RLrAnrA1o4/+CvfqaETNPTxb9hyBo3dQMI+SAbcdea7xLRwi/rCFIEnNv0tvB+
         4nRsjpgywtMHvuZv8gIHIuImgcYfueElkR/2URg0nbtai6YbEgENTi/pqTRBjUOka+mP
         XHK6cG7AnqgpecQYZq7jcd3QsqWBAojzEkTSujB8VXd8nBONLZKq5oJh2q6kvVYt+jt0
         WHReqJHCItXW5/qkVxOQ8D1UrF+SqmQf7voCIyKOwLCPv4Yp9eFtXU0/23xCl7wS0l9A
         LF2FaRJgv+oZtlGH30XdNdORuNAPzc5WWlfxTVEeEAtTqLfpDeBIGmvlHntpnri3eLg8
         ReoA==
X-Forwarded-Encrypted: i=1; AJvYcCVRXbHCtq8rRNH4M1YKDSFpPTEMqUUFnzOAaBUJBOCDkixknXDAFAa0dRrm5jIgYlvv+xj2JZwNPD9E@vger.kernel.org, AJvYcCWLD0DWw4w2iFkYEiL/cblVx8X6TsqFGSWir4CrvKLvhmgcLabAueK/IzFxFOm7H1/rX1JNs6ds60rQ2XLi@vger.kernel.org, AJvYcCWciLZVIcraCl0VgP6HKqL3SwY2lI87dUfLxypz62V5Ah2fY1ZP+WzpFm5kINndRocfdkzxRdF54rPY@vger.kernel.org, AJvYcCXetaAr8jap8vqtj24LGct1DX5PL7durVpBxGTnatNCuFk9zpZT2qojs/4xLGIgy78JHm4a+3J2pMaP@vger.kernel.org
X-Gm-Message-State: AOJu0YyEuS5gb8pYed9CL69T843e15yc1igHzWG/er5FdsuWwDqwRRKn
	+Wp8zI1PadmGuK7dlqYgu5xPDsRtu75orcXPyFglvpgdtZmDDikJ
X-Gm-Gg: ASbGnctdAddmyXlWyad0DDB+fS2XesktyOEt/y5FAJzY0wRVUG25qCOi0hdND6akNHm
	ZL+077sNpwbJIdC9JA+3X7u7Xu1s9sMf6nyDCGwZc82sxWSATLiuH6sIbufqObikQVaQrfTj9mt
	3T+0l+Rw2Bue1/7mjwJhoMdGrhXwpASBG/8rd+c8C86O25kkkN4lTI63kvW3FQ9YfHu7ezwiPG1
	5BTg20u0rddIpMWDRPysy2SjL/V+ccEioFNkJ0qWUYeOPTlFcCjk/SDjpWwup7pOxrQI/rL5R+7
	z2Obs1+zoTxcdf2DKO+F10LiH6zMuCQFwR08+77+FYa5KpBSQuWilw8iXG0YY5n6Lx/zYapspjg
	aAqMHbDfN+bK+Uw==
X-Google-Smtp-Source: AGHT+IFAYiD/3BzvU0Ztw0TgRXVfOis2ABlkxkXvOpFiCeCHDlQf8O38ISWMizaDRGP3JnqXEXkk2g==
X-Received: by 2002:a17:907:9623:b0:aa6:7cf3:c6f0 with SMTP id a640c23a62f3a-aab7792d033mr1697315766b.14.1734431090594;
        Tue, 17 Dec 2024 02:24:50 -0800 (PST)
Received: from ?IPv6:2003:f6:ef10:f100:a045:a7a7:11d0:8676? (p200300f6ef10f100a045a7a711d08676.dip0.t-ipconnect.de. [2003:f6:ef10:f100:a045:a7a7:11d0:8676])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aab96006b34sm428731166b.13.2024.12.17.02.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 02:24:50 -0800 (PST)
Message-ID: <b05c905cd003b6107b700628f451eb2ee42342ea.camel@gmail.com>
Subject: Re: [PATCH v3 6/7] iio: imu: adis16550: add adis16550 support
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Robert Budai <robert.budai@analog.com>, Lars-Peter Clausen
 <lars@metafoo.de>,  Michael Hennerich <Michael.Hennerich@analog.com>, Nuno
 Sa <nuno.sa@analog.com>, Ramona Gradinariu	 <ramona.gradinariu@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>,  Jonathan Cameron	
 <jic23@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski	
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet	
 <corbet@lwn.net>, Shen Jianping <Jianping.Shen@de.bosch.com>, Alex Lanzano	
 <lanzano.alex@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: robi_budai@yahoo.com
Date: Tue, 17 Dec 2024 11:29:21 +0100
In-Reply-To: <20241216144818.25344-7-robert.budai@analog.com>
References: <20241216144818.25344-1-robert.budai@analog.com>
	 <20241216144818.25344-7-robert.budai@analog.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Robert,

Some comments from my side...

On Mon, 2024-12-16 at 16:48 +0200, Robert Budai wrote:
> The ADIS16550 is a complete inertial system that includes a triaxis
> gyroscope and a triaxis accelerometer. Each inertial sensor in
> the ADIS16550 combines industry leading MEMS only technology
> with signal conditioning that optimizes dynamic performance. The
> factory calibration characterizes each sensor for sensitivity, bias,
> and alignment. As a result, each sensor has its own dynamic com-
> pensation formulas that provide accurate sensor measurements
>=20
> Co-developed-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> Co-developed-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Robert Budai <robert.budai@analog.com>
> ---
>=20
> v3:
> - freed xbuf
> - fixed code styling related issues
> - removed the sensor type enum and used separate structures for providing=
 chip
> info data
>=20
>=20

...=20

> +
> +static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> +{
> +	u32 crc;
> +	u16 dummy;
> +	bool valid;
> +	int ret, i =3D 0;
> +	u8 data_offset =3D 4;
> +	struct iio_poll_func *pf =3D p;
> +	__be32 data[ADIS16550_MAX_SCAN_DATA];
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	__be32 *buffer =3D adis->buffer;
> +
> +	ret =3D spi_sync(adis->spi, &adis->msg);
> +	if (ret)
> +		goto done;
> +	/*
> +	 * Validate the header. The header is a normal spi reply with state
> +	 * vector and crc4.
> +	 */
> +	ret =3D adis16550_spi_validate(&st->adis, buffer[0], &dummy);
> +	if (ret)
> +		goto done;
> +
> +	crc =3D be32_to_cpu(buffer[ADIS16550_BURST_N_ELEM - 1]);
> +	/* the header is not included in the crc */
> +	valid =3D adis16550_validate_crc((u32 *)&buffer[1],
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ADIS16550_BURST_N_ELEM - 2, crc=
);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
> +		goto done;
> +	}
> +
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_GYRO_X)) {
> +		memcpy(&data[i], &buffer[data_offset],
> (ADIS16550_SCAN_ACCEL_Z -
> +						ADIS16550_SCAN_GYRO_X + 1) *
> +						sizeof(__be32));
> +		i +=3D ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 1;
> +	}
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_TEMP))
> +		data[i++] =3D buffer[data_offset - 1];
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_DELTANG_X))
> +		memcpy(&data[i], &buffer[data_offset],
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (ADIS16550_SCAN_DELTVEL_Z - ADIS1=
6550_SCAN_DELTANG_X +
> 1) *
> +		=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(__be32));
>=20

Can't we just reorder the channels in adis16550_channels so that we have a =
plain
memcpy()? Like having the temperature before the accel + gyro or the delta
stuff? Then you should only need to care about the initial offset (to accou=
nt
for DATA_CNT and STATUS). Right?

> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const unsigned long adis16550_channel_masks[] =3D {
> +	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +};
> +
> +static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
> +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const unsigned long *scan_mask)
> +{
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	u16 burst_length =3D ADIS16550_BURST_DATA_LEN;
> +	u8 burst_cmd;
> +	u8 *tx;
> +
> +	if (*scan_mask & ADIS16550_BURST_DATA_GYRO_ACCEL_MASK)
> +		burst_cmd =3D ADIS16550_REG_BURST_GYRO_ACCEL;
> +	else
> +		burst_cmd =3D ADIS16550_REG_BURST_DELTA_ANG_VEL;
> +
> +	if (adis->xfer)
> +		memset(adis->xfer, 0, 2 * sizeof(*adis->xfer));
> +	if (adis->buffer)
> +		memset(adis->buffer, 0, burst_length + sizeof(u32));
>=20

The above checks should be removed. Likely from a previous version...

> +	tx =3D adis->buffer + burst_length;
> +	tx[0] =3D 0x00;
> +	tx[1] =3D 0x00;
> +	tx[2] =3D burst_cmd;
> +	/* crc4 is 0 on burst command */
> +	tx[3] =3D spi_crc4(get_unaligned_le32(tx));
> +
> +	adis->xfer[0].tx_buf =3D tx;
> +	adis->xfer[0].len =3D 4;
> +	adis->xfer[0].cs_change =3D 1;
> +	adis->xfer[0].delay.value =3D 8;
> +	adis->xfer[0].delay.unit =3D SPI_DELAY_UNIT_USECS;
> +	adis->xfer[1].rx_buf =3D adis->buffer;
> +	adis->xfer[1].len =3D burst_length;
> +
> +	spi_message_init_with_transfers(&adis->msg, adis->xfer, 2);
> +
> +	return 0;
> +}
> +
> +static int adis16550_reset(struct adis *adis)
> +{
> +	return __adis_write_reg_16(adis, ADIS16550_REG_COMMAND, BIT(15));
> +}
> +
> +static int adis16550_config_sync(struct adis16550 *st)
> +{
> +	struct device *dev =3D &st->adis.spi->dev;
> +	const struct adis16550_sync *sync;
> +	struct clk *clk;
> +	u32 sync_mode;
> +	u16 mode;
> +	int ret;
> +
> +	if (!device_property_present(dev, "adi,sync-mode")) {
> +		st->clk_freq_hz =3D st->info->int_clk * 1000;
> +		return 0;
> +	}
>=20

I would do it in another way...

ret =3D device_property_read_u32(dev, "adi,sync-mode", &sync_mode);
if (ret) {
	st->clk_freq_hz =3D st->info->int_clk * 1000;
	return 0;
}

/* then proceed */

> +	ret =3D device_property_read_u32(dev, "adi,sync-mode", &sync_mode);
> +	if (ret)
> +		return 0;
> +
> +	if (sync_mode >=3D st->info->num_sync) {
> +		dev_err(dev, "Invalid sync mode: %u for %s\n", sync_mode,
> +			st->info->name);
> +		return -EINVAL;
> +	}
> +
> +	sync =3D &st->info->sync_mode[sync_mode];
> +	st->sync_mode =3D sync->sync_mode;
> +
> +	clk =3D devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(clk))
> +		return PTR_ERR(clk);
> +
> +	st->clk_freq_hz =3D clk_get_rate(clk);
> +	if (st->clk_freq_hz > sync->max_rate || st->clk_freq_hz < sync-
> >min_rate)
> +		return dev_err_probe(dev, -EINVAL,
> +				=C2=A0=C2=A0=C2=A0=C2=A0 "Clk rate: %lu not in a valid range:[%u
> %u]\n",
> +				=C2=A0=C2=A0=C2=A0=C2=A0 st->clk_freq_hz, sync->min_rate, sync-
> >max_rate);
> +
> +	if (sync->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		u16 sync_scale;
> +		u32 scaled_freq =3D 0;
> +		/*
> +		 * In pps scaled sync we must scale the input clock to a
> range
> +		 * of [3000 45000].
> +		 */
> +		ret =3D device_property_read_u32(dev, "adi,scaled-output-hz",
> +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &scaled_freq);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "adi,scaled-output-hz property
> not found");
> +
> +		if (scaled_freq < 3000 || scaled_freq > 4500)
> +			return dev_err_probe(dev, -EINVAL,
> +					=C2=A0=C2=A0=C2=A0=C2=A0 "Invalid value:%u for
> adi,scaled-output-hz",
> +					=C2=A0=C2=A0=C2=A0=C2=A0 scaled_freq);
> +
> +		sync_scale =3D DIV_ROUND_CLOSEST(scaled_freq, st->clk_freq_hz);
> +
> +		ret =3D adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					sync_scale);
> +		if (ret)
> +			return ret;
> +
> +		st->clk_freq_hz =3D scaled_freq;
> +	}
> +
> +	st->clk_freq_hz *=3D 1000;
> +
> +	mode =3D FIELD_PREP(ADIS16550_SYNC_MODE_MASK, sync->sync_mode) |
> +	=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 FIELD_PREP(ADIS16550_SYNC_EN_MASK,=
 true);
> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				=C2=A0 ADIS16550_SYNC_MASK, mode);
> +}
> +
> +static const struct iio_info adis16550_info =3D {
> +	.read_raw =3D &adis16550_read_raw,
> +	.write_raw =3D &adis16550_write_raw,
> +	.update_scan_mode =3D adis16550_update_scan_mode,
> +	.debugfs_reg_access =3D adis_debugfs_reg_access,
> +};
> +
> +enum {
> +	ADIS16550_STATUS_CRC_CODE,
> +	ADIS16550_STATUS_CRC_CONFIG,
> +	ADIS16550_STATUS_FLASH_UPDATE,
> +	ADIS16550_STATUS_INERIAL,
> +	ADIS16550_STATUS_SENSOR,
> +	ADIS16550_STATUS_TEMPERATURE,
> +	ADIS16550_STATUS_SPI,
> +	ADIS16550_STATUS_PROCESSING,
> +	ADIS16550_STATUS_POWER,
> +	ADIS16550_STATUS_BOOT,
> +	ADIS16550_STATUS_WATCHDOG =3D 15,
> +	ADIS16550_STATUS_REGULATOR =3D 28,
> +	ADIS16550_STATUS_SENSOR_SUPPLY,
> +	ADIS16550_STATUS_CPU_SUPPLY,
> +	ADIS16550_STATUS_5V_SUPPLY
> +};
> +
> +static const char * const adis16550_status_error_msgs[] =3D {
> +	[ADIS16550_STATUS_CRC_CODE] =3D "Code CRC Error",
> +	[ADIS16550_STATUS_CRC_CONFIG] =3D "Configuration/Calibration CRC
> Error",
> +	[ADIS16550_STATUS_FLASH_UPDATE] =3D "Flash Update Error",
> +	[ADIS16550_STATUS_INERIAL] =3D "Overrange for Inertial Signals",
> +	[ADIS16550_STATUS_SENSOR] =3D "Sensor failure",
> +	[ADIS16550_STATUS_TEMPERATURE] =3D "Temperature Error",
> +	[ADIS16550_STATUS_SPI] =3D "SPI Communication Error",
> +	[ADIS16550_STATUS_PROCESSING] =3D "Processing Overrun Error",
> +	[ADIS16550_STATUS_POWER] =3D "Power Supply Failure",
> +	[ADIS16550_STATUS_BOOT] =3D "Boot Memory Failure",
> +	[ADIS16550_STATUS_WATCHDOG] =3D "Watchdog timer flag",
> +	[ADIS16550_STATUS_REGULATOR] =3D "Internal Regulator Error",
> +	[ADIS16550_STATUS_SENSOR_SUPPLY] =3D "Internal Sensor Supply Error.",
> +	[ADIS16550_STATUS_CPU_SUPPLY] =3D "Internal Processor Supply Error.",
> +	[ADIS16550_STATUS_5V_SUPPLY] =3D "External 5V Supply Error",
> +};
> +
> +static const struct adis_timeout adis16550_timeouts =3D {
> +	.reset_ms =3D 1000,
> +	.sw_reset_ms =3D 1000,
> +	.self_test_ms =3D 1000,
> +};
> +
> +static const struct adis_data adis16550_data =3D {
> +	.diag_stat_reg =3D ADIS16550_REG_STATUS,
> +	.diag_stat_size =3D 4,
> +	.prod_id_reg =3D ADIS16550_REG_PROD_ID,
> +	.prod_id =3D 16550,
> +	.self_test_mask =3D BIT(1),
> +	.self_test_reg =3D ADIS16550_REG_COMMAND,
> +	.cs_change_delay =3D 5,
> +	.unmasked_drdy =3D true,
> +	.status_error_msgs =3D adis16550_status_error_msgs,
> +	.status_error_mask =3D BIT(ADIS16550_STATUS_CRC_CODE) |
> +			BIT(ADIS16550_STATUS_CRC_CONFIG) |
> +			BIT(ADIS16550_STATUS_FLASH_UPDATE) |
> +			BIT(ADIS16550_STATUS_INERIAL) |
> +			BIT(ADIS16550_STATUS_SENSOR) |
> +			BIT(ADIS16550_STATUS_TEMPERATURE) |
> +			BIT(ADIS16550_STATUS_SPI) |
> +			BIT(ADIS16550_STATUS_PROCESSING) |
> +			BIT(ADIS16550_STATUS_POWER) |
> +			BIT(ADIS16550_STATUS_BOOT) |
> +			BIT(ADIS16550_STATUS_WATCHDOG) |
> +			BIT(ADIS16550_STATUS_REGULATOR) |
> +			BIT(ADIS16550_STATUS_SENSOR_SUPPLY) |
> +			BIT(ADIS16550_STATUS_CPU_SUPPLY) |
> +			BIT(ADIS16550_STATUS_5V_SUPPLY) |
> +			BIT(ADIS16550_STATUS_CRC_CODE),
> +	.timeouts =3D &adis16550_timeouts,
> +};
> +
> +static const struct adis_ops adis16550_ops =3D {
> +	.write =3D adis16550_spi_write,
> +	.read =3D adis16550_spi_read,
> +	.reset =3D adis16550_reset,
> +};
> +
> +static int adis16550_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct iio_dev *indio_dev;
> +	struct adis16550 *st;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st =3D iio_priv(indio_dev);
> +	st->info =3D spi_get_device_match_data(spi);
> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D st->info->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +
> +	struct spi_transfer *xfer_tmp =3D kcalloc(2, sizeof(*st->adis.xfer),
> GFP_KERNEL);
> +
> +	if (!xfer_tmp)
> +		return -ENOMEM;
> +
> +	void *buffer_tmp =3D kzalloc(ADIS16550_BURST_DATA_LEN + sizeof(u32),
> +				=C2=A0=C2=A0 GFP_KERNEL);

I'm bit a puzzeled... Why do we have it like this? I guess we are missing
__free(kfree) in here? But I would not go with this trouble in here. Why no=
t
devm_kzalloc()? should be safe to be used in here...

> +	if (!buffer_tmp) {
> +		kfree(st->adis.xfer);
> +		return -ENOMEM;
> +	}
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "Failed to get vdd regulator\n");
> +		goto free_on_error;
> +	}
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		goto free_on_error;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		goto free_on_error;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	st->adis.xfer =3D no_free_ptr(xfer_tmp);
> +	st->adis.buffer =3D no_free_ptr(buffer_tmp);
> +
> +	return 0;
> +
> +free_on_error:
> +	kfree(xfer_tmp);
> +	kfree(buffer_tmp);
>=20

The above should not be needed...

> +	return ret;
> +}
> +
> +static const struct spi_device_id adis16550_id[] =3D {
> +	{ "adis16550",=C2=A0 (kernel_ulong_t)&adis16550_chip_info},
> +	{ "adis16550w", (kernel_ulong_t)&adis16550w_chip_info},
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16550_id);
> +
> +static const struct of_device_id adis16550_of_match[] =3D {
> +	{ .compatible =3D "adi,adis16550",
> +		.data =3D &adis16550_chip_info },
> +	{ .compatible =3D "adi,adis16550w",
> +		.data =3D &adis16550w_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adis16550_of_match);
> +
> +static struct spi_driver adis16550_driver =3D {
> +	.driver =3D {
> +		.name =3D "adis16550",
> +		.of_match_table =3D adis16550_of_match,
> +	},
> +	.probe =3D adis16550_probe,
> +	.id_table =3D adis16550_id,
> +};
> +module_spi_driver(adis16550_driver);
> +
> +MODULE_AUTHOR("Nuno Sa <nuno.sa@analog.com>");
> +MODULE_AUTHOR("Ramona Gradinariu <ramona.gradinariu@analog.com>");
> +MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADIS16550 IMU driver");
> +MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS(IIO_ADISLIB);


