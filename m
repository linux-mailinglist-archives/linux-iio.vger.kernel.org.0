Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2C823B144
	for <lists+linux-iio@lfdr.de>; Tue,  4 Aug 2020 01:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728541AbgHCXvK (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 3 Aug 2020 19:51:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHCXvJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 3 Aug 2020 19:51:09 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB46AC061757
        for <linux-iio@vger.kernel.org>; Mon,  3 Aug 2020 16:51:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id jp10so13883171ejb.0
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jXDDaDw8Eqt57H3f9xOmMsGMtQY7iJ1imNUg/tVT7gg=;
        b=Cw9FE0dBbSUGSKbJHPzftiC/rFHtKDanwjgHgZmM0zw84L1NME0vqbrJbro1fec6Ds
         GY/TX6SFh1xE57ojf+2CNYbeGcHvYWavFgJ+kWqcEVPA8tMNUqmT41r4AeNkAVs7S0Ec
         M9lnfsErivuKDOlf/lX1wDO80YbsfIq6lqhmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jXDDaDw8Eqt57H3f9xOmMsGMtQY7iJ1imNUg/tVT7gg=;
        b=dtQsL3JoPqOlikwNx8ZM8Pgv+4EygtLW87wdrjVZBbLv9eN32wP0eG/LxJRAxq1el8
         /9HNNk2r+eEK7a6pNPws/LFZuid8tJPCtX5HkLSK94Yj+oPh99kY115P7+mJI8bCglWk
         Fr+4wUJFUVYGUqvrRMu/3vsW6ojE4vVvmg/nvOMN2bv4XzUqbZeeO+3nqZcBE1Z6tl5b
         Nic5aKyprAjeG/69QIcfhyUCNlOrxXzsCXVuVoQEchcvtt47TQBA01XF2S8eqjaOMBSY
         zMOINMJaVvutke8W7JGNeo5MFMxLqpVkl11+mKPnZr/pylsQ0SaYhkt6Fzdgy35TxFOL
         WBNw==
X-Gm-Message-State: AOAM532m1YvOBZf4ebKAmw86CnYhFtm+f1AIewfRhEJ34Ekekqhnm6os
        lvhdrVWT+VGgTiYPuSIyYaZd6nxXm7c=
X-Google-Smtp-Source: ABdhPJxKVzK1sBYbwJveVanx1tJ2Mh3YIinDGRvWqBdb0hX77+5WJPw6Q9WWXgyowmAjhWSvXXQ3Sw==
X-Received: by 2002:a17:906:7798:: with SMTP id s24mr18679502ejm.45.1596498666442;
        Mon, 03 Aug 2020 16:51:06 -0700 (PDT)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com. [209.85.221.51])
        by smtp.gmail.com with ESMTPSA id g5sm17258292ejk.52.2020.08.03.16.51.04
        for <linux-iio@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 16:51:05 -0700 (PDT)
Received: by mail-wr1-f51.google.com with SMTP id a15so35694916wrh.10
        for <linux-iio@vger.kernel.org>; Mon, 03 Aug 2020 16:51:04 -0700 (PDT)
X-Received: by 2002:a5d:6641:: with SMTP id f1mr16995070wrw.307.1596498664242;
 Mon, 03 Aug 2020 16:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200803234154.320400-1-campello@chromium.org>
In-Reply-To: <20200803234154.320400-1-campello@chromium.org>
From:   Daniel Campello <campello@chromium.org>
Date:   Mon, 3 Aug 2020 17:50:28 -0600
X-Gmail-Original-Message-ID: <CAHcu+VYgA2rYS_R17cnREreRSjqGQvqRDUVFGf_ttQbfQu5OOQ@mail.gmail.com>
Message-ID: <CAHcu+VYgA2rYS_R17cnREreRSjqGQvqRDUVFGf_ttQbfQu5OOQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/15] sx9310 iio driver updates
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        linux-iio <linux-iio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi everyone,

So sorry, I sent an intermediate version as v4. Please disregard since
it has a couple bugs. I will send v5 with them fixed.

Regards,
Daniel

On Mon, Aug 3, 2020 at 5:41 PM Daniel Campello <campello@chromium.org> wrote:
>
> The first patch resends the DT binding for the driver that was merged in
> v5.8-rc1 with a small change to update for proper regulators. The second
> through the eleventh patch fixes several issues dropped from v8 to v9
> when the initial patch was merged.  The twelveth patch drops
> channel_users because it's unused. The thirteenth patch adds support to
> enable the svdd and vdd supplies so that this driver can work on a board
> where the svdd supply isn't enabled at boot and needs to be turned on
> before this driver starts to communicate with the chip. The final patch
> updates irq trigger flags.
>
> Changes in v4:
>  - Updated macro SX9310_REG_STAT1_COMPSTAT_MASK at call site.
>  - Use FIELD_GET/FIELD_PREP instead of manual shift.
>  - Reverted condition check logic on enable/disable_irq methods.
>  - Use pointer to buffer struct on iio_push_to_buffers_with_timestamp().
>
> Changes in v3:
>  - Moved irq presence check down to lower methods
>  - Changed buffer to struct type to align timestamp memory properly.
>  - Added static assert for number of channels.
>  - Added irq trigger flags commit to the series.
>
> Changes in v2:
>  - Added #io-channel-cells as a required property
>  - Reordered error handling on sx9310_resume()
>  - Added #include <linux/mod_devicetable.h>
>  - Added '\n' to dev_err()
>  - Fixed commit message from "iio: sx9310: Align memory"
>  - Changed prox_stat to chan_prox_stat bitmap.
>  - Fixed dev_err() message
>  - Added '\n' to dev_err()
>
> Daniel Campello (12):
>   dt-bindings: iio: Add bindings for sx9310 sensor
>   iio: sx9310: Update macros declarations
>   iio: sx9310: Fix irq handling
>   iio: sx9310: Remove acpi and of table macros
>   iio: sx9310: Change from .probe to .probe_new
>   iio: sx9310: Fixes various memory handling
>   iio: sx9310: Use long instead of int for channel bitmaps
>   iio: sx9310: Use regmap_read_poll_timeout() for compensation
>   iio: sx9310: Update copyright
>   iio: sx9310: Simplify error return handling
>   iio: sx9310: Use variable to hold &client->dev
>   iio: sx9310: Miscellaneous format fixes
>
> Stephen Boyd (3):
>   iio: sx9310: Drop channel_users[]
>   iio: sx9310: Enable vdd and svdd regulators at probe
>   iio: sx9310: Use irq trigger flags from firmware
>
>  .../iio/proximity/semtech,sx9310.yaml         |  65 +++
>  drivers/iio/proximity/sx9310.c                | 421 +++++++++---------
>  2 files changed, 276 insertions(+), 210 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
>
> --
> 2.28.0.163.g6104cc2f0b6-goog
>
