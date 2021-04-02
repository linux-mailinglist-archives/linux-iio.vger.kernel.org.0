Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C52B9352745
	for <lists+linux-iio@lfdr.de>; Fri,  2 Apr 2021 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbhDBIOw (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 2 Apr 2021 04:14:52 -0400
Received: from www381.your-server.de ([78.46.137.84]:41236 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhDBIOv (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 2 Apr 2021 04:14:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=j+OxwzSJ5rbTE2FYHi8wA+FmBOWb3xgkePBGrFRsQm8=; b=Al8Fd/qXGIFiY00N7q3ctf2XF2
        CVZlaiCev3Isy51kgEA+8mz9UPbBvhWE9uNd25Rx1w/ipRSXfJ4exCRSOt035NLDCzxGsfNkt2jjF
        VgEEO30humgCCABhh4mXu5z58wCz8VU2On7NqayB2Gach8fsAceGjggZksh5RfedPrgFHvNZiNPMS
        MfvRHQcwUz8W0aEBq9oHselZ0efPnojVbzJnhrurSuGxnctMYmWX0rgBTswY2Q4jiinvaVb2HkhfN
        W3SaKpdN8qAhVvDkkX8TR41R/LasoB9ujJ07Co4A4KOAkdm44KUBISn4NYh41DBfNsNB3+/PXF9er
        4jrMIbiQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lSEx5-0002kh-DE; Fri, 02 Apr 2021 10:14:47 +0200
Received: from [2001:a61:2aa1:1e01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lSEx5-000JFh-8G; Fri, 02 Apr 2021 10:14:47 +0200
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>
Cc:     Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210401091648.87421-1-puranjay12@gmail.com>
 <20210401091648.87421-3-puranjay12@gmail.com>
 <CAHp75Vcmyvi4V2D0cnmobTGHCS_ci2FC=cBF8tEoG9v51o8RmQ@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0d2bce88-1c23-a711-6a37-118173066ab5@metafoo.de>
Date:   Fri, 2 Apr 2021 10:14:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vcmyvi4V2D0cnmobTGHCS_ci2FC=cBF8tEoG9v51o8RmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26127/Thu Apr  1 13:11:26 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/1/21 11:36 AM, Andy Shevchenko wrote:
> [...]
>> +       case IIO_CHAN_INFO_SCALE:
>> +               /* Conversion from 10s of uC to mC
>> +                * as IIO reports temperature in mC
>> +                */
>> +               *val = TMP117_RESOLUTION_10UC / 10000;
>> +               *val2 = (TMP117_RESOLUTION_10UC % 10000) * 100;
>> +               return IIO_VAL_INT_PLUS_MICRO;
> You use 10000 many times, can you give it an appropriate name (via #define)?
#define TENTHOUSAND 10000 ;)


