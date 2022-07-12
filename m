Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1665572202
	for <lists+linux-iio@lfdr.de>; Tue, 12 Jul 2022 19:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiGLRzC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Jul 2022 13:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233445AbiGLRzB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Jul 2022 13:55:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A88B8E87
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 10:55:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A82B561A39
        for <linux-iio@vger.kernel.org>; Tue, 12 Jul 2022 17:54:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B093DC341C0;
        Tue, 12 Jul 2022 17:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657648499;
        bh=znDMWftMN6f7cshmQRZsP+yN3VCOIUw2qjhNxMixrvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fnUselSuwCB7RGvEcIfNahttBad1xxw7YipvoEdJbHwbg5IK6sMswKltNrGbkKj+4
         oCRYlTBK27KpVLn7YrX0aBLwTxVC8RF7eurdjFuyTyrq7MMY21npFN79yDhFnSOjFL
         2w1f8pJ7PySEHNA3DgeNFGZsCrc/ZOVJlmuWzQgA=
Date:   Tue, 12 Jul 2022 19:54:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: IIO: Off sick....
Message-ID: <Ys21cP3/9D9stkO7@kroah.com>
References: <20220712163019.00000264@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220712163019.00000264@Huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jul 12, 2022 at 04:30:19PM +0100, Jonathan Cameron wrote:
> Hi all,
> 
> Unfortunately after some travel / workshop I've come down with covid.
> Recovering, but will going to take me a while to catch up with backlog
> of reviews. I should manage to get a pull request out later this week, so
> everything we already have queued up hopefully makes the merge window,
> but may not catch up with everything that needs review for a little while.

Sorry to hear this.  If there's anything I can do to pick up pending
patches, or pull from your current tree, please let me know.

Go get some rest,

greg k-h
