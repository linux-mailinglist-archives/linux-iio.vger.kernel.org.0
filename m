Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905D755238B
	for <lists+linux-iio@lfdr.de>; Mon, 20 Jun 2022 20:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238373AbiFTSH0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 20 Jun 2022 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235843AbiFTSHZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 20 Jun 2022 14:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B281AF12
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 11:07:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 817386158A
        for <linux-iio@vger.kernel.org>; Mon, 20 Jun 2022 18:07:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0DFC341C4;
        Mon, 20 Jun 2022 18:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655748443;
        bh=emiH/nkiB4LRfl4YbcP4q238Ek9cnNaD0f0wciRs5Bk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UmRTccA0/VOJgDgYGEOeEc/6M91TuBh7IgMR7vEseKg7TNoukiHjgR6V+NnNeYpTn
         tDmMRsGp2IrSh6RVntZPBmG9aWr7dxHnbypZShIxDQbrVB7PWcu3tX7IYD9GuVu6uk
         /j7m5VXPg5yNvJ2Q2ndlbr8SLwiI2m5pHiUOlXeZtuEyaX1fDhHFJfeiXUc7TPkC7F
         vFR2rQanVXnlOhluxfy6AWbYnYTS3YtEQFmpdHAUG0Z+1wfCZUORtXarNXzcEOhQSq
         RYPeEXfGG+EspWZagowN00Ztf7//KINCL9VEetpKKjSp2hGGOEMS1XzR18DtFEheRC
         kCL5Efs9z/jUw==
Date:   Mon, 20 Jun 2022 19:07:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 00/17] staging/iio: Clean up AD7746 CDC driver and
 move from staging.
Message-ID: <20220620190718.3978775e@jic23-huawei>
In-Reply-To: <CAHp75VdjNuXeNPsjV4owGt5yg9N9kN8iYMKUX8rn=PRFpLKa+A@mail.gmail.com>
References: <20220619185839.1363503-1-jic23@kernel.org>
        <CAHp75VdjNuXeNPsjV4owGt5yg9N9kN8iYMKUX8rn=PRFpLKa+A@mail.gmail.com>
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


> 
> Overall it looks good to me. One Q though, do you plan to switch it to
> regmap APIs?

Probably not unless doing some more significant work on the driver for
some other reason.  It's definitely not yet a requirement that IIO drivers
use regmap, even though it is of course desirable where it fits well.
Given it should be fine to do the conversion and rely on roadtest to
see if anything isn't broken, converting this one might be a good first
patch for someone who is interested in writing modern drivers.

Thanks,

Jonathan
