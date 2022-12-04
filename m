Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB6A641E90
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 19:06:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiLDSG3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 13:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiLDSG2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 13:06:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC9DEE5
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 10:06:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3167760EE1
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 18:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA974C433D6;
        Sun,  4 Dec 2022 18:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670177186;
        bh=EdLb9a9G+RAOv9mD3dt/nbq2zeaQ9ik5OSkBOGzKArA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aBx4aToU/ViaEFaU8qCyTz+wayeHhLLfSpwXar/dvUTomXyarmOaHYiX/yvrSEO9+
         08Ed24zj/16t62nfJSpCWhqFPJilo6KVrOFU6/g2UMLKdDbu+RZeHe9UBvkFRjv33h
         y7SMAgJp8A8gw0uEvu20syyBfgOf/4bdVLeZ70wkzAymsuP6AGu6JE+Kff8Fh9+KP2
         Wtk715zS9BpnlBOTftz/UQP9+aa/KhvCnYHqZZSb5YUJbY+wK1MB/DqBr3s2+4iYgw
         gxOkOnu9Ix6zvCh17QyCHsFVN+KcxFTrbdk1sxzeeJksRogsEXT3C1HVLfOa7p+Guz
         yzva0pHgyJfzQ==
Date:   Sun, 4 Dec 2022 18:19:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martyn Welch <martyn.welch@collabora.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 13/14] iio: pressure: ms5611: Use
 devm_regulator_get_enable()
Message-ID: <20221204181910.1ee1ae92@jic23-huawei>
In-Reply-To: <e4dbfb4d-cd92-f72f-caf0-4eece7678de7@gmail.com>
References: <20221016163409.320197-1-jic23@kernel.org>
        <20221016163409.320197-14-jic23@kernel.org>
        <e4dbfb4d-cd92-f72f-caf0-4eece7678de7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Mon, 17 Oct 2022 09:26:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/16/22 19:34, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This driver only turns the power on at probe and off via a custom
> > devm_add_action_or_reset() callback.  
> 
> I think this one did not use devm_add_action_or_reset()
The other changes hitting this driver are now upstream so applied
to the togreg branch of iio.git with a bit of fuzz.

Thanks,

Jonathan

> 
> > The new devm_regulator_get_enable()
> > replaces this boilerplate code. Some additional refactoring to drop
> > now unnecessary unwinding after this change.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Tomasz Duszynski <tduszyns@gmail.com>
> > ---
> >   drivers/iio/pressure/ms5611.h      |  3 ---
> >   drivers/iio/pressure/ms5611_core.c | 32 +++++-------------------------
> >   2 files changed, 5 insertions(+), 30 deletions(-)
> >   
> 
> // snip
> 
> > @@ -477,7 +456,6 @@ void ms5611_remove(struct iio_dev *indio_dev)
> >   {
> >   	iio_device_unregister(indio_dev);
> >   	iio_triggered_buffer_cleanup(indio_dev);
> > -	ms5611_fini(indio_dev);
> >   }
> >   EXPORT_SYMBOL_NS(ms5611_remove, IIO_MS5611);  
> 
> Just a thought but maybe the whole remove() could be done using devm()? 
> (As far as I can say the current flow works. AFAICS the devm unwinding 
> is done after the remove() has been ran. But perhaps it would be cleaner 
> if the remove() would not need to be exported at all.)
> 
> With, or without the remove() removed, if commit description is fixed:
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

