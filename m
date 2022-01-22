Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCBC496D13
	for <lists+linux-iio@lfdr.de>; Sat, 22 Jan 2022 18:23:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234599AbiAVRXe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 Jan 2022 12:23:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39852 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbiAVRXd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 Jan 2022 12:23:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C6A27B80AB1
        for <linux-iio@vger.kernel.org>; Sat, 22 Jan 2022 17:23:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FC9C004E1;
        Sat, 22 Jan 2022 17:23:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642872211;
        bh=nxkP0wle0FNzDE+0zarLnzRHdZ8KOeCA5Rqwq9RytM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IIU+MYBYXm5ooD+7T4qa9mYNWZCF2aDKStFzhZTARzC8P9YZwp59Ej6k157Qoacrz
         IzXoDj+1n2U39NDyUfJbzZcd3tniChmpQHSR/wfCR8xBBggNVhSwfSxBjv0p4lt2qq
         rtZLmCQrjMYHtpTszaRrXEvuT+4/suPOdKBOLjT5xz2iq/fxXBldAVjFBkNzzpF0yz
         1YXQ4Byo1VoUTRbn3CzhmUjD6ZOYJKiA28Ko6Dwg9WQq2BmwflahnC0+9mwhL3MbvF
         FlEsLm2Yovn2XFULGOuNZ4YuSH03Yb2GEs49DVmCzTejgKNpe/b1B6hb+pApMQ/7Oc
         QDjaR54QWpXEQ==
Date:   Sat, 22 Jan 2022 17:29:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     jongpil19.jung@samsung.com, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: sx9360: enable push iio event
Message-ID: <20220122172940.125d8033@jic23-huawei>
In-Reply-To: <20220118212504.832429-1-gwendal@chromium.org>
References: <20220118212504.832429-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 18 Jan 2022 13:25:04 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> From: Jongpil Jung <jongpil19.jung@samsung.com>

Hi, 

Patch title is not really clear. It suggests this is enabling
a new feature rather than fixing anything.  Please rephrase.

> 
> Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")
This is part of the tag block so should appear.
> 
> To convert SX9360 status register ["REG_STAT"], into a channel
> index, we need to right shift by |stat_offset|, not left shift.
> Also the PROXSTAT bit (3) is for channel 1 (PHM, PHase Measured), not (PHR,
> PHase Reference, channel 0), so the offset is 2 instead of 3.
> 
Phase 

fixes tag should be here.
> Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/sx9360.c    | 2 +-
>  drivers/iio/proximity/sx_common.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/sx9360.c b/drivers/iio/proximity/sx9360.c
> index 6fd6561bb6f5b8..3ebb30c8a4f61d 100644
> --- a/drivers/iio/proximity/sx9360.c
> +++ b/drivers/iio/proximity/sx9360.c
> @@ -775,7 +775,7 @@ static const struct sx_common_chip_info sx9360_chip_info = {
>  	.reg_reset = SX9360_REG_RESET,
>  
>  	.mask_enable_chan = SX9360_REG_GNRL_CTRL0_PHEN_MASK,
> -	.stat_offset = 3,
> +	.stat_offset = 2,
>  	.num_channels = SX9360_NUM_CHANNELS,
>  	.num_default_regs = ARRAY_SIZE(sx9360_default_regs),
>  
> diff --git a/drivers/iio/proximity/sx_common.c b/drivers/iio/proximity/sx_common.c
> index ac8fd5920481cb..a7c07316a0a91e 100644
> --- a/drivers/iio/proximity/sx_common.c
> +++ b/drivers/iio/proximity/sx_common.c
> @@ -87,7 +87,7 @@ static void sx_common_push_events(struct iio_dev *indio_dev)
>  		return;
>  	}
>  
> -	val <<= data->chip_info->stat_offset;
> +	val >>= data->chip_info->stat_offset;
>  
>  	/*
>  	 * Only iterate over channels with changes on proximity status that have

