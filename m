Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E765A69BB2D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 18:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjBRRLx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBRRLw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 12:11:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 029261716C
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 09:11:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ABA9AB80860
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 17:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B436C4339B;
        Sat, 18 Feb 2023 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676740309;
        bh=r86RsONMhiDNVTyz87MmlaybdkQwDr3qh1bkpwtoa6I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fuZwn8Ug75FKy2mVcLwwneaURqpB/5+jXT3zKkYRWVpDlh5qqG8qxRMKdSA9hshIx
         I9jPXnNJWgHgjwCSk2aYhAUaLbKiCouwysSLHV+ORP7QV53r5sUP1QL0J73MR1fQGz
         iEclOHrR/YPJWMpwg2WmoibBD3MWz/62WOOxFmrF5k5+pbwWD8clzvCGqZL2j/yJj5
         ctlpRdU0uYo3JheT01uKzVo13sPp9ZFWnsRF1i+Yok3i1P3Y7zO6YBF+C6PQkwHLKY
         Z11eaTEFcNwCWoK15sPcjrIKSfMImqv8NQKdeZaJQG0A1N00de4CIbsloB/9LVM+Z2
         VnehhriNHJuaw==
Date:   Sat, 18 Feb 2023 17:26:09 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mehdi Djait <mehdi.djait.k@gmail.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/1] iio: accel: kionix-kx022a: Timestamp minor fix
Message-ID: <20230218172609.4c613cc5@jic23-huawei>
In-Reply-To: <Y/DTfoFMkPQeZODL@carbian>
References: <cover.1676661174.git.mehdi.djait.k@gmail.com>
        <44a866e5-61ae-3373-10f5-c21efeec7f53@gmail.com>
        <Y/DTfoFMkPQeZODL@carbian>
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

On Sat, 18 Feb 2023 14:32:46 +0100
Mehdi Djait <mehdi.djait.k@gmail.com> wrote:

> Hi Matti,
> 
> On Fri, Feb 17, 2023 at 10:04:30PM +0200, Matti Vaittinen wrote:
> > Thanks again Mehdi. It's great to have this fixed :)
> > 
> > On 2/17/23 21:19, Mehdi Djait wrote:  
> > > As discussed in [1] here is a patch to get the timestamp in the
> > > trigger handler from the driver's private data
> > > 
> > > [1] https://lore.kernel.org/linux-iio/Y+%2FLpcc0Wa2VGsGO@carbian/T/#mec923c14d1324ffabfa88dde225eeb227005b48f
> > >   
> > 
> > By the way, I don't think a cover-letter is required for single patches. You
> > can usually put the relevant information in the commit message.
> > Additionally, if there is some questions, suggestions or other relevant bits
> > you wish to say - but don't want to include in commit logs - you can usually
> > place them in the patch mail directly after the first
> > "---"
> > 
> > Eg:
> > 
> > <commit message>
> > <Signed-off-by and other tags>
> > 
> > ---
> > 
> > Here we can add a note / request if required.
> >   
> 
> Yes, that's why I sent a cover-letter, I wanted to include relevant bits
> but not in the commit message (a reference to the discussion). 
> 
> I should have sent the patch --in-reply-to the thread with the discussion 
> anyway. 

Don't do that.  Use a Link tag to the discussion instead.
Otherwise the patch series can get buried and lost.


> 
> Thank you for the help :) 
> 
> --
> Kind Regards
> Mehdi Djait

