Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944451D0EF8
	for <lists+linux-iio@lfdr.de>; Wed, 13 May 2020 12:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733024AbgEMJsQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 13 May 2020 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733027AbgEMJsO (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 13 May 2020 05:48:14 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36E5C061A0C;
        Wed, 13 May 2020 02:48:14 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so10872597pjb.1;
        Wed, 13 May 2020 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bjsu2SAJTtr2kJH3ue6aN6Ti78fmHhbAVyvMhimqSsQ=;
        b=LWVGtdUt6YPbFWykGS5kdFT+p0sVsgqjSJe4RbMQBERznbDkMTrHlo77rtHp35J6uD
         mgf4IfTuol9BBCv6jCKmgDYzexxLwY611GiaX8yeLHviv7RkPvLc+WUhUolsGzPZrJ0z
         4NxoLPO6kqnM0p+h2fwfyl/pCGVEuw2sWekgQTJwk8wJP92OwvVfaSlRcWufagqMEzhX
         fFewiwgTYH+qIeug1diJ9uXyWNw5cxwTwk4bkgQFc5zEr9O7xDnFeUJsx4f19e+/WsBO
         SvaqYjrAv/t/CmbeujlpKF7GXfJYxGt9tQO8zIFNzuMf7VjSZZZnOmjHrK4yQJB5CnbW
         GlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bjsu2SAJTtr2kJH3ue6aN6Ti78fmHhbAVyvMhimqSsQ=;
        b=TPJYaDpp56h/8jqYELr0c85GXbpPfMRtn9KLQuyFTuQN/0PG4wEh6/ZqHbqd6mWpEf
         ES5QfT+jhCwh1vFBbzcH02UC170lBpS9NZF4MEfyk7QH6cfv4NLdDtuCWl1oe52HSxZD
         bx+1zYpqbFzZVTSi2KRrI0DP64B3TuxYag3dDGTnGLl+uRxtjmn14Rh0xiNYTmqk2m1Q
         JzijgsyzxYyJvMfS9pqWkNLVQcCZr5rt69P40cXFeop+hSfmInm3buRMjM1G46LoFj4O
         dkC684SKAxYPBkfIoZMWIA2+LfUET/KyXKvuXN8s1TmZUxcmm8qNpr3dAeh08IZnTBxA
         FbKA==
X-Gm-Message-State: AGi0PubjjW6CO/dFAWTbwbHfgBooqaMn6Mc44RERTkbRuLsNPIrFiwH9
        +armH2q/dbWO+lKgWkTaxoSmGXZMKNz4GaoVdkc=
X-Google-Smtp-Source: APiQypK+UYacLdCsTsRxHMMOZPFez8xItFlhrNgGL222RcsdOJVS0GeWd82dTmjrD7vpBSnJU10Webmi2EBRKf2/jqQ=
X-Received: by 2002:a17:90b:94a:: with SMTP id dw10mr34235868pjb.228.1589363294097;
 Wed, 13 May 2020 02:48:14 -0700 (PDT)
MIME-Version: 1.0
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org> <1589361736-816-4-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1589361736-816-4-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 13 May 2020 12:48:07 +0300
Message-ID: <CAHp75VedM+=+m8WF=zPpUcizgCGareYuBzUfjKwesozVSY_gKg@mail.gmail.com>
Subject: Re: [PATCH V4 3/5] iio: adc: Add support for PMIC7 ADC
To:     Jishnu Prakash <jprakash@codeaurora.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, May 13, 2020 at 12:23 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.

> +#define ADC7_CONV_TIMEOUT                      msecs_to_jiffies(10)

...

> +       ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));
> +       if (ret < 0)

Is ' < 0' part necessary?
Ditto for same cases in other places in the code.

> +               return ret;

...

> +       switch (mask) {
> +       case IIO_CHAN_INFO_PROCESSED:
> +               ret = adc7_do_conversion(adc, prop, chan,
> +                                       &adc_code_volt, &adc_code_cur);
> +               if (ret)
> +                       return ret;
> +
> +               ret = qcom_adc5_hw_scale(prop->scale_fn_type,
> +                       &adc5_prescale_ratios[prop->prescale],
> +                       adc->data,
> +                       adc_code_volt, val);
> +
> +               if (ret)
> +                       return ret;
> +
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }

> +
> +       return 0;

Dead code?

...

> +static int qcom_vadc7_scale_hw_calib_die_temp(
> +                               const struct vadc_prescale_ratio *prescale,
> +                               const struct adc5_data *data,
> +                               u16 adc_code, int *result_mdec)
> +{
> +
> +       int voltage, vtemp0, temp, i = ARRAY_SIZE(adcmap7_die_temp) - 1;

How assignment to i is useful?

> +       voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
> +                               prescale, data, 1);
> +
> +       if (adcmap7_die_temp[0].x > voltage) {
> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
> +               return 0;

> +       } else if (adcmap7_die_temp[i].x <= voltage) {

Redundant 'else'.

> +               *result_mdec = DIE_TEMP_ADC7_MAX;
> +               return 0;
> +       }
> +
> +       for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
> +               if (adcmap7_die_temp[i].x > voltage)
> +                       break;
> +
> +       vtemp0 = adcmap7_die_temp[i - 1].x;
> +       voltage = voltage - vtemp0;
> +       temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
> +               adcmap7_die_temp[i - 1].y);
> +       temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
> +       *result_mdec = temp;
> +
> +       return 0;
> +}

...

> +#define RATIO_MAX_ADC7         0x4000

Hmm... Why the last is in hex? Is it related to amount of bits in the
hardware? Then probably better to use BIT().

-- 
With Best Regards,
Andy Shevchenko
