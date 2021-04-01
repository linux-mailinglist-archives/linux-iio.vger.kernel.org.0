Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DFFE3513A6
	for <lists+linux-iio@lfdr.de>; Thu,  1 Apr 2021 12:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233650AbhDAKbs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 1 Apr 2021 06:31:48 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2756 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233834AbhDAKbj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 1 Apr 2021 06:31:39 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4F9znv0bmMz685Dg;
        Thu,  1 Apr 2021 18:24:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Thu, 1 Apr 2021 12:31:37 +0200
Received: from localhost (10.47.80.95) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 1 Apr 2021
 11:31:36 +0100
Date:   Thu, 1 Apr 2021 11:30:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: bcm_iproc_adc: Use %s and __func__
Message-ID: <20210401113015.00006b70@Huawei.com>
In-Reply-To: <CAHp75VfgL0KW0fetgE3NuBb4itMK1oY+yLmr1xDYkn390hCscg@mail.gmail.com>
References: <20210401062517.28832-1-dmugil2000@gmail.com>
        <CAHp75VfgL0KW0fetgE3NuBb4itMK1oY+yLmr1xDYkn390hCscg@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.95]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 1 Apr 2021 12:24:50 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Apr 1, 2021 at 9:27 AM Mugilraj Dhavachelvan
> <dmugil2000@gmail.com> wrote:
> >
> > Change function's name to %s and __func__ to fix checkpatch.pl errors.  
> 
> No, just drop the __func__ completely. First of all, we have a device
> name, and uniqueness of the messages in the driver should guarantee
> easy findings. Second, specific to _dbg() variants, with enabled
> Dynamic Debug it can be chosen at run time!
> 
> I recommend going through all drivers and drop __func__ near to
> dev_dbg() and pr_debug().
> 

Agreed.  Though beware that some maintainers will count this
as noise and get grumpy.

I'm fine with such patches for IIO.

Jonathan
