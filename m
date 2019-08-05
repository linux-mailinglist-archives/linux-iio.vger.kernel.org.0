Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4E181F91
	for <lists+linux-iio@lfdr.de>; Mon,  5 Aug 2019 16:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbfHEOy1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 5 Aug 2019 10:54:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728043AbfHEOy1 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 5 Aug 2019 10:54:27 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3380E206C1;
        Mon,  5 Aug 2019 14:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565016866;
        bh=UzKav88A7iFYVtoLk8KJjYDlrDokACtTBAAskUdmfSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xPDGnsIPOTwzT3NsSDUSuQUKeNkeo4UjEbPSRmga9tvZXZE5SzNrG+LzxqkmIDmNv
         oPJl2fK8wL27feQkv9PKQqWkxY6+3S33jNxaDDZXHej336DJW+39r2hC3ntCd/af1U
         AjZ1ATmmkd1/B/q2FHVz0P9HNhb/RJX9QQy4heLA=
Date:   Mon, 5 Aug 2019 15:54:20 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chuhong Yuan <hslester96@gmail.com>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: light: si1145: Use device-managed APIs
Message-ID: <20190805155403.3d45b0b5@archlinux>
In-Reply-To: <20190729014301.13402-1-hslester96@gmail.com>
References: <20190729014301.13402-1-hslester96@gmail.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 29 Jul 2019 09:43:01 +0800
Chuhong Yuan <hslester96@gmail.com> wrote:

> Use device-managed APIs to simplify the code.
> The remove functions are redundant now and can
> be deleted.
> 
> Signed-off-by: Chuhong Yuan <hslester96@gmail.com>

Nice little patch, thanks!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan

> ---
> Changes in v2:
>   - Split v1 into two patches.
>   - Use devm_iio_trigger_register in probe_trigger,
>     delete redundant remove_trigger.
>   - Return devm_iio_device_register directly as a
>     minor optimization.
> 
>  drivers/iio/light/si1145.c | 42 +++++---------------------------------
>  1 file changed, 5 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/light/si1145.c b/drivers/iio/light/si1145.c
> index 6579d2418814..982bba0c54e7 100644
> --- a/drivers/iio/light/si1145.c
> +++ b/drivers/iio/light/si1145.c
> @@ -1261,7 +1261,7 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
>  		return ret;
>  	}
>  
> -	ret = iio_trigger_register(trig);
> +	ret = devm_iio_trigger_register(&client->dev, trig);
>  	if (ret)
>  		return ret;
>  
> @@ -1271,16 +1271,6 @@ static int si1145_probe_trigger(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> -static void si1145_remove_trigger(struct iio_dev *indio_dev)
> -{
> -	struct si1145_data *data = iio_priv(indio_dev);
> -
> -	if (data->trig) {
> -		iio_trigger_unregister(data->trig);
> -		data->trig = NULL;
> -	}
> -}
> -
>  static int si1145_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
> @@ -1332,7 +1322,8 @@ static int si1145_probe(struct i2c_client *client,
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, NULL,
> +	ret = devm_iio_triggered_buffer_setup(&client->dev,
> +		indio_dev, NULL,
>  		si1145_trigger_handler, &si1145_buffer_setup_ops);
>  	if (ret < 0)
>  		return ret;
> @@ -1340,23 +1331,12 @@ static int si1145_probe(struct i2c_client *client,
>  	if (client->irq) {
>  		ret = si1145_probe_trigger(indio_dev);
>  		if (ret < 0)
> -			goto error_free_buffer;
> +			return ret;
>  	} else {
>  		dev_info(&client->dev, "no irq, using polling\n");
>  	}
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto error_free_trigger;
> -
> -	return 0;
> -
> -error_free_trigger:
> -	si1145_remove_trigger(indio_dev);
> -error_free_buffer:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return ret;
> +	return devm_iio_device_register(&client->dev, indio_dev);
>  }
>  
>  static const struct i2c_device_id si1145_ids[] = {
> @@ -1371,23 +1351,11 @@ static const struct i2c_device_id si1145_ids[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, si1145_ids);
>  
> -static int si1145_remove(struct i2c_client *client)
> -{
> -	struct iio_dev *indio_dev = i2c_get_clientdata(client);
> -
> -	iio_device_unregister(indio_dev);
> -	si1145_remove_trigger(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -
> -	return 0;
> -}
> -
>  static struct i2c_driver si1145_driver = {
>  	.driver = {
>  		.name   = "si1145",
>  	},
>  	.probe  = si1145_probe,
> -	.remove = si1145_remove,
>  	.id_table = si1145_ids,
>  };
>  

