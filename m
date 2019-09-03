Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41AE1A68AC
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2019 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727667AbfICMhX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 3 Sep 2019 08:37:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:6190 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728994AbfICMhW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 3 Sep 2019 08:37:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1A98DAE6AA0E08BB86B1;
        Tue,  3 Sep 2019 20:37:20 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Sep 2019
 20:37:18 +0800
Date:   Tue, 3 Sep 2019 13:37:08 +0100
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Martin Kepplinger <martink@posteo.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        <lorenzo.bianconi@redhat.com>, <linux-iio@vger.kernel.org>,
        <gregkh@linuxfoundation.org>
Subject: Re: [BUG] Re: [PATCH] iio: imu: st_lsm6dsx: remove invalid gain
 value for LSM9DS1
Message-ID: <20190903133708.00002f22@huawei.com>
In-Reply-To: <d9fc24f9-192c-b5c5-5883-cde5ecfb1a11@posteo.de>
References: <f2be2f0e064bc7785f9d8f7f6a8598c325b39a45.1566894261.git.lorenzo@kernel.org>
        <20190827210857.718d7f9b@archlinux>
        <37cb0888-50b6-40d2-1289-a78499a90b7c@puri.sm>
        <20190829083714.GA2880@localhost.localdomain>
        <f34694f0-ea7c-0327-532d-7a2904952771@puri.sm>
        <20190830072354.GA5910@localhost.localdomain>
        <531903f2-a4df-87a8-6417-68463261b859@puri.sm>
        <20190831093224.GA5393@lore-desk-wlan.lan>
        <20190901155023.249271e1@archlinux>
        <d9fc24f9-192c-b5c5-5883-cde5ecfb1a11@posteo.de>
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

On Tue, 3 Sep 2019 07:22:20 +0200
Martin Kepplinger <martink@posteo.de> wrote:

> On 01.09.19 16:50, Jonathan Cameron wrote:
> 
> [...]
> 
> > 
> > Rather than messing around with a pull request that has already gone
> > to Greg, I'm going to leave this as it is for now.
> > 
> > The trace doesn't make a lot of sense to me and whilst a bit messy (as fixed
> > up by Lorenzo's follow up) I can't see why things would crash.
> > 
> > So needs debugging and that isn't a problem given we are only looking
> > at putting this support into rc1.  Not ideal, but there is time
> > to work out what is wrong and fix it up!
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> for the record, I found the problem I've had here. It's been introduced
> with the DEV_NAME change and I sent a fix (and question):
> 
> https://lore.kernel.org/linux-iio/20190903051802.22716-1-martin.kepplinger@puri.sm/T/#u
> 

Doh. This one is entirely my fault as I messed up that last minute edit :(

Greg, this bug is in my outstanding pull request. If you would prefer to
pick it from lore and add my Acked-by that's great.
If not I can send this after rc1. 

Thanks,

Jonathan

