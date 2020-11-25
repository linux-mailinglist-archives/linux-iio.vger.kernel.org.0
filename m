Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558072C3ED5
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 12:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725989AbgKYLMy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 06:12:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgKYLMy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 06:12:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606302773;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w7O3iYZA149yx/s8eZSGVGWYblyGhXKYVUTJl12uIso=;
        b=QbkDERiK0uZXHv7Rn/5U8zPHelsZ6yD4kyLkOKQIvPafmhtxtqWlCIelG/R8ZmgywgLHrb
        v+6jKpb3RjnqibFwIbhS4L8z3cBORM2K9cIq8Ku2j3nomXz5crEoYwj4FIdwgJexcUF5o0
        qq3oTU1EpmrSPaajvAZmLEYeOpsTn2A=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-GDfWltWbM-yUN2Twoj9Kag-1; Wed, 25 Nov 2020 06:12:50 -0500
X-MC-Unique: GDfWltWbM-yUN2Twoj9Kag-1
Received: by mail-ej1-f71.google.com with SMTP id pv11so699681ejb.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 03:12:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w7O3iYZA149yx/s8eZSGVGWYblyGhXKYVUTJl12uIso=;
        b=k+pedq0U2Dg9sQM6i4/QHQB/Cui3UtcScF55RlV36cxUludZjSE0ZPLGRAA2eVBdQ8
         dCxbz2oDDkYJmiQqygfyMWWUUYPt9nyBR4B3OurBDAGbh11ToYzYlRbtTaXtetTIjtlX
         IaCDQAS0I16JBrCyHrM7WYcvJYURAJxrnGfT0lemVfoh3qrAE0QofPX9gAHaYH3GT+BQ
         KMfGHETgDHu0eE3uWa9C5/bdP41dXynVPpfgjTBmovjeFdca+28eRU3Qc4d/TmKFIFge
         WvcfL/Jo6cGWxzJlLMw+CCNDreBJpSEH0Iaegc2lKYCpIGQMjA8DHv53cNdtC1kvs1pN
         LSVA==
X-Gm-Message-State: AOAM5330p/D9+yadyxj6RfbVRXjHGdAieTdlrGQpTqbuVtaMXOeMUX4C
        qBmqAH5NcwmYGax87H1DSC16SmL0ZxlFyGP83Ttdpqg2z88I13/qmezZRcNDX+nTIWYauIgSM5Z
        OodlQ3c23bwgbpKpeKKvQMNhSR0g2Co3o42+QgBnMWr+mDCydq+3hknv4ECfM+Kdf7YbbTLKf
X-Received: by 2002:a17:906:1458:: with SMTP id q24mr2734157ejc.541.1606302769385;
        Wed, 25 Nov 2020 03:12:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSLazYW4R1OqTSB9HLt0XnyORLgHzWIYYJfZfPvQ0c1T5xC8uNHWB+d2Cy4NHYZ448BPaBNg==
X-Received: by 2002:a17:906:1458:: with SMTP id q24mr2734146ejc.541.1606302769184;
        Wed, 25 Nov 2020 03:12:49 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id v8sm1033433edt.3.2020.11.25.03.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 03:12:48 -0800 (PST)
Subject: Re: [PATCH 3/3] iio: accel: bmc150: Get mount-matrix from ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201125083618.10989-1-hdegoede@redhat.com>
 <20201125083618.10989-4-hdegoede@redhat.com>
 <CAHp75Vd5i7aErbRN9RVeH9H+OdKSqc_OKPnUtWR+cs7iP-Us2g@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <db0b5e1e-d643-9af8-a9e5-ad4aec089b0c@redhat.com>
Date:   Wed, 25 Nov 2020 12:12:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd5i7aErbRN9RVeH9H+OdKSqc_OKPnUtWR+cs7iP-Us2g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/25/20 12:07 PM, Andy Shevchenko wrote:
> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> bmc150 accelerometers with an ACPI hardware-id of BOSC0200 have an ACPI
>> method providing their mount-matrix, add support for retrieving this.
> 
> ...
> 
>> +       if (strcmp(dev_name(dev), "i2c-BOSC0200:base") == 0)
>> +               alt_name = "ROMK";
>> +       else
>> +               alt_name = "ROMS";
>> +
>> +       if (acpi_has_method(adev->handle, "ROTM"))
>> +               name = "ROTM";
> 
> My gosh, it's a third method of this...
> 
> ...
> 
>> +       elements = obj->package.elements;
>> +       for (i = 0; i < 3; i++) {
>> +               if (elements[i].type != ACPI_TYPE_STRING)
>> +                       goto unknown_format;
>> +
>> +               str = elements[i].string.pointer;
>> +               if (sscanf(str, "%d %d %d", &val[0], &val[1], &val[2]) != 3)
>> +                       goto unknown_format;
>> +
>> +               for (j = 0; j < 3; j++) {
>> +                       switch (val[j]) {
>> +                       case -1: str = "-1"; break;
>> +                       case 0:  str = "0";  break;
>> +                       case 1:  str = "1";  break;
>> +                       default: goto unknown_format;
>> +                       }
>> +                       orientation->rotation[i * 3 + j] = str;
>> +               }
>> +       }
> 
> I'm wondering if we can come up with some common code out of this and
> existing apply_acpi_orientation().

Honestly they are all different enough that I don't think it is worth
the trouble (I did take a look at this, but it did not seem feasible
without creating horrible code).

Regards,

Hans

