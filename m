Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362B01F1A8C
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFHOHZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 10:07:25 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2293 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728988AbgFHOHZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 10:07:25 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3AF54E9978B6C2029929;
        Mon,  8 Jun 2020 15:07:24 +0100 (IST)
Received: from localhost (10.47.27.61) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Jun 2020
 15:07:23 +0100
Date:   Mon, 8 Jun 2020 15:06:40 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH 27/32] iio:adc:ti-ads124s08 Fix alignment and data leak
 issues.
Message-ID: <20200608150640.000053a6@Huawei.com>
In-Reply-To: <20200608131458.GP2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-28-jic23@kernel.org>
        <20200608131458.GP2428291@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.27.61]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Jun 2020 16:14:58 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jun 07, 2020 at 04:54:03PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable structure in the iio_priv() data with alignment
> > explicitly requested.  This data is allocated with kzalloc so no
> > data can leak apart from previous readings.  
> 
> > +	/*
> > +	 * Used to correctly align data.
> > +	 * Ensure timestamp is naturally aligned.
> > +	 */  
> 
> > +	u32 buffer[ADS124S08_MAX_CHANNELS + sizeof(s64)/sizeof(u16)] __aligned(8);  
> 
> Can't you rather provide a struct as well?
> 
Not without giving a false impression of where the time stamp is in the resulting
buffer.

I'm not keen to do that because it'll lead to people fundamentally misunderstanding
the dynamic nature of IIO buffer packing.

Here it could start at byte 8, 16, 24, 32, 48, 64 I think.

It's more than possible I've gotten one of these wrong and missed a restriction
on the layout in a given device though!

Jonathan

