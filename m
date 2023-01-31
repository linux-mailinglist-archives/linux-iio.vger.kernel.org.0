Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79AA682BBF
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 12:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbjAaLqh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 06:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjAaLqg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 06:46:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CB94ED6
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 03:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 657E66147C
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 11:46:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 710C3C433EF;
        Tue, 31 Jan 2023 11:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675165593;
        bh=/Zd7kMjvgFyQOMGBWi1o0ItmAQA6drcu1bKFiqhHRDY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iuSRQNDRl9SrkwqLSbk7ygijZ+MhBSGgu/KO9OEq6E3ouEPX0MeMqyIKa7vrMwMMs
         2AGV3zB9m7ekZ7ftijZj+Rc5FIdQmKPoFRhLVVcG1VXJC/k6pKoh/AbpEzuPU7eqEb
         nak9JuMhuclj3UjMKYtISrVexkj0wSpd1eGaUkeo=
Date:   Tue, 31 Jan 2023 12:46:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9j/lgPB3kzPENvs@kroah.com>
References: <Y9g5MOWkDGZxovjW@ishi>
 <Y9jD5h64XFknwb8/@kroah.com>
 <Y9j4PGeHWnqPGxNG@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9j4PGeHWnqPGxNG@ishi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 06:15:08AM -0500, William Breathitt Gray wrote:
> On Tue, Jan 31, 2023 at 08:31:50AM +0100, Greg KH wrote:
> > On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrote:
> > > The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> > > 
> > >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.2a
> > > 
> > > for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:
> > > 
> > >   counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (2023-01-18 09:59:58 -0500)
> > > 
> > > ----------------------------------------------------------------
> > > First set of Counter updates for the 6.2 cycle
> > 
> > You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
> > can tell.
> > 
> > > This set of updates consists only of Kconfig cleanup and changes for the
> > > Counter subsystem. In particular, the Kconfig entries are reorganized to
> > > to alphabetical order, and dependencies added to restrict building
> > > certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
> > > systems that support them.
> > > 
> > > Changes
> > > * counter
> > >   - Sort the Kconfig entries alphabetically
> > 
> > This isn't needed for 6.2-final at all from waht I can tell.
> > 
> > thanks,
> > 
> > greg k-h
> 
> Oops I mistyped the version in the description; yes these are for the
> 6.3 merge. Would you like me to retag and resend?

Please do.  Also, I can't verify your signature:
	# gpg: Signature made Mon 30 Jan 2023 10:27:41 PM CET
	# gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE12232B
	# gpg: Can't check signature: No public key

Is it in the kernel.org keyring?

thanks,

greg k-h
