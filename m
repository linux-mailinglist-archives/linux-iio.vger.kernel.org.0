Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60328107F66
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2019 17:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfKWQnh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 23 Nov 2019 11:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:54912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbfKWQnh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 23 Nov 2019 11:43:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AADCC2070E;
        Sat, 23 Nov 2019 16:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574527416;
        bh=NYF7myKhi5RYq2ICOWgPxRYnz2JyYw4d7NLCuexs998=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nk/sJIrTSqES6rCOA8bglankx0REQQdcXsEMCLyYqPnw4Hjru0nxhRm4SgI96tbxJ
         4Wo63N+9hQULsupg1AmR1hIhtfG66+RoPnkRYAyqaLYZx7hiscYe35iGW5PENVQ/YT
         OOuEY95+uYU0uvtX9WeVRI0j3amoh2qRGZI+ZDW8=
Date:   Sat, 23 Nov 2019 16:43:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabrice Gasnier <fabrice.gasnier@st.com>
Cc:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <benjamin.gaignard@st.com>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <linux-iio@vger.kernel.org>, <lars@metafoo.de>, <knaack.h@gmx.de>,
        <pmeerw@pmeerw.net>, <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH] iio: trigger: stm32-timer: remove unnecessary update
 event
Message-ID: <20191123164330.04785b93@archlinux>
In-Reply-To: <1574334317-30014-1-git-send-email-fabrice.gasnier@st.com>
References: <1574334317-30014-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 21 Nov 2019 12:05:17 +0100
Fabrice Gasnier <fabrice.gasnier@st.com> wrote:

> There is no need to explicitly generate update event to update
> timer master mode.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to poke at it

Thanks,

Jonathan

> ---
>  drivers/iio/trigger/stm32-timer-trigger.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/iio/trigger/stm32-timer-trigger.c b/drivers/iio/trigger/stm32-timer-trigger.c
> index a5dfe65..2e0d32a 100644
> --- a/drivers/iio/trigger/stm32-timer-trigger.c
> +++ b/drivers/iio/trigger/stm32-timer-trigger.c
> @@ -297,9 +297,6 @@ static ssize_t stm32_tt_store_master_mode(struct device *dev,
>  			     strlen(master_mode_table[i]))) {
>  			regmap_update_bits(priv->regmap, TIM_CR2, mask,
>  					   i << shift);
> -			/* Make sure that registers are updated */
> -			regmap_update_bits(priv->regmap, TIM_EGR,
> -					   TIM_EGR_UG, TIM_EGR_UG);
>  			return len;
>  		}
>  	}

