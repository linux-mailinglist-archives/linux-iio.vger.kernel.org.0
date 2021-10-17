Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4193430851
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbhJQLX6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:49896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234082AbhJQLX5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:23:57 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B910E60F46;
        Sun, 17 Oct 2021 11:21:46 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:26:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] docs: counter: add latch_mode and latched_count
 sysfs attributes
Message-ID: <20211017122600.535d8dfc@jic23-huawei>
In-Reply-To: <20211017013343.3385923-7-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-7-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:41 -0500
David Lechner <david@lechnology.com> wrote:

> This documents new counterX/latch_mode* and
> counterX/countY/latched_count* attributes.
> 
> The counterX/signalY/*_available are moved to the
> counterX/countY/*_available section similar to the way we already have
> The counterX/*_component_id and The counterX/signalY/*_component_id
> grouped together so that we don't have to start a 3rd redundant section
> for device-level *_available section.

Two unrelated changes in the same patch. Please redo this as multiple patches.

Thanks,

Jonathan

> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-counter | 39 ++++++++++++++++-----
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-counter b/Documentation/ABI/testing/sysfs-bus-counter
> index 37d960a8cb1b..78bb1a501007 100644
> --- a/Documentation/ABI/testing/sysfs-bus-counter
> +++ b/Documentation/ABI/testing/sysfs-bus-counter
> @@ -59,10 +59,13 @@ What:		/sys/bus/counter/devices/counterX/countY/error_noise_available
>  What:		/sys/bus/counter/devices/counterX/countY/function_available
>  What:		/sys/bus/counter/devices/counterX/countY/prescaler_available
>  What:		/sys/bus/counter/devices/counterX/countY/signalZ_action_available
> +What:		/sys/bus/counter/devices/counterX/latch_mode_available
> +What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> +What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
>  Description:
> -		Discrete set of available values for the respective Count Y
> +		Discrete set of available values for the respective component
>  		configuration are listed in this file. Values are delimited by
>  		newline characters.
>  
> @@ -147,6 +150,14 @@ Description:
>  			updates	the respective count. Quadrature encoding
>  			determines the direction.
>  
> +What:		/sys/bus/counter/devices/counterX/countY/latched_count
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Latched count data of Count Y represented as a string. The value
> +		is latched in based on the trigger selected by the
> +		counterX/latch_mode attribute.
> +
>  What:		/sys/bus/counter/devices/counterX/countY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -209,6 +220,7 @@ What:		/sys/bus/counter/devices/counterX/countY/count_mode_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/direction_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/enable_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/error_noise_component_id
> +What:		/sys/bus/counter/devices/counterX/countY/latched_count_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/prescaler_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_component_id
>  What:		/sys/bus/counter/devices/counterX/countY/preset_enable_component_id
> @@ -218,6 +230,7 @@ What:		/sys/bus/counter/devices/counterX/signalY/cable_fault_enable_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/filter_clock_prescaler_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_component_id
>  What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_component_id
> +What:		/sys/bus/counter/devices/latch_mode_component_id
>  What:		/sys/bus/counter/devices/unit_timer_enable_component_id
>  What:		/sys/bus/counter/devices/unit_timer_period_component_id
>  What:		/sys/bus/counter/devices/unit_timer_time_component_id
> @@ -244,6 +257,22 @@ Description:
>  		counter_event data structures. The number of elements will be
>  		rounded-up to a power of 2.
>  
> +What:		/sys/bus/counter/devices/counterX/latch_mode
> +KernelVersion:	5.16
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Read/write attribute that selects the trigger for latching
> +		values. Valid values are device-specific (given by
> +		latch_mode_available attribute) and may include:
> +
> +		"Read count":
> +			Reading the countY/count attribute latches values.
> +
> +		"Unit timeout":
> +			Unit timer timeout event latches values.
> +
> +		The latched values can be read from latched_* attributes.
> +
>  What:		/sys/bus/counter/devices/counterX/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org
> @@ -298,14 +327,6 @@ Description:
>  		Active level of index input Signal Y; irrelevant in
>  		non-synchronous load mode.
>  
> -What:		/sys/bus/counter/devices/counterX/signalY/index_polarity_available
> -What:		/sys/bus/counter/devices/counterX/signalY/synchronous_mode_available
> -KernelVersion:	5.2
> -Contact:	linux-iio@vger.kernel.org
> -Description:
> -		Discrete set of available values for the respective Signal Y
> -		configuration are listed in this file.
> -
>  What:		/sys/bus/counter/devices/counterX/signalY/name
>  KernelVersion:	5.2
>  Contact:	linux-iio@vger.kernel.org

