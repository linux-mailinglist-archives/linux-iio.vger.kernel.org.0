Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA9D04446CE
	for <lists+linux-iio@lfdr.de>; Wed,  3 Nov 2021 18:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbhKCRRf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Wed, 3 Nov 2021 13:17:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229587AbhKCRRe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 3 Nov 2021 13:17:34 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC856109F;
        Wed,  3 Nov 2021 17:14:55 +0000 (UTC)
Date:   Wed, 3 Nov 2021 17:19:28 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Anand Ashok Dumbre <ANANDASH@xilinx.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>, git <git@xilinx.com>,
        Michal Simek <michals@xilinx.com>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        devicetree <devicetree@vger.kernel.org>,
        Manish Narani <MNARANI@xilinx.com>
Subject: Re: [PATCH v7 2/4] iio: adc: Add Xilinx AMS driver
Message-ID: <20211103171928.23e86227@jic23-huawei>
In-Reply-To: <BY5PR02MB69163C30E1F4BAB847C88C1AA98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
References: <20211019152048.28983-1-anand.ashok.dumbre@xilinx.com>
        <20211019152048.28983-3-anand.ashok.dumbre@xilinx.com>
        <CAHp75Vf+dWSG6g-JsVnkJc0nREviRGZCeqoCfi20YZ9ouD+=hg@mail.gmail.com>
        <BY5PR02MB69163C30E1F4BAB847C88C1AA98B9@BY5PR02MB6916.namprd02.prod.outlook.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 2 Nov 2021 21:31:21 +0000
Anand Ashok Dumbre <ANANDASH@xilinx.com> wrote:

> Hi Andy,
> 
> Thanks for the review.
...

> > > +               return IRQ_NONE;  
> > 
> > ...
> >   
> > > +       for_each_child_of_node(chan_node, child) {
> > > +               ret = of_property_read_u32(child, "reg", &reg);
> > > +               if (ret || reg > (AMS_PL_MAX_EXT_CHANNEL + 30))
> > > +                       continue;
> > > +
> > > +               memcpy(&channels[num_channels], &ams_pl_channels[reg +
> > > +                      AMS_PL_MAX_FIXED_CHANNEL - 30],
> > > + sizeof(*channels));
> > > +
> > > +               if (of_property_read_bool(child, "xlnx,bipolar"))
> > > +                       channels[num_channels].scan_type.sign = 's';
> > > +
> > > +               num_channels++;
> > > +       }  
> > 
> > Use device property API here instead of *of_*() calls.  
> 
> 
> > 
> > ...
> >   
> > > +       /* Initialize buffer for channel specification */
> > > +       ams_channels = kzalloc(sizeof(ams_ps_channels) +
> > > +                              sizeof(ams_pl_channels) +
> > > +                              sizeof(ams_ctrl_channels), GFP_KERNEL);  
> > 
> > Use the corresponding macro from overflow.h.
> >   
> > > +       if (!ams_channels)
> > > +               return -ENOMEM;  
> > 
> > ...
> >   
> > > +       if (of_device_is_available(np)) {  
> > 
> > fwnode_device_is_available()  
> 
> Currently acpi is not supported with this driver. But I will add support in the next series of patches.
> I don’t have a full understanding of ACPI and its interfaces. So would it be okay once the first iteration
> gets checked in, I will add ACPI support on top.

If you use the generic fwnode etc from property.h then dt
will just work and it may well be enough to enable the weirdness that
is ACPI ID PRP0001 which actually uses dt properties but reads them
from an ACPI DSDT.

So basically nothing to do except use the generic accessors rather than
the of_ variants.

Jonathan

