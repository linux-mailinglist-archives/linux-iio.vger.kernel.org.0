Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01A48186C12
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 14:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731327AbgCPNbE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 09:31:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:45868 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731193AbgCPNbE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 09:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=rvrgFhHJz5Wm5Ciz89yCk0npatAz8VsWcPwEjqmsXUw=; b=lj2C15zTpGfmry/t703wGAuNlB
        LqdpKerhJs9LpgOhA5jLCYB1eM6agaMJt3QqtZiMRiFwFcnLh3EqXk1IGPONRDXntWPWVWXvMMWiA
        f0+2MhjGuU3uBxxoh4qbybEOPWsNht2So2fcAmtkOesx15mRjNiQotyB7EcD2BT2P7JB7RuYep+s+
        3KttuNtBMEk/WDIDEoF+5JPa72sLghHv1xmsPVwEfSVV6iQdf9rzwAOLyZ2Ox1YawAHBg2CaxPJ8d
        ubPDqjw9SNrLSNXOMe4TAeaTqPRybqUhehUnQuK9phuMNkOYZKhWTS0axyU5Iv55A6D9jd7oqXQ3u
        qtaovbpQ==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDppe-0008Bj-Ms; Mon, 16 Mar 2020 14:31:02 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDppe-0001LR-AW; Mon, 16 Mar 2020 14:31:02 +0100
Subject: Re: [PATCH v2 2/6] iio: imu: adis: Add irq mask variable
To:     =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>
References: <20200316125312.39178-1-nuno.sa@analog.com>
 <20200316125312.39178-3-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3ee772d7-2261-51f1-a420-213fdbc77595@metafoo.de>
Date:   Mon, 16 Mar 2020 14:31:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316125312.39178-3-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25752/Sun Mar 15 14:21:48 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/16/20 1:53 PM, Nuno Sá wrote:
> There are some ADIS devices that can configure the data ready pin
> polarity. Hence, we cannot hardcode our IRQ mask as IRQF_TRIGGER_RISING
> since we might want to have it as IRQF_TRIGGER_FALLING.
>
> Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> ---
> Changes in v2:
>   * Add kernel doc-string for `irq-mask`.
>
>   drivers/iio/imu/adis_trigger.c | 26 ++++++++++++++++++++++++--
>   include/linux/iio/imu/adis.h   |  2 ++
>   2 files changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index 9e393819d238..21eddffc50d3 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -34,6 +34,20 @@ static inline void adis_trigger_setup(struct adis *adis)
>   	iio_trigger_set_drvdata(adis->trig, adis);
>   }
>   
> +static inline int __adis_validate_irq_mask(struct adis *adis)

Bit of a nitpick, I'd drop the __ prefix, so far we only used it if 
there is a locked and an unlocked version of a function and it is 
unlikely that we'll need an unlocked function here.

I'd also drop the inline the compiler is smart enough to figure this out 
on its own. I believe the recommendation at the moment for kernel code 
is to use inline only for functions defined in header files.

> +{
> +	if (!adis->irq_mask) {
> +		adis->irq_mask = IRQF_TRIGGER_RISING;
> +		return 0;
> +	} else if (adis->irq_mask != IRQF_TRIGGER_RISING &&
> +		   adis->irq_mask != IRQF_TRIGGER_FALLING) {
> +		dev_err(&adis->spi->dev, "Invalid IRQ mask:%08lx\n",

Another nitpick. Space behind the ":".

> +			adis->irq_mask);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
>   /**
>    * adis_probe_trigger() - Sets up trigger for a adis device
>    * @adis: The adis device
> @@ -54,9 +68,13 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>   
>   	adis_trigger_setup(adis);
>   
> +	ret = __adis_validate_irq_mask(adis);
> +	if (ret)
> +		return ret;
> +
>   	ret = request_irq(adis->spi->irq,
>   			  &iio_trigger_generic_data_rdy_poll,
> -			  IRQF_TRIGGER_RISING,
> +			  adis->irq_mask,
>   			  indio_dev->name,
>   			  adis->trig);
>   	if (ret)
> @@ -96,9 +114,13 @@ int devm_adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>   
>   	adis_trigger_setup(adis);
>   
> +	ret = __adis_validate_irq_mask(adis);
> +	if (ret)
> +		return ret;
> +
>   	ret = devm_request_irq(&adis->spi->dev, adis->spi->irq,
>   			       &iio_trigger_generic_data_rdy_poll,
> -			       IRQF_TRIGGER_RISING,
> +			       adis->irq_mask,
>   			       indio_dev->name,
>   			       adis->trig);
>   	if (ret)
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index ac94c483bf2b..ed41c6b96d14 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -87,6 +87,7 @@ struct adis_data {
>    * @msg: SPI message object
>    * @xfer: SPI transfer objects to be used for a @msg
>    * @current_page: Some ADIS devices have registers, this selects current page
> + * @irq_mask: IRQ handling flags as passed to request_irq()
>    * @buffer: Data buffer for information read from the device
>    * @tx: DMA safe TX buffer for SPI transfers
>    * @rx: DMA safe RX buffer for SPI transfers
> @@ -113,6 +114,7 @@ struct adis {
>   	struct spi_message	msg;
>   	struct spi_transfer	*xfer;
>   	unsigned int		current_page;
> +	unsigned long		irq_mask;
>   	void			*buffer;
>   
>   	uint8_t			tx[10] ____cacheline_aligned;


