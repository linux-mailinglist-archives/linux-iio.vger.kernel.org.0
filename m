Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6735D2DB3C1
	for <lists+linux-iio@lfdr.de>; Tue, 15 Dec 2020 19:31:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729683AbgLOSaN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 15 Dec 2020 13:30:13 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2262 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731584AbgLOS37 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 15 Dec 2020 13:29:59 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CwRXx2zGWz67Ph6;
        Wed, 16 Dec 2020 02:26:25 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 15 Dec 2020 19:29:15 +0100
Received: from localhost (10.47.79.81) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Tue, 15 Dec
 2020 18:29:14 +0000
Date:   Tue, 15 Dec 2020 18:28:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Anand Ashok Dumbre <ANANDASH@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
 System Monitor
Message-ID: <20201215182847.00001627@Huawei.com>
In-Reply-To: <d88226b8-74c6-0535-fc72-936f87463fb6@metafoo.de>
References: <20200922134624.13191-1-lars@metafoo.de>
        <20200922134624.13191-2-lars@metafoo.de>
        <20200923214728.6e0c07b0@archlinux>
        <fb8db604-0ae3-1736-67bf-20a1dc8bc008@xilinx.com>
        <20201129131441.3e9d83f8@archlinux>
        <BY5PR02MB6916F923D93341D41BA08E8AA9CA0@BY5PR02MB6916.namprd02.prod.outlook.com>
        <20201213115711.58733caa@archlinux>
        <d88226b8-74c6-0535-fc72-936f87463fb6@metafoo.de>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.79.81]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Dec 2020 16:49:19 +0100
Lars-Peter Clausen <lars@metafoo.de> wrote:

> On 12/13/20 12:57 PM, Jonathan Cameron wrote:
> > On Fri, 11 Dec 2020 09:57:30 +0000
> > Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:
> >  
> >>> -----Original Message-----
> >>> From: Jonathan Cameron <jic23@kernel.org>
> >>> Sent: Sunday 29 November 2020 1:15 PM
> >>> To: Michal Simek <michals@xilinx.com>
> >>> Cc: Lars-Peter Clausen <lars@metafoo.de>; Peter Meerwald-Stadler
> >>> <pmeerw@pmeerw.net>; linux-iio@vger.kernel.org; Anand Ashok Dumbre
> >>> <ANANDASH@xilinx.com>
> >>> Subject: Re: [PATCH 2/2] iio: xilinx-xadc: Add basic support for Ultrascale
> >>> System Monitor
> >>>
> >>> On Thu, 24 Sep 2020 08:08:31 +0200
> >>> Michal Simek <michal.simek@xilinx.com> wrote:
> >>>      
> >>>> Hi, +Anand,
> >>>>
> >>>> On 23. 09. 20 22:47, Jonathan Cameron wrote:  
> >>>>> On Tue, 22 Sep 2020 15:46:24 +0200
> >>>>> Lars-Peter Clausen <lars@metafoo.de> wrote:
> >>>>>     
> >>>>>> The xilinx-xadc IIO driver currently has support for the XADC in
> >>>>>> the Xilinx
> >>>>>> 7 series FPGAs. The system-monitor is the equivalent to the XADC in
> >>>>>> the Xilinx UltraScale and UltraScale+ FPGAs.
> >>>>>>
> >>>>>> The IP designers did a good job at maintaining backwards
> >>>>>> compatibility and only minor changes are required to add basic
> >>>>>> support for the system-monitor core.
> >>>>>>
> >>>>>> The non backwards compatible changes are:
> >>>>>>    * Register map offset was moved from 0x200 to 0x400
> >>>>>>    * Only one ADC compared to two in the XADC
> >>>>>>    * 10 bit ADC instead of 12 bit ADC
> >>>>>>    * Two of the channels monitor different supplies
> >>>>>>
> >>>>>> Add the necessary logic to accommodate these changes to support the
> >>>>>> system-monitor in the XADC driver.
> >>>>>>
> >>>>>> Note that this patch does not include support for some new features
> >>>>>> found in the system-monitor like additional alarms, user supply
> >>>>>> monitoring and secondary system-monitor access. This might be added  
> >>> at a later time.  
> >>>>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>  
> >>>>> Very nice.  Will let this sit on the mailing list a bit longer but
> >>>>> looks good to me.  
> >>>> FYI: I have asked Anand to take a look at it and retest.
> >>>>
> >>>> Thanks,
> >>>> Michal
> >>>>     
> >>> Hi Michal / Anand,
> >>>
> >>> Any feedback on this one?
> >>>
> >>> Thanks
> >>>
> >>> Jonathan
> >>>
> >>> p.s. I'm just ploughing through my older emails and had this one marked as
> >>> waiting for a reply.
> >>>      
> >> Hi Jonathan,
> >>
> >> Thanks for waiting.
> >> The patch looks good.
> >>
> >> Reviewed-by: Anand Ashok Dumbre <anandash@xilinx.com>
> >> Tested-by: Anand Ashok Dumbre <anandash@xilinx.com>  
> > Thanks. I've applied this but there was a bit of complexity around
> > devm changes that went in whilst this was under review.
> >
> > I think I fixed it up correctly, but great if you can take
> > a quick look to make sure I didn't mess it up.
> > I'll try and put the other outstanding series in as well which
> > will probably result in more fiddly corners during the merge.
> >
> > Applied to the togreg branch of iio.git and pushed out as testing
> > or the autobuilders to see what we missed.
> >  
> Thanks Johnathan.
> 
> I'm not seeing the patches in your public repository yet :)

Doh. I may well have forgotten to push.  Will do so later today if so.

Jonathan

> 

