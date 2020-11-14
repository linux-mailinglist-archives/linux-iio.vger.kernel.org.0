Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A68A2B2DE8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Nov 2020 16:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKNPXI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Nov 2020 10:23:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:46446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727053AbgKNPXI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Nov 2020 10:23:08 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FBD32225E;
        Sat, 14 Nov 2020 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605367387;
        bh=3SYzMSYYaj4uG6+YZIW8LzSIBNVm9uAuKPTUXWI99gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ty5IopicuQVVHSO1Y1OPsIu7qXPLgfHyBQz/GWtLRtUfJzXM+SqTjo5Wke9m5nPeA
         PIMQ+B93nscdPfcub2/UhhWvkzzC5rjybVhJOJeLPoBtXJUhr/a40ba568IrqUGf4m
         3I+35eFYNZ3ABPR+7+yTocHhdK7XcxRAlqRN0YwM=
Date:   Sat, 14 Nov 2020 15:23:02 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Cc:     robh+dt@kernel.org, robh@kernel.org, mchehab+huawei@kernel.org,
        davem@davemloft.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/13] Documentation: ABI: add specific icm42600
 documentation
Message-ID: <20201114152302.3b05c4ea@archlinux>
In-Reply-To: <20200622153729.12702-9-jmaneyrol@invensense.com>
References: <20200622153729.12702-1-jmaneyrol@invensense.com>
        <20200622153729.12702-9-jmaneyrol@invensense.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Jun 2020 17:37:24 +0200
Jean-Baptiste Maneyrol <jmaneyrol@invensense.com> wrote:

> Hardware offset available as calibscale sysfs attributes are real
> physical values exprimed in SI units.
> 
> calibscale_available sysfs attributes represents the range of
> acceptable values.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>

Hi Jean-Baptiste. 

This is causing us some issues as the ABI docs are now added to the
generated html docs for the kernel.  It's been a while, so I've kind
of forgotten why we have this file.  Was the issue that these are
in SI units as opposed to most calibbias controls which are offsets
applied to the raw analog reading hitting the ADC?

Would you mind if we moved this into the main doc as a note for this
particular device?

i.e. something in sysfs-bus-iio saying

icm42600: Hardware applied calibration offset is in SI units (rad/s or m/s^2 as appropriate)

?

Thanks,

Jonathan
 
> ---
>  .../ABI/testing/sysfs-bus-iio-icm42600        | 20 +++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-icm42600
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-icm42600 b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> new file mode 100644
> index 000000000000..0bf1fd4f5bf1
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-icm42600
> @@ -0,0 +1,20 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_z_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_x_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_y_calibbias
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_z_calibbias
> +KernelVersion:  5.8
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Hardware applied calibration offset (assumed to fix production
> +		inaccuracies). Values represent a real physical offset expressed
> +		in SI units (m/s^2 for accelerometer and rad/s for gyroscope).
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_calibbias_available
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglvel_calibbias_available
> +KernelVersion:  5.8
> +Contact:        linux-iio@vger.kernel.org
> +Description:
> +		Range of available values for hardware offset. Values in SI
> +		units (m/s^2 for accelerometer and rad/s for gyroscope).

