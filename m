Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51EBE53D78C
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jun 2022 17:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237666AbiFDPrI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Jun 2022 11:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237602AbiFDPrH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Jun 2022 11:47:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01F997661
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 08:47:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8FB2260B4F
        for <linux-iio@vger.kernel.org>; Sat,  4 Jun 2022 15:47:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE965C385B8;
        Sat,  4 Jun 2022 15:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654357625;
        bh=dB06cGiVznxpqsRNu4Py/lM2r9oAIHBvY6ImJOZENUQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IBoo1SiLNUVeI7ao3C7zusjuSkb3RRhKhnV9nzOeYHSmRqiXnCAQ5JoUyvkFboPFZ
         uPZq1PzyLhpJQSOJ5FtYO64nujAy6UgaJ6A+u9KR7fUpm9iYRyJWNrwcM3RY08AGh3
         sUNm95nxVOH4i0f9LhblLQNrA1/dTIgU0Uee5UEly3/nUVQ+DBe5uQy1+55EE4FUD4
         Ot8G54fJOZOZ0HvJ1GdQL0wvX1jsImtzYAyFauI5fS1igpHVNSkI+i/neDwFpo7jAJ
         41Wt7HEb/JJjh4QucSdYEIV8C8rOhanmomNht6/T/fbwQqTTNUGrqvk9/P8EJ9odVl
         7Mkt5IfRqJzaQ==
Date:   Sat, 4 Jun 2022 16:56:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio: gyro: mpu3050: Cleanup exports and PM
Message-ID: <20220604165607.748bdbef@jic23-huawei>
In-Reply-To: <20220220175149.503495-1-jic23@kernel.org>
References: <20220220175149.503495-1-jic23@kernel.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Feb 2022 17:51:47 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Paul Cercueil happened to chose this driver as his example for
> EXPORT_RUNTIME_DEV_PM_OPS() in his recent patch set to cleanup
> how we handle dev_pm_ops.
> 
> https://lore.kernel.org/linux-pm/20220105101106.00005ae0@Huawei.com/
> 
> Whilst reviewing that I noticed that there were a bunch of exports
> in this driver that are only used by other files compiled into the same
> module.  Paul found another driver to demo his new infrastructure.
> 
> This series is cleaning up that oddity by first dropping the exports
> and then using the new pm_ptr() and DEFINE_RUNTIME_PM_DEV_OPS() to allow
> the compiler to be responsible for removing the unused code for us rather
> than requiring manual CONFIG_PM guards.
> 
Oops. Lost my own series down the back of the sofa.  No idea why
I didn't apply these when Linus reviewed them back in March.

Anyhow, now applied to the togreg branch of iio.git (with some fuzz)
and pushed out as testing to see if 0-day is happy with them.

Thanks,

Jonathan

> Jonathan Cameron (2):
>   iio: gyro: mpu3050: Drop unused symbol exports.
>   iio: gyro: mpu3050: Use pm_ptr() and DEFINE_RUNTIME_DEV_PM_OPS()
> 
>  drivers/iio/gyro/mpu3050-core.c | 14 ++------------
>  drivers/iio/gyro/mpu3050-i2c.c  |  2 +-
>  2 files changed, 3 insertions(+), 13 deletions(-)
> 

