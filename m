Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258FC5BE73C
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiITNiB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbiITNh7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:37:59 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875D6580B0
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:37:56 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id l14so1990022qvq.8
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=ldfCfPiEcl/iU6xkC9UBhb9pCzWFcdD9p30orMt50qQ=;
        b=ODRXoPyJ/TIwb3d/5fipsb9U4muzMkRw+uwLDlR5po75SUqM7n9cLElB3A7bdfH2hm
         JSlt3PSCmlA8zhg/TzrF4ppn3crEZo8H7OTj5eawr3ISGr5nUWHWSMLZZYFDjIMMrvuA
         Sx+Ace0o1wYKyHWCtfeMEUIoWEIZPlrIoXnkOGNm7DVHJ9Zu26Ec90q7Pn9fYmgWeNtz
         +nF0aSOP4aSGWZ5+AfLwQ62K6CjKmnSUWNwzyu/pMyzMPvhe0Usk6Wh+QcR5G4bCd7pM
         /p2FGkh1Y19EA7MogXX37LqHOSQvs+apl3NdvoMLviD01/RmE2e40KJi98J1z1qHVDO+
         k1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=ldfCfPiEcl/iU6xkC9UBhb9pCzWFcdD9p30orMt50qQ=;
        b=Tw4OMHLlPB/2PAjUrwGyp9RDIT92hY5Q86yGmpzYQpo+WpXTmYslvhBHsyWq1s1Sok
         l8b4vT95BPEBiW+V0T33I4DyWhbr4mPDlTioup7xcYNa0grF8qNy/J5CEQi40ZbH2Br+
         mDjFM3YBAHhlxFQO+boTVFD9ARJNXarNX5VL3CxBN7P+ZdMfZxxmZ0JADdi5wUOkeGu4
         NPAYtAX3M/g7e4tGgKbJtZZKZIdpHOhJI0FXi1HER/CJDsVvlQOEROKvizr/SF7UccNg
         3oxNB1qDdX5IXS1tiQhHfXFyj+TH0969nh+WQDB9xNFEtotP12p4VMe0646ssEl/mApN
         nhsw==
X-Gm-Message-State: ACrzQf2s7if/u9l26o6hK9//3vDTvNCX4NAS1hCrxRDrUQWRhNHM+Iog
        +4ATlAu2+uo1LfgRaKSw7BrbYRNv0PQbS4amXn8=
X-Google-Smtp-Source: AMsMyM5RWpOoUCubSLZldb8nZ0OMTgh0LmGChDVJqvPSCUwsewgD/0JGu3T0lW4vETV28zQlu9VzRczxmvQKqnteIac=
X-Received: by 2002:a0c:e24b:0:b0:4a1:d41b:e280 with SMTP id
 x11-20020a0ce24b000000b004a1d41be280mr19334009qvl.11.1663681075513; Tue, 20
 Sep 2022 06:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220920112821.975359-1-nuno.sa@analog.com> <20220920112821.975359-4-nuno.sa@analog.com>
 <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com> <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Sep 2022 16:37:19 +0300
Message-ID: <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 4:18 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote=
:

...

> > >         info =3D iio_priv(indio_dev);
> > > +       mutex_init(&info->lock);
> > >         info->irq =3D platform_get_irq(pdev, 0);
> > >         if (info->irq < 0)
> > >                 return info->irq;
> >
> > Consider initializing it as late as possible, like after IRQ retrieval
> > in this context (maybe even deeper, but no context available). Ditto
> > for the rest of the series.
>
> Any special reason for it (maybe related to lockdep :wondering: ) ? Just
> curious as I never noticed such a pattern when initializing mutexes.

Yes. Micro-optimization based on the rule "don't create a resource in
case of known error".

OTOH, you have to be sure that the mutex (and generally speaking a
locking) should be initialized early enough.

--=20
With Best Regards,
Andy Shevchenko
