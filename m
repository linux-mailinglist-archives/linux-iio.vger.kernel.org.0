Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 462473992B8
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jun 2021 20:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbhFBSob (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 2 Jun 2021 14:44:31 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:40862 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229467AbhFBSob (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 2 Jun 2021 14:44:31 -0400
Received: by mail-ed1-f47.google.com with SMTP id t3so4098443edc.7
        for <linux-iio@vger.kernel.org>; Wed, 02 Jun 2021 11:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aA6t+RFH6h9m3cbYD0eRjMB82kwRGZB4a6SuZXwckcY=;
        b=MBzaTrxXB7Liekl/ShYJO4WDEuiJ7MU/8pDShyR4P1nUffZotjM2KjCZoKLchBdQS5
         lu2PrRmJpXPBaNtR+muW0SRlPKpgO8lY0ou0ohZZMRPhyb6d4lH28V4LiX4wWZnrhMWZ
         LGkDBdT3IZ6Babzz3520GiKlizN+T1OdmNDPOXRM9yDobwZ1Pm46GbliBzgwimYADgF2
         arlrN5XrJ6dL7ep3Be/BuQ3yUmJ99aTOvtRx646DNx943eyU8+Vc5KWf8T9hOIPoi+Z+
         bI/ICuQ9q9J7NHJ3dfecGRInTNub/IisZqPHJEBsMWxMXzkJ5IxWY0h/tiMe4wL5pSzp
         7Nrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aA6t+RFH6h9m3cbYD0eRjMB82kwRGZB4a6SuZXwckcY=;
        b=QQz6T1u4XzUJonZACVYV49HnhzUlbtcwJHOFeDpCvV/eXt95atixCUIstdYkMxGlod
         JfgwgOf9Yyp15XcD6r5Hq4Q3emKcav0D9Pv+wG43kYXSiJufw6ld7PXpxE1Tu7so2v/u
         w8ytgMf4l/38xCfaJTQSNxVgbthm+P6jf2eByMZGuOAe4/ecspWMS4Tv6fI88MtYk4dE
         Tn9cyNcn5vdjzK+/3jbBR7lPe+TN5ROzE1Fw8fzJm0M4KoFD9Iild17lUyIxB7VAMIXA
         bdxL/bsrGBfLGoJwIGgYa152GIjTY76SNxYH9DkepUgeVNuxwslj9PYGszIVwMg5tIBh
         EJjQ==
X-Gm-Message-State: AOAM533ZtRz8B8IYxwPcDCTdNon1ckMP1k+qq6lrDL/Rw8LGYkVZryOG
        N5tGRc7gG2/aamXh6TjfqEH4Y968Fa1U6vTMoDH6Pw==
X-Google-Smtp-Source: ABdhPJwkxd6w0X9znF/p7wVaLPhMx+ywGiSGVIf++Ik66e55IkWpssaoidvBn0b5v0GQRLcq1lIgoJ/b8rQdWezVq7A=
X-Received: by 2002:aa7:cb92:: with SMTP id r18mr40925195edt.246.1622659297618;
 Wed, 02 Jun 2021 11:41:37 -0700 (PDT)
MIME-Version: 1.0
References: <9681d2a6-c820-c5a0-2cc1-e0b7fc808dae@linux.vnet.ibm.com> <ca1268bd-8134-352f-bfc1-665abfa7f42c@linux.vnet.ibm.com>
In-Reply-To: <ca1268bd-8134-352f-bfc1-665abfa7f42c@linux.vnet.ibm.com>
From:   Guenter Roeck <groeck@google.com>
Date:   Wed, 2 Jun 2021 11:41:26 -0700
Message-ID: <CABXOdTegoRVC_3Ks8sTnbhZaGmGXLu_w47Dx5BydLLkGX8Au3A@mail.gmail.com>
Subject: Re: Regarding Pressure sensors for atmospheric, station, and
 barometric pressures.
To:     Bruce Mitchell <bruce.mitchell@linux.vnet.ibm.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Guenter Roeck <groeck@chromium.org>,
        linux-hwmon@vger.kernel.org, linux-iio@vger.kernel.org,
        Milton Miller II <miltonm@us.ibm.com>,
        Eddie James <eajames@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Bruce,

On Wed, Jun 2, 2021 at 11:14 AM Bruce Mitchell
<bruce.mitchell@linux.vnet.ibm.com> wrote:
>
> Hello Guenter,
>
> I've been asked to expand the To list to include you and hwmon.
>
> In reference to:
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio
>
> There is this section:
>
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_raw
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_raw
> KernelVersion:  3.8
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Raw pressure measurement from channel Y. Units after
>                 application of scale and offset are kilopascal.
>
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressureY_input
> What:           /sys/bus/iio/devices/iio:deviceX/in_pressure_input
> KernelVersion:  3.8
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Scaled pressure measurement from channel Y, in kilopascal.
>
> What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_raw
> KernelVersion:  3.14
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Raw humidity measurement of air. Units after application of
>                 scale and offset are milli percent.
>
> What:           /sys/bus/iio/devices/iio:deviceX/in_humidityrelative_input
> KernelVersion:  3.14
> Contact:        linux-iio@vger.kernel.org
> Description:
>                 Scaled humidity measurement in milli percent.
>
> Nowhere do I find the unit kilopascal used in atmospheric pressure.
> To stick with International System of Units and its Prefixes
> https://en.wikipedia.org/wiki/International_System_of_Units#Prefixes
>
> The standard unit for used in atmospheric pressure measurements or
> readings is the hectopascal (hPa), in meteorology, for atmospheric
> pressure, the modern equivalent of the traditional millibar.
>
> What would it take to make this change to the standard for
> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-bus-iio ?
>

The short answer is "you don't". The ABI states that pressure is reported in
kilopascal, not in hectopascal. We can't change the ABI because existing
user space code depends on it. Changing it would be equivalent to changing
the ABI for, say, temperature from degrees C to degrees F, or Kelvin.

Quite frankly I don't see your problem. 1 kilopascal = 10 hectopascal. Take
the reported number and multiply by 10. What am I missing ?

Obviously I _am_ missing the entire discussion so far, so my response may
be  completely off track. If so, my apologies for the noise.

Thanks,
Guenter
