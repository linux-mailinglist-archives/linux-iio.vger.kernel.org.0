Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A93B5267EFD
	for <lists+linux-iio@lfdr.de>; Sun, 13 Sep 2020 11:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgIMJpL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 13 Sep 2020 05:45:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45964 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbgIMJpL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 13 Sep 2020 05:45:11 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74CB920796;
        Sun, 13 Sep 2020 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599990310;
        bh=k+BofSh+QwxaRrl2wyYgP2XKH965o2mEBGH18y12SN0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R7Xyly+0py1yFDNy5z9Dh+KtcMDagJ/XnH2dOjPUi2EzQ0MB94hTe5lZUuD3ds1oI
         1YfSWb9X8ggHn4eTYxY8BH4KdcYnh1tDHeTk4575oCcSDtJkGbgmvaEZ2blBYqGQ+T
         T9IYUxCO7TThqJrsPv46K0SvY81J31CwVPYOk62o=
Date:   Sun, 13 Sep 2020 10:45:05 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Greg KH <greg@kroah.com>
Subject: Re: [PATCH] iio: adc: stm32: Fix missing return in booster error
 path
Message-ID: <20200913104505.1e4b661c@archlinux>
In-Reply-To: <1599727927-7776-1-git-send-email-krzk@kernel.org>
References: <1599727927-7776-1-git-send-email-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 10 Sep 2020 10:52:07 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> Conversion of error paths to dev_err_probe() dropped one return
> statement.  The driver will continue to probe if getting booster
> regulator fails.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Fixes: ce30eeb613cb ("iio: adc: stm32: Simplify with dev_err_probe()")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to poke at it.

Thanks,

Jonathan

> 
> ---
> 
> Commit sha from linux-next.

This is applying to an (in theory) non rebasing tree, so hopefully
that will remain stable!

> ---
>  drivers/iio/adc/stm32-adc-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 3f27b4817a42..6a0338d33bd8 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -595,7 +595,7 @@ static int stm32_adc_core_switches_probe(struct device *dev,
>  		if (IS_ERR(priv->booster)) {
>  			ret = PTR_ERR(priv->booster);
>  			if (ret != -ENODEV)
> -				dev_err_probe(dev, ret, "can't get booster\n");
> +				return dev_err_probe(dev, ret, "can't get booster\n");
>  
>  			priv->booster = NULL;
>  		}

