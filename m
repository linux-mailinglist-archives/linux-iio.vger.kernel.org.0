Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63A77D0865
	for <lists+linux-iio@lfdr.de>; Fri, 20 Oct 2023 08:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235627AbjJTGW2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 20 Oct 2023 02:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbjJTGWV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 20 Oct 2023 02:22:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DBABD4C
        for <linux-iio@vger.kernel.org>; Thu, 19 Oct 2023 23:22:19 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E23C433C7;
        Fri, 20 Oct 2023 06:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697782939;
        bh=9qTV89XE2V2xrKVbG4lOpKFnDKfqeBnivwOObMT2Bo4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YTVSZqW//XiCLiVs6516OUM7xRFc9FDHWdvptrlZ6prhTnahoGxXAlqrn7W7p0Yiu
         RP9ZK1x9kaem+tyEDwerwooJVeUskcmOQU163+6O6MmsdnUpb8echx0T5SGeglT+em
         rLFwarvrSPbLikfwkDiJNKlSyEj151u3JJLl8yKA=
Date:   Fri, 20 Oct 2023 08:13:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, features and cleanup
 for 6.7
Message-ID: <2023102032-pebbly-posh-97b5@gregkh>
References: <20231017202438.2ace1422@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202438.2ace1422@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Oct 17, 2023 at 08:24:38PM +0100, Jonathan Cameron wrote:
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.7a

Pulled and pushed out, thanks.

greg k-h
