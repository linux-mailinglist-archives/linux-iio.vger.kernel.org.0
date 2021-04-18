Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D85363482
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhDRJsg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 05:48:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:46634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhDRJsf (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 05:48:35 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D248261245;
        Sun, 18 Apr 2021 09:48:04 +0000 (UTC)
Date:   Sun, 18 Apr 2021 10:48:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Puranjay Mohan <puranjay12@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH v4 2/2] iio: temperature: add driver support for ti
 tmp117
Message-ID: <20210418104835.3ac0e311@jic23-huawei>
In-Reply-To: <CAHp75VfN5J747w6o=A2eng+9SV_2L-NH28O=sGRuxGz_oxPh-Q@mail.gmail.com>
References: <20210407182147.77221-1-puranjay12@gmail.com>
        <20210407182147.77221-3-puranjay12@gmail.com>
        <20210411155420.318e866e@jic23-huawei>
        <CAHp75VcQYLRJ-p4CWJyk3h0=nL=TqwEFAxkO+z1Nbg8=3Fchyg@mail.gmail.com>
        <CAHp75VfN5J747w6o=A2eng+9SV_2L-NH28O=sGRuxGz_oxPh-Q@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 11 Apr 2021 21:08:29 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Apr 11, 2021 at 9:07 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Apr 11, 2021 at 5:53 PM Jonathan Cameron <jic23@kernel.org> wrote:  
> > > On Wed,  7 Apr 2021 23:51:47 +0530
> > > Puranjay Mohan <puranjay12@gmail.com> wrote:  
> 
> > Good point, but better is to use clamp_t(s16, ...) rather than explicit casting.  
> 
> Sorry, I meant clamp_t(int, ...) of course, otherwise it will give wrong values.
I've switched it over to this which is indeed nicer.

Jonathan

> 
> > I always consider explicit casting in C (and esp. in Linux kernel) is
> > a red flag. Should be really rarely needed.  
> 
> 
> 

