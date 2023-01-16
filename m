Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB9F66CDD4
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jan 2023 18:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232583AbjAPRmx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Jan 2023 12:42:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235051AbjAPRmV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Jan 2023 12:42:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFB523846
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 09:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F22696108B
        for <linux-iio@vger.kernel.org>; Mon, 16 Jan 2023 17:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78CEBC433F0;
        Mon, 16 Jan 2023 17:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673889606;
        bh=c/+8BVWXgzuRXFjz4Dbw2XkS81BAljkKtZEMkbtvh4Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ik4BqilWgfVAbyP96IgXhyej5ud+A7hPy5tvA1MsVoE0jJddT89ZdrVN4tQ8YKNAS
         vTTw2937iJI8SGzgdIT5MUYyfPoqQ1Oms7Svz6ARfvADWQcDNFZd8kluqeCswh0oi0
         csjNwXT+GPimEED8mG1dVD0Gt6QcecO5zKEOzol0HdUFYNu7GjGyq3MwrxhT2RtxbR
         HP3bs+aHJSeZ41PTjFuC4lxtNLMu2+QpNuXsL1a4NbVNF3JbsFzZoRYvfvYCL76CsC
         eKYxWyOhgXgfW2nRpKegZ0ILDfX2cPb2Nx4v8Siv+zu9Hfx99Fo0407LVOzmM+Kxgl
         94FNfsE79WWew==
Date:   Mon, 16 Jan 2023 17:33:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     andy.shevchenko@gmail.com
Cc:     Gwendal Grignou <gwendal@chromium.org>, swboyd@chromium.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: sx_common: Add old register mapping
Message-ID: <20230116173346.43c1ee20@jic23-huawei>
In-Reply-To: <Y8RE0QBbNWbfwi0l@surfacebook>
References: <20221220193926.126366-1-gwendal@chromium.org>
        <Y8RE0QBbNWbfwi0l@surfacebook>
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

On Sun, 15 Jan 2023 20:24:17 +0200
andy.shevchenko@gmail.com wrote:

> Tue, Dec 20, 2022 at 11:39:26AM -0800, Gwendal Grignou kirjoitti:
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
> 
> ...
> 
> Can we use acpi_device_hid() from the ACPI companion device instead of calling
> acpi_match_device()?
> 
> Note that in this case you won't need half of this patch that passes acpi_id
> here and there.
> 
> ...
> 
> > +	scnprintf(prop, ARRAY_SIZE(prop), "%s,reg_%s", id->id, reg_def->property);  
> 
> Why c? The regular snprintf() will work the same since you haven't checked for
> the error.
> 
Dropped this patch for now so this discussion can continue.

Jonathan

