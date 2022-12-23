Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7053655205
	for <lists+linux-iio@lfdr.de>; Fri, 23 Dec 2022 16:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiLWP1M (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 23 Dec 2022 10:27:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiLWP1M (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 23 Dec 2022 10:27:12 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2119F28E3A
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 07:27:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7BCEECE1C02
        for <linux-iio@vger.kernel.org>; Fri, 23 Dec 2022 15:27:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12CDC433EF;
        Fri, 23 Dec 2022 15:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671809227;
        bh=ykJgLOsyg+jfR1orxeL+IB6BRdbchGsLUkuA2VXe2VY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rJKm5MF5D/RvkEx9OtMQNPTznbGK62DRaqPSSo5LXwqowxTLTjqzw1AbNPQuTCZNL
         8+J2KVlEIvomRIHHhdh0Z9tlLs6+m9+PvupC4vs3wbovzJFcH7QZ+q+RnNyNkk8X5M
         4yfkOpjoFKNoi426Vyw1EXnxOzHvRgpWlatv7zQp96beYjCPsZTNZAsEGx1Lu/qSHQ
         q4mq8KqdY/hDpVs0L7d0W/xM2CJ6qc0ve4zAP2knDYac3Zkav4mkUBMAcluK3OQbrb
         E+cs8WbVwRJ6vQSxAmnXnah+knhO37qCriJpDDBvlejD39IPXLkHssKrxj4LSxZ5gJ
         dxWGuyEqQGC5w==
Date:   Fri, 23 Dec 2022 15:40:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     swboyd@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx_common: Add old register mapping
Message-ID: <20221223154017.20f25396@jic23-huawei>
In-Reply-To: <20221220193926.126366-1-gwendal@chromium.org>
References: <20221220193926.126366-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Tue, 20 Dec 2022 11:39:26 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Older firmwares still send sensor configuration using a list of
> registers with opaque values defined during sensor tuning.
> sx9234 and sx9360 sensor on ACPI based devices are concerned.
> More schema to configure the sensors will be needed to support devices
> designed for windows, like Samsung Galaxy Book2.
> 
> Support schema is: "<_HID>.<register_name>". For instance
> "STH9324,reg_adv_ctrl2" in:
> 
>     Scope (\_SB.PCI0.I2C2)
>     {
>         Device (SX28)
>         {
>             Name (_HID, "STH9324")  // _HID: Hardware ID
> ...
>             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
>             {
>                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> Device Properties for _DSD */,
>                 Package (0x3F)
>                 {
> ...
>                     Package (0x02)
>                     {
>                         "STH9324,reg_adv_ctrl2",
>                         Zero
>                     },`
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
LGTM with one exception. See below.  I can fix that whilst applying, but
would like to leave time for Stephen to take a look anyway.

...

>  
> @@ -101,6 +105,7 @@ struct sx_common_chip_info {
>   * @client:		I2C client structure.
>   * @trig:		IIO trigger object.
>   * @regmap:		Register map.
> + * @acpi_id: ACPI device entry when the device is using APCI, NULL otherwise.

The lack of num_default_regs below made me suspicious enough to open the code.
This is the wrong documentation block.

>   * @num_default_regs:	Number of default registers to set at init.
>   * @supplies:		Power supplies object.
>   * @chan_prox_stat:	Last reading of the proximity status for each channel.
> @@ -119,6 +124,7 @@ struct sx_common_data {
>  	struct i2c_client *client;
>  	struct iio_trigger *trig;
>  	struct regmap *regmap;
> +	const struct acpi_device_id *acpi_id;
>  
>  	struct regulator_bulk_data supplies[2];
>  	unsigned long chan_prox_stat;
> @@ -151,6 +157,10 @@ int sx_common_probe(struct i2c_client *client,
>  		    const struct sx_common_chip_info *chip_info,
>  		    const struct regmap_config *regmap_config);
>  
> +void sx_common_get_raw_register_config(struct device *dev,
> +				       const struct acpi_device_id *id,
> +				       struct sx_common_reg_default *reg_def);
> +
>  /* 3 is the number of events defined by a single phase. */
>  extern const struct iio_event_spec sx_common_events[3];
>  

