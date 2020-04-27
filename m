Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62DBB1BA4AE
	for <lists+linux-iio@lfdr.de>; Mon, 27 Apr 2020 15:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgD0N2W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 27 Apr 2020 09:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726769AbgD0N2U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 27 Apr 2020 09:28:20 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CEDC0610D5;
        Mon, 27 Apr 2020 06:28:20 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id e6so7437764pjt.4;
        Mon, 27 Apr 2020 06:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GHn5LhhRmzy3sndf78S27qfruwCqi4o/1SdzUaUG+CY=;
        b=P/eSHGWJI1R3+uwssq2jpcVpDs0STyTfYIjS/6fMuUcoKIU0mq5NqPzlrT8vwwPNAW
         uWttoIiLsdjqqVFUgcTi1GYSStxqdgmYStqY38agWPApHa+cK/4u2CfH0yRl5SFqVKAv
         Lr1F/A+HFTmbHrP9nKai236DFWbk6CzIXm1hXRwW7lDktn98mx6HZrofcjh1rRx6lsJT
         5QegEpUU99h1j5Krd1SLd4YTii50H5tDTxxsdTW5OcElutDBV78VY0szJ6Ogjodm/e59
         5IkNZ0WklVmQIYsgXD2jWRDMIdKvEsuK5EAhTmM8MChcBuQ0SzdZHqGBhH++PbTkQ3VE
         jtaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GHn5LhhRmzy3sndf78S27qfruwCqi4o/1SdzUaUG+CY=;
        b=aeK8Uyr/6fN8u276LP1T5Tu4GaSG9EQTALOBVALSRKahmR60h+1hNTZA7F+P0IgFyb
         pemHGld97av8l/DmPcblVX/HCJadbfkk/Nbd40K4aJWoDNuCtfpQCXQAohz4EHq8vrip
         hNkQC7h3wmCPd8/bbZfa2XUVUO6H+KpjsEgK0XE99/y62/Fr3k0KQLZKKLZGRw9gD5wo
         hj+DK23z7ATcXmNFUWZ072uwmyW8StWMxMn8zgvSaHOdG0+X8W7/4Bh7hXZeFJtzu6Og
         e8Q9LTD09DqhsV6HkVb/NrcNiz0G6VRCd9dfkgo79+mAeKnrKZD5aSTMKz8HiQ8hj2v4
         EZ0g==
X-Gm-Message-State: AGi0PuZsafI9WR+z9hj4BzqbM8g3TidQJ2iQ3W5bfT4ME6S2GQ1ca63V
        95+xfBnCn9ZHHSurY0gMcfCQUMm5a+CY/AMpGts=
X-Google-Smtp-Source: APiQypLM5+dnAYGRYo/miUr0skkS1pXmKokJxMTF2OxcJbjIgqi5/Xf//ExfkwcwyxPjQWzVN+J/SlG8Ed/n4uKxqo8=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr23246347pjb.143.1587994099840;
 Mon, 27 Apr 2020 06:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <1586942266-21480-1-git-send-email-jprakash@codeaurora.org>
 <1586942266-21480-4-git-send-email-jprakash@codeaurora.org>
 <CAHp75VegoXJmi1rDg_-ePKqoo69Jdt7NBchCTE=bPAdJqrgYQQ@mail.gmail.com> <68d9c770-b190-dd13-0869-fdae9fb1f16f@codeaurora.org>
In-Reply-To: <68d9c770-b190-dd13-0869-fdae9fb1f16f@codeaurora.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Apr 2020 16:28:13 +0300
Message-ID: <CAHp75Vdu4HvaTg5ij=DFhwn=y_JCb9ae9L5-iV72Zk-k9CBHuw@mail.gmail.com>
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

On Mon, Apr 27, 2020 at 3:56 PM Jishnu Prakash <jprakash@codeaurora.org> wrote:
> On 4/17/2020 3:51 PM, Andy Shevchenko wrote:
> On Thu, Apr 16, 2020 at 1:48 AM Jishnu Prakash <jprakash@codeaurora.org> wrote:

Stop using HTML. It breaks badly the reply and discussion.

...

> +static const struct adc5_data adc7_data_pmic;
>
> Global variable? Hmm...
>
> adc7_data_pmic is referenced twice before its actual definition (which was added along with corresponding adc5_data struct for PMIC5 ADC), so I have given the initial declaration here.

Maybe you can realize how to avoid global variable at all?

...

> +       buf[1] &= 0xff & ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
>
> What the point of 0xff & part?
>
> This was something you suggested in my first post:
>
> > +       buf[1] &= (u8) ~ADC5_USR_FAST_AVG_CTL_SAMPLES_MASK;
>
> Use '0xFF ^ _MASK' instead of casting.
>
> ...
>
> > +       buf[3] &= (u8) ~ADC5_USR_HW_SETTLE_DELAY_MASK;
>
> Ditto.
>
> I think "0xff &" works as intended here in place of casting to (u8)...

Does it work without casting? (Note, I suggested slightly different expression)
I.o.w. what the problem casting solves?

> +       buf[1] |= prop->avg_samples;
> +
> +       /* Select ADC channel */
> +       buf[2] = prop->channel;
> +
> +       /* Select HW settle delay for channel */
> +       buf[3] &= 0xff & ~ADC5_USR_HW_SETTLE_DELAY_MASK;
>
> Ditto.
>
> +       buf[3] |= prop->hw_settle_time;


-- 
With Best Regards,
Andy Shevchenko
