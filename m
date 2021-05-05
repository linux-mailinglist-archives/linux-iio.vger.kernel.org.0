Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33C8373FD8
	for <lists+linux-iio@lfdr.de>; Wed,  5 May 2021 18:31:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234095AbhEEQcC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 5 May 2021 12:32:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50934 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234021AbhEEQcB (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 5 May 2021 12:32:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620232264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kX3E2zH85fHZhD2JEIaEbiUpcmLdxoyEdcOH7SUKQb8=;
        b=LdnGrFfsWlblGy8sqU5zeS7OyhL2GtJoWeQlnLl440PWqRYcy3FpTiCf8xuBr0QNgDE07D
        guBCcNIMy3ccB9U/kZvuDItJks21tIo3GIPK+ThPGEqVsUpfn7D+voh9INPlJE3f1u15Yo
        4ZXKdnQGPsn0jZ1GXCr7Y3kQxwc3yTQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-zBacsGDDNdmMn0XAskweSA-1; Wed, 05 May 2021 12:31:01 -0400
X-MC-Unique: zBacsGDDNdmMn0XAskweSA-1
Received: by mail-ej1-f71.google.com with SMTP id bi3-20020a170906a243b02903933c4d9132so679883ejb.11
        for <linux-iio@vger.kernel.org>; Wed, 05 May 2021 09:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kX3E2zH85fHZhD2JEIaEbiUpcmLdxoyEdcOH7SUKQb8=;
        b=pJl3JJXVQNeXzzOIfLK2KcU4b7RMs+BiqLAwOuMi0t4AM78YjL+fG7rSHAEMpMzB2+
         UPlUrAaTo1gIW+HxPvkSSLYgnC+mFzPop3lJtUD3jiTXd56VOWWPEhIC7BVqr5Ze79tL
         i0uOk8YtQx3B5MBrbzdFNRbn579TEtiHU/da8dB1p8r++iW/DLBdS4reEWAYkMWpVrZr
         8anMrvBvagZzgyS0wE5kWgbM1LmB4bq24p96L3CAsh5GI1Ze2GYuOZWqLxo59L8qBODi
         ogSA2Sk34fgWI2OEjC/pOWPYSzL7myL/AoMz87uCE2Y7mNl2UOVcsEoF8RhiiWfB68t6
         W6Fg==
X-Gm-Message-State: AOAM533T5RIeWj5MycgTAdcqIX/uoiCx5X6dewbsQQnRDWQyRWKyTI+5
        zWwjIaBbWeTa/P7Z4khFegtH6S6bvEoeYdtmieg3EXnfQtuwX8kilKVvowjJk/YN5v0uX4ahycK
        uYyjfa7xNKK8ItDuGN1YI
X-Received: by 2002:aa7:d955:: with SMTP id l21mr24340455eds.118.1620232260021;
        Wed, 05 May 2021 09:31:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHidgZUVPmG9pmetM6ciJpFsJs1e1yXIaEK6eN7wapSpmFtjNJU9Wh9NljExq3tV1gNFyTfg==
X-Received: by 2002:aa7:d955:: with SMTP id l21mr24340438eds.118.1620232259879;
        Wed, 05 May 2021 09:30:59 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id t9sm3135658edf.70.2021.05.05.09.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 09:30:59 -0700 (PDT)
Subject: Re: [PATCH] iio: bme680_i2c: Make bme680_acpi_match depend on
 CONFIG_ACPI
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Paul Menzel <paulepanter@users.sourceforge.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@denx.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
References: <20210504174019.2134652-1-linux@roeck-us.net>
 <CAHp75Vd-iTkA5Y6tEHtfcqLxxmHaaU8nLQSL7eWb-gaa-c8AJg@mail.gmail.com>
 <8f8b6f33-4308-bfda-2238-9a54e19c3f9f@roeck-us.net>
 <20210505093235.00007c38@Huawei.com> <20210505093438.00005238@Huawei.com>
 <CAHp75VezSD_TcbQ_OBZXPo-szTr-qwOT9oU+7h7W6nk65ZLBhA@mail.gmail.com>
 <22212bbc-1dc7-c7e7-1954-ebb911754246@redhat.com>
 <CAHp75Vf+2oVttGhAcpcw-ZsAXno01yuKWz0Xiti_7beHCR81ng@mail.gmail.com>
 <ede732cb-4a23-e5bc-6802-0280dc232876@redhat.com>
 <CAHp75VciMKfxPvKmY349327FcoUcUMeFnvqkniw2erCyb71BoQ@mail.gmail.com>
 <3121ad81-1dc3-eace-a87c-47ebafa2d615@redhat.com>
 <CAHp75VfosJVmQOBUSQEVwrvkfUKnVdfAW7ctX+Yi8bFu1+jamw@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <dbcf3cf5-069b-6a20-ebc7-0675e7713367@redhat.com>
Date:   Wed, 5 May 2021 18:30:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAHp75VfosJVmQOBUSQEVwrvkfUKnVdfAW7ctX+Yi8bFu1+jamw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/5/21 6:26 PM, Andy Shevchenko wrote:
> On Wed, May 5, 2021 at 6:19 PM Hans de Goede <hdegoede@redhat.com> wrote:
>> On 5/5/21 4:18 PM, Andy Shevchenko wrote:
>>> On Wed, May 5, 2021 at 5:11 PM Hans de Goede <hdegoede@redhat.com> wrote:
> 
> ...
> 
>>> Currently the scope is of
>>> AOS2315
>>> BME0680
>>> STK8312
>>
>> Ok I cannot find any reference to those in the DSDT-s which I have,
>> nor in systemd's hwdb.
> 
> Thanks for checking.
> 
> By the way. Do you have DSDTs in some kind of Git repository?
> Shouldn't we have (means to create if not exists) one publicly
> available? It would be nice to gather them under the hood for the
> purpose of looking into. I have some (small) set of those as well
> which might be useful.

Interesting idea, the issue is that arguably these are copyrightable
and we don't have any permission to distribute them. Things like
attaching them to bugs, having them emailed to me, etc. can be
considered fair use of sorts I guess (IANAL), but putting them into
a git repo would really be a bit of a grey area...

Regards,

Hans


