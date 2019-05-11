Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52DE21A75A
	for <lists+linux-iio@lfdr.de>; Sat, 11 May 2019 11:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728450AbfEKJ6U (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 May 2019 05:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:51714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726941AbfEKJ6U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 May 2019 05:58:20 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1620D21479;
        Sat, 11 May 2019 09:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557568699;
        bh=w06xIIDrPLNrUYunIGSuFxnclJ9Ts8pgisvyPGIll0c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KpuAxiSrFCRO5aA7AgDmR6XNEY/HgQMzyfHQlLiLaqKhuXAve4OUfzRbsxkC9lgoo
         u/KWxxXhC0NdI3bWI0AQ+Kfxm8DqpWmK0ppR3q+pBOeKkQK7DDyIvUC1u5+4tbpxef
         pPvH/wpW2lxtd4V+kNlF6XUZ8GeqTyFZu7QD9EZA=
Date:   Sat, 11 May 2019 10:58:12 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     linux-iio@vger.kernel.org, Stefan Agner <stefan@agner.ch>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/5] iio: stmpe-adc: Add compatible name
Message-ID: <20190511105812.54f6d5f0@archlinux>
In-Reply-To: <20190507143615.28477-1-dev@pschenker.ch>
References: <20190507143615.28477-1-dev@pschenker.ch>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  7 May 2019 16:36:11 +0200
Philippe Schenker <dev@pschenker.ch> wrote:

> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Add the compatible name to the driver so it gets loaded when the proper
> node in DT is detected.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Applied thanks,

Jonathan

> ---
> 
>  drivers/iio/adc/stmpe-adc.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stmpe-adc.c b/drivers/iio/adc/stmpe-adc.c
> index 37f4b74a5d32..9ec338ba3440 100644
> --- a/drivers/iio/adc/stmpe-adc.c
> +++ b/drivers/iio/adc/stmpe-adc.c
> @@ -354,9 +354,14 @@ static struct platform_driver stmpe_adc_driver = {
>  		.pm	= &stmpe_adc_pm_ops,
>  	},
>  };
> -
>  module_platform_driver(stmpe_adc_driver);
>  
> +static const struct of_device_id stmpe_adc_ids[] = {
> +	{ .compatible = "st,stmpe-adc", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, stmpe_adc_ids);
> +
>  MODULE_AUTHOR("Stefan Agner <stefan.agner@toradex.com>");
>  MODULE_DESCRIPTION("STMPEXXX ADC driver");
>  MODULE_LICENSE("GPL v2");

