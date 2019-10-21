Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09D21DF329
	for <lists+linux-iio@lfdr.de>; Mon, 21 Oct 2019 18:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728018AbfJUQdI (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 21 Oct 2019 12:33:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:41752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727101AbfJUQdI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 21 Oct 2019 12:33:08 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 528D8205ED;
        Mon, 21 Oct 2019 16:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571675586;
        bh=qDPaRx40y17YObQNSDMzSABKHqukVZssvQsf3oQmrg0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hHTkS6DbkZMGdx5b7qC495MnAWe+i8TqnUNgyxmxL3Q3f+/Fz2ud3DsFvlvyjq7My
         3vFlFr3K11VE/TlY2KO4gxfyMAkVMuOdtVlLZLXBr1prImUpwHLhL6qSqsYKBWVwmL
         9kKnFpplSiR5lwkToiNCUBlj1O69pgSxL1Q3knQA=
Date:   Mon, 21 Oct 2019 17:33:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        enric.balletbo@collabora.com, dianders@chromium.org,
        groeck@chromium.org, fabien.lahoudere@collabora.com,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 13/18] iio: cros_ec: Move function description to .c
 file
Message-ID: <20191021173301.3f7b3268@archlinux>
In-Reply-To: <20191021055403.67849-14-gwendal@chromium.org>
References: <20191021055403.67849-1-gwendal@chromium.org>
        <20191021055403.67849-14-gwendal@chromium.org>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, 20 Oct 2019 22:53:58 -0700
Gwendal Grignou <gwendal@chromium.org> wrote:

> To prevent comment rot, move function description to
> cros_ec_sensors_core.c.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
Great thanks.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> New in v2.
> 
>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 69 ++++++++++++++++
>  .../linux/iio/common/cros_ec_sensors_core.h   | 80 -------------------
>  2 files changed, 69 insertions(+), 80 deletions(-)
> 
> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> index 81a7f692de2f3..4acb8b7310d43 100644
> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
> @@ -83,6 +83,14 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>  	}
>  }
>  
> +/**
> + * cros_ec_sensors_core_init() - basic initialization of the core structure
> + * @pdev:		platform device created for the sensors
> + * @indio_dev:		iio device structure of the device
> + * @physical_device:	true if the device refers to a physical device
> + *
> + * Return: 0 on success, -errno on failure.
> + */
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev,
>  			      bool physical_device)
> @@ -160,6 +168,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>  
> +/**
> + * cros_ec_motion_send_host_cmd() - send motion sense host command
> + * @st:		pointer to state information for device
> + * @opt_length:	optional length to reduce the response size, useful on the data
> + *		path. Otherwise, the maximal allowed response size is used
> + *
> + * When called, the sub-command is assumed to be set in param->cmd.
> + *
> + * Return: 0 on success, -errno on failure.
> + */
>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>  				 u16 opt_length)
>  {
> @@ -422,6 +440,14 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_read_lpc);
>  
> +/**
> + * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
> + * @indio_dev:	pointer to IIO device
> + * @scan_mask:	bitmap of the sensor indices to scan
> + * @data:	location to store data
> + *
> + * Return: 0 on success, -errno on failure.
> + */
>  int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
>  			     unsigned long scan_mask, s16 *data)
>  {
> @@ -446,6 +472,18 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
>  
> +/**
> + * cros_ec_sensors_capture() - the trigger handler function
> + * @irq:	the interrupt number.
> + * @p:		a pointer to the poll function.
> + *
> + * On a trigger event occurring, if the pollfunc is attached then this
> + * handler is called as a threaded interrupt (and hence may sleep). It
> + * is responsible for grabbing data from the device and pushing it into
> + * the associated buffer.
> + *
> + * Return: IRQ_HANDLED
> + */
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
> @@ -481,6 +519,16 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
>  
> +/**
> + * cros_ec_sensors_core_read() - function to request a value from the sensor
> + * @st:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @val:	will contain one element making up the returned value
> + * @val2:	will contain another element making up the returned value
> + * @mask:	specifies which values to be requested
> + *
> + * Return:	the type of value returned by the device
> + */
>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			  struct iio_chan_spec const *chan,
>  			  int *val, int *val2, long mask)
> @@ -521,6 +569,17 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
>  
> +/**
> + * cros_ec_sensors_core_read_avail() - get available values
> + * @indio_dev:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @vals:	list of available values
> + * @type:	type of data returned
> + * @length:	number of data returned in the array
> + * @mask:	specifies which values to be requested
> + *
> + * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
> + */
>  int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec const *chan,
>  				    const int **vals,
> @@ -542,6 +601,16 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
>  
> +/**
> + * cros_ec_sensors_core_write() - function to write a value to the sensor
> + * @st:		pointer to state information for device
> + * @chan:	channel specification structure table
> + * @val:	first part of value to write
> + * @val2:	second part of value to write
> + * @mask:	specifies which values to write
> + *
> + * Return:	the type of value returned by the device
> + */
>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask)
> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
> index bb331e6356a9c..0af918978f975 100644
> --- a/include/linux/iio/common/cros_ec_sensors_core.h
> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
> @@ -79,95 +79,25 @@ struct cros_ec_sensors_core_state {
>  	int frequencies[3];
>  };
>  
> -/**
> - * cros_ec_sensors_read_lpc() - retrieve data from EC shared memory
> - * @indio_dev:	pointer to IIO device
> - * @scan_mask:	bitmap of the sensor indices to scan
> - * @data:	location to store data
> - *
> - * This is the safe function for reading the EC data. It guarantees that the
> - * data sampled was not modified by the EC while being read.
> - *
> - * Return: 0 on success, -errno on failure.
> - */
>  int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
>  			     s16 *data);
>  
> -/**
> - * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
> - * @indio_dev:	pointer to IIO device
> - * @scan_mask:	bitmap of the sensor indices to scan
> - * @data:	location to store data
> - *
> - * Return: 0 on success, -errno on failure.
> - */
>  int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
>  			     s16 *data);
>  
>  struct platform_device;
> -/**
> - * cros_ec_sensors_core_init() - basic initialization of the core structure
> - * @pdev:		platform device created for the sensors
> - * @indio_dev:		iio device structure of the device
> - * @physical_device:	true if the device refers to a physical device
> - *
> - * Return: 0 on success, -errno on failure.
> - */
>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>  			      struct iio_dev *indio_dev, bool physical_device);
>  
> -/**
> - * cros_ec_sensors_capture() - the trigger handler function
> - * @irq:	the interrupt number.
> - * @p:		a pointer to the poll function.
> - *
> - * On a trigger event occurring, if the pollfunc is attached then this
> - * handler is called as a threaded interrupt (and hence may sleep). It
> - * is responsible for grabbing data from the device and pushing it into
> - * the associated buffer.
> - *
> - * Return: IRQ_HANDLED
> - */
>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
>  
> -/**
> - * cros_ec_motion_send_host_cmd() - send motion sense host command
> - * @st:		pointer to state information for device
> - * @opt_length:	optional length to reduce the response size, useful on the data
> - *		path. Otherwise, the maximal allowed response size is used
> - *
> - * When called, the sub-command is assumed to be set in param->cmd.
> - *
> - * Return: 0 on success, -errno on failure.
> - */
>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
>  				 u16 opt_length);
>  
> -/**
> - * cros_ec_sensors_core_read() - function to request a value from the sensor
> - * @st:		pointer to state information for device
> - * @chan:	channel specification structure table
> - * @val:	will contain one element making up the returned value
> - * @val2:	will contain another element making up the returned value
> - * @mask:	specifies which values to be requested
> - *
> - * Return:	the type of value returned by the device
> - */
>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>  			      struct iio_chan_spec const *chan,
>  			      int *val, int *val2, long mask);
>  
> -/**
> - * cros_ec_sensors_core_read_avail() - get available values
> - * @indio_dev:		pointer to state information for device
> - * @chan:	channel specification structure table
> - * @vals:	list of available values
> - * @type:	type of data returned
> - * @length:	number of data returned in the array
> - * @mask:	specifies which values to be requested
> - *
> - * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
> - */
>  int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  				    struct iio_chan_spec const *chan,
>  				    const int **vals,
> @@ -175,16 +105,6 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>  				    int *length,
>  				    long mask);
>  
> -/**
> - * cros_ec_sensors_core_write() - function to write a value to the sensor
> - * @st:		pointer to state information for device
> - * @chan:	channel specification structure table
> - * @val:	first part of value to write
> - * @val2:	second part of value to write
> - * @mask:	specifies which values to write
> - *
> - * Return:	the type of value returned by the device
> - */
>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>  			       struct iio_chan_spec const *chan,
>  			       int val, int val2, long mask);

