Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC6A682C1B
	for <lists+linux-iio@lfdr.de>; Tue, 31 Jan 2023 13:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjAaMC0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 31 Jan 2023 07:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjAaMCZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 31 Jan 2023 07:02:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187234C6EA
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 04:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCE70B81BF9
        for <linux-iio@vger.kernel.org>; Tue, 31 Jan 2023 12:02:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DD4C433D2;
        Tue, 31 Jan 2023 12:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675166541;
        bh=5FMvraAE4z359dIAC9xB4TITi34uJ4xDIOc2SPnkylY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rQYNFD3MurbmsJMAW2r1lkXkkJjHzdcC+YhFt3aYT6OMGyIIDcCSm9AU+Di/55BhA
         P617k0lbG5/Wx3weWJQqB0CRyelo9IRepIspd10QLT5hsE+06tSXiwa44qgx2ZNZkT
         D/p/aYH/dj36t4jjwGdepMEwsxmCLACiJt5SwPtM=
Date:   Tue, 31 Jan 2023 13:02:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <wbg@kernel.org>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] First set of Counter updates for the 6.2 cycle
Message-ID: <Y9kDSvCWNLoyIQKO@kroah.com>
References: <Y9g5MOWkDGZxovjW@ishi>
 <Y9jD5h64XFknwb8/@kroah.com>
 <Y9j4PGeHWnqPGxNG@ishi>
 <Y9j/lgPB3kzPENvs@kroah.com>
 <Y9kCIK2bkha/JYJS@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9kCIK2bkha/JYJS@ishi>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jan 31, 2023 at 06:57:20AM -0500, William Breathitt Gray wrote:
> On Tue, Jan 31, 2023 at 12:46:30PM +0100, Greg KH wrote:
> > On Tue, Jan 31, 2023 at 06:15:08AM -0500, William Breathitt Gray wrote:
> > > On Tue, Jan 31, 2023 at 08:31:50AM +0100, Greg KH wrote:
> > > > On Mon, Jan 30, 2023 at 04:40:00PM -0500, William Breathitt Gray wrote:
> > > > > The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:
> > > > > 
> > > > >   Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)
> > > > > 
> > > > > are available in the Git repository at:
> > > > > 
> > > > >   git://git.kernel.org/pub/scm/linux/kernel/git/wbg/counter.git tags/counter-updates-for-6.2a
> > > > > 
> > > > > for you to fetch changes up to 01f714ee022ecb2667ca8ba909138b1af4cfff2c:
> > > > > 
> > > > >   counter: fix dependency references for config MICROCHIP_TCB_CAPTURE (2023-01-18 09:59:58 -0500)
> > > > > 
> > > > > ----------------------------------------------------------------
> > > > > First set of Counter updates for the 6.2 cycle
> > > > 
> > > > You mean 6.3, right?  These aren't bugfixes for 6.2-final from what I
> > > > can tell.
> > > > 
> > > > > This set of updates consists only of Kconfig cleanup and changes for the
> > > > > Counter subsystem. In particular, the Kconfig entries are reorganized to
> > > > > to alphabetical order, and dependencies added to restrict building
> > > > > certain drivers (intel-qep, ftm-quaddec, and microchip-tcp-capture) to
> > > > > systems that support them.
> > > > > 
> > > > > Changes
> > > > > * counter
> > > > >   - Sort the Kconfig entries alphabetically
> > > > 
> > > > This isn't needed for 6.2-final at all from waht I can tell.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > Oops I mistyped the version in the description; yes these are for the
> > > 6.3 merge. Would you like me to retag and resend?
> > 
> > Please do.  Also, I can't verify your signature:
> > 	# gpg: Signature made Mon 30 Jan 2023 10:27:41 PM CET
> > 	# gpg:                using EDDSA key 8D37CDDDE0D22528F8E89FB6B54856CABE12232B
> > 	# gpg: Can't check signature: No public key
> > 
> > Is it in the kernel.org keyring?
> > 
> > thanks,
> > 
> > greg k-h
> 
> I'm not quite sure why it's returning an error for you, but here's the
> key (8D37CDDDE0D22528F8E89FB6B54856CABE12232B) in kernel.org pgpkeys
> tree:
> https://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git/tree/keys/B54856CABE12232B.asc
> 
> Does that work for you?

Yes, sorry for the noise, I hadn't updated from the key repo in a while
on this machine.  It's all good now.

greg k-h
