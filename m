Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2499C6923E8
	for <lists+linux-iio@lfdr.de>; Fri, 10 Feb 2023 18:03:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjBJRDR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Feb 2023 12:03:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBJRDQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Feb 2023 12:03:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E926FEB0
        for <linux-iio@vger.kernel.org>; Fri, 10 Feb 2023 09:03:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E584B8259D
        for <linux-iio@vger.kernel.org>; Fri, 10 Feb 2023 17:03:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA30C433D2;
        Fri, 10 Feb 2023 17:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676048592;
        bh=4phiVarOwteAC4tlMADX/wuSvTwRmWWfJQTtXH7vRxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Umxs3fNQTM9Uu406+mX9L0aCD5jpSWSDUqFNsWMaqjHF3SVAlyU9UKAT+F9bPEUOU
         /DwMlqMr549pvLG9kOJ9k7Fwk/M1/rv6qDLotgAEWT+VTe3F1LIOMmTk7K7xCAfMD3
         x+u1Wh+7dY+O99fkgRaM+nP+bZoQNE+1MgiptsBtjkKo3wjHyqmP4bsXqUB1N9Y1Qy
         HsJ2+6XpYYFvux9C8KssCim1n8SxR49nCAbLeAqOcz6Y1SyAXlDF+cq2wB8to+oWdI
         Q4cTauLraHLVTvkITKQiJqCW8PCr1BNm1wqVtxG+K3waqBz3FVS1IlExQN3wVZl4fT
         vxXUJcwzJm8rQ==
Date:   Fri, 10 Feb 2023 17:17:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: proximity: sx_common: Add old register mapping
Message-ID: <20230210171720.30ef1be9@jic23-huawei>
In-Reply-To: <20230205145759.2ce9f274@jic23-huawei>
References: <20230129003753.1980309-1-gwendal@chromium.org>
        <CAE-0n510nBDOdWXH43qhRtVsQOCPCbkeP1wCr2LvGXbbXyg5yg@mail.gmail.com>
        <20230205145759.2ce9f274@jic23-huawei>
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

On Sun, 5 Feb 2023 14:57:59 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Mon, 30 Jan 2023 11:41:31 -0800
> Stephen Boyd <swboyd@chromium.org> wrote:
> 
> > Quoting Gwendal Grignou (2023-01-28 16:37:53)  
> > > Older firmwares still send sensor configuration using a list of
> > > registers with opaque values defined during sensor tuning.
> > > sx9234 and sx9360 sensor on ACPI based devices are concerned.
> > > More schema to configure the sensors will be needed to support devices
> > > designed for windows, like Samsung Galaxy Book2.
> > >
> > > Support schema is: "<_HID>.<register_name>". For instance
> > > "STH9324,reg_adv_ctrl2" in:
> > >
> > >     Scope (\_SB.PCI0.I2C2)
> > >     {
> > >         Device (SX28)
> > >         {
> > >             Name (_HID, "STH9324")  // _HID: Hardware ID
> > > ...
> > >             Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
> > >             {
> > >                 ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /*
> > > Device Properties for _DSD */,
> > >                 Package (0x3F)
> > >                 {
> > > ...
> > >                     Package (0x02)
> > >                     {
> > >                         "STH9324,reg_adv_ctrl2",
> > >                         Zero
> > >                     },`
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---    
> > 
> > Reviewed-by: Stephen Boyd <swboyd@chromium.org>  
> Applied to the togreg branch of iio.git and pushed out as testing.
> 
> Timing wise, we are late in the cycle so this might not make it upstream
> until next cycle.
> 

Dropped for now as we need to fix an issue with acpi_device_hid()
not being defined with !CONFIG_ACPI that broke some builds in next.

Jonathan


> Thanks,
> 
> Jonathan
> 

