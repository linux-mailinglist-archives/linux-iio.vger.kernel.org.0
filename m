Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F24D0342CDF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Mar 2021 13:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCTMwj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 20 Mar 2021 08:52:39 -0400
Received: from www381.your-server.de ([78.46.137.84]:51564 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhCTMw1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 20 Mar 2021 08:52:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=YnxDx14DgbEq/fFkIvh4xmfD+U9hJOx2AnbQTNDX3sE=; b=IQYd13PYwV7LpswK9GYCrY/ECx
        W1UR4SSToi8Wo+dIPELAHEVIcGDnoQDUghBuDrFz82Aav3IGZ/o8WZtY7l2p/N6Cw1qOcWRsmCdae
        Em6KCQ5FFRyO+g4mg4TnNsIDFDdj1GxyXuFaNSpWLVFoiwsB9d5yKifloXRJvQpI2l3qiB3JQXXVh
        L7uCvGg4aq5iyTnGdugt2t6Q0YrlTIHyXUq0H4BiZ/jISDqi2ZqY+Om0t8PhE/E9F6CsUCVSNQIa6
        Xlb3jXHCjqz4UcqhSbc0VdqJsYb0gK+Ie1dTJhJDVNn1blcCw3lSQk0daary0w9HgBPYFMhZv2gzK
        A/7VPJRQ==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNb5b-000B0J-Ez; Sat, 20 Mar 2021 13:52:23 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNb5b-0006D0-BK; Sat, 20 Mar 2021 13:52:23 +0100
Subject: Re: [PATCH 4/4] iio: dac: Convert powerdown read callbacks to
 sysfs_emit()
To:     Joe Perches <joe@perches.com>, Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
References: <20210320071405.9347-1-lars@metafoo.de>
 <20210320071405.9347-5-lars@metafoo.de>
 <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3e26d657-4f03-5284-8cfe-73131a65e33f@metafoo.de>
Date:   Sat, 20 Mar 2021 13:52:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <733be1879f059f87fc03df79b33cf5560f3dfcaf.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26115/Sat Mar 20 12:03:55 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/20/21 12:01 PM, Joe Perches wrote:
> On Sat, 2021-03-20 at 08:14 +0100, Lars-Peter Clausen wrote:
>> Update DAC drivers powerdown attribute show callback to use the new
>> sysfs_emit() function.
>>
>> sysfs_emit() is preferred over raw s*printf() for sysfs attributes since it
>> knows about the sysfs buffer specifics and has some built-in sanity checks.
> Thanks.
>
> unrelated trivia:
>
>> diff --git a/drivers/iio/dac/ad5360.c b/drivers/iio/dac/ad5360.c
> []
>> @@ -255,7 +255,7 @@ static ssize_t ad5360_read_dac_powerdown(struct device *dev,
>>   	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>   	struct ad5360_state *st = iio_priv(indio_dev);
>>   
>> -	return sprintf(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
>> +	return sysfs_emit(buf, "%d\n", (bool)(st->ctrl & AD5360_SF_CTRL_PWR_DOWN));
> rather than cast to bool, perhaps standardize to use !!(val & test)
I very much prefer the cast to bool since it semantically stronger. You 
don't have to know that the !! idiom is used to cast an int to bool.
