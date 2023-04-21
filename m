Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 389436EA495
	for <lists+linux-iio@lfdr.de>; Fri, 21 Apr 2023 09:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjDUHWI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 21 Apr 2023 03:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbjDUHWH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 21 Apr 2023 03:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03364DC;
        Fri, 21 Apr 2023 00:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 873E064E3E;
        Fri, 21 Apr 2023 07:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EF63C433EF;
        Fri, 21 Apr 2023 07:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682061725;
        bh=FwLRxDR9MFCxG4/NR6xh4TDXmQe9nb8mtDHLKN1BZSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qp7++j3JGmtObLdpT13iUFGXw1QbAZR0Jm5Na31sND5LkUn6cBcS/PFJ2Mx2niEov
         AksVgTx6c5F3WgReSzZH1lzxGvMeKLpaiDyQJ80Ob/stoQoKZK/kML5DJ/97G8K9mu
         ZjF1kGEW0WlIMVncDayxtIDYvlctYXW7knRkC9uuq35YDJ3dZP5nKaE5/3qmYWHrQt
         ii/MU5WQ/47q1R6S3CUhana5GdZ9nTC3hKudvD1/AUL3qaXd60uDiYSwlbYsMehvoE
         8D4L7XJ57zycx/WTaw2HKn+Y8nWkTWhSy8uc8mQNMdbryo03i+b/4gCySN0DzUvTHN
         2H3YmP9DqdDfQ==
Date:   Fri, 21 Apr 2023 08:22:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] counter: rz-mtu3-cnt: Unlock on error in
 rz_mtu3_count_ceiling_write()
Message-ID: <20230421072201.GJ996918@google.com>
References: <7b535d6b-6031-493a-84f6-82842089e637@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b535d6b-6031-493a-84f6-82842089e637@kili.mountain>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 20 Apr 2023, Dan Carpenter wrote:

> These error paths need to call mutex_unlock(&priv->lock) before
> returning.  The lock is taken in rz_mtu3_lock_if_counter_is_valid().
> 
> Fixes: 25d21447d896 ("counter: Add Renesas RZ/G2L MTU3a counter driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: I had the wrong function in the subject.  Also style changes.
> 
>  drivers/counter/rz-mtu3-cnt.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
