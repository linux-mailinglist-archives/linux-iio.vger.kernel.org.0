Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA73F2F9259
	for <lists+linux-iio@lfdr.de>; Sun, 17 Jan 2021 13:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbhAQMfu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Jan 2021 07:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:42810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbhAQMfb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Jan 2021 07:35:31 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 448A0206F4;
        Sun, 17 Jan 2021 12:34:49 +0000 (UTC)
Date:   Sun, 17 Jan 2021 12:34:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lars@metafoo.de, pmeerw@pmeerw.net, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, krzk@kernel.org,
        andy.shevchenko@gmail.com, bobo.shaobowang@huawei.com,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: stm32-dfsdm: Remove redundant null check
 before clk_disable_unprepare
Message-ID: <20210117123442.5156a509@archlinux>
In-Reply-To: <20201231085322.24398-1-vulab@iscas.ac.cn>
References: <20201231085322.24398-1-vulab@iscas.ac.cn>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 31 Dec 2020 08:53:22 +0000
Xu Wang <vulab@iscas.ac.cn> wrote:

> ecause clk_disable_unprepare() already checked NULL clock parameter,
> so the additional check is unnecessary, just remove it.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to see if we missed anything.

thanks,

Jonathan

> ---
>  drivers/iio/adc/stm32-dfsdm-core.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
> index 42a7377704a4..bb925a11c8ae 100644
> --- a/drivers/iio/adc/stm32-dfsdm-core.c
> +++ b/drivers/iio/adc/stm32-dfsdm-core.c
> @@ -117,8 +117,7 @@ static void stm32_dfsdm_clk_disable_unprepare(struct stm32_dfsdm *dfsdm)
>  {
>  	struct dfsdm_priv *priv = to_stm32_dfsdm_priv(dfsdm);
>  
> -	if (priv->aclk)
> -		clk_disable_unprepare(priv->aclk);
> +	clk_disable_unprepare(priv->aclk);
>  	clk_disable_unprepare(priv->clk);
>  }
>  

