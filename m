Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2596F70E4
	for <lists+linux-iio@lfdr.de>; Mon, 11 Nov 2019 10:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbfKKJfh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 11 Nov 2019 04:35:37 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:60706 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbfKKJfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 11 Nov 2019 04:35:37 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2B640283D30
Subject: Re: [PATCH v4 12/17] iio: cros_ec: Move function description to .c
 file
To:     Jonathan Cameron <jic23@kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>
Cc:     briannorris@chromium.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, lee.jones@linaro.org, bleung@chromium.org,
        dianders@chromium.org, groeck@chromium.org,
        fabien.lahoudere@collabora.com, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20191105222652.70226-1-gwendal@chromium.org>
 <20191105222652.70226-13-gwendal@chromium.org>
 <20191110130827.12583c30@archlinux>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <9af7416b-d324-8401-5137-d5dcc37277f3@collabora.com>
Date:   Mon, 11 Nov 2019 10:35:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191110130827.12583c30@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 10/11/19 14:08, Jonathan Cameron wrote:
> On Tue,  5 Nov 2019 14:26:47 -0800
> Gwendal Grignou <gwendal@chromium.org> wrote:
> 
>> To prevent comment rot, move function description to
>> cros_ec_sensors_core.c.
>>
>> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Thanks for tidying this up.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 

Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
 Enric

>> ---
>> No changes in v4.
>> Changes in v3:
>>   fix spelling.
>> New in v2.
>>
>>  .../cros_ec_sensors/cros_ec_sensors_core.c    | 69 ++++++++++++++++
>>  .../linux/iio/common/cros_ec_sensors_core.h   | 80 -------------------
>>  2 files changed, 69 insertions(+), 80 deletions(-)
>>
>> diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> index 81a7f692de2f..b47da497a3c3 100644
>> --- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> +++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
>> @@ -83,6 +83,14 @@ static void get_default_min_max_freq(enum motionsensor_type type,
>>  	}
>>  }
>>  
>> +/**
>> + * cros_ec_sensors_core_init() - basic initialization of the core structure
>> + * @pdev:		platform device created for the sensors
>> + * @indio_dev:		iio device structure of the device
>> + * @physical_device:	true if the device refers to a physical device
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  			      struct iio_dev *indio_dev,
>>  			      bool physical_device)
>> @@ -160,6 +168,16 @@ int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_init);
>>  
>> +/**
>> + * cros_ec_motion_send_host_cmd() - send motion sense host command
>> + * @state:		pointer to state information for device
>> + * @opt_length:	optional length to reduce the response size, useful on the data
>> + *		path. Otherwise, the maximal allowed response size is used
>> + *
>> + * When called, the sub-command is assumed to be set in param->cmd.
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *state,
>>  				 u16 opt_length)
>>  {
>> @@ -422,6 +440,14 @@ int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev,
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_read_lpc);
>>  
>> +/**
>> + * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
>> + * @indio_dev:	pointer to IIO device
>> + * @scan_mask:	bitmap of the sensor indices to scan
>> + * @data:	location to store data
>> + *
>> + * Return: 0 on success, -errno on failure.
>> + */
>>  int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
>>  			     unsigned long scan_mask, s16 *data)
>>  {
>> @@ -446,6 +472,18 @@ int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev,
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_read_cmd);
>>  
>> +/**
>> + * cros_ec_sensors_capture() - the trigger handler function
>> + * @irq:	the interrupt number.
>> + * @p:		a pointer to the poll function.
>> + *
>> + * On a trigger event occurring, if the pollfunc is attached then this
>> + * handler is called as a threaded interrupt (and hence may sleep). It
>> + * is responsible for grabbing data from the device and pushing it into
>> + * the associated buffer.
>> + *
>> + * Return: IRQ_HANDLED
>> + */
>>  irqreturn_t cros_ec_sensors_capture(int irq, void *p)
>>  {
>>  	struct iio_poll_func *pf = p;
>> @@ -481,6 +519,16 @@ irqreturn_t cros_ec_sensors_capture(int irq, void *p)
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_capture);
>>  
>> +/**
>> + * cros_ec_sensors_core_read() - function to request a value from the sensor
>> + * @st:		pointer to state information for device
>> + * @chan:	channel specification structure table
>> + * @val:	will contain one element making up the returned value
>> + * @val2:	will contain another element making up the returned value
>> + * @mask:	specifies which values to be requested
>> + *
>> + * Return:	the type of value returned by the device
>> + */
>>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>>  			  struct iio_chan_spec const *chan,
>>  			  int *val, int *val2, long mask)
>> @@ -521,6 +569,17 @@ int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read);
>>  
>> +/**
>> + * cros_ec_sensors_core_read_avail() - get available values
>> + * @indio_dev:		pointer to state information for device
>> + * @chan:	channel specification structure table
>> + * @vals:	list of available values
>> + * @type:	type of data returned
>> + * @length:	number of data returned in the array
>> + * @mask:	specifies which values to be requested
>> + *
>> + * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
>> + */
>>  int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>>  				    struct iio_chan_spec const *chan,
>>  				    const int **vals,
>> @@ -542,6 +601,16 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>>  }
>>  EXPORT_SYMBOL_GPL(cros_ec_sensors_core_read_avail);
>>  
>> +/**
>> + * cros_ec_sensors_core_write() - function to write a value to the sensor
>> + * @st:		pointer to state information for device
>> + * @chan:	channel specification structure table
>> + * @val:	first part of value to write
>> + * @val2:	second part of value to write
>> + * @mask:	specifies which values to write
>> + *
>> + * Return:	the type of value returned by the device
>> + */
>>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>>  			       struct iio_chan_spec const *chan,
>>  			       int val, int val2, long mask)
>> diff --git a/include/linux/iio/common/cros_ec_sensors_core.h b/include/linux/iio/common/cros_ec_sensors_core.h
>> index bb331e6356a9..0af918978f97 100644
>> --- a/include/linux/iio/common/cros_ec_sensors_core.h
>> +++ b/include/linux/iio/common/cros_ec_sensors_core.h
>> @@ -79,95 +79,25 @@ struct cros_ec_sensors_core_state {
>>  	int frequencies[3];
>>  };
>>  
>> -/**
>> - * cros_ec_sensors_read_lpc() - retrieve data from EC shared memory
>> - * @indio_dev:	pointer to IIO device
>> - * @scan_mask:	bitmap of the sensor indices to scan
>> - * @data:	location to store data
>> - *
>> - * This is the safe function for reading the EC data. It guarantees that the
>> - * data sampled was not modified by the EC while being read.
>> - *
>> - * Return: 0 on success, -errno on failure.
>> - */
>>  int cros_ec_sensors_read_lpc(struct iio_dev *indio_dev, unsigned long scan_mask,
>>  			     s16 *data);
>>  
>> -/**
>> - * cros_ec_sensors_read_cmd() - retrieve data using the EC command protocol
>> - * @indio_dev:	pointer to IIO device
>> - * @scan_mask:	bitmap of the sensor indices to scan
>> - * @data:	location to store data
>> - *
>> - * Return: 0 on success, -errno on failure.
>> - */
>>  int cros_ec_sensors_read_cmd(struct iio_dev *indio_dev, unsigned long scan_mask,
>>  			     s16 *data);
>>  
>>  struct platform_device;
>> -/**
>> - * cros_ec_sensors_core_init() - basic initialization of the core structure
>> - * @pdev:		platform device created for the sensors
>> - * @indio_dev:		iio device structure of the device
>> - * @physical_device:	true if the device refers to a physical device
>> - *
>> - * Return: 0 on success, -errno on failure.
>> - */
>>  int cros_ec_sensors_core_init(struct platform_device *pdev,
>>  			      struct iio_dev *indio_dev, bool physical_device);
>>  
>> -/**
>> - * cros_ec_sensors_capture() - the trigger handler function
>> - * @irq:	the interrupt number.
>> - * @p:		a pointer to the poll function.
>> - *
>> - * On a trigger event occurring, if the pollfunc is attached then this
>> - * handler is called as a threaded interrupt (and hence may sleep). It
>> - * is responsible for grabbing data from the device and pushing it into
>> - * the associated buffer.
>> - *
>> - * Return: IRQ_HANDLED
>> - */
>>  irqreturn_t cros_ec_sensors_capture(int irq, void *p);
>>  
>> -/**
>> - * cros_ec_motion_send_host_cmd() - send motion sense host command
>> - * @st:		pointer to state information for device
>> - * @opt_length:	optional length to reduce the response size, useful on the data
>> - *		path. Otherwise, the maximal allowed response size is used
>> - *
>> - * When called, the sub-command is assumed to be set in param->cmd.
>> - *
>> - * Return: 0 on success, -errno on failure.
>> - */
>>  int cros_ec_motion_send_host_cmd(struct cros_ec_sensors_core_state *st,
>>  				 u16 opt_length);
>>  
>> -/**
>> - * cros_ec_sensors_core_read() - function to request a value from the sensor
>> - * @st:		pointer to state information for device
>> - * @chan:	channel specification structure table
>> - * @val:	will contain one element making up the returned value
>> - * @val2:	will contain another element making up the returned value
>> - * @mask:	specifies which values to be requested
>> - *
>> - * Return:	the type of value returned by the device
>> - */
>>  int cros_ec_sensors_core_read(struct cros_ec_sensors_core_state *st,
>>  			      struct iio_chan_spec const *chan,
>>  			      int *val, int *val2, long mask);
>>  
>> -/**
>> - * cros_ec_sensors_core_read_avail() - get available values
>> - * @indio_dev:		pointer to state information for device
>> - * @chan:	channel specification structure table
>> - * @vals:	list of available values
>> - * @type:	type of data returned
>> - * @length:	number of data returned in the array
>> - * @mask:	specifies which values to be requested
>> - *
>> - * Return:	an error code, IIO_AVAIL_RANGE or IIO_AVAIL_LIST
>> - */
>>  int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>>  				    struct iio_chan_spec const *chan,
>>  				    const int **vals,
>> @@ -175,16 +105,6 @@ int cros_ec_sensors_core_read_avail(struct iio_dev *indio_dev,
>>  				    int *length,
>>  				    long mask);
>>  
>> -/**
>> - * cros_ec_sensors_core_write() - function to write a value to the sensor
>> - * @st:		pointer to state information for device
>> - * @chan:	channel specification structure table
>> - * @val:	first part of value to write
>> - * @val2:	second part of value to write
>> - * @mask:	specifies which values to write
>> - *
>> - * Return:	the type of value returned by the device
>> - */
>>  int cros_ec_sensors_core_write(struct cros_ec_sensors_core_state *st,
>>  			       struct iio_chan_spec const *chan,
>>  			       int val, int val2, long mask);
> 
