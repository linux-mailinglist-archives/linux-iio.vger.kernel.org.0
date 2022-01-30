Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3FC4A3646
	for <lists+linux-iio@lfdr.de>; Sun, 30 Jan 2022 13:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354796AbiA3Mep (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 30 Jan 2022 07:34:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:58194 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354795AbiA3Meo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 30 Jan 2022 07:34:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 570CAB82921
        for <linux-iio@vger.kernel.org>; Sun, 30 Jan 2022 12:34:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA10FC340E4;
        Sun, 30 Jan 2022 12:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643546082;
        bh=0toZ3pZyC/Wy3X9Cx3KUWPtAY0odPP5+z3iXEp7K0Qw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f7c0ZRc7QA18WktbKaIYhnhRsdScDDIbHfvse7RqelNfOQ61UnmSeHYpynmQqaFQd
         DMTs9TbpYEVuP+f/rnPigZikqywZG05r3sv6mwHVnrarv/YuKFcqlEs8nlh+Iz03xq
         jxN8DRxpoI02jI60oGKbIuycLcxb5eKcQaughoG0wd4Ceu3FafneOqlsNMqMULbYZW
         oCDdsMO1DgFJnhOLuGbKDxNKNqaQCfFdZpDJUzXRSCSCLLibjoX5OsEcFVPK9ISgEB
         kwtrdyT9DiU5K6zT/Kn0B9XgPlRvEud9qVpmR/1qw0j28wywsx2c2PWkYzM16laOcO
         6IcPwrh93XdhQ==
Date:   Sun, 30 Jan 2022 12:41:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org,
        Jongpil Jung <jongpil19.jung@samsung.com>
Subject: Re: [PATCH v2] iio: sx9360: fix iio event generation
Message-ID: <20220130124105.23ed6bdb@jic23-huawei>
In-Reply-To: <20220122213444.745152-1-gwendal@chromium.org>
References: <20220122213444.745152-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 22 Jan 2022 13:34:44 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> From: Jongpil Jung <jongpil19.jung@samsung.com>
> 
> To convert SX9360 status register ["REG_STAT"], into a channel
> index, we need to right shift by |stat_offset|, not left shift.
> Also the PROXSTAT bit (3) is for channel 1 (PHM, Phase Measured), not (PHR,
> Phase Reference, channel 0), so the offset is 2 instead of 3.
> 
> Fixes: f75095753 ("iio:proximity:sx9360: Add sx9360 support")
Should be 12 chars of the hash.

Also, tree rebased at rc1 so it's wrong anyway :)

Fixed it up and applied to the togreg branch of iio.git and pushed
out as testing for 0-day to see if it can find anything else.

Thanks,

Jonathan

> Signed-off-by: Jongpil Jung <jongpil19.jung@samsung.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
> Changes since v1:
> - Change title to highlight the patch is a fix.
> - Put "Fixes:" tag in the commit message footer
> 
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

