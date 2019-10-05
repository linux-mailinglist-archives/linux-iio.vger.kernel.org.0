Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB765CCA43
	for <lists+linux-iio@lfdr.de>; Sat,  5 Oct 2019 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfJEOL1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Oct 2019 10:11:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:58552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbfJEOL0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Oct 2019 10:11:26 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6E2520862;
        Sat,  5 Oct 2019 14:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570284685;
        bh=Iu6/Q+vHoIMIRH9O25dGaFDV9Yyhmxx1UXt4XXHmCUY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=M9fVnyxZdlzJTmkp1GT/sKulEb54fc9V6XtZ/l498GnX9GHsofAq0xsyhYnuBM2zk
         ++fyzNY7ZQTXXjO7JvVgtzJPtYNgXwyzXTRjox7XtYWUF/Q0bnekSvqKOuT9AbHjLW
         Aj99SSadsZlZoq1Zu+7JudXAQuvGIv/xCW6DeGNI=
Date:   Sat, 5 Oct 2019 15:11:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hslester96@gmail.com, wsa+renesas@sang-engineering.com
Subject: Re: [RESEND PATCH v2 3/3] iio: documentation: light: Add veml6030
 sysfs documentation
Message-ID: <20191005151119.56c65d71@archlinux>
In-Reply-To: <35614391cf5e79765a6151ce998a213544562a37.1569321085.git.gupt21@gmail.com>
References: <cover.1569321085.git.gupt21@gmail.com>
        <35614391cf5e79765a6151ce998a213544562a37.1569321085.git.gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 24 Sep 2019 16:21:58 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> The driver for veml6030 light sensor provides custom sysfs entries
> used to know parameters supported by the driver and to configure
> sensor like setting power saving mode and persistence etc. This
> commit document them.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v2:
> * Nothing has changed in this file
> 
>  .../ABI/testing/sysfs-bus-iio-light-veml6030       | 49 ++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030 b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> new file mode 100644
> index 0000000..13589c9
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-light-veml6030
> @@ -0,0 +1,49 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm_available
> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Provides list of valid values that can be used to activate a
> +		particular power saving mode in sensor. For ex; 1 means psm
> +		mode 1 and 2 means psm mode 2.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_psm

Peter was a bit confusing on this. Much of the interface is standard ABI
(or falls within the ABI that is constructed so should be in the main docs -
a particularly combination may be missing and should be added).

psm is the one exception I can see so if we decide to keep it, will indeed
need to be documented here.

However, custom ABI is always problematic as generic userspace code will never
know what to do with it.  So if it is possible to map to standard ABI that
is always a better idea.

> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Writing '1' will activate power saving mode 1 in sensor.
> +		Similarly, 2 is to activate psm mode 2 and so on.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_illuminance_period_available

As I mentioned in the review of the driver, this is a characteristic of the event
so should be in the events directory.

> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		List of valid values available in multiples of integration time
> +		for which the light intensity must be above the cutoff level
> +		before interrupt is asserted. This refers to persistence values.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_either_period
> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Value in multiple of integration time for which the light intensity must
> +		be above the cutoff level before interrupt is asserted.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_rising_value
> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
> +		light intensity is above this value.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_thresh_falling_value
> +Date:		September 2019
> +KernelVersion:	5.3.1
> +Contact:	Rishi Gupta <gupt21@gmail.com>
> +Description:
> +		Raw threshold value from 0 to 0xffffffff. An interrupt will be asserted whenever
> +		light intensity is below this value.

