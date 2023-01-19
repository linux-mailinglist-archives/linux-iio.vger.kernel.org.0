Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DFD673D18
	for <lists+linux-iio@lfdr.de>; Thu, 19 Jan 2023 16:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjASPIc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Jan 2023 10:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjASPIb (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Jan 2023 10:08:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3AA2D147;
        Thu, 19 Jan 2023 07:08:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0FD61C40;
        Thu, 19 Jan 2023 15:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCA1C433D2;
        Thu, 19 Jan 2023 15:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674140908;
        bh=gWg8R9h32+YanBxUrwFptR8qDXzcix128ZijjGUPXE8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mvK3Qp86sII9omRQ4/aay2babUNA9v1MIJZRUV9u1rbIV4KoVcJX4Hfca98s02BrI
         iUklylOMQRJQpNLJGzSeX6ltjSHcZSqfB+kvt7UajQmRCAqbX0Easa5XxsEwDk5wl/
         S5MYRv3bpqgRPpt4C+WNt6AGozO17xej5Il4ILP+nAOSdOyjEEr49rIja2muhF64yV
         TqPTZfwvGnH7CGDnPaLkejVqcMtw4f8atkZAO5FV1kzMmbwUFOiFcZ5VrZ3/0mRqCA
         8pz0ZgZ1NLOp/Z/AzScVH0WMKwNwJZG9Lc+QYqogVdOOqsrgAuwJk5HhZM70fNT2ar
         //uv4wgIQdDDQ==
Date:   Thu, 19 Jan 2023 15:08:23 +0000
From:   Lee Jones <lee@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     sre@kernel.org, jic23@kernel.org, lars@metafoo.de,
        andy.shevchenko@gmail.com, linux-pm@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 4/7] mfd: mp2629: Add support for mps mp2733 battery
 charger
Message-ID: <Y8lc52I7A9TkWpMa@google.com>
References: <20221123175425.564042-1-sravanhome@gmail.com>
 <20221123175425.564042-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221123175425.564042-5-sravanhome@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

MP2733, MP2629, MPS, Battery Charge Management? 

On Wed, 23 Nov 2022, Saravanan Sekar wrote:

> mp2733 is updated version of mp2629 battery charge management
> device for single-cell Li-ion or Li-polymer battery. Additionally
> supports USB fast-charge and higher range of input voltage.
> 
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/mfd/mp2629.c       | 1 +
>  include/linux/mfd/mp2629.h | 1 +
>  2 files changed, 2 insertions(+)

Once the above has been fixed, please add my:

For my own reference (apply this as-is to your sign-off block):

Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
