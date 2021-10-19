Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D84894330D3
	for <lists+linux-iio@lfdr.de>; Tue, 19 Oct 2021 10:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234657AbhJSIMe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 19 Oct 2021 04:12:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40527 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234671AbhJSIMd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 19 Oct 2021 04:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634631020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkXFhcV+/zxfEYqnjfBha3xxa5ZEj2GAqqrXULNm9mw=;
        b=eF7n0nY4LaJgaH0ghoTlg705vC3l9C+n7goAqxbbJ1bFG0svlzBbKpHPTdkb+UsN6+oNTD
        ZaiEzRyQbzz3a4iDcUYme2JD3S4YTCqWFrRYMWYLqTXrDoT1Xez8MDo/BzKmZ3O12neSV4
        H1RkdhAyeFsN+gj0OGHcY9LZ/jppEhg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-0uvAktTdOGGH7E0rQwURQw-1; Tue, 19 Oct 2021 04:10:14 -0400
X-MC-Unique: 0uvAktTdOGGH7E0rQwURQw-1
Received: by mail-ed1-f71.google.com with SMTP id l22-20020aa7c316000000b003dbbced0731so16842795edq.6
        for <linux-iio@vger.kernel.org>; Tue, 19 Oct 2021 01:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FkXFhcV+/zxfEYqnjfBha3xxa5ZEj2GAqqrXULNm9mw=;
        b=SlAOG4MdQl69kgpHTHIewIiditHyKTGpElIMCrbhNBOY5DgiSOmtSUt/swtFfs++5s
         AkASo9bmzGTA+7dG7vLJ9j1ACWSnvWKuBTLTXrh+zsAf3rSCuOt+YPc4ps9Wy4XFkhN/
         LrdA36EqMVR6IsbFPpthHLiPrWvaUGsEO5ztEI3QNqvix3Qj5gTuEynKyE43tNFlO4JZ
         z+WPeUIgqv+rR8+kW9iHvtjRaRW5/nelSl6Tp+bpX5u0Qlj0LoV98jGvpmHGDYKw40/O
         Zlgq3cO0WFffrG+d0hqjn6AzPLbAJzfqOzS26z2feqjCGBQyxVIb3d/23r3JJZEybf4L
         hzHQ==
X-Gm-Message-State: AOAM532mpmCFSUiY6UZveav1TopAH2+ELOC6zC5T/H6HATb/SebaMH3O
        XX3VpjeihOLYfBVsep6bv92+Ma+yaY/j/cyn1+RLEg0b7RRE4T1D92kYPyyRcsAI6H4n+5HqXb9
        ack/OhfNoAs1bN006GBLf
X-Received: by 2002:a50:d885:: with SMTP id p5mr52171857edj.255.1634631012917;
        Tue, 19 Oct 2021 01:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzosqBQafK63EMeHqdbkT6tgiXIRHSVtmPYVHpHH/GgdpC3lhfGo5ZhNFQunq7pMNngQ60wzw==
X-Received: by 2002:a50:d885:: with SMTP id p5mr52171824edj.255.1634631012690;
        Tue, 19 Oct 2021 01:10:12 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:1054:9d19:e0f0:8214? (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id q9sm9816205ejf.70.2021.10.19.01.10.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Oct 2021 01:10:12 -0700 (PDT)
Message-ID: <7522243d-79f4-9687-103f-3692eb70533f@redhat.com>
Date:   Tue, 19 Oct 2021 10:10:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: BMI160 accelerometer on AyaNeo tablet
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Maxim Levitsky <maximlevitsky@gmail.com>
Cc:     linux-realtek-soc@lists.infradead.org,
        Oder Chiou <oder_chiou@realtek.com>,
        Ping-Ke Shih <pkshih@realtek.com>, nic_swsd@realtek.com,
        Derek Fang <derek.fang@realtek.com>,
        Hayes Wang <hayeswang@realtek.com>,
        Kailang Yang <kailang@realtek.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        LKML <linux-kernel@vger.kernel.org>, info@ayaneo.com
References: <CACAwPwb7edLzX-KO1XVNWuQ3w=U0BfA=_kwiGCjZOpKfZpc2pw@mail.gmail.com>
 <CACAwPwYQHRcrabw9=0tvenPzAcwwW1pTaR6a+AEWBF9Hqf_wXQ@mail.gmail.com>
 <CAHp75VcEZ19zUU-Ps=kAYJDX1bkxmOqmHii36HE2ujC3gROkNQ@mail.gmail.com>
 <CACAwPwaj_ekK6j9S4CRu6tRTPyjffgDhL3UFnhoYSyJSkAkmpw@mail.gmail.com>
 <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YW3ErLKGtmyhSFd3@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 10/18/21 21:02, Andy Shevchenko wrote:
> On Mon, Oct 18, 2021 at 09:02:40PM +0300, Maxim Levitsky wrote:
>> I also suspect a mistake from the hardware vendors.
>>
>> I attached all DSDT decompiled, which shows that they indeed use that
>> ID, and I also attached the windows driver .INF which was published on
>> their website  with the driver (https://www.ayaneo.com/downloads)
>>
>> They are a small startup so they might have used the realtek ID by mistake.
>> I added them to the CC.
> 
> Thank you for sharing. Seems they indeed used (deliberately or not) the wrong
> ID. So there are questions I have:
> - Is the firmware available in the wild?
> - Do they plan to update firmware to fix this?
> - Can we make sure that guys got their mistake and will be more careful
>   in the future?
> 
> Realtek probably should make this ID marked somehow broken and not use
> in their products in case the answer to the first of the above question
> is "yes". (Of course in case the ID will be used for solely PCI enumerated
> product there will be no conflict, I just propose to be on the safest side,
> but remark should be made somewhere).
> 
>> BTW, I also notice a rotation matrix embedded in DSTD, but the linux's
>> BMI160 driver doesn't recognize it.
> 
> This is done by the commit 8a0672003421 ("iio: accel: bmc150: Get
> mount-matrix from ACPI") which needs to be amended to take care about
> more devices, somewhere in drivers/iio/industialio-acpi.c ? Jonathan,
> Hans, what do you think?

First of all the vendor needs to be asked to fix their DSDT to just
use BOSC0200 as HID. That will fix both the driver not binding as well
as it will make the bmc150_apply_acpi_orientation() just work.

If we are going to add the funky ACPI HID to the driver, then this
HID check in bmc150_apply_acpi_orientation():

	if (!adev || !acpi_dev_hid_uid_match(adev, "BOSC0200", NULL))
		return false;

Should probable just be dropped changing the check to just:

	if (!adev)
		return false;

We already check for the method name later, so the HID check is not
really necessary.

This dropping of the HID check should probably be done in a separate
commit, with its own explanation of why this is ok.

Regards,

Hans

