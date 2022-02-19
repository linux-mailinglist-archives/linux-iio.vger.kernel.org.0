Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 625824BC9B9
	for <lists+linux-iio@lfdr.de>; Sat, 19 Feb 2022 19:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiBSSNb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 19 Feb 2022 13:13:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiBSSNb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 19 Feb 2022 13:13:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4220C7E;
        Sat, 19 Feb 2022 10:13:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6967E60C03;
        Sat, 19 Feb 2022 18:13:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF9CC004E1;
        Sat, 19 Feb 2022 18:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645294390;
        bh=dSDjdBicoltX5N4N78Mx82dOF5tuxV4/33SM9lnQ3Vs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WwNxslP6zEk8o0IfSWmgnalERt7cPVL3t9bx0Tug0cFBWtue80yEultX9bm+DXGmi
         P3o7EvGo42Eh9xMWiyOjDbp7ixM9leIsmp8W+xre8YzjJSw8sxOj2s9ZTXrerbQU/+
         ZuM+gAoskupaRsIHDwXVtsuUaHuq1akvHi2FgRbZJerovba2TWY3AFGYlbiU0agQbL
         Ji2LixFJPM9WulM7ecrs7z/MqHXGhsOuONFEkRuJqO+TSGYPT7ph+oIu6Is9miNePN
         kzp2sueHVwDPACxBzRzEPU5K35yedB2DqHenCuvmyPMmCuEwdEjdhuqY6A6zhpyoYl
         wxAA5Qv9xHWTQ==
Date:   Sat, 19 Feb 2022 18:19:55 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        sumit.semwal@linaro.org, amit.pundir@linaro.org,
        john.stultz@linaro.org
Subject: Re: [PATCH v7 1/9] spmi: add a helper to look up an SPMI device
 from a device node
Message-ID: <20220219181955.10b707cc@jic23-huawei>
In-Reply-To: <20220216134920.239989-2-caleb.connolly@linaro.org>
References: <20220216134920.239989-1-caleb.connolly@linaro.org>
        <20220216134920.239989-2-caleb.connolly@linaro.org>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 16 Feb 2022 13:49:12 +0000
Caleb Connolly <caleb.connolly@linaro.org> wrote:

> The helper function spmi_device_from_of() takes a device node and
> returns the SPMI device associated with it.
> This is like of_find_device_by_node but for SPMI devices.
> 
> Signed-off-by: Caleb Connolly <caleb.connolly@linaro.org>
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

https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html
"Each function argument should be described in order, immediately following the
 short function description. Do not leave a blank line between the function
 description and the arguments, nor between the arguments."

> + * @np:		device node
> + *
> + * Returns the struct spmi_device associated with a device node or NULL.
> + */
> +inline struct spmi_device *spmi_device_from_of(struct device_node *np)
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

If all you need is struct device_node * then normally preferred to
use a forwards definition rather than including the header.

struct device_node;

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

