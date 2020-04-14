Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 792D51A8164
	for <lists+linux-iio@lfdr.de>; Tue, 14 Apr 2020 17:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440195AbgDNPH2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 14 Apr 2020 11:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440187AbgDNPHR (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 14 Apr 2020 11:07:17 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADF1C061A0C
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 08:07:17 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id v2so27359plp.9
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2020 08:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HXPhg5XZLWctoFmTijyqdVHg9O3QBjKw4IoYCJobOX4=;
        b=GbDuuqSI/y8KQHrgK6cgKbnAH49ERBN4AarYo9AXQCMOz+8ZxuVUcFznEYqZAWBLpc
         dnUjexS+qLW+qIBfJY3L9dEc8sGU+bD6u7a3c6NMxpVR6g9BDfYTtQSsHZUiwYU4X5X0
         7yugArXgu3Duk3xxD4R8R+yLomXmxBRccglR9jwu84wB04WUbYU/pAsMvRFWZYGZyH8O
         axx0MqiJIxv7LhhpOqjr99h2yBe2ggzJTmV56X+Y/v8fNnXfgqxBEx80G4DN699cOV2Z
         j3OKSs+vTeagbdC5RcoMtaLnB90XFQGuQLjQzr/YvKnbK2T5++8vIZANlfwsNVaGMYEg
         tk3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HXPhg5XZLWctoFmTijyqdVHg9O3QBjKw4IoYCJobOX4=;
        b=tJDIvHlXDwm/obiX3+SIhbW+V4XKGolLO/9ghAeLkV+AfAW07OXxqJfBZ9iyIyAlGx
         UAl9u/rMhvQ6eqduf2WVC5/A/oXPoO7atDnjOl2loOq5wqQ9hfEbHD2jF1bLsFyPtCAa
         VOM17vkZs/kqhMcczteCgaYpuunq/8frY1971m6UJ7PdcCzJEqEITtnI2AS2V0GMXs/L
         VJJ0EDaAZcv2p4Acrw3w08esnaVDIfsng1eQUY6+Xp29cZDMTFZ1wQ13DzrOo0f8HRk/
         fAwmf4wF+4AwoCRCT+tCfM/nCd9t0VBfCMq+0JNLohKpskXtI71i4MlP5vlPRPB/jyNz
         ch7Q==
X-Gm-Message-State: AGi0PuYpTHyhgePtaNnKnMPhtTbk9eg/7t6qmbO50CR5cd9HmM2aSV72
        c0Kca7JlPLAlSsSaTeglcAQ8s2yikhhApIihIvs=
X-Google-Smtp-Source: APiQypJ+D2oaChmsjeZ1Uc9W8K2+tcjQqU2Wuqb8oPQVfJXVMFF2nafiAtLnsNnQEEkhsm/9r7yL1jsbxFZDX/h0uVg=
X-Received: by 2002:a17:902:9306:: with SMTP id bc6mr352911plb.255.1586876836713;
 Tue, 14 Apr 2020 08:07:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200414062717.19124-1-chris.ruehl@gtsys.com.hk> <alpine.DEB.2.21.2004140920210.21841@vps.pmeerw.net>
In-Reply-To: <alpine.DEB.2.21.2004140920210.21841@vps.pmeerw.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 14 Apr 2020 18:07:09 +0300
Message-ID: <CAHp75VcD6j-OLTN1hUZ5+j-L+yZmpmy8LSi1NkDoLdoKGyYEZw@mail.gmail.com>
Subject: Re: [PATCH 2/3] iio: DAC extension for ltc2634-12/10/8
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Chris Ruehl <chris.ruehl@gtsys.com.hk>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, Apr 14, 2020 at 5:51 PM Peter Meerwald-Stadler
<pmeerw@pmeerw.net> wrote:

...

> > @@ -357,6 +393,12 @@ static const struct spi_device_id ltc2632_id[] = {
> >       { "ltc2632-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H12] },
> >       { "ltc2632-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H10] },
> >       { "ltc2632-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2632H8] },
> > +     { "ltc2634-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L12] },
>
> is kernel_ulong_t the correct type here?

Pretty much.

> i.e. guaranteed to hold a pointer value, such as uintptr_t in C?

> it seems so, but why not use uintptr_t?

Because of inconsistency with a definition of structure. Please, refer
to mod_devicetable.h for the details.

> > +     { "ltc2634-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L10] },
> > +     { "ltc2634-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634L8] },
> > +     { "ltc2634-h12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H12] },
> > +     { "ltc2634-h10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H10] },
> > +     { "ltc2634-h8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2634H8] },
> >       { "ltc2636-l12", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L12] },
> >       { "ltc2636-l10", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L10] },
> >       { "ltc2636-l8", (kernel_ulong_t)&ltc2632_chip_info_tbl[ID_LTC2636L8] },

-- 
With Best Regards,
Andy Shevchenko
