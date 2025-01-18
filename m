Return-Path: <linux-iio+bounces-14462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E402EA15E18
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 17:34:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E51418869DD
	for <lists+linux-iio@lfdr.de>; Sat, 18 Jan 2025 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63515197A92;
	Sat, 18 Jan 2025 16:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHWEurJi"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 236E015CD78
	for <linux-iio@vger.kernel.org>; Sat, 18 Jan 2025 16:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737218041; cv=none; b=jsPxj0HZsku5diTZgVpJS8yoYBIIpYtssMN/p3qB6SqiE1XehT9tHZc3k67VZ0jvqnuGIG+xMsFqHQxRaITa5GqE/Y2h9EciSeXlyRZmiMA8VxYRKmQrCeydbiVapw/wNvGudyJVJS5mSne42H5YkmYTcUXwYOffARMRxC2bLMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737218041; c=relaxed/simple;
	bh=kYRzdjCBW9hm8F3TBsAhdjJ7x0TlgRoIHA03ypLqnp8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2R+Qr/lhbuwiAluYn+ZurezGBtsFiHable9T/REhH5Tk9VQOJ0nrz+0xk/z4WZDGqpJED4zEyl3HOmb/0VdPc7LUMWBSPp14QIi+L9gpv6lyNlQn0WjDYui8th+/PN+33I5OTLsYnH8n3LdTLdhJwZ4HQhIA0fKNdsXkabZfpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHWEurJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD385C4CED1;
	Sat, 18 Jan 2025 16:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737218040;
	bh=kYRzdjCBW9hm8F3TBsAhdjJ7x0TlgRoIHA03ypLqnp8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHWEurJih0OvjrLSh4ovqLmgEYYNj5Jte9Cpnfj3y2TJQCvCzEv1zPmEPVLmgs8Oz
	 5R3AHkEUFm6FX/ZzKO03MGS9KVIv6AcpDuHfhLTBuNASh+a/t7cRrPmNRF9ifyqh1y
	 XX2DQ4UDy5oDU3v6hO+Drr6HUinZNsmYxFQvshsZm0VRd4VEtgBKdjUV9EHepHHRT8
	 AJziox6wTqejzI9f80TIUCTaxZQFjRFloNywjQlWbjRbygWcpKO99r68MvnKsuEeCD
	 Z342VzQiKzkSu1KBtAx06CB7EDxlKq8qsrbqUI177dNlZ0loxc0GfI+poj1AoIl4Dq
	 ecMSjlFuFEEMg==
Date: Sat, 18 Jan 2025 16:33:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gwendal Grignou <gwendal@chromium.org>
Cc: tzungbi@kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v3] iio: cros_ec: Trace EC sensors command
Message-ID: <20250118162748.6badf0ab@jic23-huawei>
In-Reply-To: <20250117230136.2237346-1-gwendal@chromium.org>
References: <20250117230136.2237346-1-gwendal@chromium.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jan 2025 15:01:36 -0800
Gwendal Grignou <gwendal@chromium.org> wrote:

> For debugging, add tracing for EC_CMD_MOTION_SENSE_CMD command:
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

I briefly applied this, but...

[jic23@jic23-huawei iio]$ make LOCALVERSION= W=1 -j12  C=1
mkdir -p /home/jic23/src/kernel/iio/tools/objtool && make O=/home/jic23/src/kernel/iio subdir=tools/objtool --no-print-directory -C objtool 
  CALL    scripts/checksyscalls.sh
  INSTALL libsubcmd_headers
  CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.o
  CC [M]  drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.o
In file included from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h:56,
                 from drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c:32:
./include/trace/define_trace.h:106:42: fatal error: ./cros_ec_sensors_trace.h: No such file or directory
  106 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^

Despite dealing with trace points a lot in the day job
I still find them hard to actually add to a subsystem because
of fun things like this one. 

Jonathan

> ---
> Changes from v2 (https://patchwork.kernel.org/patch/13942819/):
> - Improve casting
> - Add intent of the patch in commit message.
> Changes from v1 (https://patchwork.kernel.org/patch/13942368/):
> - fix merging issue with iio.git/togreg.
> 
>  drivers/iio/common/cros_ec_sensors/Makefile   |  3 +-
>  .../cros_ec_sensors/cros_ec_sensors_core.c    |  9 ++-
>  .../cros_ec_sensors/cros_ec_sensors_trace.c   | 32 +++++++++++
>  .../cros_ec_sensors/cros_ec_sensors_trace.h   | 56 +++++++++++++++++++
>  4 files changed, 96 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
>  create mode 100644 drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/Makefile b/drivers/iio/common/cros_ec_sensors/Makefile
> index e0a33ab66d21a..c358fa0328abd 100644
> --- a/drivers/iio/common/cros_ec_sensors/Makefile
> +++ b/drivers/iio/common/cros_ec_sensors/Makefile
> @@ -3,6 +3,7 @@
>  # Makefile for sensors seen through the ChromeOS EC sensor hub.
>  #
>  
> -obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros_ec_sensors_core.o
> +cros-ec-sensors-core-objs += cros_ec_sensors_core.o cros_ec_sensors_trace.o
> +obj-$(CONFIG_IIO_CROS_EC_SENSORS_CORE) += cros-ec-sensors-core.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS) += cros_ec_sensors.o
>  obj-$(CONFIG_IIO_CROS_EC_SENSORS_LID_ANGLE) += cros_ec_lid_angle.o
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 9fc71a73caa12..7751d6f69b124 100644
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
> @@ -413,6 +415,7 @@ EXPORT_SYMBOL_GPL(cros_ec_sensors_core_register);
>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  				 u16 opt_length)
>  {
> +	struct ec_response_motion_sense *resp = (struct ec_response_motion_sense *)state->msg->data;
>  	int ret;
>  
>  	if (opt_length)
> @@ -423,12 +426,12 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  	memcpy(state->msg->data, &state->param, sizeof(state->param));
>  
>  	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +	trace_cros_ec_motion_host_cmd(&state->param, resp, ret);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (ret &&
> -	    state->resp != (struct ec_response_motion_sense *)state->msg->data)
> -		memcpy(state->resp, state->msg->data, ret);
> +	if (ret && state->resp != resp)
> +		memcpy(state->resp, resp, ret);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
> new file mode 100644
> index 0000000000000..c4db949fa7750
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0
> +// Trace events for the ChromeOS Embedded Controller
> +//
> +// Copyright 2025 Google LLC.
> +
> +#define TRACE_SYMBOL(a) {a, #a}
> +
> +// Generate the list using the following script:
> +// sed -n 's/^.*\(MOTIONSENSE_CMD.*\) = .*,$/\tTRACE_SYMBOL(\1), \\/p' include/linux/platform_data/cros_ec_commands.h
> +#define MOTIONSENSE_CMDS \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_DUMP), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_INFO), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_EC_RATE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_ODR), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_RANGE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_KB_WAKE_ANGLE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_DATA), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_INFO), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_FLUSH), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_READ), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_PERFORM_CALIB), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_OFFSET), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_LIST_ACTIVITIES), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SET_ACTIVITY), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_LID_ANGLE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_FIFO_INT_ENABLE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SPOOF), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_TABLET_MODE_LID_ANGLE), \
> +	TRACE_SYMBOL(MOTIONSENSE_CMD_SENSOR_SCALE)
> +
> +#define CREATE_TRACE_POINTS
> +#include "cros_ec_sensors_trace.h"
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
> new file mode 100644
> index 0000000000000..61853e410e96c
> --- /dev/null
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_trace.h
> @@ -0,0 +1,56 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Trace events for the ChromeOS Embedded Controller
> + *
> + * Copyright 2025 Google LLC.
> + */
> +
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM cros_ec
> +
> +#if !defined(_CROS_EC_SENSORS_TRACE_H_) || defined(TRACE_HEADER_MULTI_READ)
> +#define _CROS_EC_SENSORS_TRACE_H_
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(cros_ec_motion_host_cmd,
> +	    TP_PROTO(struct ec_params_motion_sense *param,
> +		     struct ec_response_motion_sense *resp,
> +		     int retval),
> +	    TP_ARGS(param, resp, retval),
> +	    TP_STRUCT__entry(__field(uint8_t, cmd)
> +			     __field(uint8_t, sensor_id)
> +			     __field(uint32_t, data)
> +			     __field(int, retval)
> +			     __field(int32_t, ret)
> +	    ),
> +	    TP_fast_assign(__entry->cmd = param->cmd;
> +			   __entry->sensor_id = param->sensor_odr.sensor_num;
> +			   __entry->data = param->sensor_odr.data;
> +			   __entry->retval = retval;
> +			   __entry->ret = retval > 0 ? resp->sensor_odr.ret : -1;
> +	    ),
> +	    TP_printk("%s, id: %d, data: %u, result: %u, return: %d",
> +		      __print_symbolic(__entry->cmd, MOTIONSENSE_CMDS),
> +		      __entry->sensor_id,
> +		      __entry->data,
> +		      __entry->retval,
> +		      __entry->ret)
> +);
> +
> +#endif /* _CROS_EC_SENSORS_TRACE_H_ */
> +
> +/* this part must be outside header guard */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +
> +#undef TRACE_INCLUDE_FILE
> +#define TRACE_INCLUDE_FILE cros_ec_sensors_trace
> +
> +#include <trace/define_trace.h>


