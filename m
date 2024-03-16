Return-Path: <linux-iio+bounces-3556-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1C687DA45
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 14:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B6311F2173D
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 13:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28BFB17BAF;
	Sat, 16 Mar 2024 13:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAzd+8NM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB9AEAEB
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 13:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710595683; cv=none; b=Lychq1UpMri3tWiqr7OqH/IZ7weRvYY/1yRgTs5KCfcuWfPFDsNcyAS70gYV4lHJxcwDoHDjp18n9V+1g+DJCSFZRyjy/5jlg59gfLTAhC0SPcphJn0lzgDty8AXL3lWki+84SPF+E7t6RPa8m49xbB72Pp3sX3gC6K1c35S9R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710595683; c=relaxed/simple;
	bh=VJ8o55rE05FhwlG96vK0pCGMs709Gfubn04jWZH1Zuc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R+tL7s/NYRq38ze3ywqSFm/bllrwPQAPEA4F7yB1RZyFshQ+M7yx7z8Yg86a3twQQAiHeLDzbcEl2johCNYbyEjjicsfnN4ay2kvejhbiIVK92nSS5ZTVwwu57MmChUcbIld2xygn5LDN4Uzz5o8Jtt/akqA+/D+SKHHS9lXsag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAzd+8NM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8580C433C7;
	Sat, 16 Mar 2024 13:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710595683;
	bh=VJ8o55rE05FhwlG96vK0pCGMs709Gfubn04jWZH1Zuc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JAzd+8NMGwuEAE9h4l6v8iVKz3eJ48YIwA7jIBYwtRv6i+pkKPHIdNaR3uBI3Q/O1
	 pcVzrsDGo+y1pTVOZwagem/F0Y+9KnM00qWlU8WwjIlm2Em7vUW9CctYJ0ZadbLYPr
	 vi7HebxGYfqv34n2hA8JMrt5dSoWka0eMRe5hMRbIe9sJmnAMxQBfRE8xoDuEG+r90
	 gD9pbHxtuhSq9b8fs/zHAeJ0jT+5i24BbYmb+syRDe8h3Ppme1iAifPVVpTXGnHB1I
	 b02Ua19IPGwOE+/WXu4oGYH8DNSgPyZgiU8lINfpJW0smpqY1euanUG8Ovy+ssSXIv
	 +yQScX1EBoqoA==
Date: Sat, 16 Mar 2024 13:27:50 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend wakeup
 with low-power mode
Message-ID: <20240316132750.4b78e89a@jic23-huawei>
In-Reply-To: <FR3P281MB17573CB0387765756C5820A1CE292@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20240308151023.379705-1-inv.git-commit@tdk.com>
	<20240308151023.379705-5-inv.git-commit@tdk.com>
	<20240314145230.4fb5fc86@jic23-huawei>
	<FR3P281MB17573CB0387765756C5820A1CE292@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Mar 2024 16:44:23 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello Jonathan,
>=20
> I already issued a V3 of this patch.
>=20
> I have switched to guard(mutex) in the V3, but too bad I didn't get your =
comments sooner.
> Certainly, we could use BIT() macro, but I didn't want to change the othe=
r defines or have 1 BIT() in the middle. But do as you prefer.

It would need them all tidied up in a separate patch I think.

Jonathan

>=20
> Thanks for reviewing V3 of the series and for your comments,
> JB
>=20
> From:=C2=A0Jonathan Cameron <jic23@kernel.org>
> Sent:=C2=A0Thursday, March 14, 2024 15:52
> To:=C2=A0INV Git Commit <INV.git-commit@tdk.com>
> Cc:=C2=A0lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <li=
nux-iio@vger.kernel.org>; Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@td=
k.com>
> Subject:=C2=A0Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: add WoM suspend w=
akeup with low-power mode
> =C2=A0
> This Message Is From an External Sender
> This message came from outside your organization.
> =C2=A0
> On Fri,  8 Mar 2024 15:10:23 +0000
> inv.git-commit@tdk.com wrote:
>=20
> > From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
> >=20
> > Add wakeup from suspend for WoM when enabled and put accel in
> > low-power mode when suspended. Requires rewriting pwr_mgmt_1
> > register handling and factorize out accel LPF settings.
> > Use a low-power rate similar to the chip sampling rate but always
> > lower for a best match of the sampling rate while saving power
> > and adjust threshold to follow the required roc value.
> >=20
> > Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com> =
=20
> A few comments inline, but nothing significant that needs changes.
> Not sure why this didn't send the other day - just found it still open :(
>=20
> Jonathan
>=20
> > --- =20
>=20
> > +
> > +static int inv_mpu6050_set_wom_lp(struct inv_mpu6050_state *st, bool o=
n) =20
>=20
> You could just split this given almost nothing shared between the two bra=
nches.
>=20
> > +{
> > +	unsigned int lp_div;
> > +	int result;
> > +
> > +	if (on) {
> > +		/* set low power ODR */
> > +		result =3D inv_mpu6050_set_lp_odr(st, INV_MPU6050_FREQ_DIVIDER(st), =
&lp_div);
> > +		if (result)
> > +			return result;
> > +		/* disable accel low pass filter */
> > +		result =3D inv_mpu6050_set_accel_lpf_regs(st, INV_MPU6050_FILTER_NOL=
PF);
> > +		if (result)
> > +			return result;
> > +		/* update wom threshold with new low-power frequency divider */
> > +		result =3D inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_thr=
eshold, lp_div);
> > +		if (result)
> > +			return result;
> > +		/* set cycle mode */
> > +		result =3D inv_mpu6050_pwr_mgmt_1_write(st, false, true, -1, -1);
> > +	} else {
> > +		/* disable cycle mode */
> > +		result =3D inv_mpu6050_pwr_mgmt_1_write(st, false, false, -1, -1);
> > +		if (result)
> > +			return result;
> > +		/* restore wom threshold */
> > +		result =3D inv_mpu6050_set_wom_threshold(st, st->chip_config.roc_thr=
eshold,
> > +						       INV_MPU6050_FREQ_DIVIDER(st));
> > +		if (result)
> > +			return result;
> > +		/* restore accel low pass filter */
> > +		result =3D inv_mpu6050_set_accel_lpf_regs(st, st->chip_config.lpf);
> > +	}
> > +
> > +	return result;
> > +}
> > +
> >  static int inv_mpu6050_enable_wom(struct inv_mpu6050_state *st, bool e=
n)
> >  {
> >  	struct device *pdev =3D regmap_get_device(st->map);
> > @@ -1847,6 +1933,7 @@ int inv_mpu_core_probe(struct regmap *regmap, int=
 irq, const char *name,
> >  			irq_type);
> >  		return -EINVAL;
> >  	}
> > +	device_set_wakeup_capable(dev, true);
> > =20
> >  	st->vdd_supply =3D devm_regulator_get(dev, "vdd");
> >  	if (IS_ERR(st->vdd_supply))
> > @@ -2012,16 +2099,27 @@ static int inv_mpu_resume(struct device *dev)
> >  {
> >  	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> >  	struct inv_mpu6050_state *st =3D iio_priv(indio_dev);
> > +	bool wakeup;
> >  	int result;
> > =20
> >  	mutex_lock(&st->lock); =20
> A very good case for using guard(mutex)(&st->lock); but that can be a fut=
ure series.
>=20
> > -	result =3D inv_mpu_core_enable_regulator_vddio(st);
> > -	if (result)
> > -		goto out_unlock;
> > =20
> > -	result =3D inv_mpu6050_set_power_itg(st, true);
> > -	if (result)
> > -		goto out_unlock;
> > +	wakeup =3D device_may_wakeup(dev) && st->chip_config.wom_en;
> > +
> > +	if (wakeup) {
> > +		enable_irq(st->irq);
> > +		disable_irq_wake(st->irq);
> > +		result =3D inv_mpu6050_set_wom_lp(st, false);
> > +		if (result)
> > +			goto out_unlock;
> > +	} else {
> > +		result =3D inv_mpu_core_enable_regulator_vddio(st);
> > +		if (result)
> > +			goto out_unlock;
> > +		result =3D inv_mpu6050_set_power_itg(st, true);
> > +		if (result)
> > +			goto out_unlock;
> > +	}
> > =20
> >  	pm_runtime_disable(dev);
> >  	pm_runtime_set_active(dev);
> > @@ -2031,7 +2129,7 @@ static int inv_mpu_resume(struct device *dev)
> >  	if (result)
> >  		goto out_unlock;
> > =20
> > -	if (st->chip_config.wom_en) {
> > +	if (st->chip_config.wom_en && !wakeup) {
> >  		result =3D inv_mpu6050_set_wom_int(st, true);
> >  		if (result)
> >  			goto out_unlock; =20
> ...
>=20
> > diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/im=
u/inv_mpu6050/inv_mpu_iio.h
> > index e97a63ad2c31..6ba9d42b2537 100644
> > --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> > @@ -304,6 +304,7 @@ struct inv_mpu6050_state {
> >  #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
> >  #define INV_MPU6050_BIT_H_RESET             0x80
> >  #define INV_MPU6050_BIT_SLEEP               0x40
> > +#define INV_MPU6050_BIT_CYCLE               0x20
> >  #define INV_MPU6050_BIT_TEMP_DIS            0x08 =20
>=20
> Side note but why don't we use BIT(x) for these?
>=20
> >  #define INV_MPU6050_BIT_CLK_MASK            0x7
> > =20
> > @@ -335,6 +336,7 @@ struct inv_mpu6050_state {
> >  /* mpu6500 registers */
> >  #define INV_MPU6500_REG_ACCEL_CONFIG_2      0x1D
> >  #define INV_ICM20689_BITS_FIFO_SIZE_MAX     0xC0
> > +#define INV_MPU6500_REG_LP_ODR              0x1E
> >  #define INV_MPU6500_REG_WOM_THRESHOLD       0x1F
> >  #define INV_MPU6500_REG_ACCEL_INTEL_CTRL    0x69
> >  #define INV_MPU6500_BIT_ACCEL_INTEL_EN      BIT(7)
> > @@ -451,6 +453,18 @@ enum inv_mpu6050_filter_e {
> >  	NUM_MPU6050_FILTER
> >  };
> > =20
> > +enum inv_mpu6050_lposc_e {
> > +	INV_MPU6050_LPOSC_4HZ =3D 4,
> > +	INV_MPU6050_LPOSC_8HZ,
> > +	INV_MPU6050_LPOSC_16HZ,
> > +	INV_MPU6050_LPOSC_31HZ,
> > +	INV_MPU6050_LPOSC_62HZ,
> > +	INV_MPU6050_LPOSC_125HZ,
> > +	INV_MPU6050_LPOSC_250HZ,
> > +	INV_MPU6050_LPOSC_500HZ,
> > +	NUM_MPU6050_LPOSC, =20
>=20
> Trivial but no comma needed on a NUM type last entry as we'll never
> add anything after it.
>=20
> > +};
> > +
> >  /* IIO attribute address */
> >  enum INV_MPU6050_IIO_ATTR_ADDR {
> >  	ATTR_GYRO_MATRIX, =20
>=20


