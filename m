Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483A72B9612
	for <lists+linux-iio@lfdr.de>; Thu, 19 Nov 2020 16:25:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgKSPYZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 19 Nov 2020 10:24:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31267 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727193AbgKSPYZ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2020 10:24:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605799463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lszpJqSI3eY5AHkczCdj9Dt5FSswLvwnFJiuNI8t5Cw=;
        b=BB0mYTXVocSFiHeEa4FB7m2d3oqqraQmxMsWyfMeuNxutF+gHvhpsl0ToEzJxOSgi3U2ti
        EkI3rMVwYvS/SIyCyVr89ZWhag3Emq59yet1VEDD54leZuRCApOsZKvzm1botLX0VtJsQZ
        swrNwb95a88ECJxVMlrvQPTAQ7ybEqo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-DGd_aIlDODmN58ywoB8GAA-1; Thu, 19 Nov 2020 10:24:22 -0500
X-MC-Unique: DGd_aIlDODmN58ywoB8GAA-1
Received: by mail-ed1-f71.google.com with SMTP id d3so2478012eds.3
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2020 07:24:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lszpJqSI3eY5AHkczCdj9Dt5FSswLvwnFJiuNI8t5Cw=;
        b=tdb1rk5+C3Gm82p0OeJRZekIobB0P/0hSYEyrtSGe2wU6D9+DKW89b7y8T/9aU2HEB
         puXQkZMpQ0o3wVJ1D/hn2YXD9LtVr2FBW67As5xMBvYavWrMhK6KcLSXSkxvqxtyUfWR
         BXUpxy1c9+Z9uQzULPCrRr5He8Dzf+8/uG4r6UgnzxF2Wqkei66lDBaciMtN05YtcqaI
         0DqV6jqCKG+WxTwmMl/btTxPxw/cN5yQZCSZ/LA704pOYYlxH57ODaOY3dX5NzVTtPID
         A9bpxoUVpWW0BU1CcBSsHZbxsngqYKNoPcZgsDsiBtF5KrXyRAhkD65mIXBolhmlEFsb
         WP4w==
X-Gm-Message-State: AOAM533Qgxi6BXxNXsjYm9mMErEHMppDXa9N6EyGWg46K7JUARTNEHcj
        +2L35lnRaw/kjXOtP1CMFn0+cI1OtfFgFQE2OywRRT4ohZofMkt6XNDq7dEWGO1dTebNTaRpGZY
        XZ18lqA5U6+OcO9WTReBm
X-Received: by 2002:a50:85c6:: with SMTP id q6mr32435566edh.126.1605799460767;
        Thu, 19 Nov 2020 07:24:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUrvFpsfkC2FtqUtyt4sD4BX7TPMl6noqDcSqQsjhWgC2ws9+3GgbuVaz9JqG9dOoz08nEEA==
X-Received: by 2002:a50:85c6:: with SMTP id q6mr32435550edh.126.1605799460581;
        Thu, 19 Nov 2020 07:24:20 -0800 (PST)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-6c10-fbf3-14c4-884c.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:6c10:fbf3:14c4:884c])
        by smtp.gmail.com with ESMTPSA id f18sm15202540edt.32.2020.11.19.07.24.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 07:24:19 -0800 (PST)
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
To:     Bastien Nocera <hadess@hadess.net>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Nitin Joshi1 <njoshi1@lenovo.com>,
        linux-input@vger.kernel.org
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
 <20201112062348.GF1003057@dtor-ws>
 <96e2c4ebd7e826b6ea52f72f301fb5e8c33479d5.camel@hadess.net>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <19622786-6aa9-483a-bbad-28112ea3609a@redhat.com>
Date:   Thu, 19 Nov 2020 16:24:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <96e2c4ebd7e826b6ea52f72f301fb5e8c33479d5.camel@hadess.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/19/20 4:16 PM, Bastien Nocera wrote:
> On Wed, 2020-11-11 at 22:23 -0800, Dmitry Torokhov wrote:
>> <snip>
>> I am not sure if multiplexing all proximity switches into one evdev
>> node
>> is that great option, as I am sure we'll soon have devices with 2x
>> palmrest switches and being capable finely adjusting transmit power,
>> etc.
> 
> Hans, Mark, so is there a consensus to how we should export the "lap-
> mode"?

Given Dmitry's input itl ooks like we need to go back to using iio
for this. Probably with something like my initial proposal wherre we
add an in_proximity_location sysfs attribute to the iio-devices which
represent the lap-mode and palmrest sensors. But ChromeOS is doing
something different to figure out which sensor is which, so this needs
a bit more discussion.

I'll go and reply to Dmitry's latest mail on this now and then we will
see from there.

> I had nearly finished working on updated code and all the test suite
> changes needed to use an input device with switches when IIO started
> being discussed, so I stopped in my tracks.

Ouch, sorry about this.

Regards,

Hans

