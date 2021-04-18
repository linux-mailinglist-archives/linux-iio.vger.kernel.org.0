Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5CE3634C7
	for <lists+linux-iio@lfdr.de>; Sun, 18 Apr 2021 13:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236700AbhDRLMp (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 18 Apr 2021 07:12:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:44494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236562AbhDRLMo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 18 Apr 2021 07:12:44 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C6CB61001;
        Sun, 18 Apr 2021 11:12:13 +0000 (UTC)
Date:   Sun, 18 Apr 2021 12:12:44 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        jiapeng.chong@linux.alibaba.com, linux-input@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] HID: hid-sensor-hub: Return error for
 hid_set_field() failure
Message-ID: <20210418121244.7e26914b@jic23-huawei>
In-Reply-To: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
References: <20210415185232.2617398-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 15 Apr 2021 11:52:31 -0700
Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> wrote:

> In the function sensor_hub_set_feature(), return error when hid_set_field()
> fails.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Series applied to the to greg branch of iio.git.  Note these won't make the
coming merge window, so will turn up in next sometime after rc1.

thanks,

Jonathan

> ---
>  drivers/hid/hid-sensor-hub.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 3dd7d3246737..f9983145d4e7 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -210,16 +210,21 @@ int sensor_hub_set_feature(struct hid_sensor_hub_device *hsdev, u32 report_id,
>  	buffer_size = buffer_size / sizeof(__s32);
>  	if (buffer_size) {
>  		for (i = 0; i < buffer_size; ++i) {
> -			hid_set_field(report->field[field_index], i,
> -				      (__force __s32)cpu_to_le32(*buf32));
> +			ret = hid_set_field(report->field[field_index], i,
> +					    (__force __s32)cpu_to_le32(*buf32));
> +			if (ret)
> +				goto done_proc;
> +
>  			++buf32;
>  		}
>  	}
>  	if (remaining_bytes) {
>  		value = 0;
>  		memcpy(&value, (u8 *)buf32, remaining_bytes);
> -		hid_set_field(report->field[field_index], i,
> -			      (__force __s32)cpu_to_le32(value));
> +		ret = hid_set_field(report->field[field_index], i,
> +				    (__force __s32)cpu_to_le32(value));
> +		if (ret)
> +			goto done_proc;
>  	}
>  	hid_hw_request(hsdev->hdev, report, HID_REQ_SET_REPORT);
>  	hid_hw_wait(hsdev->hdev);

