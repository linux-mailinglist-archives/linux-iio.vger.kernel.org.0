Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3B841A5AC
	for <lists+linux-iio@lfdr.de>; Tue, 28 Sep 2021 04:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbhI1Cvn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Sep 2021 22:51:43 -0400
Received: from mx22.baidu.com ([220.181.50.185]:45848 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238590AbhI1Cvm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Sep 2021 22:51:42 -0400
Received: from BC-Mail-Ex30.internal.baidu.com (unknown [172.31.51.24])
        by Forcepoint Email with ESMTPS id BE25CCC1775BA3014171;
        Tue, 28 Sep 2021 10:49:48 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex30.internal.baidu.com (172.31.51.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Tue, 28 Sep 2021 10:49:48 +0800
Received: from localhost (172.31.63.8) by BJHW-MAIL-EX27.internal.baidu.com
 (10.127.64.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 28
 Sep 2021 10:49:48 +0800
Date:   Tue, 28 Sep 2021 10:49:46 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-amlogic@lists.infradead.org>
Subject: Re: [PATCH 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
Message-ID: <20210928024946.GA1628@LAPTOP-UKSR4ENP.internal.baidu.com>
References: <20210927081426.762-1-caihuoqing@baidu.com>
 <20210927081426.762-6-caihuoqing@baidu.com>
 <CAFBinCAatVy_9abUJ7A6frbsOqDqAzVe9oDJODOS5MC7aCcDVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCAatVy_9abUJ7A6frbsOqDqAzVe9oDJODOS5MC7aCcDVg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex11.internal.baidu.com (172.31.51.51) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 27 9月 21 22:09:47, Martin Blumenstingl wrote:
> Hello,
> 
> first of all: thanks for this patch!
> 
> On Mon, Sep 27, 2021 at 10:15 AM Cai Huoqing <caihuoqing@baidu.com> wrote:
> [...]
> > +       if (IS_ERR(priv->clkin))
> > +               return dev_err_probe(&pdev->dev,
> > +                                    PTR_ERR(priv->clkin),
> Is there any specific reason why you put PTR_ERR() on a separate line?
> it would still fit into the line above and be below the old 80 chars
> per line limit.
> For priv->vref you already have it the way I am suggesting there.
> 
> [...]
> > +       if (IS_ERR(priv->core_clk))
> > +               return dev_err_probe(&pdev->dev,
> > +                                    PTR_ERR(priv->core_clk),
> the same question as above applies here as well
> 
> 
> Best regards,
> Martin
Hi,

Thanks for your feedback.
I have resend v2 to fix it.
here
https://lore.kernel.org/linux-arm-kernel/20210928013621.1245-6-caihuoqing@baidu.com/

Many thanks
Cai
