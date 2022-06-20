Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEDE5524E3
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 21:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiFTT51 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 15:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiFTT50 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 15:57:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8701DA42
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 12:57:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 79074B811CE
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 19:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94528C3411B;
        Mon, 20 Jun 2022 19:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655755040;
        bh=MFR+acm6eoXH9G65Ow+riM1xiyYKRhIYmShj4tMHGeY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Th+tI8vPnltOSPJYM3KkajzexBjqk7t8TuHPtLDkqoP1O07Kt8UxyRtvExV18GKYv
         Csrsa7RcZrMeyXbTzgXu+P1/zT9QrkqUjtkg2WIahIKtGpupjemVi5JWULOLYUeIRn
         caDGybuWa4P5YUqQUUH8OtZ02rX8bKBOzSv75N2KwyQuo+qgCEcEjuLnDvX9+n/hQK
         gBUTynt1Ou1FVJEb12VADH+WctZJazs1Al4anik66WHkx/HFKcaewA44W+gcHIssz5
         eUZqHbSR4CWCahWDnC0pg88bBtB+dTT/WBAHxoOHO6aBE5E3SjImPrrga5QBmmC9jE
         5KwH9wdBX8EJw==
Date:   Mon, 20 Jun 2022 20:57:14 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Peter Rosin <peda@axentia.se>
Cc:     Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 11/17] iio: core: Introduce _inputoffset for
 differential channels
Message-ID: <20220620205714.03d32259@jic23-huawei>
In-Reply-To: <20220619185839.1363503-12-jic23@kernel.org>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <20220619185839.1363503-12-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 19 Jun 2022 19:58:33 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Address an ABI gap for device where the offset of both lines in a
> differential pair may be controlled so as to allow a wider range of
> inputs, but without having any direct effect of the differential
> measurement.
> 
> _offset cannot be used as to remain in line with existing usage,
> userspace would be expected to apply it as (_raw + _offset) * scale
> whereas _inputoffset is not.
> Similarly calibbias is expected to tweak the measurement seen, not
> the adjust the two lines of the differential pair.
> 
> Needed for in_capacitanceX-capacitanceY_inputoffset for the
> AD7746 CDC driver.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> I''m not entirely happy with the naming on this one, so if anyone
> has a better idea I'm definitely open to it!
> ---
>  Documentation/ABI/testing/sysfs-bus-iio | 13 +++++++++++++
>  drivers/iio/industrialio-core.c         |  1 +
>  include/linux/iio/types.h               |  1 +
>  3 files changed, 15 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
> index d3a0c0ef8948..132eb4e849f9 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio
> +++ b/Documentation/ABI/testing/sysfs-bus-iio
> @@ -204,6 +204,19 @@ Description:
>  		is required is a consistent labeling.  Units after application
>  		of scale and offset are nanofarads.
>  
> +What:		/sys/.../iio:deviceX/in_capacitableY-capacitanceZ_inputoffset

capacitable?  What was I drinking that day...  Will fix.

> +KernelVersion:	5.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		For differential channels, this an offset that is applied
> +		equally to both inputs. As the reading is of the difference
> +		between the two inputs this should not be applied to the _raw
> +		reading by userspace (unlike _offset) and unlike calibbias
> +		it does not affect the differential value measured because
> +		the effect of _inputoffset cancels out across the two inputs
> +		that make up the differential pair. It is expressed with
> +		the same scaling as _raw.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_temp_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_tempX_raw
>  What:		/sys/bus/iio/devices/iio:deviceX/in_temp_x_raw
> diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
> index 6b401f63805f..ad1c2354502d 100644
> --- a/drivers/iio/industrialio-core.c
> +++ b/drivers/iio/industrialio-core.c
> @@ -168,6 +168,7 @@ static const char * const iio_chan_info_postfix[] = {
>  	[IIO_CHAN_INFO_OVERSAMPLING_RATIO] = "oversampling_ratio",
>  	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
>  	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
> +	[IIO_CHAN_INFO_INPUTOFFSET] = "inputoffset",
>  };
>  /**
>   * iio_device_id() - query the unique ID for the device
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index a7aa91f3a8dc..c7f79a251a14 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -63,6 +63,7 @@ enum iio_chan_info_enum {
>  	IIO_CHAN_INFO_OVERSAMPLING_RATIO,
>  	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
>  	IIO_CHAN_INFO_CALIBAMBIENT,
> +	IIO_CHAN_INFO_INPUTOFFSET,
>  };
>  
>  #endif /* _IIO_TYPES_H_ */

