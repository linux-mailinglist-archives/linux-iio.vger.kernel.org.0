Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAFE2BC10C
	for <lists+linux-iio@lfdr.de>; Sat, 21 Nov 2020 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgKURXC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 21 Nov 2020 12:23:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:41072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgKURXC (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Nov 2020 12:23:02 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4DF8208CA;
        Sat, 21 Nov 2020 17:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605979382;
        bh=yG2OGMLqiBkxwmYUNcyYmCrFrypiBHz3ksLoG91LVDg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gjunsitt6iiGoM0+hr+GV4rs9pyY5IpsRUW4QXditBE/s/y3+eO8LwCSXa2EpiaPy
         EVNbj+uRohX35CA/OzUXtmEyPiWfd5w6QWP2Qx7EC/i8RN3HLZJpH/tpzxu7bUNCnu
         v6O1eGrt5YEnmEoddCTRSXXHALmz25KNC0f50axQ=
Date:   Sat, 21 Nov 2020 17:22:57 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: hid-sensor-trigger: Decrement runtime pm
 enable count on driver removal
Message-ID: <20201121172257.59fa05d5@archlinux>
In-Reply-To: <20201119100331.2594-3-xiang.ye@intel.com>
References: <20201119100331.2594-1-xiang.ye@intel.com>
        <20201119100331.2594-3-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 19 Nov 2020 18:03:29 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> To avoid pm_runtime_disable called repeatedly by hid sensor drivers,
> decrease runtime pm enable count after call it.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
This sounds like a fix.  If so please make that clear and add a fixes tag.

If it couldn't have been triggered before, then please explain why in this
patch description.

Thanks,

Jonathan

> ---
>  drivers/iio/common/hid-sensors/hid-sensor-trigger.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> index ff375790b7e8..30340abcbc8d 100644
> --- a/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> +++ b/drivers/iio/common/hid-sensors/hid-sensor-trigger.c
> @@ -227,8 +227,10 @@ static int hid_sensor_data_rdy_trigger_set_state(struct iio_trigger *trig,
>  void hid_sensor_remove_trigger(struct iio_dev *indio_dev,
>  			       struct hid_sensor_common *attrb)
>  {
> -	if (atomic_read(&attrb->runtime_pm_enable))
> +	if (atomic_read(&attrb->runtime_pm_enable)) {
>  		pm_runtime_disable(&attrb->pdev->dev);
> +		atomic_dec(&attrb->runtime_pm_enable);
> +	}
>  
>  	pm_runtime_set_suspended(&attrb->pdev->dev);
>  	pm_runtime_put_noidle(&attrb->pdev->dev);

