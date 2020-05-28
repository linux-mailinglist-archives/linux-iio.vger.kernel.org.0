Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60EB11E67B1
	for <lists+linux-iio@lfdr.de>; Thu, 28 May 2020 18:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405181AbgE1QrW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 May 2020 12:47:22 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:60961 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405101AbgE1QrV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 May 2020 12:47:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590684439; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=T4tupt5NAgmORde5nrj9W65EYS8aJc0xInYBse0Y2do=; b=h/hrpo617JM2vt/vjqGOGoGEngRnoJfsjrWQsjNPqsD9cN+GdTw5GuPhDoxd2v2/XyxfbDuz
 keJUjSqpF5uGUJFsZlZROgf4SZ/Kz1rHp1amefzHMvUTP7RKsE5HmPNvb5NYrBPv0WkhoOyk
 o4DBVKZfhsgPpSRSsHPZ+vHdIZ0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3Mzk1NyIsICJsaW51eC1paW9Admdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ecfeb173ac6f4f603eb2b87 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 16:47:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21FA2C433CA; Thu, 28 May 2020 16:47:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from [192.168.1.102] (unknown [157.47.99.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jprakash)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9B2C2C43391;
        Thu, 28 May 2020 16:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9B2C2C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jprakash@codeaurora.org
Subject: Re: [PATCH V5 3/5] iio: adc: Add support for PMIC7 ADC
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
References: <1590157452-27179-1-git-send-email-jprakash@codeaurora.org>
 <1590157452-27179-4-git-send-email-jprakash@codeaurora.org>
 <CAHp75Vfgk0-Rye2We1A6_WTWMCK3D-WW4_T3CGPHc=-tB=6M9g@mail.gmail.com>
From:   Jishnu Prakash <jprakash@codeaurora.org>
Message-ID: <81ef429e-48d5-48b3-b344-3a48c2287907@codeaurora.org>
Date:   Thu, 28 May 2020 22:17:08 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vfgk0-Rye2We1A6_WTWMCK3D-WW4_T3CGPHc=-tB=6M9g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 5/22/2020 9:07 PM, Andy Shevchenko wrote:
> On Fri, May 22, 2020 at 5:25 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
>> major change from PMIC5 is that all SW communication to ADC goes through
>> PMK8350, which communicates with other PMICs through PBS when the ADC
>> on PMK8350 works in master mode. The SID register is used to identify the
>> PMICs with which the PBS needs to communicate. Add support for the same.
> Below should be in a separate patch, but it's a bikeshedding. So, I
> left it to maintainers to decide.
> Fine with me
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> ...
>
>> @@ -285,7 +304,7 @@ static int adc5_configure(struct adc5_chip *adc,
>>
>>          /* Read registers 0x42 through 0x46 */
>>          ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
>> -       if (ret < 0)
>> +       if (ret)
>>                  return ret;
>>
>>          /* Digital param selection */
> ...
>
>> @@ -331,7 +391,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>>
>>          if (adc->poll_eoc) {
>>                  ret = adc5_poll_wait_eoc(adc);
>> -               if (ret < 0) {
>> +               if (ret) {
>>                          pr_err("EOC bit not set\n");
>>                          goto unlock;
>>                  }
>> @@ -341,7 +401,7 @@ static int adc5_do_conversion(struct adc5_chip *adc,
>>                  if (!ret) {
>>                          pr_debug("Did not get completion timeout.\n");
>>                          ret = adc5_poll_wait_eoc(adc);
>> -                       if (ret < 0) {
>> +                       if (ret) {
>>                                  pr_err("EOC bit not set\n");
>>                                  goto unlock;
>>                          }
> ...
>
>> @@ -406,8 +519,38 @@ static int adc5_read_raw(struct iio_dev *indio_dev,
>>          default:
>>                  return -EINVAL;
>>          }
>> +}
>>
>> -       return 0;
> (this one looks like standalone change from above)
>
> ...
>
>> @@ -570,7 +762,7 @@ static int adc5_get_dt_channel_data(struct adc5_chip *adc,
>>
>>                  ret = adc5_read(adc, ADC5_USR_REVISION1, dig_version,
>>                                                          sizeof(dig_version));
>> -               if (ret < 0) {
>> +               if (ret) {
>>                          dev_err(dev, "Invalid dig version read %d\n", ret);
>>                          return ret;
>>                  }
> ...
>
>> +       if (of_device_is_compatible(node, "qcom,spmi-adc7"))
>> +               indio_dev->info = &adc7_info;
>> +       else
>> +               indio_dev->info = &adc5_info;
> Can we use driver_data?
I'll make the change in a patch before this one in the next post.
>
> ...
>
>> +       if (adcmap7_die_temp[0].x > voltage) {
>> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
>> +               return 0;
>> +       } else if (adcmap7_die_temp[i].x <= voltage) {
> As per previous comment, redundant 'else' and please use value of i
> directly here.
I'll add the change in the next post.

>
>
