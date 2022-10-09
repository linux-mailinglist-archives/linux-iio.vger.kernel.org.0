Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860245F8B1D
	for <lists+linux-iio@lfdr.de>; Sun,  9 Oct 2022 14:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJIMOP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 9 Oct 2022 08:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbiJIMOO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2022 08:14:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B92409A
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 05:14:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F0255B80D29
        for <linux-iio@vger.kernel.org>; Sun,  9 Oct 2022 12:14:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D8BC433C1;
        Sun,  9 Oct 2022 12:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665317650;
        bh=xR/Gp7PyBo7b3uBk2sbadg7hX39s/vl2ucN0GSLqPxE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A9c0L3QXW/L78kLL4XQj9+faQbQXJqXinFWYtp16nO8DMWuWIlhQgqWT52v/2uTZQ
         lbKFciJ0lkIBcnzW0/s3qdPe5RIH4n/ICPi4MFBVbmpJ6WmuiyswwSbXYK7H1iwdvE
         xxveysjo0uag6C/e06S1pzPQ/iVneXFgCjNDNbmw3qp+oHBJiDrpD0zfh5Q8w3yxhE
         dfStRqqiiRISQgB2YYR1q4uOO+jvlVT/Thvo+LQfXicRJBAwTSKKoTiRugjlxudRSk
         7J9EmFOeZ6eP3l+96Eh2E3LY2178AsgkrjwMOguKP3pWewUUl1Tsx0griMAUVsKeAG
         PwXB5c6wZNsLA==
Date:   Sun, 9 Oct 2022 13:14:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
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
Subject: Re: [PATCH v2 14/16] iio: health: max30100: do not use internal
 iio_dev lock
Message-ID: <20221009131426.77f4697f@jic23-huawei>
In-Reply-To: <0bad9d1ef45d0a85b7d25a4ee50914ea93936bb2.camel@gmail.com>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
        <20221004134909.1692021-15-nuno.sa@analog.com>
        <CAHp75Vfv4BntoDPOo_MXZ33dVEKYj1KW_Ocd5QL_Ez06HJ33iw@mail.gmail.com>
        <0bad9d1ef45d0a85b7d25a4ee50914ea93936bb2.camel@gmail.com>
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

On Wed, 05 Oct 2022 10:09:29 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Tue, 2022-10-04 at 17:13 +0300, Andy Shevchenko wrote:
> > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:=
 =20
> > >=20
> > > The pattern used in this device does not quite fit in the
> > > iio_device_claim_direct_mode() typical usage. In this case,
> > > iio_buffer_enabled() was being used not to prevent the raw access
> > > but to
> > > allow it. Hence, let's make use of the new
> > > iio_device_claim_buffer_mode() API to make sure we stay in buffered
> > > mode
> > > during the complete read. =20
> >=20
> > ...
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 if (iio_device_claim_buffer_mode(indio_dev)) {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D -EAGAIN; =20
> >=20
> > Why is the error code shadowed? Isn't it better to return exactly the
> > one you resend to the upper caller(s)? Each unclear error code
> > shadowing should be at least explained. =20
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } =20
>=20
> I'm keeping the same error that was returned before. Changing the error
> code returned to userspace can break some apps relying on it. But if
> everyone is ok with assuming the risk and changing it, fine by me.

Hmm. For most drivers I'd say change it, but these weird health parts
use a highly custom userspace so it's just possible we'd break it
by changing the return code.  Unfortunately I don't know of anyone with cur=
rent
access to the code of that software stack to check this for us as
there have been a lot of changes at TI in recent years.

So probably best to leave it alone, but add a comment to the patch descript=
ion
to give reasoning.

Thanks,

Jonathan

>=20
>=20
> - Nuno S=C3=A1

