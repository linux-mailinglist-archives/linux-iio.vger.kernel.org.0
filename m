Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E534D1543E8
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2020 13:17:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbgBFMR7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Feb 2020 07:17:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbgBFMR7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Feb 2020 07:17:59 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8210920730;
        Thu,  6 Feb 2020 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580991478;
        bh=FjgGnBgBvon/B65YoGpHoOuV1f02D9RUlOO9st7qV28=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FTqMznmKWf3vacIggfHWN427phyU6z1Y8ILChETefsSYVFiV9gsPPPbiUaHGOs9Zw
         KiDw8ZhL7CP3+C3kiLyX7kH8lVhpiL1cf5z8LNbso5XTSJzp1La2L/3BS9/q/Mtr2y
         3983c72a3WVYM5nAWsH/WJW60ljP0N/LmADYi2Vc=
Date:   Thu, 6 Feb 2020 12:17:53 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH v2 10/17] iio: cros_ec: Use cros_ec_cmd()
Message-ID: <20200206121753.7b809631@archlinux>
In-Reply-To: <20200205190028.183069-11-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
        <20200205190028.183069-11-pmalani@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed,  5 Feb 2020 11:00:13 -0800
Prashant Malani <pmalani@chromium.org> wrote:

> Replace cros_ec_cmd_xfer_status() with cros_ec_cmd()
> which does the message buffer setup and cleanup.
> 
> For one other usage, replace the cros_ec_cmd_xfer_status() call with a
> call to cros_ec_cmd_xfer(), in preparation for the removal of the former
> function.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> 
> Changes in v2:
> - Updated to use new function name and parameter list.
> - Used C99 element setting to initialize param struct.
> - For second usage, replaced cros_ec_cmd_xfer_status() with
>   cros_ec_cmd_xfer() which is functionally similar.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 25 +++++++------------
>  1 file changed, 9 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index d3a3626c7cd834..94e22e7d927631 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -30,24 +30,15 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
>  					     u16 cmd_offset, u16 cmd, u32 *mask)
>  {
>  	int ret;
> -	struct {
> -		struct cros_ec_command msg;
> -		union {
> -			struct ec_params_get_cmd_versions params;
> -			struct ec_response_get_cmd_versions resp;
> -		};
> -	} __packed buf = {
> -		.msg = {
> -			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> -			.insize = sizeof(struct ec_response_get_cmd_versions),
> -			.outsize = sizeof(struct ec_params_get_cmd_versions)
> -			},
> -		.params = {.cmd = cmd}
> +	struct ec_params_get_cmd_versions params = {
> +		.cmd = cmd,
>  	};
> +	struct ec_response_get_cmd_versions resp = {0};
>  
> -	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> +			  &params, sizeof(params), &resp, sizeof(resp), NULL);
>  	if (ret >= 0)
> -		*mask = buf.resp.version_mask;
> +		*mask = resp.version_mask;
>  	return ret;
>  }
>  
> @@ -171,9 +162,11 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  
>  	memcpy(state->msg->data, &state->param, sizeof(state->param));
>  
> -	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +	ret = cros_ec_cmd_xfer(state->ec, state->msg);
>  	if (ret < 0)
>  		return ret;
> +	else if (state->msg->result != EC_RES_SUCCESS)
> +		return -EPROTO;
>  
>  	if (ret &&
>  	    state->resp != (struct ec_response_motion_sense *)state->msg->data)

