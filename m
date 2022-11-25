Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53F1E638F39
	for <lists+linux-iio@lfdr.de>; Fri, 25 Nov 2022 18:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbiKYRhq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Nov 2022 12:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiKYRhp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2022 12:37:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D44A9186DB
        for <linux-iio@vger.kernel.org>; Fri, 25 Nov 2022 09:37:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D1836259C
        for <linux-iio@vger.kernel.org>; Fri, 25 Nov 2022 17:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83D23C433C1;
        Fri, 25 Nov 2022 17:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669397863;
        bh=mgtZmagx2/a/jC1ExNuhETC5tM2MHDAqhx1jWXG/+0c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GmtOg5xcx3RvZWY592vJuUluZ+cwibeNgV8gKcoSkuborJkDlkPMOGNlRGgVCn0eU
         nlORcJRCNrgX6xkh7jFX+i+1mi476LJgGTOngYBfmrRNjagqTgG4ykgVez48mD4Ee7
         Da02mZFs/JwDatlWSC29Vm6aqUVPnvG1KHi0gW6E=
Date:   Fri, 25 Nov 2022 18:36:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL V2] IIO: First set of new device support, features and
 cleanup  for 6.2
Message-ID: <Y4D9Dr7DF1zPfRWF@kroah.com>
References: <20221123200802.2ef37104@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123200802.2ef37104@jic23-huawei>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 23, 2022 at 08:08:02PM +0000, Jonathan Cameron wrote:
> The following changes since commit 30a0b95b1335e12efef89dd78518ed3e4a71a763:
> 
>   Linux 6.1-rc3 (2022-10-30 15:19:28 -0700)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-6.2a-take2
> 

That worked, thanks for fixing it up.  pulled and pushed out now.

greg k-h
