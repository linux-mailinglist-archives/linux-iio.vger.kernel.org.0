Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19FFA196C75
	for <lists+linux-iio@lfdr.de>; Sun, 29 Mar 2020 12:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgC2KeJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 29 Mar 2020 06:34:09 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37348 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727869AbgC2KeI (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 29 Mar 2020 06:34:08 -0400
Received: by mail-wm1-f68.google.com with SMTP id d1so17849441wmb.2;
        Sun, 29 Mar 2020 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=FlZLcBO7OYWRZLM3fnAWMQqlsSHKvKFSKGsey7ScD04=;
        b=cw+9tTm5CubLPa3eNghOc8/tTgz+aoRUpcGucXULJ+ldNN6QMblIQREQsUok7XYMIk
         ha8w9p/gRDaqa39YyCeDLhRrDkt+4q+bHhHtN1N5r/GB16h5vWpaDBRYq4cWDVmCYbtI
         LhoMLLqgM8i5JmFitQATyqoECAHnFf8DB64QFr5DeCzSyG+T485qKEWYkcGar4TPwGiY
         D+wex9yiUq1JIyfCngOdQ58Es1pLoMF8r5KRRprvGxH8cYXUJVe2Erpsw/XHx+u9FUF8
         Jwc3wa+e+SyDOdX3wuMhA3LWBEcccWUM7IcZdEcO1cggFTiCyd66cxF+BcCFlodaCNzn
         aB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=FlZLcBO7OYWRZLM3fnAWMQqlsSHKvKFSKGsey7ScD04=;
        b=ujmJuJs5r470oALl5YZ+q1uC6o3mEjbeVopOl/2G/c7wY0z7Ia7nek6b/EIyzD8DwH
         c8kkE33pZJG9VFN3sgw+5VNEy2OmYhlpOznz6A/5amavW+xWbIMzjQC4dxV2PQpf8fyp
         IzPed1VJJPRWlOXXYikEGIypMkc0TxOcbiqZfV2TG2/MzJQluzwbF1BZw+iig76qxbcy
         53QeGxLovPExByoBeYsPRPVMMUD3f0aDcAQ62/J+dtIjiDpDvVO+94eHcEc9Upz8P7un
         ByajeBbwDMYEl9dQlU3w0zKXhO6PfswHUZXknB6VsixQ32QSmNq3M6MsyMNlETIY2foj
         TPyw==
X-Gm-Message-State: ANhLgQ0Ks7qGMJ/n3cVEm+zZRyrAwvAQT9Mnad1gAh/1vhI11UuA8bUW
        so1SdlhnDNJ1KtdNk65Oz/gQuRR3
X-Google-Smtp-Source: ADFU+vsgvkJcM76vOwqLH3zSNrn5alEJfrSXUpOh5ObS7Qs3iQPqty7+fqs4pAtBixLWjHiL2dqujw==
X-Received: by 2002:a7b:c0d1:: with SMTP id s17mr7685443wmh.58.1585478046213;
        Sun, 29 Mar 2020 03:34:06 -0700 (PDT)
Received: from [192.168.0.104] (p5B3F6BD9.dip0.t-ipconnect.de. [91.63.107.217])
        by smtp.gmail.com with ESMTPSA id m19sm16289545wml.48.2020.03.29.03.34.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2020 03:34:05 -0700 (PDT)
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
 <36892440-99b2-10e8-1d7c-dd8c97e03a39@gmail.com>
 <CAHp75VdAfiSjkHhTnghZ__WAJCJTGSWBprJBPNmpkxZTjZuVgQ@mail.gmail.com>
From:   saravanan sekar <sravanhome@gmail.com>
Message-ID: <3d811222-68fa-0992-eeeb-97d1c6d09608@gmail.com>
Date:   Sun, 29 Mar 2020 12:34:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VdAfiSjkHhTnghZ__WAJCJTGSWBprJBPNmpkxZTjZuVgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Andy,

On 28/03/20 7:44 pm, Andy Shevchenko wrote:
> On Sat, Mar 28, 2020 at 1:29 PM saravanan sekar <sravanhome@gmail.com> wrote:
>> On 28/03/20 12:02 pm, Andy Shevchenko wrote:
>>> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:
> ...
>
>>>> +       val->intval = (rval * props[fld].step) + props[fld].min;
>>> Too many parentheses.
>>>
>>> ...
>>>
>>>> +       return ((psp == POWER_SUPPLY_PROP_PRECHARGE_CURRENT) ||
>>>> +               (psp == POWER_SUPPLY_PROP_CHARGE_TERM_CURRENT) ||
>>>> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_CURRENT) ||
>>>> +               (psp == POWER_SUPPLY_PROP_CONSTANT_CHARGE_VOLTAGE));
>>> Ditto.
>> I think I misunderstood you previous review comment "Redundant
>> parentheses", no sure what is the expectation
> (At least) surrounding pair is not needed, return (a == b) || (c == d);
ok, I will remove outer ().
>>> ...
>>>
>>>> +       return ((psp == POWER_SUPPLY_PROP_INPUT_VOLTAGE_LIMIT) ||
>>>> +               (psp == POWER_SUPPLY_PROP_INPUT_CURRENT_LIMIT));
>>> Ditto.
> ...
>
>>>> +       struct power_supply_config psy_cfg = {NULL};
>>> { 0 }
>>>
>> NULL to make compiler happy.
> Hmm... Can you share warning / error compiler issued in 0 case?
>
Please see the 0-day warning.

"Reported-by: kbuild test robot <lkp@intel.com>
sparse warnings: (new ones prefixed by >>)
 >> drivers/power/supply/mp2629_charger.c:584:47: sparse: sparse: Using 
plain integer as NULL pointer"

