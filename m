Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA9237FB4C
	for <lists+linux-iio@lfdr.de>; Thu, 13 May 2021 18:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235057AbhEMQOh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 13 May 2021 12:14:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:53910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234993AbhEMQOb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 May 2021 12:14:31 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3EC6142E;
        Thu, 13 May 2021 16:13:18 +0000 (UTC)
Date:   Thu, 13 May 2021 17:14:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Cc:     Stephan Gerhold <stephan@gerhold.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Yang <decatf@gmail.com>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 0/3] iio: accel: kxcjk-1013: Add support for KX023-1025
Message-ID: <20210513171426.27dd6533@jic23-huawei>
In-Reply-To: <20210511145051.GC4413@qmqm.qmqm.pl>
References: <20210511095409.9290-1-stephan@gerhold.net>
        <20210511142847.GA4413@qmqm.qmqm.pl>
        <YJqWzgmxVEvfElZj@gerhold.net>
        <20210511145051.GC4413@qmqm.qmqm.pl>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 11 May 2021 16:50:51 +0200
Michał Mirosław <mirq-linux@rere.qmqm.pl> wrote:

> On Tue, May 11, 2021 at 04:38:06PM +0200, Stephan Gerhold wrote:
> > Hi Michał,
> > 
> > On Tue, May 11, 2021 at 04:28:47PM +0200, Michał Mirosław wrote:  
> > > On Tue, May 11, 2021 at 11:54:06AM +0200, Stephan Gerhold wrote:  
> > > > KX023-1025 [1] is another accelerometer from Kionix that has lots
> > > > of additional functionality compared to KXCJK-1013. It combines the
> > > > motion interrupt functionality from KXCJK with the tap detection
> > > > from KXTF9, plus a lot more other functionality.  
> > > When I researched KXTF9 support it occurred to me that the -10xx part is
> > > duplicating the information in 'KXyyy' - it seems to be a project number
> > > or something. I would suggest to use just 'kx023' prefix for the code
> > > and DT but leave the full identification in the comments/description.  
> > There do seem to be two different KXTF9 from Kionix, a KXTF9-4100 [1]
> > and a KXTF9-2050 [2] with separate datasheets. Have you checked if there
> > is a meaningful difference between them?  
> 
> I haven't compared them thoroughly, but the versions seem to differ only
> in power consumption (maybe a different manufacturing process?). The
> register sets seem the same.

Differ in expected Vdd supply voltage. 3.3 vs 1.8V .  Looks like this has
knock on effects on things like self test values.  So I'd argue it's worth keeping
the distinction for device tree. 

We could do a double compatible

compatible = kionix,kx023-1024, konix,kx023;

but may be too late to do that now.

Jonathan


> 
> Best Regards
> Michał Mirosław

