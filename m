Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF4F91A4593
	for <lists+linux-iio@lfdr.de>; Fri, 10 Apr 2020 13:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbgDJLWj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 10 Apr 2020 07:22:39 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:38793 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJLWj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 10 Apr 2020 07:22:39 -0400
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 5B594240010;
        Fri, 10 Apr 2020 11:22:36 +0000 (UTC)
Date:   Fri, 10 Apr 2020 13:22:36 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Aishwarya R <aishwaryarj100@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: adc: at91-adc: Use devm_platform_ioremap_resource
Message-ID: <20200410112236.GX3628@piout.net>
References: <20200409151125.32677-1-aishwaryarj100@gmail.com>
 <20200409155936.GV3628@piout.net>
 <CAHp75VcLLjjc5T+Qq8du4QgnQ-rtzFLh=5Jt-DPjigb+QUWOSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcLLjjc5T+Qq8du4QgnQ-rtzFLh=5Jt-DPjigb+QUWOSg@mail.gmail.com>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 10/04/2020 13:55:26+0300, Andy Shevchenko wrote:
> On Thu, Apr 9, 2020 at 7:00 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> > On 09/04/2020 20:41:23+0530, Aishwarya R wrote:
> > > Use the helper function that wraps the calls to
> > > platform_get_resource() and devm_ioremap_resource()
> > > together.
> 
> > Please elaborate the actual value of doing that.
> 
> Please, elaborate actual value of not doing that.
> 
> Yes, I know that you are p* off of these changes, but why you not
> going further and forbid all clean ups we are doing in the code?
> 
> To the point. Above change is reducing code base and showing the new
> comers modern APIs to use.
> 

The value of doing it is to reduce the code size by 16 bytes. The same
people doing that will actively ruin that by adding error string for
error that will never ever happen.

Also, the commit message is definitively lacking. A good commit message
would say that the patch has been generated using coccinelle, that no
testing has been done and that no thought has been given.

It would definitively make sense to send one patch per subsystem instead
of having 475 different patches each changing only one location.

The whole "let's let newcomers fix trivial bugs" thing is definitively
not working and it is not leading to an increase of the number of useful
reviewers and contributors

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
