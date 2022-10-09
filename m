Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DE25F8B1B
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiJIMKd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiJIMKc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:10:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8EE23BCE
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3B92860BC7
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F614C433D6;
        Sun,  9 Oct 2022 12:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317430;
        bh=ZeIrQu9oB0CDR0Z9aoiHCQq9wYylwX/q/3WhMIMNbJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eoAuPCL6ltefEACMxNzHCx4dRc/nLGvz82fV/q00356YmopaWTlUMndjUr9i5i44g
         H+YC9zYA2bQbAcX0l9I332sGYiNbXb4L3IAFXRlSp7ZlphCJWyKm+BDbc84wM2IIiF
         6wrbcw9cjHlbh6sXqBJJsDCEak95+8G5wveeaMxdcO1UY+kNeZAABjg85HmaoPYZ3Y
         YismVVqATjPiAjCXDD2dzPsTBu+aS535N3fbW89Xstj8jgVXECzMDNIv9H9WqsKIbz
         iX0v22JiKhIwFB0Vi5jA2MmGZjl0HZdI0clDijllDP0D1ScmJHXSzbUrgO/XW2CAFk
         og3U0Z7VHYf8g==
Date:   Sun, 9 Oct 2022 13:10:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Cc:     <linux-amlogic@lists.infradead.org>, <linux-imx@nxp.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
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
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 12/16] iio: gyro: itg3200_core: do not use internal
 iio_dev lock
Message-ID: <20221009131046.3f55c691@jic23-huawei>
In-Reply-To: <20221004134909.1692021-13-nuno.sa@analog.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-13-nuno.sa@analog.com>
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

On Tue, 4 Oct 2022 15:49:05 +0200
Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.
>=20
> While at it, properly include "mutex.h" for mutex related APIs.
>=20
> Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
Applied, but only pushed out as testing (which will be rebased)
until after rc1.

Jonathan
