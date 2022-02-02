Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3E14A764E
	for <lists+linux-iio@lfdr.de>; Wed,  2 Feb 2022 17:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346067AbiBBQ5i (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Feb 2022 11:57:38 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:58652 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1346064AbiBBQ5h (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Feb 2022 11:57:37 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 212CBB3R026626;
        Wed, 2 Feb 2022 17:57:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=zJ1ktvO9XOJYSwo/QvjjMNUhkMtUvUVmHlLQgswZVWI=;
 b=wTqz1+aNbaMYLit8E22BqzfajLAPbZgmpwPu+mXuZZhL/FXtsxHqw9MXFbQ73ZaulQbG
 PHWnh5avfyrJ+VON9232s0LpBCH06cdZrGlROJ2IrIgMHR3G4HzsfaYaXnat4Y2O5cyn
 hxJMKPazo0v8w01XzEkR11SaIra8EKY8gG04SmhM7EgFJMp2cj8egQhqQjOsoURmgrVJ
 iDIyj2Skofewr321/C9C0jb4BIPS2G2NaXzhUJ7j+ZUmju08MItTcOKcoL9XPlrHIwfi
 rHWWW0P/MohZirTZXVQp8hEjv0yzTS2EAlLb9z0DvprN1RrLFihxo7JjJhmAPbyfVOhS yQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dysr31dvh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Feb 2022 17:57:14 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5CB7E10002A;
        Wed,  2 Feb 2022 17:57:13 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4AEDF229A9C;
        Wed,  2 Feb 2022 17:57:13 +0100 (CET)
Received: from [10.48.0.112] (10.75.127.49) by SFHDAG2NODE2.st.com
 (10.75.127.5) with Microsoft SMTP Server (TLS) id 15.0.1497.26; Wed, 2 Feb
 2022 17:57:12 +0100
Subject: Re: [PATCH v2 03/12] iio: adc: stm32-dfsdm: Avoid dereferencing
 ->currentmode
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-iio@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
CC:     Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
References: <20220202140208.391394-1-miquel.raynal@bootlin.com>
 <20220202140208.391394-4-miquel.raynal@bootlin.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Message-ID: <c13d3155-d851-f060-c8e4-cb93670b7faa@foss.st.com>
Date:   Wed, 2 Feb 2022 17:57:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20220202140208.391394-4-miquel.raynal@bootlin.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-02_08,2022-02-01_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 2/2/22 3:01 PM, Miquel Raynal wrote:
> This is an internal variable of the core, let's use the
> iio_buffer_enabled() helper which is exported for the following purpose:
> telling if the current mode is a buffered mode, which is precisely what
> this driver looks for.
> 
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Hi Miquel,

Thanks for your patch, and your answer in v1.

Please feel free to add my:
Reviewed-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>

Best Regards,
Fabrice

>  drivers/iio/adc/stm32-dfsdm-adc.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 1cfefb3b5e56..a3b8827d3bbf 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -466,8 +466,7 @@ static int stm32_dfsdm_channels_configure(struct iio_dev *indio_dev,
>  	 * In continuous mode, use fast mode configuration,
>  	 * if it provides a better resolution.
>  	 */
> -	if (adc->nconv == 1 && !trig &&
> -	    (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)) {
> +	if (adc->nconv == 1 && !trig && iio_buffer_enabled(indio_dev)) {
>  		if (fl->flo[1].res >= fl->flo[0].res) {
>  			fl->fast = 1;
>  			flo = &fl->flo[1];
> @@ -562,7 +561,7 @@ static int stm32_dfsdm_filter_configure(struct iio_dev *indio_dev,
>  		cr1 = DFSDM_CR1_RCH(chan->channel);
>  
>  		/* Continuous conversions triggered by SPI clk in buffer mode */
> -		if (indio_dev->currentmode & INDIO_BUFFER_SOFTWARE)
> +		if (iio_buffer_enabled(indio_dev))
>  			cr1 |= DFSDM_CR1_RCONT(1);
>  
>  		cr1 |= DFSDM_CR1_RSYNC(fl->sync_mode);
> 
