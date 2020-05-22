Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CC41DEBDC
	for <lists+linux-iio@lfdr.de>; Fri, 22 May 2020 17:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbgEVPbS (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 22 May 2020 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729851AbgEVPbR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 22 May 2020 11:31:17 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDCCC061A0E;
        Fri, 22 May 2020 08:31:17 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id z26so5338891pfk.12;
        Fri, 22 May 2020 08:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SSLvHrUrUmnP+J7EUaDe7T1ErKWhhTBSuFxFKbP5p2U=;
        b=BDzT50X4coOikh70Rqyz4HIZVxhBJy6tMg7dg9A0Bg1ifgpbm0V3hjmHvn1rMK3PEd
         /qMrIu8iNjKTKRWpT8Jbk7dtDxRjGFKboNsPH2O9H11NdshCEZZL4n5czFNxzuorYO2V
         QGgZuCQpICm2KGwKaoKHbPprG9wGuf+R/XU1p0tLI7QRX9YNCGCfu2gByZRBzIAB1N41
         avM2FWs/qBUEqeJ+NOhEMOcmPJU1XIy2/Bm5fOOZX2U3qrt+1Q6HyZV9z1Ze6gsaPPDi
         7CMey5aUjddyc3RXjMykO0TzXs+CznhwuR+9h/sRwVNqGpFkPJzuiucwbiEfeUc9hyYD
         pslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SSLvHrUrUmnP+J7EUaDe7T1ErKWhhTBSuFxFKbP5p2U=;
        b=WEM+d2qKcQTKiVHLg2BwkV+am5RZaOY0sKaV5Os3v6GiSFQH1T1QEN7VURPuEaV1Jl
         Nc/Y4g2+giZsag72adS/7YJqRpro3bEDuvrhiDXZWy01gbJ1KgcGnozwcXbLx8k7wAw8
         kn0/l9R+ONNGfIq/0NssVF+LZiP2rzdGSjb/FEQUNOUpSOKp/r86w22JhydbfE18bJGC
         aV25wdEbEasxTrSE/lZkbDNkHk+ezilreLNfCJUEHdw3YghVl7YOOUZLD8bhPKhX/qbK
         tAlsIEMZlpTo/uiOYWif1X1WE5v9mdvUCLuucHihriG4JEQyV/jGxfMuXgHBksUrFrus
         VxzA==
X-Gm-Message-State: AOAM533qzoAySc+O+q1j6zqeUjMprx8zwctYjjAax7WMwuYXDrpIIR8E
        l1qIjK+i2bPnvdHFImLW6xZhr7EfxDJAWg108rs=
X-Google-Smtp-Source: ABdhPJzHqqj8fLHqrPYt8036814ISRqAPyzCPwkwOwKw/jPrnn09boo9l3HZ9RshYZIyO8CwzN4XLER+NW+Ss0UGdtY=
X-Received: by 2002:a62:2f43:: with SMTP id v64mr4328523pfv.170.1590161476980;
 Fri, 22 May 2020 08:31:16 -0700 (PDT)
MIME-Version: 1.0
References: <1589361736-816-1-git-send-email-jprakash@codeaurora.org>
 <1589361736-816-4-git-send-email-jprakash@codeaurora.org> <CAHp75VedM+=+m8WF=zPpUcizgCGareYuBzUfjKwesozVSY_gKg@mail.gmail.com>
 <50ad0f74-22cc-c74f-afa4-df654e29bebb@codeaurora.org>
In-Reply-To: <50ad0f74-22cc-c74f-afa4-df654e29bebb@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 22 May 2020 18:31:05 +0300
Message-ID: <CAHp75Vf0srsT6yonxiA1Lc8uP4=17u5E19iWfW7XGivfgJjFNg@mail.gmail.com>
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

On Fri, May 22, 2020 at 2:58 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
> On 5/13/2020 3:18 PM, Andy Shevchenko wrote:
> > On Wed, May 13, 2020 at 12:23 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:

...

> >> +static int qcom_vadc7_scale_hw_calib_die_temp(
> >> +                               const struct vadc_prescale_ratio *prescale,
> >> +                               const struct adc5_data *data,
> >> +                               u16 adc_code, int *result_mdec)
> >> +{
> >> +
> >> +       int voltage, vtemp0, temp, i = ARRAY_SIZE(adcmap7_die_temp) - 1;
> > How assignment to i is useful?
>
>
> I'm using it in adcmap7_die_temp[i] below, to keep it within the
> character limit per line. I think it's more readable that way.
>
> >
> >> +       voltage = qcom_vadc_scale_code_voltage_factor(adc_code,
> >> +                               prescale, data, 1);
> >> +
> >> +       if (adcmap7_die_temp[0].x > voltage) {
> >> +               *result_mdec = DIE_TEMP_ADC7_SCALE_1;
> >> +               return 0;
> >> +       } else if (adcmap7_die_temp[i].x <= voltage) {

I see now i in use, please, replace with direct meaning.

> > Redundant 'else'.
> The expression is different, it's adcmap7_die_temp[i] here, not
> adcmap7_die_temp[0].

if (a) {
 ...
 return;
} else if (b) {
 ...
}

'else' is redundant due to 'return'. Same when it's 'goto'.

> >> +               *result_mdec = DIE_TEMP_ADC7_MAX;
> >> +               return 0;
> >> +       }
> >> +
> >> +       for (i = 0; i < ARRAY_SIZE(adcmap7_die_temp); i++)
> >> +               if (adcmap7_die_temp[i].x > voltage)
> >> +                       break;
> >> +
> >> +       vtemp0 = adcmap7_die_temp[i - 1].x;
> >> +       voltage = voltage - vtemp0;
> >> +       temp = div64_s64(voltage * DIE_TEMP_ADC7_SCALE_FACTOR,
> >> +               adcmap7_die_temp[i - 1].y);
> >> +       temp += DIE_TEMP_ADC7_SCALE_1 + (DIE_TEMP_ADC7_SCALE_2 * (i - 1));
> >> +       *result_mdec = temp;
> >> +
> >> +       return 0;
> >> +}

-- 
With Best Regards,
Andy Shevchenko
