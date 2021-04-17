Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4937362FEC
	for <lists+linux-iio@lfdr.de>; Sat, 17 Apr 2021 15:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236312AbhDQMld (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 17 Apr 2021 08:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235901AbhDQMlc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 17 Apr 2021 08:41:32 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A1C061574;
        Sat, 17 Apr 2021 05:41:06 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n10so4210805plc.0;
        Sat, 17 Apr 2021 05:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibIdkXZgsWIeMzNWNtun5B8Bs1xvkosUdmWqeEywi3Y=;
        b=Jh6AN/Ps8MRSXOQVpwtSUTNASkXmkaTOfgyvRxJw99sBFTV1Yx67D0Yh6uulRcOSnB
         AqW7JRSwWV3rblNeyoGR80lz0NgxWIPKgKyGPxJEDnaRRtRzCpW9E0k1vEhZqBw1lMdN
         wsWqvjoqwCf/rc66l5H+VDv3ojjGMTUmdUYFYdSRkItpmqnxMOaeOKaFBwibHVUfaGXl
         LHMrH7m64x/BMAYPxwrTSXlqcII9nhPMUGYFgh4z7ipGdq/Drjf/x1FFjGYGEzJ2hkHU
         tCfoMcaOFQBA9SzVKG8s7bTRam15//ZfB24ARVtPh+6lSwM1J8RvE8MXTOmhv8cvZcH6
         mpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibIdkXZgsWIeMzNWNtun5B8Bs1xvkosUdmWqeEywi3Y=;
        b=TqxxJEEQc9kl4fdvF+p+iTrEVC9LVxDMyz1gvYrnkMn5BBd5obXZAnejsQ9+bkM41q
         y8Eny6E4L4EQae5w38Hzl+0wXdhcx8gQXP6+Pqgo1qnvLzmqO+Cfti4zuiilJYi1VF7z
         nHXQCGGo54533+wHZw5s7XBqeiNHPoJuJD/krBl4FRX8cy2urPKKdT3N4IlyWM9RUL1P
         hkEpsSxBL9v2r+HXcl52Cq0AjQmjewpUPTeUuzI17H41S/+wdCmLAaqPWLyRIGiS7XxT
         /SkKk1/zdvfi2QmNW1PLJInciYuEDF0whDofBC/GiZNtF3Tntf9scq8bFAxAaj0V4dB/
         mDBg==
X-Gm-Message-State: AOAM532l2kKQV6TfE6tA7R7bXpmP/XqxapcolUtQ0cXmLuWN3dRYhvzp
        Qgbq5w60M5d6Wp2n/asP3SLAQa6v90RdhKRMOD77kVtacz8=
X-Google-Smtp-Source: ABdhPJzVnbNe19wUJ3SlX6vHojkbozR8JThr+Wz2rVyzSVVd2IiFXA5VVfhSYO7XZ29L8GXpT9Pr2clj6VA8ZThOJsg=
X-Received: by 2002:a17:90b:1184:: with SMTP id gk4mr9228799pjb.129.1618663266011;
 Sat, 17 Apr 2021 05:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210416174902.9036-1-joe.g.sandom@gmail.com> <20210416174902.9036-2-joe.g.sandom@gmail.com>
In-Reply-To: <20210416174902.9036-2-joe.g.sandom@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 17 Apr 2021 15:40:49 +0300
Message-ID: <CAHp75VdNmuv_+1FvnENsp4yK8_v_pK+2Tp3=jLWM2BiFmyPWEQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] Added AMS tsl2591 device tree binding
To:     Joe Sandom <joe.g.sandom@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Apr 16, 2021 at 8:49 PM Joe Sandom <joe.g.sandom@gmail.com> wrote:
>
> Device tree binding for AMS/TAOS tsl2591 ambient light sensor.
>
> This driver supports configuration via device tree and sysfs.
> Supported channels for raw infrared light intensity,
> raw combined light intensity and illuminance in lux.
> The driver additionally supports iio events on lower and
> upper thresholds.
>
> This is a very-high sensitivity light-to-digital converter that
> transforms light intensity into a digital signal.

Subject should be something like dt-bindings: iio: ...


-- 
With Best Regards,
Andy Shevchenko
