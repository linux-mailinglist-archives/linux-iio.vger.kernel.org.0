Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E529B5BE747
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiITNkH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiITNjz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:39:55 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799F527DD3
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:39:53 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id w4so2024375qvp.2
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=x27NWvYktqlnusyS/qm9PNgdsudNh50YHSIrIUi9m8s=;
        b=YEZRyS/mExig2KaV4RW4O5SenkKekfz/I/LZ4vkqtmJhA72WWTImL0KtR8QYpFJC/w
         4u5cANeaCnvpFM4IKoJHVFsaRgDrjBH+g1wWpECPZ6Eu/rk6V+cE+Nq8HNeWTLhmZ6OJ
         nKvNU9UjcqkWtvEgECdo0swBarERO65UAbYsso8N2s+hjQKAS295pQW3niA5Ufil7JvQ
         1I+HbPBGEubUeriW22gHYnwDPM5cwW9tML19PeF7QpP2wGFUW7udSCBVFytHOF4uYjND
         wsDItVWu399GdaVXG5bcCDI9XysgPN6oooRmqx7vTvfDYAvrq9p6A3+Xm9qt3k1X5QQc
         THlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x27NWvYktqlnusyS/qm9PNgdsudNh50YHSIrIUi9m8s=;
        b=yjMntENWvDCitGPJD2e0g6hN+xbilp8Uke/ZJsTRygZD3mBgDyYhglmGi6+A+9o+IF
         JkMy1MRxKKN9BoN/Dn5Jv5FDlH/wJd5D/yzUxE+q73Qv3G8CDdERGBk6JXb6UrwCcbWQ
         m7D9sWyzmupBqvzJiO9lm8DWkaT0cXinbFNsNFKi522hMCNeGF7USbv0P3VN4A8k98Tb
         xmVmt7tRS7SozqSki4Kspq/uHOCloNycUKbU2bfOtjIE/bhqFqkIvUxuPlL+09NdZ4XZ
         wdAWDejr/94IIXeA5D80UW4OXMX3iOPnYebxk9wI1p4zLuSwQQTJS4bBNTt8RMCf6ipb
         TSCg==
X-Gm-Message-State: ACrzQf3EP3IsoQ3vbcSQCSumJQhVcopv+Yp7QIJyBT9KA8i8mppsFJf8
        E6jByevm0YOJW+xbGtnvFJBHkcMjBhimMEGjt3U=
X-Google-Smtp-Source: AMsMyM5C+z2L7ENi+SWLvx55m0PRFwxKoEZfjPSxoLQ70jW3kb3UuOMOpiUDttlB9lpgAQ5Ayl1c1mbvthu4A5c70sA=
X-Received: by 2002:a05:6214:19cf:b0:4a9:4241:2399 with SMTP id
 j15-20020a05621419cf00b004a942412399mr18751591qvc.64.1663681192253; Tue, 20
 Sep 2022 06:39:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220920112821.975359-1-nuno.sa@analog.com> <20220920112821.975359-4-nuno.sa@analog.com>
 <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
 <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
In-Reply-To: <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Sep 2022 16:39:16 +0300
Message-ID: <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev lock
To:     "Sa, Nuno" <Nuno.Sa@analog.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
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
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Florian Boor <florian.boor@kernelconcepts.de>,
        "Regus, Ciprian" <Ciprian.Regus@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Jyoti Bhayana <jbhayana@google.com>,
        Chen-Yu Tsai <wens@csie.org>, Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Sep 20, 2022 at 4:37 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, Sep 20, 2022 at 4:18 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1 <nuno.sa@analog.com> wro=
te:

...

> > > >         info =3D iio_priv(indio_dev);
> > > > +       mutex_init(&info->lock);
> > > >         info->irq =3D platform_get_irq(pdev, 0);
> > > >         if (info->irq < 0)
> > > >                 return info->irq;
> > >
> > > Consider initializing it as late as possible, like after IRQ retrieva=
l
> > > in this context (maybe even deeper, but no context available). Ditto
> > > for the rest of the series.
> >
> > Any special reason for it (maybe related to lockdep :wondering: ) ? Jus=
t
> > curious as I never noticed such a pattern when initializing mutexes.
>
> Yes. Micro-optimization based on the rule "don't create a resource in
> case of known error".
>
> OTOH, you have to be sure that the mutex (and generally speaking a
> locking) should be initialized early enough.

Note that "micro" in the above can be multiplied by 'k', where 'k' is
the amount of deferred probes (probably not the case here, but again,
"generally speaking").

--=20
With Best Regards,
Andy Shevchenko
