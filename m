Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F184A3D4AE
	for <lists+linux-iio@lfdr.de>; Tue, 11 Jun 2019 19:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406641AbfFKR6L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 11 Jun 2019 13:58:11 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35352 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406628AbfFKR6L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 11 Jun 2019 13:58:11 -0400
Received: by mail-ot1-f65.google.com with SMTP id j19so12789586otq.2;
        Tue, 11 Jun 2019 10:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VCk8yXyDlU45xhcdQhx1a6hD5bkWPN082lBz8bnOkUY=;
        b=P1UKhIYgxM+XqSIsgTb87emPKNlNd6xALypb/TZzyRb+jBUnC8i5Nd+y9bqj8zezw1
         PVLkE5srBChxTYeKSTiG/xzCtE2O39FMElMr++lFqkDifYYzZHHXxNVa6ZAUbKOpMyhe
         u6PlXZNboq4L0jgn7AkxtSd28W736ruhkywHshY+jyCzZvIMs1O56l0gflaBZ7UqhwQL
         x2RQMfu1NCl93I1mh4SAyT5fO5WxjcRqNVi6NdN2yKWoaWkd3acM80QLStmQWoTnX1v5
         7M1JBXsMpTxCe4p9R78MjJh5v33YPLvhehDsyfHgqx7cuL09xlhmcldE4dAYPb/FmdZm
         6TOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VCk8yXyDlU45xhcdQhx1a6hD5bkWPN082lBz8bnOkUY=;
        b=i/EzGORW0GxMPsExG4+Uf3MGJGPLozly2hDQmUlb7QlXqbBr9bHMimkOXiUWmTzs+I
         MlWZpXJTaZ5crgPd86XGPRMVNUAHVY0yfrMdoxQjNe766jS+92s7GPqhgo5x4yLIqvyF
         Q4bUn/wflq05F0JHlVYAATv61ADPQOm/QPk5fq/ei0UJDCQ4xPD2VFpaE8baTthSlYt9
         gmIL42VlT111KUPMbgQB84r13PblhNPiahU55Cu0UsR4x/lT+A1kc7ZZDn6G28RILoGf
         U+xXh6KSQ0nNWmZPHriK2a3UJPBRAD1Jqm7OQTfL6uZv0uYSfkHJS+qY8BCGJCWJTar5
         yqXg==
X-Gm-Message-State: APjAAAWbQO+dIhyb8K9qkj3zAC6EvvIgeQYD6JzH1tPmTaR6NSOismuv
        Jz6jH+gQMWndJW6s/D/KAXlh/xAicr8KHpMHad4=
X-Google-Smtp-Source: APXvYqzoPj3Xa4uMgvBC9zsIyKzC4P0HF+b5cZAVaQucBLGJZkMH7tOH6JRC+xDDYFPIUVm3dwteObyR0yuyPX59K5A=
X-Received: by 2002:a9d:32a6:: with SMTP id u35mr36257313otb.81.1560275890132;
 Tue, 11 Jun 2019 10:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190604144714.2009-1-glaroque@baylibre.com> <20190604144714.2009-2-glaroque@baylibre.com>
 <CAFBinCBN4QC2tPDEQmTW_c+PP5yu2qoK5M1eSye=SmvpieKWQg@mail.gmail.com> <d68aae23-f877-1f65-94a4-79e909ae111a@baylibre.com>
In-Reply-To: <d68aae23-f877-1f65-94a4-79e909ae111a@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 11 Jun 2019 19:57:59 +0200
Message-ID: <CAFBinCBCUxZjnrRxFHApp4iwPUCQQ+PU54V6zJew8Sr8La3u7w@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation: dt-bindings: add the Amlogic Meson
 Temperature Sensor
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        khilman@baylibre.com, linux-kernel@vger.kernel.org,
        jic23@kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Neil,

On Tue, Jun 11, 2019 at 1:01 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 06/06/2019 21:16, Martin Blumenstingl wrote:
> > Hi Guillaume,
> >
> > thank you for working on this!
> >
> > On Tue, Jun 4, 2019 at 4:47 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
> >>
> >> This adds the devicetree binding documentation for the Temperature
> >> Sensor found in the Amlogic Meson G12 SoCs.
> >> Currently only the G12A SoCs are supported.
> > so G12B is not supported (yet)?
>
> G12B is 95% similar as G12A, it will certainly use slighly different values.
OK, thank you for clarifying this
as far as I can tell Guillaume's code is already prepared for that (as
there's a per-instance specific struct with settings for the specific
instance) which is good to know

> >
> >> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> >> ---
> >>  .../iio/temperature/amlogic,meson-tsensor.txt | 31 +++++++++++++++++++
> >>  1 file changed, 31 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> >> new file mode 100644
> >> index 000000000000..d064db0e9cac
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> >> @@ -0,0 +1,31 @@
> >> +* Amlogic Meson Temperature Sensor
> >> +
> >> +Required properties:
> >> +- compatible:  depending on the SoC and the position of the sensor,
> >> +               this should be one of:
> >> +               - "amlogic,meson-g12a-cpu-tsensor" for the CPU G12A SoC sensor
> >> +               - "amlogic,meson-g12a-ddr-tsensor" for the DDR G12A SoC sensor
> >> +               followed by the common :
> >> +               - "amlogic,meson-g12a-tsensor" for G12A SoC family
> >> +- reg:         the physical base address and length of the registers
> >> +- interrupts:  the interrupt indicating end of sampling
> >> +- clocks:      phandle identifier for the reference clock of temperature sensor
> >> +- #io-channel-cells: must be 1, see ../iio-bindings.txt
> > have you considered using the thermal framework [0] instead of the iio
> > framework (see below)?
>
> Question: why thermal, and not hwmon ? what's the main difference ?
this is what came to my mind why the thermal framework fits best (at
least based on my current knowledge):
a) the thermal-zones (see meson-gxm-khadas-vim2.dts for example) a
"thermal-sensors" property. so for active (with a fan) or passive (by
limiting the maximum frequency and thus the supply voltage) cooling we
need a thermal device anyways
b) the thermal bindings support multiple trip points. we can map them
to one of the four interrupts which the IP block can generate
c) defining a temperature where the chip will power off sounds like a
use-case which may be implemented by other thermal IP blocks (in other
words: maybe the thermal frameworks provides some generic property to
replace the "amlogic,critical-temperature" property)
d) as far as I know you can tell the thermal framework to create a
hwmon device with only a couple (5?) lines of code

as Guillaume has already shown we can implement c) with a custom
property, but that's not limited to the underlying framework (IIO,
hwmon, thermal, ...)

use-case d) is not a strong one because I'm using iio-hwmon to create
a hwmon device on the 32-bit SoCs.
however, together with case a) using an IIO driver is going to be more
difficult because currently there's "only" a "generic-adc-thermal"
binding (but not a "generic-iio-temperature-thermal" binding)

the initial driver version doesn't have to support everything I listed above.
however, I believe with the thermal framework we don't limit ourselves
to one use-case and can extend the driver in the future


Martin
