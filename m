Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2877D1965CC
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 12:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgC1L3s (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 07:29:48 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42397 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgC1L3r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 07:29:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15so14868352wrx.9;
        Sat, 28 Mar 2020 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=48cUKb3hewA6YqxxcM8aRq1Cv5K4EWHquZ9kJ+7UoxA=;
        b=J7XK/uR96SCZTbQlk5nx5a9xV0/oPjTVP6L+T791RLlhHdiAeFs/GwmPkcHngmgaGR
         +Fjy4LENZQnIwA3gEmwwuLBtAeqeLdHljL/9qmaGka1WI57wWwzR+segwNCQW6ZlSfGG
         PA9WYCZQ2QjuoyMTVkh4ivqRyvNBh13gmjvDipeiben/7eciS5nCvhahWJZ00F7Iq+xa
         YDFGB+NjacR9xG3b28SpY22L86jMVeWKTV9sGRvzVDfbQJ6owCkP1GVX5iKMalmR3Ear
         tRv+SkRfWds3vIP1zRbNlqXgmTXfs3SRSb0lxGM04zrvygExplOJMX1LBCj7K51P1ju4
         goxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=48cUKb3hewA6YqxxcM8aRq1Cv5K4EWHquZ9kJ+7UoxA=;
        b=aa9lcS2iBFs5InYerH5b1WEl3ANu4rLI8iMsV53v9pHnlRFKaRSuB1S0dFEBL2cx1y
         7QYlO/ALKCKUMUu7RxcLr9t80/mp5hXuqxG7nyshBDEChPLCL5bewVJqi40L3NySluUC
         VJUGFnz18VTqeRoY+VEMi4SafRJ82c5q2KS/F5dJtND5E2ZcHOXh+x/mBOc9dvRoKmqY
         so6V1eWLZe3LByAdJiw1hOYk5SuZKQr3Ja5rq/ZhzfjP3dk7ilCOgWFHOiOGpxJahY+R
         GwD6wol2mytoMcR8/bdi23dI2mw4GkWp7lYq674sw4Xy+45ZJZKfG/+2ic/tmSoU/Okv
         6pvQ==
X-Gm-Message-State: ANhLgQ1R2MpSIbcEc4vy7RuLW37bYDKIgUwA5ynszeaaC4Hvj+RPbTMS
        4iB5Ze0Nl/w9600x/9796+wDp2rcXm4=
X-Google-Smtp-Source: ADFU+vs4/LZ1qoi9tgNpOM9fvmW6ER9q3wSqLs/wu94Ztl/ULPfT1jcvMWdjNrRrQCO2/HtGqakGGA==
X-Received: by 2002:a5d:4cc4:: with SMTP id c4mr4424245wrt.346.1585394984815;
        Sat, 28 Mar 2020 04:29:44 -0700 (PDT)
Received: from [192.168.0.104] (p5DCFFF1C.dip0.t-ipconnect.de. [93.207.255.28])
        by smtp.gmail.com with ESMTPSA id m11sm12283575wmf.9.2020.03.28.04.29.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Mar 2020 04:29:44 -0700 (PDT)
Subject: Re: [PATCH v5 4/5] power: supply: Add support for mps mp2629 battery
 charger
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
References: <20200328001154.17313-1-sravanhome@gmail.com>
 <20200328001154.17313-5-sravanhome@gmail.com>
 <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <36892440-99b2-10e8-1d7c-dd8c97e03a39@gmail.com>
Date:   Sat, 28 Mar 2020 12:29:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 28/03/20 12:02 pm, Andy Shevchenko wrote:
> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
>> The mp2629 provides switching-mode battery charge management for
>> single-cell Li-ion or Li-polymer battery. Driver supports the
>> access/control input source and battery charging parameters.
> ...
>
>> +#include <linux/module.h>
>> +#include <linux/of_device.h>
> Missed header bits.h.
>
> ...
>
>> +       ret = iio_read_channel_processed(charger->iiochan[ch], &chval);
>> +       if (ret < 0)
> Is it possible to get positive returned value?
Really not for processed
>> +               return ret;
> ...
>
>> +       val->intval = (rval * props[fld].step) + props[fld].min;
> Too many parentheses.
>
> ...
>
>> +       return ((psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT) ||
>> +               (psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT) ||
>> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) ||
>> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE));
> Ditto.
I think I misunderstood you previous review comment "Redundant 
parentheses", no sure what is the expectation
>
> ...
>
>> +       return ((psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT) ||
>> +               (psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT));
> Ditto.
>
> ...
>
>> +       return sprintf(buf, "%d mohm\n", rval);
> Hmm... For units we usually have separate node, but it is up to
> maintainer, I dunno what the common practice is there.
>
> ...
>
>> +       int val;
>> +       int ret;
>> +
>> +       ret = kstrtoint(buf, 10, &val);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (val < 0 && val > 140)
> What the point to convert negative values in the first place? kstrtouint()
Done
>> +               return -ERANGE;
> ...
>
>> +       struct power_supply_config psy_cfg = {NULL};
> { 0 }
>
NULL to make compiler happy.
