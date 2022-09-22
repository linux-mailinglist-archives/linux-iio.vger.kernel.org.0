Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CC25E5C78
	for <lists+linux-iio@lfdr.de>; Thu, 22 Sep 2022 09:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiIVHbv (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 22 Sep 2022 03:31:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiIVHbu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 22 Sep 2022 03:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37B86733
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 00:31:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D408163422
        for <linux-iio@vger.kernel.org>; Thu, 22 Sep 2022 07:31:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC1E8C433D6;
        Thu, 22 Sep 2022 07:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663831908;
        bh=zhP8ebgdVAD4kAQ6qEbn8YcObr4F06a8YlgzmpIDJ8k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NRuOIwHh3YsfVh2Yulmdi5o/QfcyLnS77CSgfx0xY/XBZlDbVnCWzDhcgqcm0LhBw
         nAkMLtW5i/Tt6z510WLmiUbpnCB47lH8yAS/FPb6GeEuzc4zcen4BCLimuOJMeYxbe
         N9kybqn13pQLEDhIjmP4koFur5VTe10tYfOV4sd4=
Date:   Thu, 22 Sep 2022 09:32:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] counter: First set of Counter fixes for 6.0-rc5
Message-ID: <YywPgWIgkE76z48/@kroah.com>
References: <YyNWADWgfl1sL10S@ishi>
 <YysQ+JUP0u3kge53@kroah.com>
 <YytwQEV+ajrZELTm@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YytwQEV+ajrZELTm@ishi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Sep 21, 2022 at 04:12:48PM -0400, William Breathitt Gray wrote:
> On Wed, Sep 21, 2022 at 03:26:16PM +0200, Greg KH wrote:
> > On Thu, Sep 15, 2022 at 12:42:40PM -0400, William Breathitt Gray wrote:
> > > The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:
> > > 
> > >   Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-fixes-for-6.0a
> > > 
> > > for you to fetch changes up to 8294b04153c33602e9c3dd21ac90c1e99bd0fdaf:
> > > 
> > >   counter: Realign counter_comp comment block to 80 characters (2022-09-11 11:45:02 -0400)
> > > 
> > > ----------------------------------------------------------------
> > > counter: First set of Counter fixes for 6.0-rc5
> > > 
> > > counter
> > >  - Realign counter_comp comment block to 80 characters
> > > 
> > > 104-quad-8
> > >  - Fix skipped IRQ lines during events configuration
> > > 
> > > ----------------------------------------------------------------
> > > William Breathitt Gray (2):
> > >       counter: 104-quad-8: Fix skipped IRQ lines during events configuration
> > >       counter: Realign counter_comp comment block to 80 characters
> > > 
> > >  drivers/counter/104-quad-8.c |  6 +++---
> > >  include/linux/counter.h      | 40 ++++++++++++++++++++--------------------
> > >  2 files changed, 23 insertions(+), 23 deletions(-)
> > 
> > 
> > You signed this pull request, yet I don't see your key in the kernel.org
> > pgp repo, and so I get this error when trying to merge:
> > 
> > # gpg: Signature made Thu 15 Sep 2022 06:40:07 PM CEST
> > # gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE12232B
> > # gpg: Can't check signature: No public key
> > 
> > Did you use the right key, or is it somewhere else?
> > 
> > thanks,
> > 
> > greg k-h
> 
> It's located under pgpkeys/keys/B54856CABE12232B.asc in the kernel.org
> pgp repo: https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/B54856CABE12232B.asc
> 
> I added wbg@kernel.org as a new UID and uploaded it to keys.openpgp.org:
> https://keys.openpgp.org/search?q=8D37CDDDE0D22528F8E89FB6B54856CABE12232B
> 
> Looks like the kernel.org pgp repo hasn't been synchronized yet with the
> updated key from keys.openpgp.org, so I suspect that's why you're
> getting the error right now.

Ok, can you just send me the patch through email for now until things
get propagated properly?

thanks,

greg k-h
