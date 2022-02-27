Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBF4C5ABE
	for <lists+linux-iio@lfdr.de>; Sun, 27 Feb 2022 12:55:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbiB0Lzv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Feb 2022 06:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiB0Lzv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Feb 2022 06:55:51 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A989F31900
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 03:55:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3721C60E9B
        for <linux-iio@vger.kernel.org>; Sun, 27 Feb 2022 11:55:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93FB3C340E9;
        Sun, 27 Feb 2022 11:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645962913;
        bh=1D46LrvQDmcYzxzHk0RLMPYyM8EV3PHh9+WRVp5XWa0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NBJctDlFoWnJJmkLzv6gW9pBQk+6sWeFWhVjbpXdxCnosJ4Nsyc8oOMsbeTToQY7C
         h/VMwSWVOtCnXbb2x8haTDsUuGuR8AqJsNuZ7n+HykVBLAik6YURlBvS1lk6a3mc9D
         sw1Pnz5gyM3GGLGHBwuTxqfn9m8ZNksvgfiQqK5zqaqeMRAav68LALWc3sKVidNq9l
         qaFFaU5tgKdEmcN8R+Ymv1LZCnZ6ugVDwb43rpB3t9g/5NWPlwT+5m3uKKR7Cb+9qR
         +wb3GgGGxchBSJEAN9FerOJVz6i8jT36ExfEV/mY9SVg5muAd1Yzp3FKNZXvhEyH0y
         /uEYbiGNsYuGw==
Date:   Sun, 27 Feb 2022 12:02:15 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        linux-iio <linux-iio@vger.kernel.org>, patches@lists.linux.dev,
        llvm@lists.linux.dev, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: adxl367: Fix handled initialization in
 adxl367_irq_handler()
Message-ID: <20220227120215.4c112bc2@jic23-huawei>
In-Reply-To: <CAHp75VdW8g_bvPvvfWOW5SUkEm9PYu8UvO9Mf_wshLLB3u=zPw@mail.gmail.com>
References: <20220224211034.625130-1-nathan@kernel.org>
        <CAHp75VdW8g_bvPvvfWOW5SUkEm9PYu8UvO9Mf_wshLLB3u=zPw@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 26 Feb 2022 21:49:16 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Feb 24, 2022 at 11:25 PM Nathan Chancellor <nathan@kernel.org> wrote:
> 
> ...
> 
> >   drivers/iio/accel/adxl367.c:879:14: note: initialize the variable 'handled' to silence this warning
> >           bool handled;
> >                       ^  
> 
> >                        = 0  
> 
> Bad advice (at minimum it should be false, but in general it might
> hide a real issue)

True. Thankfully Nathan did the right thing and looked for the real
problem :)

Jonathan

> 
> >   1 error generated.  
> 

