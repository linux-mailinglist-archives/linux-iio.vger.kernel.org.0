Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB3D7BBB1A
	for <lists+linux-iio@lfdr.de>; Fri,  6 Oct 2023 17:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232698AbjJFPBr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Oct 2023 11:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232704AbjJFPBp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Oct 2023 11:01:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F241CA
        for <linux-iio@vger.kernel.org>; Fri,  6 Oct 2023 08:01:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB727C433C8;
        Fri,  6 Oct 2023 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696604504;
        bh=mr5FOkQQUAz47JkMV9gdhLLln+n7zpVsZVEm5FGfVuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2gSD08uzYsb12oLBB5XgZhpoMlHE2182lp9cnkvyTv90MTwhV343GjAULg45IDl4Q
         DxOCJQAK1FzVis5CKzq2zDbT8lVe1vVCoTqL+eE/qQiNqQ9F7uWjhCm2pndqzuEcNB
         ROG33v77KwjvAU+e8+ii4A7mH/QrKFcEwTt4Q2O8=
Date:   Fri, 6 Oct 2023 17:01:11 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] 1st set of IIO fixes for 6.6
Message-ID: <2023100604-hungrily-driller-8928@gregkh>
References: <20231005182024.66b68b41@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005182024.66b68b41@jic23-huawei>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 05, 2023 at 06:20:24PM +0100, Jonathan Cameron wrote:
> The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:
> 
>   Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-fixes-for-6.6a

Pulled and pushed out, thanks.

greg k-h
