Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDA6F6A7B
	for <lists+linux-iio@lfdr.de>; Sun, 10 Nov 2019 18:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbfKJRH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 10 Nov 2019 12:07:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:52836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbfKJRH2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 10 Nov 2019 12:07:28 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D804E2080F;
        Sun, 10 Nov 2019 17:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573405647;
        bh=qR+eCMLEC9F14EZhf+b34l4RlDa8lL3eoGdKf1oAhao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uiid3y3iobMwPN5uuGEoc3+dpY9njjFvf6P+PTQpt4h7PSrgFmNkVRtx5KVkH1zjn
         HuCpva/CiUh2yQ+DcA8mTRqHoNOQyRWmmENVjbkBwfebFasuxqnrR0hbgRT/Wg2Tw0
         RPbFmF2yUp5T1h3n7vvlGlc9+ahdFO9SjHscVw+4=
Date:   Sun, 10 Nov 2019 17:07:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, mripard@kernel.org,
        shawnguo@kernel.org, heiko@sntech.de, icenowy@aosc.io,
        laurent.pinchart@ideasonboard.com, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        christophe.jaillet@wanadoo.fr, tglx@linutronix.de,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        paulmck@linux.ibm.com, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] iio: add ping sensors to kernel configuration
Message-ID: <20191110170720.1731c731@archlinux>
In-Reply-To: <20191107130108.p6maggrs2m7va5pf@arbad>
References: <20191107130108.p6maggrs2m7va5pf@arbad>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 7 Nov 2019 14:01:11 +0100
Andreas Klinger <ak@it-klinger.de> wrote:

> Add a new configuration variable CONFIG_PING for the newly supported
> parallax ping sensors.
> 
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
Merge with patch 3 please.

Thanks,

Jonathan

> ---
>  drivers/iio/proximity/Kconfig  | 15 +++++++++++++++
>  drivers/iio/proximity/Makefile |  1 +
>  2 files changed, 16 insertions(+)
> 
> diff --git a/drivers/iio/proximity/Kconfig b/drivers/iio/proximity/Kconfig
> index d53601447da4..37606d400805 100644
> --- a/drivers/iio/proximity/Kconfig
> +++ b/drivers/iio/proximity/Kconfig
> @@ -58,6 +58,21 @@ config MB1232
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called mb1232.
>  
> +config PING
> +	tristate "Parallax GPIO bitbanged ranger sensors"
> +	depends on GPIOLIB
> +	help
> +	  Say Y here to build a driver for GPIO bitbanged ranger sensors
> +	  with just one GPIO for the trigger and echo. This driver can be
> +	  used to measure the distance of objects.
> +
> +	  Actually supported are:
> +	  - Parallax PING))) (ultrasonic)
> +	  - Parallax LaserPING (time-of-flight)
> +
> +	  To compile this driver as a module, choose M here: the
> +	  module will be called ping.
> +
>  config RFD77402
>  	tristate "RFD77402 ToF sensor"
>  	depends on I2C
> diff --git a/drivers/iio/proximity/Makefile b/drivers/iio/proximity/Makefile
> index 0bb5f9de13d6..c591b019304e 100644
> --- a/drivers/iio/proximity/Makefile
> +++ b/drivers/iio/proximity/Makefile
> @@ -8,6 +8,7 @@ obj-$(CONFIG_AS3935)		+= as3935.o
>  obj-$(CONFIG_ISL29501)		+= isl29501.o
>  obj-$(CONFIG_LIDAR_LITE_V2)	+= pulsedlight-lidar-lite-v2.o
>  obj-$(CONFIG_MB1232)		+= mb1232.o
> +obj-$(CONFIG_PING)		+= ping.o
>  obj-$(CONFIG_RFD77402)		+= rfd77402.o
>  obj-$(CONFIG_SRF04)		+= srf04.o
>  obj-$(CONFIG_SRF08)		+= srf08.o

