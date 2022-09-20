Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F05BE6CB
	for <lists+linux-iio@lfdr.de>; Tue, 20 Sep 2022 15:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiITNN7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Sep 2022 09:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiITNN6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Sep 2022 09:13:58 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62618474EB
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:13:57 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id g4so1962211qvo.3
        for <linux-iio@vger.kernel.org>; Tue, 20 Sep 2022 06:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=BHlaie6hylWMV8coBd5FIDUSQ9oG1Uphbsv015aZs/4=;
        b=dhNIARiESV6MyND7GWZFXhtWA4jq4Qay7x+tcorjQneVflX9NA4nkhEmxOaz9iIh4u
         6p9TBGmTfswxJiGL/pS/TfyVmKJmkP73qD4dVvYQjP0uvFObt0DclYjTKa3k1qe+UN0i
         6XiWp3jw/JUpctW6aAR/dyvS9mX2D5ssCKmbPbsDo//nRDNPTmwBZnguh2sveAHw2xDI
         ImsdLYJ8SPXNeRD9CZc/DMZCFu6j2D2oo9N5d/wXZgHEXAnVCbEGOOnGRrO8J0b6FcQ0
         up7t7CVx4H/+7yxQknO6m/306g+wrgO/GLKMMykOWJzpINEi/VMU6VvwKhKh+SjX+/41
         yLYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BHlaie6hylWMV8coBd5FIDUSQ9oG1Uphbsv015aZs/4=;
        b=zu/XCbn6fSbcPnhIVHd6bp2JLh5oDNC2wYH2xD1Wa2SCxSlr1krA/kK+qvjv6jtW6C
         eCjzEdUqsEEZnXmyN80wXPBPDK1s5dUGtIumOyx6BF2ronC0Iv1Al5pr3RMj4M5oUTaz
         l0LZ22xAL3cBzSSXztjnA+Nmgq7leZk5JoeRdOpBUByS6AVNrw+1tvFuo005MycTMj0Y
         dPrkaAXvLQ+R83q24DxO5A40WEKqbOs1edGlO+oUnpoE7yxDJUFfF959ymzExxecNEau
         rjRX8a1JLAccACJk6D0nHSY9HSRjMB5uHVrKoe1YA6y6iecRXjhqoUHw0MQ8vkFPQ9WH
         SjuQ==
X-Gm-Message-State: ACrzQf3zflVIiddPSL2rxMqNw1wkXaoKC81IhX6Zs3uvx8lQ3jTVTsWy
        d2qjtsrvJ8LjV+1qHQdu84GwLsWAsCfo8xpA/AA=
X-Google-Smtp-Source: AMsMyM56JXV/U4hiso6NAbUubkut0P6ri2M6qFySsSuc+BbVmLxrkRxw+GByxxcwzVFfwDyrKqMuP3Cm+4aDJqRNXkU=
X-Received: by 2002:a05:6214:d6f:b0:4ac:7748:2e5c with SMTP id
 15-20020a0562140d6f00b004ac77482e5cmr18616202qvs.97.1663679636472; Tue, 20
 Sep 2022 06:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220920112821.975359-1-nuno.sa@analog.com> <20220920112821.975359-4-nuno.sa@analog.com>
In-Reply-To: <20220920112821.975359-4-nuno.sa@analog.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 20 Sep 2022 16:13:20 +0300
Message-ID: <CAHp75VeA48FbKy2uUjW4T19=Vn-UEznT7prkXZq4sdZ4Q9o-YA@mail.gmail.com>
Subject: Re: [PATCH 03/15] iio: adc: axp288_adc: do not use internal iio_dev lock
To:     =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-imx@nxp.com,
        linux-iio@vger.kernel.org, Chunyan Zhang <zhang.lyra@gmail.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
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
        Ciprian Regus <ciprian.regus@analog.com>,
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

On Tue, Sep 20, 2022 at 2:28 PM Nuno S=C3=A1 <nuno.sa@analog.com> wrote:
>
> The iio_device lock is only meant for internal use. Hence define a
> device local lock to protect against concurrent accesses.

...

>         info =3D iio_priv(indio_dev);
> +       mutex_init(&info->lock);
>         info->irq =3D platform_get_irq(pdev, 0);
>         if (info->irq < 0)
>                 return info->irq;

Consider initializing it as late as possible, like after IRQ retrieval
in this context (maybe even deeper, but no context available). Ditto
for the rest of the series.

--=20
With Best Regards,
Andy Shevchenko
