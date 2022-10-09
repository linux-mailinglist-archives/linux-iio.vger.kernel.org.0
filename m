Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4BF75F8B0B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJIMDn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiJIMDm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A31BEA2
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:03:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4480A60BD6
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:03:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F0CC433C1;
        Sun,  9 Oct 2022 12:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317020;
        bh=88Rrz7WpjK2fu1HAcpETvoy2xqJPXiF5srquZwunYeI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Uq9ksDB2qZt2bV9yy5F48OZqiKPE2TbQRFycqSn2xVmB6y6zcD//xlKUxZijeOuT2
         rRJdjQe6/J9yLCgtcPSC3yuY+Uz5OD86RCaTSEa6SmkjFjoz4jDBk2v8THP/e+h/b8
         q/sNzbwgmQ5hWXGlzXqbABz46cP2vxVzPidhQ9AN4W5W4aqFRSIF5I5tE7hEsICYER
         xLcBaZ9S0C6+02s1Y+7NgQZG+tRU6MrLxEb9xPN1SiOlfantpTCLs11g2qrFvGJQ11
         zVxaZoC2/wxaL8ebV2U+F4MNIQiBNTXfjglc/6CPLk6Qo3dx9RZ+7tR8peKR2s5Vt4
         25m/EP/1Wxfdg==
Date:   Sun, 9 Oct 2022 13:03:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
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
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 07/16] iio: adc: rockchip_saradc: do not use internal
 iio_dev lock
Message-ID: <20221009130153.794f404a@jic23-huawei>
In-Reply-To: <1803833.atdPhlSkOF@diego>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-8-nuno.sa@analog.com>
        <1803833.atdPhlSkOF@diego>
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

On Wed, 05 Oct 2022 09:44:37 +0200
Heiko St=C3=BCbner <heiko@sntech.de> wrote:

> Am Dienstag, 4. Oktober 2022, 15:49:00 CEST schrieb Nuno S=C3=A1:
> > The iio_device lock is only meant for internal use. Hence define a
> > device local lock to protect against concurrent accesses.
> >=20
> > While at it, properly include "mutex.h" for mutex related APIs.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com> =20
>=20
> Acked-by: Heiko Stuebner <heiko@sntech.de>
>=20
>=20
Applied and pushed out as testing. Note I'll be rebasing on rc1 once availa=
ble.

Thanks,

Jonathan

