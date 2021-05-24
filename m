Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB84B38E37F
	for <lists+linux-iio@lfdr.de>; Mon, 24 May 2021 11:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232426AbhEXJox (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 24 May 2021 05:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232318AbhEXJox (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 24 May 2021 05:44:53 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5792AC061574
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 02:43:24 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id s25so32725568ljo.11
        for <linux-iio@vger.kernel.org>; Mon, 24 May 2021 02:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/+7VcbFhCLsORk4AL5LwpxSLV1BgnffBxx0vGz+mfvQ=;
        b=MiDF5sKmsC9xOKtlOHbSNZV8ifWz1ILGJobQhTzrftj6LpizdTC6e5eVP+mHMro4iR
         Sxk15vP0irKjz8ZniuzY1agSJZdP//zMps0aE0Y+TcsXzkTAXqKZuuQM1wODg3qnrfLg
         IqbBz59GV8DkDN45RC7f1A9wIEg+yO9Na8XePrfWOY11eGnAnzXcuhRv9HR+dVu/BcRz
         Fiqqo4qIBZ7KgUJMrZ7tZwnuhILN+CUlj8eGh/UJlI4tOI0L4Ea1chMj4YJAQd/h9FyN
         oyL9JG6VjWIboTFtLFNaRIfGYLbRTJbkrqIIqq+Z7brNHvjB3p6OXRwE0SRmpgpMKZmh
         peKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/+7VcbFhCLsORk4AL5LwpxSLV1BgnffBxx0vGz+mfvQ=;
        b=AVrP4X3SHESsPP+LjmClZXfZXqIqekGK0klNahpK7iZvzpVEvssNzDXUTA0dhEjSnu
         sLN7nVZE+neyos86nSemnFDHCzUo1+X0EUJefOalNDSC9Y7zFavAzqNwyTaLCGvPTXcK
         3Acp3VrElm7cGtK/XrQuEEOkOypjXnTpe5DQSjlJ7z0B6n+D9sHeET3NnTzxwznSIQLC
         ZPFSJQhKuR6+CA6kc+QVV1DqyXnTWNCHl/TPlOUmtJyoRZGhIUG5DTdr/vcfWtxwt0Ny
         zSiRtkZxdhLi0/FV8CQujtr9PZRWm1r7+xV0mDpXmgHQQIs1dKSNxXrmRZHo6xUggGl6
         FBVw==
X-Gm-Message-State: AOAM531Qor1dxm3B3WGQ0L8Fgk6BmyKZVmG6oC7OlcooV6iOAQUdvnqQ
        BbwSX3I66dZIepHUORvqbVsE0ETw9qLZK9QjXqpy+g==
X-Google-Smtp-Source: ABdhPJx5orS/qR1u4F+jnTL42ezcA7woRdr0+5nHYlfG5G+D9J9EIfxIPziQrGpipAfqPWKm9qcuEjETNpdAXvUCHmM=
X-Received: by 2002:a05:651c:4c6:: with SMTP id e6mr16854161lji.326.1621849402733;
 Mon, 24 May 2021 02:43:22 -0700 (PDT)
MIME-Version: 1.0
References: <20210518230722.522446-1-linus.walleij@linaro.org>
 <323cc45a-6db2-8732-d3b0-784b1250d7f7@redhat.com> <20210522191527.228f795a@jic23-huawei>
In-Reply-To: <20210522191527.228f795a@jic23-huawei>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 24 May 2021 11:43:11 +0200
Message-ID: <CACRpkdZu0PjH4ciJMSRZ0bywYFjrfWvvfvcpxPQQ+4P=rTNmTw@mail.gmail.com>
Subject: Re: [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Denis Ciocca <denis.ciocca@st.com>,
        Daniel Drake <drake@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, May 22, 2021 at 8:14 PM Jonathan Cameron <jic23@kernel.org> wrote:

> @Linus, for IIO stuff, please put a cover letter on series as it makes it
> easier for people to reply with things like this

OK sorry about that, I'll try to keep it in mind.

> and still let me use b4
> without manual tweaking.

b4 only need the patches to be sent in a thread which I
actually did, at least this works fine for me from here:

tmp]$ b4 am -t 20210518230722.522446-1-linus.walleij@linaro.org
Looking up https://lore.kernel.org/r/20210518230722.522446-1-linus.walleij%=
40linaro.org
Grabbing thread from lore.kernel.org/linux-iio
Analyzing 7 messages in the thread
---
Writing ./v3_20210519_linus_walleij_iio_st_sensors_create_extended_attr_mac=
ro.mbx
  =E2=9C=93 [PATCH 1/5 v3] iio: st_sensors: Create extended attr macro
    + Reviewed-by: Hans de Goede <hdegoede@redhat.com> (=E2=9C=93 DKIM/redh=
at.com)
  =E2=9C=93 [PATCH 2/5 v3] iio: accel: st_sensors: Support generic mounting=
 matrix
  =E2=9C=93 [PATCH 3/5 v3] iio: accel: st_sensors: Stop copying channels
  =E2=9C=93 [PATCH 4/5 v3] iio: magnetometer: st_magn: Support mount matrix
  =E2=9C=93 [PATCH 5/5 v3] iio: gyro: st_gyro: Support mount matrix
  ---
  =E2=9C=93 Attestation-by: DKIM/linaro.org (From: linus.walleij@linaro.org=
)
---
Total patches: 5
---
 Link: https://lore.kernel.org/r/20210518230722.522446-1-linus.walleij@lina=
ro.org
 Base: not found
       git am ./v3_20210519_linus_walleij_iio_st_sensors_create_extended_at=
tr_macro.mbx

But I guess that without a 00/nn it is maybe not as clear if a series was
sent as a thread.

Yours,
Linus Walleij
