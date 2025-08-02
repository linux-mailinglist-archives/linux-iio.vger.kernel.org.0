Return-Path: <linux-iio+bounces-22190-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212CEB18E3B
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 13:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1BD65601BE
	for <lists+linux-iio@lfdr.de>; Sat,  2 Aug 2025 11:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82430221F17;
	Sat,  2 Aug 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1Twnu4k"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33890256D;
	Sat,  2 Aug 2025 11:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754135024; cv=none; b=nklYSLGRANl6oKTCBF6YoxmSmPPZIzyY2Sml1d08lV2cSSWmsVs9iWwctCO8TpnBSCQq6Fhay76EA6BVwPdH6AYuZYxsM0UcBwIDPRKX7R2LcaolI/0SiXQ12wupUUu93wa50xkG8YuGh0zzm8pZLG4l3pmOMUOqxRBi8GXUPMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754135024; c=relaxed/simple;
	bh=KN5mq0xSB8X9KKs/tm6snivXjWaEfNYoAHad5h2MKwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4sgvQfBG8R96zqMqA5FVXwVqkCNpeYv9PaT6HXo8hWXIhyKaqdIupUkdUiKBd68Tgd42QxWs4HRjbP/Kz0l+7Y8N1NEYlUsrr+z3g+pi5kf3gHWeUDAtKq+cwR7u+x9JkGKJ0ScboJH/9kUlWxmgyqBetdSoZ6Xxw6oIX+kWmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1Twnu4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42722C4CEEF;
	Sat,  2 Aug 2025 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754135023;
	bh=KN5mq0xSB8X9KKs/tm6snivXjWaEfNYoAHad5h2MKwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F1Twnu4k1FevZ17/ExKfO3nlPTXo8QJpCYDHqfIEU/W7CLcsqTIc7IQBDNCSiNj0k
	 GI/5cYRAOh+jmLtO619fh3pf9wViH0aTUXbyTedap8gg+b1r/SLYCIntlmBxIhCen5
	 1fyMLOHZqLM0f1bwMAnjiFkOakqYmRtPw5tdnzsgIvLneoY/kUjWA4ymudgZMv06Vz
	 RRUTPZuc3t+/sXsM644s9ZELYGM2VD3Lw2/zr6+heLTxxCRLPa/yWRIFylAzrsawET
	 3k96Nd0EfODNMMhIsrBaHJolFq3kgw6teeRHuVJgepvnvghlx5remmTaJqc1rqTXGP
	 iPs6BisQdp0YQ==
Date: Sat, 2 Aug 2025 12:43:33 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dixit Parmar <dixitparmar19@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
Message-ID: <20250802124333.67f64863@jic23-huawei>
In-Reply-To: <20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
References: <20250802-tlv493d-sensor-v6_16-rc5-v2-0-e867df86ad93@gmail.com>
	<20250802-tlv493d-sensor-v6_16-rc5-v2-1-e867df86ad93@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 02 Aug 2025 12:14:27 +0530
Dixit Parmar <dixitparmar19@gmail.com> wrote:

> The Infineon TLV493D is a Low-Power 3D Magnetic Sensor. The Sensor
> applications includes joysticks, control elements (white goods,
> multifunction knops), or electric meters (anti tampering) and any
> other application that requires accurate angular measurements at
> low power consumptions.
>=20
> The Sensor is configured over I2C, and as part of Sensor measurement
> data it provides 3-Axis magnetic fields and temperature core measurement.
>=20
> The driver supports raw value read and buffered input via external trigger
> to allow streaming values with the same sensing timestamp.
>=20
> While sensor has interrupt pin multiplexed with I2C SCL pin. But for bus
> configurations interrupt(INT) is not recommended, unless timing constrain=
ts
> between I2C data transfers and interrupt pulses are monitored and aligned.
>=20
> The Sensor's I2C register map and mode information is described in product
> User Manual[Link].
>=20
> Datasheet: https://www.infineon.com/assets/row/public/documents/24/49/inf=
ineon-tlv493d-a1b6-datasheet-en.pdf
> Link: https://www.mouser.com/pdfDocs/Infineon-TLV493D-A1B6_3DMagnetic-Use=
rManual-v01_03-EN.pdf
> Signed-off-by: Dixit Parmar <dixitparmar19@gmail.com>

Hi Dixit,

Some additional comments inline.

> diff --git a/drivers/iio/magnetometer/tlv493d.c b/drivers/iio/magnetomete=
r/tlv493d.c
> new file mode 100644
> index 000000000000..da1569ae97bf
> --- /dev/null
> +++ b/drivers/iio/magnetometer/tlv493d.c

> +enum tlv493d_op_mode {
> +	TLV493D_OP_MODE_POWERDOWN =3D 0,
> +	TLV493D_OP_MODE_FAST,
> +	TLV493D_OP_MODE_LOWPOWER,
> +	TLV493D_OP_MODE_ULTRA_LOWPOWER,
> +	TLV493D_OP_MODE_MASTERCONTROLLED,
> +	TLV493D_OP_MODE_MAX
In order to be able to use this as the type for a parameter as suggested
below, you'll need to drop MODE_MAX.  Comments on why you shouldn't
need that anyway below.

> +};
> +
> +struct tlv493d_mode {
> +	u8 m;
You have an enum type.  Much better to use it.

> +	u32 sleep_us;
> +};
> +
> +struct tlv493d_data {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	/* protects from simultaneous sensor access and register readings */
> +	struct mutex lock;
> +	u8 mode;
> +	u8 wr_regs[TLV493D_WR_REG_MAX];
> +};
> +
> +/*
> + * Different mode has different measurement cycle time, this time is
> + * used in deriving the sleep and timemout while reading the data from
> + * sensor in polling.
> + * Power-down mode: No measurement.
> + * Fast mode: Freq:3.3 KHz. Measurement time:305 usec.
> + * Low-power mode: Freq:100 Hz. Measurement time:10 msec.
> + * Ultra low-power mode: Freq:10 Hz. Measurement time:100 msec.
> + * Master controlled mode: Freq:3.3 Khz. Measurement time:305 usec.
> + */
> +static struct tlv493d_mode tlv493d_mode_info[TLV493D_OP_MODE_MAX] =3D {
If you want to size it, do it using the enum values. [] is fine here
	[TLV493D_OP_MODE_POWERDOWN] =3D { }

I'm not sure why this should embed the index.  Can you just drop .m?

> +	{ .m =3D TLV493D_OP_MODE_POWERDOWN, .sleep_us =3D 0 },
> +	{ .m =3D TLV493D_OP_MODE_FAST, .sleep_us =3D 305 },
> +	{ .m =3D TLV493D_OP_MODE_LOWPOWER, .sleep_us =3D 10 * USEC_PER_MSEC	},
> +	{ .m =3D TLV493D_OP_MODE_ULTRA_LOWPOWER, .sleep_us =3D 100 * USEC_PER_M=
SEC },
> +	{ .m =3D TLV493D_OP_MODE_MASTERCONTROLLED, .sleep_us =3D 305 }
> +};
> +
> +/*
> + * The datasheet mentions the sensor supports only direct byte-stream wr=
ite
> + * starting from register address 0x0. So for any modification to be mad=
e to
> + * any write registers, it must be written starting from the register ad=
dress
> + * 0x0. I2C write operation should not contain register address in the I=
2C
> + * frame, it should contains only raw byte stream for the write register=
s.
> + * I2C Frame: |S|SlaveAddr Wr|Ack|Byte[0]|Ack|Byte[1]|Ack|.....|Sp|
> + */
> +static int tlv493d_write_all_regs(struct tlv493d_data *data)
> +{
> +	int ret;
> +
> +	if (!data || !data->client)
If either of these happen, something went very very wrong.
No need for the checks.  Remove all similar ones.

> +		return -EINVAL;
> +
> +	ret =3D i2c_master_send(data->client, data->wr_regs, ARRAY_SIZE(data->w=
r_regs));
> +	if (ret < 0) {
> +		dev_err(data->dev, "i2c write registers failed, error: %d\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int tlv493d_set_operating_mode(struct tlv493d_data *data, u8 mode)
As below. Use the enum type.
> +{
> +	if (!data)
> +		return -EINVAL;

As above. Data is never going to be NULL, so don't check it.

> +
> +	u8 mode1_cfg, mode2_cfg;
> +
> +	switch (mode) {
> +	case TLV493D_OP_MODE_POWERDOWN:
> +		mode1_cfg =3D FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 0);
> +		mode2_cfg =3D FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> +		break;
> +
> +	case TLV493D_OP_MODE_FAST:
> +		mode1_cfg =3D FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 1);
> +		mode2_cfg =3D FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> +		break;
> +
> +	case TLV493D_OP_MODE_LOWPOWER:
> +		mode1_cfg =3D FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> +		mode2_cfg =3D FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 1);
> +		break;
> +
> +	case TLV493D_OP_MODE_ULTRA_LOWPOWER:
> +		mode1_cfg =3D FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 2);
> +		mode2_cfg =3D FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> +		break;
> +
> +	case TLV493D_OP_MODE_MASTERCONTROLLED:
> +		mode1_cfg =3D FIELD_PREP(TLV493D_MODE1_MOD_LOWFAST, 3);
> +		mode2_cfg =3D FIELD_PREP(TLV493D_MODE2_LP_PERIOD, 0);
> +		break;
> +
> +	default:
> +		dev_err(data->dev, "invalid mode configuration\n");
> +		return -EINVAL;
And with the enum type you shouldn't need a default.

> +	}
> +
> +	data->wr_regs[TLV493D_WR_REG_MODE1] |=3D mode1_cfg;
> +	data->wr_regs[TLV493D_WR_REG_MODE2] |=3D mode2_cfg;
> +
> +	return tlv493d_write_all_regs(data);
> +}
> +
> +static s16 tlv493d_get_channel_data(u8 *b, u8 ch)
Use the enum.=20
> +{
> +	if (!b)
> +		return -EINVAL;
Unnecessary check
> +
> +	u16 val =3D 0;
Variable declarations at the top of scope unless strong reason to do otherw=
ise
(only normally done for auto cleanup)
> +
> +	switch (ch) {
> +	case TLV493D_AXIS_X:
> +		val =3D FIELD_GET(TLV493D_BX_MAG_X_AXIS_MSB, b[TLV493D_RD_REG_BX]) << =
4 |
> +			FIELD_GET(TLV493D_BX2_MAG_X_AXIS_LSB, b[TLV493D_RD_REG_BX2]) >> 4;
> +		break;
> +	case TLV493D_AXIS_Y:
> +		val =3D FIELD_GET(TLV493D_BY_MAG_Y_AXIS_MSB, b[TLV493D_RD_REG_BY]) << =
4 |
> +			FIELD_GET(TLV493D_BX2_MAG_Y_AXIS_LSB, b[TLV493D_RD_REG_BX2]);
> +		break;
> +	case TLV493D_AXIS_Z:
> +		val =3D FIELD_GET(TLV493D_BZ_MAG_Z_AXIS_MSB, b[TLV493D_RD_REG_BZ]) << =
4 |
> +			FIELD_GET(TLV493D_BZ2_MAG_Z_AXIS_LSB, b[TLV493D_RD_REG_BZ2]);
> +		break;
> +	case TLV493D_TEMPERATURE:
> +		val =3D FIELD_GET(TLV493D_TEMP_TEMP_MSB, b[TLV493D_RD_REG_TEMP]) << 8 |
> +			FIELD_GET(TLV493D_TEMP2_TEMP_LSB, b[TLV493D_RD_REG_TEMP2]);
> +		break;
> +	default:
> +		return -EINVAL;
And with the enum, there will be no need to have a default.
Not to mention passing -EINVAL through an s16 is unusual and I doubt wise.

> +	}
> +
> +	return sign_extend32(val, 11);
> +}
> +
> +static int tlv493d_get_measurements(struct tlv493d_data *data, s16 *x, s=
16 *y,
> +				s16 *z, s16 *t)
> +{
> +	u8 buff[7] =3D {};
> +	int err, ret;
> +	struct tlv493d_mode *mode;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret =3D pm_runtime_resume_and_get(data->dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	mode =3D &tlv493d_mode_info[data->mode];
> +
> +	/*
> +	 * Poll until data is valid,
> +	 * For a valid data TLV493D_TEMP_CHANNEL bit of TLV493D_RD_REG_TEMP sho=
uld be set to 0.
> +	 * The sampling time depends on the sensor mode. poll 3x the time of th=
e sampling time.
> +	 */
> +	ret =3D read_poll_timeout(i2c_master_recv, err, err ||
> +			FIELD_GET(TLV493D_TEMP_CHANNEL, buff[TLV493D_RD_REG_TEMP]) =3D=3D 0,
> +			mode->sleep_us, (3 * mode->sleep_us), false, data->client, buff,
> +			ARRAY_SIZE(buff));
> +	if (ret) {
> +		dev_err(data->dev, "i2c read poll timeout, error:%d\n", ret);
> +		goto out;
> +	}
> +	if (err < 0) {
> +		dev_err(data->dev, "i2c read data failed, error:%d\n", err);
> +		ret =3D err;
> +		goto out;
> +	}
> +
> +	*x =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_X);
> +	*y =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Y);
> +	*z =3D tlv493d_get_channel_data(buff, TLV493D_AXIS_Z);
> +	*t =3D tlv493d_get_channel_data(buff, TLV493D_TEMPERATURE);
> +
> +out:
> +	pm_runtime_mark_last_busy(data->dev);
I've just rebased (mid merge window so i'll do it again on rc1) and now
have the version of pm_runtime_put_autosuspend() that internally calls
pm_runtime_mark_last_busy().

So please drop the line above if you need to do a v3.
=20
> +	pm_runtime_put_autosuspend(data->dev);
> +	return ret;
> +}

> +static int tlv493d_read_raw(struct iio_dev *indio_dev,
> +			const struct iio_chan_spec *chan, int *val,
> +			int *val2, long mask)
> +{
> +	struct tlv493d_data *data =3D iio_priv(indio_dev);
> +	s16 x, y, z, t;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret =3D tlv493d_get_measurements(data, &x, &y, &z, &t);
> +		if (ret)
> +			return ret;
> +
> +		/* Return raw values for requested channel */
> +		switch (chan->address) {
> +		case TLV493D_AXIS_X:
> +			*val =3D x;
> +			return IIO_VAL_INT;
> +		case TLV493D_AXIS_Y:
> +			*val =3D y;
> +			return IIO_VAL_INT;
> +		case TLV493D_AXIS_Z:
> +			*val =3D z;
> +			return IIO_VAL_INT;
> +		case TLV493D_TEMPERATURE:
> +			*val =3D t;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			/*
> +			 * Magnetic field scale: 0.0098 mTesla (i.e. 9.8 =C2=B5T)
> +			 * Magnetic filed in Guass: mT * 10 =3D 0.098.
> +			 */
> +			*val =3D 98;
> +			*val2 =3D 1000;
> +			return IIO_VAL_FRACTIONAL;
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature scale: 1.1 =C2=B0C per LSB, expressed as 1100 m=C2=B0C
> +			 * Returned as integer for IIO core to apply:
> +			 * temp =3D (raw + offset) * scale
> +			 */
> +			*val =3D 1100;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_OFFSET:
> +		switch (chan->type) {
> +		case IIO_TEMP:
> +			/*
> +			 * Temperature offset includes sensor-specific raw offset
> +			 * plus compensation for +25=C2=B0C bias in formula.
> +			 * offset =3D -raw_offset + (25000 / 1100)
> +			 * -340 + 22.72 =3D -317.28
> +			 */
> +			*val =3D -31728;
> +			*val2 =3D 100;
> +			return IIO_VAL_FRACTIONAL;
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;

Can you get here? If not drop this.  Compilers are very good at complaining=
 if
code changes later such that we should add this back.

> +}

> +static const struct iio_info tlv493d_info =3D {
> +	.read_raw =3D tlv493d_read_raw,
> +};
> +
> +static const struct iio_buffer_setup_ops tlv493d_setup_ops =3D { NULL };

No need specify that NULL. Due to some odd quirks of compiler specific
handling and C spec evolution (none of which apply to the kernel because
we carefully choose build options) that is actually less likely to do what
you want than =3D { };



> +
> +static const unsigned long tlv493d_scan_masks[] =3D { GENMASK(3, 0), 0 };
> +
> +static int tlv493d_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct tlv493d_data *data;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	data->dev =3D dev;
> +	data->client =3D client;
> +	i2c_set_clientdata(client, indio_dev);
> +
> +	ret =3D devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable regulator\n");
> +
> +	/*
> +	 * Setting Sensor default operating mode as Master Controlled mode as
> +	 * it performs measurement cycle on-request only and stays in Power-Down
> +	 * mode until next cycle is initiated.
> +	 */
> +	data->mode =3D TLV493D_OP_MODE_MASTERCONTROLLED;
> +	ret =3D tlv493d_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to initialize\n");
> +
> +	indio_dev->info =3D &tlv493d_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->name =3D client->name;
> +	indio_dev->channels =3D tlv493d_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(tlv493d_channels);
> +	indio_dev->available_scan_masks =3D tlv493d_scan_masks;
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +			iio_pollfunc_store_time, tlv493d_trigger_handler,
> +			&tlv493d_setup_ops);
Similar to below no alignment. Something like;
	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
					      iio_pollfunc_store_time,
					      tlv493d_trigger_handler,
					      &tlv493d_setup_ops);

If you do have a case where the line ends up very long with this style, then
indent only one tab more than line above. If that applied here it would be.

	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
		iio_pollfunc_store_time, tlv493d_trigger_handler,
		&tlv493d_setup_ops);



> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "iio triggered buffer setup failed\n");
> +
> +	ret =3D pm_runtime_set_active(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D devm_pm_runtime_enable(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_set_autosuspend_delay(dev, 500);
> +	pm_runtime_use_autosuspend(dev);
> +
> +	pm_runtime_mark_last_busy(dev);
> +	pm_runtime_put_autosuspend(dev);
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "iio device register failed\n");
> +
> +	return 0;
> +}
> +
> +static int tlv493d_runtime_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct tlv493d_data *data =3D iio_priv(indio_dev);
> +
> +	return tlv493d_set_operating_mode(data, TLV493D_OP_MODE_POWERDOWN);
> +}
> +
> +static int tlv493d_runtime_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct tlv493d_data *data =3D iio_priv(indio_dev);

Trivial but you could do
	struct tlv493d_data *data =3D iio_priv(dev_get_drvdata(dev));
with no real loss of readability.

> +
> +	return tlv493d_set_operating_mode(data, data->mode);
> +}
> +
> +static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops,
> +			tlv493d_runtime_suspend, tlv493d_runtime_resume, NULL);
Preferred wrapping here is
static DEFINE_RUNTIME_DEV_PM_OPS(tlv493d_pm_ops, tlv493d_runtime_suspend,
				 tlv493d_runtime_resume, NULL);

So go nearer 80 chars on first line and align second line below the paramet=
ers
on the first line.

Jonathan


