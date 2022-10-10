Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FA8A5F98E7
	for <lists+linux-iio@lfdr.de>; Mon, 10 Oct 2022 09:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbiJJHCb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Oct 2022 03:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiJJHC3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2022 03:02:29 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4266C3B713
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 00:02:28 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v17so6196026qkv.5
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 00:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3yT0ctdZydc+N40TPk8vYFwq0X5hY6hPQZEk2eDVw70=;
        b=hPG3MIllA4/bctpkcrIFqmmy2fPX7ndGoe/454jMNR3Jkb9XF5kEprHDarMWao/enM
         OPtKMe8HpjiYqarFWAmEP/Zwcff2Y1ekewl8XmC/dvF+faQ7JqA5dAx2TmlH9XDVyoO4
         1ug4utdGLrgVMfOcRKxDJfnJ0G7oDe2U/YIqiRLOTG+c9quEHL8ym29ACJfoEaHJDVJV
         E91NW7r5AKWoj1eUOPaiqdJV25W6LiiDpNGGA9/AO+Lm557bxs/OTXEH28992KxMYh4f
         cQAYihaqIuuwsjZBNjqPHKk9Jo2LiCZ9U/xSmtKzT/r4WW4+o5rEJHn7iQkng8y78J0q
         r2Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3yT0ctdZydc+N40TPk8vYFwq0X5hY6hPQZEk2eDVw70=;
        b=unvvJEBrwV8PqPRdWC+j0m+phCA+daqj2G5og3fRPebNF6cPhG5/dRKuxVfa9KrlRr
         wQm78yoQzjrotxQ0nm9YvuesuLpGqzdxvCsih7f7IYzBUQSK/E0zfxN957cTV7kR8p1l
         OinU2yq668wc+XN2vYg7LflFBIUwLp9gm/zYfuLOqFPRxLj8RG+T/qNeBnXtqS9nYhdv
         /r6V9KHfmwawffom5CaVGkAV69HDg3MTmLZVR9pEggJDOC+8auLrKzkUvbp8zaYgfW3X
         9Kjw/h3UlW+9ocYMwZEik6/i9BGHVUd6ppbAALynmtYKwn+IrhNHRaYDfRRi5+Jxa3SN
         GVCw==
X-Gm-Message-State: ACrzQf0ilUGKQxkRxgYuhT+A+PJuWByvvTPU0XXbuIqMkLTsJh/NBzGx
        vS51dB/5UPqmt5+60gt+eik=
X-Google-Smtp-Source: AMsMyM7KfTRmJnXydAYbJgREbLJNimSTnmeCiAGcC+LyfonBwqydRnZBDe0+CQJF9ZRflMHJzX0Vuw==
X-Received: by 2002:a05:620a:318a:b0:6ce:732a:f92 with SMTP id bi10-20020a05620a318a00b006ce732a0f92mr11728995qkb.347.1665385347394;
        Mon, 10 Oct 2022 00:02:27 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a248d00b006b5e296452csm9649652qkn.54.2022.10.10.00.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:02:26 -0700 (PDT)
Message-ID: <73e43d55f76216d3cb720d687d1510e626997f0f.camel@gmail.com>
Subject: Re: [PATCH v2 13/16] iio: core: introduce
 iio_device_{claim|release}_buffer_mode() APIs
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
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
Date:   Mon, 10 Oct 2022 09:03:44 +0200
In-Reply-To: <20221009124120.39a43103@jic23-huawei>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-14-nuno.sa@analog.com>
         <CAHp75VfmMWonUV1jahbAmBZJixfdxA=ZAm-NNt7XiO+RDbupyg@mail.gmail.com>
         <609d7e50d76a2a2aa2bbaddfed8a846c91854065.camel@gmail.com>
         <20221009124120.39a43103@jic23-huawei>
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

On Sun, 2022-10-09 at 12:41 +0100, Jonathan Cameron wrote:
> On Wed, 05 Oct 2022 10:37:39 +0200
> Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:
>=20
> > On Tue, 2022-10-04 at 17:08 +0300, Andy Shevchenko wrote:
> > > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com>
> > > wrote:=C2=A0=20
> > > >=20
> > > > These APIs are analogous to iio_device_claim_direct_mode() and
> > > > iio_device_release_direct_mode() but, as the name suggests,
> > > > with
> > > > the
> > > > logic flipped. While this looks odd enough, it will have at
> > > > least
> > > > two
> > > > users (in following changes) and it will be important to move
> > > > the
> > > > iio
> > > > mlock to the private struct.=C2=A0=20
> > >=20
> > > ...
> > > =C2=A0=20
> > > > +int iio_device_claim_buffer_mode(struct iio_dev *indio_dev)
> > > > +{
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 mutex_lock(&indio_dev->mlock)=
;
> > > > +
> > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (iio_buffer_enabled(indio_=
dev))=C2=A0=20
> > >=20
> > > Do you need to annotate these two APIs to make sparse happy about
> > > locking balance?
> > >=20
> > > (Try to run `make W=3D1 C=3D1 ...` with your patches and look if any
> > > new
> > > warnings appear.)=C2=A0=20
> >=20
> > make W=3D1 C=3D1 drivers/iio/industrialio-core.o
> > #=C2=A0 UPD=C2=A0=C2=A0=C2=A0=C2=A0 include/config/kernel.release
>=20
> ...
>=20
> > drivers/iio/industrialio-core.c:2100: warning: expecting prototype
> > for
> > iio_device_claim_buffered_mode(). Prototype was for
> > iio_device_claim_buffer_mode() instead
>=20
> That one wants fixing as this patch introduces it.
>=20

Bah, That's why another pair of eyes is useful... I looked for that
warning without seeing what it was complaining about. Now, I could
finally see it :)

- Nuno S=C3=A1
>=20

