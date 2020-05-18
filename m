Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68C3E1D7ED0
	for <lists+linux-iio@lfdr.de>; Mon, 18 May 2020 18:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbgERQnU (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 18 May 2020 12:43:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:48761 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgERQnU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 18 May 2020 12:43:20 -0400
IronPort-SDR: 0AHFgMZphkospxMAbe/8lyswVtAI8SxiTNhvSVk+vNF7UzvxfHM/xEx0CfgBVIOfCcBdLXd2OR
 ZwVnfPt1ZdEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 09:43:18 -0700
IronPort-SDR: upDKlvNwBdsY1JUgaGgn7G2U8VVN5G1yPIetYSweB5w8b5sStOSfgYfh5535yban1X6ROWpjOW
 Nd09R8pnrSMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="288632001"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga004.fm.intel.com with ESMTP; 18 May 2020 09:43:15 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andy.shevchenko@gmail.com>)
        id 1jairF-007TA1-UP; Mon, 18 May 2020 19:43:17 +0300
Date:   Mon, 18 May 2020 19:43:17 +0300
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Jonathan Albrieux <jonathan.albrieux@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Steve Winslow <swinslow@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 3/3] iio: magnetometer: ak8975: Add gpio reset support
Message-ID: <20200518164317.GL1634618@smile.fi.intel.com>
References: <20200518133645.19127-1-jonathan.albrieux@gmail.com>
 <20200518133645.19127-4-jonathan.albrieux@gmail.com>
 <CAHp75VdFJUNOtRyCNEGnvoOCZYoPvyhjC15_iC72JD-1sOavwA@mail.gmail.com>
 <20200518160120.GA21361@ict14-OptiPlex-980>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518160120.GA21361@ict14-OptiPlex-980>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, May 18, 2020 at 06:01:20PM +0200, Jonathan Albrieux wrote:
> On Mon, May 18, 2020 at 05:55:51PM +0300, Andy Shevchenko wrote:
> > On Mon, May 18, 2020 at 4:38 PM Jonathan Albrieux
> > <jonathan.albrieux@gmail.com> wrote:
> > 
> > > +       gpiod_set_value_cansleep(data->reset_gpiod, 1);
> > 
> > (1)
> > 
> > ...
> > 
> > > +       /*
> > > +        * If reset pin is provided then will be set to high on power on
> > > +        * and to low on power off according to AK09911 datasheet
> > > +        */
> > 
> > Wording is confusing, perhaps you have to use 'asserted / deasserted'.
> 
> Thank you for the suggestion, I'll be working on rewording as soon as
> possible.
> 
> > Btw, in (1) it's also "high" (asserted). I barely understand how it's
> > supposed to work in all cases?
> > 
> > > +       reset_gpiod = devm_gpiod_get_optional(&client->dev,
> > > +                                             "reset", GPIOD_OUT_HIGH);
> > > +       if (IS_ERR(reset_gpiod))
> > > +               return PTR_ERR(reset_gpiod);
> > 
> 
> I'm sorry but I'm not sure about what you mean by saying all cases.
> Currently  I'm testing this driver on a msm8916 device having AK09911
> magnetometer. At the current stage the driver is failing on probe 
> because reset pin is not connected to VID (as datasheet requires in case
> of pin not being used). In case of reset pin not asserted, register's
> reset is triggered resulting in empty registers, leading to probe fail.
> For this reason pin is asserted during power on in order to have 
> informations in registers and deasserted before power off triggering
> a reset.
> 
> A workaround that gets AK09911 working on device is by setting the
> reset pin always high on device tree. This way registers gets reset by
> a Power On Reset circuit autonomously and reset pin never triggers the
> reset.

You need to distinguish electrical level from logical (GPIO flag defines
logical). So, I'm talking about active-high vs. active-low case.

Now I re-read above, and see that here you assert the reset signal. But where
is desertion?

-- 
With Best Regards,
Andy Shevchenko


