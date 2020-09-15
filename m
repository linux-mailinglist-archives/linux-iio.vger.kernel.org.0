Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2BC26A2D6
	for <lists+linux-iio@lfdr.de>; Tue, 15 Sep 2020 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgIOKLz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Tue, 15 Sep 2020 06:11:55 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726267AbgIOKLy (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 15 Sep 2020 06:11:54 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 856404D5EFE1B488665C;
        Tue, 15 Sep 2020 11:11:52 +0100 (IST)
Received: from localhost (10.52.121.217) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 15 Sep
 2020 11:11:51 +0100
Date:   Tue, 15 Sep 2020 11:10:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Nuno =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Alexandru Ardelean --dry-run <alexandru.ardelean@analog.com>
Subject: Re: [PATCH 10/10] iio: adis: Drop non Managed device functions
Message-ID: <20200915111015.00004707@Huawei.com>
In-Reply-To: <20200915093345.85614-11-nuno.sa@analog.com>
References: <20200915093345.85614-1-nuno.sa@analog.com>
        <20200915093345.85614-11-nuno.sa@analog.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.121.217]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Sep 2020 11:33:45 +0200
Nuno Sá <nuno.sa@analog.com> wrote:

> Drop `adis_setup_buffer_and_trigger()`. All users were updated to use
> the devm version of this function. This avoids having almost the same
> code repeated.
> 
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>

Good to see this cleanup, as long as we tidy up the few issues in the
earlier patches.

Note I think I only commented on first instance of each thing to fix.
Please carry them through all the patches.

Thanks,

Jonathan

> ---
>  drivers/iio/imu/adis_buffer.c  | 64 +++-------------------------------
>  drivers/iio/imu/adis_trigger.c | 60 -------------------------------
>  include/linux/iio/imu/adis.h   | 27 --------------
>  3 files changed, 4 insertions(+), 147 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 5b4225ee09b9..df6144285470 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -169,48 +169,6 @@ static void adis_buffer_cleanup(void *arg)
>  	kfree(adis->xfer);
>  }
>  
> -/**
> - * adis_setup_buffer_and_trigger() - Sets up buffer and trigger for the adis device
> - * @adis: The adis device.
> - * @indio_dev: The IIO device.
> - * @trigger_handler: Optional trigger handler, may be NULL.
> - *
> - * Returns 0 on success, a negative error code otherwise.
> - *
> - * This function sets up the buffer and trigger for a adis devices.  If
> - * 'trigger_handler' is NULL the default trigger handler will be used. The
> - * default trigger handler will simply read the registers assigned to the
> - * currently active channels.
> - *
> - * adis_cleanup_buffer_and_trigger() should be called to free the resources
> - * allocated by this function.
> - */
> -int adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
> -	irqreturn_t (*trigger_handler)(int, void *))
> -{
> -	int ret;
> -
> -	if (!trigger_handler)
> -		trigger_handler = adis_trigger_handler;
> -
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> -		trigger_handler, NULL);
> -	if (ret)
> -		return ret;
> -
> -	if (adis->spi->irq) {
> -		ret = adis_probe_trigger(adis, indio_dev);
> -		if (ret)
> -			goto error_buffer_cleanup;
> -	}
> -	return 0;
> -
> -error_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
> -
>  /**
>   * devm_adis_setup_buffer_and_trigger() - Sets up buffer and trigger for
>   *					  the managed adis device
> @@ -220,7 +178,10 @@ EXPORT_SYMBOL_GPL(adis_setup_buffer_and_trigger);
>   *
>   * Returns 0 on success, a negative error code otherwise.
>   *
> - * This function perfoms exactly the same as adis_setup_buffer_and_trigger()
> + * This function sets up the buffer and trigger for a adis devices.  If
> + * 'trigger_handler' is NULL the default trigger handler will be used. The
> + * default trigger handler will simply read the registers assigned to the
> + * currently active channels.
>   */
>  int
>  devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
> @@ -248,20 +209,3 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
>  }
>  EXPORT_SYMBOL_GPL(devm_adis_setup_buffer_and_trigger);
>  
> -/**
> - * adis_cleanup_buffer_and_trigger() - Free buffer and trigger resources
> - * @adis: The adis device.
> - * @indio_dev: The IIO device.
> - *
> - * Frees resources allocated by adis_setup_buffer_and_trigger()
> - */
> -void adis_cleanup_buffer_and_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev)
> -{
> -	if (adis->spi->irq)
> -		adis_remove_trigger(adis);
> -	kfree(adis->buffer);
> -	kfree(adis->xfer);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -}
> -EXPORT_SYMBOL_GPL(adis_cleanup_buffer_and_trigger);
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index 8afe71947c00..64e0ba51cb18 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -55,53 +55,6 @@ static int adis_validate_irq_flag(struct adis *adis)
>  
>  	return 0;
>  }
> -/**
> - * adis_probe_trigger() - Sets up trigger for a adis device
> - * @adis: The adis device
> - * @indio_dev: The IIO device
> - *
> - * Returns 0 on success or a negative error code
> - *
> - * adis_remove_trigger() should be used to free the trigger.
> - */
> -int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
> -{
> -	int ret;
> -
> -	adis->trig = iio_trigger_alloc("%s-dev%d", indio_dev->name,
> -					indio_dev->id);
> -	if (adis->trig == NULL)
> -		return -ENOMEM;
> -
> -	adis_trigger_setup(adis);
> -
> -	ret = adis_validate_irq_flag(adis);
> -	if (ret)
> -		return ret;
> -
> -	ret = request_irq(adis->spi->irq,
> -			  &iio_trigger_generic_data_rdy_poll,
> -			  adis->irq_flag,
> -			  indio_dev->name,
> -			  adis->trig);
> -	if (ret)
> -		goto error_free_trig;
> -
> -	ret = iio_trigger_register(adis->trig);
> -
> -	indio_dev->trig = iio_trigger_get(adis->trig);
> -	if (ret)
> -		goto error_free_irq;
> -
> -	return 0;
> -
> -error_free_irq:
> -	free_irq(adis->spi->irq, adis->trig);
> -error_free_trig:
> -	iio_trigger_free(adis->trig);
> -	return ret;
> -}
> -EXPORT_SYMBOL_GPL(adis_probe_trigger);
>  
>  /**
>   * devm_adis_probe_trigger() - Sets up trigger for a managed adis device
> @@ -137,16 +90,3 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>  }
>  EXPORT_SYMBOL_GPL(devm_adis_probe_trigger);
>  
> -/**
> - * adis_remove_trigger() - Remove trigger for a adis devices
> - * @adis: The adis device
> - *
> - * Removes the trigger previously registered with adis_probe_trigger().
> - */
> -void adis_remove_trigger(struct adis *adis)
> -{
> -	iio_trigger_unregister(adis->trig);
> -	free_irq(adis->spi->irq, adis->trig);
> -	iio_trigger_free(adis->trig);
> -}
> -EXPORT_SYMBOL_GPL(adis_remove_trigger);
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index 2df67448f0d1..01ba691da2f3 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -517,14 +517,8 @@ struct adis_burst {
>  int
>  devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
>  				   irq_handler_t trigger_handler);
> -int adis_setup_buffer_and_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *));
> -void adis_cleanup_buffer_and_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev);
>  
>  int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
> -int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev);
> -void adis_remove_trigger(struct adis *adis);
>  
>  int adis_update_scan_mode(struct iio_dev *indio_dev,
>  	const unsigned long *scan_mask);
> @@ -538,33 +532,12 @@ devm_adis_setup_buffer_and_trigger(struct adis *adis, struct iio_dev *indio_dev,
>  	return 0;
>  }
>  
> -static inline int adis_setup_buffer_and_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev, irqreturn_t (*trigger_handler)(int, void *))
> -{
> -	return 0;
> -}
> -
> -static inline void adis_cleanup_buffer_and_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev)
> -{
> -}
> -
>  static inline int devm_adis_probe_trigger(struct adis *adis,
>  					  struct iio_dev *indio_dev)
>  {
>  	return 0;
>  }
>  
> -static inline int adis_probe_trigger(struct adis *adis,
> -	struct iio_dev *indio_dev)
> -{
> -	return 0;
> -}
> -
> -static inline void adis_remove_trigger(struct adis *adis)
> -{
> -}
> -
>  #define adis_update_scan_mode NULL
>  
>  #endif /* CONFIG_IIO_BUFFER */


