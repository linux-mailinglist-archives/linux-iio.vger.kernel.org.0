Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9F5E915A
	for <lists+linux-iio@lfdr.de>; Sun, 25 Sep 2022 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbiIYHPB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Sep 2022 03:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbiIYHPA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Sep 2022 03:15:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5772E1E727
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 00:14:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E88CC6122A
        for <linux-iio@vger.kernel.org>; Sun, 25 Sep 2022 07:14:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD6DC433C1;
        Sun, 25 Sep 2022 07:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664090098;
        bh=LoOWqmbp1IKbgHtWjZGCDFh9gAmFoN8OHdSUYUwDRxI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NTjGQBxOuBuBsSZcQFTHtM/XJsB3Peh/TYYwMJiq67PItNL/441yVPLfHWlUqPZYk
         53vWW/CR5yF0s1MYDCjfzti9i6YEhNFHlawLp/LfUL8NPrcKASnv63XfEaX7tSkeFG
         bki0o+U3weG6raj++xDgNpap0Q4Wjf6Yw6xHxyjE=
Date:   Sun, 25 Sep 2022 09:10:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO: 2nd set of new device support, cleanup and features
 for the 6.1 cycle.
Message-ID: <Yy/+/VBevPN28KyO@kroah.com>
References: <20220924151432.312f5240@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220924151432.312f5240@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Sep 24, 2022 at 03:14:32PM +0100, Jonathan Cameron wrote:
> The following changes since commit 8be7dfc6a8eb54589100d4ea15b0039c2d01422b:
> 
>   Merge tag 'coresight-next-v6.1' of git://git.kernel.org/pub/scm/linux/kernel/git/coresight/linux into char-misc-next (2022-09-21 16:16:03 +0200)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.1b

Pulled and pushed out, thanks.

greg k-h
