Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72913224C5C
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgGRPQp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:16:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:38830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPQp (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:16:45 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1DFFB2076A;
        Sat, 18 Jul 2020 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085404;
        bh=35faZSalQB+cqTbX1R2VNGg6wNJC60ycGnCnnnSFeUw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GQXiioKh2xzlwlYfRQF87o/7SX0vTb0COerHrKePioeTcLwiMCHI9pKGO4hK4KK13
         K36kr0J6TWfP5UOZhl8yQBDgk03QoKSbKcp38ghMznXE629HgwRZz2qKj4d7QepVVS
         L7rGtEH+m/1HxvSwMVRpUN6Sf5x64qvmgFitTY1k=
Date:   Sat, 18 Jul 2020 16:16:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 28/30] iio: magnetometer: mmc35240: Fix function header
 formatting
Message-ID: <20200718161640.70fce581@archlinux>
In-Reply-To: <20200716135928.1456727-29-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-29-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:26 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> All lines in the header must start with " *".
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/magnetometer/mmc35240.c:304: warning: bad line:                             compensation for output value.
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
I tweaked this one a tiny bit to drop the brackets you added.
I remember looking this up recently and they are optional in the kernel-doc
format.  Adds a very small amount of confusion perhaps to add them in here.

Applied


> ---
>  drivers/iio/magnetometer/mmc35240.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/magnetometer/mmc35240.c b/drivers/iio/magnetometer/mmc35240.c
> index 1787d656d0094..19e46b1f4ee81 100644
> --- a/drivers/iio/magnetometer/mmc35240.c
> +++ b/drivers/iio/magnetometer/mmc35240.c
> @@ -300,8 +300,8 @@ static int mmc35240_read_measurement(struct mmc35240_data *data, __le16 buf[3])
>  }
>  
>  /**
> - * mmc35240_raw_to_mgauss - convert raw readings to milli gauss. Also apply
> -			    compensation for output value.
> + * mmc35240_raw_to_mgauss() - convert raw readings to milli gauss. Also apply
> + *			      compensation for output value.
>   *
>   * @data: device private data
>   * @index: axis index for which we want the conversion

