Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FC655D99C
	for <lists+linux-iio@lfdr.de>; Tue, 28 Jun 2022 15:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiF1Mf7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 28 Jun 2022 08:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiF1Mf7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 28 Jun 2022 08:35:59 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5122ED77
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:35:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id p136so15761694ybg.4
        for <linux-iio@vger.kernel.org>; Tue, 28 Jun 2022 05:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=dXeLXPCxiWqN7jgHDWdSTPe2Ap3emKS/DkWHTPafUZA=;
        b=RmMIxcyYHlWiiKAVuqcXaFv4p9EUKQNFun1yMSg0FdJvc67isBbagam9cajB6kdcTL
         nbD98wVORCz7JU8rt3CkZy5qTtgB6/UVn5QoGiHQH5PmNbK8Dn+vCUqUKWp1HCvmtuQU
         qKUqY0UMonTf9CMX+BBNnWkOHcVG4663Xoxu8F/Ob/GkrM27vvEfPw+QCr8CQYQ09s6f
         Ly2hS40kmRlGeQytDRYfTY9Ul6SB2ARArLzlLfdqf2SHDCuH7zYePdOsCe52IvMlCwHI
         n5HPkVXigQlMe4cnYJMV63oJjS5hOSnvrCg7v75OGvc/kj22GkxWQko0wv67d3pJG2Gq
         grew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=dXeLXPCxiWqN7jgHDWdSTPe2Ap3emKS/DkWHTPafUZA=;
        b=jT8xTfT2lrwgEWQCa5QvSh7oHAyDt4EXD68IjZEAki2iDGzAL0ovgyWMjLwrGod6HV
         zanrXCfred2nJsDBKx/gt0FAAyI0hqqoZGEKrtMpZ7fZ9vNeWcYr00mWOAjt/mHKiqO+
         awMxo+hfWVWUXNxaqZkG1YNpshes0Hto4ImfBk4vA5cia/nMyqO2buGkadNSD23TkPoY
         pv0WZqXMVyP63RpdF6LLAg0y8Y7uCIKn7kRTnrPKyy24oHtpnGmeAWdL4h4pW1QkTt8z
         IM9jTowI2wU9xfhfChjB++lxO/TZaumgbP++njEvWC88VLQA3oWsQny/8JLQWYaXYfU9
         GS0w==
X-Gm-Message-State: AJIora+mDuD+zghf04xSFP+c5Drs/37ryvTYjKbwAIIZeWSaXM9OfK1z
        sX348rQIkzyF4Tvj3l/3CZrAevcx308/LWhcH34vnvDd1eNolQ==
X-Google-Smtp-Source: AGRyM1uYOKceRRtf4nrQJOT+wLe/mzghVn1AqPf1gbIXjp23nBkWtati6/2kVJxdF6H4ldT6ZjjpR4NUaHdx3Z3WTpc=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr20819095ybg.296.1656419757485; Tue, 28
 Jun 2022 05:35:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMONXLtN9-t=SuNzDWk22ufYXQHh7ZkXD2FhrRmR_uRgJFmZng@mail.gmail.com>
In-Reply-To: <CAMONXLtN9-t=SuNzDWk22ufYXQHh7ZkXD2FhrRmR_uRgJFmZng@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 14:35:20 +0200
Message-ID: <CAHp75Vd28B5HFcmOPoT4HS0MHyCs8-WXUxSzgVgpg1nXj5sR7g@mail.gmail.com>
Subject: Re: Dynamically configured channels, overlap with GPIO, encoder support
To:     =?UTF-8?Q?Giedrius_Trainavi=C4=8Dius?= <giedrius@blokas.io>
Cc:     linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Jun 28, 2022 at 12:06 PM Giedrius Trainavi=C4=8Dius
<giedrius@blokas.io> wrote:
>
> Hello,
>
> I am developing an extension board for Raspberry Pi, it has a
> microcontroller on it and I'm trying to expose its pins as a I/O
> expander via I=C2=B2C bus. I've recently successfully implemented gpiochi=
p
> interface as well as irq_chip in a kernel module, and now I'm looking
> at adding ADC support, Industrial IO seems like a good candidate for
> exposing it, but I have a couple of questions:
>
> 1. Can the IIO channels be configured dynamically? On the
> microcontroller, the same pins can be used for GPIO, ADC, etc... - can
> things like the channel direction, the function (simple high or low
> GPIO pin, ADC, PWM output) be configured by userspace programs? Can it
> be configured within a kernel module, if I provide my own sysfs
> interface for function setup?
>
> 2. Can IIO channels be appended and removed to/from the list during runti=
me?
>
> 3. Are encoders supported by IIO? I'd like to decode encoders within
> the firmware of the microcontroller, and provide only
> increments/decrements to the kernel module via I=C2=B2C, can encoders bui=
lt
> in such a way be exposed via IIO? I've seen some patches on the
> internet adding 'counter' interface to IIO, but it seems it never made
> it to be within IIO, and instead the 'counter' in its own subsystem.
>
> 4. How does IIO interact with gpiochip? As I'm implementing gpiochip
> interface, I could simply return -EBUSY for pins already used by the
> other subsystem.

We have a DLN2 adapter that provides 4 interfaces with overlapped GPIO
pins, I don't remember how they solved this. Perhaps the
microcontroller itself refuses GPIO line acquisition when it's in use
for other functions.

Hence, I recommend looking into the drivers for Diolan DLN2.


--=20
With Best Regards,
Andy Shevchenko
