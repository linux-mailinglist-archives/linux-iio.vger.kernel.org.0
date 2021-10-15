Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F4642F43F
	for <lists+linux-iio@lfdr.de>; Fri, 15 Oct 2021 15:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240081AbhJONyD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 15 Oct 2021 09:54:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3981 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240090AbhJONyA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 15 Oct 2021 09:54:00 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HW6zh0ZF9z67bh2;
        Fri, 15 Oct 2021 21:48:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 15:51:52 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 14:51:51 +0100
Date:   Fri, 15 Oct 2021 14:51:50 +0100
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
Subject: Re: [PATCH V2 1/5] hid-lenovo: replace snprintf in show functions
 with sysfs_emit
Message-ID: <20211015145150.0000006e@Huawei.com>
In-Reply-To: <1634296054-6971-2-git-send-email-wangqing@vivo.com>
References: <1634296054-6971-1-git-send-email-wangqing@vivo.com>
        <1634296054-6971-2-git-send-email-wangqing@vivo.com>
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

On Fri, 15 Oct 2021 04:07:28 -0700
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

Hi,

A few places where it makes sense to tidy up the line breaks.

The benefit of the change in general is fairly minor given none
of the cases here can cause problems, but I guess it is worthwhile
as warning suppression and general tidiness improvement.

Jonathan

> ---
>  drivers/hid/hid-lenovo.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hid/hid-lenovo.c b/drivers/hid/hid-lenovo.c
> index 93b1f93..086a7ae 100644
> --- a/drivers/hid/hid-lenovo.c
> +++ b/drivers/hid/hid-lenovo.c
> @@ -400,7 +400,7 @@ static ssize_t attr_fn_lock_show(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data->fn_lock);
> +	return sysfs_emit(buf, "%u\n", data->fn_lock);
>  }
>  
>  static ssize_t attr_fn_lock_store(struct device *dev,
> @@ -442,7 +442,7 @@ static ssize_t attr_sensitivity_show_cptkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *cptkbd_data = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		cptkbd_data->sensitivity);

As below, whilst here tidy this up to be one line.

>  }
>  
> @@ -603,7 +603,7 @@ static ssize_t attr_press_to_select_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->press_to_select);
> +	return sysfs_emit(buf, "%u\n", data_pointer->press_to_select);
>  }
>  
>  static ssize_t attr_press_to_select_store_tpkbd(struct device *dev,
> @@ -633,7 +633,7 @@ static ssize_t attr_dragging_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->dragging);
> +	return sysfs_emit(buf, "%u\n", data_pointer->dragging);
>  }
>  
>  static ssize_t attr_dragging_store_tpkbd(struct device *dev,
> @@ -663,7 +663,7 @@ static ssize_t attr_release_to_select_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->release_to_select);
> +	return sysfs_emit(buf, "%u\n", data_pointer->release_to_select);
>  }
>  
>  static ssize_t attr_release_to_select_store_tpkbd(struct device *dev,
> @@ -693,7 +693,7 @@ static ssize_t attr_select_right_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n", data_pointer->select_right);
> +	return sysfs_emit(buf, "%u\n", data_pointer->select_right);
>  }
>  
>  static ssize_t attr_select_right_store_tpkbd(struct device *dev,
> @@ -723,7 +723,7 @@ static ssize_t attr_sensitivity_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->sensitivity);
Perhaps put this on one line?  It fit before the change of course, but
as you are touching the code, might as well tidy that up.

>  }
>  
> @@ -752,7 +752,7 @@ static ssize_t attr_press_speed_show_tpkbd(struct device *dev,
>  	struct hid_device *hdev = to_hid_device(dev);
>  	struct lenovo_drvdata *data_pointer = hid_get_drvdata(hdev);
>  
> -	return snprintf(buf, PAGE_SIZE, "%u\n",
> +	return sysfs_emit(buf, "%u\n",
>  		data_pointer->press_speed);
Same here.

Thanks,

Jonathan

>  }
>  

