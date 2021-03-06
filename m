Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC1932FC51
	for <lists+linux-iio@lfdr.de>; Sat,  6 Mar 2021 18:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbhCFRiq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Mar 2021 12:38:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:59846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229779AbhCFRiW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Mar 2021 12:38:22 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86CCE64FCF;
        Sat,  6 Mar 2021 17:38:21 +0000 (UTC)
Date:   Sat, 6 Mar 2021 17:38:18 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: accel: mma8452: fix indentation
Message-ID: <20210306173818.31cd17c9@archlinux>
In-Reply-To: <20210301080029.1974797-1-sean@geanix.com>
References: <20210301080029.1974797-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Mar 2021 09:00:28 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Improve readability by fixing indentation.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Applied.

Thanks,

Jonathan

> ---
> v2: removed fixing of register values indentation
> 
>  drivers/iio/accel/mma8452.c | 46 ++++++++++++++++++-------------------
>  1 file changed, 23 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b0176d936423..33f0c419d8ff 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -58,7 +58,7 @@
>  #define MMA8452_FF_MT_THS			0x17
>  #define  MMA8452_FF_MT_THS_MASK			0x7f
>  #define MMA8452_FF_MT_COUNT			0x18
> -#define MMA8452_FF_MT_CHAN_SHIFT	3
> +#define MMA8452_FF_MT_CHAN_SHIFT		3
>  #define MMA8452_TRANSIENT_CFG			0x1d
>  #define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
>  #define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
> @@ -70,7 +70,7 @@
>  #define MMA8452_TRANSIENT_THS			0x1f
>  #define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
>  #define MMA8452_TRANSIENT_COUNT			0x20
> -#define MMA8452_TRANSIENT_CHAN_SHIFT 1
> +#define MMA8452_TRANSIENT_CHAN_SHIFT		1
>  #define MMA8452_CTRL_REG1			0x2a
>  #define  MMA8452_CTRL_ACTIVE			BIT(0)
>  #define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
> @@ -134,33 +134,33 @@ struct mma8452_data {
>    * used for different chips and the relevant registers are included here.
>    */
>  struct mma8452_event_regs {
> -		u8 ev_cfg;
> -		u8 ev_cfg_ele;
> -		u8 ev_cfg_chan_shift;
> -		u8 ev_src;
> -		u8 ev_ths;
> -		u8 ev_ths_mask;
> -		u8 ev_count;
> +	u8 ev_cfg;
> +	u8 ev_cfg_ele;
> +	u8 ev_cfg_chan_shift;
> +	u8 ev_src;
> +	u8 ev_ths;
> +	u8 ev_ths_mask;
> +	u8 ev_count;
>  };
>  
>  static const struct mma8452_event_regs ff_mt_ev_regs = {
> -		.ev_cfg = MMA8452_FF_MT_CFG,
> -		.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> -		.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
> -		.ev_src = MMA8452_FF_MT_SRC,
> -		.ev_ths = MMA8452_FF_MT_THS,
> -		.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> -		.ev_count = MMA8452_FF_MT_COUNT
> +	.ev_cfg = MMA8452_FF_MT_CFG,
> +	.ev_cfg_ele = MMA8452_FF_MT_CFG_ELE,
> +	.ev_cfg_chan_shift = MMA8452_FF_MT_CHAN_SHIFT,
> +	.ev_src = MMA8452_FF_MT_SRC,
> +	.ev_ths = MMA8452_FF_MT_THS,
> +	.ev_ths_mask = MMA8452_FF_MT_THS_MASK,
> +	.ev_count = MMA8452_FF_MT_COUNT
>  };
>  
>  static const struct mma8452_event_regs trans_ev_regs = {
> -		.ev_cfg = MMA8452_TRANSIENT_CFG,
> -		.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> -		.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
> -		.ev_src = MMA8452_TRANSIENT_SRC,
> -		.ev_ths = MMA8452_TRANSIENT_THS,
> -		.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> -		.ev_count = MMA8452_TRANSIENT_COUNT,
> +	.ev_cfg = MMA8452_TRANSIENT_CFG,
> +	.ev_cfg_ele = MMA8452_TRANSIENT_CFG_ELE,
> +	.ev_cfg_chan_shift = MMA8452_TRANSIENT_CHAN_SHIFT,
> +	.ev_src = MMA8452_TRANSIENT_SRC,
> +	.ev_ths = MMA8452_TRANSIENT_THS,
> +	.ev_ths_mask = MMA8452_TRANSIENT_THS_MASK,
> +	.ev_count = MMA8452_TRANSIENT_COUNT,
>  };
>  
>  /**

