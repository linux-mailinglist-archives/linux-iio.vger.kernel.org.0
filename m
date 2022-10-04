Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0505F3D89
	for <lists+linux-iio@lfdr.de>; Tue,  4 Oct 2022 09:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiJDH4s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 4 Oct 2022 03:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiJDH4q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 4 Oct 2022 03:56:46 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EEC2CCBA
        for <linux-iio@vger.kernel.org>; Tue,  4 Oct 2022 00:56:43 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id h10so6602216qvq.7
        for <linux-iio@vger.kernel.org>; Tue, 04 Oct 2022 00:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=HW3pXV9AoGtOCcczfQGsv6Gj1OZsXuyRGgZ9uArzuUs=;
        b=XASNVM/wbT2yPGCGxYbh/Y8F6U5JzAjDNhK88QyTUlrr950/cJ6SQyul8TNNPCuV3w
         /IrmWwA4O98PtRNI+6lHt5vXx2uguq/3D0FRRrFOUi9oqVHq2UhnyvvuP2oSTRAD4Svp
         qdiP3l4JjzlKksMTqq24naUkeNZjBw7bEnXzGzYgBPsJtan8rH9/snXuNtnsOOWxTZkt
         7Y4nmBaph6qTiIaSDHTwtorTReGqwLWyRtU3YdS/HLYbv8oIW8GYWfnU7h0C7hQcI+mi
         5w6cyndbdEfHhA7giFJBrBqtQmqmpqImeu7v3dKgU/Hy9g9AJ2qrQ6k04dppLeeg9L7G
         Xbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=HW3pXV9AoGtOCcczfQGsv6Gj1OZsXuyRGgZ9uArzuUs=;
        b=T/t+mDGqcveZmfx1EmcYhBMAxStSUBxlJmLPyeZWp/xAbKSQvs9iBLZCY3r+1U7+6h
         7oR7gIO2WLeSJgBTiz7bDvgz0YKOjXtaqAOizWkrm1fpJmaISMvrzhHp1b47LPf6HYvv
         n8jfHDejFLtlSDeCX3bDFT6s95VZMoVzlp1/s20wHKtnoIxQCURBquf+Jqz6cCMaU14D
         UKtyv5y9hZqABqWdEbrr8Yhx6mqir+2w6ffn95LC7Vn832Kc7a1BxbwXMCYmAbmK719u
         WvuHKrXgYv2kNjjiQ8EYcsBzqGrJaTUMAQ4OXXrYc8NWUY9wgmei/d8BnR3e40Vw2cSF
         hp7A==
X-Gm-Message-State: ACrzQf1Fi/iwz2uZQiqOhcEkjNLCnq6+BUdLaNAx3CTb86j5dIF18FL+
        S08o9ADLCAeHLnVQwa3SwwQ=
X-Google-Smtp-Source: AMsMyM529APgqGNFGmfFPUmzEk+9GtMORRZ8hoc2gqKgPzCIBT8Epimr0+fMS2cqhIsYDJWd1MnqlQ==
X-Received: by 2002:a05:6214:260a:b0:4b1:8b7d:8e78 with SMTP id gu10-20020a056214260a00b004b18b7d8e78mr6607487qvb.5.1664870202256;
        Tue, 04 Oct 2022 00:56:42 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id g9-20020a05620a40c900b006bbe6e89bdcsm14109267qko.31.2022.10.04.00.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 00:56:41 -0700 (PDT)
Message-ID: <3fd3e2116ef355c8136ab3a5d5beaea577e01c19.camel@gmail.com>
Subject: Re: [PATCH 13/15] iio: health: max30100: do not use internal
 iio_dev lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Cixi Geng <cixi.geng1@unisoc.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Fabio Estevam <festevam@gmail.com>,
        Andriy Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Date:   Tue, 04 Oct 2022 09:57:57 +0200
In-Reply-To: <20221002120322.3eba3f24@jic23-huawei>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-14-nuno.sa@analog.com>
         <20220920142319.61557023@xps-13>
         <SJ0PR03MB6778FC7FD469F7C2BC7FB9DB994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <20220920145534.0bdd4e69@xps-13>
         <SJ0PR03MB6778761640C55A5022F40822994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <20220920155305.395dad08@xps-13>
         <1684ca38960d035a0fedd077ed149f524c58f7ff.camel@gmail.com>
         <20220920171033.2f9d6d1f@xps-13> <20220924165318.0cf4403e@jic23-huawei>
         <92a9947072e57194fea22ba3551f7ab097b961da.camel@gmail.com>
         <20221002120322.3eba3f24@jic23-huawei>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 2022-10-02 at 12:03 +0100, Jonathan Cameron wrote:
> On Mon, 26 Sep 2022 12:06:13 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Sat, 2022-09-24 at 16:53 +0100, Jonathan Cameron wrote:
> > > On Tue, 20 Sep 2022 17:10:33 +0200
> > > Miquel Raynal <miquel.raynal@bootlin.com> wrote:
> > > =C2=A0=20
> > > > Hi Nuno,
> > > >=20
> > > > noname.nuno@gmail.com=C2=A0wrote on Tue, 20 Sep 2022 16:56:01 +0200=
:
> > > > =C2=A0=20
> > > > > On Tue, 2022-09-20 at 15:53 +0200, Miquel Raynal wrote:=C2=A0=C2=
=A0=C2=A0=20
> > > > > > Hi Nuno,
> > > > > >=20
> > > > > > Nuno.Sa@analog.com=C2=A0wrote on Tue, 20 Sep 2022 13:15:32
> > > > > > +0000:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > -----Original Message-----
> > > > > > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > > > Sent: Tuesday, September 20, 2022 2:56 PM
> > > > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > > > Cc: linux-arm-kernel@lists.infradead.org;
> > > > > > > > linux-rockchip@lists.infradead.org;
> > > > > > > > linux-amlogic@lists.infradead.org; linux-imx@nxp.com;
> > > > > > > > linux-
> > > > > > > > iio@vger.kernel.org; Chunyan Zhang
> > > > > > > > <zhang.lyra@gmail.com>;
> > > > > > > > Hennerich,
> > > > > > > > Michael <Michael.Hennerich@analog.com>; Martin
> > > > > > > > Blumenstingl
> > > > > > > > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > > > > > > > <s.hauer@pengutronix.de>; Cixi Geng
> > > > > > > > <cixi.geng1@unisoc.com>;
> > > > > > > > Kevin
> > > > > > > > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy
> > > > > > > > <vz@mleia.com>;
> > > > > > > > Pengutronix Kernel Team <kernel@pengutronix.de>;
> > > > > > > > Alexandru
> > > > > > > > Ardelean
> > > > > > > > <aardelean@deviqon.com>; Fabio Estevam
> > > > > > > > <festevam@gmail.com>;
> > > > > > > > Andriy
> > > > > > > > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>;
> > > > > > > > Haibo
> > > > > > > > Chen
> > > > > > > > <haibo.chen@nxp.com>; Shawn Guo <shawnguo@kernel.org>;
> > > > > > > > Hans
> > > > > > > > de
> > > > > > > > Goede <hdegoede@redhat.com>; Jerome Brunet
> > > > > > > > <jbrunet@baylibre.com>;
> > > > > > > > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > > > > > > > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > > > > > > > <Ciprian.Regus@analog.com>; Lars-Peter Clausen
> > > > > > > > <lars@metafoo.de>;
> > > > > > > > Andy
> > > > > > > > Shevchenko <andy.shevchenko@gmail.com>; Jonathan
> > > > > > > > Cameron
> > > > > > > > <jic23@kernel.org>; Neil Armstrong
> > > > > > > > <narmstrong@baylibre.com>;
> > > > > > > > Baolin
> > > > > > > > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > > > > > > > <jbhayana@google.com>; Chen-Yu Tsai <wens@csie.org>;
> > > > > > > > Orson
> > > > > > > > Zhai
> > > > > > > > <orsonzhai@gmail.com>
> > > > > > > > Subject: Re: [PATCH 13/15] iio: health: max30100: do
> > > > > > > > not
> > > > > > > > use
> > > > > > > > internal iio_dev
> > > > > > > > lock
> > > > > > > >=20
> > > > > > > > [External]
> > > > > > > >=20
> > > > > > > > Hi Nuno,
> > > > > > > >=20
> > > > > > > > Nuno.Sa@analog.com=C2=A0wrote on Tue, 20 Sep 2022 12:44:08
> > > > > > > > +0000:
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > -----Original Message-----
> > > > > > > > > > From: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > > > > > > Sent: Tuesday, September 20, 2022 2:23 PM
> > > > > > > > > > To: Sa, Nuno <Nuno.Sa@analog.com>
> > > > > > > > > > Cc: linux-arm-kernel@lists.infradead.org; linux-
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > rockchip@lists.infradead.org;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > > > > linux-amlogic@lists.infradead.org;
> > > > > > > > > > linux-imx@nxp.com;
> > > > > > > > > > linux-
> > > > > > > > > > iio@vger.kernel.org; Chunyan Zhang
> > > > > > > > > > <zhang.lyra@gmail.com>;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=20
> > > > > > > > Hennerich,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > Michael <Michael.Hennerich@analog.com>; Martin
> > > > > > > > > > Blumenstingl
> > > > > > > > > > <martin.blumenstingl@googlemail.com>; Sascha Hauer
> > > > > > > > > > <s.hauer@pengutronix.de>; Cixi Geng
> > > > > > > > > > <cixi.geng1@unisoc.com>;
> > > > > > > > > > Kevin
> > > > > > > > > > Hilman <khilman@baylibre.com>; Vladimir Zapolskiy
> > > > > > > > > > <vz@mleia.com>;
> > > > > > > > > > Pengutronix Kernel Team <kernel@pengutronix.de>;
> > > > > > > > > > Alexandru=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > Ardelean=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > <aardelean@deviqon.com>; Fabio Estevam
> > > > > > > > > > <festevam@gmail.com>;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > > > > > > Andriy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > Tryshnivskyy <andriy.tryshnivskyy@opensynergy.com>;
> > > > > > > > > > Haibo
> > > > > > > > > > Chen
> > > > > > > > > > <haibo.chen@nxp.com>; Shawn Guo
> > > > > > > > > > <shawnguo@kernel.org>;
> > > > > > > > > > Hans
> > > > > > > > > > de
> > > > > > > > > > Goede <hdegoede@redhat.com>; Jerome Brunet=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > <jbrunet@baylibre.com>;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > > > Heiko Stuebner <heiko@sntech.de>; Florian Boor
> > > > > > > > > > <florian.boor@kernelconcepts.de>; Regus, Ciprian
> > > > > > > > > > <Ciprian.Regus@analog.com>; Lars-Peter Clausen
> > > > > > > > > > <lars@metafoo.de>;=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > Andy=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > Shevchenko <andy.shevchenko@gmail.com>; Jonathan
> > > > > > > > > > Cameron
> > > > > > > > > > <jic23@kernel.org>; Neil Armstrong
> > > > > > > > > > <narmstrong@baylibre.com>;
> > > > > > > > > > Baolin
> > > > > > > > > > Wang <baolin.wang@linux.alibaba.com>; Jyoti Bhayana
> > > > > > > > > > <jbhayana@google.com>; Chen-Yu Tsai
> > > > > > > > > > <wens@csie.org>;
> > > > > > > > > > Orson
> > > > > > > > > > Zhai
> > > > > > > > > > <orsonzhai@gmail.com>
> > > > > > > > > > Subject: Re: [PATCH 13/15] iio: health: max30100:
> > > > > > > > > > do
> > > > > > > > > > not use
> > > > > > > > > > internal=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > iio_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > lock
> > > > > > > > > >=20
> > > > > > > > > > [External]
> > > > > > > > > >=20
> > > > > > > > > > Hi Nuno,
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > Hi Miquel,
> > > > > > > > >=20
> > > > > > > > > Thanks for reviewing...
> > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > nuno.sa@analog.com=C2=A0wrote on Tue, 20 Sep 2022
> > > > > > > > > > 13:28:19
> > > > > > > > > > +0200:
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > The pattern used in this device does not quite
> > > > > > > > > > > fit in
> > > > > > > > > > > the
> > > > > > > > > > > iio_device_claim_direct_mode() typical usage. In
> > > > > > > > > > > this
> > > > > > > > > > > case,
> > > > > > > > > > > iio_buffer_enabled() was being used not to
> > > > > > > > > > > prevent
> > > > > > > > > > > the raw
> > > > > > > > > > > access but=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > to=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > allow it. Hence to get rid of the 'mlock' we need
> > > > > > > > > > > to:
> > > > > > > > > > >=20
> > > > > > > > > > > 1. Use iio_device_claim_direct_mode() to check if
> > > > > > > > > > > direct
> > > > > > > > > > > mode can be
> > > > > > > > > > > claimed and if we can return -EINVAL (as the
> > > > > > > > > > > original
> > > > > > > > > > > code);
> > > > > > > > > > >=20
> > > > > > > > > > > 2. Make sure that buffering is not disabled while
> > > > > > > > > > > doing a
> > > > > > > > > > > raw read. For
> > > > > > > > > > > that, we can make use of the local lock that
> > > > > > > > > > > already
> > > > > > > > > > > exists.
> > > > > > > > > > >=20
> > > > > > > > > > > While at it, fixed a minor coding style
> > > > > > > > > > > complain...
> > > > > > > > > > >=20
> > > > > > > > > > > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> > > > > > > > > > > ---
> > > > > > > > > > > =C2=A0drivers/iio/health/max30100.c | 24
> > > > > > > > > > > +++++++++++++++++------
> > > > > > > > > > > -
> > > > > > > > > > > =C2=A01 file changed, 17 insertions(+), 7 deletions(-=
)
> > > > > > > > > > >=20
> > > > > > > > > > > diff --git a/drivers/iio/health/max30100.c=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> > > > > > > > b/drivers/iio/health/max30100.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > > > > > > > > > index ad5717965223..aa494cad5df0 100644
> > > > > > > > > > > --- a/drivers/iio/health/max30100.c
> > > > > > > > > > > +++ b/drivers/iio/health/max30100.c
> > > > > > > > > > > @@ -185,8 +185,19 @@ static int
> > > > > > > > > > > max30100_buffer_postenable(struct=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > iio_dev *indio_dev)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=20
> > > > > > > > > > > =C2=A0static int max30100_buffer_predisable(struct
> > > > > > > > > > > iio_dev
> > > > > > > > > > > *indio_dev)
> > > > > > > > > > > =C2=A0{
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struc=
t max30100_data *data =3D
> > > > > > > > > > > iio_priv(indio_dev);
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int ret;
> > > > > > > > > > > +
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * As stat=
ed in the comment in the
> > > > > > > > > > > read_raw()
> > > > > > > > > > > function, temperature
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can onl=
y be acquired if the engine is
> > > > > > > > > > > running.
> > > > > > > > > > > As such the mutex
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is used=
 to make sure we do not power
> > > > > > > > > > > down
> > > > > > > > > > > while
> > > > > > > > > > > doing a=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > temperature=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * reading=
.
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock=
(&data->lock);
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D ma=
x30100_set_powermode(data,
> > > > > > > > > > > false);
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_unlo=
ck(&data->lock);
> > > > > > > > > > >=20
> > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return max=
30100_set_powermode(data,
> > > > > > > > > > > false);
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return ret=
;
> > > > > > > > > > > =C2=A0}
> > > > > > > > > > >=20
> > > > > > > > > > > =C2=A0static const struct iio_buffer_setup_ops
> > > > > > > > > > > max30100_buffer_setup_ops=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=20
> > > > > > > > =3D {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > > @@ -387,18 +398,17 @@ static int
> > > > > > > > > > > max30100_read_raw(struct
> > > > > > > > > > > iio_dev=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > > *indio_dev,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=20
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Temperature reading can onl=
y
> > > > > > > > > > > be
> > > > > > > > > > > acquired
> > > > > > > > > > > while engine
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * is running
> > > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mutex_lock(&indio_dev->mlock);
> > > > > > > > > > > -
> > > > > > > > > > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if
> > > > > > > > > > > (!iio_buffer_enabled(indio_dev))
> > > > > > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if
> > > > > > > > > > > (!iio_device_claim_direct_mode(indio_dev))
> > > > > > > > > > > {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > > >=20
> > > > > > > > > > I wonder if this line change here is really needed.
> > > > > > > > > > I
> > > > > > > > > > agree
> > > > > > > > > > the whole
> > > > > > > > > > construction looks like what
> > > > > > > > > > iio_device_claim_direct_mode()
> > > > > > > > > > does but in
> > > > > > > > > > practice I don't see the point of acquiring any
> > > > > > > > > > lock
> > > > > > > > > > here if
> > > > > > > > > > we just
> > > > > > > > > > release it no matter what happens right after.
> > > > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > > >=20
> > > > > > > > > I can see that this is odd (at the very least) but
> > > > > > > > > AFAIK,
> > > > > > > > > this
> > > > > > > > > is the only way
> > > > > > > > > to safely infer if buffering is enabled or not.
> > > > > > > > > iio_buffer_enabled() has no
> > > > > > > > > protection against someone concurrently
> > > > > > > > > enabling/disabling the
> > > > > > > > > buffer.=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > > >=20
> > > > > > > > Yes, but this is only relevant if you want to infer
> > > > > > > > that
> > > > > > > > the
> > > > > > > > "buffers
> > > > > > > > are enabled" and be sure that it cannot be otherwise
> > > > > > > > during
> > > > > > > > the
> > > > > > > > next
> > > > > > > > lines until you release the lock. Acquiring a lock,
> > > > > > > > doing
> > > > > > > > the if
> > > > > > > > and
> > > > > > > > then unconditionally releasing the lock, IMHO, does not
> > > > > > > > make any
> > > > > > > > sense
> > > > > > > > (but I'm not a locking guru) because when you enter the
> > > > > > > > else
> > > > > > > > clause,
> > > > > > > > you are not protected anyway, so in both cases all this
> > > > > > > > is
> > > > > > > > completely
> > > > > > > > racy.
> > > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > > >=20
> > > > > > > Ahh crap, yes you are right... It is still racy since we
> > > > > > > can
> > > > > > > still
> > > > > > > try to read
> > > > > > > the temperature with the device powered off. I'm not
> > > > > > > really
> > > > > > > sure
> > > > > > > how to
> > > > > > > address this. One way could be to just use an internal
> > > > > > > control
> > > > > > > variable
> > > > > > > to reflect the device power state (set/clear on the
> > > > > > > buffer
> > > > > > > callbacks) and
> > > > > > > only use the local lock (completely ditching the call to
> > > > > > > iio_device_claim_direct_mode())...=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=20
> > > > > >=20
> > > > > > I tend to prefer this option than the one below.
> > > > > >=20
> > > > > > I guess your implementation already prevents
> > > > > > buffer_predisable() to
> > > > > > run
> > > > > > thanks to the local lock being held during the operation.
> > > > > > Maybe
> > > > > > we
> > > > > > should just verify that buffers are enabled from within the
> > > > > > local
> > > > > > lock
> > > > > > being held instead of just acquiring it for the get_temp()
> > > > > > measure.
> > > > > > It
> > > > > > would probably solve the situation here.=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=20
> > > > > Not sure if I understood... You mean something like:
> > > > >=20
> > > > > mutex_lock(&data->lock);
> > > > > if (!iio_buffer_enabled(indio_dev)) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> > > > > } else {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D max30100_=
get_temp(data, val);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D IIO_VAL_INT;
> > > > >=20
> > > > > }
> > > > > mutex_unlock(&data->lock);
> > > > >=20
> > > > > If so, I think this is still racy since we release the lock
> > > > > after
> > > > > the
> > > > > predisable which means we could still detect the buffers as
> > > > > enabled (in
> > > > > the above block) and try to get_temp on a powered down
> > > > > device.=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > True.
> > > > =C2=A0=20
> > > > >=20
> > > > > Since we pretty much only care about the power state of the
> > > > > device (and
> > > > > we are using the buffering state to infer that AFAIU), I was
> > > > > thinking
> > > > > in something like:
> > > > >=20
> > > > >=20
> > > > > mutex_lock(&data->lock);
> > > > > if (!data->powered) {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D -EINVAL;
> > > > > } else {
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D max30100_=
get_temp(data, val);
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ret)
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret =3D IIO_VAL_INT;
> > > > >=20
> > > > > }
> > > > > mutex_unlock(&data->lock);=C2=A0=C2=A0=C2=A0=20
> > > >=20
> > > > LGTM.=C2=A0=20
> > >=20
> > > A reference counted power up flag would probably work as we'd
> > > want to
> > > disable
> > > power only when the reference count goes to 0.=C2=A0 Note all checks
> > > of
> > > that flag
> > > would need to be done under the lock as well.
> > > =C2=A0=20
> >=20
> > Is there any way to enable a buffer more than once? Otherwise I'm
> > not
> > sure we really need a refcount... Any ways, your below approach
> > looks
> > good to me and surely easier.
>=20
> Indeed can only have the buffer enabled once, but there may be a race
> with the disable of the buffer and this path. Hence need a ref count
> to detect when the count goes to zero, what ever the reason.
> A flag only covers one side of the race.
>=20
> > >=20
Sure, but I would "secure" it with the same lock on 'data->lock' and
the flag setting would be obviously under that lock (same on the
postenable side of things). IMO, I don't think we need to that far as
using refcounts in here. Anyways, I will give a try to the suggestion
you made in the other patch.

- Nuno S=C3=A1
> >=20
