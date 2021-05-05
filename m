Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55915373B7C
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 14:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbhEEMjY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 08:39:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233555AbhEEMjL (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 5 May 2021 08:39:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FBEA608FE;
        Wed,  5 May 2021 12:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620218294;
        bh=/+2VzFRJPGasWSU5GhWAr3OrK3XekxrSTsUlVTbikPY=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=D59oFyJHUt9CttXDsUimugJnjeOHwFL1YmM4DQ0BXW5gQqOH1qJUlYqUwlHPLduNI
         gXkaQv0wTHqG8G0+Ac6zApU6wsb8s881hbwSVph2nIJjqD2HWjZ08G2NgJTWJ1tl30
         uQQ64Slbd4aUP9hrM+fzTK5pH/dbShuK93JOPxpd6YR0WvtnErk9uo6vgEFw2zvJsx
         1xvbD9yFw8nEfhP3AOgjewQiNBhFieOOe3E2J2BiGzHU0e3QfBYi1vyFCNzGaYvUoA
         l66NMR0T10dN9t8KeDIecQjaYxROf112+JlZkYtxzkd4PRsReTDTj2lS0cUuEqIQZH
         +0OHv88r9uxPw==
Date:   Wed, 5 May 2021 14:38:11 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     jic23@kernel.org, benjamin.tissoires@redhat.com,
        jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH 2/2] HID: hid-sensor-custom: Process failure of
 sensor_hub_set_feature()
In-Reply-To: <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.2105051437420.28378@cbobk.fhfr.pm>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com> <20210415185232.2617398-2-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021, Srinivas Pandruvada wrote:

> When user modifies a custom feature value and sensor_hub_set_feature()
> fails, return error.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
> Replaces patch: HID: hid-sensor-custom: remove useless variable
> by Jiapeng Chong <jiapeng.chong@linux.alibaba.com> 
> 
>  drivers/hid/hid-sensor-custom.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
> index 2628bc53ed80..58b54b127cdf 100644
> --- a/drivers/hid/hid-sensor-custom.c
> +++ b/drivers/hid/hid-sensor-custom.c
> @@ -406,6 +406,8 @@ static ssize_t store_value(struct device *dev, struct device_attribute *attr,
>  								report_id;
>  		ret = sensor_hub_set_feature(sensor_inst->hsdev, report_id,
>  					     index, sizeof(value), &value);
> +		if (ret)
> +			return ret;

What tree is this patch against? In my tree, we're not even assigning 
sensor_hub_set_feature() return value to anything.

-- 
Jiri Kosina
SUSE Labs

