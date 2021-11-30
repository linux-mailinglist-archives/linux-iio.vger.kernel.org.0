Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2506C46298F
	for <lists+linux-iio@lfdr.de>; Tue, 30 Nov 2021 02:19:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235806AbhK3BWW (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 29 Nov 2021 20:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235648AbhK3BWV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Nov 2021 20:22:21 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B09CC061714
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 17:18:59 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id o4so38056957oia.10
        for <linux-iio@vger.kernel.org>; Mon, 29 Nov 2021 17:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=h7dfI3SuNLbI8eu2t4U0v+H2ni+TuABrtKx5R3CfOHM=;
        b=yJc94fLQTljmDterLRcug2eR/c+vDp0LTI+vRv2nR+c/ddCjsYXmPTE02Vayv09E3R
         Kv8LNcOXnMkrzyWweCyKQNq91Omh0l7IFZLiSEs3jXCZXnBJ67lffzr40aZWtneQarqb
         bKVmqXvIjRi8CEqJPV+fdwbCsmIYY0oya15SfMc4WnqZwgpCckZ2362UkaNMbQ3rnE6Q
         L2ZqySG/zeIswlIiFzrpwKLl+Vdekd1MbW0XqN5PD7lMKjSU87ArTZPmkYsxYkiO7meU
         q/F+WzMnW2TPdv54KXLgDmIsF6YCCQZ+rb+ylC+w3Hz/3rP1sQ2Mx1L73iPSSK5zyfls
         mjsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=h7dfI3SuNLbI8eu2t4U0v+H2ni+TuABrtKx5R3CfOHM=;
        b=fu8xF8CDV04hm+a2hkJLgLsReI2kRYBvXfzDapSVdJ3SNvYD9faTgZoCgMyEXv7uaN
         A7lYXviYZ2Gnp8tYM5hnfJjPy7JSKCgiOB2YReDf6uYhCrP3fIaljCNsCXY6fdcBlX5g
         BnfftxQylx3jesJ3a8rAo2IP3B6whZsw+1F1RfHS573sSipUMlqcc2Jhn0uX40EDXRxr
         cqXnTkxXZNgJc38UeVv2XmKsm9+x3Nvkg/AmO8vftXKti8J+vC5u5jC+ZTvWwAw8p/JF
         TT00EL8gDZ2vs3N14jel/wWZgcy0kxYln3RFhTDvIs/vovYGmR3//hQ8JJql+Gi5hvR3
         36/Q==
X-Gm-Message-State: AOAM530cKEvp+oHLFTfS9RmgKrLwpcjORNE/VHUV2wOKqyJBc9X2r16r
        2qBKkwY4unU8brvr1gxd8hMBBrmRMvXM0JeKWVGZtw==
X-Google-Smtp-Source: ABdhPJzmLyeQbxd78GNxBdXwDedwzxM3MZT96tDdvy8hzbjtS6grHN+iBJetLmTlLj/SPYPMXXf9itVMOmqvKPpjHwU=
X-Received: by 2002:a54:4791:: with SMTP id o17mr1541501oic.114.1638235138666;
 Mon, 29 Nov 2021 17:18:58 -0800 (PST)
MIME-Version: 1.0
References: <20211127192510.35723-1-demonsingur@gmail.com> <20211127192510.35723-4-demonsingur@gmail.com>
In-Reply-To: <20211127192510.35723-4-demonsingur@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Nov 2021 02:18:46 +0100
Message-ID: <CACRpkda7-5YDQ6Gc+Ad0eHYO8pW3nLuUh1rKn9dEZ0PS-xHyJg@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] iio: addac: add AD74413R driver
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, Nov 27, 2021 at 8:25 PM Cosmin Tanislav <demonsingur@gmail.com> wro=
te:

> The AD74412R and AD74413R are quad-channel software configurable input/ou=
tput
> solutions for building and process control applications. They contain
> functionality for analog output, analog input, digital input, resistance
> temperature detector, and thermocouple measurements integrated
> into a single chip solution with an SPI interface.
> The devices feature a 16-bit ADC and four configurable 13-bit DACs to pro=
vide
> four configurable input/output channels and a suite of diagnostic functio=
ns.
> The AD74413R differentiates itself from the AD74412R by being HART-compat=
ible.
>
> When configured with channel 0 as voltage output, channel 1 as current
> output, channel 2 as voltage input and channel 3 as current input, the
> following structure is created under the corresponding IIO device.
>
> .
> =E2=94=9C=E2=94=80=E2=94=80 in_current0_offset
> =E2=94=9C=E2=94=80=E2=94=80 in_current0_raw
> =E2=94=9C=E2=94=80=E2=94=80 in_current0_sampling_frequency
> =E2=94=9C=E2=94=80=E2=94=80 in_current0_sampling_frequency_available
> =E2=94=9C=E2=94=80=E2=94=80 in_current0_scale
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_offset
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_raw
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_sampling_frequency
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_sampling_frequency_available
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_scale
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_offset
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_raw
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_sampling_frequency
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_sampling_frequency_available
> =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_scale
> =E2=94=9C=E2=94=80=E2=94=80 in_current3_offset
> =E2=94=9C=E2=94=80=E2=94=80 in_current3_raw
> =E2=94=9C=E2=94=80=E2=94=80 in_current3_sampling_frequency
> =E2=94=9C=E2=94=80=E2=94=80 in_current3_sampling_frequency_available
> =E2=94=9C=E2=94=80=E2=94=80 in_current3_scale
> =E2=94=9C=E2=94=80=E2=94=80 out_voltage0_raw
> =E2=94=9C=E2=94=80=E2=94=80 out_voltage0_scale
> =E2=94=9C=E2=94=80=E2=94=80 out_current1_raw
> =E2=94=9C=E2=94=80=E2=94=80 out_current1_scale
> =E2=94=9C=E2=94=80=E2=94=80 name
> =E2=94=9C=E2=94=80=E2=94=80 buffer
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 data_available
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 enable
> =E2=94=82   =E2=94=9C=E2=94=80=E2=94=80 length
> =E2=94=82   =E2=94=94=E2=94=80=E2=94=80 watermark
> =E2=94=94=E2=94=80=E2=94=80 scan_elements
>     =E2=94=9C=E2=94=80=E2=94=80 in_current0_en
>     =E2=94=9C=E2=94=80=E2=94=80 in_current0_index
>     =E2=94=9C=E2=94=80=E2=94=80 in_current0_type
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_en
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_index
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage1_type
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_en
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_index
>     =E2=94=9C=E2=94=80=E2=94=80 in_voltage2_type
>     =E2=94=9C=E2=94=80=E2=94=80 in_current3_en
>     =E2=94=9C=E2=94=80=E2=94=80 in_current3_index
>     =E2=94=94=E2=94=80=E2=94=80 in_current3_type
>
> Signed-off-by: Cosmin Tanislav <cosmin.tanislav@analog.com>

From a GPIO point of view there is nothing to complain about here
so:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
