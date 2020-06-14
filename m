Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E251F8974
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jun 2020 17:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgFNPLI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jun 2020 11:11:08 -0400
Received: from www381.your-server.de ([78.46.137.84]:41598 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNPLH (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jun 2020 11:11:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2DdAg+LgMBd0da3+ETcMF3kF+GgHUd3v2IJF8Z+RehE=; b=WojMRQ/HGD48weFeNClYtL1TYx
        xS7hBXCEQWorRipPomN2p6KcuCRsXJi8Nc4JnoVU3NpqP6SWN3W6hwVGzs2QgjS+6VV2UjBqrun0r
        mMulN2/Dl7lQys1FILORLf56YqqP9ZouTuhfgy7OxcGAOWesdzU52giqo1FVH0VIX5q2INuX3Nezs
        NsF4vbU6C35QYjh1E7yaU/cPTCixz7uenHN0GtHnZ1dO6kp3OjUNoLHQl3ezS8gBxKHJE1NcIflQo
        0cfhIIAS68MGNx28cMfUuqFwDyXPr5Uixl++4jVmV3XmFvAT/j/8H7ok4K+14RgMnGZDNCZ1otBE6
        JF/osOWg==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jkUHd-0002I6-7W; Sun, 14 Jun 2020 17:10:53 +0200
Received: from [82.135.70.239] (helo=[192.168.178.20])
        by sslproxy01.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jkUHc-000Rve-TY; Sun, 14 Jun 2020 17:10:52 +0200
Subject: Re: [PATCH v3 06/13] iio: imu: inv_icm42600: add temperature sensor
 support
To:     Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        jic23@kernel.org, robh+dt@kernel.org, robh@kernel.org,
        mchehab+huawei@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200608204250.3291-1-jmaneyrol@invensense.com>
 <20200608204250.3291-7-jmaneyrol@invensense.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fd4918b6-a55f-4047-7f18-b796a8ccd020@metafoo.de>
Date:   Sun, 14 Jun 2020 17:10:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200608204250.3291-7-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.3/25843/Sun Jun 14 14:53:02 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/8/20 10:42 PM, Jean-Baptiste Maneyrol wrote:
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = iio_device_claim_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		ret = inv_icm42600_temp_read(st, &temp);
> +		iio_device_release_direct_mode(indio_dev);
> +		if (ret)
> +			return ret;
> +		*val = temp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 483;
> +		*val2 = 91787;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 25000;
> +		return IIO_VAL_INT;

If the data is returned processed there is no need to specify scale and 
offset.

But since the transformation to turn the data into standard units is a 
simple linear transform the preferred way to handle this is to return 
RAW data and specify scale and offset.

