Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332EB45FF8E
	for <lists+linux-iio@lfdr.de>; Sat, 27 Nov 2021 16:12:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345484AbhK0PPv convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sat, 27 Nov 2021 10:15:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237073AbhK0PNv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 27 Nov 2021 10:13:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF76C061748;
        Sat, 27 Nov 2021 07:10:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CA99B829F0;
        Sat, 27 Nov 2021 15:10:35 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 98F7AC53FBF;
        Sat, 27 Nov 2021 15:10:30 +0000 (UTC)
Date:   Sat, 27 Nov 2021 15:15:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH 03/15] iio: buffer-dma: Use round_down() instead of
 rounddown()
Message-ID: <20211127151338.35e9d347@jic23-huawei>
In-Reply-To: <J4XY2R.1WOGAOGR6ITU2@crapouillou.net>
References: <20211115141925.60164-1-paul@crapouillou.net>
        <20211115141925.60164-4-paul@crapouillou.net>
        <20211121140823.6b2922f6@jic23-huawei>
        <J4XY2R.1WOGAOGR6ITU2@crapouillou.net>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 22 Nov 2021 10:00:19 +0000
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Le dim., nov. 21 2021 at 14:08:23 +0000, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > On Mon, 15 Nov 2021 14:19:13 +0000
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >   
> >>  We know that the buffer's alignment will always be a power of two;
> >>  therefore, we can use the faster round_down() macro.
> >> 
> >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>  
> > *groan*.  I don't want to know where the naming of these two came 
> > from but that
> > is spectacular...
> > 
> > Anyhow, happy to pick up 1-3 now if you like as all are good cleanup 
> > of
> > existing code.  
> 
> I think you can pick 2-3 now; I will do some changes to patch [01/15] 
> in the V2.

Applied, 2+3 to the togreg branch of iio.git and pushed out as testing for all
the normal reasons.

Thanks,

Jonathan

> 
> Cheers,
> -Paul
> 
> 

