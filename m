Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D629C41FCEE
	for <lists+linux-iio@lfdr.de>; Sat,  2 Oct 2021 18:05:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbhJBQGz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 2 Oct 2021 12:06:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:38896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232575AbhJBQGy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 2 Oct 2021 12:06:54 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A896E61B20;
        Sat,  2 Oct 2021 16:05:03 +0000 (UTC)
Date:   Sat, 2 Oct 2021 17:09:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Cai Huoqing <caihuoqing@baidu.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3 6/9] iio: adc: meson_saradc: Make use of the helper
 function dev_err_probe()
Message-ID: <20211002170901.7378fcc4@jic23-huawei>
In-Reply-To: <CAFBinCB+tYAjqhyO-UAsZxqm6FkK8Q8TGPJ_ehuxwgRSSRZDJA@mail.gmail.com>
References: <20210928141956.2148-1-caihuoqing@baidu.com>
        <20210928141956.2148-6-caihuoqing@baidu.com>
        <CAFBinCB+tYAjqhyO-UAsZxqm6FkK8Q8TGPJ_ehuxwgRSSRZDJA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 2 Oct 2021 15:01:56 +0200
Martin Blumenstingl <martin.blumenstingl@googlemail.com> wrote:

> On Tue, Sep 28, 2021 at 4:20 PM Cai Huoqing <caihuoqing@baidu.com> wrote:
> >
> > When possible use dev_err_probe help to properly deal with the
> > PROBE_DEFER error, the benefit is that DEFER issue will be logged
> > in the devices_deferred debugfs file.
> > Using dev_err_probe() can reduce code size, and the error value
> > gets printed.
> >
> > Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>  
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> as well as:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> # Odroid-C1
Hi Martin,

Confusing tag.  Was the second meant to be a Tested-by?

Thanks,

Jonathan
> 
> Thanks for your contribution!
> 
> 
> Best regards,
> Martin

