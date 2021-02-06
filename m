Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B67AC311EBF
	for <lists+linux-iio@lfdr.de>; Sat,  6 Feb 2021 17:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhBFQrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 6 Feb 2021 11:47:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230184AbhBFQrT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Feb 2021 11:47:19 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3B9B64E81;
        Sat,  6 Feb 2021 16:46:37 +0000 (UTC)
Date:   Sat, 6 Feb 2021 16:46:34 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ye Xiang <xiang.ye@intel.com>
Cc:     jikos@kernel.org, srinivas.pandruvada@linux.intel.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: Add relative hysteresis in ABI documentation
Message-ID: <20210206164634.1e7fa0c4@archlinux>
In-Reply-To: <20210201074358.18435-4-xiang.ye@intel.com>
References: <20210201074358.18435-1-xiang.ye@intel.com>
        <20210201074358.18435-4-xiang.ye@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Feb 2021 15:43:58 +0800
Ye Xiang <xiang.ye@intel.com> wrote:

> Add relative hysteresis in ABI documentation.
> 
> Signed-off-by: Ye Xiang <xiang.ye@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d957f5da5c04..1c51db7eb8ef 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -1823,3 +1823,11 @@ Description:
>  		hinge, keyboard, screen. It means the three channels
>  		each correspond respectively to hinge angle, keyboard angle,
>  		and screen angle.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_Y_hysteresis_relative

I'm rather undecided on whether a generic catch all for sensor types here makes
sense. Given we aren't currently applying it to too many devices, I think
I'd prefer we documented this for the particular entries we are adding as
that is the approach that we've taken for the majority of the rest of the
main ABI doc.   Note that tidying this doc up has been something I've wanted
to look at doing for a while, so it's possible I'll revisit this decision
at that time.

Otherwise, this looks good.

Thanks,

Jonathan


> +KernelVersion:	5.12
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Specify the percent relative to the current sensor channel
> +		Y absolute value that a data field should change before an event
> +		is generated. Units are a percentage of the prior reading.
