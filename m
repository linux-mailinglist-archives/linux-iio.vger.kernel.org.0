Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB13634CEE0
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbhC2L0f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Mon, 29 Mar 2021 07:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232858AbhC2L0O (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 07:26:14 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0872161585;
        Mon, 29 Mar 2021 11:26:10 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:26:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 20/25] HID: hid-sensor-custom: Remove unused variable
 'ret'
Message-ID: <20210329122617.76335c90@jic23-huawei>
In-Reply-To: <20210326143458.508959-22-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
        <20210326143458.508959-22-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 14:34:53 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/hid/hid-sensor-custom.c: In function ‘store_value’:
>  drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’ set but not used [-Wunused-but-set-variable]
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hid/hid-sensor-custom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 2628bc53ed809..2e6662173a79c 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -397,15 +397,14 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
>  
>  	if (!strncmp(name, "value", strlen("value"))) {
>  		u32 report_id;
> -		int ret;
>  
>  		if (kstrtoint(buf, 0, &value) != 0)
>  			return -EINVAL;
>  
>  		report_id = sensor_inst->fields[field_index].attribute.
>  								report_id;
> -		ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> -					     index, sizeof(value), &value);
> +		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> +				       index, sizeof(value), &value);
>  	} else
>  		return -EINVAL;
>  

