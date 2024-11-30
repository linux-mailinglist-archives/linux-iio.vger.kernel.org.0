Return-Path: <linux-iio+bounces-12866-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C329DF23E
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:32:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A0E2812C7
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866B21A38E1;
	Sat, 30 Nov 2024 17:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEmDhahy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3253B42AA4;
	Sat, 30 Nov 2024 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732987927; cv=none; b=MA03lTnjwWMvZIfDE/r4jIN+LlCsF2w0PXv+ie+yenVmMDBDsJSFPqm334ugwatZea+P/qAN2L68RWIsgDQTp9waG5XVTGi3G3e99CBbZ/jq98vyGXkDUGxiSfzdL9gTUO/oSm/QU4n5ID14oWg8nh7df8HZknkhZVScUZ5Hf9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732987927; c=relaxed/simple;
	bh=uJGUgHZQDp01CjnKwP3Dy7tTuDx3byOlCXzgg4ukKdM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iFUAChjshjGtLcmqjvci3hUBuFd5p8EirmiNvPA4rR7RZegJHz3Yl/TqQbtcmB66H99JoHV4rDO440bx27AG9Hs1dO1dkazgPNlE2bXTsVUBfTj/R8eL4XdhSzRj2E6oOEDPTTUn0A7t2MvCn1MCrLazlKxKoVqnh5uW6zGTkfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEmDhahy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694CDC4CECC;
	Sat, 30 Nov 2024 17:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732987926;
	bh=uJGUgHZQDp01CjnKwP3Dy7tTuDx3byOlCXzgg4ukKdM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aEmDhahycJrBa5iFn4M+6rWoVImWX2j5TneNvj3AbYGAwXVvN5/H7ABklaIqFpLyx
	 EcETQCFkZp1ITYjNOMlSs+ttSWcUC1yAg7ubOpkCdpXbmpZb4Qs+eGUSnpLmWbGZmk
	 BIefKpQA/t3v13P7/4nhrAPLufmqBtE0ADDoRpSbYnwhfuDCRxnceDZ3FuI3Iqk650
	 kU2+FrNzCBbAM7FS5LezMGC1uB6XBB1GS3H1zbXP86cWsYLGEYUF5LxpndJvND7cpi
	 lv645RKjkrYIFUGoVR07aSmGUULtt1eym4ASHmygnGGXr+GZ3IFgAZ+A54ZWroiK8S
	 OPP3czqRVLEIw==
Date: Sat, 30 Nov 2024 17:31:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Ramona
 Gradinariu <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 6/7] iio: imu: adis16550: add adis16550 support
Message-ID: <20241130173156.4e260944@jic23-huawei>
In-Reply-To: <20241125133520.24328-7-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
	<20241125133520.24328-7-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Nov 2024 15:35:13 +0200
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

A few additional comments below.

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/adis16550.c b/drivers/iio/imu/adis16550.c
> new file mode 100644
> index 000000000000..db0e9dcadca2
> --- /dev/null
> +++ b/drivers/iio/imu/adis16550.c
> @@ -0,0 +1,1203 @@

> +
> +static int adis16550_set_freq_hz(struct adis16550 *st, u32 freq_hz)
> +{
> +	u16 dec;
> +	int ret;
> +	u32 sample_rate =3D st->clk_freq_hz;
> +	/*
> +	 * The optimal sample rate for the supported IMUs is between
> +	 * int_clk - 1000 and int_clk + 500.
> +	 */
> +	u32 max_sample_rate =3D st->info->int_clk * 1000 + 500000;
> +	u32 min_sample_rate =3D st->info->int_clk * 1000 - 1000000;
> +
> +	if (!freq_hz)
> +		return -EINVAL;
> +
> +	adis_dev_auto_lock(&st->adis);
> +
> +	if (st->sync_mode =3D=3D ADIS16550_SYNC_MODE_SCALED) {
> +		unsigned long scaled_rate =3D lcm(st->clk_freq_hz, freq_hz);
> +		int sync_scale;
> +
> +		if (scaled_rate > max_sample_rate)
> +			scaled_rate =3D max_sample_rate / st->clk_freq_hz * st->clk_freq_hz;
> +		else
> +			scaled_rate =3D max_sample_rate / scaled_rate * scaled_rate;
> +
> +		if (scaled_rate < min_sample_rate)
> +			scaled_rate =3D roundup(min_sample_rate, st->clk_freq_hz);
> +
> +		sync_scale =3D scaled_rate / st->clk_freq_hz;
> +		ret =3D __adis_write_reg_16(&st->adis, ADIS16550_REG_SYNC_SCALE,
> +					  sync_scale);
> +		if (ret)
> +			return ret;
> +
> +		sample_rate =3D scaled_rate;
> +	}
> +
> +	dec =3D DIV_ROUND_CLOSEST(sample_rate, freq_hz);
> +
> +	if (dec)
> +		dec--;
> +
> +	dec =3D min(dec, st->info->max_dec);
> +
> +	ret =3D __adis_write_reg_16(&st->adis, ADIS16550_REG_DEC_RATE, dec);
> +
> +	return ret;

return __adis_write ..

> +}

> +
> +static int adis16550_set_gyro_filter_freq(struct adis16550 *st, int freq=
_hz)
> +{
> +	bool en =3D false;
> +
> +	if (freq_hz)
> +		en =3D true;
> +
> +	return __adis_update_bits(&st->adis, ADIS16550_REG_CONFIG,
> +				  ADIS16550_GYRO_FIR_EN_MASK,
> +				  (u32)FIELD_PREP(ADIS16550_GYRO_FIR_EN_MASK, en));
> +}
> +
> +enum adis16550_variants {
> +	ADIS16550,
> +	ADIS16550W
These enums are usually a sign that something is not going to extend well.
Code should never need to match on such an enum value, but instead using=20
structures with all the information this conveys as flags and callbacks etc.

> +};

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
> +				       ADIS16550_BURST_N_ELEM - 2, crc);
> +	if (!valid) {
> +		dev_err(&adis->spi->dev, "Burst Invalid crc!\n");
> +		goto done;
> +	}
> +
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_GYRO_X)) {
> +		memcpy(&data[i], &buffer[data_offset], (ADIS16550_SCAN_ACCEL_Z -
> +						ADIS16550_SCAN_GYRO_X + 1) *
> +						sizeof(__be32));
> +		i +=3D ADIS16550_SCAN_ACCEL_Z - ADIS16550_SCAN_GYRO_X + 1;
> +	}
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_TEMP))
> +		data[i++] =3D buffer[data_offset - 1];
> +	if (*indio_dev->active_scan_mask & BIT(ADIS16550_SCAN_DELTANG_X))
> +		memcpy(&data[i], &buffer[data_offset], (ADIS16550_SCAN_DELTVEL_Z -
I would break the line after offset],
> +							ADIS16550_SCAN_DELTANG_X + 1) *
> +							sizeof(__be32));
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, data, pf->timestamp);
> +done:
> +	iio_trigger_notify_done(indio_dev->trig);
> +	return IRQ_HANDLED;
> +}
> +
> +static const unsigned long adis16550_channel_masks[] =3D {
> +	ADIS16550_BURST_DATA_GYRO_ACCEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	ADIS16550_BURST_DATA_DELTA_ANG_VEL_MASK | BIT(ADIS16550_SCAN_TEMP),
> +	0,
This 0 is effectively a terminating entry. So no need for trailing 0 as we =
should
never add anything after this.

> +};

> +
> +static inline void void_cleaner(void *v) {kfree(v); }
> +
> +DEFINE_FREE(void, void *, if (_T) void_cleaner(_T))
If this made sense why not

__free(kfree)?  Only difference is that it will not call
the free if ERR_PTR() which is more general than what you have
here and does your usecase no harm.

Having __free(void) is not useful.


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
> +	st->info =3D &adis16550_chip_info_ip;
> +	if (!st->info)
> +		return -EINVAL;
> +
> +	indio_dev->name =3D spi_get_device_id(spi)->name;
> +	indio_dev->channels =3D st->info->channels;
> +	indio_dev->num_channels =3D st->info->num_channels;
> +	indio_dev->available_scan_masks =3D adis16550_channel_masks;
> +	indio_dev->info =3D &adis16550_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +
> +	st->adis.ops =3D &adis16550_ops;
> +
> +	st->adis.xfer =3D kcalloc(2, sizeof(*st->adis.xfer), GFP_KERNEL);
> +	if (!st->adis.xfer)
> +		return -ENOMEM;
> +
> +	void *buffer_tmp __free(void) =3D kzalloc(ADIS16550_BURST_DATA_LEN + si=
zeof(u32),
> +				  GFP_KERNEL);

For such a short lived thing I'm not immediately seeing why __free is usefu=
l.


> +	if (!buffer_tmp) {
> +		kfree(st->adis.xfer);
> +		return -ENOMEM;
> +	}
> +	st->adis.buffer =3D no_free_ptr(buffer_tmp);
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to get vdd regulator\n");
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
> +	{ "adis16550", ADIS16550 },
> +	{ "adis16550w", ADIS16550W },
I've no idea what the difference between these is.  Assuming there is one t=
hat matters
to software then use a per type structure, not an enum.  That way as you add
lots of additional device support over time it is easy to specify new combi=
nations of
features as data, not code

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adis16550_id);
> +
> +static const struct of_device_id adis16550_of_match[] =3D {
> +	{ .compatible =3D "adi,adis16550" },
> +	{ .compatible =3D "adi,adis16550w" },

Should have data as the pointers to chip_info type structs as suggested abo=
ve.

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


