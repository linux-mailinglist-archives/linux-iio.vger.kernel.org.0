Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D16614D2
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 12:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjAHLkR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 8 Jan 2023 06:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjAHLkQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2023 06:40:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50720DEED
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 03:40:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BD19B80977
        for <linux-iio@vger.kernel.org>; Sun,  8 Jan 2023 11:40:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BDD8C433D2;
        Sun,  8 Jan 2023 11:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673178012;
        bh=VTwcWE7nK7fi/qxGDrR+V+vq/EKozU6M2WKS4UhbaaU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uuahwJod/7ZMfRMgHNrbu3EFJJr+TN1kOOD44KbTgmAA7NARiF2y+cDGTlDhjvM4u
         4z7UIv3gitND96h4ZD0g/mIlNgLQD2GCO440lBgn+zcmDxcyQgTkEin5PDwhYwZ9s8
         8cmqrVZ+8x172ZHfKI80MwCuqoDbHGrb81OKT8GtyCOJDiczShJ6eyTLVU4zqxB/Tg
         u+INf9iu9VKfBBgQpY12PW3qPtnmP+PrtOZ+f02LCC8pgd+hJD0QzaR3I/ZWqRjFGU
         XmOVXIjT6FbXCgVz5UXpLKq+nBHSGuHIcs2crJpgAp371JHd/uy+iYaQmnRnKiPYW3
         3izRsRq3gvA7g==
Date:   Sun, 8 Jan 2023 11:53:41 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Derek John Clark <derekjohn.clark@gmail.com>
Cc:     linux-iio@vger.kernel.org,
        =?UTF-8?B?Sm9hcXXDrW4=?= Ignacio =?UTF-8?B?QXJhbWVuZMOtYQ==?= 
        <samsagax@gmail.com>, Hans de Goede <hdegoede@redhat.com>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: BMI0160/260 conflicts
Message-ID: <20230108115341.6929e7c5@jic23-huawei>
In-Reply-To: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
References: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 7 Jan 2023 19:51:59 -0800
Derek John Clark <derekjohn.clark@gmail.com> wrote:

> Greetings,
> 
> I have identified a trend where handheld PC manufacturers, primarily
> from China, are not properly identifying the IMU's in their device
> DSDT's. I was hoping to start a dialogue on possible remediation at
> the kernel level as I only imagine this issue compounding further. I
> have an idea of the solution, but considering the amount of work for
> it I at least wanted to see what the general thoughts of the
> maintainers were first.  My apologies for the length here, I have done
> quite a bit of investigation before reaching out as I wanted to have
> all my ducks in a row.
> 
> Background:
> The first instance was AYANEO with their founders edition & 2021
> models using 10EC5280 instead of BMI0160. A kernel patch was submitted
> a while back that ultimately stalled for this being considered
> incorrect. For context:
> https://lore.kernel.org/all/Yfqv8V6fZBnG5J5H@smile.fi.intel.com/
> 
> Unfortunately the issue has only compounded with time. GPD has been
> shipping their WinMax2 with 10EC5280 in the DSDT, and the early GPD
> Win4 prototypes sent out are using the same despite it actually having
> a BMI0260, which isn't currently supported in the kernel.
> 
> Three other manufacturers are using BMI0160 in their DSDT when they
> have a BMI0260. Specifically, the Aya Neo AIR Pro (5825u model), OXP
> Mini Pro, and AOKZOE A1 are all guilty of this. Unfortunately this IMU
> isn't a complete drop in replacement. While it uses some of the same
> registers, many are different. I won't go too into the weeds, but for
> this discussion the most important is that the CHIP_ID uses the same
> registers but is reported 0x27 on the BMI0260's while the BMI0160's
> are 0x1d. Based on all these findings I don't believe it is possible
> to have a separate bmi260 driver.
> 
> Remediation:
> I have reached out to the aforementioned companies about releasing
> updated BIOS for each of the respective models to correct the DSDT
> ID's. AYANEO and GPD seem receptive as they have each provided beta
> BIOS for testing. 

Great.  Hopefully that means that the scope of problem devices from
these manufacturers is not going to grow too much going forwards!

> There are still plenty of devices in the wild
> however that will likely not be fixed, and there's no telling what
> will be created in the future considering the rapid growth in this
> market. OneNet forwarded the concern to the OXP/AOK engineering team
> but have not provided comment at this time.
> 
> I think the only reliable way to resolve this effectively would be to
> utilize the IMU reported chip ID to actually identify which device is
> present, using the ACPI ID as an entry point for the driver. This
> would likely require some redesign of the driver, wherein all common
> functionality between chips would exist in the existing bmi160_core to
> ensure backwards compatibility. This would essentially become the
> entry point where all three ACPI IDs trigger a read of the CHIP_ID
> before splitting off to load IMU specific registers and functions.

Whilst it's previously been more common to see a mess on this front for
DT, we do have drivers that use the 'compatible' as more of a hint than
anything else.  The approach being.

1) Check for the chip ID matching the expected.  All good use that.
2) Check for a match against other known IDs.  Print a warning message
   but use the values for the right device.
3) If no match, use the values for the compatible originally given.
   The reasoning behind this is that new devices might come along that
   are truely backwards compatible, but include extra features.
   We want them to work with the supported features out of the box
   so the dts includes a fallback compatible to the simpler old device.

I have no problem with doing similar for ACPI.  IIRC it even has the
equivalent of fallback compatibles to cover that 3rd case.
For the ACPI case we might have to deny certain fallbacks if we know
they are shipping in devices and are broken (sigh).  Or we only use
the fallback route if the _CID is provided - which is the right way
to do compatible handling in ACPI anyway.

The bigger issue here was that the manufacturers were using the
ID space of a realtech pci device.  I'm not so worried if they just
break things in their own ID spaces but potentially breaking
things for someone else is a big problem.

*Sigh*. Doing this stuff right in the first place is so easy and
the specs are free to anyone etc...

Thanks for your hard work tracking down people who can hopefully
improve what they do next time around.

Jonathan


> 
> This is similar to how ChromiumOS manages these two IMU's, which
> incidentally I'm using that driver as the primary source of
> information about the 260 since Bosch haven't released a comprehensive
> datasheet on it.
> 
> Link for the curious, see accelgyro_bmi_x files for reference:
> https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver
> 
> Thank you for your time, I await your feedback.

