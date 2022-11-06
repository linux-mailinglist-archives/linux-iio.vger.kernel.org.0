Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4132C61E38E
	for <lists+linux-iio@lfdr.de>; Sun,  6 Nov 2022 17:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiKFQza (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 6 Nov 2022 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiKFQz3 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 Nov 2022 11:55:29 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F665D2E0
        for <linux-iio@vger.kernel.org>; Sun,  6 Nov 2022 08:55:28 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id z189so8603742vsb.4
        for <linux-iio@vger.kernel.org>; Sun, 06 Nov 2022 08:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=timesys-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=orSVHiG9552fm9XZdQth16f0UY66UX6B9oQmxb64YNw=;
        b=LMjDQYT5EvEFPdTH+3KDTwpTS/9aSuxBAW5I/OjSLTPtaI2w1y+pFq4hktRbTm1eMb
         5fg5XZxE933SiUu/DSO6XYLhKgixUzodEL4ADlpkmP9+9Tk28s29YtJPgtCWPbE6epBL
         F3IfEl2b+8ykpORrg2P1mWYBQdH4/axkLKJysj+6a3ItcVB+ccxzZhcpHnMOjBjwX1Bb
         G2PbiYCAkbsXX55Ayk/LDDQbti/U39LywwOq+c/8yWDgYIvncE+U98bPxCZcDEonQTDD
         0fKy/fHmdg5wxSkuC0v+AOfl+TdQE+YMFzBfSRz/E3k7vr9kelSrvgfkCRZMZFZdgCLu
         pp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=orSVHiG9552fm9XZdQth16f0UY66UX6B9oQmxb64YNw=;
        b=mzP2ZMBUH5tX20lMiDpMN8DmfVE8VLKOfDBO6XF8GHFuJwQ88LenRWf6dDPB3SNuJm
         yc8RB9QsYWZm9WxF7F2xoBhVrQGkoCalTb/Uff8lPgMUhry+zA1SSDgb0oiBkjub2IjN
         88zQrnmvbzkKLA1NdBiGQHEl74RdGlOrqDW59fyNwOwB4zSuKodJTFfZsWSJ0IhLIsAZ
         sSWKiOGhhFxrBMU9vcuQd6hCJQXOLHGBEICBdRmh2S+lyukuUDfX+W+9skh2XlZJeAln
         fafN8CEspBDNsGD/RS5F3NECklpXy3G+H59Li1ma2l4hSWzzhjqcTZ97hrDTaelrovYE
         UxXA==
X-Gm-Message-State: ACrzQf2JA0RJcb39SC3vsTvD6TfhQ5Vbcx+x+3J4CzU5euvp87aMfGUA
        S5c35HxM7Wp5b1NXxlzjtMfWZQzt/ElqEoXSqxhlhxdmnKrw2F+a
X-Google-Smtp-Source: AMsMyM50yPw+CAKSj1JH7HE37GRVXT+iUYqAhM36+dHZViRjj5rCuwIkZde0+RIN+yAG7TXL/eZpozicKHRq0b1LvUU=
X-Received: by 2002:a67:f10f:0:b0:3aa:2452:34bc with SMTP id
 n15-20020a67f10f000000b003aa245234bcmr23239480vsk.54.1667753727302; Sun, 06
 Nov 2022 08:55:27 -0800 (PST)
MIME-Version: 1.0
References: <20221030230813.460021-1-angelo.dureghello@timesys.com> <20221106123435.29770882@jic23-huawei>
In-Reply-To: <20221106123435.29770882@jic23-huawei>
From:   Angelo Dureghello <angelo.dureghello@timesys.com>
Date:   Sun, 6 Nov 2022 17:53:28 +0100
Message-ID: <CALJHbkDaAGN1yT+y+a5B8ZvCUSK-xrj3A5rwf4byDbw08bBZyQ@mail.gmail.com>
Subject: Re: [PATCH v2] iio: dac: add support for max5522
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     william.gray@linaro.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan,

On Sun, Nov 6, 2022 at 1:34 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 31 Oct 2022 00:08:13 +0100
> Angelo Dureghello <angelo.dureghello@timesys.com> wrote:
>
> > Add initial support for DAC max5522.
> >
> > Tested writing DAC A and B with some values,
> > from 0 to 1023, measured output voltages, driver works properly.
>
> Hi.
>
> A few minor follow up comments plus details I missed on first review.
> The dance with data from different firmware sources is something we are
> still tidying up across the subsystem - so there are lots of less than
> perfect examples!
>
> Coming together nicely.
>
> Jonathan
>
>

thanks a lot for the feedbacks, sending v3.

Regards,
angelo
