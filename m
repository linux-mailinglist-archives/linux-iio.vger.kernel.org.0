Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA533B123
	for <lists+linux-iio@lfdr.de>; Mon, 10 Jun 2019 10:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfFJIp2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 10 Jun 2019 04:45:28 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43881 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388041AbfFJIp1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 10 Jun 2019 04:45:27 -0400
Received: by mail-qk1-f193.google.com with SMTP id m14so5045841qka.10;
        Mon, 10 Jun 2019 01:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mg3aSfJBuVduU4VNPluxDXCyjmsixqOgJYW+XgD2lXY=;
        b=bRZsnI/y5+a24CCyEpHu5g85JrLnk+kCQ4csaKYuDD7NjNGXJQ4RYET471WVVRsWLr
         KpYKWOJgJN2lDFoNg6eLa2OFmx9gIujjclUYuTWPLDiT34u1HBr6tV5NYwltlf3s6Buk
         fhsLiGivPOQjpGY+/mcGsKuhM/fKEAGXT3y6MGbiZkbryYw/+R5XOnsOq7WW7ouRkia5
         KqA6n9IpuzZQTiKOPqNeXckHSY1X7CW2EWRedosL/YXvu4g2Eo2ZML7R0YCHzw4ea3xv
         5jGwYUju2d3e/4/41/Vu34qCW88ne5PMxYpi0cmom7wgfSCMFCX+WnkyxTDBUP0XQm4m
         pnhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mg3aSfJBuVduU4VNPluxDXCyjmsixqOgJYW+XgD2lXY=;
        b=BrFERDPKL/1CzFtMXVKPcxTbSIEGxr9touXPeZ5PBX/6jRqtgAp6hAXaT1aJgV3dts
         u2XfFiyFIZyknRJFiD8VYVcfQTQt8Vu8stOda8pQ9Ca8bJRjCJqg45Wkd+c10piD9p1j
         d5fmXAwTtSIyCC/DZ9U8daESOEP8HVjRTxBqj60ghSg+AfhhBEyIHXK5tHn+U8ICHwYX
         Y32PojMb3FkQO6q/uY+0Vk9LRUMd72+MlxaJ2whesq9hSMfEn0AZZv0w0a6xSuiC/yHe
         fMVqG8PaH2kPTKI8JENT7LZqu/Ly0uWiebpOM4fauAX93GVm1N2u5c5Fx5MEjzXMOFdO
         EDCg==
X-Gm-Message-State: APjAAAUEWeJsYTp2Kjv51A6KyFQyb6bKR0w2kVBkzMRDu4aPfnXcFF3D
        XwGpiIZTiTyoxwZbxavTff5ucjpfXtC9eYSYpw0=
X-Google-Smtp-Source: APXvYqwOdQ8P2Ew3Mk3oGOxjm0eqXygeSpRp3gbJMPVswit25JDiJQ7ZHeMuJkIf6k835tU672Pnazl1f0Z1doVdvP0=
X-Received: by 2002:a37:5fc2:: with SMTP id t185mr12884844qkb.206.1560156326605;
 Mon, 10 Jun 2019 01:45:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190603183401.151408-1-gwendal@chromium.org> <20190604055908.GA4797@dell>
 <CAFqH_51gMu81f=VFQaF4u9-tAWDMocGAwM_fOPT3Cctv6KWniw@mail.gmail.com> <20190610082012.GK4797@dell>
In-Reply-To: <20190610082012.GK4797@dell>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Mon, 10 Jun 2019 10:45:15 +0200
Message-ID: <CAFqH_50J1wqdhWw5nW+D=crfg=JjUrSh2it=JORx5Wn8LfNTQg@mail.gmail.com>
Subject: Re: [GIT PULL] Immutable branch between MFD and Cros due for the v5.3
 merge window
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        alsa-devel@alsa-project.org, linux-iio@vger.kernel.org,
        fabien.lahoudere@collabora.com, Takashi Iwai <tiwai@suse.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Thanks for the ib Lee.

Doing my Monday rebase I just noticed we will have a trivial conflict
for the merge window.

Missatge de Lee Jones <lee.jones@linaro.org> del dia dl., 10 de juny
2019 a les 10:20:
>
> As requested.
>
> Enjoy!
>
> The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0eb=
d9:
>
>   Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git ib-mfd-cros-v=
5.3
>
> for you to fetch changes up to 3aa6be30da899619c44aa654313ba66eb44e7291:
>
>   mfd: cros_ec: Update I2S API (2019-06-10 09:15:08 +0100)
>
> ----------------------------------------------------------------
> Immutable branch between MFD and Cros due for the v5.3 merge window
>
> ----------------------------------------------------------------
> Gwendal Grignou (30):
>       mfd: cros_ec: Update license term

That's the commit will have problems due

commit 9c92ab61914157664a2fbdf926df0eb937838e45
Author: Thomas Gleixner <tglx@linutronix.de>
Date:   Wed May 29 07:17:56 2019 -0700

    treewide: Replace GPLv2 boilerplate/reference with SPDX - rule 282

That was introduced in v5.2-rc4

Just to let you know.
 Enric

>       mfd: cros_ec: Zero BUILD_ macro
>       mfd: cros_ec: set comments properly
>       mfd: cros_ec: add ec_align macros
>       mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
>       mfd: cros_ec: use BIT macro
>       mfd: cros_ec: Update ACPI interface definition
>       mfd: cros_ec: move HDMI CEC API definition
>       mfd: cros_ec: Remove zero-size structs
>       mfd: cros_ec: Add Flash V2 commands API
>       mfd: cros_ec: Add PWM_SET_DUTY API
>       mfd: cros_ec: Add lightbar v2 API
>       mfd: cros_ec: Expand hash API
>       mfd: cros_ec: Add EC transport protocol v4
>       mfd: cros_ec: Complete MEMS sensor API
>       mfd: cros_ec: Fix event processing API
>       mfd: cros_ec: Add fingerprint API
>       mfd: cros_ec: Fix temperature API
>       mfd: cros_ec: Complete Power and USB PD API
>       mfd: cros_ec: Add API for keyboard testing
>       mfd: cros_ec: Add Hibernate API
>       mfd: cros_ec: Add Smart Battery Firmware update API
>       mfd: cros_ec: Add I2C passthru protection API
>       mfd: cros_ec: Add API for EC-EC communication
>       mfd: cros_ec: Add API for Touchpad support
>       mfd: cros_ec: Add API for Fingerprint support
>       mfd: cros_ec: Add API for rwsig
>       mfd: cros_ec: Add SKU ID and Secure storage API
>       mfd: cros_ec: Add Management API entry points
>       mfd: cros_ec: Update I2S API
>
>  include/linux/mfd/cros_ec_commands.h | 3658 +++++++++++++++++++++++++++-=
------
>  sound/soc/codecs/cros_ec_codec.c     |    8 +-
>  2 files changed, 2915 insertions(+), 751 deletions(-)
>
> --
> Lee Jones [=E6=9D=8E=E7=90=BC=E6=96=AF]
> Linaro Services Technical Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
