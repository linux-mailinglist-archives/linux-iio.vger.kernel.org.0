Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22356550653
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jun 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234336AbiFRRVn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jun 2022 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiFRRVm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Jun 2022 13:21:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA0140CF;
        Sat, 18 Jun 2022 10:21:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17596B80A72;
        Sat, 18 Jun 2022 17:21:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41652C3411A;
        Sat, 18 Jun 2022 17:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655572894;
        bh=s9rzUJH1dCU78egHZ+iIG03v6Lj+ion9PzSseqxJCFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mLbJ4PLP002IFIyUS/mFXkt7VRPo37gj1dl2UgXLay+Jd+5DxzlSRZxjCKSQfzLtm
         w4ERJv/y4Vtvf+zMWg/hqpOjfO75ncGomxEsmRBeblvqyljZF/cJ0Ghsf1i8AkvVYy
         CTfCUKo5VD9g1SiBv2jluSBhogu0x0nNfUVOBKIfVg9HtAQUAAfDJ/p33a5g0kx2kd
         QlWaytpoO91OuQliAYmBYJC3yq5N6Q8XpHivXx5gTE7c7v/ixy3a9u9FLFcZpTIv8D
         BUJ5TsJBVILC9zkvhKEqh4bM/awT4sH6gM4Y9KEH1IVSYXTDyOvr87C/r8rkSapHHo
         AwM2FiuCayWcQ==
Date:   Sat, 18 Jun 2022 18:30:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-imx@nxp.com>, <linux-renesas-soc@vger.kernel.org>,
        <linux-mips@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <chrome-platform@lists.linux.dev>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <linux-mediatek@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <openbmc@lists.ozlabs.org>, Cai Huoqing <cai.huoqing@linux.dev>,
        Benjamin Fair <benjaminfair@google.com>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Benson Leung <bleung@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Christophe Branchereau <cbranchereau@gmail.com>,
        Patrick Venture <venture@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Nancy Yuen <yuenn@google.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Avi Fishman <avifishman70@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Fabio Estevam <festevam@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH 20/34] iio: inkern: only relase the device node when
 done with it
Message-ID: <20220618183040.29ed935d@jic23-huawei>
In-Reply-To: <20220610084545.547700-21-nuno.sa@analog.com>
References: <20220610084545.547700-1-nuno.sa@analog.com>
        <20220610084545.547700-21-nuno.sa@analog.com>
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

On Fri, 10 Jun 2022 10:45:31 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

Typo in patch title (just noticed whilst scrolling past)

release


> 'of_node_put()' can potentially release the memory pointed to by
> 'iiospec.np' which would leave us with an invalid pointer (and we would
> still pass it in 'of_xlate()'). As such, we can only release the node
> after we are done with it.
>=20
> Fixes: 17d82b47a215d ("iio: Add OF support")
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> ---
>  drivers/iio/inkern.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index df74765d33dc..9d87057794fc 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -165,9 +165,10 @@ static int __of_iio_channel_get(struct iio_channel *=
channel,
> =20
>  	idev =3D bus_find_device(&iio_bus_type, NULL, iiospec.np,
>  			       iio_dev_node_match);
> -	of_node_put(iiospec.np);
> -	if (idev =3D=3D NULL)
> +	if (idev =3D=3D NULL) {
> +		of_node_put(iiospec.np);
>  		return -EPROBE_DEFER;
> +	}
> =20
>  	indio_dev =3D dev_to_iio_dev(idev);
>  	channel->indio_dev =3D indio_dev;
> @@ -175,6 +176,7 @@ static int __of_iio_channel_get(struct iio_channel *c=
hannel,
>  		index =3D indio_dev->info->of_xlate(indio_dev, &iiospec);
>  	else
>  		index =3D __of_iio_simple_xlate(indio_dev, &iiospec);
> +	of_node_put(iiospec.np);
>  	if (index < 0)
>  		goto err_put;
>  	channel->channel =3D &indio_dev->channels[index];

