Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D24E6801F
	for <lists+linux-iio@lfdr.de>; Sun, 14 Jul 2019 18:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbfGNQTm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Jul 2019 12:19:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:52104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728106AbfGNQTm (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jul 2019 12:19:42 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78C9F20C01;
        Sun, 14 Jul 2019 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563121180;
        bh=TVxBVjOA00hKVNaSlq096EK5GPPxbdmRVnbjXDeVNMY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a4lyDsOcgUrk5m4ywtq75dKQlLM4Txs3PNUtH93f7vVqH1Gaj807jiz4oxH5cCwv7
         LE30ZTsz/kaiqkANkKrddFXirvSf9pX5C9cIW8nY/GBcgGOXpP52Oz02uWa4cwcQ6a
         YW7Kvup9f1Ic+Lho8yJhE2Qh8qlZeQZZLOkL9x5I=
Date:   Sun, 14 Jul 2019 17:19:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Fabien Lahoudere <fabien.lahoudere@collabora.com>
Cc:     gwendal@chromium.org, egranata@chromium.org, kernel@collabora.com,
        Nick Vaccaro <nvaccaro@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] iio: common: cros_ec_sensors: determine protocol
 version
Message-ID: <20190714171935.6a67cfb2@archlinux>
In-Reply-To: <3fc3e1e606bc1e5478fca0888f9c005df6e52745.1562056868.git.fabien.lahoudere@collabora.com>
References: <cover.1562056868.git.fabien.lahoudere@collabora.com>
        <3fc3e1e606bc1e5478fca0888f9c005df6e52745.1562056868.git.fabien.lahoudere@collabora.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  2 Jul 2019 10:49:38 +0200
Fabien Lahoudere <fabien.lahoudere@collabora.com> wrote:

> This patch adds a function to determine which version of the
> protocol is used to communicate with EC.
> 
> Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.com>
> Signed-off-by: Nick Vaccaro <nvaccaro@chromium.org>
> Reviewed-by: Gwendal Grignou <gwendal@chromium.org>
> Tested-by: Gwendal Grignou <gwendal@chromium.org>
> Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
There are so many different series flying around for this driver that
I have given up trying to figure out if I should be picking some of
them up.  I'll ack them on the assumption they'll all go together,
but feel free to ping me if you want me to pick some of them up
through IIO.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,

Jonathan

> ---
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 36 ++++++++++++++++++-
>  1 file changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 130362ca421b..81111af8a167 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -25,6 +25,31 @@ static char *cros_ec_loc[] = {
>  	[MOTIONSENSE_LOC_MAX] = "unknown",
>  };
>  
> +static int cros_ec_get_host_cmd_version_mask(struct cros_ec_device *ec_dev,
> +					     u16 cmd_offset, u16 cmd, u32 *mask)
> +{
> +	int ret;
> +	struct {
> +		struct cros_ec_command msg;
> +		union {
> +			struct ec_params_get_cmd_versions params;
> +			struct ec_response_get_cmd_versions resp;
> +		};
> +	} __packed buf = {
> +		.msg = {
> +			.command = EC_CMD_GET_CMD_VERSIONS + cmd_offset,
> +			.insize = sizeof(struct ec_response_get_cmd_versions),
> +			.outsize = sizeof(struct ec_params_get_cmd_versions)
> +			},
> +		.params = {.cmd = cmd}
> +	};
> +
> +	ret = cros_ec_cmd_xfer_status(ec_dev, &buf.msg);
> +	if (ret >= 0)
> +		*mask = buf.resp.version_mask;
> +	return ret;
> +}
> +
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -33,6 +58,8 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  	struct cros_ec_sensors_core_state *state = iio_priv(indio_dev);
>  	struct cros_ec_dev *ec = dev_get_drvdata(pdev->dev.parent);
>  	struct cros_ec_sensor_platform *sensor_platform = dev_get_platdata(dev);
> +	u32 ver_mask;
> +	int ret;
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> @@ -47,8 +74,15 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  
>  	mutex_init(&state->cmd_lock);
>  
> +	ret = cros_ec_get_host_cmd_version_mask(state->ec,
> +						ec->cmd_offset,
> +						EC_CMD_MOTION_SENSE_CMD,
> +						&ver_mask);
> +	if (ret < 0)
> +		return ret;
> +
>  	/* Set up the host command structure. */
> -	state->msg->version = 2;
> +	state->msg->version = fls(ver_mask) - 1;
>  	state->msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
>  	state->msg->outsize = sizeof(struct ec_params_motion_sense);
>  

