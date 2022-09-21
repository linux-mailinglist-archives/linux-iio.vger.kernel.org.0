Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFF35BFA2B
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiIUJHC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 05:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiIUJGt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 05:06:49 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 011578E0D5
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 02:06:37 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id o7so3481366qkj.10
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 02:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date;
        bh=9yV4LRGhFt6LFezVpqUP0yfiNpoAntmY3wUwChWwW9U=;
        b=bGHmKdAYmokUvBZFszMEhy8CAuunlB33rKcKvqPQ5aT59FnJC0V3Koq5360OvzZy8S
         vwsVdqwDE0mUQHBbxEgdIa5h5MG4gqYRVHXRwO7EP3CvjGtqvoGt+kBG05skb953IjX0
         4OMU7wsjKRXvq5RvQShmO6VPyc0Nxrs8j78GYrtQLJCIDaDrPjdyYHCEkthIkG/9+yWb
         ANq3vYIyHIyhOWvC/NE3TNP5Myfa4FxLYcyaByyh6/4gmAAIO0c5T2SXFwAwN7sogjan
         JKEyoMgE+YfQmPEeuO4R9lVsi2zRPbm850gBoLNXNFC/69oo9PNswP56Xvu2HdcuLTsT
         hUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date;
        bh=9yV4LRGhFt6LFezVpqUP0yfiNpoAntmY3wUwChWwW9U=;
        b=WDogfjdC8/k4X3l2gyUtEdInWxlph5PQHgcmrL1RehXFkEwuvrQyXHC1sDUojzDo5M
         6e/ZSWG0u1CEE13imSWGCcVwptK6VCfV6/klhfrQAtFONgVFQu4qmXv3fjgy70rE7Lc+
         m87qexujHOT9/FbPjLLtigYHaZmnqvqIcRaJnlVR9E1imBQHH0tq76I9eDo5W5d9d4PJ
         L3iKU1VQga9ggbJ6TOcbmHNvLnmKMeDMDTajpwCBea6uK9OzDqO5VAAgEdevI6wjfLII
         jeyv2+VuO8uINkWceJQH10/ZXmdkSvijfP/kDjkMsBV2iq+7dJR8uAIzeI5d/u3OOT/o
         kg6w==
X-Gm-Message-State: ACrzQf3z6bdqecH++HPYxqWaZ0KJ7WQRX5kVkkGXPyqk/ARthiYBoaOL
        aNZ1427tP1dw9tE/cBdZum4=
X-Google-Smtp-Source: AMsMyM4dQV8egMsweegXJYpUsa6C3UbUT/6NomoUjurqa142TdTcGXBwyUnxuUmBXYVZPvh5vJVp4g==
X-Received: by 2002:a05:620a:ceb:b0:6cf:468f:ae66 with SMTP id c11-20020a05620a0ceb00b006cf468fae66mr3349088qkj.591.1663751196479;
        Wed, 21 Sep 2022 02:06:36 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id ay43-20020a05620a17ab00b006ce76811a07sm1553998qkb.75.2022.09.21.02.06.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 02:06:36 -0700 (PDT)
Message-ID: <c487df06699aa53292909ff6be2b07de324793f4.camel@gmail.com>
Subject: Re: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev
 lock
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>
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
Date:   Wed, 21 Sep 2022 11:07:50 +0200
In-Reply-To: <CAHp75VdT0a2DevybjT4HN8xGFrKzrR0sPXA6P89xnBg1xcqbQA@mail.gmail.com>
References: <20220920112821.975359-1-nuno.sa@analog.com>
         <20220920112821.975359-4-nuno.sa@analog.com>
         <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
         <SJ0PR03MB6778FFE254E9DDC103258FE8994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <CAHp75VdVbkXCC1PpT4h-+4HHpZX-zK34xH9dVG8vGcpQhXaQHQ@mail.gmail.com>
         <CAHp75VfdUOTd9tRXdTVq_prNf_T2=iQ4tEjusHC=gXDZvb3Qeg@mail.gmail.com>
         <SJ0PR03MB6778EEF81693C026CE131B49994C9@SJ0PR03MB6778.namprd03.prod.outlook.com>
         <CAHp75VdT0a2DevybjT4HN8xGFrKzrR0sPXA6P89xnBg1xcqbQA@mail.gmail.com>
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

On Tue, 2022-09-20 at 18:12 +0300, Andy Shevchenko wrote:
> On Tue, Sep 20, 2022 at 4:46 PM Sa, Nuno <Nuno.Sa@analog.com> wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Tuesday, September 20, 2022 3:39 PM
> > > On Tue, Sep 20, 2022 at 4:37 PM Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Tue, Sep 20, 2022 at 4:18 PM Sa, Nuno <Nuno.Sa@analog.com>
> > > > wrote:
> > > > > > On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1
> > > > > > <nuno.sa@analog.com>
> > > wrote:
> > >=20
> > > ...
> > >=20
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info =3D iio_priv(=
indio_dev);
> > > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_init(&info->lock)=
;
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 info->irq =3D plat=
form_get_irq(pdev, 0);
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (info->irq < 0)
> > > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return info->irq;
> > > > > >=20
> > > > > > Consider initializing it as late as possible, like after
> > > > > > IRQ retrieval
> > > > > > in this context (maybe even deeper, but no context
> > > > > > available). Ditto
> > > > > > for the rest of the series.
> > > > >=20
> > > > > Any special reason for it (maybe related to lockdep
> > > > > :wondering: ) ? Just
> > > > > curious as I never noticed such a pattern when initializing
> > > > > mutexes.
> > > >=20
> > > > Yes. Micro-optimization based on the rule "don't create a
> > > > resource in
> > > > case of known error".
> > > >=20
> > > > OTOH, you have to be sure that the mutex (and generally
> > > > speaking a
> > > > locking) should be initialized early enough.
> >=20
> > Typically not really needed during probe...
>=20
> Actually as long as you expose the ABI to the user anything can
> happen, means that your code should be ready to receive the requests
> in any possible callbacks / file ops. Same applies to the IRQ
> handler.
> So it's very important to initialize locking just in time. Hence I
> can
> say that "typically it needs to be carefully placed".
>=20

Yes, I'm aware of that... For some reason I just thought about code
paths directly on probe. Anyways, hopefully these drivers mostly do the
right thing and register the IIO device as late as possible (ideally
the last thing to be done). The same goes for IRQs and for IIO, when
used as part of triggered buffering, the lock is often only used in the
trigger handler which means it's only reachable after the ABI is
exposed...=20

- Nuno S=C3=A1
> >=20
