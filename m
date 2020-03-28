Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F66A196579
	for <lists+linux-iio@lfdr.de>; Sat, 28 Mar 2020 12:04:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgC1LDj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 28 Mar 2020 07:03:39 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35915 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbgC1LDj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 28 Mar 2020 07:03:39 -0400
Received: by mail-pj1-f65.google.com with SMTP id nu11so4905671pjb.1;
        Sat, 28 Mar 2020 04:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/2cYRHxrVTMN93XPhLaHucAiNCsPMIFVMOC8DyU7FT0=;
        b=bd7U7zB7Lkd8f4SzL1To6hUBcjX34t0QuZPNnYhf56HYdc0lGJkLM+fCtEhnwRb8OL
         GZGW6Zqf21OK1AMKPT9GCSYbQLcZt82Mt05HIPwuiOIX5e2W3be2g8Xb6HVunmzonAoO
         XRgyz/+PypftLC+5ncPl98dHx7iZI9P8LutD4UYvSIlAEfWyM5plDQNCf2uoqCxxHu1C
         03PBoSjna7rs7LG/N17u5l98R+ZesnGylQM9EdE/eVCIgQ9DzQYD1GGh0aotzktj7o2j
         FddImm9fxUJE5TrbSp3Zw470oOZgVg9HULXLmZ+kNByotFICKe3rnGizsuxORO1oWGZF
         T1Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/2cYRHxrVTMN93XPhLaHucAiNCsPMIFVMOC8DyU7FT0=;
        b=YGw2BZUtm2CZx1HYOrP0x3mNb0TEBIRHN71XzL+Gq7I7uY8l6Aeq7tqvujyiF/6mVt
         YLGcS2KdqADlKikpz4GGYvzHbnWj1VDiRs4016Y4jup2ZYuj998OroogYJpedBTpERED
         xmquUyWwzizxRugswIQDD0Ve7XNycA32Py4C/MNGjND104cqvKsYXRaVwmXe490JVX0W
         jYjf9+3RgUiK89Tda17avZseGKuUYN+p4AEN8NxoUO0pEz6e3Jm7Ao52QZpAhYkxo1MR
         hvE91B6v6nLQbP4pJf24BkdFd4/P5nIJbIe4P4VE6k67C+ireY4QNgmNs0lwh1E5m6XX
         dkcw==
X-Gm-Message-State: ANhLgQ072FH7mgooaR/tV0mdv1HnBfWPmIApyI/uHWYt22CFxGFXVL63
        +CrCJfaRzIUDgpcDgoViwxSnICrll1PSGhDfjYA=
X-Google-Smtp-Source: ADFU+vtqrUvwa+xJ7s/nPsOqfyNXGInz7edr1LHUXfuJWdpCmq/QCDSEXbngGm7/fdrbTiSSe2kWfP4oFqHfKp6V4+s=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr4313231pjb.143.1585393417957;
 Sat, 28 Mar 2020 04:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200328001154.17313-1-sravanhome@gmail.com> <20200328001154.17313-5-sravanhome@gmail.com>
 <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
In-Reply-To: <CAHp75VefP3oPyRJ=Z9Y5Wv3rSc-nJdKFLJ60YLdUbP5dFikS+w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 28 Mar 2020 13:03:26 +0200
Message-ID: <CAHp75VfQXdBaEHSOcj474Mj1NieU4h=2y7JrgVpKMsQq_NeMbA@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] power: supply: Add support for mps mp2629 battery charger
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Sebastian Reichel <sre@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Mar 28, 2020 at 1:02 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Mar 28, 2020 at 2:12 AM Saravanan Sekar <sravanhome@gmail.com> wrote:

> > +#include <linux/of_device.h>

Forget to tell, I haven't found evidence of the above being used.

> Missed header bits.h.

-- 
With Best Regards,
Andy Shevchenko
