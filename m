Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 952181F1A85
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 16:03:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgFHODo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 10:03:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2292 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729175AbgFHODo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 10:03:44 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 83679313408E91291DB;
        Mon,  8 Jun 2020 15:03:43 +0100 (IST)
Received: from localhost (10.47.27.61) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 8 Jun 2020
 15:03:43 +0100
Date:   Mon, 8 Jun 2020 15:03:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Daniel Baluta <daniel.baluta@gmail.com>
Subject: Re: [PATCH 18/32] iio:imu:bmi160 Fix alignment and data leak issues
Message-ID: <20200608150300.000018ff@Huawei.com>
In-Reply-To: <20200608131712.GQ2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
        <20200607155408.958437-19-jic23@kernel.org>
        <20200608131712.GQ2428291@smile.fi.intel.com>
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

On Mon, 8 Jun 2020 16:17:12 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sun, Jun 07, 2020 at 04:53:54PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > One of a class of bugs pointed out by Lars in a recent review.
> > iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
> > to the size of the timestamp (8 bytes).  This is not guaranteed in
> > this driver which uses an array of smaller elements on the stack.
> > As Lars also noted this anti pattern can involve a leak of data to
> > userspace and that indeed can happen here.  We close both issues by
> > moving to a suitable array in the iio_priv() data with alignment
> > explicitly requested.  This data is allocated with kzalloc so no
> > data can leak apart from previous readings.  
> 
> > +	/* Ensure natural alignment for timestamp if present */
> > +	__le16 buf[16] __aligned(8);  
> 
> Perhaps struct in all such cases, like
> 
>  struct scan {
> 	 __le16 buf[3 * 3]; // 3 axis per 3 sensors
> 	 s64 ts; __aligned(8);
>  };
> 
> ?
> 

I did that for all the cases where the timestamp could only appear in
one location, which are those with 8 bytes or less of channels + any
which don't have flexible channel configs.

Unfortunately that's not always the case in this driver.  It depends on how
many channels are turned on.   As they are 2 bytes each, if you have
only 1-4 channels enabled, then the timestamp will start at 8 bytes in.
If you have 5-8 channels enabled it'll be 8 bytes in, if you have 9 channels
it will be 24 bytes in.

I thought about just ignoring that and pretending the timestamp was always
in the same place but my thought was that we'd be implying something
false and weird bugs lie down that sort of route.

We could in theory do

union {
	struct {
		__le16 buf[3 * 3];
		s64 ts __aligned(8) 
	};
	struct {
		__le16 buf[4];
		s64 ts __aligned(8);
	} short1;
	struct {
		__le16 buf[8];
		s64 ts __aligned(8);
	} short2;	
} scan;

But I guess you can see why I didn't go that route.

Jonathan



