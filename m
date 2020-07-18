Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A50224C5F
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jul 2020 17:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgGRPRd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Jul 2020 11:17:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:38970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbgGRPRd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 18 Jul 2020 11:17:33 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4EB1C20775;
        Sat, 18 Jul 2020 15:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595085452;
        bh=BKNVe9fgnfqAHXaTZBDQXkmm6++oSD277VPzoltC4t8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s42pLxPyMt7gImBXNBgaVoHkq3TeaCW/j6jzSa/ngTX3ouORea9/7T4obK+xxcFZJ
         zwjJ1UTz+O8poGCWD8KjlEKsJVVqhf6bsFpJuTdvpoz98p6EQHJVk1gNIjyoN+xOaE
         ya6eEJwLSRSYeWCAuUh0csSMLHUWb56e6GqCmvtY=
Date:   Sat, 18 Jul 2020 16:17:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@intel.com>
Subject: Re: [PATCH 29/30] iio: imu: kmx61: Fix formatting in kerneldoc
 function headers
Message-ID: <20200718161728.2faa55f2@archlinux>
In-Reply-To: <20200716135928.1456727-30-lee.jones@linaro.org>
References: <20200716135928.1456727-1-lee.jones@linaro.org>
        <20200716135928.1456727-30-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 16 Jul 2020 14:59:27 +0100
Lee Jones <lee.jones@linaro.org> wrote:

> Kerneldoc expects attributes/parameters to be in '@*.: ' format.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'data' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'mode' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'device' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:327: warning: Function parameter or member 'update' not described in 'kmx61_set_mode'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'data' not described in 'kmx61_set_power_state'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'on' not described in 'kmx61_set_power_state'
>  drivers/iio/imu/kmx61.c:731: warning: Function parameter or member 'device' not described in 'kmx61_set_power_state'
> 
> Cc: Daniel Baluta <daniel.baluta@intel.com>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Applied.
Thanks,

Jonathan

> ---
>  drivers/iio/imu/kmx61.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/imu/kmx61.c b/drivers/iio/imu/kmx61.c
> index e67466100aff4..d0cee2e09884d 100644
> --- a/drivers/iio/imu/kmx61.c
> +++ b/drivers/iio/imu/kmx61.c
> @@ -312,10 +312,10 @@ static int kmx61_convert_wake_up_odr_to_bit(int val, int val2)
>  
>  /**
>   * kmx61_set_mode() - set KMX61 device operating mode
> - * @data - kmx61 device private data pointer
> - * @mode - bitmask, indicating operating mode for @device
> - * @device - bitmask, indicating device for which @mode needs to be set
> - * @update - update stby bits stored in device's private  @data
> + * @data: kmx61 device private data pointer
> + * @mode: bitmask, indicating operating mode for @device
> + * @device: bitmask, indicating device for which @mode needs to be set
> + * @update: update stby bits stored in device's private  @data
>   *
>   * For each sensor (accelerometer/magnetometer) there are two operating modes
>   * STANDBY and OPERATION. Neither accel nor magn can be disabled independently
> @@ -718,9 +718,9 @@ static int kmx61_setup_any_motion_interrupt(struct kmx61_data *data,
>  
>  /**
>   * kmx61_set_power_state() - set power state for kmx61 @device
> - * @data - kmx61 device private pointer
> - * @on - power state to be set for @device
> - * @device - bitmask indicating device for which @on state needs to be set
> + * @data: kmx61 device private pointer
> + * @on: power state to be set for @device
> + * @device: bitmask indicating device for which @on state needs to be set
>   *
>   * Notice that when ACC power state needs to be set to ON and MAG is in
>   * OPERATION then we know that kmx61_runtime_resume was already called

