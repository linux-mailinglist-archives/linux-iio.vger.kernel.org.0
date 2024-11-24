Return-Path: <linux-iio+bounces-12588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AED9D76DE
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 216B6162F77
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 17:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ADA576035;
	Sun, 24 Nov 2024 17:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gyH1CD1A"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CDD2500C7;
	Sun, 24 Nov 2024 17:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732470510; cv=none; b=klVycPbrWqKwZjs2MW9KFjupOzX0NevzRAfEDa/BhpbxtzDgWBH5/KTxF9f1mXFjfi2LknnchxWQ2mxegoCNh3j4fM2QW1ryArx3OT35Kp5/8pCWY+EFB6eveKEBZrEVWjCD2ZUFvmMOaLvNcTBLW7tJrruJE4C/ZQa00ULnOLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732470510; c=relaxed/simple;
	bh=B5V0249Yr81Quwx73/wsIh/Tm9+sW92Tqx7la4ODOW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ujludp57R1VuQtb9Ov9w+Rx+pn6XMflwVpSap1Lcm+mD9JMb43ZE2+4z0AH8FWOHmAMHi0E+dmYZqxOLV+g2K9K5iBilOULtbuz90VrX3GxwAWoq322MczmTOCc9pMBwjVuaicrQnrR22VSp9JIqIEOuStHQDFVBLowyqURrZnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyH1CD1A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6496C4CECC;
	Sun, 24 Nov 2024 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732470509;
	bh=B5V0249Yr81Quwx73/wsIh/Tm9+sW92Tqx7la4ODOW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gyH1CD1A0mCM0zlOE1mZ3CgFtZTeZ/bJnm6Zu8RxgKDP40xFa39woyrXfzdQ2uBjG
	 gNNTFWpUdByreoK5u3KST5SWTXmbwj/R3t04Df2FcPRIO6/4WYHqJn7k0fkudkoH8A
	 wWuUe3wAn645z3sV6Jj8JAPJy9xKmqieKgcGp0oKRevaKH0DHdEeVD0iknOi0z2nn9
	 VbfgukS/67CPnGKSTc7nWsYDML3iDaOmlIryA5/psGbitEslRvnMmDTHoV3VBuWCA+
	 i09ij0tO7aoROKeUy1xvAwI6YfoVTqn6wNUUgg6QDrYC6xQYWcnU9ViulBouYDq87/
	 92lQu9PXEXV/g==
Date: Sun, 24 Nov 2024 17:48:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Dumitru Ceclan <mitrutzceclan@gmail.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Michael Walle
 <michael@walle.cc>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Guillaume Ranquet
 <granquet@baylibre.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7173: make struct ad_sigma_delta_info
 ad7173_sigma_delta_info const
Message-ID: <20241124174820.3d91dba9@jic23-huawei>
In-Reply-To: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-2-d05c02324b73@baylibre.com>
References: <20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-0-d05c02324b73@baylibre.com>
	<20241122-iio-adc-ad7313-fix-non-const-info-struct-v1-2-d05c02324b73@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Nov 2024 11:39:53 -0600
David Lechner <dlechner@baylibre.com> wrote:

> Make struct ad_sigma_delta_info ad7173_sigma_delta_info static const.
> This structure is shared by all instances of the driver, so it can't be
> safely modified by one instance without affecting all other instances.
>=20
> The num_slots field was being modified, so we need to make two copies of
> the structure, one for each possible value of num_slots. Then we add a
> field to the chip-specific info struct to point to the correct copy of
> the struct ad_sigma_delta_info depending on the chip's capabilities.
>=20
> In order to do this, all of the chip-specific info structs have to be
> moved after the struct ad_sigma_delta_info definitions.
>=20
> Fixes: 76a1e6a42802 ("iio: adc: ad7173: add AD7173 driver")
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Too big to be suitable for backporting.

How about just duplicating the structure before modifying?
=09
Then continue as before though it will need to passed into a few places
where the global variable is used directly.

Might be sensible to first do a  minimal fix with duplication then
follow up with a refactor so it is picking between static const
structures as here.


Jonathan

> ---
>  drivers/iio/adc/ad7173.c | 469 +++++++++++++++++++++++++----------------=
------
>  1 file changed, 249 insertions(+), 220 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
> index 5215584438bf..ab2a7a16c477 100644
> --- a/drivers/iio/adc/ad7173.c
> +++ b/drivers/iio/adc/ad7173.c
> @@ -166,6 +166,7 @@ struct ad7173_device_info {
>  	unsigned int clock;
>  	unsigned int id;
>  	char *name;
> +	const struct ad_sigma_delta_info *sd_info;
>  	bool has_current_inputs;
>  	bool has_vincom_input;
>  	bool has_temp;
> @@ -257,223 +258,6 @@ static unsigned int ad4111_current_channel_config[]=
 =3D {
>  	0x18B, /* 12:IIN3+   11:IIN3=E2=88=92 */
>  };
> =20
> -static const struct ad7173_device_info ad4111_device_info =3D {
> -	.name =3D "ad4111",
> -	.id =3D AD4111_ID,
> -	.num_voltage_in_div =3D 8,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 8,
> -	.num_gpios =3D 2,
> -	.higher_gpio_bits =3D true,
> -	.has_temp =3D true,
> -	.has_vincom_input =3D true,
> -	.has_input_buf =3D true,
> -	.has_current_inputs =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad4112_device_info =3D {
> -	.name =3D "ad4112",
> -	.id =3D AD4112_ID,
> -	.num_voltage_in_div =3D 8,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 8,
> -	.num_gpios =3D 2,
> -	.higher_gpio_bits =3D true,
> -	.has_vincom_input =3D true,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_current_inputs =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad4113_device_info =3D {
> -	.name =3D "ad4113",
> -	.id =3D AD4113_ID,
> -	.num_voltage_in_div =3D 8,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 8,
> -	.num_gpios =3D 2,
> -	.data_reg_only_16bit =3D true,
> -	.higher_gpio_bits =3D true,
> -	.has_vincom_input =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad4114_device_info =3D {
> -	.name =3D "ad4114",
> -	.id =3D AD4114_ID,
> -	.num_voltage_in_div =3D 16,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 16,
> -	.num_gpios =3D 4,
> -	.has_vincom_input =3D true,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad4115_device_info =3D {
> -	.name =3D "ad4115",
> -	.id =3D AD4115_ID,
> -	.num_voltage_in_div =3D 16,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 16,
> -	.num_gpios =3D 4,
> -	.has_vincom_input =3D true,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 8 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad4115_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad4115_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad4116_device_info =3D {
> -	.name =3D "ad4116",
> -	.id =3D AD4116_ID,
> -	.num_voltage_in_div =3D 11,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_voltage_in =3D 16,
> -	.num_gpios =3D 4,
> -	.has_vincom_input =3D true,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.clock =3D 4 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad4116_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad4116_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7172_2_device_info =3D {
> -	.name =3D "ad7172-2",
> -	.id =3D AD7172_2_ID,
> -	.num_voltage_in =3D 5,
> -	.num_channels =3D 4,
> -	.num_configs =3D 4,
> -	.num_gpios =3D 2,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.has_pow_supply_monitoring =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7172_4_device_info =3D {
> -	.name =3D "ad7172-4",
> -	.id =3D AD7172_4_ID,
> -	.num_voltage_in =3D 9,
> -	.num_channels =3D 8,
> -	.num_configs =3D 8,
> -	.num_gpios =3D 4,
> -	.has_input_buf =3D true,
> -	.has_ref2 =3D true,
> -	.has_pow_supply_monitoring =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7173_8_device_info =3D {
> -	.name =3D "ad7173-8",
> -	.id =3D AD7173_ID,
> -	.num_voltage_in =3D 17,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_gpios =3D 4,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.has_ref2 =3D true,
> -	.clock =3D 2 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7175_2_device_info =3D {
> -	.name =3D "ad7175-2",
> -	.id =3D AD7175_2_ID,
> -	.num_voltage_in =3D 5,
> -	.num_channels =3D 4,
> -	.num_configs =3D 4,
> -	.num_gpios =3D 2,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.has_pow_supply_monitoring =3D true,
> -	.clock =3D 16 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7175_8_device_info =3D {
> -	.name =3D "ad7175-8",
> -	.id =3D AD7175_8_ID,
> -	.num_voltage_in =3D 17,
> -	.num_channels =3D 16,
> -	.num_configs =3D 8,
> -	.num_gpios =3D 4,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.has_ref2 =3D true,
> -	.has_pow_supply_monitoring =3D true,
> -	.clock =3D 16 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7176_2_device_info =3D {
> -	.name =3D "ad7176-2",
> -	.id =3D AD7176_ID,
> -	.num_voltage_in =3D 5,
> -	.num_channels =3D 4,
> -	.num_configs =3D 4,
> -	.num_gpios =3D 2,
> -	.has_int_ref =3D true,
> -	.clock =3D 16 * HZ_PER_MHZ,
> -	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> -};
> -
> -static const struct ad7173_device_info ad7177_2_device_info =3D {
> -	.name =3D "ad7177-2",
> -	.id =3D AD7177_ID,
> -	.num_voltage_in =3D 5,
> -	.num_channels =3D 4,
> -	.num_configs =3D 4,
> -	.num_gpios =3D 2,
> -	.has_temp =3D true,
> -	.has_input_buf =3D true,
> -	.has_int_ref =3D true,
> -	.has_pow_supply_monitoring =3D true,
> -	.clock =3D 16 * HZ_PER_MHZ,
> -	.odr_start_value =3D AD7177_ODR_START_VALUE,
> -	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> -	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> -};
> -
>  static const char *const ad7173_ref_sel_str[] =3D {
>  	[AD7173_SETUP_REF_SEL_EXT_REF]    =3D "vref",
>  	[AD7173_SETUP_REF_SEL_EXT_REF2]   =3D "vref2",
> @@ -752,7 +536,7 @@ static int ad7173_disable_one(struct ad_sigma_delta *=
sd, unsigned int chan)
>  	return ad_sd_write_reg(sd, AD7173_REG_CH(chan), 2, 0);
>  }
> =20
> -static struct ad_sigma_delta_info ad7173_sigma_delta_info =3D {
> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_4_slots =
=3D {
>  	.set_channel =3D ad7173_set_channel,
>  	.append_status =3D ad7173_append_status,
>  	.disable_all =3D ad7173_disable_all,
> @@ -764,6 +548,252 @@ static struct ad_sigma_delta_info ad7173_sigma_delt=
a_info =3D {
>  	.read_mask =3D BIT(6),
>  	.status_ch_mask =3D GENMASK(3, 0),
>  	.data_reg =3D AD7173_REG_DATA,
> +	.num_slots =3D 4,
> +};
> +
> +static const struct ad_sigma_delta_info ad7173_sigma_delta_info_8_slots =
=3D {
> +	.set_channel =3D ad7173_set_channel,
> +	.append_status =3D ad7173_append_status,
> +	.disable_all =3D ad7173_disable_all,
> +	.disable_one =3D ad7173_disable_one,
> +	.set_mode =3D ad7173_set_mode,
> +	.get_irq_by_name =3D true,
> +	.has_registers =3D true,
> +	.addr_shift =3D 0,
> +	.read_mask =3D BIT(6),
> +	.status_ch_mask =3D GENMASK(3, 0),
> +	.data_reg =3D AD7173_REG_DATA,
> +	.num_slots =3D 8,
> +};
> +
> +static const struct ad7173_device_info ad4111_device_info =3D {
> +	.name =3D "ad4111",
> +	.id =3D AD4111_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 8,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 8,
> +	.num_gpios =3D 2,
> +	.higher_gpio_bits =3D true,
> +	.has_temp =3D true,
> +	.has_vincom_input =3D true,
> +	.has_input_buf =3D true,
> +	.has_current_inputs =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad4112_device_info =3D {
> +	.name =3D "ad4112",
> +	.id =3D AD4112_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 8,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 8,
> +	.num_gpios =3D 2,
> +	.higher_gpio_bits =3D true,
> +	.has_vincom_input =3D true,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_current_inputs =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad4113_device_info =3D {
> +	.name =3D "ad4113",
> +	.id =3D AD4113_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 8,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 8,
> +	.num_gpios =3D 2,
> +	.data_reg_only_16bit =3D true,
> +	.higher_gpio_bits =3D true,
> +	.has_vincom_input =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad4114_device_info =3D {
> +	.name =3D "ad4114",
> +	.id =3D AD4114_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 16,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 16,
> +	.num_gpios =3D 4,
> +	.has_vincom_input =3D true,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad4115_device_info =3D {
> +	.name =3D "ad4115",
> +	.id =3D AD4115_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 16,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 16,
> +	.num_gpios =3D 4,
> +	.has_vincom_input =3D true,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 8 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad4115_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad4115_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad4116_device_info =3D {
> +	.name =3D "ad4116",
> +	.id =3D AD4116_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in_div =3D 11,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_voltage_in =3D 16,
> +	.num_gpios =3D 4,
> +	.has_vincom_input =3D true,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.clock =3D 4 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad4116_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad4116_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7172_2_device_info =3D {
> +	.name =3D "ad7172-2",
> +	.id =3D AD7172_2_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in =3D 5,
> +	.num_channels =3D 4,
> +	.num_configs =3D 4,
> +	.num_gpios =3D 2,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.has_pow_supply_monitoring =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7172_4_device_info =3D {
> +	.name =3D "ad7172-4",
> +	.id =3D AD7172_4_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in =3D 9,
> +	.num_channels =3D 8,
> +	.num_configs =3D 8,
> +	.num_gpios =3D 4,
> +	.has_input_buf =3D true,
> +	.has_ref2 =3D true,
> +	.has_pow_supply_monitoring =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7173_8_device_info =3D {
> +	.name =3D "ad7173-8",
> +	.id =3D AD7173_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in =3D 17,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_gpios =3D 4,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.has_ref2 =3D true,
> +	.clock =3D 2 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7173_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7173_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7175_2_device_info =3D {
> +	.name =3D "ad7175-2",
> +	.id =3D AD7175_2_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in =3D 5,
> +	.num_channels =3D 4,
> +	.num_configs =3D 4,
> +	.num_gpios =3D 2,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.has_pow_supply_monitoring =3D true,
> +	.clock =3D 16 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7175_8_device_info =3D {
> +	.name =3D "ad7175-8",
> +	.id =3D AD7175_8_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_8_slots,
> +	.num_voltage_in =3D 17,
> +	.num_channels =3D 16,
> +	.num_configs =3D 8,
> +	.num_gpios =3D 4,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.has_ref2 =3D true,
> +	.has_pow_supply_monitoring =3D true,
> +	.clock =3D 16 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7176_2_device_info =3D {
> +	.name =3D "ad7176-2",
> +	.id =3D AD7176_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> +	.num_voltage_in =3D 5,
> +	.num_channels =3D 4,
> +	.num_configs =3D 4,
> +	.num_gpios =3D 2,
> +	.has_int_ref =3D true,
> +	.clock =3D 16 * HZ_PER_MHZ,
> +	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
> +};
> +
> +static const struct ad7173_device_info ad7177_2_device_info =3D {
> +	.name =3D "ad7177-2",
> +	.id =3D AD7177_ID,
> +	.sd_info =3D &ad7173_sigma_delta_info_4_slots,
> +	.num_voltage_in =3D 5,
> +	.num_channels =3D 4,
> +	.num_configs =3D 4,
> +	.num_gpios =3D 2,
> +	.has_temp =3D true,
> +	.has_input_buf =3D true,
> +	.has_int_ref =3D true,
> +	.has_pow_supply_monitoring =3D true,
> +	.clock =3D 16 * HZ_PER_MHZ,
> +	.odr_start_value =3D AD7177_ODR_START_VALUE,
> +	.sinc5_data_rates =3D ad7175_sinc5_data_rates,
> +	.num_sinc5_data_rates =3D ARRAY_SIZE(ad7175_sinc5_data_rates),
>  };
> =20
>  static int ad7173_setup(struct iio_dev *indio_dev)
> @@ -1429,8 +1459,7 @@ static int ad7173_probe(struct spi_device *spi)
>  	spi->mode =3D SPI_MODE_3;
>  	spi_setup(spi);
> =20
> -	ad7173_sigma_delta_info.num_slots =3D st->info->num_configs;
> -	ret =3D ad_sd_init(&st->sd, indio_dev, spi, &ad7173_sigma_delta_info);
> +	ret =3D ad_sd_init(&st->sd, indio_dev, spi, st->info->sd_info);
>  	if (ret)
>  		return ret;
> =20
>=20


