Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1784F43084E
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241729AbhJQLV3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:21:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:48518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbhJQLV0 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:21:26 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0AF761246;
        Sun, 17 Oct 2021 11:19:15 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:23:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] docs: counter: add unit timer sysfs attributes
Message-ID: <20211017122328.295af1b2@jic23-huawei>
In-Reply-To: <20211017013343.3385923-5-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-5-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:39 -0500
David Lechner <david@lechnology.com> wrote:

> This documents new unit timer sysfs attributes for the counter
> subsystem.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

The ti-eqep.c change needs moving to patch 1 where the typo was introduced.

> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 24 +++++++++++++++++++++
>  drivers/counter/ti-eqep.c                   |  2 +-
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 06c2b3e27e0b..37d960a8cb1b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -218,6 +218,9 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
> +What:		/sys/bus/counter/devices/unit_timer_enable_component_id
> +What:		/sys/bus/counter/devices/unit_timer_period_component_id
> +What:		/sys/bus/counter/devices/unit_timer_time_component_id
>  KernelVersion:	5.16
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> @@ -345,3 +348,24 @@ Description:
>  			via index_polarity. The index function (as enabled via
>  			preset_enable) is performed synchronously with the
>  			quadrature clock on the active level of the index input.
> +
> +What:		/sys/bus/counter/devices/unit_timer_enable
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that starts or stops the unit timer. Valid
> +		values are boolean.
> +
> +What:		/sys/bus/counter/devices/unit_timer_period
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the unit timer timeout in
> +		nanoseconds.
> +
> +What:		/sys/bus/counter/devices/unit_timer_time
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that indicates the current time of the
> +		unit timer in nanoseconds.
> diff --git a/drivers/counter/ti-eqep.c b/drivers/counter/ti-eqep.c
> index a4a5a4486329..1ba7f3c7cb7e 100644
> --- a/drivers/counter/ti-eqep.c
> +++ b/drivers/counter/ti-eqep.c
> @@ -680,7 +680,7 @@ static int ti_eqep_probe(struct platform_device *pdev)
>  	pm_runtime_get_sync(dev);
>  
>  	/*
> -	 * We can end up with an interupt infinite loop (interrupts triggered
> +	 * We can end up with an interrupt infinite loop (interrupts triggered

This change should be in a separate patch.

>  	 * as soon as they are cleared) if we leave these at the default value
>  	 * of 0 and events are enabled.
>  	 */

