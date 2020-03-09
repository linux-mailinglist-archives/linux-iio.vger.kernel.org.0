Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1517DCF6
	for <lists+linux-iio@lfdr.de>; Mon,  9 Mar 2020 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbgCIKKS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Mar 2020 06:10:18 -0400
Received: from www381.your-server.de ([78.46.137.84]:57288 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIKKR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Mar 2020 06:10:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8SbM5sFpOiKO++dalR7qhIQEk+CBbb0HOEkmKG6jQ84=; b=VxQFjmHVGPOebXfooX0gLWdAbh
        9xOeWs6sqc6ymgKY3wUkfGBaV7hnD7aJdLro03K9g/T7jxt0nLPCsTrPDVZUtVj70wNs6J8XpFimq
        BmqOBxXloot7zEmOeId5HQrw0Q6XlkZwHtZoONxiB7IdoKD2jYThJ9VQM0mCmiDsQgVLf5lWKVapr
        cH5b8o2oD9KpivxtkS66A7x0MTR+qYGJC56P3zBWTaK2Qjuz86rex1+1bnGsVEO9GeQ8Z2UsLV7s8
        o4h0iYUv7j5hamtvsiogpzIj1Y5aFRP7q4lyCwhWGhcnTyfqL6qfdYO8ClFxmeOUH7Kr/HfLyZGHw
        5uarxedQ==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jBFMM-00041m-CO; Mon, 09 Mar 2020 11:10:06 +0100
Received: from [93.104.119.198] (helo=[192.168.178.20])
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jBFMM-000X8D-1X; Mon, 09 Mar 2020 11:10:06 +0100
Subject: Re: [PATCH -next] iio:ad7797: Use correct attribute_group
To:     "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "stefan.popa@analog.com" <stefan.popa@analog.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20200302133249.23152-1-yuehaibing@huawei.com>
 <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <f82a318f-16b3-0bc0-61bf-0c54da05446d@metafoo.de>
Date:   Mon, 9 Mar 2020 11:10:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <8d7a7062af94a3531dd519bd60fe26c8530c6a43.camel@analog.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25745/Sun Mar  8 12:10:36 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/4/20 7:35 AM, Ardelean, Alexandru wrote:
> On Mon, 2020-03-02 at 21:32 +0800, YueHaibing wrote:
>> [External]
>>
>> It seems ad7797_attribute_group should be used in ad7797_info,
>> according to commit ("iio:ad7793: Add support for the ad7796 and ad7797").
> While the change looks good at first, I am thinking that this might introduce
> another issue while fixing this one.
>
> It looks like the ad7797_attributes[] array may also require the
> &iio_dev_attr_in_m_in_scale_available.dev_attr.attr attribute as well.
> It looks like the available scales should be printed for AD7997 as well.
>
> That being said, this patch is fine as-is.
> But it would require a patch [before-this-patch] to fix the ad7797_attributes
> array.
>
> Something like this:
>
> static struct attribute *ad7797_attributes[] = {
>          &iio_const_attr_sampling_frequency_available_ad7797.dev_attr.attr,
> +       &iio_dev_attr_in_m_in_scale_available.dev_attr.attr,
>         NULL
> };
>
> I'm hoping I'm right about this one. I sometimes don't notice things too well.
>
Scale is fixed for the ad7796 and not programmable. Usually we only have 
the scale attribute itself in that case and no scale_available attribute.

- Lars

