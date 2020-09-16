Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717D026CDFD
	for <lists+linux-iio@lfdr.de>; Wed, 16 Sep 2020 23:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgIPVH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 16 Sep 2020 17:07:28 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:20452 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726360AbgIPQDk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 16 Sep 2020 12:03:40 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GAvX4k010624;
        Wed, 16 Sep 2020 13:03:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=HNBudS2dbgbIeBYY8ROk2CZK0Qs8u5XisjljitaW750=;
 b=czB7QETTybsqNQT8vRc3WJlJz9uwS1NsPfLhneVlioHCZaRTg+nh64gudZRbf1KrAN1C
 379MJyk6AV46Pzv5ybTTM3hZoKzgoMWjNQz8cvt4iLRV0U+UNha/GW6IP7daO8PSNLkW
 faUbA8bRyBcDjBWboGHOMZ8/7GvVzB2Q+4Ex1Oihxt7byyXETGt6nelsxjgxLJGV3gDL
 Wu9eQRSjvPMPMLSipZxLP3nq4Trp6dmyruM3U2SRFgLW88LH36kcHMnl0iDyIlVh+AFN
 +o2FIp83dKTEgz0aUhsBxBHo2Fez6+skDQREczVB0mlMU1yTafxNveBTqkuUbQjJbBpb Uw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33k691bg39-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 13:03:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 999FE1000AF;
        Wed, 16 Sep 2020 12:28:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag5node3.st.com [10.75.127.15])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DE8821CA87;
        Wed, 16 Sep 2020 12:28:01 +0200 (CEST)
Received: from [10.48.1.149] (10.75.127.47) by SFHDAG5NODE3.st.com
 (10.75.127.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 16 Sep
 2020 12:28:00 +0200
Subject: Re: [RESEND PATCH v2] iio: adc: stm32-adc: fix runtime autosuspend
 delay when slow polling
To:     <jic23@kernel.org>, <rafael.j.wysocki@intel.com>
CC:     <rjw@rjwysocki.net>, <ulf.hansson@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <olivier.moysan@st.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <1593615328-5180-1-git-send-email-fabrice.gasnier@st.com>
From:   Fabrice Gasnier <fabrice.gasnier@st.com>
Message-ID: <045e9e34-f1e0-087b-bc5b-44440db6be27@st.com>
Date:   Wed, 16 Sep 2020 12:28:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1593615328-5180-1-git-send-email-fabrice.gasnier@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG2NODE2.st.com (10.75.127.5) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_06:2020-09-16,2020-09-16 signatures=0
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 7/1/20 4:55 PM, Fabrice Gasnier wrote:
> When the ADC is runtime suspended and starting a conversion, the stm32-adc
> driver calls pm_runtime_get_sync() that gets cascaded to the parent
> (e.g. runtime resume of stm32-adc-core driver). This also kicks the
> autosuspend delay (e.g. 2s) of the parent.
> Once the ADC is active, calling pm_runtime_get_sync() again (upon a new
> capture) won't kick the autosuspend delay for the parent (stm32-adc-core
> driver) as already active.
> 
> Currently, this makes the stm32-adc-core driver go in suspend state
> every 2s when doing slow polling. As an example, doing a capture, e.g.
> cat in_voltageY_raw at a 0.2s rate, the auto suspend delay for the parent
> isn't refreshed. Once it expires, the parent immediately falls into
> runtime suspended state, in between two captures, as soon as the child
> driver falls into runtime suspend state:
> - e.g. after 2s, + child calls pm_runtime_put_autosuspend() + 100ms
>   autosuspend delay of the child.
> - stm32-adc-core switches off regulators, clocks and so on.
> - They get switched on back again 100ms later in this example (at 2.2s).
> 
> So, use runtime_idle() callback in stm32-adc-core driver to call
> pm_runtime_mark_last_busy() for the parent driver (stm32-adc-core),
> to avoid this.
> 
> Fixes: 9bdbb1139ca1 ("iio: adc: stm32-adc: add power management support")
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> ---
> Changes in v2:
> - Use runtime_idle callback in stm32-adc-core driver, instead of refreshing
>   last_busy from the child (for the parent) at many place. Initial patch v1
>   looked like "somewhat adhoc solution" as commented by Jonathan.

Hi all,

Gentle reminder for this patch. Earlier discussions on it were as per
[1] and [2].

Ideally, Jonathan was looking for an ack from Rafael on this patch.
This is a long pending issue. I'd like to progress on this.

[1] https://patchwork.kernel.org/patch/11349841/
[2] https://lkml.org/lkml/2020/6/11/279

Please advise,
Thanks in advance,
Fabrice

> ---
>  drivers/iio/adc/stm32-adc-core.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
> index 0e2068e..3586369 100644
> --- a/drivers/iio/adc/stm32-adc-core.c
> +++ b/drivers/iio/adc/stm32-adc-core.c
> @@ -794,6 +794,13 @@ static int stm32_adc_core_runtime_resume(struct device *dev)
>  {
>  	return stm32_adc_core_hw_start(dev);
>  }
> +
> +static int stm32_adc_core_runtime_idle(struct device *dev)
> +{
> +	pm_runtime_mark_last_busy(dev);
> +
> +	return 0;
> +}
>  #endif
>  
>  static const struct dev_pm_ops stm32_adc_core_pm_ops = {
> @@ -801,7 +808,7 @@ static const struct dev_pm_ops stm32_adc_core_pm_ops = {
>  				pm_runtime_force_resume)
>  	SET_RUNTIME_PM_OPS(stm32_adc_core_runtime_suspend,
>  			   stm32_adc_core_runtime_resume,
> -			   NULL)
> +			   stm32_adc_core_runtime_idle)
>  };
>  
>  static const struct stm32_adc_priv_cfg stm32f4_adc_priv_cfg = {
> 
