Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C97253CDA8
	for <lists+linux-iio@lfdr.de>; Fri,  3 Jun 2022 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344177AbiFCRDH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 3 Jun 2022 13:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344178AbiFCRDG (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 3 Jun 2022 13:03:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFAB51E6B
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 10:03:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A240661A3D
        for <linux-iio@vger.kernel.org>; Fri,  3 Jun 2022 17:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89534C385A9;
        Fri,  3 Jun 2022 17:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654275784;
        bh=Fo2kYQPEM6N0VrEs6aOZdbV//wy0FJCMzWSjZW/u1iQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=caa6b8Nj+pESbzWa7G+pbielELgSagNGTceHABlfRHzwCfrtD3hxfKXYj1LwRktXo
         OMPgSS/EZd7wZ4C8/HbBVnu0d+4tLzKwQYY3zSpM1fWLqX3eQNLRrVXBg2v/mkXr5D
         /0Pl3aMH90Q1nhMlfL8bw2dkfw0oRK+gSB+JyNkMSIRvHXtH/ndZTyiCuFG2UcpnQ0
         Z/iA+fX7L4FzlQN9DSKQzqVv07y1S0hU3ViOos9DGcsn4xI74tInG46z9dmO23WaHy
         EJf9PnjCCFrqZs2sT/gWetTna7yA6nvNBOhgq+3nMCyBI+LgwiodIyq4DJdYWPw6O4
         PHnboXUNwBWMg==
Date:   Fri, 3 Jun 2022 18:12:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Baruch Siach <baruch@tkos.co.il>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: adc: vf610: fix conversion mode sysfs node name
Message-ID: <20220603181203.66f92a60@jic23-huawei>
In-Reply-To: <DB7SPR01MB0028368318C836EBA62D34A690DD9@DB7SPR01MB0028.eurprd04.prod.outlook.com>
References: <560dc93fafe5ef7e9a409885fd20b6beac3973d8.1653900626.git.baruch@tkos.co.il>
        <DB7SPR01MB0028368318C836EBA62D34A690DD9@DB7SPR01MB0028.eurprd04.prod.outlook.com>
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

On Mon, 30 May 2022 09:06:53 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Baruch Siach <baruch@tkos.co.il>
> > Sent: 2022=E5=B9=B45=E6=9C=8830=E6=97=A5 16:50
> > To: Bough Chen <haibo.chen@nxp.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>; Sascha Hauer
> > <s.hauer@pengutronix.de>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Fabio Estevam <festevam@gmail.com>; dl-linux-i=
mx
> > <linux-imx@nxp.com>; linux-iio@vger.kernel.org; Jonathan Cameron
> > <jic23@kernel.org>; Lars-Peter Clausen <lars@metafoo.de>; Baruch Siach
> > <baruch@tkos.co.il>
> > Subject: [PATCH] iio: adc: vf610: fix conversion mode sysfs node name
> >=20
> > The documentation missed the "in_" prefix for this IIO_SHARED_BY_DIR en=
try.
> >=20
> > Fixes: bf04c1a367e3 ("iio: adc: vf610: implement configurable conversion
> > modes")
> > Signed-off-by: Baruch Siach <baruch@tkos.co.il> =20
>=20
> Acked-by: Haibo Chen <haibo.chen@nxp.com>
Applied to the fixes-togreg branch of iio.git

Thanks,

Jonathan

>=20
> > ---
> >  Documentation/ABI/testing/sysfs-bus-iio-vf610 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/ABI/testing/sysfs-bus-iio-vf610
> > b/Documentation/ABI/testing/sysfs-bus-iio-vf610
> > index 308a6756d3bf..491ead804488 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-iio-vf610
> > +++ b/Documentation/ABI/testing/sysfs-bus-iio-vf610
> > @@ -1,4 +1,4 @@
> > -What:		/sys/bus/iio/devices/iio:deviceX/conversion_mode
> > +What:		/sys/bus/iio/devices/iio:deviceX/in_conversion_mode
> >  KernelVersion:	4.2
> >  Contact:	linux-iio@vger.kernel.org
> >  Description:
> > --
> > 2.35.1 =20
>=20

