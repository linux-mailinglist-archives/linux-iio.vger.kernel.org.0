Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7D3D4D5738
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 02:13:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345285AbiCKBO1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 20:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345274AbiCKBO0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 20:14:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C9A105296
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 17:13:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC0061E23
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 01:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589E3C340EB;
        Fri, 11 Mar 2022 01:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646961203;
        bh=oyA/JIR/b20LqswgHfG5ImyAc2WneuvcP7Op2HzoT50=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oF5CTmXiUgjP5d8mQR4PjtHXAvPd2GJ0bjs44gh9KMJkS3cghnxtiXOZiDeJ8INYI
         JB0JNkJRzacYyxbq0FwUR1nHnArZIWhy9Ky5xMdhm5YlojWSHJzRx3HTBFZYR6ohR6
         zOO3DcwCH5FuIAARy9+oxGVtHSREBS/LsfjA/h2Y=
Date:   Fri, 11 Mar 2022 02:13:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-iio@vger.kernel.org
Subject: Re: [PULL] Counter updates, cleanups, and features for 5.18
Message-ID: <YiqiMIA6Mx0EjOXn@kroah.com>
References: <YiItE3YONnTILC9Q@ishi>
 <YipxpdPZEK2wpeoc@kroah.com>
 <YiqQS2pAKIfYeUIK@ishi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiqQS2pAKIfYeUIK@ishi>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Mar 10, 2022 at 06:56:59PM -0500, William Breathitt Gray wrote:
> On Thu, Mar 10, 2022 at 10:46:13PM +0100, Greg KH wrote:
> > On Fri, Mar 04, 2022 at 10:15:31AM -0500, William Breathitt Gray wrote:
> > > The following changes since commit 7e57714cd0ad2d5bb90e50b5096a0e671dec1ef3:
> > > 
> > >   Linux 5.17-rc6 (2022-02-27 14:36:33 -0800)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://gitlab.com/vilhelmgray/counter.git tags/counter-for-5.18a
> > 
> > I don't have a gpg key for you, and I really don't trust any
> > non-kernel.org git infrastructure at the moment.  Any chance you can get
> > a kernel.org account?
> 
> Sure, how would I apply for a kernel.org account?

https://korg.docs.kernel.org/accounts.html

