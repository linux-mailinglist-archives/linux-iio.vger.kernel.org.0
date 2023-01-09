Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFF8662A1F
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jan 2023 16:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbjAIPeV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 9 Jan 2023 10:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237243AbjAIPcu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 9 Jan 2023 10:32:50 -0500
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336E1103
        for <linux-iio@vger.kernel.org>; Mon,  9 Jan 2023 07:31:55 -0800 (PST)
Received: by mail-ua1-x933.google.com with SMTP id l13so2087323uai.8
        for <linux-iio@vger.kernel.org>; Mon, 09 Jan 2023 07:31:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x0l0+f0R6zM0P0hpTNvt87jdO19i49Nc71OvbH1TORo=;
        b=H0Eulc5yzudkGHISOwcsF4OQ+sFc0Dic50z02bovkGeAgeHfKeZweYKCwRmdPc+Dq+
         qNr8LweXY8mHXUcWDzij2q1fzIxA0V2RGHmfAb4+9FrDg4UJOtYCjBDL5NIyzBrHzq9U
         KEiEquwPDcZYR/SwemZkuqH15BTZhU/gMtOXJ6J1LoKNZucGWN3KqBfpe8OHzvwyw+MV
         SLp4iIRBh0X7/owKgo7Bia1jlefsM2GyFF8ID77ABZFoxJaygOrshCRc1ZAAgHbFDvfE
         tnBMOikvoWRVSvvkSPzwkf+pYRQaSSylA9VESTNY3T0z66P1XkzWaT1Y43CNbCEc+iVq
         nkGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x0l0+f0R6zM0P0hpTNvt87jdO19i49Nc71OvbH1TORo=;
        b=Wu9GUMw6v9der3irqr5A9VEPhN6lF1E1aIIoE005FghH5uw1DJJ7aFum+JZB1U2lYH
         nk6CRbbQP1Pya41fUZsys8LGbtIgDwRw7rIGb4lWa30zlEp8+EWyz/1DDDgwvyNub9XB
         fjZ897PCL2hF5Q5std4Lkdl2443YDFO9y0zcei9zVxOHTgmTDSQnx58z8Zhms53pZhGk
         Qs234kY7HV9kpLBWl3mIgRBZMj3OA3sySsl+u3+3m0SyXv8vGxHSmNrdzgS/Uz3/dGi3
         w11xDBQquegAfBHxbXvaBizo4MKH/EagJ20LchjIpV8Cr7Gkw5PTcZLC7ukAmNnNEbAy
         c4Mg==
X-Gm-Message-State: AFqh2kplqVq7R4mKvIE146ZhSfzpaiH6WIvtyMVNnF+cgcuEVBd5NuzJ
        4Z0RRuO4z00z/RVj6/5NhHuLs3xR7F7M4t3iX0mlr1H1
X-Google-Smtp-Source: AMrXdXunrOsd8tAJvDXcG/v0UAlMXZfvuXuA0OrnJR5y2043NuaWngjfl7P2YqwEnWEZmjS8f9cyEFiushdvGW9rtBU=
X-Received: by 2002:ab0:6544:0:b0:553:bde4:42f5 with SMTP id
 x4-20020ab06544000000b00553bde442f5mr4324311uap.67.1673278313534; Mon, 09 Jan
 2023 07:31:53 -0800 (PST)
MIME-Version: 1.0
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
 <20230108115341.6929e7c5@jic23-huawei>
In-Reply-To: <20230108115341.6929e7c5@jic23-huawei>
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Mon, 9 Jan 2023 07:31:42 -0800
Message-ID: <CAFqHKTn31fB3Ps_h4z+L05W1brGGeT54ahiKHuNsVW-a8On96w@mail.gmail.com>
Subject: Re: BMI0160/260 conflicts
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Jan 8, 2023 at 3:40 AM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 7 Jan 2023 19:51:59 -0800
> Derek John Clark <derekjohn.clark@gmail.com> wrote:
>
> > Greetings,
> >
> > I have identified a trend where handheld PC manufacturers, primarily
> > from China, are not properly identifying the IMU's in their device
> > DSDT's. I was hoping to start a dialogue on possible remediation at
> > the kernel level as I only imagine this issue compounding further. I
> > have an idea of the solution, but considering the amount of work for
> > it I at least wanted to see what the general thoughts of the
> > maintainers were first.  My apologies for the length here, I have done
> > quite a bit of investigation before reaching out as I wanted to have
> > all my ducks in a row.
> >
> > Background:
> > The first instance was AYANEO with their founders edition & 2021
> > models using 10EC5280 instead of BMI0160. A kernel patch was submitted
> > a while back that ultimately stalled for this being considered
> > incorrect. For context:
> > https://lore.kernel.org/all/Yfqv8V6fZBnG5J5H@smile.fi.intel.com/
> >
> > Unfortunately the issue has only compounded with time. GPD has been
> > shipping their WinMax2 with 10EC5280 in the DSDT, and the early GPD
> > Win4 prototypes sent out are using the same despite it actually having
> > a BMI0260, which isn't currently supported in the kernel.
> >
> > Three other manufacturers are using BMI0160 in their DSDT when they
> > have a BMI0260. Specifically, the Aya Neo AIR Pro (5825u model), OXP
> > Mini Pro, and AOKZOE A1 are all guilty of this. Unfortunately this IMU
> > isn't a complete drop in replacement. While it uses some of the same
> > registers, many are different. I won't go too into the weeds, but for
> > this discussion the most important is that the CHIP_ID uses the same
> > registers but is reported 0x27 on the BMI0260's while the BMI0160's
> > are 0x1d. Based on all these findings I don't believe it is possible
> > to have a separate bmi260 driver.
> >
> > Remediation:
> > I have reached out to the aforementioned companies about releasing
> > updated BIOS for each of the respective models to correct the DSDT
> > ID's. AYANEO and GPD seem receptive as they have each provided beta
> > BIOS for testing.
>
> Great.  Hopefully that means that the scope of problem devices from
> these manufacturers is not going to grow too much going forwards!
>
> > There are still plenty of devices in the wild
> > however that will likely not be fixed, and there's no telling what
> > will be created in the future considering the rapid growth in this
> > market. OneNet forwarded the concern to the OXP/AOK engineering team
> > but have not provided comment at this time.
> >
> > I think the only reliable way to resolve this effectively would be to
> > utilize the IMU reported chip ID to actually identify which device is
> > present, using the ACPI ID as an entry point for the driver. This
> > would likely require some redesign of the driver, wherein all common
> > functionality between chips would exist in the existing bmi160_core to
> > ensure backwards compatibility. This would essentially become the
> > entry point where all three ACPI IDs trigger a read of the CHIP_ID
> > before splitting off to load IMU specific registers and functions.
>
> Whilst it's previously been more common to see a mess on this front for
> DT, we do have drivers that use the 'compatible' as more of a hint than
> anything else.  The approach being.
>
> 1) Check for the chip ID matching the expected.  All good use that.
> 2) Check for a match against other known IDs.  Print a warning message
>    but use the values for the right device.
> 3) If no match, use the values for the compatible originally given.
>    The reasoning behind this is that new devices might come along that
>    are truely backwards compatible, but include extra features.
>    We want them to work with the supported features out of the box
>    so the dts includes a fallback compatible to the simpler old device.
>
> I have no problem with doing similar for ACPI.  IIRC it even has the
> equivalent of fallback compatibles to cover that 3rd case.
> For the ACPI case we might have to deny certain fallbacks if we know
> they are shipping in devices and are broken (sigh).  Or we only use
> the fallback route if the _CID is provided - which is the right way
> to do compatible handling in ACPI anyway.

Sounds good. I don't have a timeline right now but I'll start working
on this. Thank you for the feedback.

> The bigger issue here was that the manufacturers were using the
> ID space of a realtech pci device.  I'm not so worried if they just
> break things in their own ID spaces but potentially breaking
> things for someone else is a big problem.
>
> *Sigh*. Doing this stuff right in the first place is so easy and
> the specs are free to anyone etc...

From my experience, these manufacturers don't care about doing things
the right way that much. I've only been able to pressure them into
making changes because their pet projects are Linux based (AyaNeoOS
and a GPD Manjaro fork). Telling them they need to make these changes
to support their own initiatives has been more effective than trying
to explain why they shouldn't break convention. It is interesting
though that two separate companies are using the same incorrect ID. It
would seem they are either stealing from each other, or they used the
same supplier with bad data.

> Thanks for your hard work tracking down people who can hopefully
> improve what they do next time around.
>
> Jonathan




> > This is similar to how ChromiumOS manages these two IMU's, which
> > incidentally I'm using that driver as the primary source of
> > information about the 260 since Bosch haven't released a comprehensive
> > datasheet on it.
> >
> > Link for the curious, see accelgyro_bmi_x files for reference:
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver
> >
> > Thank you for your time, I await your feedback.
>
