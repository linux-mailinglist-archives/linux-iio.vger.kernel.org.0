Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66D1818F317
	for <lists+linux-iio@lfdr.de>; Mon, 23 Mar 2020 11:45:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgCWKpn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 23 Mar 2020 06:45:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:48855 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727908AbgCWKpn (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 23 Mar 2020 06:45:43 -0400
IronPort-SDR: fXj9SZnPaBC8CTWVBMMI5aMc03ByA313JkcxzX0K9P3x4HPyofdOZ8ptyliagfiLsVgi75YC4M
 sImtIXzXVKeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 03:45:43 -0700
IronPort-SDR: bF8ZssSVhipkUhGkoKKLKC2T3+xI9OpN39oCMaDRLcR8HmrQ61OjJSE8zJR4MXPUbLI+UHVynN
 LyS5LUDVYcgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,296,1580803200"; 
   d="scan'208";a="447351270"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by fmsmga006.fm.intel.com with ESMTP; 23 Mar 2020 03:45:41 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1jGKaV-00CDW1-Kv; Mon, 23 Mar 2020 12:45:43 +0200
Date:   Mon, 23 Mar 2020 12:45:43 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net
Subject: Re: [PATCH v3] iio: accel: Add support for the Bosch-Sensortec BMI088
Message-ID: <20200323104543.GH1922688@smile.fi.intel.com>
References: <20200316073208.19715-1-mike.looijmans@topic.nl>
 <20200315120238.18c10af0@archlinux>
 <20200313140415.20266-1-mike.looijmans@topic.nl>
 <46bec9b8-28ee-6fd3-f615-2b8db43626aa@metafoo.de>
 <20200319154842.1950-1-mike.looijmans@topic.nl>
 <20200322001628.GA2824675@smile.fi.intel.com>
 <826f5f78-6ce7-91f0-0ca2-880ac45c8df2@topic.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <826f5f78-6ce7-91f0-0ca2-880ac45c8df2@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Mar 23, 2020 at 10:21:07AM +0100, Mike Looijmans wrote:
> On 22-03-2020 01:16, Andy Shevchenko wrote:
> > On Thu, Mar 19, 2020 at 04:48:42PM +0100, Mike Looijmans wrote:

...

> > > +static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
> > > +{
> > > +	int ret;
> > > +	__s16 temp;
> > > +
> > > +	mutex_lock(&data->mutex);
> > 
> > > +	ret = regmap_bulk_read(data->regmap, BMI088_ACCEL_REG_TEMP,
> > > +			       &data->buffer, 2);
> > 
> > sizeof() ?
> 
> The buffer is a shared buffer, it will grow to accommodate reading all axis
> and timestamp in a single read (9 bytes) and for FIFO reads in foreseeable
> future.
> 
> I could use sizeof(temp) here though, but that wouldn't that be more
> confusing?

Yeah, perhaps comment explaining why 2 is being used there and why you write
directly to the buffer (no temporary variable being involved)?

> > > +	temp = get_unaligned_be16(data->buffer);
> > > +
> > > +	mutex_unlock(&data->mutex);
> > > +
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	*val = temp >> 5;
> > > +
> > > +	return IIO_VAL_INT;
> > > +}

-- 
With Best Regards,
Andy Shevchenko


