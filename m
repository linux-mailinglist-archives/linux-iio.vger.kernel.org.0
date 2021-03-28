Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B924534BDC2
	for <lists+linux-iio@lfdr.de>; Sun, 28 Mar 2021 19:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhC1RnL (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 28 Mar 2021 13:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhC1Rmq (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 28 Mar 2021 13:42:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB6CC061756
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 10:42:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id j25so8388136pfe.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Mar 2021 10:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=Ye+m/OIlmTMjg+aDM6OQcZLwWdpiWjCHWPLqdTZti6w=;
        b=m5dQPaPRfmY+Ky9LVhk0cPttFQYsJW9dAA3zBwHt/eN/SVS6czLlX2kX28Eq/b+GWu
         ZOhBsUJe7ze4wYSF6oF9KJtbbh0itZ/p3padHoLbruzvRUkd8vna5XomryO7+d800m5B
         jmyrLz6tlQYnHZuTZ5xdx7xAuw+uRJYOWR2eAXisnfxzrurYFfUFb5HbvWGlH3AE3Ev+
         /MMqZ340JR7SInhkyjHZpkcQ6M7T9yeOYgsrjfdAD3AQqwkeGtCUiZPeT9AweUe4X6P1
         ZMgKel2eDREn2ecor/F0t3tEowTVEl7na4m1BPSO9KIq93/EHkMGe3gZiUvI32sjZs/Y
         +oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ye+m/OIlmTMjg+aDM6OQcZLwWdpiWjCHWPLqdTZti6w=;
        b=TYLxUMqt/Mc6gHqAkaMnM+PvBAt7hC4fO53SBZIZzftK0s9eJ17hLPkd71Axdj+Yd0
         GyYvRP8GrG+leq8+zGrx6ZiQzTagiShl2GaDgHpN3nQcwuWyRrJkTY6Y66u2IrCxRITg
         1QxZMmr4KEBTi04LD5XBSMUdxcIM5Y8SbZQv9+h631tvE8RknWhbe0mKnbox/mWsEbND
         2Z9co3MDg4faKtMb/B+Ijv5WFoHo34xQjOxcFAM1sgVVlC11dPUee7wVQcm/pGQFNgTM
         nTsS3hFwKQ2bJmVfoHh8J/inFx/C/Pg0AL6gWgoXH6HIh8PspvffQtERlx6PEyYkDOL5
         ocoA==
X-Gm-Message-State: AOAM531XDVYhooQD6kQ1hPlO4OXPeDlCFtKhaHB+gevZJXkHB80gm6I1
        Ddz4aItoiDkb7ZHlqh4QVffKdpBykjPMbw==
X-Google-Smtp-Source: ABdhPJy+bIJ/cKxpPoNh3pcQwoyeNZ/05eda4Uf3+i//zjomyquRut+mKB6nYbOu8doTowP6ZD+geA==
X-Received: by 2002:a65:43c6:: with SMTP id n6mr20651877pgp.170.1616953365429;
        Sun, 28 Mar 2021 10:42:45 -0700 (PDT)
Received: from ?IPv6:2409:4072:21b:917d:6a69:e0c5:1507:d785? ([2409:4072:21b:917d:6a69:e0c5:1507:d785])
        by smtp.gmail.com with ESMTPSA id t12sm14239117pga.85.2021.03.28.10.42.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Mar 2021 10:42:44 -0700 (PDT)
Subject: Re: [RFC] GSoC'21 IIO project: Mugil
From:   Mugilraj D <dmugil2000@gmail.com>
To:     linux-iio <linux-iio@vger.kernel.org>, dragos.bogdan@analog.com
References: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
Message-ID: <6e95cf24-9b8b-dd8d-d9cd-c3302d0f7993@gmail.com>
Date:   Sun, 28 Mar 2021 23:12:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAOgtOjMw0UDhOgXU=HY=+kUhVU+Ya_N=Mvxj-cA_gvj-r9HwuQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 26/03/21 3:20 pm, Mugil Raj wrote:
> Hello All,
> 
> [Dragos here you have a quick intro about me if you want,
> https://lore.kernel.org/linux-iio/CAOgtOjMwnwsiXd8rPeGBBTVkZUeabQ5nLtPts2RQDDMc-TDgKA@mail.gmail.com/]
> 
> For GSoC'21 IIO project I would like to choose  AD4695/AD4696 device
> for implementing the driver.
> I referred Analog Device, Inc.'s page that lists all drivers and
> their kernel tree, but there is no existence of any compatible drivers
> for this component.
> 
> About AD4695:
> - 16-Channel, 16-bit 500 kSPS SAR ADC
> - "Recommended for New Designs" phase
> - SPI digital output
> - Datasheet in [1]
> - Product overview in [2]
> 
> Is there any other factor I should consider before choosing a component
> to make a driver for? Do I go ahead with AD4695  in my
> proposal? If yes, are there any recommendations/suggestions you'd like
> to provide for a beginner indulging in making a kernel driver for such a
> component?
> 

I would like to hear from Dragos but seems like he is busy/out of station. 
So, if possible can any other ADI peoples comment on this?

> Thanks,
> Mugil
> 
> [1] https://www.analog.com/media/en/technical-documentation/data-sheets/ad4695_4696.pdf
> [2] https://www.analog.com/en/products/ad4695.html#product-overview
> 
