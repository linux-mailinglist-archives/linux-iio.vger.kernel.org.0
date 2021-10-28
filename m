Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC2743DEF2
	for <lists+linux-iio@lfdr.de>; Thu, 28 Oct 2021 12:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229850AbhJ1Kge (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 28 Oct 2021 06:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhJ1Kge (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 28 Oct 2021 06:36:34 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850ACC061745;
        Thu, 28 Oct 2021 03:34:07 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg18so5889659edb.11;
        Thu, 28 Oct 2021 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sM+K/3UTRADD/MTDsa0GbpR4m1FvgQwc3pG+Y4l51z4=;
        b=cfYygbQDylL/aJZg4qcPeRT7czTLg1oXl0LOhyJWADf9KAVTvn24w9THsIuPqVyEED
         gmJ8O9XMImdiJ10jvtQf2INC+uE7owBt9WCLDiXxcg7fPUfnt7m3tuVjTKkGGAa7bclE
         Q8DnKAxG7LsBB5o+AVtFlw9D1aq/YJLR/MVreE3O/HuEJ+8x1PHs0uSo1VuXreI9RLgu
         6l6lhzzmTBsSBNOfyTizOg8YBx2VJPO/XSO9svSgPfkM9HMBEYtNxKmacFcgjgjWBeZ+
         U2lW4w6LGdKNrNsVnEy8/ZxsblSt2Z86qPC3EJR1uN/OiHIAGVr2Zq2M3XIjeZjsW+Fd
         5UrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sM+K/3UTRADD/MTDsa0GbpR4m1FvgQwc3pG+Y4l51z4=;
        b=0gKtqSAQGrTyYLSAvNSaAXRSo0n3+8LzYi3dGir1wMl01x99da7VhgOGI/0zymnteC
         q1ZXyaZqJ2ekE2ws2KnyNVnfFvv9TvVpDE4E+/XJ7yT0pk126DrDvtuMYZfu1jFKVIUp
         G6HpOlZSdxcHpe2JJStaPud8Z41p8pp1q/XFKrCQFSd3Wm1qi7OMD+jlBqPxbee3z6Eh
         eAo3ELgHsbpiDh5547dzEw3KoqTtALStf9tnNTTEcfrfpcIALgyoF4FseOCcrlBu9Pkw
         /MQCcYJdbIQX3WEM+kA586IJxzMpZa0N7n+n43suRsNngxHXNRPMUJQ3faTf/GY+h0kJ
         zCYA==
X-Gm-Message-State: AOAM530t64ajygt+FonVirpZ/MaxTTE7wiUmdaDZQH5ph6lxXGuu8ABD
        KjZaEvEhuzfWXNYDxwdsDqai9YCSgb89cRWrBoE=
X-Google-Smtp-Source: ABdhPJwOYQj4Uj3fqWiPlg5E+pv61BN7C71XCGCKp4cwe7DIEgmDutVr9Ad3UNe6RBjFsV4arz8Dhrk3JnWVUYpdGzw=
X-Received: by 2002:aa7:c40c:: with SMTP id j12mr5012780edq.224.1635417246061;
 Thu, 28 Oct 2021 03:34:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210715141742.15072-1-andrea.merello@gmail.com>
 <20211028101840.24632-1-andrea.merello@gmail.com> <20211028113511.13803ecb@jic23-huawei>
In-Reply-To: <20211028113511.13803ecb@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 28 Oct 2021 13:33:13 +0300
Message-ID: <CAHp75VeiNQLU1Y-gSsD7qibMmF_74ZDFCPSr-6ySFi2NaAPV=A@mail.gmail.com>
Subject: Re: [v2 00/10] Add support for Bosch BNO055 IMU
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andrea Merello <andrea.merello@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Oct 28, 2021 at 1:30 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> Hi Andrea,
>
> I'd advise not sending new versions of a series with the in-reply-to set
> to an older version.  It's a good way to ensure anyone using an email client
> handling threads never sees them...  It also gets very messy if we happen
> to get replies to multiple versions overlapping.
>
> New version, new email thread.

+1 here, but since it will be a new version, let's leave it for a
while so reviewers may have a chance to comment on something.

-- 
With Best Regards,
Andy Shevchenko
