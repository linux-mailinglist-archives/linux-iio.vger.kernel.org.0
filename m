Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFD546D099A
	for <lists+linux-iio@lfdr.de>; Thu, 30 Mar 2023 17:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233090AbjC3Pbe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Mar 2023 11:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbjC3Pb3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Mar 2023 11:31:29 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D332ED524
        for <linux-iio@vger.kernel.org>; Thu, 30 Mar 2023 08:31:13 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32UDIgRd027659;
        Thu, 30 Mar 2023 17:30:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=vclZGwjFovBc37Bi5vGN1t0oZHb63VyxRmpvirSmPBM=;
 b=aoD4GHP4QPuBfBLS2aSaeW/6N9RQKXZiZTeNsUAe78IpgPmsZ7oHKnAIcp5BHbg/eflp
 5VMDpywGP2VUVoS7Zn5MQCAIfjgenHXwOfVNno5LSpUq03eGdopFCffJndnCt3AQvAhi
 HQh4fz7dYd60o1FXvRlmtLq9umvUOwysfVaJ/cCf0fdOEgqmhEyOu89wD2uD+ySW6tR/
 GeP7TiE1+uRSs2Qbo/PESb664F4Pc3khEbShe3DN+SL07kuvFRssovZH9aA6QsIZfwjT
 WkBz96c6EfT9UmDUZKcyCRRbL81sqNnQ+mpvGDf0UEj5TQpf5AI8eUGNaZAHx5aU1N81 TA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3pn7nh2ba2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Mar 2023 17:30:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2580F100056;
        Thu, 30 Mar 2023 17:30:33 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 19BF1226FAB;
        Thu, 30 Mar 2023 17:30:33 +0200 (CEST)
Received: from [10.48.1.102] (10.48.1.102) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 30 Mar
 2023 17:30:32 +0200
Message-ID: <56c019d4-832e-17e1-19f8-7d8bd927c1bb@foss.st.com>
Date:   Thu, 30 Mar 2023 17:30:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [Linux-stm32] [PATCH 1/3] iio: adc: stm32-adc: warn if dt uses
 legacy channel config
Content-Language: en-US
To:     Sean Nyekjaer <sean@geanix.com>, <jic23@kernel.org>,
        <lars@metafoo.de>, <alexandre.torgue@foss.st.com>,
        <nuno.sa@analog.com>
CC:     <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
References: <20230327083449.1098174-1-sean@geanix.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20230327083449.1098174-1-sean@geanix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.1.102]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-30_09,2023-03-30_03,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/27/23 10:34, Sean Nyekjaer wrote:
> Since nearly all stm32 dt's are using the legacy adc channel config,
> we should warn users about using it.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
>  drivers/iio/adc/stm32-adc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
> index 1aadb2ad2cab..d8e755d0cc52 100644
> --- a/drivers/iio/adc/stm32-adc.c
> +++ b/drivers/iio/adc/stm32-adc.c
> @@ -1993,6 +1993,8 @@ static int stm32_adc_get_legacy_chan_count(struct iio_dev *indio_dev, struct stm
>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;
>  	int num_channels = 0, ret;
>  
> +	dev_warn(&indio_dev->dev, "using legacy channel config\n");
> +

Hi Sean,

I'd recommend to avoid adding a dev_warn() on a per driver basis, for
depreacted DT properties. Still I'm not sure if there's some policy in
this area.

IMHO, deprecated properties should be checked by using dt tools
(dt_binding_check / dtbs_check or other mean?). But I have no idea if
this is going to report warnings and when. Purpose would be to avoid
introducing no dts files with these. As commented by Olivier on Patch 3,
we've some downstream patches to adopt the generic bindings (not
upstream 'yet').

Another downside is regarding backward compatibility. In case an old dtb
is used to boot the kernel, as long as there's no functionality loss,
I'd advise not to use any warning here. That's a valid use of an old dt.

In all case, thanks for pointing issues (e.g. Patch 2 & 3), regarding
this patch, I'd nack adding this warning. Please drop this change if you
re-submit or turn this into a dev_dbg().

Best Regards,
Fabrice

>  	ret = device_property_count_u32(dev, "st,adc-channels");
>  	if (ret > adc_info->max_channels) {
>  		dev_err(&indio_dev->dev, "Bad st,adc-channels?\n");
