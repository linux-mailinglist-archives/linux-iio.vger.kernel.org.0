Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088C238D6DC
	for <lists+linux-iio@lfdr.de>; Sat, 22 May 2021 20:11:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEVSNQ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 22 May 2021 14:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbhEVSNQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 22 May 2021 14:13:16 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A7CBC061574
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:11:50 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id j12so16877300pgh.7
        for <linux-iio@vger.kernel.org>; Sat, 22 May 2021 11:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7SK1jwCORAJwOku71k74kizq3BL/irGNdgIM5FobjmM=;
        b=VHJIUfmLszzHd+U/XxstxbnDiua+CqbneEPzSwbTrodTOtPvnn86yMa9AcyoPJO92Q
         7ynnKMbSMq7/1yUqP8XF0CF8hZSwezJiU3q4GS79TMLtaTgJ6aWqfyvT+NwIEZJMl1xY
         v4WHfjErBVp45Xwp9+9xN/BHOXG2+k/SP3LBQrYXRxVWjFjMQL20mOptdXm2ukhRwGx8
         Br1buXG1k8BRq87rwYJuA3PTtyt+qubUEqhN3db19aiJiXb2eXoFBo7M3zJYYrxPvQwd
         PuPmNn85YMrcRopcm72/3aI03L9kDvd7oGOkN+OJbR3q5UOrKd8/D8MIumUrP605pfCU
         EyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7SK1jwCORAJwOku71k74kizq3BL/irGNdgIM5FobjmM=;
        b=eAXdczWecwiI+uTzGF1FsB/NgTNOssG9WFJKKM6N9SZgnPxGZ3d59W+jsMpvGfTZQP
         FZMe1RMN/XXmuFyLfYlfTVgkVluswG46ebPGcSDRtM0suf9xQl54sARqB4hIAf3xNt9j
         nVfaEymU6X0CxPw54UV2mj/pPszzFTDf6Jgct7ZxAiVgE/aPRgu1wH+VhGKdaDNC9ZR1
         0crTIFmA5eTkQGTKww8KlgtNUDK+eRtKd9+cSoQ55DV79Tk9AdZlyuPAQ6Vne827+m4C
         5BoqTM/i6qmS8WvTyzFiXaZ3TABa00aFHnE1Ras6oxaa0nUNfb/0w6yA+hdm/3bYJEsK
         U+Lg==
X-Gm-Message-State: AOAM532Cb+4Dh1t79m4yqbHdBr5LoYAWBtlM9QyCyoVzrpCz7O+gNIVh
        xZ74lPTqyDJ87r3C+X3+ZV8r/K4b00yl+1R3SVQ=
X-Google-Smtp-Source: ABdhPJxNLyTS1W/9LF7NcfOsca+cphRVoI5JVl72ltX0NVbzB6beP5o/0iTUNuBCog2Iz9M5dAWa7LGTFikQR9Psx3U=
X-Received: by 2002:a05:6a00:a1e:b029:2e2:89d8:5c87 with SMTP id
 p30-20020a056a000a1eb02902e289d85c87mr14588981pfh.73.1621707109670; Sat, 22
 May 2021 11:11:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210521171418.393871-1-hdegoede@redhat.com> <20210521171418.393871-5-hdegoede@redhat.com>
In-Reply-To: <20210521171418.393871-5-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 22 May 2021 21:11:32 +0300
Message-ID: <CAHp75Vf_itoC8hiacBPXLK73NLbFre58b=wmVdEbviwEj0ZHHA@mail.gmail.com>
Subject: Re: [PATCH 4/8] iio: accel: bmc150: Add support for
 dual-accelerometers with a DUAL250E HID
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jeremy Cline <jeremy@jcline.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        patches@opensource.cirrus.com,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 21, 2021 at 11:23 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> The Lenovo Yoga 300-11IBR has a ACPI fwnode with a HID of DUAL250E
> which contains I2C and IRQ resources for 2 accelerometers, 1 in the
> display and one in the base of the device. Add support for this.

...

> +       board_info.irq = acpi_dev_gpio_irq_get_by(adev, NULL, 1);

If NULL will be there after the series, why not to use
acpi_dev_gpio_irq_get() directly?

-- 
With Best Regards,
Andy Shevchenko
