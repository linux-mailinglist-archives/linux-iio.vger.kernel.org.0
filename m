Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD59121A3EF
	for <lists+linux-iio@lfdr.de>; Thu,  9 Jul 2020 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGIPn5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 9 Jul 2020 11:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgGIPn5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 9 Jul 2020 11:43:57 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772CDC08C5CE;
        Thu,  9 Jul 2020 08:43:57 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mn17so1292274pjb.4;
        Thu, 09 Jul 2020 08:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5aSR39Y673gK4LGy+pomYrdhftpjF5NzAVJPOxgGDA8=;
        b=roDisFVPKLpYmdVp11RgxCQVrZnqxRmEM5k2L+abqUHYtxCJKkeCwNctIul+/pax8W
         Mbe2HIMo63hDHBD221lNxo4JQifsrDKRyBYOSXgNibMyXSHrWouzA/eV5WSNnXNDACOE
         dlIhnaVD31AD+hRu2cmd91xSo4JK+GbKdDjUoegM60F3us7yUeAVc/XwhwIiRViW1gEJ
         21YJxdwTRjrKqEpQz3Drr77ZV3DlEJEuelFNLRM6I74+pk+A+Pne1wwrg6jS7jzVloAB
         ckNUkhVbfz34eovP+IOBlBpKnh0Wm+j//BobyB0Oh0Ab6CffALrkReGnSw/oWDdGhqQE
         yCSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5aSR39Y673gK4LGy+pomYrdhftpjF5NzAVJPOxgGDA8=;
        b=Mow9gznm8Grl9RUa1Qcu6hxVHd/erqB6zK1d4aVxiapuvz/UzXV3QVRKuiN5R8siee
         D9VhFTz2ef7h1XbGCPfXgxvZDrPrvmsbh3tXqJbYPPxcz0c8us19ctFS4TcUQontJUjC
         26vAahzYSbsg9IpakwKqPvurIMf2ldwcVVoX8nAYcH9j7F1USF4VejNXNshe7YBMzsLX
         t9hqNX08LbovK1Qn9cxVVppm/2HZHCyDtXGk77oN+UdYSUZaz0TfZ6DjHpOLGBLYWUTE
         5ElTQvkVCM3gis3YvT1Q/BUkRjDbonTUOm2PSq9Y/vmsnvkNp9yTWUfNBzYNHs9KDS8I
         q7Hw==
X-Gm-Message-State: AOAM530i9JPzrR7YmJA/o5n2fI+F0ZD2bISdd+7g/YNRuDLrucSbQIwM
        F1j11jB2ogNcxymtDb1RFuCw/nydJ5VM3cNrrjo=
X-Google-Smtp-Source: ABdhPJymrDoI28s7I5KmpXMuqSAKOHB4T6Mn8hum7vi5/FRCdzLui7I/tE3BYrOAP4DxBG27lCVshjmLSxleGLqiP3E=
X-Received: by 2002:a17:90b:1b52:: with SMTP id nv18mr673895pjb.129.1594309436972;
 Thu, 09 Jul 2020 08:43:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200709152200.10039-1-contact@artur-rojek.eu>
In-Reply-To: <20200709152200.10039-1-contact@artur-rojek.eu>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 9 Jul 2020 18:43:40 +0300
Message-ID: <CAHp75VcwgL8pH+pH9TnsuwbWr=wSFu37sX8sTkbkfk+iBv7Jng@mail.gmail.com>
Subject: Re: [PATCH v8 0/6] iio/adc: ingenic: Cleanups & add touchscreen mode.
To:     Artur Rojek <contact@artur-rojek.eu>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Heiko Stuebner <heiko@sntech.de>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        devicetree <devicetree@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Thu, Jul 9, 2020 at 6:22 PM Artur Rojek <contact@artur-rojek.eu> wrote:
>
> Hi all,
>
> v8 of this patchset introduces some structural changes, which I deemed
> worthy highlighting here:

Can you remind me if I gave you tags on the previous version?
If so, is the above the reason to drop them?

>
>  - adc-joystick related changes have been dropped from this patchset and
>    will be upstreamed separately. Their only connection to this patchset
>    was that they used INGENIC_ADC_TOUCH_* defines in the DTS example,
>    causing trouble to Rob's scripts.
>
>  - Integrated Paul's changes, which introduce an ADCMD low-level command
>    feature. These changes affect patches 5/6 and 6/6, with the former
>    requiring Rob to re-ack.
>
> Cheers,
> Artur
>
> Artur Rojek (5):
>   dt-bindings: iio/adc: Convert ingenic-adc docs to YAML.
>   IIO: Ingenic JZ47xx: Error check clk_enable calls.
>   IIO: Ingenic JZ47xx: Add xlate cb to retrieve correct channel idx
>   dt-bindings: iio/adc: Add touchscreen idx for JZ47xx SoC ADC
>   IIO: Ingenic JZ47xx: Add touchscreen mode.
>
> Paul Cercueil (1):
>   iio/adc: ingenic: Retrieve channels list from soc data struct
>
>  .../bindings/iio/adc/ingenic,adc.txt          |  49 ---
>  .../bindings/iio/adc/ingenic,adc.yaml         |  71 ++++
>  drivers/iio/adc/Kconfig                       |   1 +
>  drivers/iio/adc/ingenic-adc.c                 | 386 ++++++++++++++++--
>  include/dt-bindings/iio/adc/ingenic,adc.h     |   6 +
>  5 files changed, 426 insertions(+), 87 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ingenic,adc.yaml
>
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
