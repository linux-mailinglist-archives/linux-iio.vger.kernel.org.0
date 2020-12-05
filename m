Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCEAD2CFC9D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Dec 2020 19:51:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgLEQu3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 5 Dec 2020 11:50:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:48354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbgLEQop (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Dec 2020 11:44:45 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7276A23136;
        Sat,  5 Dec 2020 16:05:44 +0000 (UTC)
Date:   Sat, 5 Dec 2020 16:05:40 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio:Documentation: Add documentation for hinge
 sensor channels
Message-ID: <20201205160540.22d2b8d5@archlinux>
In-Reply-To: <20201203035352.13918-4-xiang.ye@intel.com>
References: <20201203035352.13918-1-xiang.ye@intel.com>
        <20201203035352.13918-4-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  3 Dec 2020 11:53:52 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Add channel description for hinge sensor, including channel label
> attribute and raw data description.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index df42bed09f25..82303b1bdff0 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1802,3 +1802,20 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Unscaled light intensity according to CIE 1931/DIN 5033 color space.
>  		Units after application of scale are nano nanowatts per square meter.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_raw
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Angle of rotation for channel Y. Units after application of scale
> +		and offset are radians.

This entry is already mostly in the doc around line 200, just without the index.
Please just add the What: line to that block to reduce repetition.
If you want to add... "Where present, Y indexes the channel." or something like
that feel free.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_anglY_label
> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Optional symbolic label for channel Y.
> +		For Intel hid hinge sensor, the label values are:
> +		hinge, keyboard, screen. It means the three channels
> +		each correspond respectively to hinge angle, keyboard angle,
> +		and screen angle.

Makes sense to keep this block separate given the additional info provided.
Alternative would be to add it to the one with in_voltageY_label which would
be odd given what follows!

Thanks,

Jonathan


