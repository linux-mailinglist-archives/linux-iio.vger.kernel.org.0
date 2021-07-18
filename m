Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED68A3CC9A0
	for <lists+linux-iio@lfdr.de>; Sun, 18 Jul 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbhGROno convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Sun, 18 Jul 2021 10:43:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:52194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233970AbhGROnf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Jul 2021 10:43:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A5E561184;
        Sun, 18 Jul 2021 14:40:34 +0000 (UTC)
Date:   Sun, 18 Jul 2021 15:42:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add "extended_name" to label
Message-ID: <20210718154259.1aaf69a2@jic23-huawei>
In-Reply-To: <AIOQVQ.VCBVMZQG56T83@crapouillou.net>
References: <20210618123005.49867-1-paul@crapouillou.net>
        <20210704183425.34df79ef@jic23-huawei>
        <AIOQVQ.VCBVMZQG56T83@crapouillou.net>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 04 Jul 2021 22:18:10 +0100
Paul Cercueil <paul@crapouillou.net> wrote:

> Hi Jonathan,
> 
> Le dim., juil. 4 2021 at 18:34:25 +0100, Jonathan Cameron 
> <jic23@kernel.org> a écrit :
> > On Fri, 18 Jun 2021 13:30:03 +0100
> > Paul Cercueil <paul@crapouillou.net> wrote:
> >   
> >>  Hi Jonathan,
> >> 
> >>  This is the v3 of my patchset that sets the label attribute to the
> >>  "extended_name".
> >> 
> >>  v3 only refactors the code of patch [2/2] to make it look a bit 
> >> better.  
> > 
> > Hi Paul,
> > 
> > Just thought I'd let you know v3 looks great to me.  Timing meant I 
> > didn't
> > manage to get it into last cycle, and am now waiting for rc1 to give 
> > a nice
> > place to rebase my trees on.  Hence I'll pick this up in a week or 
> > two.  
> 
> That's perfectly fine, I wasn't expecting it to land before rc1.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it before I push it out in a fashion that makes tidying
any issues up messy.

Thanks,

Jonathan

> 
> Cheers,
> -Paul
> 
> 

