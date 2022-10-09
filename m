Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE5075F8AFF
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 13:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiJILwB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 07:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiJILwA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 07:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D7E02CDE1
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 04:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A31560B92
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 11:51:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E14DC433C1;
        Sun,  9 Oct 2022 11:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665316318;
        bh=dbV8fl4e8RfgF35OuOILn9qLI5jumdgLtDq0/jL8jqg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qJZZ0O+Ox8ThRYC0eGOb0eeh/fsM5cmq+45tkQXUM6OBDIVd7f3xvEWqxgDeC+FdU
         TQTqWoLXrl15Zchs28pICXXELElrogWImAiB6vi4OTHFlRf4WW1IHjh0Pi4IUuQtYZ
         dLFePSJP5ePzD/k5kS4PysiQGhFmwAu5i/rYujH1e7sgYXBU/F4OzjwWgIc6mPdDnk
         B/lng4UMNgs3xATKc+begkH3dMLdBFHCP+2jqyqN+/YdVp80E6LAKwetZXQ3FeSvym
         BZrmmbr9QGLYyfSvHyVXsgwuqCgR3sN2We1MyMkVAuCXSplFAjZOA5L/E9p5r5yxHM
         QG8BmSxOAEi/w==
Date:   Sun, 9 Oct 2022 12:52:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
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
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct
 iio_dev_opaque'
Message-ID: <20221009125214.3da1dc89@jic23-huawei>
In-Reply-To: <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-17-nuno.sa@analog.com>
        <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com>
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

On Tue, 4 Oct 2022 17:21:20 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
> >
> > Now that there are no more users accessing 'mlock' directly, we can move
> > it to the iio_dev private structure. Hence, it's now explicit that new
> > driver's should not directly this lock. =20
>=20
> use this
>=20
>=20
> I like the end result!
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Hi Andy,

Just to check, just this patch, or series (where you haven't commented?)

I'm going to queue this series up piecewise just because it's fairly
big and most of it is completely non controversial!  So for now I've
not applied your RB, but can do so before I push out as anything non
rebasing (which I won't do until after the merge window).

Thanks,

Jonathan
