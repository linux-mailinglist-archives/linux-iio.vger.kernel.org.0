Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3477543DF0A
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:37:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1Kj7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:39:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229775AbhJ1Kj7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 06:39:59 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 295CA60296;
        Thu, 28 Oct 2021 10:37:28 +0000 (UTC)
Date:   Thu, 28 Oct 2021 11:41:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 03/10] iio: document euler angles modifiers
Message-ID: <20211028114154.19e596fc@jic23-huawei>
In-Reply-To: <20211028101840.24632-4-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-4-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:33 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch introduces ABI documentation for new modifiers used for
> reporting rotations expressed as euler angles (i.e. yaw, pitch, roll).
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 5147a00bf24a..f0adc2c817bd 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1965,3 +1965,11 @@ KernelVersion:	5.15
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Raw (unscaled) linear acceleration readings.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_yaw_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_pitch_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_rot_roll_raw
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) euler angles readings.
Any _raw entry should also include what the units are after application of
offset and scale.   Or you could just add this as more info to the in_rot_raw
block as an extra sentence explaining that they are euler angles.
That will lose the 'KernelVersion' information but honestly I'm not sure we
care that much about that.

Jonathan


