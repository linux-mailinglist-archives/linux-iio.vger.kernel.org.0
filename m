Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2316E66ACE9
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jan 2023 18:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjANRKc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 Jan 2023 12:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjANRKb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Jan 2023 12:10:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE50676A0
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 09:10:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 928F5B808D2
        for <linux-iio@vger.kernel.org>; Sat, 14 Jan 2023 17:10:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70CE5C433D2;
        Sat, 14 Jan 2023 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673716228;
        bh=pQm4y04nFx2RwmRxyEi6p9CMOdHPB+VWcffMleFofKo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YQWTNRx+fXv4vEJAHCmDP4BMuoS46nNXxw1IiETf4ETZYxO24pqHtl9ayxGt0J3Ig
         XlIkIDCWvhWAULGIU/98eX3RxHVOxsJJU4Vd0PcTdc/oZRj14BjoMZruN4UolFLPUg
         Oopt0COMG5/r7jnHCDIPodJtFo9RcUa0HdzHDBY5hlI+JGy/ueE+qLWsJmV67LU+4r
         fdSX2nhEx6qNyqi5jck6XcNHHi6b6A3irHvm55nP306E7QusCM6GahrPkXRRZ3N69U
         2L07/KEZAfxZbEcFdKLlnrMmNbcb3+Uabg0+L9xD5ohpOY+9Iwga8VkFDX/db3VRl4
         z1+8giPynixgw==
Date:   Sat, 14 Jan 2023 17:24:05 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     swboyd@chromium.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx_common: Add old register mapping
Message-ID: <20230114172405.0b0d5b26@jic23-huawei>
In-Reply-To: <20221223154017.20f25396@jic23-huawei>
References: <20221220193926.126366-1-gwendal@chromium.org>
        <20221223154017.20f25396@jic23-huawei>
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

On Fri, 23 Dec 2022 15:40:17 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Tue, 20 Dec 2022 11:39:26 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
> > Older firmwares still send sensor configuration using a list of
> > registers with opaque values defined during sensor tuning.
> > sx9234 and sx9360 sensor on ACPI based devices are concerned.
> > More schema to configure the sensors will be needed to support devices
> > designed for windows, like Samsung Galaxy Book2.
> > 
> > Support schema is: "<_HID>.<register_name>". For instance
> > "STH9324,reg_adv_ctrl2" in:
> > 
> >     Scope (\_SB.PCI0.I2C2)
> >     {
> >         Device (SX28)
> >         {
> >             Name (_HID, "STH9324")  // _HID: Hardware ID
> > ...
> >             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> >             {
> >                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> > Device Properties for _DSD */,
> >                 Package (0x3F)
> >                 {
> > ...
> >                     Package (0x02)
> >                     {
> >                         "STH9324,reg_adv_ctrl2",
> >                         Zero
> >                     },`
> > 
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>  
> LGTM with one exception. See below.  I can fix that whilst applying, but
> would like to leave time for Stephen to take a look anyway.
> 
> ...
> 
> >  
> > @@ -101,6 +105,7 @@ struct sx_common_chip_info {
> >   * @client:		I2C client structure.
> >   * @trig:		IIO trigger object.
> >   * @regmap:		Register map.
> > + * @acpi_id: ACPI device entry when the device is using APCI, NULL otherwise.  
> 
> The lack of num_default_regs below made me suspicious enough to open the code.
> This is the wrong documentation block.
huh. My interpretation of this oddity was wrong.  The actual issue is that
we have docs here for a field that doesn't exist.

I'll send a follow up.

Applied this patch to the togreg branch of iio.git.
Thanks,

Jonathan

> 
> >   * @num_default_regs:	Number of default registers to set at init.
> >   * @supplies:		Power supplies object.
> >   * @chan_prox_stat:	Last reading of the proximity status for each channel.
> > @@ -119,6 +124,7 @@ struct sx_common_data {
> >  	struct i2c_client *client;
> >  	struct iio_trigger *trig;
> >  	struct regmap *regmap;
> > +	const struct acpi_device_id *acpi_id;
> >  
> >  	struct regulator_bulk_data supplies[2];
> >  	unsigned long chan_prox_stat;
> > @@ -151,6 +157,10 @@ int sx_common_probe(struct i2c_client *client,
> >  		    const struct sx_common_chip_info *chip_info,
> >  		    const struct regmap_config *regmap_config);
> >  
> > +void sx_common_get_raw_register_config(struct device *dev,
> > +				       const struct acpi_device_id *id,
> > +				       struct sx_common_reg_default *reg_def);
> > +
> >  /* 3 is the number of events defined by a single phase. */
> >  extern const struct iio_event_spec sx_common_events[3];
> >    
> 

