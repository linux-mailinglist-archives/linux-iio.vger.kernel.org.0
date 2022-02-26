Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7473A4C56E7
	for <lists+linux-iio@lfdr.de>; Sat, 26 Feb 2022 17:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiBZQ5Q (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Feb 2022 11:57:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBZQ5Q (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 26 Feb 2022 11:57:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A8517D1;
        Sat, 26 Feb 2022 08:56:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2A760C7B;
        Sat, 26 Feb 2022 16:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29191C340E8;
        Sat, 26 Feb 2022 16:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645894600;
        bh=PG2wm/58y/+uCeR8hm38xmgMRhBYzuCytGo4KSURr+w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AYE14dGpY2Uv9VQ5DF/brD8IXPHIf5Qesf7M3PSIf3ubX2n+7A/vz3EM98IO7NKgW
         BvATEKlNu9zG+DrQFLM1RN6X88dkuovVvvDCRAEUceQg96CsoClJetj3p0K54RzBof
         Vl90LgLbcG48zMKTyP7rWoq2PYqPRCjYlMewh7vubkqxcJvE+tMvaUe11DiTz1RStk
         AWEDT72BQHF8MpwSVo1Rlvj/nV/f8sxdLU9+JSvdQg/xsvUkY/kT9I0aHf7JHlVu22
         19qVoGHepg1keTXf97WuswwiBHUbbEBeDkHqSsD/HK6miTRXiu0ObdneN41ah65ic/
         esARMFflBcqlA==
Date:   Sat, 26 Feb 2022 17:03:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: Re: [PATCH v8 1/9] spmi: add a helper to look up an SPMI device
 from a device node
Message-ID: <20220226170339.6a69a041@jic23-huawei>
In-Reply-To: <20220221220743.541704-2-caleb.connolly@linaro.org>
References: <20220221220743.541704-1-caleb.connolly@linaro.org>
        <20220221220743.541704-2-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Feb 2022 22:07:35 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The helper function spmi_device_from_of() takes a device node and
> returns the SPMI device associated with it.
> This is like of_find_device_by_node but for SPMI devices.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>

Hi

I'm assuming this series will end up going in through my IIO tree.
So with that in mind, looking for an Ack from Stephen for this one.

One comment below.

Also, I vaguely wondered about whether this should switch to generic
struct fwnode rather than of/dt specific but that's probably
a question for Stephen.

Thanks,

Jonathan

> ---
>  drivers/spmi/spmi.c  | 17 +++++++++++++++++
>  include/linux/spmi.h |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/spmi/spmi.c b/drivers/spmi/spmi.c
> index b37ead9e2fad..de550b777451 100644
> --- a/drivers/spmi/spmi.c
> +++ b/drivers/spmi/spmi.c
> @@ -386,6 +386,23 @@ static struct bus_type spmi_bus_type = {
>  	.uevent		= spmi_drv_uevent,
>  };
>  
> +/**
> + * spmi_device_from_of() - get the associated SPMI device from a device node
> + *
> + * @np:		device node
> + *
> + * Returns the struct spmi_device associated with a device node or NULL.
> + */
> +inline struct spmi_device *spmi_device_from_of(struct device_node *np)

Drop the inline.  You are exporting it which would make inline rather
hard to do and in general inline markings should be used only where there
is a clear performance argument and there isn't one here.

> +{
> +	struct device *dev = bus_find_device_by_of_node(&spmi_bus_type, np);
> +
> +	if (dev)
> +		return to_spmi_device(dev);
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(spmi_device_from_of);
> +
>  /**
>   * spmi_controller_alloc() - Allocate a new SPMI device
>   * @ctrl:	associated controller
> diff --git a/include/linux/spmi.h b/include/linux/spmi.h
> index 729bcbf9f5ad..6ee476bc1cd6 100644
> --- a/include/linux/spmi.h
> +++ b/include/linux/spmi.h
> @@ -7,6 +7,7 @@
>  #include <linux/types.h>
>  #include <linux/device.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/of.h>
>  
>  /* Maximum slave identifier */
>  #define SPMI_MAX_SLAVE_ID		16
> @@ -164,6 +165,7 @@ static inline void spmi_driver_unregister(struct spmi_driver *sdrv)
>  	module_driver(__spmi_driver, spmi_driver_register, \
>  			spmi_driver_unregister)
>  
> +inline struct spmi_device *spmi_device_from_of(struct device_node *np);
>  int spmi_register_read(struct spmi_device *sdev, u8 addr, u8 *buf);
>  int spmi_ext_register_read(struct spmi_device *sdev, u8 addr, u8 *buf,
>  			   size_t len);

