Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C737038D711
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231301AbhEVS7A (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:59:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48295 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231249AbhEVS67 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:58:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621709854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0CTWc1JanZX5F1YBqTdDHu1pVBPB9ZkDdv+t/XPpJMM=;
        b=DMCJCEDITZCcIQskVXkx4H3gFMYvxwaiiVmRQ1gS/I+7kvLgyiDVnchL0KjOUMvsj5c48R
        MQHSqSgOKv2G2cZWcQEJ2wY3Re+lMe1G9/N8/evSF5UJHdyIEDJCwyO/Z4ME3GefC+fNKU
        fbVNt94Fmau6D3sB11NAn1QuXyspxAI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-190-U8UyQ4XVOkeK39Ke49SZAg-1; Sat, 22 May 2021 14:57:30 -0400
X-MC-Unique: U8UyQ4XVOkeK39Ke49SZAg-1
Received: by mail-ed1-f72.google.com with SMTP id w1-20020aa7da410000b029038d323eeee3so11200037eds.8
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0CTWc1JanZX5F1YBqTdDHu1pVBPB9ZkDdv+t/XPpJMM=;
        b=buvlUDvHWVSpz6vMIxB29u0vW808fk4r9S9lAzrCptSgGuwbxUemUAB0WPByy+R/fF
         JA2sdWAgdf35N0Oq+0AkDNzSskE+Hukbl+1ALNY4ixSwRRVqPOyiRPiIciweZE8xTWRl
         HfdR9CA/Kh/9WEReoh/6ngcHRmWdpyLf+V56HMZiMFyzxG6uYPDYXmI0eKL2/LHnvbRw
         WHK+njK2RHPWh2kc6WjDOSvlOB7iqn1EuXPFPCrnLdbmJNTPHJCrrrjpQbkGJzvi2r/k
         6/xeEK/+It+2TMaQg+Y/QQq6VuNWis7Rglt3PUzKgrbXvHeXPtuhCJoKHi+e0AjFRo0I
         mxIg==
X-Gm-Message-State: AOAM533cZtEStXPFxrVbjOA6R5CcZB8RUJddMantRzcfUPfoz6+bkWy+
        oE/B2GTWg2M7+5bOJDdjHbaH1cIl2eQY/fH3PjMukiILTk35MOAq4t5nOZc3BnjBwexmpcUbpFg
        LI9kYDC5LnZzvAq4357Ly
X-Received: by 2002:aa7:df90:: with SMTP id b16mr4007669edy.361.1621709849648;
        Sat, 22 May 2021 11:57:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiKhucOb2X+aPVb1IqqLm28bIfgK0q/UzHUrDNgYN2egw4HnbnRDwMW2GddqSCGkNGvB3ZBw==
X-Received: by 2002:aa7:df90:: with SMTP id b16mr4007651edy.361.1621709849427;
        Sat, 22 May 2021 11:57:29 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q16sm5739229ejm.12.2021.05.22.11.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 11:57:29 -0700 (PDT)
Subject: Re: [PATCH 3/8] iio: accel: bmc150: Move check for second ACPI device
 into a separate function
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
References: <20210521171418.393871-1-hdegoede@redhat.com>
 <20210521171418.393871-4-hdegoede@redhat.com>
 <CAHp75VfL0U90qcG4D1eOEP0f8sOMiNsrHwXVe4YjR1ypQFBLwQ@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <8e4e58a1-49ab-0a45-057d-838e4e934a98@redhat.com>
Date:   Sat, 22 May 2021 20:57:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfL0U90qcG4D1eOEP0f8sOMiNsrHwXVe4YjR1ypQFBLwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:09 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Move the check for a second ACPI device for BOSC0200 ACPI fwnodes into
>> a new bmc150_acpi_dual_accel_probe() helper function.
>>
>> This is a preparation patch for adding support for a new "DUAL250E" ACPI
>> Hardware-ID (HID) used on some devices.
> 
> ...
> 
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id bmc150_acpi_dual_accel_ids[] = {
>> +       {"BOSC0200"},
> 
>> +       { },
> 
> I guess it is a good chance to drop a comma.

Ack, will drop for v2.

Regards,

Hans


> 
>> +};
> 
> ...
> 
>> +       if (!IS_ERR(second_dev))
>> +               bmc150_set_second_device(client, second_dev);
> 
> I would comment on the pattern here, but I have noticed that this code
> is changed in the further patches anyway.
> 

