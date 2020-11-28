Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBC52C7546
	for <lists+linux-iio@lfdr.de>; Sat, 28 Nov 2020 23:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732765AbgK1VtY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Nov 2020 16:49:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730037AbgK1Sfh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Nov 2020 13:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606588450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Zszh/hjcmeeiyggCd7Qdid6Q4VmiyJkZoQgxeSYa8t0=;
        b=du6GD1YGOf2rvHXavubq1+2sD4dofVlwONT0EzIUgLn9+x5P8aB5QdoWj3aa9u7iFevPPo
        pK7kqMkL9iF4d8YHFEAeU3lEvcJl12LkMB4pH4zxWCEIfUfLeAvD42LhiKt2RFEJAQkF66
        s0bJbahoLTttrW3tlmlkwGIuCwX2W5o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-TB76rISrPPu2GJPAoziSgQ-1; Sat, 28 Nov 2020 08:32:53 -0500
X-MC-Unique: TB76rISrPPu2GJPAoziSgQ-1
Received: by mail-ej1-f72.google.com with SMTP id dx19so3240475ejb.7
        for <linux-iio@vger.kernel.org>; Sat, 28 Nov 2020 05:32:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Zszh/hjcmeeiyggCd7Qdid6Q4VmiyJkZoQgxeSYa8t0=;
        b=dfZxqRdo3baPqQk0AUoQ/ESaRTfqx3cJjlSw+4PTlvI0Yj3405jzvvkIePn2A2LeC4
         Nbu8YA/++LxQlqkRTIvEq+cFxB4S2Uw/uZ5Z1jmxzjTbbncsOo4Yc9zoiy5gRDuKux6D
         ccGesEor8AyhpWZkSICC/9GuRZYlFYCPzyM7F12KBVOv4sIwKsyzSft7ocvvpf/KS2Ui
         XVoJKRkLeMXflfU+XB0PrvECmsbNApQYxyN0icNM7zQ5zcSgnmfaCHGU6voH0OuiATTu
         nofwzQUlBm3qDnqz2pPvrK8Kirx1WM/kjtR+lc8q2rECp4qep7PcrdBYpZs4JzfLvdFU
         9qcw==
X-Gm-Message-State: AOAM533P8k1CMJhyJ2uYT1xVRkRC+7FTGUSMdO4FO+T9JPqn8o/ynHmD
        QWQzlgtdoxeiedoVF35Zdyc0cSfV7MBo9QX8vdrG7ToEYxVfhg8Rye4PHhJ1xSJ55sL/DaQyIqC
        H6AnhfUVeJKq/UvmNYVCBb3lihlHwtPvUwvr86zTPcZOSvhKwW/Nwn/EAS5luh4ynsCIecu05
X-Received: by 2002:a50:951e:: with SMTP id u30mr13334280eda.197.1606570371214;
        Sat, 28 Nov 2020 05:32:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxIqMCUHs1PeV7rP9PTmA1bTNVtveQDSJymxUNHFDVyf8TUxr491dMIWGP0oErUZ+u1asJ4aw==
X-Received: by 2002:a50:951e:: with SMTP id u30mr13334265eda.197.1606570370948;
        Sat, 28 Nov 2020 05:32:50 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id p4sm4186921ejx.64.2020.11.28.05.32.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Nov 2020 05:32:50 -0800 (PST)
Subject: Re: [PATCH 1/3] iio: accel: bmc150: Improve ACPI enumeration support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>
References: <20201125083618.10989-1-hdegoede@redhat.com>
 <CAHp75Vfu+PC-QzzE0_guwLHTdBXes-7RxbaS85df_p4Z=qR2=w@mail.gmail.com>
 <ec8c6e1e-f914-9ee7-133f-2f55d7cc8dfb@redhat.com>
 <20201128131604.1367126b@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <17447d78-c637-ad6b-2e38-c4ce82587598@redhat.com>
Date:   Sat, 28 Nov 2020 14:32:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201128131604.1367126b@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/28/20 2:16 PM, Jonathan Cameron wrote:
> On Wed, 25 Nov 2020 11:49:15 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi,
>>
>> On 11/25/20 11:41 AM, Andy Shevchenko wrote:
>>> On Wed, Nov 25, 2020 at 10:37 AM Hans de Goede <hdegoede@redhat.com> wrote:  
>>>>
>>>> Hi All,
>>>>
>>>> This series improves support for ACPI enumeration of bmc150 accels
>>>> described by an ACPI node with an ACPI hw-id of BOSC0200:
>>>>
>>>> 1. Add support for nodes which describe 2 acceleromers in a single node,  
>>>
>>> accelerometers
>>>   
>>>> fixing: https://bugzilla.kernel.org/show_bug.cgi?id=198671
>>>>
>>>> 2. Add support for reading the mount-matrix from the ACPI node.
>>>>
>>>> This is done in patches 2 - 3, patch 1 is a trivial cleanup which I noticed
>>>> could be done while working on this.
>>>>
>>>> Patch 2 is based on an earlier patch for this from Jeremy Cline:
>>>> https://lore.kernel.org/r/010001602cf53153-39ad69f1-1b39-4e6d-a748-9455a16c2fbd-000000@email.amazonses.com
>>>>
>>>> That patch was put on hold because normally ACPI nodes which describe
>>>> multiple i2c-clients in a single node are handled by:
>>>> drivers/platform/x86/i2c-multi-instantiate.c
>>>>
>>>> Which I tried to do at first, but as explained in the commit msg
>>>> of the updated patch, that is not possible in this special case
>>>> (because it would cause userspace breakage due to the modalias changing).  
>>>
>>> This is marked as patch 1?!  
>>
>> Yes my bad, sorry.
>>
>>> Usually --cover-letter produces a correct template...  
>>
>> I use --compose, time to switch to --cover-letter instead I guess.
>>
>> Regards,
>>
>> Hans
>>
> 
> Other than the minor bits Andy mentioned I'm fine with this.
> 
> It does sort of feel like we should be gathering documentation somewhere of
> where this crazy stuff has been seen in the wild.

I can provide an (incomplete) list of devices known to use the BOSC0200 ACPI HID,
both in single and dual accelerometer configs.

In lieu of a better place, I guess I could best just drop this info in
a big comment block near the ACPI mount-matrix parsing stuff ?

If you agree that a comment is a reasonable place to place this info I
can add this for v2 of the patch-set.

Regards,

Hans

