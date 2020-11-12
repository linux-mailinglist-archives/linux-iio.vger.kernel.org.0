Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1442AFF92
	for <lists+linux-iio@lfdr.de>; Thu, 12 Nov 2020 07:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgKLGXy (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 12 Nov 2020 01:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbgKLGXx (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 12 Nov 2020 01:23:53 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15C8EC0613D1;
        Wed, 11 Nov 2020 22:23:52 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id 34so38021pgp.10;
        Wed, 11 Nov 2020 22:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OIhd3mPHGXUKi53MawqoYGKb0TVJcQxotMsgj9HyU3M=;
        b=rmaJp67NJIvoDowN01zns2CXI4p1V5e3Y/ZhTDgsE+mr7du3aeLnh/lYwFgssYkcJN
         LCCZjyY/h6HZ6l1kLWeCxLUHK76wf7tPH7BA3PLXChvPpXlwn9NEbm04BOPQMJqAYp7W
         2bUAUZu7xfvxFhA8BuEBwbgB5tFGppcHh1tkb5KUHWy6tfEKx2dE89Vq6pNVNUfrccO5
         +m/38Ix4uUAQGlSQAyCXm9f73Hn0NTkNKt0rNm9MDLY8Brxd7zrFdFQBolKxkoSNbAym
         RGTBl36T8nkWBI15GPvmEjTDqK5EdMqoKkA/6A3h+Sd/s3CMzO4lZqBRngF3dIa7YA1t
         kFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OIhd3mPHGXUKi53MawqoYGKb0TVJcQxotMsgj9HyU3M=;
        b=S479k2XwkQUwIt9EYd+ZxIoVi+7JQD65r+BN/s1jDWXdMqSHTx0fadphmY9TSmjWgU
         VgZBM1xeO+FndXkJXqHjaQHrsjQ/Ih9w7gB9PrXyvu8NT75AfV4CIWL3R1yLYizWzGuN
         PJ6iHCdYumo//b9+gEvYWlv7fZczudVoZ7+eeVOJ1drYjVIazNXVcpMSwPArMWliI+y8
         hIXbEnO00WFXp5kHGwFbgbNef6HYYMR+Sf18S/d5TEPaFyCxdgsE0FNBILzg5adBVWef
         R4ppP1B9J0JibEF9yaZWSgnRukDo3UZbKD2NTbRv6qd9XSB1aGXWcXBDg0+oqb0XIlHS
         Dt5w==
X-Gm-Message-State: AOAM533zBoA75ieXnUQz8ANIvlbsy1MBJUEfe/EItj5+245Yg/yzJ4aX
        Wuip/dkq2Zi42mCRleqqZ5w=
X-Google-Smtp-Source: ABdhPJzv1ETbt4VnaBCJ1YTAAiAmkqrE5DAiBoPrj2v8rlyV9lIT6qAZ1KqHlrgQsM8mY7PctQ2sHw==
X-Received: by 2002:a63:d542:: with SMTP id v2mr4322235pgi.250.1605162231399;
        Wed, 11 Nov 2020 22:23:51 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:a6ae:11ff:fe11:fcc3])
        by smtp.gmail.com with ESMTPSA id ce19sm5443034pjb.53.2020.11.11.22.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 22:23:50 -0800 (PST)
Date:   Wed, 11 Nov 2020 22:23:48 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Pearson <markpearson@lenovo.com>,
        linux-iio@vger.kernel.org, Bastien Nocera <hadess@hadess.net>,
        Nitin Joshi1 <njoshi1@lenovo.com>, linux-input@vger.kernel.org
Subject: Re: [External] Using IIO to export laptop palm-sensor and lap-mode
 info to userspace?
Message-ID: <20201112062348.GF1003057@dtor-ws>
References: <9f9b0ff6-3bf1-63c4-eb36-901cecd7c4d9@redhat.com>
 <5a646527-7a1f-2fb9-7c09-8becdbff417b@lenovo.com>
 <20201007083602.00006b7e@Huawei.com>
 <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <218be284-4a37-e9f9-749d-c126ef1d098b@redhat.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Oct 07, 2020 at 11:51:05AM +0200, Hans de Goede wrote:
> Hi,
> 
> On 10/7/20 10:36 AM, Jonathan Cameron wrote:
> > On Mon, 5 Oct 2020 22:04:27 -0400
> > Mark Pearson <markpearson@lenovo.com> wrote:
> > 
> > > Adding Nitin, lead for this feature, to the thread
> > 
> > +CC linux-input and Dmitry for reasons that will become clear below.
> > > 
> > > On 2020-10-03 10:02 a.m., Hans de Goede wrote:
> > > > Hi All,
> > > > 
> > > > Modern laptops can have various sensors which are kinda
> > > > like proximity sensors, but not really (they are more
> > > > specific in which part of the laptop the user is
> > > > proximate to).
> > > > 
> > > > Specifically modern Thinkpad's have 2 readings which we
> > > > want to export to userspace, and I'm wondering if we
> > > > could use the IIO framework for this since these readings
> > > > are in essence sensor readings:
> > > > 
> > > > 1. These laptops have a sensor in the palm-rests to
> > > > check if a user is physically proximate to the device's
> > > > palm-rests. This info will be used by userspace for WWAN
> > > > functionality to control the transmission level safely.
> > > > 
> > > > A patch adding a thinkpad_acpi specific sysfs API for this
> > > > is currently pending:
> > > > https://patchwork.kernel.org/patch/11722127/
> > > > 
> > > > But I'm wondering if it would not be better to use
> > > > IIO to export this info.
> > 
> > My first thought on this is it sounds more like a key than a sensor
> > (simple proximity sensors fall into this category as well.)

[ sorry for sitting on this thread for so long ]

So I think the important question here is if we only ever want yes/no
answer, or if we can consider adjusting behavior of the system based on
the "closeness" of an object to the device, in which case I think IIO is
more flexible.

FWIW in Chrome OS land we name IIO proximity sensors using a scheme
"proximity-lte", "proximity-wifi", "proximity-wifi-left",
"proximity-wifi-right", etc, and then userspace implements various
policies (SAR, etc) based off it.

> 
> That is an interesting suggestion. Using the input/evdev API
> would have some advantages such as being able to have a single
> event node for all the proximity switches and then being able
> to pass a fd to that from a privileged process to a non
> privileged one, something which userspace already has
> various infrastructure for.

I am not sure if multiplexing all proximity switches into one evdev node
is that great option, as I am sure we'll soon have devices with 2x
palmrest switches and being capable finely adjusting transmit power,
etc.

Thanks.

-- 
Dmitry
