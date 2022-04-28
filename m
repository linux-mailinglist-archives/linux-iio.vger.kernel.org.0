Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53702513714
	for <lists+linux-iio@lfdr.de>; Thu, 28 Apr 2022 16:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348511AbiD1Ol6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Apr 2022 10:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345616AbiD1Ol5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Apr 2022 10:41:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1A1515BF
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 07:38:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 423B561E63
        for <linux-iio@vger.kernel.org>; Thu, 28 Apr 2022 14:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4C6C385A9;
        Thu, 28 Apr 2022 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651156719;
        bh=SNFj16B2i13xHLFMk2BBmzV4xdVrE3i2kWYMQwzWG3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XDALSjA9LN8/IYZhpzpv7KrJLXOIncd6x50NgUx1gMukumEM+/qWxMxnPFiOOky6Q
         Egwl6gFchiiQvVPErZ0nlEQYrFz+snDyt5HMG8rs9fvPUu1rhoCUJTtPhvpfVk3GFG
         4+x2HGvY5Bn+Nls//t7Nhj36c0M5JWELuV7IZH1c=
Date:   Thu, 28 Apr 2022 16:37:59 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 5.18
Message-ID: <Ymqmx1CrtDsV33HG@kroah.com>
References: <20220427193153.69d3237b@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427193153.69d3237b@jic23-huawei>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Apr 27, 2022 at 07:31:53PM +0100, Jonathan Cameron wrote:
> The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:
> 
>   Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-5.18a

Pulled and pushed out, thanks.

greg k-h
