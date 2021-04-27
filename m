Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C0036CA71
	for <lists+linux-iio@lfdr.de>; Tue, 27 Apr 2021 19:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbhD0Rhn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 27 Apr 2021 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235974AbhD0Rhn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 27 Apr 2021 13:37:43 -0400
Received: from balrog.mythic-beasts.com (balrog.mythic-beasts.com [IPv6:2a00:1098:0:82:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D0C061574;
        Tue, 27 Apr 2021 10:36:58 -0700 (PDT)
Received: from [81.101.6.87] (port=41356 helo=jic23-huawei)
        by balrog.mythic-beasts.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1lbRdl-0007qa-5k; Tue, 27 Apr 2021 18:36:57 +0100
Date:   Tue, 27 Apr 2021 18:37:36 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: Re: [RFC PATCH 7/7] iio:ABI docs: Move specific description of
 out_altvoltageX_frequency to main docs.
Message-ID: <20210427183736.3799a03d@jic23-huawei>
In-Reply-To: <20210117153816.696693-8-jic23@kernel.org>
References: <20210117153816.696693-1-jic23@kernel.org>
        <20210117153816.696693-8-jic23@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BlackCat-Spam-Score: 19
X-Spam-Status: No, score=1.9
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 17 Jan 2021 15:38:16 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> The adf4371 has channels that are very closely coupled, so additional
> documentation is needed to express these constraints.
> Unfortunately having the same sysfs filename in multiple documentation
> does not work well when generating automated documentation.
> To avoid this issue, we add a new device specific description to the
> main docs and remove the one in the device specific file.
> 
> Fixes:
> $ scripts/get_abi.pl validate
> Warning: /sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency is defined 2 times:  ./Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371:0  ./Documentation/ABI/testing/sysfs-bus-iio:599
> 
> Cc: Alexandru Ardelean <alexandru.ardelean@analog.com>
> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Applied.

Thanks,

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio       | 19 ++++++++++++++
>  .../testing/sysfs-bus-iio-frequency-adf4371   | 25 -------------------
>  2 files changed, 19 insertions(+), 25 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index ed50f4b21dcc..515c4290d43d 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -620,6 +620,25 @@ Description:
>  		Output frequency for channel Y in Hz. The number must always be
>  		specified and unique if the output corresponds to a single
>  		channel.
> +		Some drivers have additional constraints:
> +		ADF4371 has an integrated VCO with fundamendal output
> +		frequency ranging from 4000000000 Hz 8000000000 Hz.
> +
> +		out_altvoltage0_frequency:
> +			A divide by 1, 2, 4, 8, 16, 32 or circuit generates
> +			frequencies from 62500000 Hz to 8000000000 Hz.
> +		out_altvoltage1_frequency:
> +			This channel duplicates the channel 0 frequency
> +		out_altvoltage2_frequency:
> +			A frequency doubler generates frequencies from
> +			8000000000 Hz to 16000000000 Hz.
> +		out_altvoltage3_frequency:
> +			A frequency quadrupler generates frequencies from
> +			16000000000 Hz to 32000000000 Hz.
> +
> +		Note: writes to one of the channels will affect the frequency of
> +		all the other channels, since it involves changing the VCO
> +		fundamental output frequency.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_phase
>  KernelVersion:	3.4.0
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> index 457f75903963..7fe6935d1448 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4371
> @@ -1,28 +1,3 @@
> -What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
> -KernelVersion:
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Stores the PLL frequency in Hz for channel Y.
> -		Reading returns the actual frequency in Hz.
> -		The ADF4371 has an integrated VCO with fundamendal output
> -		frequency ranging from 4000000000 Hz 8000000000 Hz.
> -
> -		out_altvoltage0_frequency:
> -			A divide by 1, 2, 4, 8, 16, 32 or circuit generates
> -			frequencies from 62500000 Hz to 8000000000 Hz.
> -		out_altvoltage1_frequency:
> -			This channel duplicates the channel 0 frequency
> -		out_altvoltage2_frequency:
> -			A frequency doubler generates frequencies from
> -			8000000000 Hz to 16000000000 Hz.
> -		out_altvoltage3_frequency:
> -			A frequency quadrupler generates frequencies from
> -			16000000000 Hz to 32000000000 Hz.
> -
> -		Note: writes to one of the channels will affect the frequency of
> -		all the other channels, since it involves changing the VCO
> -		fundamental output frequency.
> -
>  What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_name
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org

