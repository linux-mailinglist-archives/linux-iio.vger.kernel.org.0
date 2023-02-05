Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E3568B082
	for <lists+linux-iio@lfdr.de>; Sun,  5 Feb 2023 16:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBEPJp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Feb 2023 10:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBEPJp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Feb 2023 10:09:45 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA671E1F2
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 07:09:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3B653B80C85
        for <linux-iio@vger.kernel.org>; Sun,  5 Feb 2023 15:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E502FC433EF;
        Sun,  5 Feb 2023 15:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675609781;
        bh=onZwIXt+bYLm7jU0MfUYNhhAP4gkRA2GnoXYrcBCAHU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MT0COwV0u3FmYjYwdV41Nv4OF0xJPvUEXCV7dXDtZ5nBiXKbn6UfNvwj01gtwIzBf
         jiX8Ismggj1c7uUDxlWM5DOFWWsnh/FRHGJaMhRhh4DiciaM9pArAwuGvT30yS4tNq
         I1/UWASu2glNC5AXG/p8gceDsEXdxcEi6brt5H7OGhUf9v+bD6cSi9ZZlN3gvF9uKt
         oiosgs8srngdYTsLg22S+nw9x59R+kTrwrrWIfJBUilWmiBD9Dhb8XCfy3+vZEsmHs
         +0N/gmxSm5vHLpWP4ehUKswar6uWGanwFGOr0iX+UbmCDrFCIzaXPtx9+4TotBoWrk
         unRBB79OpgLMA==
Date:   Sun, 5 Feb 2023 15:23:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: Re: [PATCH] iio: proximity: sx_common: Drop documentation of non
 existent struct element.
Message-ID: <20230205152343.527ad5bd@jic23-huawei>
In-Reply-To: <CAE-0n502JpQWfZsN960KcA34ndrqMmkmznCNGY36eGJ=JPiy3g@mail.gmail.com>
References: <20230114172928.80414-1-jic23@kernel.org>
        <CAE-0n502JpQWfZsN960KcA34ndrqMmkmznCNGY36eGJ=JPiy3g@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 18 Jan 2023 17:54:28 -0600
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2023-01-14 09:29:28)
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > struct sx_common_data doesn't have a num_default_regs element so
> > drop the documentation for it.
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Gwendal Grignou <gwendal@chromium.org>
> > Cc: Stephen Boyd <swboyd@chromium.org>
> > ---  
> 
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

I rebased this on the new version of
[PATCH v3] iio: proximity: sx_common: Add old register mapping
which changed the context a bit.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to look at it.

Jonathan
