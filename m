Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D25C836D927
	for <lists+linux-iio@lfdr.de>; Wed, 28 Apr 2021 16:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhD1OB4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 28 Apr 2021 10:01:56 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2941 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbhD1OB4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 28 Apr 2021 10:01:56 -0400
Received: from fraeml702-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FVgBT2DNQz72fC3;
        Wed, 28 Apr 2021 21:55:29 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml702-chm.china.huawei.com (10.206.15.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 28 Apr 2021 16:01:06 +0200
Received: from localhost (10.52.123.69) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Wed, 28 Apr
 2021 15:01:06 +0100
Date:   Wed, 28 Apr 2021 14:59:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Sean Nyekjaer <sean@geanix.com>
CC:     <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <andy.shevchenko@gmail.com>, <lars@metafoo.de>,
        <Nuno.Sa@analog.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] iio: accel: add support for
 FXLS8962AF/FXLS8964AF accelerometers
Message-ID: <20210428145932.000022db@Huawei.com>
In-Reply-To: <9b42101e-a48e-d01e-4cd3-51f5ebfcf7d7@geanix.com>
References: <20210428080107.3584120-1-sean@geanix.com>
        <9b42101e-a48e-d01e-4cd3-51f5ebfcf7d7@geanix.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.123.69]
X-ClientProxiedBy: lhreml751-chm.china.huawei.com (10.201.108.201) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 28 Apr 2021 13:34:01 +0200
Sean Nyekjaer <sean@geanix.com> wrote:

> On 28/04/2021 10.01, Sean Nyekjaer wrote:
> > |static int fxls8962af_read_raw(struct iio_dev *indio_dev, + struct 
> > iio_chan_spec const *chan, + int *val, int *val2, long mask) +{ + 
> > struct fxls8962af_data *data = iio_priv(indio_dev); + int ret; + + 
> > switch (mask) { + case IIO_CHAN_INFO_RAW: + ret = 
> > iio_device_claim_direct_mode(indio_dev); + if (ret) + return ret; + + 
> > switch (chan->type) { + case IIO_TEMP: + ret = 
> > fxls8962af_get_temp(data, val); + break; + case IIO_ACCEL: + ret = 
> > fxls8962af_get_axis(data, chan, val); + break; + default: + ret = 
> > -EINVAL; + } + + iio_device_release_direct_mode(indio_dev); + return ret;|  
> |Maybe I should remove iio_device_claim_direct_mode() and release(),
> there is actually nothing in the datasheet that block us from reading 
> temp and raw
> axis data with streaming enabled to the internal fifo.
> We have a use-case for reading temperature data while streaming 
> accelerometer data.
> 
> Could I just check for ||iio_buffer_enabled||() and skip the drdy and 
> power_on/off in
> ||fxls8962af_get_temp() and ||fxls8962af_get_axis()||?

Absolutely fine to have these enabled whilst doing fifo accesses as
long as they don't changing timing etc (they do on some devices).

Sounds like you'd need to reference count power_on / off rather than
basing it on whether the buffer is enabled (to avoid a race condition).

I think runtime pm should handle that for you anyway. 

> 
> /Sean
> |

