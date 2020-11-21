Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8EC2BC093
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 17:34:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgKUQd7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 11:33:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725914AbgKUQd7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 11:33:59 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD48B22206;
        Sat, 21 Nov 2020 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605976438;
        bh=OjIgm9vMAzT5oeiIWUTmvBNS+yRnQOvpUcQ3pu3xRHQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IMoL/eKo4qLZQlO8HriRf57Qs5pofKjTiz/Qd1N07fylU6F4JoYif2Zp3B1gD5Fpn
         FrXmtqiUq2+SPq5YubPGFLJCR9ap2JUk6t2OllmNqgWHyHtJtG7mmpHkNtAuV0STfL
         9MuLuWCqtLAIBDoFY6W5hcgrMDGFK0wVibqLS9l4=
Date:   Sat, 21 Nov 2020 16:33:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201121163354.64af2edd@archlinux>
In-Reply-To: <5e93cda7dc1e665f5685c53ad8e9ea71dbae782d.1605378871.git.lorenzo@kernel.org>
References: <5e93cda7dc1e665f5685c53ad8e9ea71dbae782d.1605378871.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 14 Nov 2020 19:39:05 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> If we are using edge IRQs, new samples can arrive while processing
> current interrupt since there are no hw guarantees the irq line
> stays "low" long enough to properly detect the new interrupt.
> In this case the new sample will be missed.
> Polling FIFO status register in st_lsm6dsx_handler_thread routine
> allow us to read new samples even if the interrupt arrives while
> processing previous data and the timeslot where the line is "low"
> is too short to be properly detected.
> 
> Fixes: 89ca88a7cdf2 ("iio: imu: st_lsm6dsx: support active-low interrupts")
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> ---
> Changes since v2:
> - improve comments/commit log
> 
> Changes since v1:
> - add missing fixes tags
> - keep IRQF_ONESHOT even for edge-interrupts
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 26 ++++++++++++++++----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 5e584c6026f1..da91f5e7e86d 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2460,19 +2460,35 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
>  static irqreturn_t st_lsm6dsx_handler_thread(int irq, void *private)
>  {
>  	struct st_lsm6dsx_hw *hw = private;
> +	int fifo_len = 0, len;
>  	bool event;
> -	int count;
>  
>  	event = st_lsm6dsx_report_motion_event(hw);
>  
>  	if (!hw->settings->fifo_ops.read_fifo)
>  		return event ? IRQ_HANDLED : IRQ_NONE;
>  
> -	mutex_lock(&hw->fifo_lock);
> -	count = hw->settings->fifo_ops.read_fifo(hw);
> -	mutex_unlock(&hw->fifo_lock);
> +	/*
> +	 * If we are using edge IRQs, new samples can arrive while
> +	 * processing current interrupt since there are no hw
> +	 * guarantees the irq line stays "low" long enough to properly
> +	 * detect the new interrupt. In this case the new sample will
> +	 * be missed.
> +	 * Polling FIFO status register allow us to read new
> +	 * samples even if the interrupt arrives while processing
> +	 * previous data and the timeslot where the line is "low" is
> +	 * too short to be properly detected.
> +	 */
> +	do {
> +		mutex_lock(&hw->fifo_lock);
> +		len = hw->settings->fifo_ops.read_fifo(hw);
> +		mutex_unlock(&hw->fifo_lock);
> +
> +		if (len > 0)
> +			fifo_len += len;
> +	} while (len > 0);
>  
> -	return count || event ? IRQ_HANDLED : IRQ_NONE;
> +	return fifo_len || event ? IRQ_HANDLED : IRQ_NONE;
>  }
>  
>  static int st_lsm6dsx_irq_setup(struct st_lsm6dsx_hw *hw)

