Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C67A5E8D45
	for <lists+linux-iio@lfdr.de>; Sat, 24 Sep 2022 16:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbiIXOWw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 24 Sep 2022 10:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiIXOWu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 24 Sep 2022 10:22:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE859E0C6
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 07:22:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9106AB80DAF
        for <linux-iio@vger.kernel.org>; Sat, 24 Sep 2022 14:22:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A142C433D6;
        Sat, 24 Sep 2022 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664029366;
        bh=DmG39HCLiqVHbQoFCtDoz0NAoOHiovpmsUn+4M8cQKQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DAJTSFkp0Pv/j1sorh6J2+fNUf4K+QglFZrNRAkNqvVgpXIOYs6M3akjqwu5V6TTn
         nTQbgDrt41n38jL49OXrDd4Z/wOzyDUUG9i4QWFpO9Uc9s0y11ZHrosjZxOo3OuoLB
         7MKfjOBN5dbqEiO2hN/5PXiUXcPojM1rg9w0jxchorBO3fCo+dnnjf34SvSBk4p+pU
         YmsnmSdr3uUqvmohZYMQJpb88Q7POu6m0vWnZSGDJ7olKkWOgMtDkDvftvx6dqkYYR
         pEhAFcc1LzvC/6bebpsmlqlUzg1+S5SbW6CzCcquqR3BdibiwYZnfiAyTXqP6GdcBF
         SEdtsJxPYEScw==
Date:   Sat, 24 Sep 2022 15:22:48 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        "Fabio Estevam" <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "Shawn Guo" <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Subject: Re: [PATCH 01/15] iio: adc: ad_sigma_delta: do not use internal
 iio_dev lock
Message-ID: <20220924152248.5523267d@jic23-huawei>
In-Reply-To: <20220920135410.4429694c@xps-13>
References: <20220920112821.975359-1-nuno.sa@analog.com>
        <20220920112821.975359-2-nuno.sa@analog.com>
        <20220920135410.4429694c@xps-13>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 20 Sep 2022 13:54:10 +0200
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hi Nuno,
>=20
> nuno.sa@analog.com wrote on Tue, 20 Sep 2022 13:28:07 +0200:
>=20
> > Drop 'mlock' usage by making use of iio_device_claim_direct_mode().
> > This change actually makes sure we cannot do a single conversion while
> > buffering is enable. Note there was a potential race in the previous
> > code since we were only acquiring the lock after checking if the bus is
> > enabled.
> >=20
> > Fixes: af3008485ea0 ("iio:adc: Add common code for ADI Sigma Deltadevic=
es") =20
>=20
> To answer your question in the cover letter, I feel like this Fixes:
> tag is deserved.
>=20
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Agreed to the fixes tag being valid.
There is the slightly fun aspect that the issue predates
the introduction of iio_device_claim_direct_mode() so when this gets
backported we could get failures.  However, I think the oldest kernel
anyone is bothering with in the stable series is 4.9 and that function
was introduced earlier the same year as that kernel so we are probably fine=
 :)

I'm going to pick the easy ones up in this series, though note that these
are 'probably' now being queued up for next cycle.  Linus made some noises
about a possible rc8 though so I might do an extra pull request if that loo=
ks
likely - then these might make it in rather sooner.

Jonathan



>=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > ---
> >  drivers/iio/adc/ad_sigma_delta.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad_sigma_delta.c b/drivers/iio/adc/ad_sigm=
a_delta.c
> > index 261a9a6b45e1..d8570f620785 100644
> > --- a/drivers/iio/adc/ad_sigma_delta.c
> > +++ b/drivers/iio/adc/ad_sigma_delta.c
> > @@ -281,10 +281,10 @@ int ad_sigma_delta_single_conversion(struct iio_d=
ev *indio_dev,
> >  	unsigned int data_reg;
> >  	int ret =3D 0;
> > =20
> > -	if (iio_buffer_enabled(indio_dev))
> > -		return -EBUSY;
> > +	ret =3D iio_device_claim_direct_mode(indio_dev);
> > +	if (ret)
> > +		return ret;
> > =20
> > -	mutex_lock(&indio_dev->mlock);
> >  	ad_sigma_delta_set_channel(sigma_delta, chan->address);
> > =20
> >  	spi_bus_lock(sigma_delta->spi->master);
> > @@ -323,7 +323,7 @@ int ad_sigma_delta_single_conversion(struct iio_dev=
 *indio_dev,
> >  	ad_sigma_delta_set_mode(sigma_delta, AD_SD_MODE_IDLE);
> >  	sigma_delta->bus_locked =3D false;
> >  	spi_bus_unlock(sigma_delta->spi->master);
> > -	mutex_unlock(&indio_dev->mlock);
> > +	iio_device_release_direct_mode(indio_dev);
> > =20
> >  	if (ret)
> >  		return ret; =20
>=20
>=20
> Thanks,
> Miqu=C3=A8l

