Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D655219EB21
	for <lists+linux-iio@lfdr.de>; Sun,  5 Apr 2020 14:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgDEMNg (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 5 Apr 2020 08:13:36 -0400
Received: from www381.your-server.de ([78.46.137.84]:48156 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgDEMNf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 5 Apr 2020 08:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=682+EXlTpEEqAjYTEZEEx959VaPq1DnUP0GqLBEVGTY=; b=kRvWuVnmCzTtd1S5nVevss0OFy
        J1885eAMoIBgvwFBluFE2R5Mjs4o844FbYg/BIDApR5gCTSQIR+VQQ59iWGPklMAQOXTQuNcNhLNr
        hbXgUaQMV0szIsbIcVOEek4k28cxW7Pl8CrURSv0ynxXJKtFXkgAeB+p1YhKBTejoYVJ8zt/Jq/6S
        SO3Jq7WY5ZZKyp4ZeJoCf/unjnnQXeek/PKR7ZvKRlZl3fCSDF/BqjOEfXXjzDPXuoQlfXGAlD9ye
        aiutL6lgkE8X26P626n2oZfnmhNI34VA3kNNOEizaDznF2Z6e+GFtBL65S5I0Rh5+znlz+Esg0kGJ
        H5fGtvTQ==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <lars@metafoo.de>)
        id 1jL49d-0004HW-Qn; Sun, 05 Apr 2020 14:13:33 +0200
Received: from [82.135.79.250] (helo=[192.168.178.20])
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1jL49d-000GgM-HD; Sun, 05 Apr 2020 14:13:33 +0200
Subject: Re: [PATCH 1/5] iio: xilinx-xadc: Fix ADC-B powerdown
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20200403132717.24682-1-lars@metafoo.de>
 <20200405131039.37ae5165@archlinux>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <55c93588-2242-2ccb-2d8e-50cc66de28f5@metafoo.de>
Date:   Sun, 5 Apr 2020 14:13:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200405131039.37ae5165@archlinux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.2/25772/Sat Apr  4 14:56:57 2020)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/5/20 2:10 PM, Jonathan Cameron wrote:
> On Fri,  3 Apr 2020 15:27:13 +0200
> Lars-Peter Clausen <lars@metafoo.de> wrote:
>
>> The check for shutting down the second ADC is inverted. This causes it to
>> be powered down when it should be enabled. As a result channels that are
>> supposed to be handled by the second ADC return invalid conversion results.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Fixes tag?  Definitely sounds like something we should be backporting!

Fixes: bdc8cda1d010 ("iio:adc: Add Xilinx XADC driver")

>
> Jonathan
>
>> ---
>>   drivers/iio/adc/xilinx-xadc-core.c | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
>> index 2d6505a66511..4fcf1729341f 100644
>> --- a/drivers/iio/adc/xilinx-xadc-core.c
>> +++ b/drivers/iio/adc/xilinx-xadc-core.c
>> @@ -722,13 +722,14 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>>   {
>>   	uint16_t val;
>>   
>> +	/* Powerdown the ADC-B when it is not needed. */
>>   	switch (seq_mode) {
>>   	case XADC_CONF1_SEQ_SIMULTANEOUS:
>>   	case XADC_CONF1_SEQ_INDEPENDENT:
>> -		val = XADC_CONF2_PD_ADC_B;
>> +		val = 0;
>>   		break;
>>   	default:
>> -		val = 0;
>> +		val = XADC_CONF2_PD_ADC_B;
>>   		break;
>>   	}
>>   


