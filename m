Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49E7E2C7954
	for <lists+linux-iio@lfdr.de>; Sun, 29 Nov 2020 14:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727406AbgK2NP0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Nov 2020 08:15:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:56684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727357AbgK2NPZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 29 Nov 2020 08:15:25 -0500
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C8E220705;
        Sun, 29 Nov 2020 13:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606655685;
        bh=sOoA8YkbNkg0C0Iuz84qo4YIsS/CkyxHwr4KwyX7M88=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uG6O4DFCutNnmNU1npJrRkXraImVLRMOEP36eRapQmFQBf+rU+FzxwNZnP3fY9gX/
         CpYX3KIDOjDtTeezwHaObL78sZZ9NXbqgiHiZgqYKp4aFLLcQCT7+W8v6kB982w7iQ
         ueuLGsQQpAqe7FA09hdM4fGAUKWu+HHfTdbw2Dhk=
Date:   Sun, 29 Nov 2020 13:14:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org,
        Anand Ashok Dumbre <anand.ashok.dumbre@xilinx.com>
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
Message-ID: <20201129131441.3e9d83f8@archlinux>
In-Reply-To: <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
References: <20200922134624.13191-1-lars@metafoo.de>
        <20200922134624.13191-2-lars@metafoo.de>
        <20200923214728.6e0c07b0@archlinux>
        <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 24 Sep 2020 08:08:31 +0200
Michal Simek <michal.simek@xilinx.com> wrote:

> Hi, +Anand,
> 
> On 23. 09. 20 22:47, Jonathan Cameron wrote:
> > On Tue, 22 Sep 2020 15:46:24 +0200
> > Lars-Peter Clausen <lars@metafoo.de> wrote:
> >   
> >> The xilinx-xadc IIO driver currently has support for the XADC in the Xilinx
> >> 7 series FPGAs. The system-monitor is the equivalent to the XADC in the
> >> Xilinx UltraScale and UltraScale+ FPGAs.
> >>
> >> The IP designers did a good job at maintaining backwards compatibility and
> >> only minor changes are required to add basic support for the system-monitor
> >> core.
> >>
> >> The non backwards compatible changes are:
> >>   * Register map offset was moved from 0x200 to 0x400
> >>   * Only one ADC compared to two in the XADC
> >>   * 10 bit ADC instead of 12 bit ADC
> >>   * Two of the channels monitor different supplies
> >>
> >> Add the necessary logic to accommodate these changes to support the
> >> system-monitor in the XADC driver.
> >>
> >> Note that this patch does not include support for some new features found
> >> in the system-monitor like additional alarms, user supply monitoring and
> >> secondary system-monitor access. This might be added at a later time.
> >>
> >> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> > 
> > Very nice.  Will let this sit on the mailing list a bit longer
> > but looks good to me.  
> 
> FYI: I have asked Anand to take a look at it and retest.
> 
> Thanks,
> Michal
> 
Hi Michal / Anand,

Any feedback on this one?

Thanks

Jonathan

p.s. I'm just ploughing through my older emails and had this one marked
as waiting for a reply.


