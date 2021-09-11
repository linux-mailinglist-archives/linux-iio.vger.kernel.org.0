Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE73340791D
	for <lists+linux-iio@lfdr.de>; Sat, 11 Sep 2021 17:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231894AbhIKPkg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Sep 2021 11:40:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:51410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230265AbhIKPkg (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 11 Sep 2021 11:40:36 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03B70610F8;
        Sat, 11 Sep 2021 15:39:21 +0000 (UTC)
Date:   Sat, 11 Sep 2021 16:42:53 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Karol Wrona <k.wrona@samsung.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: ssp_sensors: add more range checking in
 ssp_parse_dataframe()
Message-ID: <20210911164253.260be729@jic23-huawei>
In-Reply-To: <20210909091336.GA26312@kili>
References: <20210909091336.GA26312@kili>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, 9 Sep 2021 12:13:36 +0300
Dan Carpenter <dan.carpenter@oracle.com> wrote:

> The "idx" is validated at the start of the loop but it gets incremented
> during the iteration so it needs to be checked again.
> 
> Fixes: 50dd64d57eee ("iio: common: ssp_sensors: Add sensorhub driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

This is only a fix if we assume that the len value check is there
as a protection against buffer overrun rather than as a termination condition
that occurs when parsing a valid record.

There is more paranoid checking in ssp_print_mc_debug() so it seems we aren't assuming
valid data in there at least.

Still is this perhaps a case of hardening rather than a fix or am I missing something?

As an aside, if that ssp_print_mcu_debug() reads a negative char it is then
returned directly so we get a random small negative number as the error code which
isn't going to be very useful.

Jonathan


> ---
>  drivers/iio/common/ssp_sensors/ssp_spi.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/common/ssp_sensors/ssp_spi.c b/drivers/iio/common/ssp_sensors/ssp_spi.c
> index 4864c38b8d1c..387551eac184 100644
> --- a/drivers/iio/common/ssp_sensors/ssp_spi.c
> +++ b/drivers/iio/common/ssp_sensors/ssp_spi.c
> @@ -273,6 +273,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  	for (idx = 0; idx < len;) {
>  		switch (dataframe[idx++]) {
>  		case SSP_MSG2AP_INST_BYPASS_DATA:
> +			if (idx >= len)
> +				return -EPROTO;
>  			sd = dataframe[idx++];
>  			if (sd < 0 || sd >= SSP_SENSOR_MAX) {
>  				dev_err(SSP_DEV,
> @@ -282,10 +284,13 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  
>  			if (indio_devs[sd]) {
>  				spd = iio_priv(indio_devs[sd]);
> -				if (spd->process_data)
> +				if (spd->process_data) {
> +					if (idx >= len)
> +						return -EPROTO;
>  					spd->process_data(indio_devs[sd],
>  							  &dataframe[idx],
>  							  data->timestamp);
> +				}
>  			} else {
>  				dev_err(SSP_DEV, "no client for frame\n");
>  			}
> @@ -293,6 +298,8 @@ static int ssp_parse_dataframe(struct ssp_data *data, char *dataframe, int len)
>  			idx += ssp_offset_map[sd];
>  			break;
>  		case SSP_MSG2AP_INST_DEBUG_DATA:
> +			if (idx >= len)
> +				return -EPROTO;
>  			sd = ssp_print_mcu_debug(dataframe, &idx, len);
>  			if (sd) {
>  				dev_err(SSP_DEV,

