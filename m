Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEB9D9CB63
	for <lists+linux-iio@lfdr.de>; Mon, 26 Aug 2019 10:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbfHZIPn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 26 Aug 2019 04:15:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727951AbfHZIPn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 26 Aug 2019 04:15:43 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49DAE206BA;
        Mon, 26 Aug 2019 08:15:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566807341;
        bh=o46p+1wEJqHNxnPFY9zwnbijwyf1vyUPApcaVBqttjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eBVQ8VdzJxQqJMkSFiqjx4vTbtutkgBYvowmS97iIKq4vIOtejWME0yWED/aJFvEk
         Ke03/HewJ/DLWin96UngA6PyncmMSSpZnIMkvw0WFyumnlKcURLKQEF9ia3+8JCkVU
         StHkE0EubJErO1BdylmBXNoYHNwgK1RvjhLi8IZU=
Date:   Mon, 26 Aug 2019 09:15:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mario Tesi <martepisa@gmail.com>
Cc:     lorenzo.bianconi83@gmail.com, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.tesi@st.com
Subject: Re: [PATCH] iio: imu: st_lsm6dsx: Fix FIFO diff mask for tagged
 fifo
Message-ID: <20190826091537.66e07ec9@archlinux>
In-Reply-To: <1566480139-4015-1-git-send-email-martepisa@gmail.com>
References: <1566480139-4015-1-git-send-email-martepisa@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 22 Aug 2019 15:22:19 +0200
Mario Tesi <martepisa@gmail.com> wrote:

> From: mario tesi <mario.tesi@st.com>
> 
> 	According to the latest version of datasheet the mask
> 	for number of unread sensor data in FIFO_STATUS registers
> 	has been extended to 10 bits
> 
> 	The devices involved are:
> 	 - LSM6DSO
> 	 - LSM6DSOX
> 	 - ASM330LHH
> 	 - LSM6DSR
> 	 - ISM330DHCX
> 
> Signed-off-by: mario tesi <mario.tesi@st.com>

Seems straight forward and should be side effect free I think.
Hence I won't wait for Lorenzo to take a look (though there
is still a small window for comments whilst the autobuilders
poke at it!)

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to take a look.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> index 85824d6..47b77d0 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -497,7 +497,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  			.fifo_diff = {
>  				.addr = 0x3a,
> -				.mask = GENMASK(8, 0),
> +				.mask = GENMASK(9, 0),
>  			},
>  			.th_wl = 1,
>  		},
> @@ -623,7 +623,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  			.fifo_diff = {
>  				.addr = 0x3a,
> -				.mask = GENMASK(8, 0),
> +				.mask = GENMASK(9, 0),
>  			},
>  			.th_wl = 1,
>  		},
> @@ -726,7 +726,7 @@ static const struct st_lsm6dsx_settings st_lsm6dsx_sensor_settings[] = {
>  			},
>  			.fifo_diff = {
>  				.addr = 0x3a,
> -				.mask = GENMASK(8, 0),
> +				.mask = GENMASK(9, 0),
>  			},
>  			.th_wl = 1,
>  		},

