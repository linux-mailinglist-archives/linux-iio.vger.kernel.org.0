Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF938D715
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhEVTAu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 15:00:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42681 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231334AbhEVTAu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 15:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621709964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxC/Wf7jSJzdkmQnLLsHKhYhaWILzajKsVMVqng36Ps=;
        b=ICt5rFYmtYXgtaeYAoLVuqBBVXggVgz+Ajs/m2EKNCZvYiqVt23PEUa0tsbuInXyaesPZg
        3nnSrR+V1Jpm6AZDW+XUPKDKaJTyxEzWWCauvMg3ly32iylmRvxui0lyhZuOR56n/cRf2S
        1lv+9Q976r7ys6IKtLnpCBBnlokBujg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-15-K88AkrOAMSG_VmnesXRFnQ-1; Sat, 22 May 2021 14:59:23 -0400
X-MC-Unique: K88AkrOAMSG_VmnesXRFnQ-1
Received: by mail-ed1-f70.google.com with SMTP id w22-20020a05640234d6b029038d04376b6aso13131767edc.21
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:59:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QxC/Wf7jSJzdkmQnLLsHKhYhaWILzajKsVMVqng36Ps=;
        b=QWCrAuRs6oS5/EIAV20d5QyXiL8GCWIGe8RROyP313mEj9nuCQaj9Q7+PRN3QUBHpW
         5yXycgqVnLJ0ueFJI8APNUxsM5fOxJ6H8gjiI4eMQU3f6Zbh/ezBbHKjkRX1pwqUixzv
         iY0e7wZgUEh+TmPDkAWaRJ8zpId8pdrY0FkziQsTuzwNUfzCg7uER2GmKDln2F739TyE
         R9EAzy8nrRqEy1Gv3BI8ocLBHK5eQBiL/Rmh2DXHXJgcMH2TJdkj6xBgUBocEKktQnlk
         4ruqFd5kd3m+LhmI4ha/TQBou4AEg7Jvp13s7JCDu8zMXSgfTm3qozqAlxRCKoA/Fbn5
         WsWg==
X-Gm-Message-State: AOAM530F7BbT3QJ5sBVs3eo+yuUb08Vsw7nL4IGbSlbLjfHU5nwE4iVk
        Rsv+11dHGrvmuh2/yRuerseqp8YL8MDYT9dbhDMC2imfmj3DFbt/ASgLUyXdmwYx+ZAVf9QT1L4
        Eci7r7uISd2ucRpvNUQDB
X-Received: by 2002:a05:6402:1c97:: with SMTP id cy23mr17648235edb.213.1621709961996;
        Sat, 22 May 2021 11:59:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyOERy4cTDs7RSotWaJMAqZJP24uoWXS48eRhBEIoxF1UKEU2Vm6jV0Gsn939GVtpoQfvtEMQ==
X-Received: by 2002:a05:6402:1c97:: with SMTP id cy23mr17648226edb.213.1621709961898;
        Sat, 22 May 2021 11:59:21 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id m13sm6817462eds.21.2021.05.22.11.59.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 May 2021 11:59:21 -0700 (PDT)
Subject: Re: [PATCH 4/8] iio: accel: bmc150: Add support for
 dual-accelerometers with a DUAL250E HID
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
 <20210521171418.393871-5-hdegoede@redhat.com>
 <CAHp75Vf_itoC8hiacBPXLK73NLbFre58b=wmVdEbviwEj0ZHHA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9df6f2a8-cb41-5fd1-c56e-b72fb129e758@redhat.com>
Date:   Sat, 22 May 2021 20:59:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAHp75Vf_itoC8hiacBPXLK73NLbFre58b=wmVdEbviwEj0ZHHA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 5/22/21 8:11 PM, Andy Shevchenko wrote:
> On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> The Lenovo Yoga 300-11IBR has a ACPI fwnode with a HID of DUAL250E
>> which contains I2C and IRQ resources for 2 accelerometers, 1 in the
>> display and one in the base of the device. Add support for this.
> 
> ...
> 
>> +       board_info.irq = acpi_dev_gpio_irq_get_by(adev, NULL, 1);
> 
> If NULL will be there after the series, why not to use
> acpi_dev_gpio_irq_get() directly?

I looked in drivers/gpio/gpiolib-acpi.c to see what is available
and that is an inline helper in include/linux/acpi.h, so I missed
it. I'll switch over in v2.

Regards,

Hans

