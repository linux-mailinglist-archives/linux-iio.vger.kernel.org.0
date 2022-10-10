Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0FF45F9B10
	for <lists+linux-iio@lfdr.de>; Mon, 10 Oct 2022 10:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbiJJIbf (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Oct 2022 04:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231253AbiJJIbe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2022 04:31:34 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731CA5F121
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 01:31:33 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a17so1272200qtw.10
        for <linux-iio@vger.kernel.org>; Mon, 10 Oct 2022 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hXaoEpBmFaWm4YhSYhLJqszxluutx3yUpvPEtnwbf/8=;
        b=pbKo5cQY+nM/svnG1J2yTAioTB9mF671N4t972e6X12Ufjd8dlZfTuJXhSiAz7EHNF
         wF3XvAwLlqluc2FHKZos96RpTw7oo5eMSesokaPklmKvwl6Dwp+jUSBYwjKp9UJZ9cUW
         l4EyXZNXxwJahajQXN10hBa2q3QIuWAxwkG1fXMZoEfZs5zFIutcDaGQC4xcsQM+z3e6
         iOrPZ3cC9ST2Bp0j1oRUgQiR+ZZQUaoklGVtPrUhb6NeKIxpO0tHIg2Ne2wCzyngsiiZ
         b/2s1nQYcUJC55Du1tRtkxTS9LVd1buXC3B34vzTdqRWAlE9GlfTXokc1pI4JdewpmnF
         YOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hXaoEpBmFaWm4YhSYhLJqszxluutx3yUpvPEtnwbf/8=;
        b=kQHBF4RBcm5bispOkrw7/F7984WX4rRUQngT7gEbWKprtYovGCAgWFpNwueQCjr+bl
         0LGXia+phhyeqOIksqlVU0sAzXXWk7KEOmbt8Tceb3scDpI89mtal4TJYxltk8DFql3C
         h63KV2cyyvdo1d8el+banCWGsJkuWkUVM2donbH2va0J9xLXXRQ42wepUId2q6tUm6kB
         fgcEYc0dWT4BZENnLhvRXjRjf/+9v+9yy4qlvp61dtuZnDSFcVeVCf/jhUauMr+olaf4
         CrdC1lGsdRS3ckWsP+IK8prntiwi9WNDTFivZ+vcy03fzJ6yzyRA2R71m8LqYieIgLRA
         yMWw==
X-Gm-Message-State: ACrzQf1+B+PbRpd+wWSRPWTNKc0VKIaxw0TbJd5w+OZuBH749DhLpO4j
        Le/TaYvxAhbnASptaH3xRKhcx14IeFjoYYXL9Xs=
X-Google-Smtp-Source: AMsMyM4hZoJLGMaXto5+xoWE98hY7087ITW8cBq1XE4Zd9kTd/+UmjrShW6jvIaNBIv6x5xptyiXvJwqLCjpn0ibCk4=
X-Received: by 2002:ac8:7c43:0:b0:35c:cd8f:3da5 with SMTP id
 o3-20020ac87c43000000b0035ccd8f3da5mr14202039qtv.61.1665390692590; Mon, 10
 Oct 2022 01:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221004134909.1692021-1-nuno.sa@analog.com> <20221004134909.1692021-17-nuno.sa@analog.com>
 <CAHp75VfpcrTpH83XqAC9xFrwYApORwoDcqmnhLLTkEWbj6zYVg@mail.gmail.com> <20221009125214.3da1dc89@jic23-huawei>
In-Reply-To: <20221009125214.3da1dc89@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 10 Oct 2022 11:30:56 +0300
Message-ID: <CAHp75Ve4+rRa37jhMHpvLt85Zdad1vRYJuGomZR3rb6TvO6Hew@mail.gmail.com>
Subject: Re: [PATCH v2 16/16] iio: core: move 'mlock' to 'struct iio_dev_opaque'
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>,
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

On Sun, Oct 9, 2022 at 2:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 4 Oct 2022 17:21:20 +0300
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > On Tue, Oct 4, 2022 at 4:49 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:

...

> > I like the end result!
> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Just to check, just this patch, or series (where you haven't commented?)

Just for this patch.

> I'm going to queue this series up piecewise just because it's fairly
> big and most of it is completely non controversial!  So for now I've
> not applied your RB, but can do so before I push out as anything non
> rebasing (which I won't do until after the merge window).

--=20
With Best Regards,
Andy Shevchenko
