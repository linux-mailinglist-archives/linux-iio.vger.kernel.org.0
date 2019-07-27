Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4B777C3A
	for <lists+linux-iio@lfdr.de>; Sat, 27 Jul 2019 23:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725280AbfG0V7o (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Jul 2019 17:59:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725263AbfG0V7n (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Jul 2019 17:59:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35A9B2085A;
        Sat, 27 Jul 2019 21:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564264782;
        bh=K8n4MeIvGQKOLm7FtIlhwfB+lz2iSJKzOVCxp4peWp0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bnZWlHn2zwC2vsK4gHvioDflL31jdz3awGBZaK+SVMqkiO0YBN4PV1SXDsazmqswq
         mI4v7PDvnTgiTS8Z8dt8PebGVr4tMApaG2vKwZFwGV4RN6ESWQFnrhTCXrXfDwCy0m
         lLYx68k1NptZsTIAIaISM/O46i442JssYwTG1yOU=
Date:   Sat, 27 Jul 2019 22:59:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iio: common: cros_ec_sensors: determine protocol
 version
Message-ID: <20190727225936.753ee487@archlinux>
In-Reply-To: <2b0bc34a6cf504c468a5708709384c6b4af42e10.camel@collabora.com>
References: <cover.1562056868.git.fabien.lahoudere@collabora.com>
        <3fc3e1e606bc1e5478fca0888f9c005df6e52745.1562056868.git.fabien.lahoudere@collabora.com>
        <20190714171935.6a67cfb2@archlinux>
        <2b0bc34a6cf504c468a5708709384c6b4af42e10.camel@collabora.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 16 Jul 2019 10:56:38 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> Le dimanche 14 juillet 2019 =C3=A0 17:19 +0100, Jonathan Cameron a =C3=A9=
crit :
> > On Tue,  2 Jul 2019 10:49:38 +0200
> > Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:
> >  =20
> > > This patch adds a function to determine which version of the
> > > protocol is used to communicate with EC.
> > >=20
> > > Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> > > Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> > > Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> > > Tested-by: Gwendal Grignou <gwendal@chromium.org>
> > > Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com> =20
> > There are so many different series flying around for this driver that
> > I have given up trying to figure out if I should be picking some of
> > them up.  I'll ack them on the assumption they'll all go together,
> > but feel free to ping me if you want me to pick some of them up
> > through IIO.
> >  =20
>=20
> Yes sorry for all that confusing series.
> Enric wanted this patch first and it is independant of others, so feel
> free to pick it. Others patcheshave been sent separately.
Applied.

Thanks,

Jonathan
>=20
> Thanks
>=20
> > Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > > ---
> > >  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36
> > > ++++++++++++++++++-
> > >  1 file changed, 35 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git
> > > a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > index 130362ca421b..81111af8a167 100644
> > > --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> > > @@ -25,6 +25,31 @@ static char *cros_ec_loc[] =3D {
> > >  	[MOTIONSENSE_LOC_MAX] =3D "unknown",
> > >  };
> > > =20
> > > +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device
> > > *ec_dev,
> > > +					     u16 cmd_offset, u16 cmd,
> > > u32 *mask)
> > > +{
> > > +	int ret;
> > > +	struct {
> > > +		struct cros_ec_command msg;
> > > +		union {
> > > +			struct ec_params_get_cmd_versions params;
> > > +			struct ec_response_get_cmd_versions resp;
> > > +		};
> > > +	} __packed buf =3D {
> > > +		.msg =3D {
> > > +			.command =3D EC_CMD_GET_CMD_VERSIONS +
> > > cmd_offset,
> > > +			.insize =3D sizeof(struct
> > > ec_response_get_cmd_versions),
> > > +			.outsize =3D sizeof(struct
> > > ec_params_get_cmd_versions)
> > > +			},
> > > +		.params =3D {.cmd =3D cmd}
> > > +	};
> > > +
> > > +	ret =3D cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> > > +	if (ret >=3D 0)
> > > +		*mask =3D buf.resp.version_mask;
> > > +	return ret;
> > > +}
> > > +
> > >  int cros_ec_sensors_core_init(struct platform_device *pdev,
> > >  			      struct iio_dev *indio_dev,
> > >  			      bool physical_device)
> > > @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct
> > > platform_device *pdev,
> > >  	struct cros_ec_sensors_core_state *state =3D iio_priv(indio_dev);
> > >  	struct cros_ec_dev *ec =3D dev_get_drvdata(pdev->dev.parent);
> > >  	struct cros_ec_sensor_platform *sensor_platform =3D
> > > dev_get_platdata(dev);
> > > +	u32 ver_mask;
> > > +	int ret;
> > > =20
> > >  	platform_set_drvdata(pdev, indio_dev);
> > > =20
> > > @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct
> > > platform_device *pdev,
> > > =20
> > >  	mutex_init(&state->cmd_lock);
> > > =20
> > > +	ret =3D cros_ec_get_host_cmd_version_mask(state->ec,
> > > +						ec->cmd_offset,
> > > +						EC_CMD_MOTION_SENSE_CMD
> > > ,
> > > +						&ver_mask);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > >  	/* Set up the host command structure. */
> > > -	state->msg->version =3D 2;
> > > +	state->msg->version =3D fls(ver_mask) - 1;
> > >  	state->msg->command =3D EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
> > >  	state->msg->outsize =3D sizeof(struct ec_params_motion_sense);
> > >   =20
>=20

