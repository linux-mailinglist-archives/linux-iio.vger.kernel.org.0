Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 213F85F8B03
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiJIL4r (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiJIL4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:56:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BB527FD6
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:56:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BBD4B80C69
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:56:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D55AC433C1;
        Sun,  9 Oct 2022 11:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316602;
        bh=JuwAGyYUq+0tY/jXJqv6WkGInPS/MccBTwHv0B2XuPo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Jr7eFuNqvfRqmwaBri6OAi3LG/0ExX+msNdFrzzW6sJRFzZZQGSUy34t2cyJW8F++
         0h5aJK4KAP16xCcUqsCO+qtmkBqzAxGRtlxEMb5gMm5vKLo84+wyibmn5/slZW5MvO
         P0NHgX1exk3kb4ObHRGRaB6Rt9gZCvwaMPDdz5LZVDVYlsJh1ECzP2spUyDRdnkUxb
         Wz+QDhVX3vCUkLpAuMqhKvmEuRSaiSUCAVpP8BGPkPqel4JAEBYwhEPPDV8E4Cd8th
         8bd/LCcIRqF+6/LCKzp7BFNyF3SqVWnFm4BTBF8xdn6jP6/RA6MP5gTtgL8v1VCihC
         Bf16hOHMV10wQ==
Date:   Sun, 9 Oct 2022 12:56:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bough Chen <haibo.chen@nxp.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jyoti Bhayana <jbhayana@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Ciprian Regus <ciprian.regus@analog.com>,
        Fabio Estevam <festevam@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Orson Zhai <orsonzhai@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 03/16] iio: adc: imx7d_adc: do not use internal
 iio_dev lock
Message-ID: <20221009125658.7ad8e57d@jic23-huawei>
In-Reply-To: <DB7PR04MB4010D3A27C8C6FAF87187F4690219@DB7PR04MB4010.eurprd04.prod.outlook.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-4-nuno.sa@analog.com>
        <DB7PR04MB4010D3A27C8C6FAF87187F4690219@DB7PR04MB4010.eurprd04.prod.outlook.com>
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

On Sun, 9 Oct 2022 02:00:22 +0000
Bough Chen <haibo.chen@nxp.com> wrote:

> > -----Original Message-----
> > From: Nuno S=C3=A1 <nuno.sa@analog.com>
> > Sent: 2022=E5=B9=B410=E6=9C=884=E6=97=A5 21:49
> > To: linux-amlogic@lists.infradead.org; dl-linux-imx <linux-imx@nxp.com>;
> > linux-iio@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > linux-rockchip@lists.infradead.org
> > Cc: Heiko Stuebner <heiko@sntech.de>; Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com>; Neil Armstrong
> > <narmstrong@baylibre.com>; Shawn Guo <shawnguo@kernel.org>; Lars-Peter
> > Clausen <lars@metafoo.de>; Jyoti Bhayana <jbhayana@google.com>; Hans de
> > Goede <hdegoede@redhat.com>; Andriy Tryshnivskyy
> > <andriy.tryshnivskyy@opensynergy.com>; Pengutronix Kernel Team
> > <kernel@pengutronix.de>; Miquel Raynal <miquel.raynal@bootlin.com>; Cixi
> > Geng <cixi.geng1@unisoc.com>; Baolin Wang
> > <baolin.wang@linux.alibaba.com>; Ciprian Regus <ciprian.regus@analog.co=
m>;
> > Fabio Estevam <festevam@gmail.com>; Nuno S=C3=A1 <nuno.sa@analog.com>;
> > Sascha Hauer <s.hauer@pengutronix.de>; Alexandru Ardelean
> > <aardelean@deviqon.com>; Florian Boor <florian.boor@kernelconcepts.de>;
> > Michael Hennerich <Michael.Hennerich@analog.com>; Orson Zhai
> > <orsonzhai@gmail.com>; Chen-Yu Tsai <wens@csie.org>; Chunyan Zhang
> > <zhang.lyra@gmail.com>; Vladimir Zapolskiy <vz@mleia.com>; Andy
> > Shevchenko <andy.shevchenko@gmail.com>; Jerome Brunet
> > <jbrunet@baylibre.com>; Bough Chen <haibo.chen@nxp.com>; Kevin Hilman
> > <khilman@baylibre.com>; Jonathan Cameron <jic23@kernel.org>
> > Subject: [PATCH v2 03/16] iio: adc: imx7d_adc: do not use internal iio_=
dev lock
> >=20
> > The iio_device lock is only meant for internal use. Hence define a devi=
ce local
> > lock to protect against concurrent accesses.
> >=20
> > While at it, properly include "mutex.h" for mutex related APIs.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Note I'll be rebasing on rc1 once available.

Thanks,

Jonathan
