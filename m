Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3AA94DD931
	for <lists+linux-iio@lfdr.de>; Fri, 18 Mar 2022 12:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiCRLsl (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 18 Mar 2022 07:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232272AbiCRLsk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 18 Mar 2022 07:48:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1E32CD81F
        for <linux-iio@vger.kernel.org>; Fri, 18 Mar 2022 04:47:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 56E61611FA
        for <linux-iio@vger.kernel.org>; Fri, 18 Mar 2022 11:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEEBC340E8;
        Fri, 18 Mar 2022 11:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647604039;
        bh=Ha2qipBfIzREFXTthGdvZpZbPOflIzc/avBGspK+s68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tysBpDe3U1Z/OXYMezPA2uLqHY9gD25C9a6jDAmQe/6LVtkO6SNMJdyKS0UHulws6
         eNpQjhTG1tPsVLAZvoCZm1AF5Tx6UG6PpPFLf7aG+/FHys+iptC5aR+J67xJEhu/Su
         Kdzz6ZxSk5igcsfDfKMKwssn9QZj///nK+MvOgoY=
Date:   Fri, 18 Mar 2022 12:42:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PULL] IIO new device support, features, fixes and cleanups for
 5.18
Message-ID: <YjRwJpLfNEVg5bkt@kroah.com>
References: <20220302135101.353b9470@jic23-huawei>
 <20220302140256.279c7c51@jic23-huawei>
 <20220315121025.00002e93@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315121025.00002e93@Huawei.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 15, 2022 at 12:10:25PM +0000, Jonathan Cameron wrote:
> On Wed, 2 Mar 2022 14:02:56 +0000
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Wed, 2 Mar 2022 13:51:01 +0000
> > Jonathan Cameron <jic23@kernel.org> wrote:
> > 
> > > The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac07:
> > > 
> > >   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
> > > 
> > > are available in the Git repository at:
> > > 
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.18a
> > > 
> > > for you to fetch changes up to 0bf126163c3e7e6d722622073046aed567a5551e:
> > > 
> > >   iio: adc: xilinx-ams: Fix single channel switching sequence (2022-03-02 13:39:08 +0000)
> > > 
> > > ----------------------------------------------------------------  
> > 
> > Hi Greg,
> 
> Hi Greg,
> 
> Just wondering if you have any feedback on this pull request or maybe something
> went wrong somewhere?  Absolutely fine if it's still in your todo pile!

Sorry for the delay.  Now pulled and pushed out, thanks,

greg k-h
