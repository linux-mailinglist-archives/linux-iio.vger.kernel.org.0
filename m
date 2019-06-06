Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56C5237D1B
	for <lists+linux-iio@lfdr.de>; Thu,  6 Jun 2019 21:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfFFTQt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 6 Jun 2019 15:16:49 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33865 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728504AbfFFTQt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 6 Jun 2019 15:16:49 -0400
Received: by mail-oi1-f196.google.com with SMTP id u64so2431795oib.1;
        Thu, 06 Jun 2019 12:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wGZZja4pj4ztNwQ9lR3/UUwJOv78Qh9P9Xjpyh0RQ78=;
        b=MlguHHFVeVF5g8EuutoY2+4e4/Pw0Jksvx2WO+YX4EXH/vrWpw8vSrRkHDsQ5pCprF
         VOOrYSbElvFQPDJ1pyFaOT1ZJsULnLmMJqy1IsxnVZdQ2TX7jIHv0e0ss70lh5ntGrCr
         9h5SGrKKopTt92DtlXKrgLixrRZN3HTlEp/DsazX5SMtFLNu/HDahe78SQy0E27BH+bd
         RxBmkb4hwXMColZk5JNlqwaiHmrUdxk+iPbBcJNiYM0JuHJkuGRnqrkSb2EDhX3CPXFR
         5vgsiGzCykpZt901hiOso3ha0jcf1ibamJ27d0TLyi7mkiDkAOrclJVHjLg6ZD6sw/qp
         a+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wGZZja4pj4ztNwQ9lR3/UUwJOv78Qh9P9Xjpyh0RQ78=;
        b=fHE53kWwp2M1AzeSg+QyuS5oCN8RL/wxiFyWqbL1Jjejw2/1uuXXlncvLX7JdWjhX8
         vMnLS+YP5J26ZWxAygTXaos5vjhpoMKIVhb31F4NX+82rmcLbBb7lPmLBLwtRdQV23CY
         fRD62P1AzCIMUAzF9aN8eJGZSdlYk8JzCzFJ7cJtuqEoeijrFWYyz+CpHsmtRmOx4FRe
         era8uIjj3pG8UiN2my5OLsCotTj11G4a3KL0bx/XSYUYpzF1uuBy21/1uEYjqLeSerGr
         5G4iQH2biJFyTCiQwvd7nJz331G5Y/3MJOO7+L3X/geF2l5J4HxZ6r3+NHotqIXETwxq
         vzbg==
X-Gm-Message-State: APjAAAXzEEZMYcU73JLCaV1dm5SU4GUn8PJr1G1slm/CrqBIVO1bE41S
        W+qrRVvWRDOcFpvWuq0V7fr8VQbGzmyTbejIq07weLQN
X-Google-Smtp-Source: APXvYqzC9WxN3NamhIGFHT81BAmrC45+rcidscjDt+KRt+ASEEUVD3u5cHxp97h+S4hAPTzsUEsNS5LmM87cdCqMsVQ=
X-Received: by 2002:aca:3545:: with SMTP id c66mr1176682oia.129.1559848608679;
 Thu, 06 Jun 2019 12:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190604144714.2009-1-glaroque@baylibre.com> <20190604144714.2009-2-glaroque@baylibre.com>
In-Reply-To: <20190604144714.2009-2-glaroque@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 6 Jun 2019 21:16:37 +0200
Message-ID: <CAFBinCBN4QC2tPDEQmTW_c+PP5yu2qoK5M1eSye=SmvpieKWQg@mail.gmail.com>
Subject: Re: [PATCH 1/3] Documentation: dt-bindings: add the Amlogic Meson
 Temperature Sensor
To:     Guillaume La Roque <glaroque@baylibre.com>
Cc:     jic23@kernel.org, khilman@baylibre.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Guillaume,

thank you for working on this!

On Tue, Jun 4, 2019 at 4:47 PM Guillaume La Roque <glaroque@baylibre.com> wrote:
>
> This adds the devicetree binding documentation for the Temperature
> Sensor found in the Amlogic Meson G12 SoCs.
> Currently only the G12A SoCs are supported.
so G12B is not supported (yet)?

> Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
> ---
>  .../iio/temperature/amlogic,meson-tsensor.txt | 31 +++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
>
> diff --git a/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> new file mode 100644
> index 000000000000..d064db0e9cac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/temperature/amlogic,meson-tsensor.txt
> @@ -0,0 +1,31 @@
> +* Amlogic Meson Temperature Sensor
> +
> +Required properties:
> +- compatible:  depending on the SoC and the position of the sensor,
> +               this should be one of:
> +               - "amlogic,meson-g12a-cpu-tsensor" for the CPU G12A SoC sensor
> +               - "amlogic,meson-g12a-ddr-tsensor" for the DDR G12A SoC sensor
> +               followed by the common :
> +               - "amlogic,meson-g12a-tsensor" for G12A SoC family
> +- reg:         the physical base address and length of the registers
> +- interrupts:  the interrupt indicating end of sampling
> +- clocks:      phandle identifier for the reference clock of temperature sensor
> +- #io-channel-cells: must be 1, see ../iio-bindings.txt
have you considered using the thermal framework [0] instead of the iio
framework (see below)?

> +- amlogic,ao-secure: phandle to the ao-secure syscon
the driver has some "u_efuse_off" access. do we need to get some
calibration values from the AO syscon or can we also fetch it from the
eFuse? you can look at arch/arm/boot/dts/meson8.dtsi where I'm passing
the temperature sensor calibration data to the SAR ADC (there's no
dedicated temperature sensor IP block prior to G12A) while reading the
data from the eFuse

> +Optional properties:
> +- amlogic,critical-temperature: temperature value in milli degrees Celsius
> +       to set automatic reboot on too high temperature
as far as I can tell the thermal framework supports multiple trip
points. I'm seeing this as a benefit because the hardware can raise
interrupts at four different temperatures (defined by the driver)

> +Example:
> +       cpu_temp: temperature-sensor@ff634800 {
> +               compatible = "amlogic,meson-g12a-cpu-tsensor",
> +                            "amlogic,meson-g12a-tsensor";
> +               reg = <0x0 0xff634800 0x0 0x50>;
> +               interrupts = <GIC_SPI 35 IRQ_TYPE_EDGE_RISING>;
> +               clocks = <&clkc CLKID_TS>;
> +               status = "okay";
as far as I know the dt-bindings should not have a status property in
the examples


Martin
