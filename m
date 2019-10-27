Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 426D4E6448
	for <lists+linux-iio@lfdr.de>; Sun, 27 Oct 2019 17:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfJ0Qo1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Oct 2019 12:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:50838 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726682AbfJ0Qo1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 27 Oct 2019 12:44:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED8D121726;
        Sun, 27 Oct 2019 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572194666;
        bh=XwS5i6MNNhwp8I5DB1OdPHCvAwnv3Rif4k1pFCPwCzA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DQrl9SdB02jUANet0M/EyTNtAtCzKuT4tWm+PE/xkZOVHa6RDcho9Keu5Z5UrYjjr
         z7w+AxjjhF/FFLuW7ns7v+bIoIBczrz1WIKK2aqAg+eWvkXzedECrPuJDeTeX+Rnmu
         Wz7hLjQpyyQ3Ax4okjHkTPDWMC5KOMdA8qmrvLeQ=
Date:   Sun, 27 Oct 2019 16:44:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rishi Gupta <gupt21@gmail.com>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        allison@lohutok.net, alexios.zavras@intel.com, angus@akkea.ca,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iio: documentation: light: Add veml6030 sysfs
 documentation
Message-ID: <20191027164420.2a1aa82c@archlinux>
In-Reply-To: <1571749887-9054-1-git-send-email-gupt21@gmail.com>
References: <1571749887-9054-1-git-send-email-gupt21@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 22 Oct 2019 18:41:27 +0530
Rishi Gupta <gupt21@gmail.com> wrote:

> The driver for veml6030 light sensor provides sysfs
> entries like configuring cutoff for interrupt. This
> commit document them.
> 
> Signed-off-by: Rishi Gupta <gupt21@gmail.com>
> ---
> Changes in v5:
> * Use ABI/testing/sysfs-bus-iio to document sysfs files for veml6030
> 
> Changes in v4:
> * None
> 
> Changes in v3:
> * Updated Date from September to October
> * Updated KernelVersion from 5.3.1 to 5.4
> * in_illuminance_period_available is now in events directory
> 
> Changes in v2:
> * None
> 
>  Documentation/ABI/testing/sysfs-bus-iio | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6804516..a26d532 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -753,6 +753,8 @@ What:		/sys/.../events/in_illuminance0_thresh_falling_value
>  what:		/sys/.../events/in_illuminance0_thresh_rising_value
>  what:		/sys/.../events/in_proximity0_thresh_falling_value
>  what:		/sys/.../events/in_proximity0_thresh_rising_value
> +What:		/sys/.../events/in_illuminance_thresh_rising_value
> +What:		/sys/.../events/in_illuminance_thresh_falling_value
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -972,6 +974,7 @@ What:		/sys/.../events/in_activity_jogging_thresh_rising_period
>  What:		/sys/.../events/in_activity_jogging_thresh_falling_period
>  What:		/sys/.../events/in_activity_running_thresh_rising_period
>  What:		/sys/.../events/in_activity_running_thresh_falling_period
> +What:		/sys/.../events/in_illuminance_thresh_either_period
>  KernelVersion:	2.6.37
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -1715,3 +1718,12 @@ Description:
>  		Mass concentration reading of particulate matter in ug / m3.
>  		pmX consists of particles with aerodynamic diameter less or
>  		equal to X micrometers.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/events/in_illuminance_period_available
> +Date:		October 2019
> +KernelVersion:	5.4
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		List of valid values available in multiples of integration time
> +		for which the light intensity must be above the threshold level
> +		before interrupt is asserted. This refers to persistence values.

This doesn't match with in_illuminance_period (which is correct).  The period values
a are in seconds, not multiples of the integration time.  The reason is that firstly
integration time may not be related to sampling frequency (which actually matters here)
and secondly it's much easier for userspace to set these period values to say something
is true for 0.1 seconds rather than having to work out the relationship with the devices
internal sampling rates.


Thanks,

Jonathan

