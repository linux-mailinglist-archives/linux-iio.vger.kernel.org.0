Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1387A354D
	for <lists+linux-iio@lfdr.de>; Sun, 17 Sep 2023 13:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjIQLFV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Sep 2023 07:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbjIQLE5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 17 Sep 2023 07:04:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398BC189;
        Sun, 17 Sep 2023 04:04:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CEF6C433C8;
        Sun, 17 Sep 2023 11:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694948691;
        bh=Vjx2F7/0TTzdgXR3kzz3SvgyXzml4i4A1Ktl8Fi85+s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CTD30R2UmexHqBmResk/BSxPkqW4iEInGuECcShBZe9y/5RDlASj/xWkU4/rFwY9X
         bOhwLsv4PnkTUn82ifI1njx55+JgfxteHL1+GD+VNYJSzuVxQwcigL0jXJlurKuYQB
         jX6fKtvwb8eIYuIf4kVm0jMWwqSRRU4l/tgPI/mvC3Uq6B53V00m0yPeioImSVhWYo
         ueMwQCg5paSpsjGUtGffQqiIWwYpEuumSXSQnQO+tZYANYrQ9Agz4k/0agZ7lvgHIH
         Dr/j0CEHN6zm13zc+kBz9EvM8jtXyFsksna9ajc4HxLFKbz4xbazC6f4AUaI+RRooT
         39ZdEGQf3c6lQ==
Date:   Sun, 17 Sep 2023 12:04:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 5/8] iio: Add channel for chromaticity
Message-ID: <20230917120444.6f986084@jic23-huawei>
In-Reply-To: <20230915051703.1689578-6-Basavaraj.Natikar@amd.com>
References: <20230915051703.1689578-1-Basavaraj.Natikar@amd.com>
        <20230915051703.1689578-6-Basavaraj.Natikar@amd.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Sep 2023 10:47:00 +0530
Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:

> In most cases, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Thus, add channel for chromaticity.

Adding a channel type.

Otherwise looks reasonable to me.

> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 2 ++
>  4 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index a2854dc9a839..6a810771f5e4 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2179,3 +2179,11 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Number of conditions that must occur, during a running
>  		period, before an event is generated.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_y_raw
> +KernelVersion:	6.6
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The x and y light color coordinate on the CIE 1931 chromaticity
> +		diagram.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index d752e9c0499b..c1df66cdfdf6 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -90,6 +90,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE]  = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_CHROMATICITY] = "chromaticity",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index c79f2f046a0b..8952d48cfc64 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -47,6 +47,7 @@ enum iio_chan_type {
>  	IIO_POSITIONRELATIVE,
>  	IIO_PHASE,
>  	IIO_MASSCONCENTRATION,
> +	IIO_CHROMATICITY,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index 0a5c2bb60030..115ba1fbf3ac 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -59,6 +59,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_POSITIONRELATIVE] = "positionrelative",
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
> +	[IIO_CHROMATICITY] = "chromaticity",
>  };
>  
>  static const char * const iio_ev_type_text[] = {
> @@ -173,6 +174,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_POSITIONRELATIVE:
>  	case IIO_PHASE:
>  	case IIO_MASSCONCENTRATION:
> +	case IIO_CHROMATICITY:
>  		break;
>  	default:
>  		return false;

