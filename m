Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B884034CEFF
	for <lists+linux-iio@lfdr.de>; Mon, 29 Mar 2021 13:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhC2Lat (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Mar 2021 07:30:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:56166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230322AbhC2Lad (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 29 Mar 2021 07:30:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E4B361585;
        Mon, 29 Mar 2021 11:30:30 +0000 (UTC)
Date:   Mon, 29 Mar 2021 12:30:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-input@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 23/25] HID: hid-sensor-hub: Move 'hsdev' description to
 correct struct definition
Message-ID: <20210329123020.10250228@jic23-huawei>
In-Reply-To: <20210326143458.508959-25-lee.jones@linaro.org>
References: <20210326143458.508959-1-lee.jones@linaro.org>
        <20210326143458.508959-25-lee.jones@linaro.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 26 Mar 2021 14:34:56 +0000
Lee Jones <lee.jones@linaro.org> wrote:

> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/hid/hid-sensor-hub.c:54: warning: Function parameter or member 'hsdev' not described in 'hid_sensor_hub_callbacks_list'
> 

Perhaps nice to mention that this was a result of

ca2ed12f163b ("HID: hid-sensor-hub: Processing for duplicate physical ids")

> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> Cc: linux-input@vger.kernel.org
> Cc: linux-iio@vger.kernel.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hid/hid-sensor-hub.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
> index 36b6852f75dd5..95cf88f3bafb9 100644
> --- a/drivers/hid/hid-sensor-hub.c
> +++ b/drivers/hid/hid-sensor-hub.c
> @@ -18,7 +18,6 @@
>  
>  /**
>   * struct sensor_hub_data - Hold a instance data for a HID hub device
> - * @hsdev:		Stored hid instance for current hub device.
>   * @mutex:		Mutex to serialize synchronous request.
>   * @lock:		Spin lock to protect pending request structure.
>   * @dyn_callback_list:	Holds callback function
> @@ -41,6 +40,7 @@ struct sensor_hub_data {
>   * struct hid_sensor_hub_callbacks_list - Stores callback list
>   * @list:		list head.
>   * @usage_id:		usage id for a physical device.
> + * @hsdev:		Stored hid instance for current hub device.
>   * @usage_callback:	Stores registered callback functions.
>   * @priv:		Private data for a physical device.
>   */

