Return-Path: <linux-iio+bounces-994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D3815F28
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 14:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D4BC1C20FA3
	for <lists+linux-iio@lfdr.de>; Sun, 17 Dec 2023 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583B043AAB;
	Sun, 17 Dec 2023 13:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpP/TkpV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C28442ABB;
	Sun, 17 Dec 2023 13:06:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29B92C433C8;
	Sun, 17 Dec 2023 13:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702818391;
	bh=PaD/icLcaY/GikbVtAiVwoSGKEx0fBa3zQ8gqKHvZnw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EpP/TkpVVazLC39hYjGgYkKXH5ImVpGVVDyhA0AsUXdFtD6YsFohGpSlsoiXErC9D
	 VhUqevuJh9S8nujaRrI/aUYQ19ZZvmdgjDM68ZmZ3glkuNrPTnf9EbKs6ZkIx8einX
	 RJW2cqS27phpDDz8cwXzYGflqMlKsK7A9uiTJpcwwyoArxTrgtaRXvTisFkIaL7BbL
	 MDA5qCSLmYvyD5yLl06ZshELSS6DL3fki8a9uNnvyewx62R8FfhVRRW98nuRZf4/Y6
	 7U0c9rtqq7SYS7IxygF/8SbuXqYCMW4iflrvETBIPySrp8uO5DSDrz02lYhAKHCalV
	 ts63pUst1TObw==
Date: Sun, 17 Dec 2023 13:06:13 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>, Andre Werner
 <andre.werner@systec-electronic.com>, devicetree@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Naresh Solanki <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231217130613.47bab03d@jic23-huawei>
In-Reply-To: <dff1e2f9-c2a1-4262-b80b-ce0c144fdaf5@gmail.com>
References: <20231121031043.327614-1-marex@denx.de>
	<20231121031043.327614-2-marex@denx.de>
	<8b865546-0e51-45ff-ab76-8189afaa9ad5@gmail.com>
	<cd21c72f-d9ff-471d-a08d-9b67bf180950@denx.de>
	<4a39aff2-bb1a-447c-8c33-8bfad06777e3@gmail.com>
	<dff1e2f9-c2a1-4262-b80b-ce0c144fdaf5@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Dec 2023 14:06:32 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 11/23/23 09:24, Matti Vaittinen wrote:
> > On 11/23/23 02:26, Marek Vasut wrote: =20
> >> On 11/22/23 13:17, Matti Vaittinen wrote: =20
> >>> On 11/21/23 05:10, Marek Vasut wrote: =20
>=20
> ..snip
>=20
> >>> I like this table-based look-up for write (and read) of scales.=20
> >>> Looking at this I see an analogy to some of the regulator stuff, like=
=20
> >>> for example the ramp-up values. What I do very much like in the=20
> >>> regulator subsystem is the drivers/regulator/helpers.c
> >>>
> >>> I wonder if similar approach would be usable in IIO as well? I mean,=
=20
> >>> providing readily written iio_regmap_read/write_raw_<functionality>()=
=20
> >>> and iio_available_*() helpers for the simple devices where we just=20
> >>> have value-register mapping? I mean, driver would just populate=20
> >>> something like:
> >>>
> >>> struct iio_scale_desc {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int *scale_val_table;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int *scale_val2_table;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int num_scales; =20
> >>
> >> You'd also need type here (fractional, int+micro, ...), right ? =20
> >=20
> > Well, my thinking was to go with baby-steps. Eg, start by supporting=20
> > just int+micro - but yes. As I wrote below, this can be expanded by=20
> > allowing specifying the type.
> >  =20
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int scale_reg_addr;
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int scale_reg_mask;
> >>> };
> >>>
> >>> and call helper like
> >>> int iio_regmap_read_raw_scale(struct iio_dev *idev,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct iio_scale_desc *sd, int *val,
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int *val2)"
> >>> provided by IIO framework.
> >>>
> >>> Similar helper for writing new scales and getting available scales.
> >>>
> >>> Later this could be expanded by allowing specifying the type of=20
> >>> provided values (in the example case, IIO_VAL_INT_PLUS_x - but maybe=
=20
> >>> this would be extensible (and worth) to support also the other option=
s?)
> >>> =20
>=20
> ... snip
>=20
> >>
> >> The only thing I would wonder about is, should such a thing go into=20
> >> regmap so it can be reused cross-subsystem instead of making this iio=
=20
> >> specific ? =20
> >=20
> > I definitely think a relation "register value" <=3D> "item from a table=
"=20
> > is very much used also outside the IIO. So yes, a generic regmap helper=
=20
> > for doing write as a "look value from table and write corresponding=20
> > value to a register" and "read value from register and return me a=20
> > corresponding item from a table" would be very usable.
> >=20
> > There is a tradeoff when doing a generic one instead of making it=20
> > targeted for IIO use. Supporting different types of data is likely to=20
> > make the code a bit hairy. Also, the IIO way of having these IIO_VAL_*=
=20
> > flags does probably require IIO - specific wrappers in any case. =20
>=20
> I had some spare time so drafted following:
>=20
> +struct reg_val_table {
> +       int *reg_vals;
> +       int *vals;
> +       int num_vals;
> +};
>=20
> ...
>=20
> +/**
> + * regtable_find_val - find a value matching register setting
> + *
> + * Search given table for value mathcing a register setting.
> + *
> + * @table:     Table from which the register setting - value pairs are
> + *             searched.
> + * @reg:       Register value for which the matching physical value is
> + *             searched.
> + * @val:       Pointer to location where the found value will be stored.
> + *
> + * returns:    0 on success, negative errno if table is invalid or match=
 is
> + *             not found.
> + */
> +int regtable_find_val(const struct reg_val_table *table, int reg, int *v=
al)
>=20
>=20
> +/**
> + * regtable_find_reg - find a register setting matching given value.
> + *
> + * Search given table for a register setting matching a value.
> + *
> + * @table:     Table from which the register setting - value pairs are
> + *             searched.
> + * @val:       Value for which the matching register setting is searched.
> + * @reg:       Pointer to location where the found register value will be
> + *             stored.
> + *
> + * returns:    0 on success, negative errno if table is invalid or match=
 is
> + *             not found.
> + */
> +int regtable_find_reg(const struct reg_val_table *table, int val, int *r=
eg)
>=20
>=20
> +/**
> + * regtable_find_greater_than_val - find the closest greater val and reg
Maybe use rounding terminology rather than greater than?

regtable_find_val_roundup()?

> + *
> + * Search given table for the smallest value which is still greater than
> + * the given value. Both the found value and corresponding register
> + * setting are returned unless given pointers are NULL.
> + *
> + * @table:     Table from which the register setting - value pairs are
> + *             searched.
> + * @val_cmp:   Value to which the values stored in table are compared to.
> + * @reg:       NULL or pointer to location where the matching register
> + *             setting value will be stored.
> + * @val:       NULL or pointer to location where the found value will be
> + *             stored.
> + *
> + * returns:    0 on success, negative errno if table is invalid or match=
 is
> + *             not found.
> + */
> +int regtable_find_greater_than_val(const struct reg_val_table *table,=20
> int val_cmp,
> +                                  int *reg, int *val)
>=20
>=20

regtable_find_val_rounddown()?

> +/**
> + * regtable_find_smaller_than_val - find the closest smaller val and reg
> + *
> + * Search given table for the greatest value which is still smaller than
> + * the given value. Both the found value and corresponding register
> + * setting are returned unless given pointers are NULL.
> + *
> + * @table:     Table from which the register setting - value pairs are
> + *             searched.
> + * @val_cmp:   Value to which the values stored in table are compared to.
> + * @reg:       NULL or pointer to location where the matching register
> + *             setting value will be stored.
> + * @val:       NULL or pointer to location where the found value will be
> + *             stored.
> + *
> + * returns:    0 on success, negative errno if table is invalid or match=
 is
> + *             not found.
> + */
> +int regtable_find_smaller_than_val(const struct reg_val_table *table,
> +                                  int val_cmp, int *reg, int *val)
>=20
>=20
> and
>=20
> +struct regmap_regval_table {
> +       const struct reg_val_table table;
> +       int reg;
> +       int mask;
> +};
>=20
> +/**
> + * regmap_table_value_set - update register to match=20
> human-understandable value
> + * @map:       Register map
> + * @table:     Table describing register-value, human-readable value=20
> relation
> + * value:      Human understandable value to configure in hardware.
> + *
> + * Return:     0 on success, negative errno on error.
> + */
> +int regmap_table_value_set(struct regmap *map,
> +                          const struct regmap_regval_table *table, int=20
> value)
>=20
>=20
> +/**
> + * regmap_table_value_get - return human-understandable configuration
> + *
> + * Reads hardware or regmap cache for current hardware configuration and
> + * converts the read register value to human understandable entity.
> + * @map:       Register map
> + * @table:     Table describing register-value, human-readable value=20
> relation
> + * value:      Human understandable value to configure in hardware.
> + *
> + * Return:     0 on success, negative errno on error.
> + */
> +int regmap_table_value_get(struct regmap *map,
> +                          const struct regmap_regval_table *table, int=20
> *value)
>=20
>=20
> (for anyone interested, whole thing + tests can be found from:
> https://github.com/M-Vaittinen/linux/commits/regtable/
> Just last 3 commits.)
>=20
> I am however having difficulties in seeing how this could be utilized by=
=20
> IIO, which tends to rely on values being represented by two integers=20
> (val and val2).

Two integers and a type to make it harder still... IIO_VAL_INT_PLUS_MICRO e=
tc
though I guess that might not need representing as generally the caller
would know what that was.  Fixed point (ish) is a pain, but not come up wit=
h a better
presentation yet :(


>=20
> Any suggestions regarding this idea? I'm wondering if I should just=20
> scrap this and try seeing if I can make an IIO-specific helper(s) - or=20
> if someone sees this would bring additional value worth an proper RFC? I=
=20
> don't want to sen an RFC for people to properly review if this idea is=20
> just plain stupid :)

It seems useful in general but I guess it's a question of whether you can f=
ind
enough users to justify it.

>=20
> Yours,
> 	-- Matti
>=20


