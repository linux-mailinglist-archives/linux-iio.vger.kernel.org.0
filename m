Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01797AC808
	for <lists+linux-iio@lfdr.de>; Sun, 24 Sep 2023 14:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229450AbjIXMcK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 24 Sep 2023 08:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMcJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 24 Sep 2023 08:32:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38A01101;
        Sun, 24 Sep 2023 05:32:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C74DC433C7;
        Sun, 24 Sep 2023 12:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695558722;
        bh=4O8Z/nlwUMfJ5kW6vROIpHUGLRtUh9kQDaNRYgH56ck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cX+G1R2HwjyhGBE0l8VRphVl9tiNFnqdNMDw2rtDJYsHm/ek/8pR5g1moCaICZxAO
         HeydWTVqVthlZpvc8xe0YmFzHy9fFF1j4cnoiQT6/M9XxpUZl+y3q6sFWXOIqSVZ7U
         dV038a8DOXvGThuGfZRU2chYsvlyLgFi1FYLWliaQhwSyREpUsJvu+L4wDZzjVTXAP
         DUdSzR06Y9YubTae4C80Pw147/75W4BDTyCZkXGxKMeh3lYdn+/DL+UA5WceEGl0Eb
         gM9FRaoZjH5O2h0U6ZOiyqud1b3sxLpGhB2urz51RaceEkQODyzkX7Px4DyUxYoLb3
         Fecz9WtQRwx7w==
Date:   Sun, 24 Sep 2023 13:31:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Cc:     <jikos@kernel.org>, <benjamin.tissoires@redhat.com>,
        <lars@metafoo.de>, <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 6/9] iio: Add channel type for chromaticity
Message-ID: <20230924133155.48da9a8d@jic23-huawei>
In-Reply-To: <20230919081054.2050714-7-Basavaraj.Natikar@amd.com>
References: <20230919081054.2050714-1-Basavaraj.Natikar@amd.com>
        <20230919081054.2050714-7-Basavaraj.Natikar@amd.com>
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

On Tue, 19 Sep 2023 13:40:51 +0530
Basavaraj Natikar <Basavaraj.Natikar@amd.com> wrote:

> In most cases, ambient color sensors also support the x and y light
> colors, which represent the coordinates on the CIE 1931 chromaticity
> diagram. Thus, add channel type for chromaticity.
> 
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
One small thing I fixed up whilst applying.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 8 ++++++++
>  drivers/iio/industrialio-core.c         | 1 +
>  include/uapi/linux/iio/types.h          | 1 +
>  tools/iio/iio_event_monitor.c           | 1 +
>  4 files changed, 11 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index 4cf7ed9ca57b..0c9389ad3709 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -2186,3 +2186,11 @@ Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Represents light color temperature, which measures light color
>  		temperature in Kelvin.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_x_raw
> +What:		/sys/bus/iio/devices/iio:deviceX/in_chromaticity_y_raw
> +KernelVersion:	6.7
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The x and y light color coordinate on the CIE 1931 chromaticity
> +		diagram.
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index cba942cadf97..6dc4d2b296bb 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -91,6 +91,7 @@ static const char * const iio_chan_type_name_spec[] = {
>  	[IIO_PHASE] = "phase",
>  	[IIO_MASSCONCENTRATION] = "massconcentration",
>  	[IIO_COLORTEMP] = "colortemp",
> +	[IIO_CHROMATICITY] = "chromaticity",
>  };
>  
>  static const char * const iio_modifier_names[] = {
> diff --git a/include/uapi/linux/iio/types.h b/include/uapi/linux/iio/types.h
> index 08c20e540c13..4832c611c027 100644
> --- a/include/uapi/linux/iio/types.h
> +++ b/include/uapi/linux/iio/types.h
> @@ -48,6 +48,7 @@ enum iio_chan_type {
>  	IIO_PHASE,
>  	IIO_MASSCONCENTRATION,
>  	IIO_COLORTEMP,
> +	IIO_CHROMATICITY,
>  };
>  
>  enum iio_modifier {
> diff --git a/tools/iio/iio_event_monitor.c b/tools/iio/iio_event_monitor.c
> index a63741e43ddf..5edacc358c5d 100644
> --- a/tools/iio/iio_event_monitor.c
> +++ b/tools/iio/iio_event_monitor.c
> @@ -175,6 +175,7 @@ static bool event_is_known(struct iio_event_data *event)
>  	case IIO_PHASE:
>  	case IIO_MASSCONCENTRATION:
>  	case IIO_COLORTEMP:
> +	case IIO_CHROMATICITY:
This is missing updating the strings in the same file.
I only notice whilst dealing with a merge conflict where the colortemp one was
there and this wasn't.
>  		break;
>  	default:
>  		return false;

