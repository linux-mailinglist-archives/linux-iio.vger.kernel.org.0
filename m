Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5002E2C3FD9
	for <lists+linux-iio@lfdr.de>; Wed, 25 Nov 2020 13:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgKYMWV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Nov 2020 07:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728338AbgKYMWV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Nov 2020 07:22:21 -0500
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7EC0613D4
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:22:21 -0800 (PST)
Received: by mail-il1-x12d.google.com with SMTP id r17so1925110ilo.11
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2020 04:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qvBKs9ju5VjHAC6tWnPzjT1vN/JTWxe0m67O8ywsqM=;
        b=Nac+yVW2EH56oZmxhHcUlKMYuKExLipusPZxxB52R4Dvf3U8bFdtlk4mLNzyMQzaHj
         CqRxhWCcz/9uYpM5MPxZmKJ6o9gp6uB9JpgqsjeLOcMzHbZ6HqP+gF+OT1foDW+irYeq
         qSnKGrjPBpuy5exQP2rU4cZwy0Pee1AuEipqnrw+nXVRq0EwyaKg2Fp4R09E1qfJZ1pp
         dabYU0eSSOhIVy41n86MYl2W/d4/zqZx3qotpMNPXRtKO6DlhCAXw8G8Eke0WBiwvmJu
         L3CROZIcfjcBXq5HFoOLNtTJnhpwshcm2ddOdXCOwxVPzJV9gwAdcl1qPc+8euPaP+P5
         hlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qvBKs9ju5VjHAC6tWnPzjT1vN/JTWxe0m67O8ywsqM=;
        b=c17Lo8J57DoGfj1n1sXRKX6UXMcbZo/RFfDDTtp3ogQGLAZX4RHQMJidPsl4WJTcQk
         YE1DNpasE7DJzwNy0iGZ8eD8eGWLDj6Jr5DFJkMWJ2fATXKKSjQ+AFqQAIj89l5/2Qfs
         bbmfDjpJCEDTpEv/HhYQ7CseKZN+G2IudU5U567aCRLlDJTQsc1p/FebNqjSVus+TVh8
         UjGuQIFVLMiBP5MehLXOF/u1e76zFTNGCBtiBQjPrWA80xuQmu5PMpoBdbL8qzvAoxux
         1IkoEVk1EkYx+kl3eVrHRSnFNiJjcitLba88dZzHFXxD51doeozkYuXJcsGuPKFBmLQ5
         gF+A==
X-Gm-Message-State: AOAM532vJJnPuwDhOAgEB2T8RvWwe5SeVd8KHT8DDWg6/AysNVgI0PBi
        PsXchn/aFOZ0r2mLAqEXmBaXI8weUWWr+INCOZI=
X-Google-Smtp-Source: ABdhPJzhK442QKSRUajT68Ne5Ni4OqVG0zd1+25zuvvIgHQYmfBNSIW9bUWdEeaP/XpZNrjnrP+RsLcvnDU8MBjuO50=
X-Received: by 2002:a92:c844:: with SMTP id b4mr2683341ilq.292.1606306940353;
 Wed, 25 Nov 2020 04:22:20 -0800 (PST)
MIME-Version: 1.0
References: <CAHp75Vfz2P=U6CFY4824hPLSSDQNh4wATE_=JjA63fXyYCpsrQ@mail.gmail.com>
 <857bbb6c-1025-df6d-871d-f0fbcafb6ad8@metafoo.de> <CAHp75VdZ1qG1yht_Wa_Npn8jv61ux+mWBeayd5x8uLOj2JarcA@mail.gmail.com>
 <57a87648-b329-6c79-21bb-629a7f4e43e0@metafoo.de>
In-Reply-To: <57a87648-b329-6c79-21bb-629a7f4e43e0@metafoo.de>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Wed, 25 Nov 2020 14:22:09 +0200
Message-ID: <CA+U=Dsq0kC5fdG_oY3zxtb1JFREok6mzT75SSx3v8hNeW3_Wew@mail.gmail.com>
Subject: Re: fake ACPI IDs in the drivers
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Nov 25, 2020 at 2:08 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>
> On 11/25/20 1:00 PM, Andy Shevchenko wrote:
> >> I'd assume that most drivers that have a acpi_device_id table do have
> >> hardware that uses that ID and were not just cargo culted.
> >>
> >> For new drivers we should push back on unregistered IDs, but if there is
> >> hardware that uses them we have to take the patches.
> > Right. But at the same time we have to push the idea of proper IDs to
> > the vendor companies, so they won't abuse ACPI specification anymore.
>
> The last couple of years have made me very cynical on this. Vendors will
> ship whatever works, not what is correct.
>

hear hear
