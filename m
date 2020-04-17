Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CABE1ADEA9
	for <lists+linux-iio@lfdr.de>; Fri, 17 Apr 2020 15:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbgDQNpN (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 17 Apr 2020 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730597AbgDQNpM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 17 Apr 2020 09:45:12 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4C4AC061A0C;
        Fri, 17 Apr 2020 06:45:12 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t4so973825plq.12;
        Fri, 17 Apr 2020 06:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9kS0cSAgo1VPJStqOCcHdT5aRZVdhxXEJVNNXkxC32E=;
        b=aNT+4DDGzgqUGZdBxXq6BjG+qo3kEc2axfFiFWkHdAY/FVv/zbHydwt4eJLAozs/ZL
         WbpgGQ7sYYZoiPpCs3xSI8d3G0X/vdT3d3nbfTTQrUFUnbe2iGyLZcFGKm4of8KM3W9P
         EhSSI+1dXR86Jvx1WuAaAfc9kNLcPkV/YnvUB6triKKXLY0z2I2qNavpxcaYGuHFxpKz
         EC9y99pg5dHX3Xd/v6sNU5SM9jv8tzDfKu0mpPShW6JGsTGa/RyRAlbI9C5ZaUc5vIPd
         hhRRc7Ch6HG25LRoeCFVRutKLzIas9jYk+QjC8955M4kY4YlNFlTBiZkm1PoP/JFdH/P
         E41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9kS0cSAgo1VPJStqOCcHdT5aRZVdhxXEJVNNXkxC32E=;
        b=RkxhiHEbH/wz6OVZra7U1iu9K68xz8vXLjdcxHrqpnSbmmr5YFaUP+Qo8nJMwNkT7w
         WqW2mtUK6ml7X/Ypr1IX3ruowWZIHzwZ5bLzeuC0rr87eJGs1qr0ZokNmDrdrdKzzaol
         7op6cYUzFSGm6YntF71pj9VMMo5aEAin4kSscW9ApyjKD/iKUCSspoXWz3QVYgfeioUG
         n/W9za31PoPq/rF6iHB5mU8pUFYiwuIzdQSC1/xh9dCuoyEBOcc1Irc3CLbzg/4quIGD
         azwIDlvkjXS+tXnvjo/jJ5HryhloDYA+16mJc/sCUnX2/Q8M0Nyx/0v7xqLKceQ/kJnr
         GVXQ==
X-Gm-Message-State: AGi0PuYBtmwNGkk1jzzXhxvdNPqgMPdBaWnPwxSculiYttbxmWOz+Xnp
        Vtz8tAMfSjJYep+w6Fmn+7sdD+1XuPfaH0jemL0=
X-Google-Smtp-Source: APiQypIubgvKFgUljd5eUdgsJU9Cc9nrqckwz8ARK+bdaJtwxs/+ldNfW5QQhVXWxg6FYF9r7akNg0PT3AQgYTo4kOM=
X-Received: by 2002:a17:90a:364c:: with SMTP id s70mr4458977pjb.143.1587131112391;
 Fri, 17 Apr 2020 06:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200416205428.437503-1-alexandre.belloni@bootlin.com> <20200416205428.437503-2-alexandre.belloni@bootlin.com>
In-Reply-To: <20200416205428.437503-2-alexandre.belloni@bootlin.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 17 Apr 2020 16:45:05 +0300
Message-ID: <CAHp75VdQ58A39HYnW-7CYJgp4+adrzcoiQ4KmTq=0snVAokH9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads8344: properly byte swap value
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Apr 16, 2020 at 11:55 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The first received byte is the MSB, followed by the LSB so the value needs
> to be byte swapped.
>
> Also, the ADC actually has a delay of one clock on the SPI bus. Read three
> bytes to get the last bit.

> +       return adc->rx_buf[0] << 9 | adc->rx_buf[1] << 1 | adc->rx_buf[2] >> 7;

I just realize, isn't it an open coded variant of ror() / rol()?

-- 
With Best Regards,
Andy Shevchenko
