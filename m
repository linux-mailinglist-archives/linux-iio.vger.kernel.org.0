Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17B7531A4A4
	for <lists+linux-iio@lfdr.de>; Fri, 12 Feb 2021 19:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbhBLSkn (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 12 Feb 2021 13:40:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53822 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229451AbhBLSkm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 12 Feb 2021 13:40:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613155155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXbmiHWAl15tkf37i9FLNdYEK2E4WAvEcnjVjXzu2F8=;
        b=JInQe+Pv1zpeEVwi0KmavSeQ1aU4KX8S7hc6JkqX05Ig2xj3ti9vE/lRDpJVgAVTsHIiWB
        jcXmcZgW+MUXNFkzNYE6EqvmP1xpYv3EELeKEeFk95f6Auz1/2EAojup/xMfVqe5aNtbcI
        BKJwUaw+LiJ6KmKFR/F9o8lPlrJZ9Gw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-l6dosSWkOPeXdUHdhcCMJg-1; Fri, 12 Feb 2021 13:39:14 -0500
X-MC-Unique: l6dosSWkOPeXdUHdhcCMJg-1
Received: by mail-ej1-f69.google.com with SMTP id by8so343427ejc.1
        for <linux-iio@vger.kernel.org>; Fri, 12 Feb 2021 10:39:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jXbmiHWAl15tkf37i9FLNdYEK2E4WAvEcnjVjXzu2F8=;
        b=MtHco88Z84MurDEgthAEZbKt8IuMkQt4Ef7ngiHlA4H7bulpNnxziJOBtXOvNw9Mhd
         XS15+M1yQ5HuUfmWswqLBTy8wh7ITJAafBmgPW1mwYckRsk0rnRITfRhJebRGbh4GvtR
         lxbQymmnPXWVcTnzNnqDgeRIyHNUEWddO44Oge4ve4k1AxQ6R9R0Um6wwprwhxnCO50r
         zn9gDQ9fnPwNdbajhgaijLE4PVoH1/UJfW1BeiPQ2DQwWM/vJ6sjRSe730VCljohWR0r
         wYFZBxLgPrbHOuMWutn8Dg+ETTZBRjJF3uT6krn2XkyD6AyNspaNuZz0B/nmdeMNnjf1
         LhrQ==
X-Gm-Message-State: AOAM533f5HQB4jwETRfgrQeLCIs+WZ8ybW2rQK76vNj7gtPS66Iyv8iK
        QKNTNny1EsgFw1lNtHRCjUeweJUB+AYAW/NVGgTAMeQduVJhCocrx2S9c/MUe2f3p0EwHAGw/5+
        2xLfMoffXRpQicwgyiW7h3NaFg8kumVssmg1hT+N2CNEbM5gVpH0WiCctySn8Kdu0YI//9k1M
X-Received: by 2002:a17:907:da9:: with SMTP id go41mr4338255ejc.326.1613155152685;
        Fri, 12 Feb 2021 10:39:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz8rrJRwdCQ1r6c31h0pLMtGN0Ra7yotJSnsCw+gvPvak/G0DmzL01Lc2uC4wMbfczeUS822g==
X-Received: by 2002:a17:907:da9:: with SMTP id go41mr4338239ejc.326.1613155152515;
        Fri, 12 Feb 2021 10:39:12 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c1e-bf00-1054-9d19-e0f0-8214.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1054:9d19:e0f0:8214])
        by smtp.gmail.com with ESMTPSA id zg22sm6677690ejb.0.2021.02.12.10.39.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Feb 2021 10:39:12 -0800 (PST)
Subject: Re: [PATCH 0/3] iio: add labels with accel-location to bmc150 and
 kxcjk-1013 drivers
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
References: <20210207160901.110643-1-hdegoede@redhat.com>
 <20210212183332.7769e70b@archlinux>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <9f3dfd69-c0cc-13d1-d7b5-738387dcb9e4@redhat.com>
Date:   Fri, 12 Feb 2021 19:39:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210212183332.7769e70b@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 2/12/21 7:33 PM, Jonathan Cameron wrote:
> On Sun,  7 Feb 2021 17:08:58 +0100
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Hi All,
>>
>> Here is a patch-set implementing the standardized "accel-display"
>> and "accel-base" label sysfs-attributes defined in my earlier
>> "[PATCH 1/2] iio: documentation: Document proximity sensor label use"
>> "[PATCH 2/2] iio: documentation: Document accelerometer label use"
>> series.
>>
>> This patch sets adds these labels to the bmc150 and kxcjk-1013 accel
>> drivers.
> Series applied to the togreg branch of iio.git and pushed out as testing
> for the autobuilders to poke at it.

Thanks, much appreciated.

But this was sorta a follow-up to:

[PATCH 1/2] iio: documentation: Document proximity sensor label use
[PATCH 2/2] iio: documentation: Document accelerometer label use

Where 2/2 defines the standardized label values which this series uses
and AFAIK those have not been merged yet?

I guess we can always fix the labels if discussion surrounding those
leads to standardizing on different label contents for this. But if
the discussion surrounding those results in the conclusion to not
use labels for this at all, while we already have this merged, then
we probably need to revert 2/3 and 3/3 of this series...

But maybe I just missed the 2 documentation patches getting merged ?

> Note we are almost certainly too late for coming merge window so this
> will be next time around.

That is fine.

Regards,

Hans

