Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F150E366194
	for <lists+linux-iio@lfdr.de>; Tue, 20 Apr 2021 23:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234163AbhDTV1E (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 20 Apr 2021 17:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbhDTV1D (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Apr 2021 17:27:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7702EC06174A;
        Tue, 20 Apr 2021 14:26:31 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id m7so34475878ljp.10;
        Tue, 20 Apr 2021 14:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NnEKqD9C28fKA636i2L+i6cL9LnMvcl3J0Uu0ib7IW4=;
        b=WxjER0/8npOdOTDj6FIdSV8HRBQrc+YXxC5qHzwww5TJguuHF9eLNflU+O9uWuv9GC
         vQFS5pW1xxeUQggIbxnFCjHQgQHHdvOWfYA6tw1zSNb1a4g08Cche+tnqZjTSKuHdlM9
         RQWCGNg4eBV4dTthM4BmJWPKEg4il4XBkqvnipLXvudzPZBC81ZaRktmZ7ZAGOmQ2UQn
         g+QfU7PvzpNcKNryvymlm93HVi5HAkCJ+li+kT7D2BoYZHPzAk96d7omFwMKms4H5i+1
         XyahZJ/L0+yxfpH/N+ltp/rnrpDI/7CVMVC1CCJTI4qz56PpFwXlHK6oXdSUxXJo5kJY
         1lQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NnEKqD9C28fKA636i2L+i6cL9LnMvcl3J0Uu0ib7IW4=;
        b=F3X9zgUxR+JksvUysL/61uTnBMmQJrxDzmhQOVZeMATe8U2dxp12DgImprA6xdxt8i
         mWefBFKdPky3KpkD9cZiXRmoWdvBjtS1dqEHL9XGQi8Rfes8zdkOWzuJoMq7Pb7xQAkx
         Xb0J9FJWBJAXF/yeLhUWNGDwqgq1DquR5yoGA1Ouf4KhuS1I+VxgK8iVYXi4BO7m5NR9
         fWb6pWMXBygYhxdvsXyy/0+WE3KnpcyilUg7wOBcw4KlG5b38t3i7MYpPOQgdrPmrAkV
         dkhjcJitRfwSWGZV0OdLj4LMYBIQv8590b0v3rCnr7y4nardv/MDRiasWIIJoYKvpWEI
         a7fA==
X-Gm-Message-State: AOAM531e3BmBV/BkYLZ580kHh0AncSUQ5prwyjTxEb8/kn6UgJBHMbh8
        JyUCkMUI+BHI5H3WNYW5Pq+1VjN4VMs=
X-Google-Smtp-Source: ABdhPJzCLWcKhuVqqStrn5MoWzJmSbs/Tiq9jNGrxJfaTkaI+HLRXuZy4dWtWipoSbXagESlxT/Stg==
X-Received: by 2002:a2e:990b:: with SMTP id v11mr6659909lji.53.1618953989985;
        Tue, 20 Apr 2021 14:26:29 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-103.dynamic.spd-mgts.ru. [109.252.193.103])
        by smtp.googlemail.com with ESMTPSA id p18sm3863ljo.75.2021.04.20.14.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 14:26:29 -0700 (PDT)
Subject: Re: BUG: iio: mpu3050: Wrong temperature scale
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Nathan Royer <nroyer@invensense.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
References: <483ac17b-705a-38c3-54ee-7f0089262c03@gmail.com>
 <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <f2b7938f-12ea-529b-da5e-83c9c8074e1a@gmail.com>
Date:   Wed, 21 Apr 2021 00:26:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CACRpkdbEue3OLpU0L_SDAsxpLTY7aqRP5sOZ90pF=o-Yb0ot4Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

19.04.2021 13:07, Linus Walleij пишет:
> On Mon, Apr 19, 2021 at 8:06 AM Dmitry Osipenko <digetx@gmail.com> wrote:
> 
>> The driver uses
>> (x+23000)/280 formula for the conversion of raw temperature value, which
>> gives 82C for x=0, thus apparently formula is wrong because x=50000
>> should give us ~25C.
>>
>> I tried to search for the datasheet with the formula, but couldn't find it.
> 
> There is no public datasheet. I have never seen a non-public datasheet
> either.
> 
> As the initial submission of the driver says:
> 
> "This driver is based on information from the rough input driver
>  in drivers/input/misc/mpu3050.c and the scratch misc driver
>  posted by Nathan Royer in 2011. Some years have passed but this
>  is finally a fully-fledged driver for this gyroscope. It was
>  developed and tested on the Qualcomm APQ8060 Dragonboard."
> 
> Nathans submission:
> https://lore.kernel.org/lkml/1309486707-1658-1-git-send-email-nroyer@invensense.com/
> (you find the threads at the bottom)
> 
> This submission came from inside Invensense so it is the closest
> authoritative source we have.
> 
>> Linus, will you be able to check whether the formula used by the driver
>> is correct? Thanks in advance.
> 
> Sadly the code is the documentation when it comes to Invensense stuff,
> I am CC:ing Nathans Invensense address in the vain hope he is still
> working there and could help, also CC to Jean-Baptiste who was
> there last year and maybe can help out.
> 
> I don't anymore remember exactly how I found this equation,
> but it wasn't from any datasheet. I vaguely remember browsing
> through some Android userspace sensor code.
> 
> What I tend to do is dig around in old mobile
> phone Android trees, and there you sometimes find this information
> in different GPL code drops. I bet I got it from browsing some of
> those.
> 
> Here is an example (Tegra):
> https://android.googlesource.com/kernel/tegra/+/dba2740d025c8e7e7e3c61d84a4f964d2c1c0ac9/drivers/misc/inv_mpu
> 
> Worst case what one *can* do is to calibrate the scale, like put
> the device in a controlled environment of some two reasonably
> far apart temperatures and measure, assuming it is at least
> linear. Some professionals use controlled environment
> chambers for this. But I hope there is a better way.

Linus, thank you very much for the answer! I found a non-kernel example
which uses a similar equation [1], but in a different form. The main
difference is that the Arduino code interprets a raw temperature value
as a signed integer, while upstream assumes it's unsigned.

[1]
https://github.com/blaisejarrett/Arduino-Lib.MPU3050/blob/master/MPU3050lib.cpp#L111


Still, even if assume that the raw temperature is a signed s16 value, it
gives us ~35C in a result, which should be off by ~10C.

Certainly a manual calibration is an option, but we will try to wait for
the answer from Nathans and Jean-Baptiste before going that route.
