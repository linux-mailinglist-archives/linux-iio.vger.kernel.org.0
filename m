Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D81B2CF1A2
	for <lists+linux-iio@lfdr.de>; Fri,  4 Dec 2020 17:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgLDQM4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 4 Dec 2020 11:12:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2210 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726102AbgLDQM4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 4 Dec 2020 11:12:56 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cnd2N2b1kz67LH4;
        Sat,  5 Dec 2020 00:09:48 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 4 Dec 2020 17:12:14 +0100
Received: from localhost (10.47.77.242) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 4 Dec 2020
 16:12:13 +0000
Date:   Fri, 4 Dec 2020 16:11:51 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [PULL V2] 2nd set of IIO new device support, cleanups and yaml
 conversions for the 5.11 cycle
Message-ID: <20201204161151.0000030d@Huawei.com>
In-Reply-To: <CACRpkdbAy2ULtko65JsSbTMdgfL-i0GzCSaffSTPeF_YWr+HDw@mail.gmail.com>
References: <20201203194612.3f35eda5@archlinux>
        <CACRpkdbAy2ULtko65JsSbTMdgfL-i0GzCSaffSTPeF_YWr+HDw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.77.242]
X-ClientProxiedBy: lhreml741-chm.china.huawei.com (10.201.108.191) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 4 Dec 2020 13:54:00 +0100
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Thu, Dec 3, 2020 at 8:47 PM Jonathan Cameron <jic23@kernel.org> wrote:
> 
> >       dt-bindings:iio:st,st-sensors: txt to yaml conversion.  
> 
> Somehow I managed to totally miss that you made this conversion
> and did my own conversion in parallel and sent out yesterday.
> 
> Oh well such things happen.
> 
> Shall I make an incremental patch or something? I think I could
> just copy my binding on top, the diff may be a bit big.

Hmm. You did a much more thorough job than me so definitely good to
get the tighter constraints.  I guess it will be a question of hand
tweaking your patch to keep the few blocks don't need updates the same.

Bad luck on timing on that one!

Jonathan


> 
> Yours,
> Linus Walleij

