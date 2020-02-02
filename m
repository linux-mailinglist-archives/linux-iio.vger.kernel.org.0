Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7365B14FC7A
	for <lists+linux-iio@lfdr.de>; Sun,  2 Feb 2020 10:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbgBBJns (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Feb 2020 04:43:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:48404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbgBBJns (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 2 Feb 2020 04:43:48 -0500
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7386020679;
        Sun,  2 Feb 2020 09:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580636627;
        bh=EYnP/SHj2gpLPkJ+FZsF45R0Ky7pbHvS/PbRHT9UwUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cakVawf/poqHSYOL9ydo2KqPubVXeEz1/P/uE2X3ymKdETd4WRIEx0VbaZvQ1Wzpf
         PHzDfqXG0EnVR5jCysZpEY+2c262svf1REPmo6mWshdc27EwvjcjtjCCaNpciMDC1r
         StC3TTPnZYTRbl4MGpGuoVjfcFEd9szwKqejv688=
Date:   Sun, 2 Feb 2020 09:43:42 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Fabien Lahoudere <fabien.lahoudere@collabora.com>,
        Nick Vaccaro <nvaccaro@chromium.org>,
        linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS)
Subject: Re: [PATCH 10/17] iio: cros_ec: Use cros_ec_send_cmd_msg()
Message-ID: <20200202094342.108849ab@archlinux>
In-Reply-To: <20200130203106.201894-11-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
        <20200130203106.201894-11-pmalani@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 30 Jan 2020 12:30:54 -0800
Prashant Malani <pmalani@chromium.org> wrote:

> Replace cros_ec_cmd_xfer_status() with cros_ec_send_cmd_msg()
> which does the message buffer setup and cleanup.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>

In a series like this, make sure that patch 1 with the actual code being
pulled out is sent to everyone.  Looking at what we have here, this
doesn't seem to fit well at all for one case, and I'm can't say the
other case shows much advantage either.

Jonathan

> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 43 +++++++++----------
>  1 file changed, 21 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 81a7f692de2f37..f92032e97a84d7 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -31,24 +31,16 @@ static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
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
> -	};
> -
> -	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +	struct ec_params_get_cmd_versions params = {0};
> +	struct ec_response_get_cmd_versions resp = {0};
> +
> +	params.cmd = cmd;
Use c99 element setting to set this directly rather than zeroing
explicitly then setting the element.

Something like.

struct ec_params_get_cmde_versions params = {
	.cmd = cmd;
};

> +	ret = cros_ec_send_cmd_msg(ec_dev, 0,
> +				   EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> +				   &params, sizeof(params),
> +				   &resp, sizeof(resp));
>  	if (ret >= 0)
> -		*mask = buf.resp.version_mask;
> +		*mask = resp.version_mask;
>  	return ret;
>  }
>  
> @@ -164,15 +156,22 @@ int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  				 u16 opt_length)
>  {
>  	int ret;
> +	struct cros_ec_command *msg = state->msg;

With this change the code becomes less readable and needs a comment to explain
why it is doing something odd.   Either you need to figure out how to
make this fit properly such that the comment is not needed, or leave
the code alone.

>  
>  	if (opt_length)
> -		state->msg->insize = min(opt_length, state->ec->max_response);
> +		msg->insize = min(opt_length, state->ec->max_response);
>  	else
> -		state->msg->insize = state->ec->max_response;
> +		msg->insize = state->ec->max_response;
>  
> -	memcpy(state->msg->data, &state->param, sizeof(state->param));
> -
> -	ret = cros_ec_cmd_xfer_status(state->ec, state->msg);
> +	/*
> +	 * In order to not disrupt the usage of struct cros_ec_command *msg,
> +	 * which is defined higher up in the call stack, we pass in its
> +	 * members to cros_ec_send_cmd_msg, instead of removing it at all
> +	 * calling locations.
> +	 */
> +	ret = cros_ec_send_cmd_msg(state->ec, msg->version, msg->command,
> +				   &state->param, sizeof(state->param),
> +				   msg->data, msg->insize);
>  	if (ret < 0)
>  		return ret;
>  

