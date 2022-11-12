Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D28626A40
	for <lists+linux-iio@lfdr.de>; Sat, 12 Nov 2022 16:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235044AbiKLPev (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 12 Nov 2022 10:34:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231404AbiKLPeu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 12 Nov 2022 10:34:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B417594
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 07:34:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC6BC60C38
        for <linux-iio@vger.kernel.org>; Sat, 12 Nov 2022 15:34:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF64C433C1;
        Sat, 12 Nov 2022 15:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668267289;
        bh=WxbMz4/fUf7Fe2xOa5+LMV9hyt2Qx8O/KbyoyCjkLII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MHXMn/UFPUXzbbgv7ozGPBf8Ft4s9gVJ4ZpSTviP0hmRL4rzwzWfEjsrVqwKMNqAp
         sZnNySGe5Nhc0YDe1MqZYHyf1KZhThjH8tF2D8c7WNteIPjqOD3D5HF7WHEns2kQpx
         2aov0iOVPRHT/vF0oROizSJlxwp5LMgi/wXba07HpcN2v8u2Uogs/QXtBxqqBDmy1C
         nwhOjUQE10lSdh6+6HajFJfDn38F5pPMGwfd8kXdnOvJM/Z5IfAj2j8CjA6Tz/TjzB
         n0ZMiwtWJrqKdQaF4qzWuTB8gduMVC7Dl4wHEGqvj4NCvrVrYbmeTJuo96UIyqTB9a
         oNVsPT7GN7QCw==
Date:   Sat, 12 Nov 2022 15:47:03 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org, Crt Mori <cmo@melexis.com>
Cc:     coverity-bot <keescook@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio: mlx90632: Minor fixes
Message-ID: <20221112154703.6bf2200c@jic23-huawei>
In-Reply-To: <20221105125108.383193-1-jic23@kernel.org>
References: <20221105125108.383193-1-jic23@kernel.org>
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

On Sat,  5 Nov 2022 12:51:06 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> A couple of minor fixes.  The devm_ error handling was a coverity report.
> Static was a warning I'd missed originally but saw in build whilst testing
> the above.
> 
> Crt, could you give these a quick look (+tag ideally) then I'll get them
> on the tree so the issue is fixed in Linux next before I send Greg a pull
> request.

Series applied.

Thanks,

Jonathan

> 
> Jonathan Cameron (2):
>   iio: temperature: mlx90632: Add error handling for
>     devm_pm_runtime_enable()
>   iio: temperature: mlx90632: Add missing static marking on devm_pm_ops
> 
>  drivers/iio/temperature/mlx90632.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 

