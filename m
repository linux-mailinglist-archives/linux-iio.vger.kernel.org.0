Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6503D6DC99D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Apr 2023 18:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDJQ5j (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Apr 2023 12:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjDJQ5j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Apr 2023 12:57:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86571BF9;
        Mon, 10 Apr 2023 09:57:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 485F861298;
        Mon, 10 Apr 2023 16:57:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9744C433EF;
        Mon, 10 Apr 2023 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681145856;
        bh=V+2awZdrW5NWIY63dz550FWGfXsfrH2zmYD+9pS+ywc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VyfnYV2637G6rpbAlfuGnh2PM0NFDdwkb1omUwhRm2PcwCQxnh43w3wsGfV3Mw7gd
         XHw4dLa0ER3HwPkCk6arBoYvGuVzYfBgppMrUB8IOgIzclWv5Bc0/gyJarJ56qIA38
         rWMDoLimpvgms3K5C628lSdjHF1JQPg1pcWSyjbyi6fO9IK73GTq1RJMiK/YGLQ2OX
         KT9Gf7FBJyDzChtbYtlSH86jgGsFciynxvxEFOllgnNcp7/U500q1dhW1E2EFvL/fY
         rVetN2yHA/afdBOzhW7obZGQ5WFDg+ieKPjqgpiKZ5emcp5xK6tffw9IYarrxBNsxm
         MrmvHJlWVRLIQ==
Date:   Mon, 10 Apr 2023 18:12:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Dan Carpenter <error27@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: imx93: fix a signedness bug in
 imx93_adc_read_raw()
Message-ID: <20230410181255.5035ea75@jic23-huawei>
In-Reply-To: <DB7PR04MB40101ADA70EEDE9FE130714E90A39@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <Y+utEvjfjQRQo2QB@kili>
        <DB7PR04MB40101ADA70EEDE9FE130714E90A39@DB7PR04MB4010.eurprd04.prod.outlook.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 15 Feb 2023 02:16:40 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Dan Carpenter <error27@gmail.com>
> > Sent: 2023=E5=B9=B42=E6=9C=8814=E6=97=A5 23:48
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>; Lars-Peter Clausen
> > <lars@metafoo.de>; Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-i=
mx
> > <linux-imx@nxp.com>; linux-iio@vger.kernel.org;
> > kernel-janitors@vger.kernel.org
> > Subject: [PATCH] iio: adc: imx93: fix a signedness bug in imx93_adc_rea=
d_raw()
> >=20
> > The problem is these lines:
> >=20
> > 	ret =3D vref_uv =3D regulator_get_voltage(adc->vref);
> > 	if (ret < 0)
> >=20
> > The "ret" variable is type long and "vref_uv" is u32 so that means the =
condition
> > can never be true on a 64bit system.  A negative error code from
> > regulator_get_voltage() would be cast to a high positive
> > u32 value and then remain a high positive value when cast to a long.
> >=20
> > The "ret" variable only ever stores ints so it should be declared as an=
 int.  We
> > can delete the "vref_uv" variable and use "ret" directly. =20
>=20
> Thanks for the catching!
>=20
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>

Applied to the fixes-togreg branch of iio.git.

Thanks

Jonathan

>=20
> Best Regards
> Haibo Chen
> >=20
> > Fixes: 7d02296ac8b8 ("iio: adc: add imx93 adc support")
> > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > ---
> >  drivers/iio/adc/imx93_adc.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/imx93_adc.c b/drivers/iio/adc/imx93_adc.c =
index
> > d8de8284e13d..8c68f0cd48f2 100644
> > --- a/drivers/iio/adc/imx93_adc.c
> > +++ b/drivers/iio/adc/imx93_adc.c
> > @@ -236,8 +236,7 @@ static int imx93_adc_read_raw(struct iio_dev
> > *indio_dev,  {
> >  	struct imx93_adc *adc =3D iio_priv(indio_dev);
> >  	struct device *dev =3D adc->dev;
> > -	long ret;
> > -	u32 vref_uv;
> > +	int ret;
> >=20
> >  	switch (mask) {
> >  	case IIO_CHAN_INFO_RAW:
> > @@ -253,10 +252,10 @@ static int imx93_adc_read_raw(struct iio_dev
> > *indio_dev,
> >  		return IIO_VAL_INT;
> >=20
> >  	case IIO_CHAN_INFO_SCALE:
> > -		ret =3D vref_uv =3D regulator_get_voltage(adc->vref);
> > +		ret =3D regulator_get_voltage(adc->vref);
> >  		if (ret < 0)
> >  			return ret;
> > -		*val =3D vref_uv / 1000;
> > +		*val =3D ret / 1000;
> >  		*val2 =3D 12;
> >  		return IIO_VAL_FRACTIONAL_LOG2;
> >=20
> > --
> > 2.35.1 =20
>=20

