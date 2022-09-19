Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7B695BD137
	for <lists+linux-iio@lfdr.de>; Mon, 19 Sep 2022 17:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbiISPlD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 19 Sep 2022 11:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiISPlB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 19 Sep 2022 11:41:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E380433340
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 08:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F10B61765
        for <linux-iio@vger.kernel.org>; Mon, 19 Sep 2022 15:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC07C433D7;
        Mon, 19 Sep 2022 15:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663602059;
        bh=kKazNoAuaXAO/5n9CiTx2lZ+FkEBJF+OGXcPwq2ojY0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HyUt1X9t2jiy8WIkkhONfbzxBK5plcPKTaKpdW/9oVawYz/kMIWF3B7EMBvLRFyRX
         Xi1lX5VDvQ6afxjCE35zyc+MMLE+YpA7nRJHRyYG/Sv4oGYiSdrMVdXmmJ6pFvDVJE
         W0yfTXRQoZlrKMbIQJVBdckVnesKRef2UXvrj9PoVOZ8bsq5XTwaZsIzSwHBBNIRgt
         kIqRS3D7L8GEZuiQqB5cUT9+oMqFgzcAwXUqsgP/kbKPNIc5t3EMS7azQAVa58TzhV
         pVRF4foifoPEwSwcO+Bi9l9JRGxqgwmvG2uvdIQcVYiGVBFlKJT0ul7w23xi80cZT5
         uC8m5lSfzXmqg==
Date:   Mon, 19 Sep 2022 16:41:04 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>, linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH] iio: accel: bma400: Fix smatch warning based on use of
 unintialized value.
Message-ID: <20220919164104.46dc5f1a@jic23-huawei>
In-Reply-To: <YygH7FZ23HioBZGH@kadam>
References: <20220917131401.2815486-1-jic23@kernel.org>
        <CAM+2Eu+YCtCMKoWS9yJToEV__YB=enh=54b5thO+q4wGE80wZA@mail.gmail.com>
        <20220918184503.0db7e82a@jic23-huawei>
        <YygH7FZ23HioBZGH@kadam>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 19 Sep 2022 09:10:52 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> On Sun, Sep 18, 2022 at 06:45:03PM +0100, Jonathan Cameron wrote:
> > On Sun, 18 Sep 2022 20:05:48 +0530
> > Jagath Jog J <jagathjog1996@gmail.com> wrote:
> >   
> > > Hi Jonathan,
> > > 
> > > Thank you for sending this patch.
> > > If you need a tag for this fix.
> > > 
> > > Fixes: 961db2da159d ("iio: accel: bma400: Add support for single and
> > > double tap events")  
> > Good point. I'm careful about fixes tags to stuff still not upstream
> > because they tend to be a little unstable. This should be fine.
> > I'll see if it's valid when I rebase the tree (hopefully in a few days
> > time).  
> 
> If you forget to update the tags after a rebase then Stephen Rothwell
> will let you know.  It's best to not make Stephen's job more difficult,
> but it's some comfort to know that mistakes will get caught.
> 
> regards,
> dan carpenter
> 
Hi Dan,

Having messed this up and caused Stephen pointless work several times I now
have scripting (thanks to Greg KH's scripts and some local modes to make
sure the tag is in the upstream of the fix) to check this but some how
I still mess it up from time to time :(

Jonathan

