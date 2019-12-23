Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08384129951
	for <lists+linux-iio@lfdr.de>; Mon, 23 Dec 2019 18:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbfLWRZv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Dec 2019 12:25:51 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39777 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726824AbfLWRZu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 23 Dec 2019 12:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1577121948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=26sE0SksoDEgDiardhKXnrxF+XCzn2wdGQwoGkj62K8=;
        b=L4csVd3vU2T2XIcRhkeUkr2kgqk9RRqxdoScCSM1SR7HTxCw6dPcjwuswF2uEX5CrHXGdt
        rZeJljXixg87GqV+iWniIuoQAt0flyBbE4G60gTXi+cfcMTSJdX3dacywBXOx59CirHy6T
        POBZN8NgOYyJEShEx/FXAuRByOhNGR8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-ljGXpDQfOVCqWIKzewJalA-1; Mon, 23 Dec 2019 12:25:43 -0500
X-MC-Unique: ljGXpDQfOVCqWIKzewJalA-1
Received: by mail-wm1-f72.google.com with SMTP id y125so131003wmg.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Dec 2019 09:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=26sE0SksoDEgDiardhKXnrxF+XCzn2wdGQwoGkj62K8=;
        b=MOH97urKQ8SrPusq7k5loo4mekkikTsUEvHzKItb+FRLHIB/p/CfcJdryzkJxwNBM3
         7zXnewjGj2YFdyrzzdqq6KXwZr7eUV8hXFN9qdwHpKI3ss8l0wIuT0EtEzRHRndlOI+A
         ErupDBuQjnUGEDOUiNZA4V8hz+qf5HHp4WkBv1YJ42mTlPwgLy81H2xc2XAeG5XDkA+t
         sQSz+szPz8ATqpqej6j3et3aKS8V4QQ9C1ja3Dk7twZTRkgUOsFdIKVdzV4cFVO0YArf
         noUD63xXemd/dKaYogWKAM/yi4bNgxuoQwwKlG3l2O0PNI+VJJIs+yDs3enpkYyLWiS5
         v5GQ==
X-Gm-Message-State: APjAAAV+6JPm4zaGN7EsQ16FMIxL49xLsYLAPa1dvXkD5ZpaM0Egg95Q
        agtMqx8/7/5ewe8ZnW2jOLkBzBhJBHSI94RsUaXfwy9dBiBkRWB9VJaq232G1Ss9Bg2yMYDdV+x
        hS4XJK4U050tIG+ceUmJN
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr30227690wrx.164.1577121942716;
        Mon, 23 Dec 2019 09:25:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqzYmaNjMIcVOzQxqomagf3wfGqBUO8oOM2MyynOqlaHZh0drQV2vaid0WDCbCNYcvnCXUZTbw==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr30227675wrx.164.1577121942432;
        Mon, 23 Dec 2019 09:25:42 -0800 (PST)
Received: from localhost.localdomain (nat-pool-mxp-t.redhat.com. [149.6.153.186])
        by smtp.gmail.com with ESMTPSA id x11sm22289944wre.68.2019.12.23.09.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Dec 2019 09:25:41 -0800 (PST)
Date:   Mon, 23 Dec 2019 18:25:39 +0100
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 6/6] iio: imu: st_lsm6dsx: enable sensor-hub support for
 lsm6dsm
Message-ID: <20191223172539.GE6274@localhost.localdomain>
References: <cover.1576341963.git.lorenzo@kernel.org>
 <aceae99afa9f51f533607c81f1eb1009fe0975d1.1576341963.git.lorenzo@kernel.org>
 <20191223164917.6bcb72cf@archlinux>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20191223164917.6bcb72cf@archlinux>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Sat, 14 Dec 2019 17:52:59 +0100
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > Enabled i2c master controller support for LSM6DSM sensor. Enable
> > ext_sensor0 for lsm6dsm. This series has been tested using LIS2MDL as
> > slave device connected to the i2c controller of the LSM6DSM
> >=20
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> One question inline.  However I'm happy enough to take it with that
> outstanding on basis I am not going to push out as non rebasing for
> a while yet.
>=20
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to play with it.
>=20
> Thanks,
>=20
> Jonathan
> =20
> > ---

[...]

> >  				iio_push_to_buffers_with_timestamp(
> >  					hw->iio_devs[ST_LSM6DSX_ID_ACC],
> >  					acc_buff, acc_sensor->ts_ref + ts);
> > +			if (ext_sip-- > 0)
> > +				iio_push_to_buffers_with_timestamp(
> > +					hw->iio_devs[ST_LSM6DSX_ID_EXT0],
> > +					ext_buff, ext_sensor->ts_ref + ts);
> >  		}
> >  	}
> > =20
> > @@ -628,12 +641,12 @@ int st_lsm6dsx_update_fifo(struct st_lsm6dsx_sens=
or *sensor, bool enable)
> >  		err =3D st_lsm6dsx_sensor_set_enable(sensor, enable);
> >  		if (err < 0)
> >  			goto out;
> > -
> > -		err =3D st_lsm6dsx_set_fifo_odr(sensor, enable);
> > -		if (err < 0)
> > -			goto out;
> >  	}
> > =20
>=20
> Why this change?  I'm not sure what the original logic was so hard to fol=
low ;)

Hi Jonathan,

we need to set FIFO odr to 1.66KHz for LSM6DSM even if we enable just the s=
ensor hub
(and not other sensors).

Regards,
Lorenzo

>=20
> > +	err =3D st_lsm6dsx_set_fifo_odr(sensor, enable);
> > +	if (err < 0)
> > +		goto out;
> > +
> >  	err =3D st_lsm6dsx_update_decimators(hw);
> >  	if (err < 0)
> >  		goto out;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index 679831d84d78..1f00b0d74b25 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -655,6 +655,10 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.addr =3D 0x08,
> >  				.mask =3D GENMASK(5, 3),
> >  			},
> > +			[ST_LSM6DSX_ID_EXT0] =3D {
> > +				.addr =3D 0x09,
> > +				.mask =3D GENMASK(2, 0),
> > +			},
> >  		},
> >  		.fifo_ops =3D {
> >  			.update_fifo =3D st_lsm6dsx_update_fifo,
> > @@ -687,6 +691,39 @@ static const struct st_lsm6dsx_settings st_lsm6dsx=
_sensor_settings[] =3D {
> >  				.mask =3D GENMASK(5, 3),
> >  			},
> >  		},
> > +		.shub_settings =3D {
> > +			.page_mux =3D {
> > +				.addr =3D 0x01,
> > +				.mask =3D BIT(7),
> > +			},
> > +			.master_en =3D {
> > +				.addr =3D 0x1a,
> > +				.mask =3D BIT(0),
> > +			},
> > +			.pullup_en =3D {
> > +				.addr =3D 0x1a,
> > +				.mask =3D BIT(3),
> > +			},
> > +			.aux_sens =3D {
> > +				.addr =3D 0x04,
> > +				.mask =3D GENMASK(5, 4),
> > +			},
> > +			.wr_once =3D {
> > +				.addr =3D 0x07,
> > +				.mask =3D BIT(5),
> > +			},
> > +			.emb_func =3D {
> > +				.addr =3D 0x19,
> > +				.mask =3D BIT(2),
> > +			},
> > +			.num_ext_dev =3D 1,
> > +			.shub_out =3D {
> > +				.addr =3D 0x2e,
> > +			},
> > +			.slv0_addr =3D 0x02,
> > +			.dw_slv0_addr =3D 0x0e,
> > +			.pause =3D 0x7,
> > +		},
> >  		.event_settings =3D {
> >  			.enable_reg =3D {
> >  				.addr =3D 0x58,
> > @@ -1901,6 +1938,16 @@ static int st_lsm6dsx_init_shub(struct st_lsm6ds=
x_hw *hw)
> >  					 hub_settings->aux_sens.mask, data);
> > =20
> >  		st_lsm6dsx_set_page(hw, false);
> > +
> > +		if (err < 0)
> > +			return err;
> > +	}
> > +
> > +	if (hub_settings->emb_func.addr) {
> > +		data =3D ST_LSM6DSX_SHIFT_VAL(1, hub_settings->emb_func.mask);
> > +		err =3D regmap_update_bits(hw->regmap,
> > +					 hub_settings->emb_func.addr,
> > +					 hub_settings->emb_func.mask, data);
> >  	}
> > =20
> >  	return err;
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > index dc739dfb36f2..eea555617d4a 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c
> > @@ -221,16 +221,21 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *se=
nsor, u8 addr,
> >  		     u8 *data, int len)
> >  {
> >  	const struct st_lsm6dsx_shub_settings *hub_settings;
> > +	u8 config[3], slv_addr, slv_config =3D 0;
> >  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > -	u8 config[3], slv_addr;
> > +	const struct st_lsm6dsx_reg *aux_sens;
> >  	int err;
> > =20
> >  	hub_settings =3D &hw->settings->shub_settings;
> >  	slv_addr =3D ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> > +	aux_sens =3D &hw->settings->shub_settings.aux_sens;
> > +	/* do not overwrite aux_sens */
> > +	if (slv_addr + 2 =3D=3D aux_sens->addr)
> > +		slv_config =3D ST_LSM6DSX_SHIFT_VAL(3, aux_sens->mask);
> > =20
> >  	config[0] =3D (sensor->ext_info.addr << 1) | 1;
> >  	config[1] =3D addr;
> > -	config[2] =3D len & ST_LS6DSX_READ_OP_MASK;
> > +	config[2] =3D (len & ST_LS6DSX_READ_OP_MASK) | slv_config;
> > =20
> >  	err =3D st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> >  					sizeof(config));
> > @@ -248,7 +253,9 @@ st_lsm6dsx_shub_read(struct st_lsm6dsx_sensor *sens=
or, u8 addr,
> > =20
> >  	st_lsm6dsx_shub_master_enable(sensor, false);
> > =20
> > -	memset(config, 0, sizeof(config));
> > +	config[0] =3D hub_settings->pause;
> > +	config[1] =3D 0;
> > +	config[2] =3D slv_config;
> >  	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> >  					 sizeof(config));
> >  }
> > @@ -305,7 +312,8 @@ st_lsm6dsx_shub_write(struct st_lsm6dsx_sensor *sen=
sor, u8 addr,
> >  		st_lsm6dsx_shub_master_enable(sensor, false);
> >  	}
> > =20
> > -	memset(config, 0, sizeof(config));
> > +	config[0] =3D hub_settings->pause;
> > +	config[1] =3D 0;
> >  	return st_lsm6dsx_shub_write_reg(hw, slv_addr, config, sizeof(config)=
);
> >  }
> > =20
> > @@ -697,14 +705,19 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *h=
w, u8 *i2c_addr,
> >  			  const struct st_lsm6dsx_ext_dev_settings *settings)
> >  {
> >  	const struct st_lsm6dsx_shub_settings *hub_settings;
> > +	u8 config[3], data, slv_addr, slv_config =3D 0;
> > +	const struct st_lsm6dsx_reg *aux_sens;
> >  	struct st_lsm6dsx_sensor *sensor;
> > -	u8 config[3], data, slv_addr;
> >  	bool found =3D false;
> >  	int i, err;
> > =20
> > +	sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> >  	hub_settings =3D &hw->settings->shub_settings;
> > +	aux_sens =3D &hw->settings->shub_settings.aux_sens;
> >  	slv_addr =3D ST_LSM6DSX_SLV_ADDR(0, hub_settings->slv0_addr);
> > -	sensor =3D iio_priv(hw->iio_devs[ST_LSM6DSX_ID_ACC]);
> > +	/* do not overwrite aux_sens */
> > +	if (slv_addr + 2 =3D=3D aux_sens->addr)
> > +		slv_config =3D ST_LSM6DSX_SHIFT_VAL(3, aux_sens->mask);
> > =20
> >  	for (i =3D 0; i < ARRAY_SIZE(settings->i2c_addr); i++) {
> >  		if (!settings->i2c_addr[i])
> > @@ -713,7 +726,7 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw,=
 u8 *i2c_addr,
> >  		/* read wai slave register */
> >  		config[0] =3D (settings->i2c_addr[i] << 1) | 0x1;
> >  		config[1] =3D settings->wai.addr;
> > -		config[2] =3D 0x1;
> > +		config[2] =3D 0x1 | slv_config;
> > =20
> >  		err =3D st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> >  						sizeof(config));
> > @@ -742,7 +755,9 @@ st_lsm6dsx_shub_check_wai(struct st_lsm6dsx_hw *hw,=
 u8 *i2c_addr,
> >  	}
> > =20
> >  	/* reset SLV0 channel */
> > -	memset(config, 0, sizeof(config));
> > +	config[0] =3D hub_settings->pause;
> > +	config[1] =3D 0;
> > +	config[2] =3D slv_config;
> >  	err =3D st_lsm6dsx_shub_write_reg(hw, slv_addr, config,
> >  					sizeof(config));
> >  	if (err < 0)
>=20

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCXgD4kAAKCRA6cBh0uS2t
rG9FAP9TZAnQSSbvTQPoeVZUPUunPfE3MOTg/kVVtyQcqLe74AD/VEe4tWNWvOYI
JN1R4MIJg+1XKL168H7Y6HXJXsDWywA=
=naQo
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--

