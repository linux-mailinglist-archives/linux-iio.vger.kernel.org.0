Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A67C22786B9
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgIYMMH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:12:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:33752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYMMG (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:12:06 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F1E52083B;
        Fri, 25 Sep 2020 12:12:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601035925;
        bh=DS9lQ44IRF3hy2iyiawAQdvx8fxyZmSPePpmJgDEQFk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kn7IfdTUzEM8awtCfJfFwJskPVmN0CDkovLQIObebog0PcmqSiERMhUCzLeV8PuR4
         ht+1J2k+xWbpoatxL6pcoIf8rqJHWcF4PHPs/LjmDPX9L2u7r4ckuP0q6tAdcK6Cmp
         WRU8kRFVi0Pu3C9IqGOFDLLlQybCoCbA7VssxBFs=
Date:   Fri, 25 Sep 2020 13:12:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cristian Pop <cristian.pop@analog.com>
Cc:     <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/4] iio:Documentation: Add documentation for label
 channel attribute
Message-ID: <20200925131200.458d68a1@archlinux>
In-Reply-To: <20200921133020.62978-2-cristian.pop@analog.com>
References: <20200921133020.62978-1-cristian.pop@analog.com>
        <20200921133020.62978-2-cristian.pop@analog.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Sep 2020 16:30:18 +0300
Cristian Pop <cristian.pop@analog.com> wrote:

> If a label is defined for this channel add that to the channel specific
> attributes. This is useful for userspace to be able to identify an
> individual channel.
> 
> Signed-off-by: Cristian Pop <cristian.pop@analog.com>
> ---
> Changes in v6:
>  - Fix documentation
>  Documentation/ABI/testing/sysfs-bus-iio | 72 +++++++++++++++++++++++++
>  1 file changed, 72 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a9d51810a3ba..53c5156362af 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1715,6 +1715,78 @@ Description:
>  
>  		Raw counter device counters direction for channel Y.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_voltageY_label

Please limit this to those channels for which we are implementing it
in this patch set.  Others should be added if/as we use them.

For some channel types I'm not sure it will ever be used.  It doesn't necessarily
make sense to define a label for the xaxis of an accelerometer for example.

Thanks,

Jonathan

> +What:		/sys/bus/iio/devices/iio:deviceX/in_currentY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_currentY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_powerY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_powerY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accelY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_accelY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_angl_velY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_angl_velY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_magnY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_magnY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_lightY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_lightY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_intensityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_intensityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_proximityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_proximityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_tempY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_tempY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_incliY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_incliY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rotY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_rotY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_anglY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_timestampY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_timestampY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_capacitanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_capacitanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltageY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_cctY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_cctY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_pressureY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_pressureY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_humidityrelativeY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_humidityrelativeY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_activityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_activityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_stepsY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_stepsY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_energyY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_energyY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_distanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_distanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_velocityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_velocityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_concentrationY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_concentrationY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_resistanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_resistanceY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_phY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_phY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_uvindexY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_uvindexY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_electricalconductivityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_electricalconductivityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_countY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_countY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_indexY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_indexY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/in_gravityY_label
> +What:		/sys/bus/iio/devices/iio:deviceX/out_gravityY_label
> +KernelVersion:	5.8
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label to a device channel.
> +		If a label is defined for this channel add that to the channel
> +		specific attributes. This is useful for userspace to be able to
> +		better identify an individual channel.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_phaseY_raw
>  KernelVersion:	4.18
>  Contact:	linux-iio@vger.kernel.org

