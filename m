Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D230553B7A
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jun 2022 22:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354303AbiFUUV4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jun 2022 16:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354270AbiFUUV4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jun 2022 16:21:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5AE1D31D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 13:21:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D8C6181D
        for <linux-iio@vger.kernel.org>; Tue, 21 Jun 2022 20:21:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F8DAC341C8;
        Tue, 21 Jun 2022 20:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655842914;
        bh=cqInZ8yg+41pRAR7Y1Ef4Sk6DhDP0X1rWqWoxzBWSww=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sFi9/wNlNYgVo3xXtfDe1i+wvoYdWgu76KNvkheTKje4gsWZDB0uFhc+iXZNObxKr
         gg2yhu6tt0wnlU7HU8KZDIHg9wu2JO1YwAuH5abuXSkFZE84TkFL/s/IemhDuPEJAl
         OxhD2XAm3YLF0g14m/6owc5cwOsfAl54IEFrR/l73ox35jALyUaiuC6ahHHyeX4hr3
         NbTNZMBTWomp1rlxFokxxtG26oLRdiDlm35E/xJlSDVx6a4bxcDRTwaJG8daknYE1s
         k4ycI4ULsiMQDPFzbWZMBdfD/B7a2oodjPQnXdBLQW9OWKg5nRcit9WEioNXlq/iWm
         YkGiY8zpGrOPQ==
Date:   Tue, 21 Jun 2022 21:31:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Joe Simmons-Talbott <joetalbott@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Tomasz Duszynski <tomasz.duszynski@octakon.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>
Subject: Re: [PATCH v2 0/4] 3rd set of IIO export namespaces.
Message-ID: <20220621213118.2c3c460c@jic23-huawei>
In-Reply-To: <YrE88tt9469NSNno@spruce>
References: <20220604155306.422937-1-jic23@kernel.org>
        <20220618142054.4571f2f4@jic23-huawei>
        <YrE88tt9469NSNno@spruce>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 20 Jun 2022 23:37:22 -0400
Joe Simmons-Talbott <joetalbott@gmail.com> wrote:

> On Sat, Jun 18, 2022 at 02:20:54PM +0100, Jonathan Cameron wrote:
> > On Sat,  4 Jun 2022 16:53:02 +0100
> > Jonathan Cameron <jic23@kernel.org> wrote:
> >  =20
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >=20
> > > Changes since v1:
> > > - Rebase (bit of fuzz in patches 1 and 4) =20
> >=20
> > If anyone has time to take a quick look through this lot and sanity
> > check I haven't done anything stupid it would be much appreciated. =20
>=20
> FWIW, 1 through 4 look good to me.
>=20
> Reviewed-By: Joe Simmons-Talbott <joetalbott@gmail.com>
>=20
Thanks!

Applied to the togreg branch of iio.git and pushed out as testing to
see if 0-day finds anything we missed.

Thanks,

Jonathan

> Joe
> >=20
> > Disadvantage of being the maintainer is there isn't anyone else you
> > can moan about when no one reviews your patches. Of course I never
> > moan about other maintainers and I'm sure no one ever moans
> > about me :)
> >  =20
> > >=20
> > > I sent v1 out in Feb and only got review on one patch (which I've sin=
ce
> > > applied - thanks Nuno).
> > >=20
> > > Looking for a quick sanity check of these 4 that remain from anyone w=
ho
> > > has the time.  Whilst this is mechanical stuff, I've made enough dumb
> > > mistakes in such patches over the years that I still like to get a se=
cond
> > > set of eyes on them if at all possible!=20
> > >=20
> > > Cc: Tomasz Duszynski <tomasz.duszynski@octakon.com>
> > > Cc: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > > Cc: Siddartha Mohanadoss <smohanad@codeaurora.org>
> > >=20
> > > Jonathan Cameron (4):
> > >   iio: imu: bmi160: Move exported symbols to IIO_BMI160 namespace
> > >   iio: pressure: bmp280: Move symbol exports to IIO_BMP280 namespace
> > >   iio: chemical: sps30: Move symbol exports into IIO_SPS30 namespace
> > >   iio: adc: qcom-vadc: Move symbol exports to IIO_QCOM_VADC namespace
> > >=20
> > >  drivers/iio/adc/qcom-pm8xxx-xoadc.c  |  1 +
> > >  drivers/iio/adc/qcom-spmi-adc5.c     |  1 +
> > >  drivers/iio/adc/qcom-spmi-vadc.c     |  1 +
> > >  drivers/iio/adc/qcom-vadc-common.c   | 16 ++++++++--------
> > >  drivers/iio/chemical/sps30.c         |  2 +-
> > >  drivers/iio/chemical/sps30_i2c.c     |  1 +
> > >  drivers/iio/chemical/sps30_serial.c  |  1 +
> > >  drivers/iio/imu/bmi160/bmi160_core.c |  6 +++---
> > >  drivers/iio/imu/bmi160/bmi160_i2c.c  |  1 +
> > >  drivers/iio/imu/bmi160/bmi160_spi.c  |  1 +
> > >  drivers/iio/pressure/bmp280-core.c   |  2 +-
> > >  drivers/iio/pressure/bmp280-i2c.c    |  1 +
> > >  drivers/iio/pressure/bmp280-regmap.c |  4 ++--
> > >  drivers/iio/pressure/bmp280-spi.c    |  1 +
> > >  14 files changed, 24 insertions(+), 15 deletions(-)
> > >  =20
> >  =20

