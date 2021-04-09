Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10E335A5A2
	for <lists+linux-iio@lfdr.de>; Fri,  9 Apr 2021 20:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234307AbhDIST1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 9 Apr 2021 14:19:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:52189 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhDIST1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Apr 2021 14:19:27 -0400
IronPort-SDR: uccLVigrcXuCYjf1I0geCDTAp1/Pgd3GwyhEW1RfsN6DO5AYAEOn3JcRDrcp/I3/j/Q6YF3PMv
 43G4EP1Id26A==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="257799132"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="257799132"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:19:13 -0700
IronPort-SDR: /I9COsxklnbf4TuqSKo0lJiwczd1QgJu1XMilTIe5g9PxIJEOOJz8R2W2dXE/XZO3zTymbGNXP
 v93v85mHJ7vA==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="520362034"
Received: from umangdes-mobl.amr.corp.intel.com ([10.212.128.208])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 11:19:12 -0700
Message-ID: <4079bb49a9c0022603abeffcdaec32208f449e51.camel@linux.intel.com>
Subject: Re: [PATCH] HID: hid-sensor-custom: remove useless variable
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, jikos@kernel.org
Cc:     jic23@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 09 Apr 2021 11:19:12 -0700
In-Reply-To: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1617952508-47150-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 2021-04-09 at 15:15 +0800, Jiapeng Chong wrote:
> Fix the following gcc warning:
> 
> drivers/hid/hid-sensor-custom.c:400:7: warning: variable ‘ret’ set
> but
> not used [-Wunused-but-set-variable].
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com

> ---
>  drivers/hid/hid-sensor-custom.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-
> sensor-custom.c
> index 2628bc5..e430673 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -397,15 +397,14 @@ static ssize_t store_value(struct device *dev,
> struct device_attribute *attr,
>  
>  	if (!strncmp(name, "value", strlen("value"))) {
>  		u32 report_id;
> -		int ret;
>  
>  		if (kstrtoint(buf, 0, &value) != 0)
>  			return -EINVAL;
>  
>  		report_id = sensor_inst->fields[field_index].attribute.
>  								report_
> id;
> -		ret = sensor_hub_set_feature(sensor_inst->hsdev,
> report_id,
> -					     index, sizeof(value),
> &value);
> +		sensor_hub_set_feature(sensor_inst->hsdev, report_id,
> index,
> +				       sizeof(value), &value);
>  	} else
>  		return -EINVAL;
>  

