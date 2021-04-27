Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A96036CA61
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhD0Rdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhD0Rdj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 13:33:39 -0400
X-Greylist: delayed 196 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Apr 2021 10:32:56 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617BFC061574;
        Tue, 27 Apr 2021 10:32:56 -0700 (PDT)
Received: from [81.101.6.87] (port=33696 helo=jic23-huawei)
        by haggis.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1lbRZu-0000ul-IV; Tue, 27 Apr 2021 18:32:55 +0100
Date:   Tue, 27 Apr 2021 18:33:38 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [RFC PATCH 3/7] iio:ABI docs: Drop device specific docs for
 _powerdown for the adf4371
Message-ID: <20210427183321.656b7625@jic23-huawei>
In-Reply-To: <20210117153816.696693-4-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-4-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jan 2021 15:38:12 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The interface is standard and the extra info provided on exactly what is
> being powered down is not of interest to most users.  Hence this doesn't
> need it's own documentation and can rely on the docs in sysfs-bus-iio
> 
> Fixes:
> $ scripts/get_abi.pl validate
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:36  ./Documentation/ABI/testing/sysfs-bus-iio:588
> 
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
I'm guessing I can't make a mistake removing docs :)

Applied to the togreg branch of iio.git and pushed out as testing for the
autobuilders to do nothing with it.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> index 544548ee794c..457f75903963 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> @@ -34,11 +34,3 @@ Description:
>  		  out_altvoltage2_name: RF16x
>  		  out_altvoltage3_name: RF32x
>  
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_powerdown
> -KernelVersion:
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This attribute allows the user to power down the PLL and it's
> -		RFOut buffers.
> -		Writing 1 causes the specified channel to power down.
> -		Clearing returns to normal operation.

