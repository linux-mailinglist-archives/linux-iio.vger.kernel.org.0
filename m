Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 337E939563
	for <lists+linux-iio@lfdr.de>; Fri,  7 Jun 2019 21:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbfFGTRc (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 7 Jun 2019 15:17:32 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:38587 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728752AbfFGTRc (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 7 Jun 2019 15:17:32 -0400
Received: by mail-oi1-f196.google.com with SMTP id v186so2196550oie.5
        for <linux-iio@vger.kernel.org>; Fri, 07 Jun 2019 12:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RR8YjCzVHWvR+Z+DnFHK8wgbsDPxnDxORkBlVxtZcLo=;
        b=L55r+xyZMvXx/+ExPILtcdGIJfq9xGdm92pNVpUpdNIjfDFqyGMstFILFXXtdQIoKJ
         vjfu7ulABFIWHbSeHgREFOoDraVLkf1KHzWe+V0NqJnrxHC4UETrHyJ3noGUhhI0KfZ8
         LI9c8BRHBQJlFakWwvHvyLC/GGHGTEnR/dNBcMsz7IjYGXfdKM1u4de8P2P9F1JLWN8w
         zUeVdsk1iUJkJz7GljznG4q3iX7ywd8WLqnF7XTegoIIKr4wQNVS3Flb9TIs+mLH9jRS
         +u1cDW94DeW46PxSfJJxRkSW3JG6HgpvAxUsVfDdCSnRgI+ZClaMvy/3OgqMDzElr6Ns
         4sUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RR8YjCzVHWvR+Z+DnFHK8wgbsDPxnDxORkBlVxtZcLo=;
        b=Lx+dM5wJ8FzwqWuSEE+wHIEzkbSS4FZlYz0MLsYB61vgfNGc6UDc/GRJ2mLseyaE67
         7kCpFTlkqZwP4k8AjD0ww7uy/VkBiZQss/U7V4338QOqH17lOtCXvelb2jIs6HJnmr1S
         gLw5BZfMo4tmDN3N7MbSTGbP0KHbQMTmMY+Bxz6yEipgPa3bDpkvuGnvPlyOV5GJVZ/S
         XL6rJKmNC3JFZ24nTINVA1R+ekZZ0XCToeXYkKqyOOm+oJWduaXRyoYfmhhlT/YMyaBS
         WUILJ/fFCxLUz930SzJN4QGkx7eSKY0kgWeUgC3M9ol4xnrs4/WfrYNB4qIeODFjPw8r
         aUUA==
X-Gm-Message-State: APjAAAWgdQAQFfu/ZrUTdjfETnbZ4SZWCUVD3emztsgWio3fzGI3gnFd
        g0sEcjBro6f8GQL5HImICFFG2wCwiK3+6+PGkr0=
X-Google-Smtp-Source: APXvYqyWaE8f6t1E9wg/Uu+1U3Nq40hpymHcgi8OsO/CrYIUnIuOCAvSwqNoRxIL5GqmVqJNwDE3pTSH1Rn95TNQMTY=
X-Received: by 2002:aca:db88:: with SMTP id s130mr4841828oig.159.1559935051267;
 Fri, 07 Jun 2019 12:17:31 -0700 (PDT)
MIME-Version: 1.0
References: <1559768858-1175-1-git-send-email-hancock@sedsystems.ca>
 <379a99c8405b4cfbaa61ac49f9b40d4c577eb2a8.camel@analog.com>
 <95be35ff-2e3d-bc00-8798-7c9f462a96a6@sedsystems.ca> <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
In-Reply-To: <a96943b7-00f5-288f-fa27-a82f1d6aa8dd@xilinx.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 7 Jun 2019 22:17:19 +0300
Message-ID: <CA+U=DsrBqfmqfxS_SaPJHHiet0ZuAsCK5Kdha_rH+Cbm4VRP4A@mail.gmail.com>
Subject: Re: [PATCH] iio: adc: xilinx: support all ARM platforms
To:     Michal Simek <michal.simek@xilinx.com>
Cc:     Robert Hancock <hancock@sedsystems.ca>,
        "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, Jun 7, 2019 at 10:33 AM Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 06. 06. 19 17:21, Robert Hancock wrote:
> > On 2019-06-06 4:09 a.m., Ardelean, Alexandru wrote:
> >> On Wed, 2019-06-05 at 15:07 -0600, Robert Hancock wrote:
> >>> [External]
> >>>
> >>>
> >>> Since the XADC logic can be used with standalone Xilinx FPGAs, this driver
> >>> can potentially be used with various ARM platforms, not just Zynq.
> >>> Change the Zynq dependency to ARM in the list of supported platforms
> >>> in the Kconfig dependencies for this driver.
> >>
> >> To my knowledge, there are 3 FPGA platforms with ARM supported in Linux.
> >> And symbols are ARCH_ZYNQ, ARCH_ZYNQMP & ARCH_SOCFPGA.
> >> For these ARM + FPGA SoCs, it is usually preferred to list the supported/tested ARM + FPGA platforms in Kconfig.
> >>
> >> I am curious: are you using something that isn't in the above list?
> >
> > Yes, we are using the XADC on a Kintex-7 FPGA through a PCIe to AXI
> > bridge using an iMX6D platform - not an integrated ARM+FPGA.
> >

In that case, it would be a bit more interesting to do a depends on
PCIE_XILINX, or whichever is the Kconfig symbol for the PCIe-to-AXI
bridge.

And there are some benefits to that, the major being that you can also
support other ARCHs as well (x86, ppc, mips, etc).

Naturally, if using a different PCIe-to-AXI bridge controller (other
than Xilinx's), it would be an idea to use that Kconfig symbol.

> > Using such an approach this driver could potentially be used on just
> > about any platform, but I didn't want to open it up too much for now in
> > case of some compile issues.
>
> 0day system should answer this for you.
>
> M
