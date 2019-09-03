Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB78AA6A8E
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729015AbfICN46 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 09:56:58 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55530 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727107AbfICN46 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 09:56:58 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 8CE6410D53ECBDCB99A4;
        Tue,  3 Sep 2019 21:56:56 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 21:56:51 +0800
Date:   Tue, 3 Sep 2019 14:56:43 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PULL] Second set of new device support, cleanups etc for IIO
 in the 5.4 cycle.
Message-ID: <20190903145643.00005bd0@huawei.com>
In-Reply-To: <20190903133635.GA8987@kroah.com>
References: <20190827220843.4462651e@archlinux>
        <20190903133635.GA8987@kroah.com>
Organization: Huawei
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 3 Sep 2019 15:36:35 +0200
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Tue, Aug 27, 2019 at 10:08:43PM +0100, Jonathan Cameron wrote:
> > The following changes since commit 81e0da703fdba1ee126868bf8350592c79cdba13:
> > 
> >   staging: sm750fb: fix odd license text (2019-08-15 14:43:57 +0200)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git tags/iio-for-5.4b  
> 
> Looks like commit e77b014217ff ("iio: cros_ec: set calibscale for 3d
> MEMS to unit vector") was not signed-off-by you, yet you committed it :(
> 
> Can you fix this up and add that one other patch to the tree and resend
> the pull request?
> 
> thanks,
> 
> greg k-h

Gah. I clearly made a complete idiot of myself with this set.

Sorry about that, will send an updated pull request this evening.

Thanks,

Jonathan

