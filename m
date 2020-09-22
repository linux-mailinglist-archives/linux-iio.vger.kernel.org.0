Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57AD1274052
	for <lists+linux-iio@lfdr.de>; Tue, 22 Sep 2020 13:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgIVLCs (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Sep 2020 07:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIVLCs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Sep 2020 07:02:48 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B45C061755;
        Tue, 22 Sep 2020 04:02:48 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so10718977otl.9;
        Tue, 22 Sep 2020 04:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrvS5KIZ2nQwGS4d7z8Xaz8559QAzBmEAKS76SNI7ac=;
        b=PwMqQKXxEGR6+8YaAKDnmjPdm4BYptaFCDjFiJYH/NbqUGi3Q4DujTLWhcSyo6WzEe
         QYGhzvIidRxqdzrOXaf2YU85I/h7o+vi2mxHbW88huIR+HE6dZlaQDdHmQUYwptZLtJv
         xHezAvtdMsOBlPdKsB9r1gVDMtHs2FFH+2NrLanz52NVUvieqaGRvoeNmpefi6MV2+cy
         QBTDerzX2vLb8OEOkg9AeVVZPYnuJK8wQAY/qI4/tJbc4Vmx23GFEsGRIdhw/gsW4dzs
         jdZNaKhKnC/Gj0kW4wwn363HIM0ZyshfkCdTPMLkdNq+m9eZqMCNdsywIVaI9aP+6k1/
         I7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrvS5KIZ2nQwGS4d7z8Xaz8559QAzBmEAKS76SNI7ac=;
        b=A1PbbeHBx3dOvIB45e0mj/nDdAAsgTwkoo9m3cU5ik5clqoxYrgZdJMnTBwtnMBpET
         UMvKkaHa5Xb3E/kMCS2TFDrPvA9ICW4GzFMXt+VV3/pZy1G87DarZLFW8ljiymQsIYWA
         aXAiL2kIrpijUckQnZO7kts0eYFGZ5Nxd8fEBQrZjR1Kk0UZnPlJaduGiVs0uAGTKaTI
         q+CWdj9Sg7bTN0B/zVvXRAx5btvpbjKvx4HlT5jQXtdOoJt0KmL9rUZbNnmcZNIy3PeP
         1ry1GegE3aq//rjS4EY68A86tabd/fsYcmuI1EMuPWxhZonOCuph6wHYXPdgJlwpp9NW
         RnZg==
X-Gm-Message-State: AOAM532ZzWIF5oeb61z6me73ZMMZLYVdDhvKmmI7UoGY30GkTFemnO1S
        V8lBFzsPNEpb8+t/PIHibs7GSzokrr4MkiG7zbJYSQk4qNWqGA==
X-Google-Smtp-Source: ABdhPJxLIRaSE1BxLtYMbvjeKEuHdtLQvB+vyDR0w9aZXPUAx1vdDZHjpNA0LteuLrYLQ10Scg3E8vtIgv5EiXtPCzQ=
X-Received: by 2002:a9d:50a:: with SMTP id 10mr2300865otw.207.1600772567766;
 Tue, 22 Sep 2020 04:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200921102850.192224-1-alexandru.ardelean@analog.com>
In-Reply-To: <20200921102850.192224-1-alexandru.ardelean@analog.com>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 22 Sep 2020 14:02:36 +0300
Message-ID: <CA+U=DspC_W=j-eET38q1v+ytbntUXQwvUCBKx0DJ9hDGVtV-OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc ad9467: add support for AD9434 high-speed ADC
To:     Alexandru Ardelean <alexandru.ardelean@analog.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, Sep 21, 2020 at 1:29 PM Alexandru Ardelean
<alexandru.ardelean@analog.com> wrote:
>
> From: Michael Hennerich <michael.hennerich@analog.com>
>
> The AD9434 is a 12-bit monolithic sampling analog-to-digital converter
> (ADC) optimized for high performance, low power, and ease of use. The part
> operates at up to a 500 MSPS conversion rate and is optimized for
> outstanding dynamic performance in wideband carrier and broadband systems.
>
> All necessary functions, including a sample-and-hold and voltage reference,
> are included on the chip to provide a complete signal conversion solution.
> The VREF pin can be used to monitor the internal reference or provide an
> external voltage reference (external reference mode must be enabled through
> the SPI port).
>
> The ADC requires a 1.8 V analog voltage supply and a differential clock
> for full performance operation. The digital outputs are LVDS (ANSI-644)
> compatible and support twos complement, offset binary format, or Gray code.
> A data clock output is available for proper output data timing.
>
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/AD9434.pdf
>
> The driver supports the same register set as the AD9467, so the support for
> this chip is added to the 'ad9467' driver.

I'll probably do a V2 here.
I'd like to change a few things.

>
> Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
> ---
>  drivers/iio/adc/ad9467.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index f068256cfca9..aee3007ea3f2 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -76,6 +76,14 @@
>  /* AN877_ADC_REG_OUTPUT_DELAY */
>  #define AN877_ADC_DCO_DELAY_ENABLE             0x80
>
> +/*
> + * Analog Devices AD9434 12-Bit, 370/500 MSPS ADC
> + */
> +
> +#define CHIPID_AD9434                  0x6A
> +#define AD9434_DEF_OUTPUT_MODE         0x00
> +#define AD9434_REG_VREF_MASK           0xC0
> +
>  /*
>   * Analog Devices AD9467 16-Bit, 200/250 MSPS ADC
>   */
> @@ -85,6 +93,7 @@
>  #define AD9467_REG_VREF_MASK           0x0F
>
>  enum {
> +       ID_AD9434,
>         ID_AD9467,
>  };
>
> @@ -154,6 +163,13 @@ static const unsigned int ad9467_scale_table[][2] = {
>         {2300, 8}, {2400, 9}, {2500, 10},
>  };
>
> +static const unsigned int ad9434_scale_table[][2] = {
> +       {1600, 0x1C}, {1580, 0x1D}, {1550, 0x1E}, {1520, 0x1F}, {1500, 0x00},
> +       {1470, 0x01}, {1440, 0x02}, {1420, 0x03}, {1390, 0x04}, {1360, 0x05},
> +       {1340, 0x06}, {1310, 0x07}, {1280, 0x08}, {1260, 0x09}, {1230, 0x0A},
> +       {1200, 0x0B}, {1180, 0x0C},
> +};
> +
>  static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
>                                unsigned int *val, unsigned int *val2)
>  {
> @@ -182,11 +198,23 @@ static void __ad9467_get_scale(struct adi_axi_adc_conv *conv, int index,
>         },                                                              \
>  }
>
> +static const struct iio_chan_spec ad9434_channels[] = {
> +       AD9467_CHAN(0, 0, 12, 'S'),
> +};
> +
>  static const struct iio_chan_spec ad9467_channels[] = {
>         AD9467_CHAN(0, 0, 16, 'S'),
>  };
>
>  static const struct adi_axi_adc_chip_info ad9467_chip_tbl[] = {
> +       [ID_AD9434] = {
> +               .id = CHIPID_AD9434,
> +               .max_rate = 500000000UL,
> +               .scale_table = ad9434_scale_table,
> +               .num_scales = ARRAY_SIZE(ad9434_scale_table),
> +               .channels = ad9434_channels,
> +               .num_channels = ARRAY_SIZE(ad9434_channels),
> +       },
>         [ID_AD9467] = {
>                 .id = CHIPID_AD9467,
>                 .max_rate = 250000000UL,
> @@ -318,10 +346,14 @@ static int ad9467_preenable_setup(struct adi_axi_adc_conv *conv)
>
>  static int ad9467_setup(struct ad9467_state *st, unsigned int chip_id)
>  {
> +       st->output_mode = AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +
>         switch (chip_id) {
> +       case CHIPID_AD9434:
> +               st->output_mode |= AD9434_DEF_OUTPUT_MODE;
> +               return 0;
>         case CHIPID_AD9467:
> -               st->output_mode = AD9467_DEF_OUTPUT_MODE |
> -                                 AN877_ADC_OUTPUT_MODE_TWOS_COMPLEMENT;
> +               st->output_mode |= AD9467_DEF_OUTPUT_MODE;
>                 return 0;
>         default:
>                 return -ENODEV;
> @@ -404,6 +436,7 @@ static int ad9467_probe(struct spi_device *spi)
>  }
>
>  static const struct of_device_id ad9467_of_match[] = {
> +       { .compatible = "adi,ad9434", .data = &ad9467_chip_tbl[ID_AD9434], },
>         { .compatible = "adi,ad9467", .data = &ad9467_chip_tbl[ID_AD9467], },
>         {}
>  };
> --
> 2.25.1
>
