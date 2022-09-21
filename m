Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC625BFFA6
	for <lists+linux-iio@lfdr.de>; Wed, 21 Sep 2022 16:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiIUOLj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 21 Sep 2022 10:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiIUOLj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Sep 2022 10:11:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782148B2C5
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 07:11:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11C65B82F78
        for <linux-iio@vger.kernel.org>; Wed, 21 Sep 2022 14:11:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEBBC433C1;
        Wed, 21 Sep 2022 14:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663769495;
        bh=jJjNpwGH534LoMKcGAPZVUvyimpk5DZbppJrS+usS4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S9cDwAiCTTd/WHqEQ4XD4lY3Z3GbhES/kNDJkcnPNrCece83ODCVr5mHKKSH6iR4m
         HXAjWrW6sBKYWCWu6cCzNErcY+NyE+6au6qnM2zCRlGQgMdqlHQTcTMzpaHTiFoSXx
         KboV9CsQlMH8XGT1w9+G68SHrae82D9MWs+bXMrc=
Date:   Wed, 21 Sep 2022 16:09:21 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 1st set of new device support, cleanup and features
 for the 6.1 cycle.
Message-ID: <YysbEQfPvZ0BOMz0@kroah.com>
References: <20220917140311.733566ae@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220917140311.733566ae@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 17, 2022 at 02:03:11PM +0100, Jonathan Cameron wrote:
> The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> 
>   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.1a

Pulled and pushed out, thanks.

greg k-h
