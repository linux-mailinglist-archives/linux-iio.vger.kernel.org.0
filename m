Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1012B2E38
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 16:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726908AbgKNPti (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 10:49:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:51076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726885AbgKNPth (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 10:49:37 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BAB322254;
        Sat, 14 Nov 2020 15:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605368977;
        bh=yXA8612BnLyCghmFr8evBQ/dHGuJV1Bl4fLYcWxT2JE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xtuL4YSmje7zPWwB71+NlLn+Z/lNfhn9J6euQJkBzUvnomoqTjrr+g30mQ8UvNBkw
         39BQq1I2p/8zCAdGaGHOoR5ABMSqqDx1YUajObXGnNESzROVrc0nOVEsqgdWUaJd45
         B/mfDfD+vvhmxHrwFjFYSXmJcj9y1mcTkcl+aasU=
Date:   Sat, 14 Nov 2020 15:49:32 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     lorenzo.bianconi@redhat.com, linux-iio@vger.kernel.org,
        mario.tesi@st.com, denis.ciocca@st.com, armando.visconti@st.com
Subject: Re: [PATCH v2] iio: imu: st_lsm6dsx: fix edge-trigger interrupts
Message-ID: <20201114154932.5f322b21@archlinux>
In-Reply-To: <797560f9719ee87115b51968c79e9913586d786f.1604343119.git.lorenzo@kernel.org>
References: <797560f9719ee87115b51968c79e9913586d786f.1604343119.git.lorenzo@kernel.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  2 Nov 2020 19:59:46 +0100
Lorenzo Bianconi <lorenzo@kernel.org> wrote:

> If the device is configured to trigger edge interrupts it is possible to
> miss samples since the sensor can generate an interrupt while the driver
> is still processing the previous one but it has already read the fifo
> status register. Poll FIFO status register to check if there is any pending
> interrupt to process.
> 
> Fixes: 89ca88a7cdf2 ("iio: imu: st_lsm6dsx: support active-low interrupts")
> Fixes: 290a6ce11d93 ("iio: imu: add support to lsm6dsx driver")
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Sorry, I've been a bit slow on replying to the v1 patch.  Lets finish
the discussion in that thread before we move on with this.
I suspect the patch may end up the same, but the explanation may well
be different!

Jonathan


> ---
> Changes since v1:
> - add missing fixes tags
> - keep IRQF_ONESHOT even for edge-interrupts
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 5e584c6026f1..86c50136219b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -2460,19 +2460,29 @@ st_lsm6dsx_report_motion_event(struct st_lsm6dsx_hw *hw)
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
> +	 * processing current IRQ and those may be missed unless we
> +	 * pick them here, so let's try read FIFO status again
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

