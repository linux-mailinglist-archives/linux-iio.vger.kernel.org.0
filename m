Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFCFF14A37A
	for <lists+linux-iio@lfdr.de>; Mon, 27 Jan 2020 13:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729551AbgA0MGJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Jan 2020 07:06:09 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2297 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728981AbgA0MGJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 27 Jan 2020 07:06:09 -0500
Received: from LHREML713-CAH.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id BBBD5E1D91C9EC7A5529;
        Mon, 27 Jan 2020 12:06:07 +0000 (GMT)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 LHREML713-CAH.china.huawei.com (10.201.108.36) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 27 Jan 2020 12:06:07 +0000
Received: from localhost (10.202.226.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Mon, 27 Jan
 2020 12:06:07 +0000
Date:   Mon, 27 Jan 2020 12:06:06 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Eugene Zalkonnikov <ez@norphonic.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "development@norphonic.com" <development@norphonic.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] Driver for TI HDC20x0 humidity and temperature
 sensors
Message-ID: <20200127120606.00003931@Huawei.com>
In-Reply-To: <9d866c18-6643-f76f-df7e-6f29f01274da@norphonic.com>
References: <B0A4F7BA-0D41-4DA0-985E-F2603D66C48F@norphonic.com>
        <20191223171627.1179f88b@archlinux>
        <9d866c18-6643-f76f-df7e-6f29f01274da@norphonic.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.57]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 21 Jan 2020 08:45:21 +0000
Eugene Zaikonnikov <eugene.zaikonnikov@norphonic.com> wrote:

> Hi Jonathan,
> 
> 
> On 23.12.2019 18:16, Jonathan Cameron wrote:
> >
> > As below. Why change the existing return value?
> >  
> >> +		}
> >> +		return ret;
> >> +	}
> >> +	case IIO_CHAN_INFO_PEAK: {
> >> +		int ret;
> >> +
> >> +		ret = iio_device_claim_direct_mode(indio_dev);
> >> +		if (ret)
> >> +			return ret;
> >> +		mutex_lock(&data->lock);
> >> +		ret = hdc2010_get_measurement_byte(data, chan);
> >> +		mutex_unlock(&data->lock);
> >> +		iio_device_release_direct_mode(indio_dev);
> >> +		if (ret >= 0) {
> >> +		  /* Scaling up the value so we can use same offset as RAW */
> >> +			*val = ret * 256;
> >> +			ret = IIO_VAL_INT;
> >> +		} else  
> > Why overwrite ret?  That might provide better information
> > on what went wrong.  
> 
> As with the other stylistic notes before, no good reason other than how it was handled in other drivers in the tree. So I assumed it was the practice. Will tidy up later this week I hope and send a new patchset.

We should look to clean up any cases where a valid error code is
overwritten with no good reason.   I thought we were pretty good
on that generally but there may be some still hiding in various
drivers.

Thanks,

Jonathan



