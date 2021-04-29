Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31C1F36E77A
	for <lists+linux-iio@lfdr.de>; Thu, 29 Apr 2021 10:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhD2I7m (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 29 Apr 2021 04:59:42 -0400
Received: from www381.your-server.de ([78.46.137.84]:53950 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbhD2I7l (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 29 Apr 2021 04:59:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=wkI6VedDBhz3elMdASecoXfk2atYi4oo78R8rslH5Gg=; b=B8kfdHQfwdcgOTXwbHnHpFnHc3
        hPGZXTOmeX3AEe5RpdKJfeqac/SjEsSCyQzyj555BNavwlGMicAOywKqC13LrwCitazWNqk7itYZk
        Caf9Yp7W3vmruBDUbSPU/6tizq3RsP0eOuq6Vk7DV4BA7Oi5xueF/vKO6zdbKfYobpS4S3E5BLQxK
        jkaZ4XTBXxxCQFudxCGDQJXs5/j/pF8SJtxbO4Pq6qWHkPE2gnyaH8nQeUUkmvhQK9ndDM73HpE0S
        mvXwAwuCZ3BnIYCr542kRcZ6Tl1sQNGq008cWuA0zWi7K1rI87Yz3gRqiC0U7Hfksp2BwgF0ILxYh
        1BmpFPVA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lc2VY-0006nY-1z; Thu, 29 Apr 2021 10:58:52 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lc2VX-000KsX-M6; Thu, 29 Apr 2021 10:58:51 +0200
Subject: Re: [RFC PATCH 2/4] iio: accel: fxls8962af: add interrupt support
To:     Sean Nyekjaer <sean@geanix.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
        Nuno.Sa@analog.com, robh+dt@kernel.org, devicetree@vger.kernel.org
References: <20210428082203.3587022-1-sean@geanix.com>
 <20210428082203.3587022-2-sean@geanix.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <28f1e2a4-b2fa-5e4a-954f-92d90966eaf7@metafoo.de>
Date:   Thu, 29 Apr 2021 10:58:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210428082203.3587022-2-sean@geanix.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26154/Wed Apr 28 13:07:51 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/28/21 10:22 AM, Sean Nyekjaer wrote:
> Preparation commit for the next that adds hw buffered sampling
>
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> [...]
>   
> +static void fxls8962af_get_irq(struct device_node *of_node, enum fxls8962af_int_pin *pin)
> +{
> +	int irq;
> +
> +	irq = of_irq_get_byname(of_node, "INT2");

For this I'd use device_property_match_string(dev, "interrupt-names", 
"INT2"). Means it won't try to map the interrupt again, and also this is 
the only place where the driver directly depends on OF, everything else 
already uses the device_ API.


> +	if (irq > 0) {
> +		*pin = FXLS8962AF_PIN_INT2;
> +		return;
> +	}
> +
> +	*pin = FXLS8962AF_PIN_INT1;
> +}

