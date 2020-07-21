Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 491DB227ED9
	for <lists+linux-iio@lfdr.de>; Tue, 21 Jul 2020 13:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728941AbgGUL3H (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 21 Jul 2020 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgGUL3H (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 21 Jul 2020 07:29:07 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0385EC061794;
        Tue, 21 Jul 2020 04:29:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C07BC29724F
Subject: Re: [PATCH v2 4/4] platform/chrome: cros_ec_proto: Convert EC error
 codes to Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
References: <20200720202243.180230-1-linux@roeck-us.net>
 <20200720202243.180230-5-linux@roeck-us.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <401aec54-ff21-7e0f-85dc-e32435df2672@collabora.com>
Date:   Tue, 21 Jul 2020 13:29:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200720202243.180230-5-linux@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guenter,

Thank you for work on this. Cc'ing Gwendal as he has a deep knowledge of the EC
and their errors.

On 20/7/20 22:22, Guenter Roeck wrote:
> The EC reports a variety of error codes. Most of those, with the exception
> of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> error code gets lost. In cros_ec_cmd_xfer_status(), convert all EC errors
> to Linux error codes to report a more meaningful error to the caller to aid
> debugging.
> 
> Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> Cc: Prashant Malani <pmalani@chromium.org>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: No change
> 
> Notes:
>     I would welcome feedback on the error code translations.
>     Can we do better ?
> 
>     -ENOTSUPP is not a recommended error code, and checkpatch complains
>     about it. It is used in existing code, so I did not change it, but it
>     might be worthwhile exploring if we can find a better error code to
>     report "version not supported". Possible candidates might be EPROTOTYPE,
>     ENOPROTOOPT, EPROTONOSUPPORT, EPFNOSUPPORT, or EAFNOSUPPORT. I don't
>     see a direct match, but NFS reports -EPROTONOSUPPORT for unsupported
>     protocol versions.
> 
>  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
>  1 file changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index 3e745e0fe092..10aa9e483d35 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
>  }
>  EXPORT_SYMBOL(cros_ec_cmd_xfer);
>  
> +static const int cros_ec_error_map[] = {
> +	[EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> +	[EC_RES_ERROR] = -EIO,

nit -EREMOTEIO? To make explicit that the error is "remote" from the host.
Although -EIO seems to be more generic.

> +	[EC_RES_INVALID_PARAM] = -EINVAL,
> +	[EC_RES_ACCESS_DENIED] = -EACCES,
> +	[EC_RES_INVALID_RESPONSE] = -EPROTO,
> +	[EC_RES_INVALID_VERSION] = -ENOTSUPP,

+1 for EPROTONOSUPPORT to match with EC_RES_INVALID_VERSION

> +	[EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> +	[EC_RES_IN_PROGRESS] = -EINPROGRESS,
> +	[EC_RES_UNAVAILABLE] = -ENODATA,
> +	[EC_RES_TIMEOUT] = -ETIMEDOUT,
> +	[EC_RES_OVERFLOW] = -EOVERFLOW,
> +	[EC_RES_INVALID_HEADER] = -EBADR,
> +	[EC_RES_REQUEST_TRUNCATED] = -EBADR,
> +	[EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> +	[EC_RES_BUS_ERROR] = -EFAULT,
> +	[EC_RES_BUSY] = -EBUSY,

Although the name matches, I'm wondering if we should use -EAGAIN instead as per
EC documentation:

  EC_RES_BUSY - Up but too busy. Should retry.

hmm, however, for the audio codec, for example, this seems to have a slightly
different meaning and retry is not what we want, so let's do direct translation
and stay with -EBUSY.

> +	[EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> +	[EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> +	[EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> +	[EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> +};
> +
>  /**
>   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
>   * @ec_dev: EC device.
> @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
>   *
>   * Return:
>   * >=0 - The number of bytes transferred
> - * -ENOTSUPP - Operation not supported
> - * -EPROTO - Protocol error
> + * <0 - Linux error code
>   */
>  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  			    struct cros_ec_command *msg)
> @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
>  	ret = cros_ec_cmd_xfer(ec_dev, msg);
>  	if (ret < 0) {
>  		dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> -	} else if (msg->result == EC_RES_INVALID_VERSION) {
> -		dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> -			msg->result);
> -		return -ENOTSUPP;
>  	} else if (msg->result != EC_RES_SUCCESS) {
> -		dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> -		return -EPROTO;
> +		if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> +			ret = cros_ec_error_map[msg->result];
> +		else
> +			ret = -EPROTO;
> +		dev_dbg(ec_dev->dev, "Command result (err: %d [%d])\n", msg->result, ret);
>  	}
>  
>  	return ret;
> 
