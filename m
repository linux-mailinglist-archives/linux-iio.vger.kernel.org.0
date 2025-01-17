Return-Path: <linux-iio+bounces-14425-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1E1A15317
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 16:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D81DA1671BC
	for <lists+linux-iio@lfdr.de>; Fri, 17 Jan 2025 15:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 349CD156F3F;
	Fri, 17 Jan 2025 15:47:12 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75A013AA20
	for <linux-iio@vger.kernel.org>; Fri, 17 Jan 2025 15:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737128832; cv=none; b=o5Jc3MysildRtDRcW5cLsG4hwJpTc+Rg6xsMDSOjheXbtq+1+2BDQSmoKNToJCWv08qCadP/8DX9K8hK9FwDAed8JQJMSe14ql+vFGuVsHrqmSwtxLpMDnWCuzhi7VvEm/zkgQrVJp/TngxkycPC2E6lKpWB24mvgDiMKpO7Hhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737128832; c=relaxed/simple;
	bh=wvek18CLq6URvrQqwMv3unuUK7L6HsnAHmiJSzEAysw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lRHVlbPWpvPnzHK8bKfCsBve5IwFsesTODDEPorNE2d2AY/FIvw8IEgx3nz9rBTlE5Ktkw9fcw2NxomLbB6ytwHGO1yZlln4uqkXOQ/7gzd4u1rlZvBuwEsMUX4Vcw1GfEJMkqr7IiateE6CYoMbEKRWn7u7GjISd3mLupmffws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YZPHY3BsQz6K5ls;
	Fri, 17 Jan 2025 23:47:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 520841402CB;
	Fri, 17 Jan 2025 23:47:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 17 Jan
 2025 16:47:06 +0100
Date: Fri, 17 Jan 2025 15:47:05 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Gwendal Grignou <gwendal@chromium.org>
CC: <jic23@kernel.org>, <tzungbi@kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2] iio: cros_ec: Trace EC sensors command
Message-ID: <20250117154705.00006d32@huawei.com>
In-Reply-To: <20250117042059.778637-1-gwendal@chromium.org>
References: <20250117042059.778637-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 16 Jan 2025 20:20:59 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> Add tracing for EC_CMD_MOTION_SENSE_CMD command:
> - decode the name of the subcommand
> - provide internal information for the most common sub-commands:
>   setting range, frequency, EC probing frequency, ...
> - display return status.
> 
> When enabled, the tracing output is similar to:
> /sys/kernel/debug/tracing # echo 1 > events/cros_ec/enable ; echo 1 > tracing_on ; cat trace_pipe | grep MOTIONSENSE_CMD_SENSOR_ODR
>  SensorDeviceImp-814     [003] .....   686.176782: cros_ec_motion_host_cmd: MOTIONSENSE_CMD_SENSOR_ODR, id: 1, data: 200000, result: 4, return: 12500
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
What this is missing is why?

I'm not against adding tracepoints in drivers, but some statement of
the usecase etc would be helpful. If it's debug only that makes
for different requirements than some tool is going to connect to
this stream.

Jonathan


> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 9fc71a73caa12..075196ca804a1 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -23,6 +23,8 @@
>  #include <linux/platform_data/cros_ec_sensorhub.h>
>  #include <linux/platform_device.h>
>  
> +#include "cros_ec_sensors_trace.h"
> +
>  /*
>   * Hard coded to the first device to support sensor fifo.  The EC has a 2048
>   * byte fifo and will trigger an interrupt when fifo is 2/3 full.
> @@ -423,6 +425,7 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  	memcpy(state->msg->data, &state->param, sizeof(state->param));
>  
>  	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +	trace_cros_ec_motion_host_cmd(&state->param, (void *)state->msg->data, ret);

Can we cast to the right type rather than a void *?

>  	if (ret < 0)
>  		return ret;
>  



