Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E474F78A067
	for <lists+linux-iio@lfdr.de>; Sun, 27 Aug 2023 19:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjH0RHG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Aug 2023 13:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjH0RGu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Aug 2023 13:06:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8F12D
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 10:06:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 400C86191F
        for <linux-iio@vger.kernel.org>; Sun, 27 Aug 2023 17:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A02C433C7;
        Sun, 27 Aug 2023 17:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693156006;
        bh=kf7goXxFzP7UPvM4+zs0gsazvakWRvcmTwI7V2CQnXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PowsSb3w+mXwzknuW+XZpdoiv2+Y2ez5ogTodw8fsCwGSZ6AyOg00Fhpg+eEmoXnW
         rNtnFw6NX66XUhrt+OXzNT68ByUkB744I9xychP9SbcDGOhCL8pgunIp8QeyhfoKZQ
         WrULVepsdTdX5dS2WGTFujqRU9KqQxpKYlvNYvBgQCF1PwNe2T0HHrqKQ9KkXdNRW/
         fd2/S62TvNtSCu4MZB0y09g+FN3RZnkE2I/wOY1gyKQK/y6nqkaAYvi1lrNyG6Td3c
         FO50Gx4dRhetJUS1yn0hHiEFBXP5QymWpljYnT0uG4IIUsiuN8fd1OYu77IknGtAl2
         d/RSIlbM8k9fQ==
Date:   Sun, 27 Aug 2023 18:07:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jinjie Ruan <ruanjinjie@huawei.com>
Cc:     <lars@metafoo.de>, <matthias.bgg@gmail.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH -next 0/2] iio: adc: mt6577_auxadc: Cleanup with the
 helpers
Message-ID: <20230827180706.09242b5d@jic23-huawei>
In-Reply-To: <20230826035402.3512033-1-ruanjinjie@huawei.com>
References: <20230826035402.3512033-1-ruanjinjie@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Aug 2023 11:54:00 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Use the dev_err_probe() helper to simplify error handling during probe.
> This also handle scenario, when EDEFER is returned and useless
> error is printed.

Just a quick note to the driver maintainers.  Whilst I've applied this,
I won't be pushing that out as a non rebasing tree for a few weeks.
As such I'm very happy to add tags, or indeed to drop it if you see
any changes you would like.

Taking it quickly is mostly because I have a huge backlog having been
away and want to get the simple stuff off that list!

Thanks,

Jonathan

> 
> And use devm_add_action_or_reset() and devm_iio_device_register()
> to simplify the code.
> 
> Jinjie Ruan (2):
>   iio: adc: mt6577_auxadc: Simplify with dev_err_probe()
>   iio: adc: mt6577_auxadc: Simplify with device managed function
> 
>  drivers/iio/adc/mt6577_auxadc.c | 60 +++++++++++++--------------------
>  1 file changed, 23 insertions(+), 37 deletions(-)
> 

