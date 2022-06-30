Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5C77561322
	for <lists+linux-iio@lfdr.de>; Thu, 30 Jun 2022 09:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiF3HSm (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 30 Jun 2022 03:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiF3HSl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Jun 2022 03:18:41 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCD237A00
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 00:18:40 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id v38so21492272ybi.3
        for <linux-iio@vger.kernel.org>; Thu, 30 Jun 2022 00:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3Uqb3rQRkIqkcFaLhaKM4MIIledr9NhwtVmLGdZI22M=;
        b=StHnKdwlQRY0O0cuisJ5zNzOen9uMlnHIwVMgtmLTEt6tg6rwOi5oOxPUzWq8qLyFh
         yD3xEAPii1zLjibhvVIDuOGqtnbTpIce/rqcmclV+FNvTdmK4o1iluRQRnwA6FmtkVqT
         2vCQRS5IamzW41V5/fLOdD0ZwYvQx+SzNHTyvWnvciR/GNpuDH0cwoCF3flvO2CH/Xiy
         0UrasoB7eYKT4sBdST7mF2eS7Qr45WkyC3MS93qOFVV0NwUBtEUWbb2RoR7NyImb9iAt
         lzoDrXab7ficUghqblfubS79YrDGgqDk9EElQJXP7yNfr33iH3/WwOrZJdpqmBGrR29k
         u6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3Uqb3rQRkIqkcFaLhaKM4MIIledr9NhwtVmLGdZI22M=;
        b=sa3BJAvqAR4FJ4S/N182USWHhKxr3Vh8UhiTAEqrn9xRvGLNTObmdLbTrXUlr5jz+e
         lM7hFhvg3nys4IyqSh3O85CVzTpFncsF3/DwpENsn+Fa0MojfsirB9Xk0TlqiTVq27LZ
         7BXNa7cRu2iCz0YDa0sqKoDUPajPro/tIYvkF6uVv5nwJXEK2SdKQzddDNpwIBa/19tt
         A7CfF0UkBvKF/LOlfrsTKG4tAxPcLhypk7vyOT0kMNeRrbCC/400Tbv8wxb7aGpkoIRC
         c5q4h6ZKRfeeeFuNqdJzACDtKgJdF/kDPXYCffq1BJTMy51Xmd4R+np+yeL8wFStgsSx
         ax7A==
X-Gm-Message-State: AJIora8bSigESuMAfVjIZgEZPFV2DxKKofUcP7udy4jbpmzGNCfK828U
        ilfuBDH15tfc/fr8e1EViiJ6l1l152gVdImUhxc=
X-Google-Smtp-Source: AGRyM1vfAJMZhuh66Jk7OjV4QORk/TaB4oTWbqOX6jHP7JndWDfHHUHxEKdIy9XGHKSO/sc2A1Dw3X48AZmyOlD2YIc=
X-Received: by 2002:a05:6902:1549:b0:66d:5f76:27ba with SMTP id
 r9-20020a056902154900b0066d5f7627bamr7572093ybu.385.1656573519810; Thu, 30
 Jun 2022 00:18:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220630063528.205327-1-ukleinek@debian.org>
In-Reply-To: <20220630063528.205327-1-ukleinek@debian.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:17:58 +0200
Message-ID: <CAHp75VfCwQLApiQQq6FdjoXxdyArBW9e+kkXYsRDwxXT0c17dQ@mail.gmail.com>
Subject: Re: [PATCH] iio: humidity: dht11: Improve error reporting in .probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <ukleinek@debian.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Yves-Alexis Perez <corsac@debian.org>
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

On Thu, Jun 30, 2022 at 8:58 AM Uwe Kleine-K=C3=B6nig <ukleinek@debian.org>=
 wrote:
>
> Don't emit a message for -ENOMEM, the kernel is already loud enough in
> this case. Add a message if getting the GPIO or registering the iio
> device fails and use dev_err_probe for improved behaviour on
> -EPROBE_DEFER.

Why do we need additional messages?

They should be split in a separate patch, perhaps, with the explanation.

Actually the rest I would split to two: converting to dev_err_probe()
in the case where it's not right now, and dropping ENOMEM message.

--=20
With Best Regards,
Andy Shevchenko
