Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7338E1ADAE6
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 12:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgDQKWB (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729065AbgDQKWA (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 06:22:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D4ADC061A0C;
        Fri, 17 Apr 2020 03:22:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id n24so800838plp.13;
        Fri, 17 Apr 2020 03:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v9o7ZoIgzXJqKYoLABOnJkIlZshn18vcvbRXK1Q6RLo=;
        b=JL072y7f6N9gKxWfexCxBPb+cAOHoBIFmRoncRhfQWGflGo8u+SrlKcD/00whMNBK3
         HRRXDTBWkggY00aIrwHlrDUg4tak69rOsN/DtV3BskRH8nsNrmfs6pw5zywnVVstozuN
         7cMs8DzRIFSgD8ECi4Z6zVLcPxTpVBipu/xIxz/XARsbK7oIQgP/2jd4t/wBTOC0NXhI
         BHIkceqMH6YQOkNN7aPttyieDX/Tt3hE8tF5kurxIfnNQFy9lYWKPEDI3eMMG/4BtyY6
         By/PqToU4yHid/bsBWz4hxdayFKg9ZYe0bicI2PzwoJInJcUohxa7i67eX4FRzJr1XTd
         m0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v9o7ZoIgzXJqKYoLABOnJkIlZshn18vcvbRXK1Q6RLo=;
        b=f7ZvSffOI7l6oyco0w0R2IlQDu6ea93wN3MldsBdcIFgS3U6BryJRQj8kgCngnpEsj
         hAMnmwq9ylvOwAeN1Dvg/REYQeenPuqG0vCcdjoD/KWynEH+nPa20RPYfrz3tCfLLqw4
         XaXNopZr33schCUCCppH2E9Bq1QJ7TxODJWgOeIUleoHfRTelaclLwWV8JJmlenZXOTe
         feRN5+gVXB3l2V0PCWmzSrXamlfnzZ7cl9aBdPqiv10bJnjFJej1SNelB4hTrsqCfxEc
         vZdAZ+wie87euGPyxCb/zbBvPHDamt+GW+2dlQ/wrrhqUjvRqpei3s7naR3hM+7kQBmo
         g9UQ==
X-Gm-Message-State: AGi0PuaXM6otvMOkrvyXvORoSs2tlsbwGEfgNOo6xfB7W3N8yKU3oSiV
        sWzwmuaxIBCNRoOm9OYhrsaa8Qsq2lcL2/qUVIo=
X-Google-Smtp-Source: APiQypIEGsAfRI8/UwJHsSIucgqgff/1ssU16K4g8ZZGqIBHsDCN0aHDCIFkpKuw3+ht8/snHWbikJvaNPY6iTORyQk=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr3464434pjb.143.1587118919577;
 Fri, 17 Apr 2020 03:21:59 -0700 (PDT)
MIME-Version: 1.0
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org> <1586942266-21480-4-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1586942266-21480-4-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 13:21:47 +0300
Message-ID: <CAHp75VegoXJmi1rDg_-ePKqoo69Jdt7NBchCTE=bPAdJqrgYQQ@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] iio: adc: Add support for PMIC7 ADC
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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

On Thu, Apr 16, 2020 at 1:48 AM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.

Please, split pr_*() -> dev_*() to separate patch. Also think about
other logical pieces you may split out.

...

> +static const struct adc5_data adc7_data_pmic;

Global variable? Hmm...

...

> +       int ret;
> +       u8 conv_req = 0, buf[4];
> +
> +       ret = adc5_masked_write(adc, ADC_APP_SID, ADC_APP_SID_MASK, prop->sid);
> +       if (ret)
> +               return ret;
> +
> +       ret = adc5_read(adc, ADC5_USR_DIG_PARAM, buf, sizeof(buf));

> +       if (ret < 0)

Does  > 0 have a meaning?

> +               return ret;
> +
> +       /* Digital param selection */
> +       adc5_update_dig_param(adc, prop, &buf[0]);
> +
> +       /* Update fast average sample value */

> +       buf[1] &= 0xff & ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;

What the point of 0xff & part?

> +       buf[1] |= prop->avg_samples;
> +
> +       /* Select ADC channel */
> +       buf[2] = prop->channel;
> +
> +       /* Select HW settle delay for channel */
> +       buf[3] &= 0xff & ~ADC5_USR_HW_SETTLE_DELAY_MASK;

Ditto.

> +       buf[3] |= prop->hw_settle_time;

...

> +static int adc7_do_conversion(struct adc5_chip *adc,
> +                       struct adc5_channel_prop *prop,
> +                       struct iio_chan_spec const *chan,
> +                       u16 *data_volt, u16 *data_cur)
> +{
> +       int ret;

> +       u8 status = 0;

Redundant assignment.

> +       mutex_lock(&adc->lock);
> +
> +       ret = adc7_configure(adc, prop);
> +       if (ret) {
> +               dev_err(adc->dev, "ADC configure failed with %d\n", ret);
> +               goto unlock;
> +       }
> +
> +       /* No support for polling mode at present*/

Missed space

> +       wait_for_completion_timeout(&adc->complete, ADC7_CONV_TIMEOUT);
> +
> +       ret = adc5_read(adc, ADC5_USR_STATUS1, &status, 1);

> +       if (ret < 0)

Remove all ' < 0' where it is not needed.

> +               goto unlock;
> +
> +       if (status & ADC5_USR_STATUS1_CONV_FAULT) {
> +               dev_err(adc->dev, "Unexpected conversion fault\n");
> +               ret = -EIO;
> +               goto unlock;
> +       }
> +
> +       ret = adc5_read_voltage_data(adc, data_volt);
> +
> +unlock:
> +       mutex_unlock(&adc->lock);

...

> +       for (i = 0; i < adc->nchannels; i++) {

> +               v_channel = (adc->chan_props[i].sid << ADC_CHANNEL_OFFSET |
> +                       adc->chan_props[i].channel);

Too many parentheses or they are in a wrong position. I don't remember
operator precedence by heart.

> +               if (v_channel == iiospec->args[0])
> +                       return i;
> +       }

...

> +       /*
> +        * Value read from "reg" is virtual channel number
> +        * virtual channel number = (sid << 8 | channel number).

Too many parentheses. And perhaps formulas better to have on a separate line.

> +        */

...

> +static const struct vadc_map_pt adcmap7_100k[] = {
> +       { 4250657, -40960 },
> +       { 3962085, -39936 },

> +       { 419448, -3072 },
> +       { 396851, -2048 },
> +       { 375597, -1024 },
> +       { 355598, 0 },
> +       { 336775, 1024 },
> +       { 319052, 2048 },
> +       { 302359, 3072 },

> +       { 2560, 128000 },
> +       { 2489, 129024 },
> +       { 2420, 130048 }
> +};

I'm wondering why you have second column here? Can't you derive it
from index? Seems to me pretty easy calculus.

...

> +       int ret, result = 0;

Redundant assignment.

> +       if (adc_code >= RATIO_MAX_ADC7)
> +               return -EINVAL;
> +
> +       /* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/
> +       resistance *= R_PU_100K;
> +       resistance = div64_s64(resistance, RATIO_MAX_ADC7 - adc_code);
> +
> +       ret = qcom_vadc_map_voltage_temp(adcmap7_100k,
> +                                ARRAY_SIZE(adcmap7_100k),
> +                                resistance, &result);
> +       if (ret)
> +               return ret;
> +
> +       *result_mdec = result;

...

> +       for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
> +               if (adcmap7_die_temp[i].x > voltage)
> +                       break;
> +

> +       if (i == 0) {
> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
> +       } else if (i == ARRAY_SIZE(adcmap7_die_temp)) {
> +               *result_mdec = DIE_TEMP_ADC7_MAX;

I think you can done these checks before loop, and return immediately.

> +       } else {
> +               vtemp0 = adcmap7_die_temp[i - 1].x;
> +               voltage = voltage - vtemp0;
> +               temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
> +                       adcmap7_die_temp[i - 1].y);
> +               temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
> +               *result_mdec = temp;
> +       }

-- 
With Best Regards,
Andy Shevchenko
