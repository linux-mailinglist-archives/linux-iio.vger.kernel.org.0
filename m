Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389E73534CB
	for <lists+linux-iio@lfdr.de>; Sat,  3 Apr 2021 19:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhDCRBb (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 13:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236855AbhDCRBa (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 13:01:30 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3742AC061788
        for <linux-iio@vger.kernel.org>; Sat,  3 Apr 2021 10:01:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w28so11575135lfn.2
        for <linux-iio@vger.kernel.org>; Sat, 03 Apr 2021 10:01:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=lI/1OIoZnH0zHCP8zocmSNndjhp0wXRUN/SXyEbSp7o=;
        b=LFPZ4vZUpnHnF3kzGUOxn0VBpF3tVlu8ESNevVv8UBT8zQIGyQEeOB2NJUzP4UZlvu
         oKgOXIW0UDgOqPW3bb5fnvZsU6aFEOc3+rSPaTXT+gFC97hUx+DVjpb9fkEuoU9tnpHY
         T0GRk5fSxrAxyxhC0f2YLWIYIBX0o2QC52z3r8gCDo7LrY7l7wJfbAVvrCKX5JvAL5J5
         4RUcZ5IMV6/TJrMuvlMGiPq+hqBzxuawkz2ILeMVGuX1jDMdJRRNQMSvqwj3NSDV6172
         os8U04qPvxF+0w95t8MrVcgGi6F2x3GyrFIYmi1VlYGBkO9XCusKsO7n4lZs0i48rZ6A
         lNow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=lI/1OIoZnH0zHCP8zocmSNndjhp0wXRUN/SXyEbSp7o=;
        b=Ck5rozPAeSZsEjkyTM0F24EGuSjHFlK2VbAGFUe/gREBtJ6mJ6RIT3AO4m6W7+5Gjg
         7HjkSnFZYf7RynTJ3lriZJ/tYuzvyf5D/X31wxeivl59NuSaMNqEYvBF5fuhOe7gHSB5
         K52r1fRD4HP07pWvKTq1Q96Ip6YrmpVCl/ikek+/9g+zFVan17rKfBqTwf58l4ZC/wsz
         RJsA2ZelF+DKDVmc5Zo6Hze+hY5MXq40WXYLC6tpalX2V4neRRHxCpj3GIuGZU5GeO6H
         vvo5GkTWNpbhsTCQkD0ZcyFOpwBM6YCVnal6AKorLNicLJgxOJvWXfGJqrUz3acQh3Dm
         8nAw==
X-Gm-Message-State: AOAM5322omofF7bGLrvG+0PvoSPbbq8VjQeUlwnVqV3ehUr9T441o8l7
        2La06M9F+77WgMmwKI6GKh6wLYe+4l+DcHnCzWAlskx75pqGNQ==
X-Google-Smtp-Source: ABdhPJx1VEB6XJaF57ViQBiyLEIu6QoTpGYHrmKVxM4eZ8lwh/ojbHxIxtcDKGPOCFcRaI4Yk0oihJyNkPFtN92oAVg=
X-Received: by 2002:a19:f812:: with SMTP id a18mr12272739lff.254.1617469285453;
 Sat, 03 Apr 2021 10:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <CANk7y0j89CFD7y2sY8B+H+YQ8P-w3EXmjzSL2=UitLpcgjYttQ@mail.gmail.com>
 <CANk7y0hhsP6j6geLGrHc=A=B_h7_Gv_7Y2R+RtL+KACVEVcZtw@mail.gmail.com>
In-Reply-To: <CANk7y0hhsP6j6geLGrHc=A=B_h7_Gv_7Y2R+RtL+KACVEVcZtw@mail.gmail.com>
From:   Puranjay Mohan <puranjay12@gmail.com>
Date:   Sat, 3 Apr 2021 22:31:13 +0530
Message-ID: <CANk7y0hAzcJAtQ7qbdvZZbNked=w7Nmj7OdLHyx-E1zKV+B=Eg@mail.gmail.com>
Subject: Re: IIO: GSOC 2021 Project Proposal
To:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Bogdan, Dragos" <Dragos.Bogdan@analog.com>,
        alexandru.ardelean@analog.com,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Sorry, I replied through my smartphone and it sent it in HTML, so it
didn't go through the mailing list.
I really regret doing this.


On Sat, Apr 3, 2021 at 10:23 PM Puranjay Mohan <puranjay12@gmail.com> wrote:
>
> Hi Everyone,
> I am looking forward to hearing from you. Please give some feedback, it will be very helpful for me.
>
> Thanks & Regards
> Puranjay Mohan
>
> On Tue, 30 Mar, 2021, 22:07 Puranjay Mohan, <puranjay12@gmail.com> wrote:
>>
>> Hi Everyone, I am Puranjay Mohan a junior at SRMIST, India, pursuing
>> electronics and communications engineering. I wish to participate in
>> the GSoC 2021 as a part of Linux Foundation, IIO Workgroup.
>>
>> I have been contributing to the Linux kernel and have more than 30
>> accepted patches. I was a mentee in the Linux Kernel mentorship
>> program where I worked under the mentorship of Bjorn Helgaas(PCI
>> maintainer) on PCI latency tolerance reporting.
>>
>> I have completed the IIO_tasks,  for learning the IIO Subsystem I am
>> working on an IIO Driver for TI's TMP117 temperature sensor, the patch
>> can be seen here:-
>> https://lore.kernel.org/linux-iio/20210320064509.119878-1-puranjay12@gmail.com/
>>
>> For GSoC 2021, I have chosen the ADXL355 Accelerometer as my device of
>> choice, but I am ready to work on another device if Analog Devices,
>> Inc. wants to get the driver for another device. I choose this device
>> because I saw a post on ADI Engineer Zone asking for its driver.
>>
>> I know it is too early, but I have written a proposal and wish to get
>> your comments on it so that I can improve it further.
>> Here is the google docs link, please add your comments on
>> it:-https://docs.google.com/document/d/16xusxryh_3F7Svje14fD7dAx6qzEN4fbFPpvvdJB09A/edit?usp=sharing
>>
>> --
>> Thanks and Regards
>>
>> Yours Truly,
>>
>> Puranjay Mohan



-- 
Thanks and Regards

Yours Truly,

Puranjay Mohan
