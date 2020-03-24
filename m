Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F261919167D
	for <lists+linux-iio@lfdr.de>; Tue, 24 Mar 2020 17:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCXQdk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 24 Mar 2020 12:33:40 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35486 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727161AbgCXQdk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 24 Mar 2020 12:33:40 -0400
Received: by mail-pg1-f194.google.com with SMTP id 7so9301645pgr.2;
        Tue, 24 Mar 2020 09:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iyN1hBaAFSOHm3J/cqXgvfDBZR4y77oHwv+quvoJ2Ow=;
        b=n0yORBkxyDKz3l+5kEyjxxdVxjiqvfxWjr9KzX7zthOx3zoi4FaxmCBPHrzaATQ+DR
         uFAmkKdf89YlaAmcZ+BiKZbr/41CEZDvzGmVgMyNiNh0qgjSIYLZWMRbyXHAAz5TKs/3
         d1TMGFu+nVqG6Gu94QrgQKIZ1qdQFlZneEAOZLf+aYtLuVr9GDnehP50IUA1MzFSNIb6
         ttXQ9ZhcbPjKHY0F4U5hVNA5OflhweFQ4r/p+8eeVnLL0tfr9f2PzMzGfQ9PKnJyvGKL
         vBAZq2R4qITHVrEOtuact0xmIaJyrCzo4+qX28D/RdlSLLTnxXHtHwqhT/othhzKHPPG
         gTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iyN1hBaAFSOHm3J/cqXgvfDBZR4y77oHwv+quvoJ2Ow=;
        b=RbJIuzVftmKzCaoxMAteLR8vkyZrsG2bfr+HvxhI/IB3adsITrc70DxQASq2eDJIH1
         I3KHdHwM1S06/hdxd898V5KttFl5eDX6gWpvy8vAeKlR+RhIuZHg/zJfeMw3s2Ph5Txc
         sGAkSGnK3x67Qw69bZ02AsHCj0V8m9I6hXQnu8eKL2UT7F588ea5albA2JBuMve55wOB
         ZEtY++GHlVboNkSZV2h82wtVWVh3xLS/r6r69VaroHJr+4LkbMNfJ3MzXbJZfnziwrhj
         HfPAcga6fVYrpe+hFQuOfz375rXj28uExLreCRTrJJy1mLeNkRe8ZDqt9g89/eeU8K7n
         vRVw==
X-Gm-Message-State: ANhLgQ3Wo4Yooh8t65MxlktFKASkAplOS3IcLTS1jNlcb86r3f5HYYlj
        nda5PhrUHNkcPlEm2vOcZUd6wW2nqPWSeKH95YEpAOtXuB1a/g==
X-Google-Smtp-Source: ADFU+vunIaPHWUUqedQrpgKWtpPoP3M7Xizwmytl/c1HZPLqo46nZbzfQGaudS9BltKy1Pv3nq8w/yYVltMJ7cU06ZA=
X-Received: by 2002:a63:798a:: with SMTP id u132mr29374862pgc.203.1585067618685;
 Tue, 24 Mar 2020 09:33:38 -0700 (PDT)
MIME-Version: 1.0
References: <1585064650-16235-1-git-send-email-jprakash@codeaurora.org> <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
In-Reply-To: <1585064650-16235-4-git-send-email-jprakash@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 24 Mar 2020 18:33:31 +0200
Message-ID: <CAHp75Vfk1DZ+bz6h_prm6Tp7kXos6jio5JCpg6=wvGRmDPTBsw@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: adc: Add support for PMIC7 ADC
To:     Jishnu Prakash <jprakash@codeaurora.org>
Cc:     agross@kernel.org, Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        smohanad@codeaurora.org, kgunda@codeaurora.org,
        aghayal@codeaurora.org, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-arm-msm-owner@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Mar 24, 2020 at 5:46 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
>
> The ADC architecture on PMIC7 is changed as compared to PMIC5. The
> major change from PMIC5 is that all SW communication to ADC goes through
> PMK8350, which communicates with other PMICs through PBS when the ADC
> on PMK8350 works in master mode. The SID register is used to identify the
> PMICs with which the PBS needs to communicate. Add support for the same.
>
> In addition, add definitions for ADC channels and virtual channel
> definitions per PMIC, to be used by ADC clients for PMIC7.

...

> +#define ADC_CHANNEL_OFFSET                     0x8
> +#define ADC_CHANNEL_MASK                       0xff

GENMASK()

...

> +#define ADC_APP_SID                            0x40
> +#define ADC_APP_SID_MASK                       0xf

GENMASK()

> +#define ADC7_CONV_TIMEOUT                      msecs_to_jiffies(10)

Useless.

...

> +       buf[1] &= (u8) ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;

Use '0xFF ^ _MASK' instead of casting.

...

> +       buf[3] &= (u8) ~ADC5_USR_HW_SETTLE_DELAY_MASK;

Ditto.

...

> +       ret = adc5_write(adc, ADC5_USR_CONV_REQ, &conv_req, 1);
> +
> +       return ret;

return adc5_write(...);

...

> +               pr_err("ADC configure failed with %d\n", ret);

Use dev_*() instead everywhere.

...

> +       /* No support for polling mode at present*/
> +       wait_for_completion_timeout(&adc->complete,
> +                                       ADC7_CONV_TIMEOUT);

One line. The limit is 80 and it can be bend in some cases a little bit.

...

> +               v_channel = ((adc->chan_props[i].sid << ADC_CHANNEL_OFFSET) |
> +                       adc->chan_props[i].channel);

Too many parentheses.

...

> +               sid = (chan >> ADC_CHANNEL_OFFSET);
> +               chan = (chan & ADC_CHANNEL_MASK);

Ditto.

...

> +                       (adc->is_pmic7))

Ditto.

...

> +       if (of_device_is_compatible(node, "qcom,spmi-adc7")) {
> +               indio_dev->info = &adc7_info;
> +               adc->is_pmic7 = true;
> +       } else {
> +               indio_dev->info = &adc5_info;
> +       }

Hmm... I would rather put this as driver_data in ID structure(s).

...

> +static int adc5_exit(struct platform_device *pdev)
> +{
> +       struct adc5_chip *adc = platform_get_drvdata(pdev);
> +

> +       mutex_destroy(&adc->lock);

Are you sure you will have no race conditions? Does this driver use IRQs?

> +       return 0;
> +}

...

> +       s64 resistance = 0;

= adc_code  // or sign extended variant if needed.

> +       /* (ADC code * R_PULLUP (100Kohm)) / (full_scale_code - ADC code)*/

> +       resistance = (s64) adc_code * R_PU_100K;
> +       resistance = div64_s64(resistance, (RATIO_MAX_ADC7 - adc_code));

 resistance *= R_PU_100K;
 resistance = div64_s64(resistance, RATIO_MAX_ADC7 - adc_code);

...

> +       int voltage, vtemp0, temp, i = 0;

> +       while (i < ARRAY_SIZE(adcmap7_die_temp)) {
> +               if (adcmap7_die_temp[i].x > voltage)
> +                       break;
> +               i++;
> +       }

for loop (one line less, more explicit initial value assignment)?

-- 
With Best Regards,
Andy Shevchenko
