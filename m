Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEF67154187
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 11:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgBFKFQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 05:05:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgBFKFP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 05:05:15 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 53CA521775;
        Thu,  6 Feb 2020 10:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580983514;
        bh=2aFep8wZ8W2pYINM/wm8aVztDsF3ePZ1IwnBn8+aiXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNUgZV58lkou4050sy3ZKV+/lHelDvOdJv6WBDToX/YhpICbFwrWmu1kVvcuqUj6S
         OqwOA9oZuF9XLgh43eKwIuONyQ8gyN7HZ8Z08wRvN0Fk1oDoKlRbg0zMp4bMxL4h7+
         ze4NvuCP7Znrq/wStLAkbMB84D7a3JuYM5sWHRuU=
Date:   Thu, 6 Feb 2020 10:05:11 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5 V2] Documentation: ABI: testing: ad7192: update
 sysfs docs
Message-ID: <20200206100511.3fe205d0@archlinux>
In-Reply-To: <20200205171511.25912-5-alexandru.tachici@analog.com>
References: <20200202162215.50915c83@archlinux>
        <20200205171511.25912-1-alexandru.tachici@analog.com>
        <20200205171511.25912-5-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 5 Feb 2020 19:15:10 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Updated mainline documentation on ad7192 userspace sysfs.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
looks good, but the shorted channel docs need to be added as well
unless I'm missing something.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192      | 17 ++++++++++------
>  .../iio/Documentation/sysfs-bus-iio-ad7192    | 20 -------------------
>  2 files changed, 11 insertions(+), 26 deletions(-)
>  delete mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index 7627d3be08f5..9be6b8a69a19 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -2,17 +2,22 @@ What:		/sys/bus/iio/devices/iio:deviceX/ac_excitation_en
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Reading gives the state of AC excitation.
> -		Writing '1' enables AC excitation.
> +		This attribute, if available, is used to enable the AC
> +		excitation mode found on some converters. In ac excitation mode,
> +		the polarity of the excitation voltage is reversed on
> +		alternate cycles, to eliminate DC errors.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/bridge_switch_en
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		This bridge switch is used to disconnect it when there is a
> -		need to minimize the system current consumption.
> -		Reading gives the state of the bridge switch.
> -		Writing '1' enables the bridge switch.
> +		This attribute, if available, is used to close or open the
> +		bridge power down switch found on some converters.
> +		In bridge applications, such as strain gauges and load cells,
> +		the bridge itself consumes the majority of the current in the
> +		system. To minimize the current consumption of the system,
> +		the bridge can be disconnected (when it is not being used
> +		using the bridge_switch_en attribute.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
>  KernelVersion:
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192 b/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
> deleted file mode 100644
> index 1c35c507cc05..000000000000
> --- a/drivers/staging/iio/Documentation/sysfs-bus-iio-ad7192
> +++ /dev/null
> @@ -1,20 +0,0 @@
> -What:		/sys/.../iio:deviceX/ac_excitation_en
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This attribute, if available, is used to enable the AC
> -		excitation mode found on some converters. In ac excitation mode,
> -		the polarity of the excitation voltage is reversed on
> -		alternate cycles, to eliminate DC errors.
> -
> -What:		/sys/.../iio:deviceX/bridge_switch_en
> -KernelVersion:	3.1.0
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		This attribute, if available, is used to close or open the
> -		bridge power down switch found on some converters.
> -		In bridge applications, such as strain gauges and load cells,
> -		the bridge itself consumes the majority of the current in the
> -		system. To minimize the current consumption of the system,
> -		the bridge can be disconnected (when it is not being used
> -		using the bridge_switch_en attribute.

