Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37447D99CF
	for <lists+linux-iio@lfdr.de>; Fri, 27 Oct 2023 15:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345950AbjJ0N26 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 27 Oct 2023 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345982AbjJ0N2y (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 27 Oct 2023 09:28:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B89C9;
        Fri, 27 Oct 2023 06:28:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64ABC433C9;
        Fri, 27 Oct 2023 13:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413332;
        bh=mIy3SOTr5JP1ZcZOaeFylzam1NEjWOPfdIq1B0ER9T8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljgdEUe2+n5YDJoZH2IATJIq+7r8ts7XXonc30DTfezrdKYeZ1q6hoYL5WHQV2ZKh
         RSwVY9v/hcGxrC/ip6Xm4kPLUCK+n9RmZqfHnWG2KDhopU3Wn2+omS7uVhkuDDnRCG
         OwvIe+QORZuEQomqgmhjdALz6lKChsZi5KhLQ7sukJEb35/2AhOlSzxuJwT91OumrE
         DD6QrB86q+IZRwcuAfUeikhhUvNuc9qNXnZj/XQACDh/NxRX/Z1k5NcacPe05rN/th
         BN2LBDFS1VtN08IeovE9w8ehInj7h9ECiANGvJchFiPy/910SCQ/vGpj+/o3rsHwVo
         iTUgMwsB+lDrg==
Date:   Fri, 27 Oct 2023 14:28:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Amit Dhingra <mechanicalamit@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] MAINTAINERS: correct file entry IIO LIGHT SENSOR
 GAIN-TIME_SCALE HELPERS
Message-ID: <20231027142850.6c469cd2@jic23-huawei>
In-Reply-To: <CAO=gReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9UeQekA@mail.gmail.com>
References: <CAO=gReHuuwB6mBZAXpYHGk9XsWE8e8+U3T9e6iqCXYQMcjZZVg@mail.gmail.com>
        <a0636e8e-7a39-4c58-8dee-7187ffd7fc63@gmail.com>
        <e806f42f-9baa-4689-882a-144647cc03a3@gmail.com>
        <CAO=gReECvyMDe5kbSeFQ3rAc1n6e2vkcE2mtMYUE3c45QMvW-A@mail.gmail.com>
        <CAO=gReFVhp7QK_XZRBO5vbv6fmFb4BdsZeQPSzWvuiz9UeQekA@mail.gmail.com>
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

On Thu, 26 Oct 2023 04:13:44 -0700
Amit Dhingra <mechanicalamit@gmail.com> wrote:

> Commit ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers"),
> updates the MAINTAINERS file. However the files listed do not exist.
> These presumably come from commit 38416c28e168 ("iio: light: Add
> gain-time-scale helpers")
> 
> Fix the entries.
> 
> Found by ./scripts/get_maintainer.pl --self-test=patterns
> 
> Fixes: ca11e4a35154 ("MAINTAINERS: Add IIO gain-time-scale helpers")
> Signed-off-by: Amit Dhingra <mechanicalamit@gmail.com>
Applied to the togreg branch of iio.git.

Whilst nice to tidy it up, I'm not sure it's going to make much difference
to anyone so not rushing this in.

Thanks,

Jonathan

> ---
>  MAINTAINERS | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 668d1e24452d..99c2285c58e5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -10177,8 +10177,8 @@ IIO LIGHT SENSOR GAIN-TIME-SCALE HELPERS
>  M:	Matti Vaittinen <mazziesaccount@gmail.com>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> -F:	drivers/iio/light/gain-time-scale-helper.c
> -F:	drivers/iio/light/gain-time-scale-helper.h
> +F:	drivers/iio/industrialio-gts-helper.c
> +F:	include/linux/iio/iio-gts-helper.h
> 
>  IIO MULTIPLEXER
>  M:	Peter Rosin <peda@axentia.se>

