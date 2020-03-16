Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A817186D02
	for <lists+linux-iio@lfdr.de>; Mon, 16 Mar 2020 15:27:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgCPO1m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 16 Mar 2020 10:27:42 -0400
Received: from www381.your-server.de ([78.46.137.84]:47164 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbgCPO1m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 16 Mar 2020 10:27:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=jGnxTV0/lTy7cBQWWgSE97gm+Q1DbNSaIg4kn/NeogA=; b=WOiWUtvTiCmPqfsfTtwnF5wEvp
        rvDPt5RH+r7YMpdAUGwkN41uRxMSZ2i7zB/oQmPjZ34tZtXmVDfNWIuP/RizV6kdnzPYWmFVJp/Gx
        q7mkHuawxTl+U4FkrER6rgWdLz5uEjStGewUvtd+sPwIfF7UlEF5j2Efx185MP6iDXPsfXI5zUSiq
        LsJyA5wDdWCztHhifNdDgqa7z6pW651JZ2svAvOUrYQnMqTVM1aidzkujjHbn8TD/u5a4JYvpIp0u
        n6H3ocF7yCMnh/xaS9Jm53uLUoaglQA10zMgDghB9zIYCL3JE633SEwJisua3Ufjl0WIn/JyE+ftb
        Aq8tWFjQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jDqiS-00041A-4T; Mon, 16 Mar 2020 15:27:40 +0100
Received: from [93.104.121.61] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jDqiR-000O1N-Ph; Mon, 16 Mar 2020 15:27:39 +0100
Subject: Re: [PATCH v2 1/6] iio: imu: adis: Add Managed device functions
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
 <20200316125312.39178-2-nuno.sa@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <99848a31-93db-0f09-df4e-3573500abc8c@metafoo.de>
Date:   Mon, 16 Mar 2020 15:27:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200316125312.39178-2-nuno.sa@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25753/Mon Mar 16 14:05:55 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/16/20 1:53 PM, Nuno Sá wrote:
> diff --git a/drivers/iio/imu/adis_trigger.c b/drivers/iio/imu/adis_trigger.c
> index 8b9cd02c0f9f..9e393819d238 100644
> --- a/drivers/iio/imu/adis_trigger.c
> +++ b/drivers/iio/imu/adis_trigger.c
> @@ -27,6 +27,13 @@ static const struct iio_trigger_ops adis_trigger_ops = {
>   	.set_trigger_state = &adis_data_rdy_trigger_set_state,
>   };
>   
> +static inline void adis_trigger_setup(struct adis *adis)
No need for inline. The compiler will figure this out on its own.
> +{
> +	adis->trig->dev.parent = &adis->spi->dev;
> +	adis->trig->ops = &adis_trigger_ops;
> +	iio_trigger_set_drvdata(adis->trig, adis);
> +}
> +
>   /**
>    * adis_probe_trigger() - Sets up trigger for a adis device
>    * @adis: The adis device
> @@ -45,9 +52,7 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>   	if (adis->trig == NULL)
>   		return -ENOMEM;
>   
> -	adis->trig->dev.parent = &adis->spi->dev;
> -	adis->trig->ops = &adis_trigger_ops;
> -	iio_trigger_set_drvdata(adis->trig, adis);
> +	adis_trigger_setup(adis);
>   
>   	ret = request_irq(adis->spi->irq,
>   			  &iio_trigger_generic_data_rdy_poll,
> @@ -73,6 +78,36 @@ int adis_probe_trigger(struct adis *adis, struct iio_dev *indio_dev)
>   }
>   EXPORT_SYMBOL_GPL(adis_probe_trigger);

