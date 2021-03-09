Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D067A332384
	for <lists+linux-iio@lfdr.de>; Tue,  9 Mar 2021 12:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhCILB0 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 9 Mar 2021 06:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhCILBU (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2021 06:01:20 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27BEC06174A;
        Tue,  9 Mar 2021 03:01:19 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id kx1so701398pjb.3;
        Tue, 09 Mar 2021 03:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q1cLJCT+U4+pmf7tfi6eJGOEwZrcQQZX5hIWWq7++uA=;
        b=k+HJmElhMJV/XRqoJY3jQqvnlUoBmTyEUqJXNhPKkIyPNJaApNjG6B+mj9ass5IxVC
         bISVrvzPm5uJx6aLaGE2XYfOf6d6t4d7w1pYZ4SqqMKrdWWLFd2YPo0MoLfBkcvl04fn
         hQbZsfjJ6rQqnmXnnRiNfdxuAiX1293/3C6usLZmtwYfdg6lNIJ6TwSeeGj0ygWGtdXe
         E4Z6YcXRRt8WHXk3slPIUeAh/EdAnW9b/jSbH7J6z8JYYgGUCU2mMrBGQ9Fg1Sq28Kr2
         0jTsM6iOVwDRboR6MjCecPl8RFxZoxWajTASnrkd8wNRGpAl5nH3NB54nBIgi0BEUQak
         y3og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q1cLJCT+U4+pmf7tfi6eJGOEwZrcQQZX5hIWWq7++uA=;
        b=BVFUiQcUy9DCfI3tH34xg4dVR+YH14zRdvPuzk3xVtjrmtVojJdOXrf2AozMagjofS
         sVR2UV9Ox9pSnh7v557/VaEAF6IRtyUAFvVwQqicslzaI4xsdPvPU+AbzIjPUrJi6dmc
         BEg811z/rhgy++I/xAW3hKqfiGiY/A8WMyCDiDDd0gYlX38UxckdaGiFGry2UjwLZoYP
         N08jsxHwIzSrNjz3ecKyPNHAm9KPIEoRGnxnJLctIGUcBwiptRRv5+MMxqzgWSoW23Sd
         ElV2WRnE1xcKECaHoYP6pB0tcJL2goUTgmIqpb/DUAzmUD1R+zzc8LPtx/lJYUhAkb8N
         F5kw==
X-Gm-Message-State: AOAM530M5XRoZLlPI/79KsvSyG3FW6Py9f85049LbiWVQ+HWrS5zXOpK
        bOd/QBTNBXt/w4F03VyJcOTnWiPUu+J5SqN7nvw=
X-Google-Smtp-Source: ABdhPJwqWZ5xIN184n8KYzSep418TYpT83oYXGRwwuQerm4R1zEoo6fDbtEPXFlVtaKa0OH38qRUjuZwJgW3HJ+n0+o=
X-Received: by 2002:a17:90a:e454:: with SMTP id jp20mr742370pjb.129.1615287679414;
 Tue, 09 Mar 2021 03:01:19 -0800 (PST)
MIME-Version: 1.0
References: <20210305070536.2880-1-Qing-wu.Li@leica-geosystems.com.cn>
 <20210305070536.2880-2-Qing-wu.Li@leica-geosystems.com.cn> <20210306164217.2d8166da@archlinux>
In-Reply-To: <20210306164217.2d8166da@archlinux>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 9 Mar 2021 13:01:03 +0200
Message-ID: <CAHp75VdBRtpkA5zmpEZ+gdP=RwYaoTsyDBqvvO2w67T6-6kqMw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio:magnetometer: Support for ST magnetic sensors
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Denis Ciocca <denis.ciocca@st.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        grygorii.tertychnyi@leica-geosystems.com,
        andrey.zhizhikin@leica-geosystems.com,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 6, 2021 at 6:44 PM Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri,  5 Mar 2021 07:05:36 +0000
> LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> > Add support for STMicroelectronics digital magnetic sensors,
> > LSM303AH,LSM303AGR,LIS2MDL,ISM303DAC,IIS2MDC.
> >
> > The patch tested with IIS2MDC instrument.
> >
> > Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
>
> Hi,
>
> Given that at least two parts in here is supported by the existing
> driver in
> iio/magnetometers/st_magn_*.c (lsm303agr) can you confirm that it
> doesn't make sense to simply extend that driver to support the
> other parts?  This is particularly true when the WHO AM I register
> reads 0x40 for all these parts.
>
> I've done a fairly superficial review whilst here, but please check
> you can't just add the relevant entries to the existing driver.

I even hadn't looked into the code because this one needs a very good
justification why it's a new driver rather than extension of the
existing one.

-- 
With Best Regards,
Andy Shevchenko
