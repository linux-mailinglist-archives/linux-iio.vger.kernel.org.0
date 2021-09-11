Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238B2407A02
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 19:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbhIKRog (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 13:44:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:59516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhIKRog (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 13:44:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEB2960FBF;
        Sat, 11 Sep 2021 17:43:21 +0000 (UTC)
Date:   Sat, 11 Sep 2021 18:46:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: adc: ad7793: Fix IRQ flag
Message-ID: <20210911184652.249bcbd8@jic23-huawei>
In-Reply-To: <20210906065630.16325-4-alexandru.tachici@analog.com>
References: <20210906065630.16325-1-alexandru.tachici@analog.com>
        <20210906065630.16325-4-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 6 Sep 2021 09:56:30 +0300
<alexandru.tachici@analog.com> wrote:

> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> In Sigma-Delta devices the SDO line is also used as an interrupt.
> Leaving IRQ on level instead of falling might trigger a sample read
> when the IRQ is enabled, as the SDO line is already low. Not sure
> if SDO line will always imediately go high in ad_sd_buffer_postenable
> before the IRQ is enabled.
> 
> Also the datasheet seem to explicitly say the falling edge of the SDO
> should be used as an interrupt:
> From the AD7793 datasheet: " The DOUT/RDY falling edge can be
> used as an interrupt to a processor"
> 
> Fixes: da4d3d6bb9f6 ("iio: adc: ad-sigma-delta: Allow custom IRQ flags")
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7793.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
> index ef3e2d3ecb0c..0e7ab3fb072a 100644
> --- a/drivers/iio/adc/ad7793.c
> +++ b/drivers/iio/adc/ad7793.c
> @@ -206,7 +206,7 @@ static const struct ad_sigma_delta_info ad7793_sigma_delta_info = {
>  	.has_registers = true,
>  	.addr_shift = 3,
>  	.read_mask = BIT(6),
> -	.irq_flags = IRQF_TRIGGER_LOW,
> +	.irq_flags = IRQF_TRIGGER_FALLING,
>  };
>  
>  static const struct ad_sd_calib_data ad7793_calib_arr[6] = {

