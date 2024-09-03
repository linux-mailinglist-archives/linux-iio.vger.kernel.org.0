Return-Path: <linux-iio+bounces-9063-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B0F9694E5
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 09:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AEBF1C22F66
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 07:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1F01D6C78;
	Tue,  3 Sep 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVNhGfIe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8204A1D67A8;
	Tue,  3 Sep 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725347461; cv=none; b=q4rfBHsQ+jEObJaccG198/r6rvVOUQ2KzyJJihvkKCzb5J9EQbGxqkHMPUo7ELxE0BkkUFYZ7xEWtapKNgNtqRzNJwkx3LGvld0g1eX5/kqfqfTe+leMWPF9JuQifn2pNq4eGOCRXx1xhRDl02fzDJE3qkCwB8vqUe6k80XQQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725347461; c=relaxed/simple;
	bh=yp7QPjDqSp8ibLntSHK2Vl+iJPwEo+sNDOYISBqzaJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3c1Lk6hmXmPBlE7wHqHZs+FCqzSMCiy2XcRmtEpcf9166b93quJuX3hRzKCO7qMGksLKcV7LdHdhbqvVDh8lX3PxmGLhC4jDQmn1DjfE37oXOKMCBIyolTsuikKElsJFFe4yy/JThKUkaDen2rgpVrQXD6REMA16xGITErvjx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVNhGfIe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9BD8C4CEC5;
	Tue,  3 Sep 2024 07:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725347461;
	bh=yp7QPjDqSp8ibLntSHK2Vl+iJPwEo+sNDOYISBqzaJ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cVNhGfIeG2Dd7I+YNwCLMkte9sxNLGwap9hB/6Q8hmYGMNyBPOmcTmw/tKAmJpx+Q
	 qh81qimgaSINA+M3jj+luTzjeJOuD4+xuMayjgcCVZF/Wq3kitGKdeaHQe0KB4L1RS
	 Z7tg25hJQPoLHSa1+aPJbqwhGd/8N9oOzMMs0i6+aMPgJxNVvrP5tkegCUOYeY9zoR
	 qsrmmcwb9fxe90GfWn8l51lJn7n3b+FKOYL6W+7v+/nDGRvaYQlMd5tW9kbo7CCoaE
	 Gof2RUmhaAUI0SxQb19TiH2NVH3L3jhjTQyTxMV8o7N/gVwNcg5iDcoLtoPRgMDVg8
	 5he0KCoEQC7fQ==
Date: Tue, 3 Sep 2024 09:10:57 +0200
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jinjie Ruan <ruanjinjie@huawei.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
	linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v1 14/22] iio: imu: st_lsm6dsx: Get platform data via
 dev_get_platdata()
Message-ID: <Zta2gaV_8qintFts@lore-rh-laptop>
References: <20240902222824.1145571-1-andy.shevchenko@gmail.com>
 <20240902222824.1145571-15-andy.shevchenko@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="b3D8ckyOT+sNuJnX"
Content-Disposition: inline
In-Reply-To: <20240902222824.1145571-15-andy.shevchenko@gmail.com>


--b3D8ckyOT+sNuJnX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>=20
> Access to platform data via dev_get_platdata() getter to make code cleane=
r.
>=20
> Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 15 +++++----------
>  1 file changed, 5 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index ed0267929725..3958b5e1a3f6 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2132,14 +2132,11 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
>  			const struct st_lsm6dsx_reg **drdy_reg)
>  {
>  	struct device *dev =3D hw->dev;
> +	const struct st_sensors_platform_data *pdata =3D dev_get_platdata(dev);

nit: I guess you can move pdata pointer in the 'if' block, since it is just
used there.

Regards,
Lorenzo

>  	int err =3D 0, drdy_pin;
> =20
> -	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0) {
> -		struct st_sensors_platform_data *pdata;
> -
> -		pdata =3D (struct st_sensors_platform_data *)dev->platform_data;
> +	if (device_property_read_u32(dev, "st,drdy-int-pin", &drdy_pin) < 0)
>  		drdy_pin =3D pdata ? pdata->drdy_int_pin : 1;
> -	}
> =20
>  	switch (drdy_pin) {
>  	case 1:
> @@ -2162,14 +2159,13 @@ st_lsm6dsx_get_drdy_reg(struct st_lsm6dsx_hw *hw,
>  static int st_lsm6dsx_init_shub(struct st_lsm6dsx_hw *hw)
>  {
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
> -	struct st_sensors_platform_data *pdata;
>  	struct device *dev =3D hw->dev;
> +	const struct st_sensors_platform_data *pdata =3D dev_get_platdata(dev);
>  	unsigned int data;
>  	int err =3D 0;
> =20
>  	hub_settings =3D &hw->settings->shub_settings;
> =20
> -	pdata =3D (struct st_sensors_platform_data *)dev->platform_data;
>  	if (device_property_read_bool(dev, "st,pullups") ||
>  	    (pdata && pdata->pullups)) {
>  		if (hub_settings->pullup_en.sec_page) {
> @@ -2524,9 +2520,9 @@ static irqreturn_t st_lsm6dsx_sw_trigger_handler_th=
read(int irq,
> =20
>  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
>  {
> -	struct st_sensors_platform_data *pdata;
>  	const struct st_lsm6dsx_reg *reg;
>  	struct device *dev =3D hw->dev;
> +	const struct st_sensors_platform_data *pdata =3D dev_get_platdata(dev);
>  	unsigned long irq_type;
>  	bool irq_active_low;
>  	int err;
> @@ -2554,7 +2550,6 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_h=
w *hw)
>  	if (err < 0)
>  		return err;
> =20
> -	pdata =3D (struct st_sensors_platform_data *)dev->platform_data;
>  	if (device_property_read_bool(dev, "drive-open-drain") ||
>  	    (pdata && pdata->open_drain)) {
>  		reg =3D &hw->settings->irq_config.od;
> @@ -2639,7 +2634,7 @@ static int st_lsm6dsx_init_regulators(struct device=
 *dev)
>  int st_lsm6dsx_probe(struct device *dev, int irq, int hw_id,
>  		     struct regmap *regmap)
>  {
> -	struct st_sensors_platform_data *pdata =3D dev->platform_data;
> +	const struct st_sensors_platform_data *pdata =3D dev_get_platdata(dev);
>  	const struct st_lsm6dsx_shub_settings *hub_settings;
>  	struct st_lsm6dsx_hw *hw;
>  	const char *name =3D NULL;
> --=20
> 2.46.0
>=20

--b3D8ckyOT+sNuJnX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCZta2fwAKCRA6cBh0uS2t
rLPyAQCvquLs7JDnDvHnO/jvP81iVTbPM3O1eg0j63jsywclQwD7BBi5FVTic6H6
L0gvyU9T0IGcdw1vF12cst9yKOtEwAI=
=bFZX
-----END PGP SIGNATURE-----

--b3D8ckyOT+sNuJnX--

