Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C18DB192E34
	for <lists+linux-iio@lfdr.de>; Wed, 25 Mar 2020 17:28:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgCYQ2S (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Mar 2020 12:28:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36320 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbgCYQ2S (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Mar 2020 12:28:18 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id ABBB928B90C
Subject: Re: [PATCH v6 01/11] platform: chrome: sensorhub: Add FIFO support
To:     Gwendal Grignou <gwendal@chromium.org>, bleung@chromium.org,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200324202736.243314-1-gwendal@chromium.org>
 <20200324202736.243314-2-gwendal@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <399a282a-e6a6-a1ed-26c4-1999008f242d@collabora.com>
Date:   Wed, 25 Mar 2020 17:28:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200324202736.243314-2-gwendal@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Gwendal,

Many thanks for sending this series upstream. Just one comment, other than that
looks good to me.

On 24/3/20 21:27, Gwendal Grignou wrote:
> cros_ec_sensorhub registers a listener and query motion sense FIFO,
> spread to iio sensors registers.
> 
> To test, we can use libiio:
> iiod&
> iio_readdev -u ip:localhost -T 10000 -s 25 -b 16 cros-ec-gyro | od -x
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

[snip]

> +/**
> + * cros_ec_sensorhub_ring_handler() - The trigger handler function
> + *
> + * @sensorhub: Sensor Hub object.
> + *
> + * Called by the notifier, process the EC sensor FIFO queue.
> + */
> +static void cros_ec_sensorhub_ring_handler(struct cros_ec_sensorhub *sensorhub)
> +{
> +	struct cros_ec_fifo_info *fifo_info = &sensorhub->fifo_info;
> +	struct cros_ec_dev *ec = sensorhub->ec;
> +	ktime_t fifo_timestamp, current_timestamp;
> +	int i, j, number_data, ret;
> +	unsigned long sensor_mask = 0;
> +	struct ec_response_motion_sensor_data *in;
> +	struct cros_ec_sensors_ring_sample *out, *last_out;
> +
> +	mutex_lock(&sensorhub->cmd_lock);
> +
> +	/* Get FIFO information if there are lost vectors. */
> +	if (fifo_info->info.total_lost) {
> +		/* Need to retrieve the number of lost vectors per sensor */
> +		sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
> +		sensorhub->msg->outsize = 1;
> +		sensorhub->msg->insize =
> +			sizeof(struct ec_response_motion_sense_fifo_info) +
> +			sizeof(u16) * CROS_EC_SENSOR_MAX;
> +
> +		if (cros_ec_cmd_xfer_status(ec->ec_dev, sensorhub->msg) < 0)
> +			goto error;
> +
> +		memcpy(fifo_info, &sensorhub->resp->fifo_info,
> +		       sizeof(*fifo_info));
> +

Smatch is reporting:

cros_ec_sensorhub_ring_handler() error: memcpy() '&sensorhub->resp->fifo_info'
too small (10 vs 42)

Is it fine and safe to copy always the 42 bytes? I suspect that we should only
copy the number of lost events, total_lost , not always the maximum (16). Or the
EC is always sending the full array (16 bytes)?

Thanks,
Enric

