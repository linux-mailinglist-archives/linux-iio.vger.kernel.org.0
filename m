Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DB83FAC63
	for <lists+linux-iio@lfdr.de>; Sun, 29 Aug 2021 17:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbhH2PGn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Aug 2021 11:06:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235501AbhH2PGn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Aug 2021 11:06:43 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFDBB60F36;
        Sun, 29 Aug 2021 15:05:45 +0000 (UTC)
Date:   Sun, 29 Aug 2021 16:08:56 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
Cc:     <lars@metafoo.de>, <pmeerw@pmeerw.net>, <robh+dt@kernel.org>,
        <joel@jms.id.au>, <andrew@aj.id.au>, <p.zabel@pengutronix.de>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-aspeed@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <BMC-SW@aspeedtech.com>
Subject: Re: [RESEND v4 03/15] iio: adc: aspeed: set driver data when adc
 probe.
Message-ID: <20210829160856.12dd9395@jic23-huawei>
In-Reply-To: <20210824091243.9393-4-billy_tsai@aspeedtech.com>
References: <20210824091243.9393-1-billy_tsai@aspeedtech.com>
        <20210824091243.9393-4-billy_tsai@aspeedtech.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Aug 2021 17:12:31 +0800
Billy Tsai <billy_tsai@aspeedtech.com> wrote:

> Fix the issue when adc remove will get the null driver data.
> 
> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>

This is a fix that we should probably backport.  Please add a fixes tag and move
it to the start of the series so I can pick it during this kernel
cycle rather than waiting for the next one.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/aspeed_adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/aspeed_adc.c b/drivers/iio/adc/aspeed_adc.c
> index 7010d56ac3b9..20462cf659e4 100644
> --- a/drivers/iio/adc/aspeed_adc.c
> +++ b/drivers/iio/adc/aspeed_adc.c
> @@ -201,6 +201,7 @@ static int aspeed_adc_probe(struct platform_device *pdev)
>  
>  	data = iio_priv(indio_dev);
>  	data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, indio_dev);
>  
>  	data->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(data->base))

