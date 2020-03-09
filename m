Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF3517DD02
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 11:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgCIKM6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 06:12:58 -0400
Received: from www381.your-server.de ([78.46.137.84]:58994 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKM6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xst/1QbG7NYBBC1ask2cPgz+WJ3u+VNwBtfioKBXocA=; b=GSFkKHDRP6164YKYjOHdgGHgGl
        /modLgp4t+6IWy+xrqPuE9zCX0OwjpzfUzkzShTm/T1jtkG0Pe310fa+fsNGXoJ+4IgWJu1Rvtydd
        sjJCLaiEBfd4Z9jwyWWVXLNE1HCb2GU4Atl/OF9cfQIVgDNzyl5Lg8cWq0ZClTFJAaD+Fn5J/rANh
        z6cBnakOE1j8Jl6Wg4KnOTLgW1S2UIG6JYHE8cwG810iiAgmJVaHmwncidyJKG81CjBMk5KPR5bOX
        +Ers7nGerYcaWqSzoGnESOQcToYRTvDjcFb7dOpquBGmCkzECmGUw2LfzffFXRPju3rZjUDzm7jCW
        VRTMzMjg==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jBFOz-00049s-Uy; Mon, 09 Mar 2020 11:12:50 +0100
Received: from [93.104.119.198] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jBFOz-000FRv-KO; Mon, 09 Mar 2020 11:12:49 +0100
Subject: Re: [PATCH -next] iio:ad7797: Use correct attribute_group
To:     Yuehaibing <yuehaibing@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc:     "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200302133249.23152-1-yuehaibing@huawei.com>
 <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
 <20200307131026.39f55a61@archlinux>
 <527d339d-fe32-1121-b83b-4b9385541c37@huawei.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <9c53e05a-294a-c2d1-8808-605b10c964a9@metafoo.de>
Date:   Mon, 9 Mar 2020 11:12:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <527d339d-fe32-1121-b83b-4b9385541c37@huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25745/Sun Mar  8 12:10:36 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/9/20 2:38 AM, Yuehaibing wrote:
> On 2020/3/7 21:10, Jonathan Cameron wrote:
>> On Wed, 4 Mar 2020 06:35:28 +0000
>> "Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:
>>
>>> On Mon, 2020-03-02 at 21:32 +0800, YueHaibing wrote:
>>>> [External]
>>>>
>>>> It seems ad7797_attribute_group should be used in ad7797_info,
>>>> according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").
>>> While the change looks good at first, I am thinking that this might introduce
>>> another issue while fixing this one.
>>>
>>> It looks like the ad7797_attributes[] array may also require the
>>> &iio_dev_attr_in_m_in_scale_available.dev_attr.attr attribute as well.
>>> It looks like the available scales should be printed for AD7997 as well.
>>>
>>> That being said, this patch is fine as-is.
>>> But it would require a patch [before-this-patch] to fix the ad7797_attributes
>>> array.
>>>
>>> Something like this:
>>>
>>> static struct attribute *ad7797_attributes[] = {
>>>          &iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
>>> +       &iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
>>>         NULL
>>> };
>>>
>>> I'm hoping I'm right about this one. I sometimes don't notice things too well.
>> Agreed. Should have that addition as well.  If not we'll successfully fix
>> one issue but drop a valid interface at the same time...
>>
> Ok, will send v2 with this addtion, thanks!
>
I believe the original patch is OK the way it was. The part does not 
have a programmable gain, hence should not have the scale_available 
attribute.

You can add my reviewed by to the original patch.

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

- Lars

