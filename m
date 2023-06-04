Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92E72163B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Jun 2023 12:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjFDKxl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Jun 2023 06:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjFDKxl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Jun 2023 06:53:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C812C0;
        Sun,  4 Jun 2023 03:53:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B877C60E71;
        Sun,  4 Jun 2023 10:53:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E28C433EF;
        Sun,  4 Jun 2023 10:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685876019;
        bh=v/j4DKmdtzM+oQApqSfZhtaduo95gGQbg/IfYamNqVE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kHSDpFO6Ru/4oFyMkLmFCNWjVtNDmcWuDktSjwbpuLn1U6ByqGmXb+CPDWbKpmSzy
         rNI2j5b5UPtxP84sfjjN993uwp+8p3AnxsQtjwGtbccUQaGxHVdMAM5XhRpK+W0S3W
         SJy3qhYP39lhP0UJsNSvZW9rC7G+RBv7spvyYlC/WXNQ5Y5v9Qj+rMXh8z1Try6/oQ
         n/RaYgqaD3gRqaBoNvIkEjrg0BibyUrSj75X+/xGcYQaDLgRFfIqrR9+thg6/tfccx
         8x/7aPhTwZoRxK19fs9E/O2/f+GGPiTI3cXG4l7b2fUuxzdJJyWYTTMoc0Rlrrxy3Y
         tc8prp8phi1Nw==
Date:   Sun, 4 Jun 2023 11:53:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Wilczynski <michal.wilczynski@intel.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        rafael@kernel.org
Subject: Re: [PATCH v4 11/35] iio/acpi-als: Move handler installing logic to
 driver
Message-ID: <20230604115335.0e66ca2f@jic23-huawei>
In-Reply-To: <20230601131739.300760-12-michal.wilczynski@intel.com>
References: <20230601131739.300760-3-michal.wilczynski@intel.com>
        <20230601131739.300760-12-michal.wilczynski@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu,  1 Jun 2023 15:17:14 +0200
Michal Wilczynski <michal.wilczynski@intel.com> wrote:

> Currently logic for installing notifications from ACPI devices is
> implemented using notify callback in struct acpi_driver. Preparations
> are being made to replace acpi_driver with more generic struct
> platform_driver, which doesn't contain notify callback. Furthermore
> as of now handlers are being called indirectly through
> acpi_notify_device(), which decreases performance.
> 
> Call acpi_device_install_event_handler() at the end of .add() callback.
> Call acpi_device_remove_event_handler() at the beginning of .remove()
> callback. Change arguments passed to the notify callback to match with
> what's required by acpi_device_install_event_handler().
> 
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
Hi Michal,

Comments inline.

> ---
>  drivers/iio/light/acpi-als.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/acpi-als.c b/drivers/iio/light/acpi-als.c
> index 2d91caf24dd0..5e200c6d91bc 100644
> --- a/drivers/iio/light/acpi-als.c
> +++ b/drivers/iio/light/acpi-als.c
> @@ -100,10 +100,14 @@ static int acpi_als_read_value(struct acpi_als *als, char *prop, s32 *val)
>  	return 0;
>  }
>  
> -static void acpi_als_notify(struct acpi_device *device, u32 event)
> +static void acpi_als_notify(acpi_handle handle, u32 event, void *data)
>  {
> -	struct iio_dev *indio_dev = acpi_driver_data(device);
> -	struct acpi_als *als = iio_priv(indio_dev);
> +	struct acpi_device *device = data;
> +	struct iio_dev *indio_dev;
> +	struct acpi_als *als;
> +
> +	indio_dev = acpi_driver_data(device);
> +	als = iio_priv(indio_dev);

Not particularly important, but I'd have kept to existing style

	struct acpi_device *device = data;
	struct iio_dev *indio_dev = acpi_driver_data(device);
	struct acpi_als *als = iio_priv(indio_dev);

Less churn that way.

>  
>  	if (iio_buffer_enabled(indio_dev) && iio_trigger_using_own(indio_dev)) {
>  		switch (event) {
> @@ -225,7 +229,16 @@ static int acpi_als_add(struct acpi_device *device)
>  	if (ret)
>  		return ret;
>  
> -	return devm_iio_device_register(dev, indio_dev);
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return acpi_device_install_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);

Prefer to keep to a fully devm managed flow for removal

So use a devm_add_action_or_reset() to unwind this rather than adding a remove()
callback.

Obviously ordering is the same currently but that may change if this driver
is modified in future and it's a lot easier to get that right if fully devm
(or fully not).

Jonathan

> +}
> +
> +static void acpi_als_remove(struct acpi_device *device)
> +{
> +	acpi_device_remove_event_handler(device, ACPI_DEVICE_NOTIFY, acpi_als_notify);
>  }
>  
>  static const struct acpi_device_id acpi_als_device_ids[] = {
> @@ -241,7 +254,7 @@ static struct acpi_driver acpi_als_driver = {
>  	.ids	= acpi_als_device_ids,
>  	.ops = {
>  		.add	= acpi_als_add,
> -		.notify	= acpi_als_notify,
> +		.remove = acpi_als_remove,
>  	},
>  };
>  

