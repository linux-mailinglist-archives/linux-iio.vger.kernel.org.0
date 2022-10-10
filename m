Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8425F9A5D
	for <lists+linux-iio@lfdr.de>; Mon, 10 Oct 2022 09:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231818AbiJJHrz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Oct 2022 03:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231543AbiJJHrf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2022 03:47:35 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8DF13CDA
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 00:44:45 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id a5so1196415qkl.6
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cqantoaZonPlYgGQGR7qFyyvdL6723k4g+GFmT1ALoA=;
        b=G+AzIixjDRv0qpyufIdJomHx+yTVLb0uWiOdobLG3w2zBge4b3/FgA1V78XQaxZ2xK
         4wemvPNfQ5Evyzc02kj8I7bb7xBoB2NYY8tsaky8XqUK1DfCP63g2YSTJiYMyslZu0gx
         V2bffGhyNjaMCHdmAxMe775Z15ytSo1djaxqKqUTx+fsI/jj0ree/SD7NJULKVhB2Nqa
         AQup1ciMXzHg/FPrJuwi78O8UXCalkEetRr92vr/JiWC5VOPTzf3uU22lZcU5GXgR2YC
         0zgAutmFe7evozMlZHDYvsSbseq4i1KZWafdfy27QFNn1KI72QywNz0J4GI5/jmZwws2
         2Wgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cqantoaZonPlYgGQGR7qFyyvdL6723k4g+GFmT1ALoA=;
        b=sz1J/7NfB7FGBjC/zsf7DwTusZvz0U9I6zrvGqUbz1nFZX5ZRPDHW11dGOz4r6jEdn
         Dk2zeXKP8x6SgZczE7M+FAfFq48i4k6K40VyTvEyH1oHKsk704UPt/0YGeXhv6BftdYi
         Uw0N9brwDR13xlP9khJxRMXiAYDu+dfQbB85I0PdVGfPjGT4toIMBBcH3/Nijq0RBWA8
         WeTBH7jQ9tRmHXNUo/Nch2oHAVcDkIxqWJpEiJeWl46eWHfAmdfyEopdC8NUauafL9kR
         n2v83xCvZndWChNG9pFiC40W3yqSYgR7eoLN3rIMUW0iw2IsvmjA2XDNMI/i7r2OX0Sw
         bsvQ==
X-Gm-Message-State: ACrzQf1o2gziDS85Ef7X73DsdrUln289sr2itt08NPIWDfpZczrpguqf
        Ymh7af2A9UeMRY7zYchxUVe9GcBhvCTvphSP0sU=
X-Google-Smtp-Source: AMsMyM6c5WXfjncBULc9UHk40SqYvDt4Kb9Si4N5vVusfF5PksVcJ9qxCRe6Sa/luSlMl9vyH2DM4A==
X-Received: by 2002:a05:622a:1191:b0:394:a7a2:7a3e with SMTP id m17-20020a05622a119100b00394a7a27a3emr13738039qtk.344.1665385814014;
        Mon, 10 Oct 2022 00:10:14 -0700 (PDT)
Received: from p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de (p200300f6ef036f005de6a4d0d791ed01.dip0.t-ipconnect.de. [2003:f6:ef03:6f00:5de6:a4d0:d791:ed01])
        by smtp.gmail.com with ESMTPSA id i16-20020ac87650000000b0035d5e5660cbsm7864005qtr.59.2022.10.10.00.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 00:10:13 -0700 (PDT)
Message-ID: <4059bf5b8a6d6bc2b5edab7eb447503e6a6b639b.camel@gmail.com>
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct
 iio_dev_opaque'
From:   Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Kevin Hilman <khilman@baylibre.com>
Date:   Mon, 10 Oct 2022 09:11:32 +0200
In-Reply-To: <20221009131923.2cc18d37@jic23-huawei>
References: <20221004134909.1692021-1-nuno.sa@analog.com>
         <20221004134909.1692021-17-nuno.sa@analog.com>
         <20221009131923.2cc18d37@jic23-huawei>
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

On Sun, 2022-10-09 at 13:19 +0100, Jonathan Cameron wrote:
> On Tue, 4 Oct 2022 15:49:09 +0200
> Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>=20
> > Now that there are no more users accessing 'mlock' directly, we can
> > move
> > it to the iio_dev private structure. Hence, it's now explicit that
> > new
> > driver's should not directly this lock.
> >=20
> > Signed-off-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> This looks good to me.=20
> So series wise, I think I've picked up 1-12.=20
> To resolve is remaining discussion plus the missmatch in function
> name vs
> comment in 13.
>=20

So, I think we are missing an improvement on the commit message for
patch 14 (about shadowing the error code) and fixing the function
name..
> Thanks for getting this tidied up!=C2=A0 It's the end of a very long
> process.
> I almost feel like we need a party - there would be a quite a crowd
> given
> how many people have been involved in this effort over the years. :)
>=20

Sure, happy to help! This one felt like something that we really need
to take care :)

- Nuno S=C3=A1

