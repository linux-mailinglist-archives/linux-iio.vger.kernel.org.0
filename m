Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C63F4E3C45
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbiCVKQJ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 06:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbiCVKQJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 06:16:09 -0400
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F5A31DC6
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:14:41 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id m184so6043023vsm.12
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 03:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=qQJC07rCUNswiB5jjOD2VCw5tjxjTwuScyhxRRQmtMM=;
        b=ZIvyg/LlRN1eAIM73sNBr+wlkLHyty1qRSbo+arkA33Gs6AwEgno6KW6QHWcePC7yu
         FUUyBpzHmWmklsuhDuoCtLNNc3Jmu2u1GT+di0ynn179viSyaJbFVfrL2ebIYj48gU0N
         BWyJpelI2EOspXb58mziAdc+nCCw4ictcZLY/AgTLOilebC9ttIOIeRr2HxWDxA99ovT
         ktvmcFvdeNVJrVNpNnCjZxEPRGtLv23pWtSPD31DoV8e4RzQ8YDS0knmGRoDq90PuWC6
         cN+UBz50Bb1GfO2jKJNViByeNWHzlG2IyxhBRWVmQRJiZv9RLTXAw8ByQOhRfUWBCLBI
         RWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=qQJC07rCUNswiB5jjOD2VCw5tjxjTwuScyhxRRQmtMM=;
        b=Enjec2TvOryNag6Gfm9YcdgouQnQYL5qCAWlG1CxqguceSfuRGvT8WzNmZKusQbvp5
         eWrl9nFIh9zxfkPY7R4b7NACsEnOSGp6fSHdQAWPS4mMSMg6bL1QalFvLjRLT3eWQUbo
         mkBvkD+rGtscrQIgUacE5gTfCn+h8Pstjllb9/UFQQ5Pav+KdUmkpWBNauxvOV8g+DPo
         +dq/JsEg6mm7o1tDWm8H7fNFnpO0ouYihIuYzQsPBnEwxcUfLW+emZwmeV4HVFxwB9Ln
         yKTkD8EszuWeg6YNLCrrRT0Q5knYXlPIkMpAIi8Kk2asXrErfh2kTZvqYQbxJr6Z+os1
         p3qw==
X-Gm-Message-State: AOAM532V1jOz+KZhwt04rkZZtoEp9YNVQi961/SAYES9FvHA1GNG8FLQ
        fHVRt8bC85jEsSnRqs12qREzbg56euTNRzc0SI4=
X-Google-Smtp-Source: ABdhPJwDK3IkOxPRtHHX/6/xllV2nKZ5HZBE30HpEvOS2uoxAeNPv+06vFGQZBZ4ybMCqHX89Kmvs/11qFIdh6US+zo=
X-Received: by 2002:a67:b40d:0:b0:325:2d3a:dabb with SMTP id
 x13-20020a67b40d000000b003252d3adabbmr1990441vsl.59.1647944080680; Tue, 22
 Mar 2022 03:14:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220217162710.33615-1-andrea.merello@gmail.com>
 <20220217162710.33615-8-andrea.merello@gmail.com> <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
In-Reply-To: <ba1b2d78-bf4a-ec6d-88b8-76bbf2ff5e3e@pmeerw.net>
Reply-To: andrea.merello@gmail.com
From:   Andrea Merello <andrea.merello@gmail.com>
Date:   Tue, 22 Mar 2022 11:14:29 +0100
Message-ID: <CAN8YU5PARcdR6gb4iLPS7XxVQaYkPvgRgwDo=caP+pXa7Ht3FA@mail.gmail.com>
Subject: Re: [v3 07/13] iio: imu: add Bosch Sensortec BNO055 core driver
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andrea Merello <andrea.merello@iit.it>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Il giorno gio 17 feb 2022 alle ore 22:58 Peter Meerwald-Stadler
<pmeerw@pmeerw.net> ha scritto:
>
> On Thu, 17 Feb 2022, Andrea Merello wrote:
>
> nice work, minor comments below

Thanks.
Just an inline comment; OK for all the rest.

[...]

> > +static bool bno055_regmap_writeable(struct device *dev, unsigned int reg)
> > +{
> > +     /*
> > +      * Unreadable registers are indeed reserved; there are no WO regs
> > +      * (except for a single bit in SYS_TRIGGER register)
> > +      */
> > +     if (!bno055_regmap_readable(dev, reg))
> > +             return false;
> > +
> > +     /* data and status registers */
> > +     if (reg >= BNO055_ACC_DATA_X_LSB_REG && reg <= BNO055_SYS_ERR_REG)
> > +             return false;
> > +
> > +     /* IDs areas */
>
> probably 'ID area'?
>

I'd say 'ID areas' then, because there are two zones in which
different IDs lay (one below the PAGESEL register that contains e.g.
SW ID, internal gyro ID, accell ID, and the other that contains the
chip UID)

> > +     if (reg < BNO055_PAGESEL_REG ||
> > +         (reg <= BNO055_UID_HIGHER_REG && reg >= BNO055_UID_LOWER_REG))
> > +             return false;
> > +
> > +     return true;
> > +}
> > +
