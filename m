Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897303A2BE9
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 14:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhFJMuX (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 08:50:23 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.102]:35412 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbhFJMuW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 08:50:22 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623329301; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RkLUnKiCTQ7mT7CZTP/5lFMSAgKuT6WW81nbT9sfCSohvtfDM0DfWztjTYyp3Bsqde
    UePG55vapyvLt9UF/hDcE5EF8+UB1AgBQBTnwtShq9EmplZJeZZlbdlw7S2TW47/rho6
    ZuETJiStreX+oCSQWwektE50sQCXgzMhoMkq6ZHt9HlBzNHF8GzTBhAceTHau6KYZmhb
    CVuTcFOsMCraJ+5Igi0ifD8XGEKZ3f1q0AfMdRyFWAFIzlKEHZkefzoiKPCvwaXzBpA3
    3rBS/iG0e99z/uwDTLojaAcczgU4jjwoFOwwVfvPTajkqwd1aNSO7k17jqLbsSqgf0w8
    +Q+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623329301;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NIX1i9ewWGqVCUHs4Qc+tSeYMAvkAQxhEGQPe4dsJRk=;
    b=TMvW9S6Rp0vuhA5X7oay8mDOmlYq/cQfg7pUxOihf2Xua7llKNsbTRjqz9YqcNhZtN
    GwK0qdE1T+WPdWqTueMvlIO5yCiu8MKNvkxPysqJUn+bKpN3RMqnS72aqgAfSKkpi2FE
    C6PATeW3fxQo2dx4lePlc+IM4Jo4w/6IoUtg0AWY8L4g6gV+7yEcP6mvjlpUoqw23jzP
    oEJOom/gxyDI2yMv17UE7el2wSaW1XgIhvh1geEC/YzE6sRbK5S+ApUUNUQrV1P1BwEG
    JDhoeF9xvy1z14p6UHkBHIXKviW8X4UiM9os/BAzgDAOt54kDar3nhu+/OVqjL3aYAPj
    XgSw==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623329301;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=NIX1i9ewWGqVCUHs4Qc+tSeYMAvkAQxhEGQPe4dsJRk=;
    b=icYhcwsmCxzGtJYwAH1rhGBLtjsU00gTEATESBEwgGBFSAcfomd1a8qhDs3XU7q4Gn
    5K22OiBYboGQuKkIyMFUGhV6Dz2lXtW0Cfy78GFm2yqaMVI5mDcA6eZC5bl5gVUeshrs
    lETDa/CGjPG6Yi8nafSH+SuYhmjilumDbZcGCWqfLiFWnTREIpRtucGTcniM1QI/AnjY
    gqcZRoZHmZKvCgrWHRn6MHkM0fyIPft6GyCCWDt9+6qBnOLItcyUAnFhM0X9C+gMLoEE
    SV80svgnVJOWHIwJjAvWrMEHPmrFnV4njnt8AxpojX8TMnoMG3Sz04knpYtMCcjGveqT
    pNbQ==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5ACmLu8o
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 14:48:21 +0200 (CEST)
Date:   Thu, 10 Jun 2021 14:48:16 +0200
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
Subject: Re: [PATCH v2 3/9] iio: accel: bmc150: Drop duplicated documentation
 of supported chips
Message-ID: <YMIKEInlWEzWsSY+@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
 <20210610122126.50504-4-stephan@gerhold.net>
 <CAHp75VcLWK=b3fn3c2m-2ZgapxrcNxJdQx7ODfZG2mRK5z+rQQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcLWK=b3fn3c2m-2ZgapxrcNxJdQx7ODfZG2mRK5z+rQQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 03:45:17PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > The chips supported by the bmc150-accel driver are clearly documented
> > in Kconfig, in the bmc150_accel_chip_info_tbl as well as in all the
> > device ID tables in the I2C/SPI drivers. It's easy to forget to update
> > the lists in the file header. Drop those entirely to reduce the amount
> > of changes required to add new chip variants.
> >
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > New patch in v2. Originally I tried to reorder those too but then it
> > caused conflicts in all my following patches so I'm not convinced
> > it's worth to try and keep those up to date.
> 
> It's not user-visible, so I'm fine, but users should have a
> possibility to know about supported chips in the Kconfig option.
> 
> Assuming above is done deal,
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> 

Yep, it's documented in Kconfig already. Actually I even added one
missing chip to Kconfig in patch 4/9 (BMA222) :)

Thanks!
Stephan
