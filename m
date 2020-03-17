Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 455A41890B2
	for <lists+linux-iio@lfdr.de>; Tue, 17 Mar 2020 22:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCQVkw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 17 Mar 2020 17:40:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:60586 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCQVkw (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 17 Mar 2020 17:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=TDcS8WDpOd5O4xjP3FdoBHEQZzFDW+bKJ1zrGNNcg84=; b=Kc37eTBdjzVqIpeRKSFEzV8ASv
        65ucjQfQpTN4EYc9QXRdpl4kC125r9P7lwz8sr6fTNKT8M3hQAnoWV71a/RUeMnDauVwrL+QJx1wi
        CGXVP5ZiRszd5Pl8wcefiN3YdzzFUBVkUrEMVvY48uG8NmBdNoMInd4ARqMR4Jd9z2zzpvEPP9NWM
        sbSI/oEJOtQ2kZXAKuIuEJuML4x0//sx1Tqb7NJXJ7ZNt3jzkdOrSTGVaS9LZAm+8AHoP2tEq8BtF
        HeR4IR62vcwcRIGsWSCtwAnBBiNcMAEbdEUtFkl85ot8JZtkkjVyvwUdzVdRAUUT7LqtLka7ftSdB
        WsmiKQcA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jEJxB-0003Fl-PM; Tue, 17 Mar 2020 22:40:49 +0100
Received: from [93.104.105.202] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jEJxB-000TFi-GO; Tue, 17 Mar 2020 22:40:49 +0100
Subject: Re: [PATCH 1/2] iio: adc: Add MAX1241 driver
To:     Alexandru Lazar <alazar@startmail.com>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com
References: <20200317201710.23180-1-alazar@startmail.com>
 <20200317201710.23180-2-alazar@startmail.com>
 <370e807c-da03-e925-2eac-1e7e92c124e4@metafoo.de>
 <20200317212857.GA28983@leena.republic>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <fc961f0a-134d-7084-ce16-142cf5d5cc6b@metafoo.de>
Date:   Tue, 17 Mar 2020 22:40:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200317212857.GA28983@leena.republic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25754/Tue Mar 17 14:09:15 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/17/20 10:28 PM, Alexandru Lazar wrote:
> Hi Lars,
> 
> Thank you very much for your comments! I'll send a version with the
> fixes in a day or two (ar as soon as there's no more feedback, anyways)
> -- in the meantime I have a question about this one:
> 
>>> +	if (!adc->shdn)
>>> +		dev_info(&spi->dev, "no shdn pin passed, low-power mode disabled");
>>> +	else
>>> +		dev_info(&spi->dev, "shdn pin passed, low-power mode enabled");
>>
>> I can see how these message above are useful during development, but I'd
>> remove them or turn them into dev_dbg() for the "production" version of the
>> driver. Imagine every driver printed something like this, there would be a
>> lot of spam in the bootlog.
> 
> I thought this should go under info, rather than debug, because it's
> (possibly) relevant runtime information. It doesn't require any action,
> but it's something that a user of this driver may want to be aware
> of. The timing (and power consumption, of course) in low-power mode are
> different. It's akin to e.g.:
> 
> ./at91_adc.c:782: dev_info(&idev->dev, "Resolution used: %u bits\n", st->res);
> ./at91_adc.c:842: dev_info(dev, "ADC Touch screen is disabled.\n");
> ./at91_adc.c:955: dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");
> 
> or:
> 
> ./ti-ads124s08.c:320: dev_info(&spi->dev, "Reset GPIO not defined\n");
> 
> which is why I figured I'd do the same in my code (what can I say, I
> wear my code monkey badge with pride!).
> 
> Needless to say, since you've seen more IIO subsystem drivers than I've
> seen, I totally trust your assessment of whether this is debug or info
> more than I trust mine. If this was a false positive on your "looks like
> a leftover debug message", let me know (and while I'm at it I might make
> the message more useful/friendly...). Otherwise it'll get bumped down to
> dev_dbg in my next revision.

If I was to write this driver I would not make it dev_info(). In my 
opinion drivers should only print essential information during probe, 
like when something goes wrong. Otherwise the boot log gets very noisy 
quickly.

- Lars
