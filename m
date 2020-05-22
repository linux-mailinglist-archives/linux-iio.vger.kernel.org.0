Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D67C1DE5F8
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728853AbgEVL6h (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 07:58:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:56133 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbgEVL6g (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 07:58:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590148715; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2bSS0nFqBz4iySfZO6bq+1InBVAHc8QrH0Hb9FnE1kw=; b=Kgum6m4YDKk83CYZ7iJ+of0+2Jb2QicoU/Cl55nzL1PPj9RsoM/DCY+Ye9DOuaqlSrn6Ulfl
 4/b08hkGkHftLIc2J9gwIdK47EEaEjsgjoeySccxnjT/CKUAgVE6QKt8ZMO6ogWRisicqBb3
 G0UAK4i1QUr1Fp/yMeNpZz+PwJs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5ec7be5d7171b6d7e4df89f3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 22 May 2020 11:58:21
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 32A51C43387; Fri, 22 May 2020 11:58:21 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.44.159.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4C8B9C433C6;
        Fri, 22 May 2020 11:58:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4C8B9C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V4 3/5] iio: adc: Add support for PMIC7 ADC
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
 <1589361736-816-4-git-send-email-jprakash@codeaurora.org>
 <CAHp75VedM+=+m8WF=zPpUcizgCGareYuBzUfjKwesozVSY_gKg@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <50ad0f74-22cc-c74f-afa4-df654e29bebb@codeaurora.org>
Date:   Fri, 22 May 2020 17:28:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VedM+=+m8WF=zPpUcizgCGareYuBzUfjKwesozVSY_gKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 5/13/2020 3:18 PM, Andy Shevchenko wrote:
> On Wed, May 13, 2020 at 12:23 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
>> +#define ADC7_CONV_TIMEOUT                      msecs_to_jiffies(10)
> ...
>
>> +       ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>> +       if (ret < 0)
> Is ' < 0' part necessary?
> Ditto for same cases in other places in the code.
I'll fix this at all required locations in this patch in the next post.
>
>> +               return ret;
> ...
>
>> +       switch (mask) {
>> +       case IIO_CHAN_INFO_PROCESSED:
>> +               ret = adc7_do_conversion(adc, prop, chan,
>> +                                       &adc_code_volt, &adc_code_cur);
>> +               if (ret)
>> +                       return ret;
>> +
>> +               ret = qcom_adc5_hw_scale(prop->scale_fn_type,
>> +                       &adc5_prescale_ratios[prop->prescale],
>> +                       adc->data,
>> +                       adc_code_volt, val);
>> +
>> +               if (ret)
>> +                       return ret;
>> +
>> +               return IIO_VAL_INT;
>> +       default:
>> +               return -EINVAL;
>> +       }
>> +
>> +       return 0;
> Dead code?
Right, I'll remove it in the next post.
>
> ...
>
>> +static int qcom_vadc7_scale_hw_calib_die_temp(
>> +                               const struct vadc_prescale_ratio *prescale,
>> +                               const struct adc5_data *data,
>> +                               u16 adc_code, int *result_mdec)
>> +{
>> +
>> +       int voltage, vtemp0, temp, i = ARRAY_SIZE(adcmap7_die_temp) - 1;
> How assignment to i is useful?


I'm using it in adcmap7_die_temp[i] below, to keep it within the 
character limit per line. I think it's more readable that way.

>
>> +       voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
>> +                               prescale, data, 1);
>> +
>> +       if (adcmap7_die_temp[0].x > voltage) {
>> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
>> +               return 0;
>> +       } else if (adcmap7_die_temp[i].x <= voltage) {
> Redundant 'else'.
The expression is different, it's adcmap7_die_temp[i] here, not 
adcmap7_die_temp[0].

>
>> +               *result_mdec = DIE_TEMP_ADC7_MAX;
>> +               return 0;
>> +       }
>> +
>> +       for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
>> +               if (adcmap7_die_temp[i].x > voltage)
>> +                       break;
>> +
>> +       vtemp0 = adcmap7_die_temp[i - 1].x;
>> +       voltage = voltage - vtemp0;
>> +       temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
>> +               adcmap7_die_temp[i - 1].y);
>> +       temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
>> +       *result_mdec = temp;
>> +
>> +       return 0;
>> +}
> ...
>
>> +#define RATIO_MAX_ADC7         0x4000
> Hmm... Why the last is in hex? Is it related to amount of bits in the
> hardware? Then probably better to use BIT().
It is the upper limit reading for a ratiometric calibration measurement, 
which is reported as a 14 bit reading. I'll change this in the next post.
>
