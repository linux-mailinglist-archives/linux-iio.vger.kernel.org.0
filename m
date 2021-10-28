Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4BD43DEFA
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1KiM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:38:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:42804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229835AbhJ1KiM (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 28 Oct 2021 06:38:12 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7735604DC;
        Thu, 28 Oct 2021 10:35:41 +0000 (UTC)
Date:   Thu, 28 Oct 2021 11:40:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 02/10] iio: document linear acceleration modifiers
Message-ID: <20211028114008.0c2abf06@jic23-huawei>
In-Reply-To: <20211028101840.24632-3-andrea.merello@gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-3-andrea.merello@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 28 Oct 2021 12:18:32 +0200
Andrea Merello <andrea.merello@gmail.com> wrote:

> This patch introduces ABI documentation for new iio modifiers used for
> reporting "linear acceleration" measures.
> 
> Signed-off-by: Andrea Merello <andrea.merello@iit.it>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 6ad47a67521c..5147a00bf24a 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1957,3 +1957,11 @@ Description:
>  		Specify the percent for light sensor relative to the channel
>  		absolute value that a data field should change before an event
>  		is generated. Units are a percentage of the prior reading.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_y_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_accel_linear_z_raw
> +KernelVersion:	5.15
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Raw (unscaled) linear acceleration readings.

Probably need more information that this.   What element is being 'removed' from
a normal acceleration measurement? What are units after application of offset and
scale?  Can cross refer to the in_accel_x_raw for that info if you like.

Also, but them immediately after the block with the in_accel_x_raw etc

The organization fo that file needs a rethink but let us try to avoid making
it worse in the meeantime!

Jonathan


