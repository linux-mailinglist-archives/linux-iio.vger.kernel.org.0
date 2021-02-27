Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83834326DAE
	for <lists+linux-iio@lfdr.de>; Sat, 27 Feb 2021 16:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhB0P4G (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 27 Feb 2021 10:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229999AbhB0P4F (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 27 Feb 2021 10:56:05 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D830364E54;
        Sat, 27 Feb 2021 15:55:20 +0000 (UTC)
Date:   Sat, 27 Feb 2021 15:55:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Sean Nyekjaer <sean@geanix.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: mma8452: fix indentation
Message-ID: <20210227155517.286441de@archlinux>
In-Reply-To: <20210226111142.1526909-1-sean@geanix.com>
References: <20210226111142.1526909-1-sean@geanix.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Feb 2021 12:11:42 +0100
Sean Nyekjaer <sean@geanix.com> wrote:

> Improve readability by using empty linies instead of extra spaces.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/accel/mma8452.c | 120 ++++++++++++++++++++----------------
>  1 file changed, 67 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
> index b0176d936423..9fc1f7550b9c 100644
> --- a/drivers/iio/accel/mma8452.c
> +++ b/drivers/iio/accel/mma8452.c
> @@ -34,52 +34,66 @@
>  #include <linux/regulator/consumer.h>
>  
>  #define MMA8452_STATUS				0x00
> -#define  MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))
> +#define MMA8452_STATUS_DRDY			(BIT(2) | BIT(1) | BIT(0))

This indentation is deliberate.  It is to visibly distinguish register
addresses from the fields.

> +
>  #define MMA8452_OUT_X				0x01 /* MSB first */
>  #define MMA8452_OUT_Y				0x03
>  #define MMA8452_OUT_Z				0x05
>  #define MMA8452_INT_SRC				0x0c
>  #define MMA8452_WHO_AM_I			0x0d
> +
>  #define MMA8452_DATA_CFG			0x0e
> -#define  MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
> -#define  MMA8452_DATA_CFG_FS_2G			0
> -#define  MMA8452_DATA_CFG_FS_4G			1
> -#define  MMA8452_DATA_CFG_FS_8G			2
> -#define  MMA8452_DATA_CFG_HPF_MASK		BIT(4)
> +#define MMA8452_DATA_CFG_FS_MASK		GENMASK(1, 0)
> +#define MMA8452_DATA_CFG_FS_2G			0
> +#define MMA8452_DATA_CFG_FS_4G			1
> +#define MMA8452_DATA_CFG_FS_8G			2
> +#define MMA8452_DATA_CFG_HPF_MASK		BIT(4)
> +
>  #define MMA8452_HP_FILTER_CUTOFF		0x0f
> -#define  MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
> +#define MMA8452_HP_FILTER_CUTOFF_SEL_MASK	GENMASK(1, 0)
> +
>  #define MMA8452_FF_MT_CFG			0x15
> -#define  MMA8452_FF_MT_CFG_OAE			BIT(6)
> -#define  MMA8452_FF_MT_CFG_ELE			BIT(7)
> +#define MMA8452_FF_MT_CFG_OAE			BIT(6)
> +#define MMA8452_FF_MT_CFG_ELE			BIT(7)
> +
>  #define MMA8452_FF_MT_SRC			0x16
> -#define  MMA8452_FF_MT_SRC_XHE			BIT(1)
> -#define  MMA8452_FF_MT_SRC_YHE			BIT(3)
> -#define  MMA8452_FF_MT_SRC_ZHE			BIT(5)
> +#define MMA8452_FF_MT_SRC_XHE			BIT(1)
> +#define MMA8452_FF_MT_SRC_YHE			BIT(3)
> +#define MMA8452_FF_MT_SRC_ZHE			BIT(5)
> +
>  #define MMA8452_FF_MT_THS			0x17
> -#define  MMA8452_FF_MT_THS_MASK			0x7f
> +#define MMA8452_FF_MT_THS_MASK			0x7f
> +
>  #define MMA8452_FF_MT_COUNT			0x18
> -#define MMA8452_FF_MT_CHAN_SHIFT	3
> +#define MMA8452_FF_MT_CHAN_SHIFT		3
> +
>  #define MMA8452_TRANSIENT_CFG			0x1d
> -#define  MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
> -#define  MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
> -#define  MMA8452_TRANSIENT_CFG_ELE		BIT(4)
> +#define MMA8452_TRANSIENT_CFG_CHAN(chan)	BIT(chan + 1)
> +#define MMA8452_TRANSIENT_CFG_HPF_BYP		BIT(0)
> +#define MMA8452_TRANSIENT_CFG_ELE		BIT(4)
> +
>  #define MMA8452_TRANSIENT_SRC			0x1e
> -#define  MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
> -#define  MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
> -#define  MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
> +#define MMA8452_TRANSIENT_SRC_XTRANSE		BIT(1)
> +#define MMA8452_TRANSIENT_SRC_YTRANSE		BIT(3)
> +#define MMA8452_TRANSIENT_SRC_ZTRANSE		BIT(5)
> +
>  #define MMA8452_TRANSIENT_THS			0x1f
> -#define  MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
> +#define MMA8452_TRANSIENT_THS_MASK		GENMASK(6, 0)
> +
>  #define MMA8452_TRANSIENT_COUNT			0x20
> -#define MMA8452_TRANSIENT_CHAN_SHIFT 1
> +#define MMA8452_TRANSIENT_CHAN_SHIFT		1
> +
>  #define MMA8452_CTRL_REG1			0x2a
> -#define  MMA8452_CTRL_ACTIVE			BIT(0)
> -#define  MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
> -#define  MMA8452_CTRL_DR_SHIFT			3
> -#define  MMA8452_CTRL_DR_DEFAULT		0x4 /* 50 Hz sample frequency */
> +#define MMA8452_CTRL_ACTIVE			BIT(0)
> +#define MMA8452_CTRL_DR_MASK			GENMASK(5, 3)
> +#define MMA8452_CTRL_DR_SHIFT			3
> +#define MMA8452_CTRL_DR_DEFAULT			0x4 /* 50 Hz sample frequency */
> +
>  #define MMA8452_CTRL_REG2			0x2b
> -#define  MMA8452_CTRL_REG2_RST			BIT(6)
> -#define  MMA8452_CTRL_REG2_MODS_SHIFT		3
> -#define  MMA8452_CTRL_REG2_MODS_MASK		0x1b
> +#define MMA8452_CTRL_REG2_RST			BIT(6)
> +#define MMA8452_CTRL_REG2_MODS_SHIFT		3
> +#define MMA8452_CTRL_REG2_MODS_MASK		0x1b
> +
>  #define MMA8452_CTRL_REG4			0x2d
>  #define MMA8452_CTRL_REG5			0x2e
>  #define MMA8452_OFF_X				0x2f
> @@ -88,9 +102,9 @@
>  
>  #define MMA8452_MAX_REG				0x31
>  
> -#define  MMA8452_INT_DRDY			BIT(0)
> -#define  MMA8452_INT_FF_MT			BIT(2)
> -#define  MMA8452_INT_TRANS			BIT(5)
> +#define MMA8452_INT_DRDY			BIT(0)
> +#define MMA8452_INT_FF_MT			BIT(2)
> +#define MMA8452_INT_TRANS			BIT(5)
>  
>  #define MMA8451_DEVICE_ID			0x1a
>  #define MMA8452_DEVICE_ID			0x2a
> @@ -134,33 +148,33 @@ struct mma8452_data {
>    * used for different chips and the relevant registers are included here.
>    */

The rest of the changes are fine if you want to respin the patch with the
earlier part dropped.

Jonathan

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

