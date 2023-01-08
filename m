Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7C966154C
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 14:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233225AbjAHNBm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 08:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHNBl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 08:01:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7038BDF58;
        Sun,  8 Jan 2023 05:01:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05002B80A36;
        Sun,  8 Jan 2023 13:01:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B74E2C433D2;
        Sun,  8 Jan 2023 13:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673182897;
        bh=axSUVB3lof9WSwRIsKgGRZbHEkRI+Nv4KBBytu4sLFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pfuNWB2sb257KSDBUJea2JgTBiIUCe9W1JQ5Y5TDxhwlpbWf7AjskS7jdOuoTRarZ
         ID5gc1H6tKhTQVFoPsuA5neqr2FviCPsa3iIwRhPbYffON0t5wxBEBqsE+lPFf6YX+
         e2u8I892KGi+tNEDjZEWQROgNyATIYMlyl150h8uYD6HX4+pOmxi5gxE/dspuJajha
         HjTtJ8Am/hp4r/N9vWZdXUMPeoMq+sEYxkxj5YO/j2GKdUDW5KDWuXAjP9lHy9T9NB
         NP++0DlJthv1uvJdpU18T/VWxKeKEbd7+WBalsonkEgakE+RCh+D/ac1kSuyhiARlo
         Hamv1AnarRWyQ==
Date:   Sun, 8 Jan 2023 13:15:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     haibo.chen@nxp.com
Cc:     lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 0/3] add imx93 adc support
Message-ID: <20230108131505.0a51fe46@jic23-huawei>
In-Reply-To: <20230103114359.2663262-1-haibo.chen@nxp.com>
References: <20230103114359.2663262-1-haibo.chen@nxp.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  3 Jan 2023 19:43:55 +0800
haibo.chen@nxp.com wrote:

> From: Haibo Chen <haibo.chen@nxp.com>
> 
> V5:
>   -For ADC driver, use dev_err_probe() to replace dev_err() in dev_err_probe(). 
>   -Add imx93_adc_power_down() in the probe error path.
>   -Re-order the function in imx93_adc_remove(), make them inverse in probe().
>   -Remove the pm_runtime_get_sync(dev) in imx93_adc_remove(), because this driver
>    enable the pm_runtime autosuspend feature, and config the delay as 50ms. So when
>    called imx93_adc_remove(), this device still in runtime resume state, no need to
>    force resume the device back.
I don't follow this point.  Perhaps talk me through in more detail on why the device
will be in a runtime resumed state when ever we hit remove?

>   -no changes for binding doc and dts.
> 
> V4:
>   For ADC driver, re-define the ADC status show the relation to specific register bit.
>   Redo the imx93_adc_remove(), change the return error sequence in imx93_adc_read_raw(),
>   and use a direct string for indio_dev->name.
>   For dt-bings, change the commit title and add maintainer's reviewed by tag
>   For dts, no change.
> 
> V3:
>   For dt-bings, add some change according to review comments, and pass dt_binding_check.
>   For dts, add #io-channel-cells = <1>; to pass dtbs_check
>   For ADC driver, no change.
> 
> V2:
>   For ADC driver, add change according to matainer's commets.
> 
> Haibo Chen (3):
>   iio: adc: add imx93 adc support
>   dt-bindings: iio: adc: Add NXP IMX93 ADC
>   arm64: dts: imx93: add ADC support
> 
>  .../bindings/iio/adc/nxp,imx93-adc.yaml       |  81 +++
>  MAINTAINERS                                   |   4 +-
>  .../boot/dts/freescale/imx93-11x11-evk.dts    |  12 +
>  arch/arm64/boot/dts/freescale/imx93.dtsi      |  13 +
>  drivers/iio/adc/Kconfig                       |  10 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/imx93_adc.c                   | 477 ++++++++++++++++++
>  7 files changed, 597 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/nxp,imx93-adc.yaml
>  create mode 100644 drivers/iio/adc/imx93_adc.c
> 

