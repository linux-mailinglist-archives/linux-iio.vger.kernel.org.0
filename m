Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2F434CEEA
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231663AbhC2L1h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:27:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:55110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232152AbhC2L1I (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 07:27:08 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CD18B61585;
        Mon, 29 Mar 2021 11:27:01 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:27:08 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 22/25] HID: hid-sensor-hub: Remove unused struct member
 'quirks'
Message-ID: <20210329122708.010a36a9@jic23-huawei>
In-Reply-To: <20210326143458.508959-24-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
        <20210326143458.508959-24-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 14:34:55 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> Commit b0f847e16c1ea ("HID: hid-sensor-hub: Force logical minimum to 1
> for power and report state") removed the last used quirk handled by
> this driver.
> 
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/hid/hid-sensor-hub.c:39: warning: Function parameter or member 'quirks' not described in 'sensor_hub_data'
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
>  drivers/hid/hid-sensor-hub.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 3dd7d32467378..36b6852f75dd5 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -34,7 +34,6 @@ struct sensor_hub_data {
>  	spinlock_t dyn_callback_lock;
>  	struct mfd_cell *hid_sensor_hub_client_devs;
>  	int hid_sensor_client_cnt;
> -	unsigned long quirks;
>  	int ref_cnt;
>  };
>  
> @@ -615,7 +614,6 @@ static int sensor_hub_probe(struct hid_device *hdev,
>  	}
>  
>  	hid_set_drvdata(hdev, sd);
> -	sd->quirks = id->driver_data;
>  
>  	spin_lock_init(&sd->lock);
>  	spin_lock_init(&sd->dyn_callback_lock);

