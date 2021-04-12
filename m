Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D35CF35C386
	for <lists+linux-iio@lfdr.de>; Mon, 12 Apr 2021 12:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237420AbhDLKRP (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Apr 2021 06:17:15 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2832 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237607AbhDLKRH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 12 Apr 2021 06:17:07 -0400
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FJkzC68z9z6899b;
        Mon, 12 Apr 2021 18:11:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 12 Apr 2021 12:16:33 +0200
Received: from localhost (10.47.93.73) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Mon, 12 Apr
 2021 11:16:32 +0100
Date:   Mon, 12 Apr 2021 11:15:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Dinghao Liu <dinghao.liu@zju.edu.cn>,
        Kangjie Lu <kjlu@umn.edu>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: light: gp2ap002: Fix rumtime PM imbalance on error
Message-ID: <20210412111506.0000653c@Huawei.com>
In-Reply-To: <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
References: <20210407034927.16882-1-dinghao.liu@zju.edu.cn>
        <20210411160720.037c405c@jic23-huawei>
        <CACRpkdYrRi3pa6Gw4_Q+P=WYbv-a27FHmOupKVv5s=yU53RFWA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.73]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 12 Apr 2021 00:38:41 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Sun, Apr 11, 2021 at 5:07 PM Jonathan Cameron <jic23@kernel.org> wrote:
> > On Wed,  7 Apr 2021 11:49:27 +0800
> > Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> >  
> > > When devm_request_threaded_irq() fails, we should decrease the
> > > runtime PM counter to keep the counter balanced. But when
> > > iio_device_register() fails, we need not to decrease it because
> > > we have already decreased it before.  
> >
> > Whilst agree with your assessment that the code is wrong, I'm not
> > totally sure why we need to do the pm_runtime_get_noresume() in
> > the first place.   Why do we need to hold the reference for
> > the operations going on here?  What can race against this that
> > might care about that reference count?  
> 
> pm_runtime_get_noresume() is increasing the runtime PM
> reference without calling the pm_runtime_resume() callback.
> 
> It is often called in sequence like this:
> 
>     pm_runtime_get_noresume(dev);
>     pm_runtime_set_active(dev);
>     pm_runtime_enable(dev);
> 
> This increases the reference, sets the device as active
> and enables runtime PM.
> 
> The reason that probe() has activated resources such as
> enabling two regulators, and want to leave them on so that
> later on pm_runtime_suspend() will disable them, i.e.
> handover to runtime PM with the device in resumed state.
> 
> I hope this is answering the question, not sure.

There are drivers that look the same except they aren't
holding the reference.  Are those immediately disabling the power?
I can't see the path by which that happens, but perhaps I'm just
missing something?   Maybe this is just paranoid locking in
a probe path (before we are in a position where races can occur)?

An example would be the bmc150_magn driver which does exactly the
same call sequence as this one, but without the reference count increment
and decrement.  Basically I want to know if there is a problem in
those other drivers that is being protected against here!

> 
> Yours,
> Linus Walleij

