Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C6B661382
	for <lists+linux-iio@lfdr.de>; Sun,  8 Jan 2023 04:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjAHDwN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 7 Jan 2023 22:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjAHDwM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 7 Jan 2023 22:52:12 -0500
Received: from mail-ua1-x931.google.com (mail-ua1-x931.google.com [IPv6:2607:f8b0:4864:20::931])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71DF232E99
        for <linux-iio@vger.kernel.org>; Sat,  7 Jan 2023 19:52:11 -0800 (PST)
Received: by mail-ua1-x931.google.com with SMTP id s23so1252522uac.6
        for <linux-iio@vger.kernel.org>; Sat, 07 Jan 2023 19:52:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NZ9QM5q5OooO3p3zFixbB/pyfxE5A4wy03+O14NOUVs=;
        b=NWwE/Xp4feUvyOulMZ7ZskZkpOJ+FvwssIKeir9EC1Ef8Cx68jB0TWoSmGQGo2ZPOp
         ILJMgCxz4Fq3v/7nfUjWbOLbFr+lawtrpA5djZBVAO7HufBqPxaQ2mM5ez1Hi2T56FN1
         MENkcBsEUfY/mmu5RPYTlq4mUw25VRXcny2zrrE5PU7LaXFgzS0ndzIN7QouwQpxtKXk
         iuMRX5qlHccY/F07ozOjj/xVIHFZbBXL+Sy+EyzWfqc4vtrez3MpfPKdj2K/iYMksMi5
         iuXHZfPDeBT3gZOylxY2h3ncZ2OZJsDshtafXWMufr3e9yOd5kkDy/7ZJrG+z9ZM431V
         OLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NZ9QM5q5OooO3p3zFixbB/pyfxE5A4wy03+O14NOUVs=;
        b=6x+s8mrpWr0CWxGorh3E9ViPACpbnR6tUj6q8NcCfKgmaM092mG1lumxt/sVCsHhGh
         DacDRidJv8FFUBswzogULWAv2i/tEhxcJk3eQTv2fOHhN96rhnzOaRFhzGmZ6RlSZYqN
         gF7XMce25pEWhmgTjlPFqQoGVkFUOQ0ioJ/ghhQEbgyxvDTR2TZWQOpnVXtlO4lZk6IT
         cIA4StIk4gwypQ4RXSrICbiZ/ggpAWCh8ZdJqQCL05oJp9DFQi+6fG2eiANZ5jPch2TK
         A6zNWGyFcOBE8CFI8gGkiFXAXQN/1GwHggcC2/Fbm1xNHtvTF7PoOZ1hPoAgMDFQuYbU
         7mtw==
X-Gm-Message-State: AFqh2kows4MyqEpqOLSd36ufdOy+XW2RD13xXn7dKJv1/B1f+jvIEjDG
        8R6Pehs1AoHJzMX5gq4ZwmVJuCUPuiKSGL45Gymir66xZxo=
X-Google-Smtp-Source: AMrXdXurS6k0Y3xSAmMhb5tvjLyJ3Gh3dUdOA/M0hR26dVZNJqCd5H2NOm/6yisHPulw87XQgfswiT8r3G4wAK3Ds8Y=
X-Received: by 2002:ab0:1301:0:b0:444:2123:f8df with SMTP id
 g1-20020ab01301000000b004442123f8dfmr6436274uae.86.1673149930354; Sat, 07 Jan
 2023 19:52:10 -0800 (PST)
MIME-Version: 1.0
From:   Derek John Clark <derekjohn.clark@gmail.com>
Date:   Sat, 7 Jan 2023 19:51:59 -0800
Message-ID: <CAFqHKTm2WRNkcSoBEE=oNbfu_9d9RagQHLydmv6q1=snO_MXyA@mail.gmail.com>
Subject: BMI0160/260 conflicts
To:     linux-iio@vger.kernel.org
Cc:     =?UTF-8?Q?Joaqu=C3=ADn_Ignacio_Aramend=C3=ADa?= 
        <samsagax@gmail.com>
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

Greetings,

I have identified a trend where handheld PC manufacturers, primarily
from China, are not properly identifying the IMU's in their device
DSDT's. I was hoping to start a dialogue on possible remediation at
the kernel level as I only imagine this issue compounding further. I
have an idea of the solution, but considering the amount of work for
it I at least wanted to see what the general thoughts of the
maintainers were first.  My apologies for the length here, I have done
quite a bit of investigation before reaching out as I wanted to have
all my ducks in a row.

Background:
The first instance was AYANEO with their founders edition & 2021
models using 10EC5280 instead of BMI0160. A kernel patch was submitted
a while back that ultimately stalled for this being considered
incorrect. For context:
https://lore.kernel.org/all/Yfqv8V6fZBnG5J5H@smile.fi.intel.com/

Unfortunately the issue has only compounded with time. GPD has been
shipping their WinMax2 with 10EC5280 in the DSDT, and the early GPD
Win4 prototypes sent out are using the same despite it actually having
a BMI0260, which isn't currently supported in the kernel.

Three other manufacturers are using BMI0160 in their DSDT when they
have a BMI0260. Specifically, the Aya Neo AIR Pro (5825u model), OXP
Mini Pro, and AOKZOE A1 are all guilty of this. Unfortunately this IMU
isn't a complete drop in replacement. While it uses some of the same
registers, many are different. I won't go too into the weeds, but for
this discussion the most important is that the CHIP_ID uses the same
registers but is reported 0x27 on the BMI0260's while the BMI0160's
are 0x1d. Based on all these findings I don't believe it is possible
to have a separate bmi260 driver.

Remediation:
I have reached out to the aforementioned companies about releasing
updated BIOS for each of the respective models to correct the DSDT
ID's. AYANEO and GPD seem receptive as they have each provided beta
BIOS for testing. There are still plenty of devices in the wild
however that will likely not be fixed, and there's no telling what
will be created in the future considering the rapid growth in this
market. OneNet forwarded the concern to the OXP/AOK engineering team
but have not provided comment at this time.

I think the only reliable way to resolve this effectively would be to
utilize the IMU reported chip ID to actually identify which device is
present, using the ACPI ID as an entry point for the driver. This
would likely require some redesign of the driver, wherein all common
functionality between chips would exist in the existing bmi160_core to
ensure backwards compatibility. This would essentially become the
entry point where all three ACPI IDs trigger a read of the CHIP_ID
before splitting off to load IMU specific registers and functions.

This is similar to how ChromiumOS manages these two IMU's, which
incidentally I'm using that driver as the primary source of
information about the 260 since Bosch haven't released a comprehensive
datasheet on it.

Link for the curious, see accelgyro_bmi_x files for reference:
https://chromium.googlesource.com/chromiumos/platform/ec/+/master/driver

Thank you for your time, I await your feedback.
