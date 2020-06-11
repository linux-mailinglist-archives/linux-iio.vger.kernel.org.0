Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 017CF1F6567
	for <lists+linux-iio@lfdr.de>; Thu, 11 Jun 2020 12:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgFKKJc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 11 Jun 2020 06:09:32 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:31768 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726965AbgFKKJc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 11 Jun 2020 06:09:32 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05BA7Lfr003767;
        Thu, 11 Jun 2020 12:09:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=io4QkYyPev1lFAk4WWD+YOdtfCEKcWGZV313SSMWam4=;
 b=Dfg8Bh6Vhx2dsVrLDsX09I4ViM0xyUXa6FCuXkjKTvZoDN/cXP4rVkspuAXlAku12pEI
 Nh8Zm+GNw16WVrhgo3hHmia75qDQ3oCHAMM01HT4+S+6AKbfYYu+rzKvB3oPbGIN/qRC
 FqipJob9rxIm5nv3I3lYnHW7rMETvn8k2EAHLiF3yS3w6WcWuEbs00aCMD5zSPUW3NcM
 B/huIlftPJ/ugddyWl+fFCILqYt/S8IFVenn+bdwJzp6UsuyiTBHvH9uvV5Gd9g+Q560
 HehTAN2G8PXEM0hDDL26wzGEhB55ow48vko78kVKIZ7JOTLE1gEItLxlibEALYs85x6T 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31jppnyg1r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 Jun 2020 12:09:17 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3B2C810002A;
        Thu, 11 Jun 2020 12:09:16 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id F075B20F366;
        Thu, 11 Jun 2020 12:09:15 +0200 (CEST)
Received: from [10.211.9.250] (10.75.127.45) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 11 Jun
 2020 12:09:14 +0200
Subject: Re: [PATCH v2] iio: adc: stm32-adc: fix runtime autosuspend delay
 when slow polling
To:     Jonathan Cameron <jic23@kernel.org>, <rjw@rjwysocki.net>,
        <ulf.hansson@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <benjamin.gaignard@st.com>, <alexandre.torgue@st.com>,
        <olivier.moysan@st.com>, <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1588163348-31640-1-git-send-email-fabrice.gasnier@st.com>
 <20200503124811.0abf7655@archlinux>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <b6e7d22c-2ea9-19f8-6065-519860575077@st.com>
Date:   Thu, 11 Jun 2020 12:09:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200503124811.0abf7655@archlinux>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-11_10:2020-06-10,2020-06-11 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 5/3/20 1:48 PM, Jonathan Cameron wrote:
> On Wed, 29 Apr 2020 14:29:08 +0200
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
>> When the ADC is runtime suspended and starting a conversion, the stm32-adc
>> driver calls pm_runtime_get_sync() that gets cascaded to the parent
>> (e.g. runtime resume of stm32-adc-core driver). This also kicks the
>> autosuspend delay (e.g. 2s) of the parent.
>> Once the ADC is active, calling pm_runtime_get_sync() again (upon a new
>> capture) won't kick the autosuspend delay for the parent (stm32-adc-core
>> driver) as already active.
>>
>> Currently, this makes the stm32-adc-core driver go in suspend state
>> every 2s when doing slow polling. As an example, doing a capture, e.g.
>> cat in_voltageY_raw at a 0.2s rate, the auto suspend delay for the parent
>> isn't refreshed. Once it expires, the parent immediately falls into
>> runtime suspended state, in between two captures, as soon as the child
>> driver falls into runtime suspend state:
>> - e.g. after 2s, + child calls pm_runtime_put_autosuspend() + 100ms
>>   autosuspend delay of the child.
>> - stm32-adc-core switches off regulators, clocks and so on.
>> - They get switched on back again 100ms later in this example (at 2.2s).
>>
>> So, use runtime_idle() callback in stm32-adc-core driver to call
>> pm_runtime_mark_last_busy() for the parent driver (stm32-adc-core),
>> to avoid this.
>>
>> Fixes: 9bdbb1139ca1 ("iio: adc: stm32-adc: add power management support")
>>
>> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> 
> Whilst this seems 'sensible' to me, I really don't have a good enough grasp
> of runtime pm to be sure. 
> 
> I see something similar looking in the greybus driver, but not sure on the
> reason it is there.
> 
> Hence, ideally looking for an ack from Rafael on this one!

Hi,

Gentle reminder, I'm not sure how to progress on this patch.

Rafael, or maybe Ulf, could take a look at it ?

Thanks in advance,
Best Regards,
Fabrice

> 
> Thanks,
> 
> Jonathan
> 
>> ---
>> Changes in v2:
>> - Use runtime_idle callback in stm32-adc-core driver, instead of refreshing
>>   last_busy from the child (for the parent) at many place. Initial patch v1
>>   looked like "somewhat adhoc solution" as commented by Jonathan.
>> ---
>>  drivers/iio/adc/stm32-adc-core.c | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
>> index 2df88d2..ebe5dbc 100644
>> --- a/drivers/iio/adc/stm32-adc-core.c
>> +++ b/drivers/iio/adc/stm32-adc-core.c
>> @@ -803,6 +803,13 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
>>  {
>>  	return stm32_adc_core_hw_start(dev);
>>  }
>> +
>> +static int stm32_adc_core_runtime_idle(struct device *dev)
>> +{
>> +	pm_runtime_mark_last_busy(dev);
>> +
>> +	return 0;
>> +}
>>  #endif
>>  
>>  static const struct dev_pm_ops stm32_adc_core_pm_ops = {
>> @@ -810,7 +817,7 @@ static const struct dev_pm_ops stm32_adc_core_pm_ops = {
>>  				pm_runtime_force_resume)
>>  	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
>>  			   stm32_adc_core_runtime_resume,
>> -			   NULL)
>> +			   stm32_adc_core_runtime_idle)
>>  };
>>  
>>  static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
> 
