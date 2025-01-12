Return-Path: <linux-iio+bounces-14234-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EAEA0AAC3
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B573A66AE
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jan 2025 16:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDA11BD9CF;
	Sun, 12 Jan 2025 16:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck33/bbA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A458C1B4238;
	Sun, 12 Jan 2025 16:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736698312; cv=none; b=MvmW523kXgyqTToayOdTbK9VT+uRH4XoOMMYSyh42ydeFNrh5xWBoz4tye+NA94x5m77ADmPEFFZcVC63QvoVMsPT+Ln78PuK0RE9aYO4IGCpT4gq+tPc7jncYk1j7i/7YyIaqG/Ee5dDkk1+Tk6+oe4C0KEKGPZn4EhPfSrPBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736698312; c=relaxed/simple;
	bh=UV0XOBYmSYckFNbh90Adzxlhly2bMIK8oGbSwardqX8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oKLkxLclf1Jl3cnfTBE/+7dgntkW0bVxj0gDn2F+6NJpLvuub2AxoXqr9FRcQgYpca//wG8aS9n0PlR38/VLeXlAqnMlAJUzJb/yQzf7WIvNUAbGsldEkr/ZbSnhPin76L/mJxHWsP6OVhX4z3tWYQZYY1+mPMBPVbyl3+l4bVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck33/bbA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9555CC4CEDF;
	Sun, 12 Jan 2025 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736698312;
	bh=UV0XOBYmSYckFNbh90Adzxlhly2bMIK8oGbSwardqX8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ck33/bbAN3nF2rQ5GJaJr/kXkyvT6/yXTBqx9grbb967o65lSrAgnwiArGg1lT71s
	 2tCFnhGWYiMDMihrUkvXvYS8Cc7vtqQDDJJFl5J5xmbdZBamgVsnyinX0fSeawdWmG
	 gVoNb40FCNtN/N9uqGM/z1FzEqZjEirz/hW0+FTWHcPk7s7ZhLU47PgDChJotxbXkQ
	 EpErd5UsgdN47GcLjpZUMIbdUUDgJy0aW6ZRwRifXCKf7gjDvkg/h/br9Wig8LRPVP
	 MhsY37DN7YV7tv2BbnQU0Wn/zEGnlpqL0ffLyxFmwqIWdCz3pYT3yItOES5qk863Eg
	 gUy7mseBYPy1A==
Date: Sun, 12 Jan 2025 16:11:41 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Nuno Sa <nuno.sa@analog.com>, Ramona Gradinariu
 <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Alex Lanzano
 <lanzano.alex@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v4 5/6] iio: imu: adis16550: add adis16550 support
Message-ID: <20250112161141.563064c2@jic23-huawei>
In-Reply-To: <20250110074254.38966-6-robert.budai@analog.com>
References: <20250110074254.38966-1-robert.budai@analog.com>
	<20250110074254.38966-6-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 10 Jan 2025 09:42:53 +0200
Robert Budai <robert.budai@analog.com> wrote:

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
> 4:
> - reorganized channels to match the order in the datasheet
> - removed extra checks and goto statements
> - for buffer memory allocation used only kfree, since adis library alread=
y takes care of freeing the buffer

That last bit makes for a mess wrt to who owns the buffer and lifetime
management. Suggestions inline.

Jonathan

> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..49c3ff9ef1e2
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c
> @@ -0,0 +1,1202 @@
...


> +static int adis16550_set_accl_filter_freq(struct adis16550 *st, int freq=
_hz)
> +{
> +	bool en =3D false;
> +
> +	if (freq_hz)
> +		en =3D true;
> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_ACCL_FIR_EN_MASK,
> +				  (u32)FIELD_PREP(ADIS16550_ACCL_FIR_EN_MASK, en));

Why is the cast needed? Only bit 3 is set.

> +}

> +static irqreturn_t adis16550_trigger_handler(int irq, void *p)
> +{
> +	u32 crc;
> +	u16 dummy;
> +	bool valid;
> +	int ret, i =3D 0;
> +	u8 data_offset =3D 3;
> +	struct iio_poll_func *pf =3D p;
> +	__be32 data[ADIS16550_MAX_SCAN_DATA];
> +	struct iio_dev *indio_dev =3D pf->indio_dev;
> +	struct adis16550 *st =3D iio_priv(indio_dev);
> +	struct adis *adis =3D iio_device_get_drvdata(indio_dev);
> +	__be32 *buffer =3D adis->buffer;

Related to below lifetime comment. Move this buffer into iio_priv()
given you aren't using the lifetime management in the adis library code.

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
> +				       ADIS16550_BURST_N_ELEM - 2, crc);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
> +		goto done;
> +	}
> +
> +	memcpy(&data[i], &buffer[data_offset], (ADIS16550_SCAN_ACCEL_Z -

i is always 0?  If so just use data here and get rid of i.
If data_offset is always 3, encode that directly here as well instead
of confusing local variable.

> +						ADIS16550_SCAN_GYRO_X + 2) *
> +						sizeof(__be32));
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}

> +static int adis16550_update_scan_mode(struct iio_dev *indio_dev,
> +				      const unsigned long *scan_mask)
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
> +	memset(adis->xfer, 0, 2 * sizeof(*adis->xfer));
> +	memset(adis->buffer, 0, burst_length + sizeof(u32));

This overlaps with the comment on lifetime management below.
I would move the xfer and buffer pointers into iio_priv leaving
adis->xfer and adis->buffer =3D=3D NULL so that the core frees nothing.

> +
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

> +static int adis16550_config_sync(struct adis16550 *st)
> +{
> +	struct device *dev =3D &st->adis.spi->dev;
> +	const struct adis16550_sync *sync;
> +	struct clk *clk;
> +	u32 sync_mode;
> +	u16 mode;
> +	int ret;
> +
> +	ret =3D device_property_read_u32(dev, "adi,sync-mode", &sync_mode);
> +	if (ret) {
> +		st->clk_freq_hz =3D st->info->int_clk * 1000;
> +		return 0;
> +	}
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
> +	if (st->clk_freq_hz > sync->max_rate || st->clk_freq_hz < sync->min_rat=
e)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "Clk rate: %lu not in a valid range:[%u %u]\n",
> +				     st->clk_freq_hz, sync->min_rate, sync->max_rate);
> +
> +	if (sync->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {

Similar to DT binding discussion.  You can see from the clock frequency if =
you
need to need to use sync_mode_scaled or not.  I don't see a need for a bind=
ing
to control that.

> +		u16 sync_scale;
> +		u32 scaled_freq =3D 0;
> +		/*
> +		 * In pps scaled sync we must scale the input clock to a range
> +		 * of [3000 45000].
> +		 */
> +		ret =3D device_property_read_u32(dev, "adi,scaled-output-hz",
> +					       &scaled_freq);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "adi,scaled-output-hz property not found");
> +
> +		if (scaled_freq < 3000 || scaled_freq > 4500)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "Invalid value:%u for adi,scaled-output-hz",
> +					     scaled_freq);
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
> +	       FIELD_PREP(ADIS16550_SYNC_EN_MASK, true);
> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_SYNC_MASK, mode);
> +}

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
> +	/*
> +	 * Allocate the xfer and buffer for the burst read operation. The buffer
> +	 * is used to store the burst data and the xfer is used to send the bur=
st
> +	 * command and receive the data. On device remove the adis libraary is =
going

library.

> +	 * to free the xfer and buffer.

That is a horrible lifetime control.  They should either be allocated in th=
e library
and freed in the library or allocated and freed in the driver.  Mixing that=
 doesn't
make sense.

Can you store them somewhere else so that the ownership is never in the adis
library?

> +	 */
> +	st->adis.xfer =3D kzalloc(2 * sizeof(*st->adis.xfer),
> +	if (!st->adis.xfer)
> +		return -ENOMEM;
> +
> +	st->adis.buffer =3D kzalloc(ADIS16550_BURST_DATA_LEN + sizeof(u32),
> +				  GFP_KERNEL);
> +	if (!st->adis.buffer)
> +		return -ENOMEM;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret) {
> +		dev_err_probe(dev, ret,
> +			      "Failed to get vdd regulator\n");
> +		return ret;

		return dev_err_probe()

and drop the brackets.

> +	}
> +
> +	ret =3D adis_init(&st->adis, indio_dev, spi, &adis16550_data);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D __adis_initial_startup(&st->adis);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D adis16550_config_sync(st);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_adis_setup_buffer_and_trigger(&st->adis, indio_dev,
> +						 adis16550_trigger_handler);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	adis16550_debugfs_init(indio_dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id adis16550_id[] =3D {
> +	{ "adis16550",  (kernel_ulong_t)&adis16550_chip_info},
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

Under 80 chars on one line, so don't wrap these.

> +	{ }
> +};


















































