Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69D7641E8B
	for <lists+linux-iio@lfdr.de>; Sun,  4 Dec 2022 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbiLDSCp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 4 Dec 2022 13:02:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiLDSCo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 4 Dec 2022 13:02:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D996260
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 10:02:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D325C60EE2
        for <linux-iio@vger.kernel.org>; Sun,  4 Dec 2022 18:02:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5213EC433C1;
        Sun,  4 Dec 2022 18:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670176962;
        bh=JllFXrxOL4eg4+4ZLFYSnmRNiuGS/DtFHhKIN5HQxdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Ad31qGNWwCC5PdWgIh4xGxP/XO5zb8CAykEPD+iHdZ1AATR15gY15/O/IQvNtgdX0
         b/4g2vlpXLWMxHAHkwkWTadjlUfazaw/uDD3ql0DNl1+ErKDHDAA2pAqmWm7SFJKJ9
         HmFYr5UJ/Uqaf6KwWuY/OyUEWA5ACtilX5Y8cVRRljx6TQUmCMXtqbF9Bgc53j7TMY
         5ETWrstR7vjNwZanqm6MbasR4EgfByiTBhnGR6WQTQytl0XlAd5KZjy4nmuY3qt+TY
         B13WmKdxT9XyMkEadjmV3YJmNvzsOYhisRBXZP2LjvpTxPvHg2+VS9mOW0TdZPOYJJ
         N3foeuctwRr5g==
Date:   Sun, 4 Dec 2022 18:15:26 +0000
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
Subject: Re: [PATCH 02/14] iio: accel: bma400: Use
 devm_regulator_bulk_get_enable()
Message-ID: <20221204181526.7c173bd2@jic23-huawei>
In-Reply-To: <2dcc9735-ea2d-a796-5ab4-d1928a346908@gmail.com>
References: <20221016163409.320197-1-jic23@kernel.org>
        <20221016163409.320197-3-jic23@kernel.org>
        <2dcc9735-ea2d-a796-5ab4-d1928a346908@gmail.com>
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

On Mon, 17 Oct 2022 08:27:29 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/16/22 19:33, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > This driver only turns the power on at probe and off via a custom
> > devm_add_action_or_reset() callback. The new
> > devm_regulator_bulk_get_enable() replaces this boilerplate code.
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jagath Jog J <jagathjog1996@gmail.com>  
> 
> Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
Now applied this one with slight fuzz due to the fix on ordering that crossed
with this.

Jonathan
