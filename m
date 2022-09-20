Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC5E95BE9CB
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 17:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiITPNK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 11:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbiITPNI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 11:13:08 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867255A3EE
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 08:13:07 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y2so1798975qkl.11
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 08:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=H/fELBq8CrA1DvGdURv9OEhTBXymuyG0Ndt8d3ITimI=;
        b=odqvhHE4k7/usvdUB+d9hXNls03VbsjsLLXsqVMWrIxb23eU4DkX5vrM83VTLppWKR
         ymCHStOYHe2be/kpoRTfwTZRUih7KT3hKhI+EwPdNWOworFuN5vnqpv5ga5Q2CmWxQI4
         vBZbTCdhXulCvdJxEBXNPZsjosvrBDFPMj8wZ+qAhGlKaVpt5KG0lES84qXE7u/zCbrD
         gxEWm2RSk2S9pVLQtOYUlYm/2H7Oe6Qw5ll0092KQVutYVagKSLJ+FsgJOq9N9cKYiY4
         7feqMG6EocZdNCOboZ/98Q0ELa4zmBDN6KPGZHkN6mjeGrt2rbZIjbOCIO66f138shzq
         hK0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=H/fELBq8CrA1DvGdURv9OEhTBXymuyG0Ndt8d3ITimI=;
        b=2DKIiiH6ZxnRaQvLlkQlHi3hUL7YjQUAWCNTvWu7bbLua63OLjqZa46qeDwf+wsN2e
         k31PNTUc617Omm2EjfyWwlxygeRVp415Y3Oaw0obTY+e5py7Cg4xwe8W9GaQIyBVu/AU
         bierguyZr4F6wn146zoulRnh3hF8pX5mjugkkWBGVclNAJRecG/zE26coJgd+tmu1oFf
         NV/Ms2B5i8Esb8PSFWz47XmAFbPpSmKd4qN2YyLmMn4V8MJQcIxIDsLYQ1hbfNnerVJG
         YGM8Ii3i+pUbjYIXwd3xbOV7itVboGrszO0iVR8RrgNUMtHRAJY9FyfdBETTn7379X8/
         2rIw==
X-Gm-Message-State: ACrzQf1RtDIgKutqMXoLr6jJQp3ZMxk+hx8CutHk9j1rwT2oY4IaGLzO
        7gPmRlnpkUgoiixRexOwPkeC21qKf7/ON1yjpY8=
X-Google-Smtp-Source: AMsMyM7fL5q6SxxEBDkVEF8PUG8Ss/gYOHVmtrul7fepLnHVvvy+tkwmPheD5VX2p+fX+A0Nn5TkJJig9fnXZsuGYMI=
X-Received: by 2002:a05:620a:410e:b0:6bc:5cdc:88ec with SMTP id
 j14-20020a05620a410e00b006bc5cdc88ecmr17318786qko.734.1663686786455; Tue, 20
 Sep 2022 08:13:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220920112821.975359-1-nuno.sa@analog.com> <20220920112821.975359-4-nuno.sa@analog.com>
 <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
 <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
 <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
 <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com> <SJ0PR03MB6778EEF81693C026CE131B49994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
In-Reply-To: <SJ0PR03MB6778EEF81693C026CE131B49994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Sep 2022 18:12:30 +0300
Message-ID: <CAHp75VdT0a2DevybjT4HN8xGFrKzrR0sPXA6P89xnBg1xcqbQA@mail.gmail.com>
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

On Tue, Sep 20, 2022 at 4:46 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > -----Original Message-----
> > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Sent: Tuesday, September 20, 2022 3:39 PM
> > On Tue, Sep 20, 2022 at 4:37 PM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Tue, Sep 20, 2022 at 4:18 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > > > On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1 <nuno.sa@analog.com>
> > wrote:
> >
> > ...
> >
> > > > > >         info =3D iio_priv(indio_dev);
> > > > > > +       mutex_init(&info->lock);
> > > > > >         info->irq =3D platform_get_irq(pdev, 0);
> > > > > >         if (info->irq < 0)
> > > > > >                 return info->irq;
> > > > >
> > > > > Consider initializing it as late as possible, like after IRQ retr=
ieval
> > > > > in this context (maybe even deeper, but no context available). Di=
tto
> > > > > for the rest of the series.
> > > >
> > > > Any special reason for it (maybe related to lockdep :wondering: ) ?=
 Just
> > > > curious as I never noticed such a pattern when initializing mutexes=
.
> > >
> > > Yes. Micro-optimization based on the rule "don't create a resource in
> > > case of known error".
> > >
> > > OTOH, you have to be sure that the mutex (and generally speaking a
> > > locking) should be initialized early enough.
>
> Typically not really needed during probe...

Actually as long as you expose the ABI to the user anything can
happen, means that your code should be ready to receive the requests
in any possible callbacks / file ops. Same applies to the IRQ handler.
So it's very important to initialize locking just in time. Hence I can
say that "typically it needs to be carefully placed".

> > Note that "micro" in the above can be multiplied by 'k', where 'k' is
> > the amount of deferred probes (probably not the case here, but again,
> > "generally speaking").
>
> Well, I don't think 'mutex_init()' does that much that really matters in
> these patches but ok, that rule is indeed a good practice that sometimes
> makes a difference. And since I will definitely need a v2, I can make tha=
t
> change. Where applicable, the best place is probably before registering t=
he
> IIO device...

Some drivers are pedantic and want to have mutex_destroy() to be
called, it also reduces the surface of returning with an undestroyed
object (let's not discuss the usefulness of such destruction, but in
principle).

--=20
With Best Regards,
Andy Shevchenko
