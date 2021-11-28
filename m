Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54A8D460981
	for <lists+linux-iio@lfdr.de>; Sun, 28 Nov 2021 20:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhK1Tpx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Nov 2021 14:45:53 -0500
Received: from www381.your-server.de ([78.46.137.84]:34032 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235049AbhK1Tnw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Nov 2021 14:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=+sNrwgk74O6hf3Eta4o6KmduFRJ8O1KxBW/QL08DlWs=; b=HuLNjo7xXD780PuCafiwgGHUr0
        eBUDuKV6WxAgKRHKtkIUgs4Fz+A3HPpcL1wYR7cWKB669EIMHVbKBUZj8JQ6yXNT/NDIp5IKqnz3Z
        xysAhB1/i21u0TGH43CNUGGCoF9XT73qHaCjzDuMJg8mD1bY0uVzQhSai1IzwDjrqYWc/EPKKpOci
        vJlIuhjnpRZYT3C8MqfCRZhejm/Ez2WCwpGO7ooda5lQmghf88fW0H87+RWbA9oZrwQntdRtXZIJl
        iRLVU6LE7shGOq5OBSKFdNMXJvIiY/wsxs4n8/JGPPeahLULxTtmU3rlLWNiIfm7bdaaGadWqZDXI
        322tsPKg==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mrQ2L-000Cxv-FJ; Sun, 28 Nov 2021 20:40:33 +0100
Received: from [82.135.83.112] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mrQ2L-000S0B-9p; Sun, 28 Nov 2021 20:40:33 +0100
Subject: Re: [PATCH 01/12] iio:dac:ad5755: Switch to generic firmware
 properties.
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20211128192635.2724359-1-jic23@kernel.org>
 <20211128192635.2724359-2-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2f6dad36-45d6-9acd-ff1d-edf925f99b88@metafoo.de>
Date:   Sun, 28 Nov 2021 20:40:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211128192635.2724359-2-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26367/Sun Nov 28 10:19:58 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/28/21 8:26 PM, Jonathan Cameron wrote:
>   static int ad5755_probe(struct spi_device *spi)
>   {
> @@ -751,8 +736,8 @@ static int ad5755_probe(struct spi_device *spi)
>   
>   	mutex_init(&st->lock);
>   
> -	if (spi->dev.of_node)
> -		pdata = ad5755_parse_dt(&spi->dev);
> +	if (dev_fwnode(&spi->dev))
> +		pdata = ad5755_parse_fw(&spi->dev);
>   	else
>   		pdata = spi->dev.platform_data;
Considering that it is possible to supply fw_node data through platform 
files we as well just completely drop platform_data support. And make 
the platform data struct local to this file.


