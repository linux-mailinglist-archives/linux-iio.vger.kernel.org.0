Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A95942F42F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 15:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239987AbhJONu1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 09:50:27 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3980 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239718AbhJONu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 09:50:26 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HW6wJ4zr0z67QNS;
        Fri, 15 Oct 2021 21:45:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 15:48:18 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 14:48:17 +0100
Date:   Fri, 15 Oct 2021 14:48:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Qing Wang <wangqing@vivo.com>
CC:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bruno =?ISO-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>,
        Stefan Achatz <erazor_de@users.sourceforge.net>,
        Jonathan Cameron <jic23@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
Subject: Re: [PATCH V2 4/5] hid-sensor: replace snprintf in show functions
 with sysfs_emit
Message-ID: <20211015144816.0000520f@Huawei.com>
In-Reply-To: <1634296054-6971-5-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
        <1634296054-6971-5-git-send-email-wangqing@vivo.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 15 Oct 2021 04:07:31 -0700
Qing Wang <wangqing@vivo.com> wrote:

> show() should not use snprintf() when formatting the value to be returned 
> to user space, snprintf() returns the length the resulting string and 
> scnprintf() returns the number of bytes printed into the buffer.
> 
> Fix the coccicheck warnings:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit() instead of scnprintf() makes more sense.
> 
> Signed-off-by: Qing Wang <wangqing@vivo.com>
> ---
>  drivers/hid/hid-sensor-custom.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 32c2306..a46481d6 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -371,7 +371,7 @@ static ssize_t show_value(struct device *dev, struct device_attribute *attr,
>  				     sizeof(struct hid_custom_usage_desc),
>  				     usage_id_cmp);
>  		if (usage_desc)
> -			return snprintf(buf, PAGE_SIZE, "%s\n",
> +			return sysfs_emit(buf, "%s\n",
>  					usage_desc->desc);

Now easily short enough that this can go on one line.

>  		else
>  			return sprintf(buf, "not-specified\n");
Whilst of course not necessary, it might be nicer to use sysfs_emit here as well for
consistency.

Otherwise looks good to me.

Jonathan

