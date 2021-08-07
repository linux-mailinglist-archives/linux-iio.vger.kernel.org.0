Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909383E3551
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 14:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhHGMSE (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Aug 2021 08:18:04 -0400
Received: from www381.your-server.de ([78.46.137.84]:35756 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbhHGMSD (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Aug 2021 08:18:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=DQIp9Ad4UEba40AIonqC8nTNn/YjPKQV8Gnl1+/2UTY=; b=Vz2kkbmeKnf4aSWluyAH4vzEVj
        V+H0NDTMcuS1AbaMfQwp5vVw8wauBoJ8BoUYfkkd5y4YF35A835B8gtIyeDpYrbZ37hcMwZq+b1fN
        TPqZRqGuFDwUurCb8ar2jmdY7PDKyhWNh8/oGByRBN1s9/kAcjiV0ewAPleOEReHRCyWJX7b4C6qP
        JLKJLzIsYIL9WREZ4Rpy5oiIVJ4MekdWyUYd88hSwctGOTtOHj3CSnU2N6BKVkV1rrkc4o9fKUAew
        dgCtmft0BkHhywR+0ZGVlh/e2OJlGjGcQzhG8G5wellEFW0kyxfkh+l4p8ipVDAk23cBwC9PM+SZv
        U45Tf7+Q==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1mCLGe-000B3Q-FA; Sat, 07 Aug 2021 14:17:32 +0200
Received: from [62.216.202.4] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1mCLGe-000SW1-57; Sat, 07 Aug 2021 14:17:32 +0200
Subject: Re: [PATCH 2/2] iio: potentiometer: Add driver support for AD5110
To:     Mugilraj Dhavachelvan <dmugil2000@gmail.com>,
        Dragos.Bogdan@analog.com, Darius.Berghe@analog.com,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-iio@vger.kernel.org
References: <20210807050900.10075-1-dmugil2000@gmail.com>
 <20210807050900.10075-3-dmugil2000@gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9de74da9-14b6-1533-e394-c7c8b056bce2@metafoo.de>
Date:   Sat, 7 Aug 2021 14:17:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807050900.10075-3-dmugil2000@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26256/Sat Aug  7 10:20:00 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 8/7/21 7:08 AM, Mugilraj Dhavachelvan wrote:
> +static const struct iio_chan_spec ad5110_channels[] = {
> +	{
> +		.type = IIO_RESISTANCE,
> +		.output = 1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_OFFSET),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
> +						BIT(IIO_CHAN_INFO_ENABLE),
There is only on channel in this device. Why are some `separate` and 
others `shared_by_type`?


