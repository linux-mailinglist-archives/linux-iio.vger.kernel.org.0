Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292566124E4
	for <lists+linux-iio@lfdr.de>; Sat, 29 Oct 2022 20:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiJ2S0x (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 29 Oct 2022 14:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJ2S0x (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 29 Oct 2022 14:26:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66A630548
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 11:26:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 717BF60B86
        for <linux-iio@vger.kernel.org>; Sat, 29 Oct 2022 18:26:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888EBC433C1;
        Sat, 29 Oct 2022 18:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667068010;
        bh=cWKgFqM3No6J/WpEI6Q42STgGbeIPrMsGFJjljxk9s0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrEU8jyzgpkSHC1iI0vprTD0pmOdId390lA+/HVqjl/1ST551biQQGWMqOCTjmkmN
         ESltWVUkg2b90Fz1gPEyQK2ENky8jrXqNtkEw//cdzQh6scj5ixHqHfu0wGwHGTCba
         dnVrfwCQm4q5G+9U8hhRSk9M7KP+0TVY6sFdsin99TKVkJQCcp2R11/e8Eb7LH8gzZ
         R1cpTlhEBWKtOrgDFwqbfgbsciWVSu3yhjF/Yo0HRv0ATCom2oEI6ENMo2jbr5TkAB
         clIDAQQaoqhgX+6YFjJbp7/MPneDCdrm5B81C9//WwNK1RznmcSGkiibGlygt8qPQJ
         sXtz8k6qTImfw==
Date:   Sat, 29 Oct 2022 20:26:47 +0200
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: introduce sw trigger support
Message-ID: <Y11wZ9yGCmOMAf/x@lore-desk>
References: <93ae6ff1150b531a9d7a4d3d1b1adb8383613717.1666955685.git.lorenzo@kernel.org>
 <20221029162029.31f8291a@jic23-huawei>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7qiS1AmrxUFib9oQ"
Content-Disposition: inline
In-Reply-To: <20221029162029.31f8291a@jic23-huawei>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org


--7qiS1AmrxUFib9oQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> On Fri, 28 Oct 2022 13:23:42 +0200
> Lorenzo Bianconi <lorenzo@kernel.org> wrote:
>=20
> > There are some hw configuration where irq0 and/or irq1 pins are not
> > connected to the SPI or I2C/I3C controller.
>=20
> The might be connected to lots of other places on the application process=
or
> (doesn't really matter though - I think your meaning is clear enough!)
>=20
> > In order to avoid polling
> > the output register introduce iio-sw trigger support when irq line is
> > not available (or hw FIFO is not supported).
> >=20
> > Suggested-by: Mario Tesi <mario.tesi@st.com>
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>=20
> One comment / question inline.  Otherwise looks good to me.
>=20
> Jonathan
>=20
>=20
> > ---
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h      |  3 +-
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 78 ++++++++++++++++++++
> >  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_shub.c |  4 +-
> >  3 files changed, 81 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h b/drivers/iio/imu/=
st_lsm6dsx/st_lsm6dsx.h
> > index 07ad8027de73..6399b0bb6f67 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx.h
> > @@ -424,7 +424,7 @@ struct st_lsm6dsx_hw {
> >  	struct {
> >  		__le16 channels[3];
> >  		s64 ts __aligned(8);
> > -	} scan[3];
> > +	} scan[ST_LSM6DSX_ID_MAX];
> >  };
> > =20
>=20
> >  static inline int
> > diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio=
/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > index fe5fa08b68ac..73fd5f038375 100644
> > --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> > @@ -53,6 +53,8 @@
> >  #include <linux/iio/events.h>
> >  #include <linux/iio/iio.h>
> >  #include <linux/iio/sysfs.h>
> > +#include <linux/iio/triggered_buffer.h>
> > +#include <linux/iio/trigger_consumer.h>
> >  #include <linux/interrupt.h>
> >  #include <linux/irq.h>
> >  #include <linux/minmax.h>
> > @@ -2117,6 +2119,32 @@ static irqreturn_t st_lsm6dsx_handler_thread(int=
 irq, void *private)
> >  	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
> >  }
> > =20
> > +static irqreturn_t st_lsm6dsx_sw_trigger_handler_thread(int irq,
> > +							void *private)
> > +{
> > +	struct iio_poll_func *pf =3D private;
> > +	struct iio_dev *iio_dev =3D pf->indio_dev;
> > +	struct st_lsm6dsx_sensor *sensor =3D iio_priv(iio_dev);
> > +	struct st_lsm6dsx_hw *hw =3D sensor->hw;
> > +
> > +	if (sensor->id =3D=3D ST_LSM6DSX_ID_EXT0 ||
> > +	    sensor->id =3D=3D ST_LSM6DSX_ID_EXT1 ||
> > +	    sensor->id =3D=3D ST_LSM6DSX_ID_EXT2)
> > +		st_lsm6dsx_shub_read_output(hw,
> > +					    (u8 *)hw->scan[sensor->id].channels,
> > +					    sizeof(hw->scan[sensor->id].channels));
>=20
> Are we guaranteed this particular size of readback?  I'm guessing a bit
> as it's been a long time since I looked at this driver in detail, but cou=
ld
> we have sensors with either a different number of axes or different number
> of registers per axis?
>=20
> It might be neater to have two handlers, one for the EXTN cases and one
> for the main sensors.  That would push this conditional down to the
> point of registration.  I'm not sure it's worth it however so up to you...

Hi Jonathan,

so far we support just magnetometers on sensor-hub (LIS2MDL and LIS3MDL).
Both LIS2MDL and LIS3MDL have 3 axis, each of them is le16, so it is fine a=
s it
is for the moment. Do you prefer to be more generic and take into account n=
ew
possible sensors? I am not sure when they will arrive :)

Regards,
Lorenzo

>=20
>=20
> > +	else
> > +		st_lsm6dsx_read_locked(hw, iio_dev->channels[0].address,
> > +				       hw->scan[sensor->id].channels,
> > +				       sizeof(hw->scan[sensor->id].channels));
> > +
> > +	iio_push_to_buffers_with_timestamp(iio_dev, &hw->scan[sensor->id],
> > +					   iio_get_time_ns(iio_dev));
> > +	iio_trigger_notify_done(iio_dev->trig);
> > +
> > +	return IRQ_HANDLED;
> > +}
> > +
> >  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)
> >  {
> >  	struct st_sensors_platform_data *pdata;
> > @@ -2175,6 +2203,46 @@ static int st_lsm6dsx_irq_setup(struct st_lsm6ds=
x_hw *hw)
> >  	return 0;
> >  }
>=20
> > +static int st_lsm6dsx_sw_buffers_setup(struct st_lsm6dsx_hw *hw)
> > +{
> > +	int i;
> > +
> > +	for (i =3D 0; i < ST_LSM6DSX_ID_MAX; i++) {
> > +		int err;
> > +
> > +		if (!hw->iio_devs[i])
> > +			continue;
> > +
> > +		err =3D devm_iio_triggered_buffer_setup(hw->dev,
> > +					hw->iio_devs[i], NULL,
> > +					st_lsm6dsx_sw_trigger_handler_thread,
> > +					&st_lsm6dsx_sw_buffer_ops);
> > +		if (err)
> > +			return err;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> ...
>=20

--7qiS1AmrxUFib9oQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCY11wZwAKCRA6cBh0uS2t
rPKnAQCHeyW/Qycczvd4T+zk+edj8q7AtRdxppFBkpVbq8oQ8wEAkK9sgu03I8vK
yX6SlZlRKX+tAE3dSD94trnuA48AvwA=
=U9Rx
-----END PGP SIGNATURE-----

--7qiS1AmrxUFib9oQ--
