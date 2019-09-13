Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 533E2B1C2A
	for <lists+linux-iio@lfdr.de>; Fri, 13 Sep 2019 13:30:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387523AbfIMLau (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 13 Sep 2019 07:30:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:42090 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387431AbfIMLau (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 13 Sep 2019 07:30:50 -0400
Received: by mail-ed1-f66.google.com with SMTP id y91so26718697ede.9
        for <linux-iio@vger.kernel.org>; Fri, 13 Sep 2019 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=vQsBFVEKU0Jcdo2igQSvP/k/DLBWnF92dJz9/RfTdhM=;
        b=ni5Ewj/t288NVFQjFlumHb7i63nve/Va2Omzq1jbQZ7+edaRm9Ci4zBRJa19pQSllx
         KjhVG0mKomVA8Zme3jtJF5qqsoxxSzMO8hRK6q7TAjsqmE5vHA7qOrFPin1hvhUc5Z9+
         H4bNSNJIBxVV3viI89ewjZQegPWz2IJOv23fNcpqZloSdfuMpncW2HCrDg1E/JaFpEc9
         zukHpclcpC9mSdVOAS4uZ6Gk7DZg46Ql8dgw5G7UmqwyAazfTsTIKuLjv7egm2YAaKZG
         SGu+Pp4j/42t46GJms3A9sqT+Ea1l93e54wqPw901Ubaj4cSK9Xjf/IrGCUBtAnR/lp4
         Njcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=vQsBFVEKU0Jcdo2igQSvP/k/DLBWnF92dJz9/RfTdhM=;
        b=B5f6e+ZCBkTrMhTvEhscVZwpd+oXmdgRu/HhG1SVMQTQLc7U5RIYU7rEdD+QwUD+xx
         hZ5m8zSgMYLKvGIRJ0XMtd45tTgxgpczuLVllIrxsZHjk3SPXMe4Pf7eFBzz/XzcZ0H0
         Idyv+xTTrXbancVYZmtJcXmGKDwvS8v0lHihVyg5DFW8dQaJJLBOyy/AG5/s2Ea2bTEI
         3ewNB60Jj2Q8thfzAwDqr6I3xeA1d/GQLhQMKi8dNW8WstVihvsB9uhsnR3uj8HyhNwr
         COzD5QYGu3yEYFF4ejQetWp+8InxVUKoXKmLBI9gMNjseXGKADUk7TYzH3CvY/d9CfPV
         C3BA==
X-Gm-Message-State: APjAAAV8Tq4X836hGxtpmUltPWAtMP/5rb8BPU29BT91epsuDODDxdc9
        qnNeMAxiYiAD3StzRfHdXtMFtjCCYGE=
X-Google-Smtp-Source: APXvYqyO/E+gkTXZuErb0VZOiZqDHnDM/MmGtDDTtx9GDhoUVrsptVIf1vyGzBbLBydsNICi1Ia/9Q==
X-Received: by 2002:a05:6402:1845:: with SMTP id v5mr41683745edy.130.1568374247207;
        Fri, 13 Sep 2019 04:30:47 -0700 (PDT)
Received: from [192.168.1.31] (230.120-247-81.adsl-dyn.isp.belgacom.be. [81.247.120.230])
        by smtp.gmail.com with ESMTPSA id f36sm5210425ede.28.2019.09.13.04.30.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Sep 2019 04:30:46 -0700 (PDT)
Subject: Re: [PATCH 4/4] iio: ad7949: fix channels mixups
To:     andrea.merello@gmail.com,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20190912144310.7458-1-andrea.merello@gmail.com>
 <20190912144310.7458-5-andrea.merello@gmail.com>
 <f91fb6e960dfd67926b6efa44ec7b792fc667468.camel@analog.com>
 <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
From:   Couret Charles-Antoine <charles-antoine.couret@essensium.com>
Message-ID: <4a25469a-9fe6-a560-b1cb-e9b0af7209e9@essensium.com>
Date:   Fri, 13 Sep 2019 13:30:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAN8YU5NLZhCDaocrQGUnb9TZauT-yPxY7ZQQQeYK=9696jmhCg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Le 13/09/2019 à 10:30, Andrea Merello a écrit :
> Il giorno ven 13 set 2019 alle ore 09:19 Ardelean, Alexandru
> <alexandru.Ardelean@analog.com> ha scritto:
>
>> So, at power-up this chip seems to need 2 dummy reads to discard data.
>> Which seems to happen in ad7949_spi_init()
>>
>> One thing that maybe could be optimized (for the driver), is in `ad7949_spi_read_channel()` to use the current-channel &
>> not do a SPI write to change the channel if it doesn't change.
>>
>> Datasheets (in general) are not always obvious about describing chip behavior for SW (or for writing a driver), but I
>> would suspect that if you are reading garbage data, it could be that the channel has changed.
>> This is true for some other ADCs.
>> And requires testing for this one.
> Yes, it's exactly what I've seen here. If the channel does not change
> then the AD is already in acquisition phase on the right channel (I
> assume it's OK to keep it in such phase indefinitely), then we can
> just trigger a new conversion (CNV low->high, that is a dummy xfer)
> and then read the result in following xfer, as the driver already did.
>
> I craft a V2 that performs the extra (3rd) spi xfer only if the
> channel has to change.

This design should be ok. I didn't implement in that way because not 
enough time to optimize the driver before release (I don't have access 
to the chip anymore) and for our workflow it was not relevant (we 
scanned all channels).


About your fix to read / write several times before reading the value 
after channel change seems not relevant. Did you try with the current 
implementation? Because when I developed the driver, I have always got 
the expected value for each channel with this design.


Just to be sure we are not adding useless steps.

>> Added Charles-Antoine, since he wrote the driver.
>> Shoud have added him on the other patches as well, but I just remembered.
> I tried on my first answer, but apparently mails to his address bounce
> back with a failure response..

But now it seems ok. Did you put the right email address?


Thank you for the copy.

Regards,

Charles-Antoine Couret

