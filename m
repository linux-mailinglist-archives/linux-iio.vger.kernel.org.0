Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124714BB826
	for <lists+linux-iio@lfdr.de>; Fri, 18 Feb 2022 12:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiBRLdb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Feb 2022 06:33:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233423AbiBRLda (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Feb 2022 06:33:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824922A0736
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 03:33:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id EC706CE3148
        for <linux-iio@vger.kernel.org>; Fri, 18 Feb 2022 11:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8920DC340E9;
        Fri, 18 Feb 2022 11:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645183989;
        bh=NYtkmUVaouWyumQKxxDwXwxmSaUwG6qhqXDu4oYwgA4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kIsLPRUpBSwQ/YX+VFqYz+47cC1J14MkLTCxOxFl26KhJ/LKUy5s6SoZCdCWd53yr
         +9wEpaVs8+aPGScGzJF7b4Qz7Ii269IaVRb4fHzV6sBLHQ2/vMl0mwj65q+clXLfzx
         dAwytY5tLsEVSYpQroZcOLkjmkS57vhtFvWtXjCNEhvLaXL4denv5EqGYsq+dx5/5A
         xURAZA+tOYqSsk3IOOl1OOySN3mBKfVWcJsaTgvxLlROBvl74Oaw4/UUbGd5q8NnlW
         cNHaGFNgTGLnJqP7IWWRBb2lHOZsfRQl229+8uoFsbuL0bCQ0zVAHG3HbwfV6pjzMv
         MREz4A7jeEoEw==
Date:   Fri, 18 Feb 2022 11:39:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Himanshu Jha <himanshujha199640@gmail.com>,
        Song Qiang <songqiang1304521@gmail.com>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        William Markezana <william.markezana@meas-spec.com>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        Renato Lui Geh <renatogeh@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 00/16] 2nd set of IIO export namespaces
Message-ID: <20220218113953.08d63849@jic23-huawei>
In-Reply-To: <CAHp75Vf1SguefmPDMtm87O8h8AU2Hy3r7RaJ4o6yy9k87F4MqQ@mail.gmail.com>
References: <20220130205701.334592-1-jic23@kernel.org>
        <CAHp75Vf1SguefmPDMtm87O8h8AU2Hy3r7RaJ4o6yy9k87F4MqQ@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 31 Jan 2022 12:50:32 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Jan 30, 2022 at 10:50 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > Whilst I'm still looking for additional review on the first set,
> > I'll take the quiet as meaning no one objects and send out a second
> > set.  Note that I don't have anyone cc'd on some of these because
> > I couldn't immediately figure out who was still active and familiar
> > with the drivers.  As these should be simple to review, please take
> > a look at as many as you have time for!
> >
> > Here's the reasoning as per the first set cover letter.
> > Note that we have some clashes with patches that I'd like to clean
> > up the handling of dev_pm_ops and CONFIG_PM* guards so for now
> > I've dropped those cases from this series.
> >
> > https://lwn.net/Articles/760045/ provides a good overview of this feature
> > and why it might be used.  In this particular case we fall under the multi
> > module case.  For each group of modules, I've moved the exports into
> > an independent namespace.
> >
> > Whilst I'm not entirely sure it is worth the noise of moving the main
> > IIO exports into a namespace, it is definitely worthwhile for these small
> > clusters of related modules (typically a core + i2c and spi modules).
> >
> > I've just done those within drivers/accel (including all of st-sensors as
> > I did not want to do that piecemeal) as an initial set to get feedback on
> > what people think of the approach and in particular naming of the namespaces.
> >
> > As you can see it is a straight forward change to makes so I'll do the
> > rest of the IIO drivers once we are agreed on the generic details.
> > Note that I'll be expecting this for any new cases of this pattern going
> > forwards.
> >
> > Includes a small diversion in st-sensors where we had a bunch of duplicated
> > MODULE_* macros for some of the core modules which were made up of multiple
> > c files.  
> 
> I briefly looked at the series and found no drastical issues (hope CI
> will find, if any), so
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks

Series applied to the togreg branch of iio.git and pushed out as testing
to see if CI can find anything.

Thanks,

Jonathan
> 
> > Cc: Himanshu Jha <himanshujha199640@gmail.com>
> > Cc: Song Qiang <songqiang1304521@gmail.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>
> > Cc: Lars-Peter Clausen <lars@metafoo.de>
> > Cc: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> > Cc: Paul Cercueil <paul@crapouillou.net>
> > Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > Cc: William Markezana <william.markezana@meas-spec.com>
> > Cc: Ludovic Tancerel <ludovic.tancerel@maplehightech.com>
> > Cc: Renato Lui Geh <renatogeh@gmail.com>
> > Cc: Michael Hennerich <Michael.Hennerich@analog.com>
> >
> >
> > Jonathan Cameron (16):
> >   iio:adc:ad_sigma_delta: Move exports into IIO_AD_SIGMA_DELTA namespace
> >   iio:adc:ad7091r: Move exports into IIO_AD7091R namespace.
> >   iio:adc:ad76060: Move exports into IIO_AD7606 namespace.
> >   iio:common:meas-spec: Move exports into IIO_MEAS_SPEC_SENSORS
> >   iio:common:ssp_sensors: Move exports into IIO_SSP_SENSORS namespace
> >   iio:dac:ad5592r: Move exports into IIO_AD5592R namespace
> >   iio:dac:ad5686: Move exports into IIO_AD5686 namespace
> >   iio:imu:adis: Move exports into IIO_ADISLIB namespace
> >   iio:pressure:zpa2326: Move exports into IIO_ZPA2326 namespace
> >   iio:pressure:ms5611: Move exports into IIO_MS5611 namespace
> >   iio:pressure:mpl115: Move exports into IIO_MPL115 namespace
> >   iio:magnetometer:rm3100: Move exports to IIO_RM3100 namespace
> >   iio:magnetometer:bmc150: Move exports to IIO_BMC150_MAGN namespace
> >   iio:magnetometer:hmc5843: Move exports to IIO_HMC5843 namespace
> >   iio:light:st_uvis25: Move exports to IIO_UVIS25 namespace
> >   iio:chemical:bme680: Move exports to IIO_BME680 namespace
> >
> >  drivers/iio/accel/adis16201.c                 |  1 +
> >  drivers/iio/accel/adis16209.c                 |  1 +
> >  drivers/iio/accel/ssp_accel_sensor.c          |  1 +
> >  drivers/iio/adc/ad7091r-base.c                |  4 ++--
> >  drivers/iio/adc/ad7091r5.c                    |  1 +
> >  drivers/iio/adc/ad7124.c                      |  1 +
> >  drivers/iio/adc/ad7192.c                      |  1 +
> >  drivers/iio/adc/ad7606.c                      |  4 ++--
> >  drivers/iio/adc/ad7606_par.c                  |  1 +
> >  drivers/iio/adc/ad7606_spi.c                  |  1 +
> >  drivers/iio/adc/ad7780.c                      |  1 +
> >  drivers/iio/adc/ad7791.c                      |  1 +
> >  drivers/iio/adc/ad7793.c                      |  1 +
> >  drivers/iio/adc/ad_sigma_delta.c              | 20 ++++++++--------
> >  drivers/iio/chemical/bme680_core.c            |  4 ++--
> >  drivers/iio/chemical/bme680_i2c.c             |  1 +
> >  drivers/iio/chemical/bme680_spi.c             |  1 +
> >  .../iio/common/ms_sensors/ms_sensors_i2c.c    | 24 +++++++++----------
> >  drivers/iio/common/ssp_sensors/ssp_dev.c      | 10 ++++----
> >  drivers/iio/common/ssp_sensors/ssp_iio.c      |  7 +++---
> >  drivers/iio/dac/ad5592r-base.c                |  4 ++--
> >  drivers/iio/dac/ad5592r.c                     |  1 +
> >  drivers/iio/dac/ad5593r.c                     |  1 +
> >  drivers/iio/dac/ad5686-spi.c                  |  1 +
> >  drivers/iio/dac/ad5686.c                      |  4 ++--
> >  drivers/iio/dac/ad5696-i2c.c                  |  1 +
> >  drivers/iio/gyro/adis16136.c                  |  1 +
> >  drivers/iio/gyro/adis16260.c                  |  1 +
> >  drivers/iio/gyro/ssp_gyro_sensor.c            |  1 +
> >  drivers/iio/humidity/htu21.c                  |  1 +
> >  drivers/iio/imu/adis.c                        | 20 ++++++++--------
> >  drivers/iio/imu/adis16400.c                   |  1 +
> >  drivers/iio/imu/adis16460.c                   |  1 +
> >  drivers/iio/imu/adis16475.c                   |  1 +
> >  drivers/iio/imu/adis16480.c                   |  1 +
> >  drivers/iio/imu/adis_buffer.c                 |  4 ++--
> >  drivers/iio/imu/adis_trigger.c                |  2 +-
> >  drivers/iio/light/st_uvis25_core.c            |  4 ++--
> >  drivers/iio/light/st_uvis25_i2c.c             |  1 +
> >  drivers/iio/light/st_uvis25_spi.c             |  1 +
> >  drivers/iio/magnetometer/bmc150_magn.c        |  8 +++----
> >  drivers/iio/magnetometer/bmc150_magn_i2c.c    |  1 +
> >  drivers/iio/magnetometer/bmc150_magn_spi.c    |  1 +
> >  drivers/iio/magnetometer/hmc5843_core.c       |  8 +++----
> >  drivers/iio/magnetometer/hmc5843_i2c.c        |  1 +
> >  drivers/iio/magnetometer/hmc5843_spi.c        |  1 +
> >  drivers/iio/magnetometer/rm3100-core.c        |  8 +++----
> >  drivers/iio/magnetometer/rm3100-i2c.c         |  1 +
> >  drivers/iio/magnetometer/rm3100-spi.c         |  1 +
> >  drivers/iio/pressure/mpl115.c                 |  2 +-
> >  drivers/iio/pressure/mpl115_i2c.c             |  1 +
> >  drivers/iio/pressure/mpl115_spi.c             |  1 +
> >  drivers/iio/pressure/ms5611_core.c            |  4 ++--
> >  drivers/iio/pressure/ms5611_i2c.c             |  1 +
> >  drivers/iio/pressure/ms5611_spi.c             |  1 +
> >  drivers/iio/pressure/ms5637.c                 |  1 +
> >  drivers/iio/pressure/zpa2326.c                | 12 +++++-----
> >  drivers/iio/pressure/zpa2326_i2c.c            |  1 +
> >  drivers/iio/pressure/zpa2326_spi.c            |  1 +
> >  drivers/iio/temperature/tsys01.c              |  1 +
> >  drivers/iio/temperature/tsys02d.c             |  1 +
> >  drivers/staging/iio/accel/adis16203.c         |  1 +
> >  drivers/staging/iio/accel/adis16240.c         |  1 +
> >  63 files changed, 121 insertions(+), 76 deletions(-)
> >
> > --
> > 2.35.1
> >  
> 
> 

