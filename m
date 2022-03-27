Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F4D4E89C1
	for <lists+linux-iio@lfdr.de>; Sun, 27 Mar 2022 21:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiC0Tfq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 27 Mar 2022 15:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbiC0Tfp (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2022 15:35:45 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21EF11A0B
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:34:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id c10so6222607ejs.13
        for <linux-iio@vger.kernel.org>; Sun, 27 Mar 2022 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+9b9CQoULg7uxSMPYWt1ofcpWwFshThFSFKa0XMztjc=;
        b=nRjkW7SBAmyAgvM+XR5gxmb46D+V4uM1M5rZMyIYzExkgBGz/70HbHQKplFZ7AzcXG
         TqwZwVbhM+Zegp/7X696296JjnHhuhOW1BE6INkPw4uU6o6zfyj1szGN9u6nad4JW57n
         FMJV6vWxqqruzPzTUe0UPuZU8z89gc606VaUKwMJYmGqwK7FpaUgjWSArmcXAmGwyLwc
         lbd/2d0S4z6WR9n/YFIxmqT6GS0++nD6Npd4+IDLgkoBYWyqSvs2xLfrgfu3o3tYFdhj
         eK11JxEdpiHLk9e6M1XK0mu5butv1g53uuWs6nTw/M1ZLLsjy4Xfksd1LyXUE/IBjDtQ
         2i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+9b9CQoULg7uxSMPYWt1ofcpWwFshThFSFKa0XMztjc=;
        b=GPWO8pJTgQCoWDWXwszNxjHAlKOuBk3jLyIDRiA3ciuHrk3rEXfTkut4BC1ZW4TLAC
         qh25VuwxckV3dG2boUqAZa1BIiejNU0/qsEopO4hNyI8ENGDKCJfVzDSgz7mfe9SIdXA
         norVX9ZRUhGpHB6ozhyMbkN1QXMJb3WMZsCD3aLb/zGzTJeS6Z0CrojBG6NNvbYrFEYD
         NLKXyU4DHV2kMETP0tOJY3hPh11UOadnOf4w7mgZv3ct8PqfLJvUFmFWXUvd/hlrExtv
         gsbP6f2Qbis9QWG0atQGZ0XyQz0ed2mu6Xz+5FG9dDCNivtNrrPFs3aWtlDLhIxmKYI2
         hBHw==
X-Gm-Message-State: AOAM533F9/4zINPWKTZ+bhzW7ZgqyA494f+EPhWcnRsiYmOpRpByut4b
        zPN4OyWmI8EDm6AGH+chv4JcdoWrMKs+TTraDs4=
X-Google-Smtp-Source: ABdhPJyVCISyv1QFSMOtRNT1ltbmZancIpjVXTCKLivUOmH86S6Pp/KZfpFZjQL+Fp2KwMGjlC43rPud902C0LRG5y4=
X-Received: by 2002:a17:907:968e:b0:6db:aed5:43c8 with SMTP id
 hd14-20020a170907968e00b006dbaed543c8mr23441259ejc.636.1648409645358; Sun, 27
 Mar 2022 12:34:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220322220210.207454-1-marex@denx.de> <20220322220210.207454-10-marex@denx.de>
 <20220327161835.5c661300@jic23-huawei>
In-Reply-To: <20220327161835.5c661300@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 27 Mar 2022 22:33:29 +0300
Message-ID: <CAHp75Vc8gF_oQyszZbpKoomT45BSzs3u6k=z=wSSHNbCyJNOXg@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] iio: adc: ti-ads1015: Switch to read_avail
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
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

On Sun, Mar 27, 2022 at 6:11 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Tue, 22 Mar 2022 23:02:10 +0100
> Marek Vasut <marex@denx.de> wrote:

> Also, Andy might want to take another glance
> or give a tag given his previous interest in this series.

Thanks for letting me know. I have no strong remarks on the series,
the commas at the end of the line are good to have from my point of
view, but I understand Marek's argument that they are from hardware
and shouldn't be ever bigger. So, I consider this is kinda nit-pick
which I may live with (since I'm not a maintainer here). That being
said, if you feel stronger about this, ask for it :-)


-- 
With Best Regards,
Andy Shevchenko
