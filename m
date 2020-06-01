Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 284D91EA510
	for <lists+linux-iio@lfdr.de>; Mon,  1 Jun 2020 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFANfo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 1 Jun 2020 09:35:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2263 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgFANfn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jun 2020 09:35:43 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 16A8CE2054BA6C7C3EB6;
        Mon,  1 Jun 2020 14:35:42 +0100 (IST)
Received: from localhost (10.47.94.81) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 1 Jun 2020
 14:35:41 +0100
Date:   Mon, 1 Jun 2020 14:35:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Tomasz Duszynski <tomasz.duszynski@octakon.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <robh+dt@kernel.org>, <andy.shevchenko@gmail.com>,
        <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2 1/4] iio: chemical: scd30: add core driver
Message-ID: <20200601143502.00005030@Huawei.com>
In-Reply-To: <20200601121026.GB28560@arch>
References: <20200530213630.87159-1-tomasz.duszynski@octakon.com>
        <20200530213630.87159-2-tomasz.duszynski@octakon.com>
        <20200531105840.27e17f3d@archlinux>
        <20200531192152.GC27246@arch>
        <20200601121026.GB28560@arch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.94.81]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

...
> > > > +static const struct iio_chan_spec scd30_channels[] = {
> > > > +	{
> > > > +		.type = IIO_PRESSURE,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBSCALE),
> > > > +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_CALIBSCALE),
> > > > +		.scan_index = -1,
> > > > +	},
> > > > +	{
> > > > +		.type = IIO_CONCENTRATION,
> > > > +		.channel2 = IIO_MOD_CO2,
> > > > +		.address = SCD30_CONC,
> > > > +		.scan_index = SCD30_CONC,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > > > +				      BIT(IIO_CHAN_INFO_SCALE),
> > > > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > > > +		.modified = 1,
> > > > +
> > > > +		SCD30_CHAN_SCAN_TYPE('u', 16),
> > > > +	},
> > > > +	{
> > > > +		.type = IIO_TEMP,
> > > > +		.address = SCD30_TEMP,
> > > > +		.scan_index = SCD30_TEMP,
> > > > +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
> > > > +				      BIT(IIO_CHAN_INFO_CALIBBIAS) |
> > > > +				      BIT(IIO_CHAN_INFO_SCALE),  
> > >
> > > Combination of processed and scale is unusual.  Normally scale provides
> > > a conversion factor or a _RAW reading.  
> >
> > Right that's pointless. Scales were for raw measurements inside buffer.
> > Somehow I failed to realize that only co2 concentration is raw.
> >  
> 
> One more thing occurred to me here. I just looked at CONCENTRATION_RAW
> description and is states that this should return *percentage* reading.
> Then after scaling what we should be left with?

It should say after application of scale and offset.  Patches welcome :)

> 
> Or perhaps scale should return just 1.0 for completeness if we want to
> live with percentages.
> 
> Though in case where percentage reading is fractional then passing
> through buffers will not work. Or am I missing something?
> 
> On the other hand if abi said nothing about percentages one would just
> push whatever raw reading sensor outputs and provide scaling info to
> userspace.
> 

> > >  


