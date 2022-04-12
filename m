Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096374FDBAF
	for <lists+linux-iio@lfdr.de>; Tue, 12 Apr 2022 12:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352226AbiDLKGW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 12 Apr 2022 06:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352337AbiDLJmg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 12 Apr 2022 05:42:36 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7AFE13F65
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 01:53:02 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 21so8314012edv.1
        for <linux-iio@vger.kernel.org>; Tue, 12 Apr 2022 01:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RQ9YRDAcfPp/+wqHxZqBzWjEaRO9eZ5iYPpukZ+npmc=;
        b=E41zOgOGTGTpdm2ptm/hVX4o8YUIRD5Cwmxc0VU6iR43j6VNbbg6t1gBoYIWf63prU
         Lieg4IwSIkoSMQR9qHrzSs+s7zebGQgrzZjdKxBy4gVygY4Y7Q3FUiEfpoVxXLtHIg+D
         TkDGiRaRHyMhXdYyOQCgvXwy8KYA/h9xa/lxoaWtBgqwBkNv3+MMAx/lC4Ch67nsPTMK
         lhmgddryJpY/TjyGMqrhZ60WoX5cbhbCik1oXnDHXryc2zUYNPjzO0n2xfkUjNtjaaf0
         D21plp02g9YwILUYikALaimVPECL2dAz3ydZ/om6tGTNYMFtM04iBqNuB7bzqabqhf/j
         jgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RQ9YRDAcfPp/+wqHxZqBzWjEaRO9eZ5iYPpukZ+npmc=;
        b=hZRF+a5QEIgtKl68OnbpL4K5pIckWPmYLwYVJ3knVDV8LdbATghdIP56CMSQ3ftM8r
         UopMYk4EGyPXftfcvjdLiMPuhdMHLQeGB1CJMN/cDicYulFXrpxMGFBNGvRyMKlOdujK
         MEK8EOyqSUz/9cu143zCo3zKcCvRdDCBzxd83UmPWDgkE3tsbLrxbJElHXNm5DBa1CdE
         TfSe0MDTncdV81uxnLCAqej293s0GXXxefKke4YA6uA0a6LSgh2C0evsSsHG1cMm2AuX
         4INXjDrjckPusWppWdvu9X8u6FK4qA/qZCJXaSvKppZOJQdDXSEVHsutbNwNNyo1fR0L
         pjaw==
X-Gm-Message-State: AOAM533w68xKxTfAEYUQbrTXE+hvOoPqh9/8UHd0v5wrLnghcm0uJbNj
        Opuq0fFWgZySpFjOrMtBYXp4YVVCJDcMeRQHNPmcWnWeyTc=
X-Google-Smtp-Source: ABdhPJxuA5wr10Z2VFOEZi8NYNxg31F9zUKduNF+hHrLMBbnCtp0Tjpegd1avlp/haSo9s3druRohPZDpxrSAhvAa1Y=
X-Received: by 2002:a05:6402:54:b0:419:9b58:e305 with SMTP id
 f20-20020a056402005400b004199b58e305mr37241334edu.158.1649753581523; Tue, 12
 Apr 2022 01:53:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAH7FV3=UJn98PRp1dke7iAH2j8pj4-VSbnb11OfzRUKmkAEL8Q@mail.gmail.com>
 <20220410182819.23967855@jic23-huawei> <YlNcQEAZVGYBkdy5@fedora>
 <20220411095219.000058a8@Huawei.com> <YlQpcZvwZuabMsz+@fedora>
In-Reply-To: <YlQpcZvwZuabMsz+@fedora>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 12 Apr 2022 11:48:48 +0300
Message-ID: <CAHp75VeWHgn_c9n4-t2Ofi5S7U+K2o_Sa9hNc6PvXUfR_ENtCg@mail.gmail.com>
Subject: Re: GSoC Proposal 2022
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Bogdan, Dragos" <dragos.bogdan@analog.com>,
        "Hegbeli, Ciprian" <ciprian.hegbeli@analog.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Puranjay Mohan <puranjay12@gmail.com>
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

On Tue, Apr 12, 2022 at 10:43 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrot=
e:
> On 04/11, Jonathan Cameron wrote:

...

> I took another look at the Analog Devices Inc. catalog and choose another
> couple of options:
>
>     - ADPD188BI and ADPD410x: are optical devices based on SPI/I2C. I gue=
ss they
>     might be too bold for a GSoC project.
>     - MAX31875: is a Temperature Sensor based on I2C. Different than the =
optical
>     devices, this one might be too simple.

>     - LTC2499: is a multiplexed ADC sensor. For now, it is my best option=
.

Have you checked if it has similarities to 2496 and 2497 variants? We
already have drivers for those, it makes sense to double check.

> If possible, I would like to get your input on those options.

P.S. Please try to remove unrelated text in your email replies.

--=20
With Best Regards,
Andy Shevchenko
