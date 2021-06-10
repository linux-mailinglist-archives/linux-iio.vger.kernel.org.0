Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2733A2C55
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jun 2021 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbhFJNDD (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Jun 2021 09:03:03 -0400
Received: from mo4-p03-ob.smtp.rzone.de ([85.215.255.100]:9383 "EHLO
        mo4-p03-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbhFJNC7 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Jun 2021 09:02:59 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1623330057; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KrSsON5uT1FtPXkvwp6dMEUOsejS4rCADVo+pVkw2xeLbk2FOxVTRVR7r7Y3zESPxE
    gJtKaD0sxbMurZCvcoWkjpFytd4IduDKD/HZGr6HNVhTsEs16vy6MrxCNvtNZ5OlF57v
    6oOx94I3pQwp2LgX61feRUswMYwKv8UJ3I6KrUZSL4J2mp6XLmAN3Mgdm7ds4AD518jf
    PcmpqB1EA5a+P7tnMgbX7w41vcr4kx2pp0DJgvL4A68JMnTiyTF0Q2ZS0V9ghWLxW952
    RtJbslJxlR02+9lW+yl7TrjLTBx/u7tbKm4AAIej0z9N7CLD1W3vBOEdO+pKIi6vFyNM
    yA7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1623330057;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sWxhDLVjSdcZ2UQfDvOUeM8ckKd6tdu1RXGe2b5SbxA=;
    b=EYYMmZ/tfmHP0l+Z0vXHSDg3jx/Y32XMdAwYefQZHhWwxN09BkS+wiumHwK+THAk6h
    HP0NOG1MSSCUcByK0zVGxsPZPmATfLZuXxG7NLoKxbNp++cxlcxKQf4IZ1OfPAEjAxnT
    BixW1Uul/6mIQOJMihoC3q2uztkI6SyeCUkvR7H980C/iD76oAnrsWtKkTAm41uQ0x3s
    1l/jhTHRiX9ZS/pFD03k+rAFIDc5xeKGGJEW8oTyhgHjVrBToNkBKjhb6sMQ2o09ncfe
    RBZUGyyZEWrr1LUEwboBN/+3ugjECWI2AKtn22o0zYM3HM1T5nzxVuGtRldF1xUSLHlK
    Em6g==
ARC-Authentication-Results: i=1; strato.com;
    dkim=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1623330057;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=sWxhDLVjSdcZ2UQfDvOUeM8ckKd6tdu1RXGe2b5SbxA=;
    b=H2jrjcHXgiGUpEexIxYEfL3LUzAVtY12sPAr57SrHQpp0L4FKIDyKIhNhlHFNqz0t9
    xasZpjHn3Rr2GGQywa+wuJvn+oO9RskoCFM7LbsTmwisA5zA66wLRFVePMJsVbmqu37B
    x4Rg9xNbi0lupI/jAf9dYdKuqjJ66aQQyqPeM9BBhzo07NRzSHO5EpxMGSgwyl4vtCLc
    zVXfQ3BRIIZA5VZdvVXU9f4zZ1+dxEzNJL/KGujroPI08DpTizCcCfMdE/OtlCi8vi52
    HNhB/+W1GOJjIAYp2wvfzBIObzYQPPoILG7hDXU8cL5sDquLq+m/c/2aodJKb3G12cUh
    ic/w==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u26zEodhPgRDZ8nxIc/BaYo="
X-RZG-CLASS-ID: mo00
Received: from gerhold.net
    by smtp.strato.de (RZmta 47.27.2 DYNA|AUTH)
    with ESMTPSA id y01375x5AD0vuGE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 10 Jun 2021 15:00:57 +0200 (CEST)
Date:   Thu, 10 Jun 2021 15:00:52 +0200
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
Subject: Re: [PATCH v2 4/9] iio: accel: bmc150: Sort all chip names
 alphabetically / by chip ID
Message-ID: <YMINBHXM4ZmZMblL@gerhold.net>
References: <20210610122126.50504-1-stephan@gerhold.net>
 <20210610122126.50504-5-stephan@gerhold.net>
 <CAHp75Vee9+RU8zRH-QtoKmw4K-O-SjiGnpxJRnYT2Aat3qKtfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vee9+RU8zRH-QtoKmw4K-O-SjiGnpxJRnYT2Aat3qKtfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jun 10, 2021 at 03:50:25PM +0300, Andy Shevchenko wrote:
> On Thu, Jun 10, 2021 at 3:24 PM Stephan Gerhold <stephan@gerhold.net> wrote:
> >
> > Right now all the device IDs are listed in seemingly random order,
> > make this consistent by ordering those alphabetically. Also, order
> > bmc150_accel_chip_info_tbl by chip ID for the same reason.
> 
> Thanks!
> My comments below, after addressing them,
> Reviewed-by: Andy Shevchenko <andy.shevhcenko@gmail.com>
> 
> ...
> 
> >         select BMC150_ACCEL_SPI if SPI
> >         help
> >           Say yes here to build support for the following Bosch accelerometers:
> > -         BMC150, BMI055, BMA250E, BMA222E, BMA255, BMA280.
> > +         BMA222, BMA222E, BMA250E, BMA255, BMA280, BMC150, BMI055.
> 
> Thanks!
> 
> > -         This is a combo module with both accelerometer and magnetometer.
> 
> > +         BMC150 is a combo module with both accelerometer and magnetometer.
> 
> BMC150 is only one from the list. Previous message applies to all
> listed components, so is this not true anymore for the rest?
> Or all the rest is not a combo? Please, clarify that in the commit
> message, or if this is a wrong change, drop it.
> 

I stumbled on that sentence when making the changes and it definitely
does not apply to the BMA* variants. Those are accelerometer only.

As far I can tell the prefix in the chip name says which kind of sensors
are included, i.e.

  - BMC150: accelerometer + magnetometer
  - BMA*:   only accelerometer

I'm not familiar with BMI055 but funnily the datasheet suggests it's

  - BMI055: accelerometer + gyroscope

So for BMI055 the previous message is wrong too. I guess I need to do
yet another commit in v3 to make the Kconfig option more clear for all
the sensor variants. :)

Thanks!
Stephan
