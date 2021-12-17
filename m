Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295C54786E5
	for <lists+linux-iio@lfdr.de>; Fri, 17 Dec 2021 10:18:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbhLQJSX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Dec 2021 04:18:23 -0500
Received: from www381.your-server.de ([78.46.137.84]:40782 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhLQJSX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Dec 2021 04:18:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=DF40KNpsAo2ldLlYCuZGj6WtHpEsGce6ipJZN2l9oeA=; b=AHWtQbB9vwOboOgsiE7CaJ+0az
        lVaZ34rCNCVptdYAe2X6bPl+jxaClaE5Ax5M6r35Oxz8G+/tq7SkjO0N3eB9sznp76tPtv6aQwKMr
        stDoildA15R/cnLJhpF4rqYCv5INSoqX8C1/ArHdc9BL0oBVIkI99d6iVJZ7pmyIKdVRY5iLryBzm
        DZAxey0oqhAmREYlTSNWicn3NwrSEn01HHzxVvWDE2wcLxF6t5z0xge0uJT5GP+92FIb4upjXr5v8
        WK19SR4x6FvPI+WKjwezpfSj+cGqZC8FpJNauH35KMZbHtHnHItK/VOSJoipVTDc8FfaBpRYn/EE6
        MQtRIYmg==;
Received: from [78.46.152.42] (helo=sslproxy04.your-server.de)
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1my9NH-0001I6-7i; Fri, 17 Dec 2021 10:17:59 +0100
Received: from [2001:a61:2bc8:8501:9e5c:8eff:fe01:8578]
        by sslproxy04.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1my9NG-000UQQ-Qf; Fri, 17 Dec 2021 10:17:58 +0100
Subject: Re: [PATCH 10/13] iio: max9611: Use sysfs_emit()
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Roan van Dijk <roan@protonic.nl>,
        Tomasz Duszynski <tduszyns@gmail.com>,
        Marc Titinger <mtitinger@baylibre.com>,
        Matt Ranostay <mranostay@gmail.com>,
        Johan Hovold <johan@kernel.org>,
        Paresh Chaudhary <paresh.chaudhary@rockwellcollins.com>,
        Navin Sankar Velliangiri <navin@linumiz.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Ludovic Tancerel <ludovic.tancerel@maplehightech.com>,
        linux-iio@vger.kernel.org
References: <20211216185217.1054495-1-lars@metafoo.de>
 <20211216185217.1054495-11-lars@metafoo.de>
 <20211217090543.4w3n6nfxxbemqnhb@uno.localdomain>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <485ca749-57d4-89c6-d19e-05b1cf5fb108@metafoo.de>
Date:   Fri, 17 Dec 2021 10:17:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211217090543.4w3n6nfxxbemqnhb@uno.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.3/26389/Thu Dec 16 07:02:49 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 12/17/21 10:05 AM, Jacopo Mondi wrote:
> Hi Lars-Peter,
>
> On Thu, Dec 16, 2021 at 07:52:14PM +0100, Lars-Peter Clausen wrote:
>> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
>> knows about the sysfs buffer specifics and has some built-in checks for
>> size and alignment.
>>
>> Use sysfs_emit() to format the custom `in_power_shunt_resistor` and
>> `in_current_shunt_resistor` device attributes of the max9611 driver.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Looks good, I just wonder if a dependency on the CONFIG_SYSFS symbol
> should now be added...
>
I don't think anything has changed in this regard. The function is 
called from a sysfs attribute callback. If SYSFS is disabled the 
callback will not be called. At the same time sysfs_emit() is stubbed 
out when SYSFS is disabled, so no compile error either.
