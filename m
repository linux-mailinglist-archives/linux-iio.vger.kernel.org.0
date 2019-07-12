Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37B9672EE
	for <lists+linux-iio@lfdr.de>; Fri, 12 Jul 2019 18:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726945AbfGLQDo (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Jul 2019 12:03:44 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51064 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfGLQDo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Jul 2019 12:03:44 -0400
Received: from linux.home (2a01cb0c80061e007f541addd69f0d47.ipv6.abo.wanadoo.fr [IPv6:2a01:cb0c:8006:1e00:7f54:1add:d69f:d47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 6D3C828BBDA;
        Fri, 12 Jul 2019 17:03:41 +0100 (BST)
Date:   Fri, 12 Jul 2019 18:03:38 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Vitor Soares <Vitor.Soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-kernel@vger.kernel.org, lorenzo@kernel.org,
        gregkh@linuxfoundation.org, rafael@kernel.org,
        bbrezillon@kernel.org, Joao.Pinto@synopsys.com
Subject: Re: [PATCH v4 2/3] i3c: move i3c_device_match_id to device.c and
 export it
Message-ID: <20190712180338.47b50e9f@linux.home>
In-Reply-To: <debadccffef84c541601a97162ac656cd7c58478.1562931742.git.vitor.soares@synopsys.com>
References: <cover.1562931742.git.vitor.soares@synopsys.com>
        <debadccffef84c541601a97162ac656cd7c58478.1562931742.git.vitor.soares@synopsys.com>
Organization: Collabora
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Jul 2019 13:53:29 +0200
Vitor Soares <Vitor.Soares@synopsys.com> wrote:

> The i3c device driver needs the i3c_device_id table.

"Some I3C device drivers need to know which entry matches the
i3c_device object passed to the probe function" 

> Lets move  to device.c and export it to be used.

"Let's move i3c_device_match_id() to device.c and export it so it can be
used by drivers."

> 
> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
> Changes in v4:
>   None
> 
> Changes in v3:
>   Remove i3c_get_device_id
>   Move i3c_device_match_id from drivers/i3c/master.c to drivers/i3c/device.c
>   Export i3c_device_match_id
> 
> Changes in v2:
>   move this function to drivers/i3c/device.c
> 
>  drivers/i3c/device.c       | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/i3c/master.c       | 45 ---------------------------------------------
>  include/linux/i3c/device.h |  4 ++++
>  3 files changed, 50 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/i3c/device.c b/drivers/i3c/device.c
> index 69cc040..383df3b 100644
> --- a/drivers/i3c/device.c
> +++ b/drivers/i3c/device.c
> @@ -200,6 +200,52 @@ struct i3c_device *dev_to_i3cdev(struct device *dev)
>  }
>  EXPORT_SYMBOL_GPL(dev_to_i3cdev);
>  

You're missing a kerneldoc here.

> +const struct i3c_device_id *
> +i3c_device_match_id(struct i3c_device *i3cdev,
> +		    const struct i3c_device_id *id_table)
> +{
> +	struct i3c_device_info devinfo;
> +	const struct i3c_device_id *id;
> +
> +	i3c_device_get_info(i3cdev, &devinfo);
> +
> +	/*
> +	 * The lower 32bits of the provisional ID is just filled with a random
> +	 * value, try to match using DCR info.
> +	 */
> +	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> +		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
> +		u16 part = I3C_PID_PART_ID(devinfo.pid);
> +		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
> +
> +		/* First try to match by manufacturer/part ID. */
> +		for (id = id_table; id->match_flags != 0; id++) {
> +			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> +			    I3C_MATCH_MANUF_AND_PART)
> +				continue;
> +
> +			if (manuf != id->manuf_id || part != id->part_id)
> +				continue;
> +
> +			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> +			    ext_info != id->extra_info)
> +				continue;
> +
> +			return id;
> +		}
> +	}
> +
> +	/* Fallback to DCR match. */
> +	for (id = id_table; id->match_flags != 0; id++) {
> +		if ((id->match_flags & I3C_MATCH_DCR) &&
> +		    id->dcr == devinfo.dcr)
> +			return id;
> +	}
> +
> +	return NULL;
> +}
> +EXPORT_SYMBOL_GPL(i3c_device_match_id);
> +
>  /**
>   * i3c_driver_register_with_owner() - register an I3C device driver
>   *
> diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> index 5f4bd52..7667f84 100644
> --- a/drivers/i3c/master.c
> +++ b/drivers/i3c/master.c
> @@ -270,51 +270,6 @@ static const struct device_type i3c_device_type = {
>  	.uevent = i3c_device_uevent,
>  };
>  
> -static const struct i3c_device_id *
> -i3c_device_match_id(struct i3c_device *i3cdev,
> -		    const struct i3c_device_id *id_table)
> -{
> -	struct i3c_device_info devinfo;
> -	const struct i3c_device_id *id;
> -
> -	i3c_device_get_info(i3cdev, &devinfo);
> -
> -	/*
> -	 * The lower 32bits of the provisional ID is just filled with a random
> -	 * value, try to match using DCR info.
> -	 */
> -	if (!I3C_PID_RND_LOWER_32BITS(devinfo.pid)) {
> -		u16 manuf = I3C_PID_MANUF_ID(devinfo.pid);
> -		u16 part = I3C_PID_PART_ID(devinfo.pid);
> -		u16 ext_info = I3C_PID_EXTRA_INFO(devinfo.pid);
> -
> -		/* First try to match by manufacturer/part ID. */
> -		for (id = id_table; id->match_flags != 0; id++) {
> -			if ((id->match_flags & I3C_MATCH_MANUF_AND_PART) !=
> -			    I3C_MATCH_MANUF_AND_PART)
> -				continue;
> -
> -			if (manuf != id->manuf_id || part != id->part_id)
> -				continue;
> -
> -			if ((id->match_flags & I3C_MATCH_EXTRA_INFO) &&
> -			    ext_info != id->extra_info)
> -				continue;
> -
> -			return id;
> -		}
> -	}
> -
> -	/* Fallback to DCR match. */
> -	for (id = id_table; id->match_flags != 0; id++) {
> -		if ((id->match_flags & I3C_MATCH_DCR) &&
> -		    id->dcr == devinfo.dcr)
> -			return id;
> -	}
> -
> -	return NULL;
> -}
> -
>  static int i3c_device_match(struct device *dev, struct device_driver *drv)
>  {
>  	struct i3c_device *i3cdev;
> diff --git a/include/linux/i3c/device.h b/include/linux/i3c/device.h
> index 5ecb055..de102e4 100644
> --- a/include/linux/i3c/device.h
> +++ b/include/linux/i3c/device.h
> @@ -188,6 +188,10 @@ static inline struct i3c_driver *drv_to_i3cdrv(struct device_driver *drv)
>  struct device *i3cdev_to_dev(struct i3c_device *i3cdev);
>  struct i3c_device *dev_to_i3cdev(struct device *dev);
>  
> +const struct i3c_device_id *
> +i3c_device_match_id(struct i3c_device *i3cdev,
> +		    const struct i3c_device_id *id_table);
> +
>  static inline void i3cdev_set_drvdata(struct i3c_device *i3cdev,
>  				      void *data)
>  {

