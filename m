Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728153A2C5A
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFJNE4 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:04:56 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.104]:32577 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFJNEz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:04:55 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623330174; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=hbV2ofuuX94G9csxqghXz2D4VAK8FhuDhK/p0/80JyR2nXKJPm/Ey30uc1rwmnIifJ
    upNsflM3eNwEpICnSekaMSk16svu6Y2VGDP0Vocs7IF83UuHSUOLfVVXKo3WERR77BUF
    3Gut/tvzqbZNB0cAPJ6T8sAzR5ypGYXIioOnedwuRSkwjNxW9eviPzBJNzc/iDCAfN3c
    Gjx34y/WQbG/u4iZtuhXatEkwUluvrvpUpTMI1k1EtCTu3ptJ7RWedewaUDoimX4SkFw
    aMvos9tVn6d5sxqSsAj7tNxW8e5dMvZEMIMsMOGqWJ6K3CEGFL17+auRvqfhyFJWfepE
    yYqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623330174;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=K3t8QJ/9F6hP7rSPOzWlJf4yAr8V8XezJiqIqb6/nec=;
    b=CB0nJ0jiK9955DlaqwRulDYj1l8kZNK14mFup2ngQQ/iMJuhTFFZ3D/gwAXtMGETQW
    n3PepuSxWNHAgiLKK1FilYO/Vp+UO7LgDoAMOj5xGDzOCEmu139HQoetFiN32qRnnDxb
    xOxJh8hz8FNRL8/+nhPYY/cl+JI/RWBjDPz4EfeQlqrNZUyXrK9xI+c1R0ulgT5oLSd7
    yAH7SHGBHd7PiH5foZGM7kW2KSdeB4/vlm82xXqYovq8IekESONGpUkijRKAhAA7NJtU
    Ajf6TupcRtkH7RSZaYPZ8tuVvQzIGej/XZB2SDA/ho3AxZRpZlmPO5N/VrK0BAfKyPAw
    kcXQ==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623330174;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=K3t8QJ/9F6hP7rSPOzWlJf4yAr8V8XezJiqIqb6/nec=;
    b=DqZg+nOl/hSrxNN02+WwWpI1hBYu9geYa8T9QiZrUEljFiVeSza/zJUw9ijJNvvj3W
    kRD4m3egUWfhx7tPqpDRlpHV0BwrEoSKHk9wK0xAbJ2nqBHJADu3CSaJrqgNnbzflKNY
    QEev4uK0BABuCTLQTpI6QmTp+553g2nWwf2xrDpDMANFu4nXr6FXvixpQdIklAHvNxUA
    LWfZpgOLA6Ex9KvSi1iOyrlRhaVLCGrCl+iO63naNRNrTfSYpyEsv980ID6snoXCqRbn
    sXSgMN9sdU1XW+u0y9Ra+K5p1r3izz+NY/3Dpp/eDUIQ40rYQPlqxmCCVeh+IPZ7q7JP
    FsVg==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5AD2ruK2
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 15:02:53 +0200 (CEST)
Date:   Thu, 10 Jun 2021 15:02:52 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 6/9] iio: accel: bmc150: Add device IDs for BMA253
Message-ID: <YMINfLkT0gxZKI2g@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
 <20210610122126.50504-7-stephan@gerhold.net>
 <CAHp75VdutqFuhTnZsi79ZgcVcL+o7M1k+cOFUKRB_vUUXiWJgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdutqFuhTnZsi79ZgcVcL+o7M1k+cOFUKRB_vUUXiWJgA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 03:51:46PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> > BMA253 is mostly like BMA255 and has exactly the same register layout
> > as used by the bmc150-accel driver as far I can tell. Making it work
> > is as simple as adding new device IDs for it since it has the same
> > chip_id = 0xFA (250) as BMA255 and others.
> 
> ...
> 
> > -               .name = "BMC150/BMI055/BMA255",
> 
> Somehow this is unsorted.
> 
> > +               .name = "BMC150/BMI055/BMA253/BMA255",
> 
> So does this.
> 

Yeah I sorted multi-line lists and Kconfig but not those "one-line"
lists... :-) Time for v3...

Thanks for your review!
Stephan
