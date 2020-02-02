Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 937A714FE3B
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 17:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgBBQSJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 11:18:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726947AbgBBQSJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 11:18:09 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 104CB20643;
        Sun,  2 Feb 2020 16:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580660288;
        bh=DFlvCNwEUCoYhh6ULMgm7xDGmYNjx/yiWgvXuvumBZI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Szq3nwpqfdHmodWCUCWrlwU9CM5QFQDpZwMf7yeKRfSuSdcsHDVKjV32yWpmI8PaJ
         5jZKzMyk3p5Wvm34xUEjvBWde8kzXR1e7D6LeGS6OdawrzK3sEtiYA/f7TZnvYhMRj
         frc1RnskTSJ/ZHs76ES7N4gT29CvaYPxK7bnSBu8=
Date:   Sun, 2 Feb 2020 16:18:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Alexandru Tachici <alexandru.tachici@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Documentation: ABI: testing: ad7192: update sysfs
 docs
Message-ID: <20200202161805.3758ee4a@archlinux>
In-Reply-To: <20200122143700.6069-2-alexandru.tachici@analog.com>
References: <20200122143700.6069-1-alexandru.tachici@analog.com>
        <20200122143700.6069-2-alexandru.tachici@analog.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 22 Jan 2020 16:36:59 +0200
Alexandru Tachici <alexandru.tachici@analog.com> wrote:

> Updated mainline documentation on ad7192 userspace sysfs.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
Minor bracket missing, otherwise looks good.

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
Missing bracket.
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

