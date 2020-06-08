Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB9E1F16DA
	for <lists+linux-iio@lfdr.de>; Mon,  8 Jun 2020 12:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729280AbgFHKmO (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 8 Jun 2020 06:42:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:18713 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729415AbgFHKmL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 8 Jun 2020 06:42:11 -0400
IronPort-SDR: IPRKY+LnvXy4XyUINUADCC/aQuZb7IClvr1fne1eUX6gUs/ehfvpE9nTxYqA8v9QXyATW7cZRy
 i8wzDArpu9UA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 03:42:09 -0700
IronPort-SDR: i/vTBN45wcStAf/eEOQcwz/Xrcxgv6uPoYZ0elZxnTt1i+pDMN0KegHoanJFQQpDnIL3a+Vmzp
 ZP7YbLi/Ol7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,487,1583222400"; 
   d="scan'208";a="259404287"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga007.jf.intel.com with ESMTP; 08 Jun 2020 03:42:07 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jiFEI-00BejF-8S; Mon, 08 Jun 2020 13:42:10 +0300
Date:   Mon, 8 Jun 2020 13:42:10 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 20/32] iio:imu:inv_mpu6050 Fix dma and ts alignment and
 data leak issues.
Message-ID: <20200608104210.GH2428291@smile.fi.intel.com>
References: <20200607155408.958437-1-jic23@kernel.org>
 <20200607155408.958437-21-jic23@kernel.org>
 <MN2PR12MB44220F9CE7BDF5ACA3DEF4A4C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR12MB44220F9CE7BDF5ACA3DEF4A4C4850@MN2PR12MB4422.namprd12.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Jun 08, 2020 at 10:24:11AM +0000, Jean-Baptiste Maneyrol wrote:
> Hi Jonathan,
> 
> as stated before, I think this is a good opportunity to fix FIFO data reading by replacing regmap_bulk_read by regmap_noinc_read.
> Otherwise it could also be done in another patch.

It seems I didn't get this series to my work email, so, sorry for answering here.

> -       result = regmap_bulk_read(st->map, st->reg->fifo_count_h, data,
> +       result = regmap_bulk_read(st->map, st->reg->fifo_count_h,

> +                                 st->data,
>                                    INV_MPU6050_FIFO_COUNT_BYTE);

Now this can be one line :-)

...

> -               iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> +               iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +                                                  timestamp);

And this seems redundant change.

-- 
With Best Regards,
Andy Shevchenko


