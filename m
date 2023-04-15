Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70156E3328
	for <lists+linux-iio@lfdr.de>; Sat, 15 Apr 2023 20:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjDOSZ3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 15 Apr 2023 14:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbjDOSZ2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 15 Apr 2023 14:25:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CEE448D
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 11:25:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60BBE615C6
        for <linux-iio@vger.kernel.org>; Sat, 15 Apr 2023 18:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794C0C433D2;
        Sat, 15 Apr 2023 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681583125;
        bh=EccXaNidvejIFoqrbxddeoXIRuVKnjy1FQDZVCcbKm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OzdtSrjCwQkSGNJyiecXi8qJXDCnoRfq7sfbPfNHzgk27Eg3q28dVcv3oO12GaPAT
         1RcISjI1OgHv8qdJg67OBzcTZGw/1AK6clhALCR9660zbMPCSZUzvb/OW8xOA5eO0B
         GAL0Mo4lxkLCT7EZW14SVGT7G2w+6qsQiQPT4dQM=
Date:   Sat, 15 Apr 2023 20:25:22 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of features for the 6.4 cycle.
Message-ID: <2023041512-overripe-lid-2dfb@gregkh>
References: <20230415185027.60a34106@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230415185027.60a34106@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Apr 15, 2023 at 06:50:27PM +0100, Jonathan Cameron wrote:
> The following changes since commit fba51482b6c0a6743b441bd57d53be11beb35a9b:
> 
>   Merge tag 'iio-for-6.4a' of https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio into char-misc-next (2023-04-12 09:45:34 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.4b

Pulled and pushed out, thanks.

greg k-h
