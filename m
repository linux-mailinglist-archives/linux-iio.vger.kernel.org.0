Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDDA44BB81F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234229AbiBRLba (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:31:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiBRLb3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:31:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB8A2AFEA3
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:31:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E505B825D7
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 11:31:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31E64C340F1;
        Fri, 18 Feb 2022 11:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645183870;
        bh=gDbLjYxt0UZBkjELmmn6gn85MetmorNDuaNbGZVO8JQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SR47GaPvyLE5r1mfPEhLbnVranoOpYIzoDh8Txe5KebPWNhfHyY57RiERerI6eZmH
         PtCfY5uIrcE4QYRSUgBaS3Bz0omNBEyP979ykmw6QtFHdV274KEx8p/aicRF3VaHF+
         qgEp4JbaTzEJRwjiAAFIq7DVa6+Y11Qeqccpu3cCZcaOt+WG2azf1On0ljaH+05sSE
         1Sxuida6SRnAe4HuKFG14tQklyigK2qsKwPD74lNtPnVLkgakYTmeHYp8tkW9PHsOE
         I6ekCIOiN7P6+QnrtDUkFjiKO9CuFX852s3aHp7cztOvXHg+J4vZ4gE8zIU/v20I30
         hWFHCfGXqSZcA==
Date:   Fri, 18 Feb 2022 11:37:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Sean Nyekjaer <sean@geanix.com>,
        Denis Ciocca <denis.ciocca@st.com>
Subject: Re: [PATCH v2 00/13] IIO: accel/st-sensors move into separate
 symbol namespaces
Message-ID: <20220218113756.59b6cb7e@jic23-huawei>
In-Reply-To: <e23ff571cb023799d9890b2d9426c34e27a58ae4.camel@linux.intel.com>
References: <20220116180535.2367780-1-jic23@kernel.org>
        <20220130200128.58228e7b@jic23-huawei>
        <20220214101843.00004bfb@Huawei.com>
        <e23ff571cb023799d9890b2d9426c34e27a58ae4.camel@linux.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 14 Feb 2022 07:40:24 -0800
srinivas pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> On Mon, 2022-02-14 at 10:18 +0000, Jonathan Cameron wrote:
> > On Sun, 30 Jan 2022 20:01:28 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > On Sun, 16 Jan 2022 18:05:22 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >  =20
> > > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>=C2=A0  =20
> > >=20
> > > Hi All,
> > >=20
> > > I'd appreciate it if someone has a chance to look at this set.
> > > Should be fairly simple to review as more or less mechanical
> > > changes
> > > other than the choice of naming for each namespace. =20
> >=20
> > I plan to pick this set up shortly on basis v1 got some review and
> > comments were all about the prefix.=C2=A0 So hopefully everything else
> > is fine.
> >=20
> > However, if anyone does have time to sanity check it would be much
> > appreciated as I don't trust myself to not do something silly
> > (call it experience :) =20
> I did sanity check, didn't find any issue.
Thanks!

Applied to the togreg branch of iio.git and pushed out as testing
see if the autobuilders can find anything we missed.

Jonathan

>=20
> Thanks,
> Srinivas
>=20
> >=20
> > Thanks,
> >=20
> > Jonathan
> >  =20
> > >=20
> > > Thanks,
> > >=20
> > > Jonathan
> > >  =20
> > > >=20
> > > > Changes since v1:
> > > > * Add IIO_ prefix to namespaces.
> > > >=20
> > > > https://lwn.net/Articles/760045/=C2=A0provides a good overview of t=
his
> > > > feature
> > > > and why it might be used.=C2=A0 In this particular case we fall und=
er
> > > > the multi
> > > > module case.=C2=A0 For each group of modules, I've moved the exports
> > > > into
> > > > an independent namespace.
> > > >=20
> > > > Whilst I'm not entirely sure it is worth the noise of moving the
> > > > main
> > > > IIO exports into a namespace, it is definitely worthwhile for
> > > > these small
> > > > clusters of related modules (typically a core + i2c and spi
> > > > modules).
> > > >=20
> > > > I've just done those within drivers/accel (including all of st-
> > > > sensors as
> > > > I did not want to do that piecemeal) as an initial set to get
> > > > feedback on
> > > > what people think of the approach and in particular naming of the
> > > > namespaces.
> > > >=20
> > > > As you can see it is a straight forward change to makes so I'll
> > > > do the
> > > > rest of the IIO drivers once we are agreed on the generic
> > > > details.
> > > > Note that I'll be expecting this for any new cases of this
> > > > pattern going
> > > > forwards.
> > > >=20
> > > > Includes a small diversion in st-sensors where we had a bunch of
> > > > duplicated
> > > > MODULE_* macros for some of the core modules which were made up
> > > > of multiple
> > > > c files.
> > > >=20
> > > > Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
> > > > Cc: Puranjay Mohan <puranjay12@gmail.com>
> > > > Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > Cc: Mike Looijmans <mike.looijmans@topic.nl>
> > > > Cc: Sean Nyekjaer <sean@geanix.com>
> > > > Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > > Cc: Linus Walleij <linus.walleij@linaro.org>
> > > > Cc: Denis Ciocca <denis.ciocca@st.com>
> > > >=20
> > > > Jonathan Cameron (13):
> > > > =C2=A0 iio:accel:mma9551_core: Move exports into IIO_MMA9551 namesp=
ace
> > > > =C2=A0 iio:accel:mma7455_core: Move exports into IIO_MMA7455 namesp=
ace
> > > > =C2=A0 iio:accel:kxsd9: Move exports into IIO_KDSD9 namespace
> > > > =C2=A0 iio:accel:bma400: Move exports into IIO_BMA400 namespace
> > > > =C2=A0 iio:accel:adxl313: Move exports into IIO_ADXL313 namespace
> > > > =C2=A0 iio:accel:adxl345: Move exports into IIO_ADXL345 namespace
> > > > =C2=A0 iio:accel:adxl355: Move exports into IIO_ADXL355 namespace
> > > > =C2=A0 iio:accel:adxl372: Move exports into IIO_ADXL372 namespace
> > > > =C2=A0 iio:accel:bmc150: Move exports into IIO_BMC150 namespace
> > > > =C2=A0 iio:accel:bmi088: Move exports into IIO_BMI088 namespace
> > > > =C2=A0 iio:accel:fxl8962af: Move exports into IIO_FXL8962AF namespa=
ce
> > > > =C2=A0 iio:st-sensors: Remove duplicate MODULE_*
> > > > =C2=A0 iio:st-sensors: Move exports into IIO_ST_SENSORS namespace
> > > >=20
> > > > =C2=A0drivers/iio/accel/adxl313_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/adxl313_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl313_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl345_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +-
> > > > =C2=A0drivers/iio/accel/adxl345_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl345_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl355_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/adxl355_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl355_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl372.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 4 +--
> > > > =C2=A0drivers/iio/accel/adxl372_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/adxl372_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/bma400_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/bma400_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/bma400_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/bmc150-accel-core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++---
> > > > =C2=A0drivers/iio/accel/bmc150-accel-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/bmc150-accel-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/bmi088-accel-core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 8 ++---
> > > > =C2=A0drivers/iio/accel/bmi088-accel-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/fxls8962af-core.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/fxls8962af-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/fxls8962af-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/kxsd9-i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
> > > > =C2=A0drivers/iio/accel/kxsd9-spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
1 +
> > > > =C2=A0drivers/iio/accel/kxsd9.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/mma7455_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 6 ++--
> > > > =C2=A0drivers/iio/accel/mma7455_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/mma7455_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/mma9551.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/mma9551_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 36 +++++++++----
> > > > ------
> > > > =C2=A0drivers/iio/accel/mma9553.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/st_accel_buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 ---
> > > > =C2=A0drivers/iio/accel/st_accel_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +--
> > > > =C2=A0drivers/iio/accel/st_accel_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/accel/st_accel_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0.../iio/common/st_sensors/st_sensors_buffer.c |=C2=A0 7 +---
> > > > =C2=A0.../iio/common/st_sensors/st_sensors_core.c=C2=A0=C2=A0 | 28 =
+++++++------
> > > > --
> > > > =C2=A0.../iio/common/st_sensors/st_sensors_i2c.c=C2=A0=C2=A0=C2=A0 =
|=C2=A0 2 +-
> > > > =C2=A0.../iio/common/st_sensors/st_sensors_spi.c=C2=A0=C2=A0=C2=A0 =
|=C2=A0 2 +-
> > > > =C2=A0.../common/st_sensors/st_sensors_trigger.c=C2=A0=C2=A0=C2=A0 =
|=C2=A0 9 ++---
> > > > =C2=A0drivers/iio/gyro/st_gyro_buffer.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 4 ---
> > > > =C2=A0drivers/iio/gyro/st_gyro_core.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 5 +--
> > > > =C2=A0drivers/iio/gyro/st_gyro_i2c.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/gyro/st_gyro_spi.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_core.c=C2=A0 |=C2=A0 3 =
+-
> > > > =C2=A0drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_i2c.c=C2=A0=C2=A0 |=C2=
=A0 1 +
> > > > =C2=A0drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c=C2=A0=C2=A0 |=C2=
=A0 1 +
> > > > =C2=A0drivers/iio/magnetometer/st_magn_buffer.c=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 4 ---
> > > > =C2=A0drivers/iio/magnetometer/st_magn_core.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +--
> > > > =C2=A0drivers/iio/magnetometer/st_magn_i2c.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/magnetometer/st_magn_spi.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/pressure/st_pressure_buffer.c=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0 5 ---
> > > > =C2=A0drivers/iio/pressure/st_pressure_core.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +--
> > > > =C2=A0drivers/iio/pressure/st_pressure_i2c.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A0drivers/iio/pressure/st_pressure_spi.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 1 +
> > > > =C2=A056 files changed, 111 insertions(+), 103 deletions(-)
> > > > =C2=A0  =20
> > >  =20
> >  =20
>=20

