Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E623125B2
	for <lists+linux-iio@lfdr.de>; Sun,  7 Feb 2021 17:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbhBGQBM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Feb 2021 11:01:12 -0500
Received: from www381.your-server.de ([78.46.137.84]:34524 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhBGQBM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Feb 2021 11:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=NFhX8hYysFqBWHs42JSggtQWnQGnjozUPE9iksY9+dA=; b=Mb232ZOg7s1Tzxi+rKN+OIUGlU
        SefpKWgTVDIyj/+dn1PjUmySjvHQMYqCgEEWxfsCGzQuQW3cadVXzio6byWWcO6e9BmZibk8EzuWZ
        VoehBeZECweyNWbUMwEB8xgbvtvf05s5BYkIa9iKq7W2AgE4L0183juE/nya5Hj3UmK6xBtnYsBTL
        54E+wg2aaktrkZy5UoizvkUDyUUc1aNlrl7QE00D4Ve3RFsFJG2tLjMKPHeB7tHlY1+3KKlPQn1B9
        5tUeNuFmJdDz/jBX6r+6AQcziFOnhHZf8jLv1mlcmU40BIHbHp/4A2k84y0GqiNWdzGxHItfEyX0a
        jZH14XRw==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1l8mU5-000Eyd-43; Sun, 07 Feb 2021 17:00:25 +0100
Received: from [62.216.202.92] (helo=[192.168.178.20])
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1l8mU4-000GZg-RA; Sun, 07 Feb 2021 17:00:24 +0100
Subject: Re: [PATCH 21/24] dt-bindings:iio:cdc:adi,ad7150 binding doc
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc:     Michael Hennerich <Michael.Hennerich@analog.com>,
        song.bao.hua@hisilicon.com, robh+dt@kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        devicetree@vger.kernel.org
References: <20210207154623.433442-1-jic23@kernel.org>
 <20210207154623.433442-22-jic23@kernel.org>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <1840bd30-be94-761e-403d-59b13eeef774@metafoo.de>
Date:   Sun, 7 Feb 2021 17:00:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210207154623.433442-22-jic23@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26073/Sun Feb  7 13:23:32 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/7/21 4:46 PM, Jonathan Cameron wrote:
> +required:
> +  - compatible
> +  - reg

Is vdd-supply really optional the way it is implemented in the driver?

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        cdc@48 {
> +            compatible = "adi,ad7150";
> +            reg = <0x48>;
> +            interrupts = <25 2>, <26 2>;

I wonder if we should use the symbolic constants for the IRQ type to 
make the example more clear. E.g.

interrupts = <25 IRQ_TYPE_EDGE_FALLING>, ...

> +            interrupt-parent = <&gpio>;
> +        };
> +    };
> +...


