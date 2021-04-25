Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5231C36A83C
	for <lists+linux-iio@lfdr.de>; Sun, 25 Apr 2021 18:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhDYQIj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 25 Apr 2021 12:08:39 -0400
Received: from www381.your-server.de ([78.46.137.84]:45004 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhDYQIi (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 25 Apr 2021 12:08:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=/NWFDcPq6QgEovppxgoaVTygRXN4hLC0S6HGNnbfNxI=; b=PD7OBZAHUCIZAMrWpELZzU7qNh
        vZQ8jKFjRNx4eVmaeq8/FPpFp3fLBttMtL5u4GS0c9Mw82pSERV57K0ZALf2KB+JmOUKgE+zeZZms
        Uf+4X3hta/xQFsdb3PQugh+XZBwzIHc2Xd0EevLvnKorF4ijhzDuz7QWNsvka6tRnDLxdsIu0iAfp
        GjBWfRFf8eoH9nlgNdHNLJjnvu/fkROT3DHNHKWrGsT13OMtG67dyN0sa7EyA0tH9KttUk5soYYGB
        pWLYVW6i5s3I8i94Dlkxe4qJOPPCy+h67/d4Vi3iA5JBx/EQ9xm9SZA7cP0b6eHnJ4l0LB83OkSbk
        3Yxr05Ag==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lahIb-000DKj-F2; Sun, 25 Apr 2021 18:07:57 +0200
Received: from [2001:a61:2a42:9501:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lahIb-0007Xy-A5; Sun, 25 Apr 2021 18:07:57 +0200
Subject: Re: [PATCH v3 1/2] iio:adc:ad7476: Handle the different regulators
 used by various parts.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Hennerich <michael.hennerich@analog.com>,
        kernel test robot <lkp@intel.com>
References: <20210424170346.526242-1-jic23@kernel.org>
 <20210424170346.526242-2-jic23@kernel.org>
 <3780b584-3a94-4fdd-f6d3-b8823a253de7@metafoo.de>
 <20210425161802.2627e4b8@jic23-huawei> <20210425170253.577b0f41@jic23-huawei>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <0f947774-6c63-87c9-b694-f5ee58cdc54e@metafoo.de>
Date:   Sun, 25 Apr 2021 18:07:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210425170253.577b0f41@jic23-huawei>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26151/Sun Apr 25 13:05:06 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/25/21 6:02 PM, Jonathan Cameron wrote:
> On Sun, 25 Apr 2021 16:18:02 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
>
>> On Sat, 24 Apr 2021 20:20:41 +0200
>> Lars-Peter Clausen <lars@metafoo.de> wrote:
>>
>>> On 4/24/21 7:03 PM, Jonathan Cameron wrote:
>>>> [...]
>>>>    
>>>> +	/* Either vcc or vref (below) as appropriate */
>>>> +	if (!st->chip_info->int_vref_uv)
>>>> +		st->ref_reg = reg;
>>>> +
>>>> +	if (st->chip_info->has_vref) {
>>>> +
>>>> +		/* If a device has an internal reference vref is optional */
>>>> +		if (st->chip_info->int_vref_uv) {
>>>> +			reg = devm_regulator_get_optional(&spi->dev, "vref");
>>>> +		} else {
>>>> +			reg = devm_regulator_get(&spi->dev, "vref");
>>>> +			if (IS_ERR(reg))
>>>> +				return PTR_ERR(reg);
>>>> +		}
>>>> +
>>>> +		if (!IS_ERR(reg)) {
>>>> +			ret = regulator_enable(reg);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +
>>>> +			ret = devm_add_action_or_reset(&spi->dev,
>>>> +						       ad7476_reg_disable,
>>>> +						       reg);
>>>> +			if (ret)
>>>> +				return ret;
>>>> +			st->ref_reg = reg;
>>>> +		} else {
>>> We still need to check for errors, e.g. to support EPROBE_DEFER. The
>>> only error that can be ignored is ENOENT, which means no regulator is
>>> specified.
>> Good point.  I got fixated on all the different combinations and forgot the
>> simple 'error' case :)
> As far as I can tell -ENODEV is the return for no regulator specified.

Yes. We even have a few examples like the ad7124 driver.

