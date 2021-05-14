Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2636C380584
	for <lists+linux-iio@lfdr.de>; Fri, 14 May 2021 10:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhENIvZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 14 May 2021 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbhENIvY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 14 May 2021 04:51:24 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB1CC061574;
        Fri, 14 May 2021 01:50:13 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id g6-20020a17090adac6b029015d1a9a6f1aso1037393pjx.1;
        Fri, 14 May 2021 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/mf2zMafJkj9eoIMS1YmkskGPmsR52oU07pASiKj6k=;
        b=lnU6/jpxoP/qIjjbj066k9U9gMwWnRWvK4DhIkar4FYnktHKS/Xr+2HL06179a1VE8
         tXIQK9cf7cJ3G7XCDxCNfRiOYGlbTacTkbXbYLkmtFi07YirGyhir1kST8OMS4emt0Os
         tghdi0bxEB8c8i/cEcUlhMg0f5NZi3t33jn8sNgfgs0jjP1h9ZOy/CQ5ZdTGW/EIFOrf
         Y7VRj7/NXO7skszZ8Ivaip8Nrl/boje0Bps9MUlbZK90UVmGs+4XeGyyx23G1joZU+SZ
         rwv53+6OuncNgtlGa9uGR97lZ+dv/HhluVarboSF7DfkR314XDucruhrn6HrpVtJbaS1
         bbUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/mf2zMafJkj9eoIMS1YmkskGPmsR52oU07pASiKj6k=;
        b=KlaofmWOF8ucoHTi1hTJtUWBTDSBFrUfSJarI3xiumFgo9z5zbwFAaPKrC/WAr7iIv
         ltWhaXyeK2vshjcA/oOBIFlZQbXJER5qgNmkG0tOpOQyrYIJkf85ZBQb+W+7SULH6S5V
         a5tLpzofpBwl24M2qh8mCxrNiSOl2vmas3m2pt9idIcRh1j8H50SJg8HbcQhR/oNQX7e
         5KlBeu8Je0dv5JRS1x/CIFpKjOMez4j7VAL3eLXhc5vei50cOsQLTV4MhNJWzY09fdmD
         Q9K94eh6srK1zQ7QFwbDBJWhwtLyBIFyTlAIE0lAKXM3ZwMx8J0M+f8C9UP56oxbBOOj
         Qb9Q==
X-Gm-Message-State: AOAM532j/UTcA7nXH5wDPfEsUWewIrf+pTPGl3pOP4clEBmQCJK1fJLv
        uxmk8OBpqf5YEyDD8phhZmqEuMSvHdPhl/0GvCE=
X-Google-Smtp-Source: ABdhPJz77GRmKCm+Wk3NH93Ip//h8HJcdn++dz3MmqZmjDp0x/DWjrymU+0jdXJ5+CRBQM7px//sn1aN1OuwQq+tygo=
X-Received: by 2002:a17:902:ed97:b029:ee:af8e:3a0a with SMTP id
 e23-20020a170902ed97b02900eeaf8e3a0amr45942509plj.52.1620982212367; Fri, 14
 May 2021 01:50:12 -0700 (PDT)
MIME-Version: 1.0
References: <a50bce9fd6d28fa2aa0171ba406da0dd6714fcc3.1620926923.git.info@ministro.hu>
In-Reply-To: <a50bce9fd6d28fa2aa0171ba406da0dd6714fcc3.1620926923.git.info@ministro.hu>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Fri, 14 May 2021 11:50:00 +0300
Message-ID: <CA+U=DsrBcY0nameycswS9xdpQ3ziQSLnDZrpih76VcPz+qV4QQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: adc: driver for texas instruments ads7142
To:     Jozsef Horvath <info@ministro.hu>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        Saravanan Sekar <sravanhome@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, May 14, 2021 at 1:52 AM Jozsef Horvath <info@ministro.hu> wrote:
>
> This is an iio driver for
>  Texas Instruments ADS7142 dual-channel, programmable sensor monitor.
>

Hey,

Looks good overall.
Some comments inline.

> All of the data buffer modes, supported by the device are selectable
>  over sysfs:
>   /sys/bus/iio/devices/iio:deviceX/buffer_mode
>
> Data buffer operation modes:
>   - start_burst:
>     In triggered buffer preenable hook: not relevant.
>     In trigger handler: the driver selects the autonomous monitoring
>       (see chapter 7.4.3 in datasheet) operation mode,
>           configures the channels in sequencer as specified by
>       sysfs(scan_elements/in_voltageY_en),
>           sets the data buffer mode to "Start Burst Mode",
>       then starts the conversion.
>     In irq handler: the driver pushes the conversion results received
>       from the device to the buffer,
>       then restarts the conversion like in trigger handler.
>     Both IRQ and trigger are required to support this mode.
>     See chapter 7.4.3.2.1 "Autonomous Mode with Start Burst"
>     in datasheet.
>   - stop_burst:
>     In triggered buffer preenable hook: the driver selects the
>       autonomous monitoring (see chapter 7.4.3 in datasheet)
>       operation mode,
>       configures the channels in sequencer as
>       specified by sysfs(scan_elements/in_voltageY_en),
>           sets the data buffer mode to "Stop Burst Mode",
>       then starts the conversion.
>     In trigger handler: the driver pushes the conversion results received
>       from the device to the buffer,
>           then restarts the conversion like in preenable hook.
>     In irq handler: not relevant.
>     Trigger is required to support this mode.
>     See chapter 7.4.3.2.2 "Autonomous Mode with Stop Burst"
>     in datasheet.
>   - pre_alert:
>     In triggered buffer preenable hook: the driver selects the autonomous
>       monitoring (see chapter 7.4.3 in datasheet) operation mode,
>       configures the channels in sequencer
>         as specified by sysfs(scan_elements/in_voltageY_en),
>       configures the digital window comparator and alert flags,
>           sets the data buffer mode to "Pre Alert Data Mode",
>       then starts the conversion.
>     In trigger handler: not relevant.
>     In irq handler: the driver pushes the conversion results received
>       from the device to the buffer,
>       then restarts the conversion like in preenable hook.
>     IRQ is required to support this mode.
>     See chapter 7.4.3.1.1 "Autonomous Mode with Pre Alert Data"
>     in datasheet
>   - post_alert:
>     The operations are same like in pre_alert mode,
>       except the data buffer mode selection, the selected mode is
>       "Post Alert Data Mode".
>     See chapter 7.4.3.1.2 "Autonomous Mode with Post Alert Data"
>     in datasheet
>
> The in_voltageY_raw can be used, if the buffering mode is not enabled
>  in sysfs(buffer/enable).
>  The driver initiates a single conversion in the device for each
>  read request(in_voltageY_raw).
>  This is a one-shot conversion.
>  See chapter 7.4.2.2 "Manual Mode with AUTO Sequence" in datasheet.
>
> Datasheet: https://www.ti.com/lit/ds/symlink/ads7142.pdf
>
> Signed-off-by: Jozsef Horvath <info@ministro.hu>
> ---
>
> changes v1
>   - All of the buffer opertaion modes
>     (pre_alert, post_alert, start_burst, stop_burst)
>         are added
>   - Added triggered buffer
>   - Added buffer operation mode selection sysfs support
>   - Redundant parameters (ti,threshold-rising, etc.)
>     are removed
>   - Supply name changed(vref -> avdd)
>   - Added dvdd supply
>   - Added device sampling rate calculation
>   - Use device-managed functions for regulator, iio device register
>     and triggered buffer
> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ti-ads7142  |   11 +
>  MAINTAINERS                                   |    7 +
>  drivers/iio/adc/Kconfig                       |   13 +
>  drivers/iio/adc/Makefile                      |    1 +
>  drivers/iio/adc/ti-ads7142.c                  | 1469 +++++++++++++++++
>  5 files changed, 1501 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
>  create mode 100644 drivers/iio/adc/ti-ads7142.c
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> new file mode 100644
> index 000000000000..7de69a4819e5
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> @@ -0,0 +1,11 @@
> +What:          /sys/bus/iio/devices/iio:deviceX/buffer_mode_available
> +Date:          Maa 2021
> +KernelVersion: 5.13
> +Contact:       info@ministro.hu
> +Description:   List all available buffer_mode settings.
> +
> +What:          /sys/bus/iio/devices/iio:deviceX/buffer_mode
> +Date:          Maa 2021
> +KernelVersion: 5.13
> +Contact:       info@ministro.hu
> +Description:   Sets up the device data buffer mode.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba0cc0a67b32..9acc64ed54e1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18084,6 +18084,13 @@ T:     git git://github.com/czankel/xtensa-linux.git
>  F:     arch/xtensa/
>  F:     drivers/irqchip/irq-xtensa-*
>
> +TEXAS INSTRUMENTS ADS7142 ADC DRIVER
> +M:     Jozsef Horvath <info@ministro.hu>
> +S:     Maintained
> +F:     Documentation/ABI/testing/sysfs-bus-iio-adc-ti-ads7142
> +F:     Documentation/devicetree/bindings/iio/adc/ti,ads7142.yaml
> +F:     drivers/iio/adc/ti-ads7142.c
> +
>  TEXAS INSTRUMENTS ASoC DRIVERS
>  M:     Peter Ujfalusi <peter.ujfalusi@gmail.com>
>  L:     alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index db0c8fb60515..6c34ede355e4 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -1111,6 +1111,19 @@ config TI_ADS1015
>           This driver can also be built as a module. If so, the module will be
>           called ti-ads1015.
>
> +config TI_ADS7142
> +       tristate "Texas Instruments ADS7142 ADC driver"
> +       depends on I2C
> +       select IIO_BUFFER
> +       select IIO_TRIGGERED_BUFFER
> +       help
> +         This driver is for Texas Instruments ADS7142 Nanopower,
> +          Dual-Channel, Programmable Sensor Monitor.
> +         Say 'Y' here if you wish to use it.
> +
> +         To compile this driver as a module, choose M here: the
> +         module will be called ti-ads7142.
> +
>  config TI_ADS7950
>         tristate "Texas Instruments ADS7950 ADC driver"
>         depends on SPI && GPIOLIB
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index f70d877c555a..486ca7f4037e 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_TI_ADC108S102) += ti-adc108s102.o
>  obj-$(CONFIG_TI_ADC128S052) += ti-adc128s052.o
>  obj-$(CONFIG_TI_ADC161S626) += ti-adc161s626.o
>  obj-$(CONFIG_TI_ADS1015) += ti-ads1015.o
> +obj-$(CONFIG_TI_ADS7142) += ti-ads7142.o
>  obj-$(CONFIG_TI_ADS7950) += ti-ads7950.o
>  obj-$(CONFIG_TI_ADS8344) += ti-ads8344.o
>  obj-$(CONFIG_TI_ADS8688) += ti-ads8688.o
> diff --git a/drivers/iio/adc/ti-ads7142.c b/drivers/iio/adc/ti-ads7142.c
> new file mode 100644
> index 000000000000..ab49531933e1
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads7142.c
> @@ -0,0 +1,1469 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2021 Jozsef Horvath <info@ministro.hu>
> + *
> + */
> +#include <linux/i2c.h>
> +#include <linux/device.h>
> +#include <linux/interrupt.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
> +
> +#define TI_ADS7142_NAME                                        "ads7142"
> +
> +#define TI_ADS7142_DATA_VALID_TIMEOUT                  100
> +
> +/* Opcodes for commands */
> +/* General */
> +#define TI_ADS7142_OC_GENERAL                          0x00
> +/* Single Register Read */
> +#define TI_ADS7142_OC_SINGLE_REG_READ                  0x10
> +/* Single Register Write */
> +#define TI_ADS7142_OC_SINGLE_REG_WRITE                 0x08
> +/* Single Bit Set */
> +#define TI_ADS7142_OC_SET_BIT                          0x18
> +/* Single Bit Clear */
> +#define TI_ADS7142_OC_CLEAR_BIT                                0x20
> +/* Block Register Read */
> +#define TI_ADS7142_OC_BLOCK_READ                       0x30
> +/* Block Register Write */
> +#define TI_ADS7142_OC_BLOCK_WRITE                      0x28
> +
> +/* Registers */
> +/* Reset registers */
> +#define TI_ADS7142_WKEY                                        0x17
> +#define TI_ADS7142_DEVICE_RESET                                0x14
> +/* Functional mode select registers */
> +#define TI_ADS7142_OFFSET_CAL                          0x15
> +#define TI_ADS7142_OPMODE_SEL                          0x1C
> +#define TI_ADS7142_OPMODE_SEL_MANUALCH0                        (0)
> +#define TI_ADS7142_OPMODE_SEL_MANUALSEQ                        (4)
> +#define TI_ADS7142_OPMODE_SEL_MONITORING               (6)
> +#define TI_ADS7142_OPMODE_SEL_HIGHPREC                 (7)
> +#define TI_ADS7142_OPMODE_STATUS                       0x00
> +#define TI_ADS7142_OPMODE_STATUS_OPMODE_MSK            (3)
> +#define TI_ADS7142_OPMODE_STATUS_OPMODE_MANUAL         (0)
> +#define TI_ADS7142_OPMODE_STATUS_OPMODE_AUTO           (2)
> +#define TI_ADS7142_OPMODE_STATUS_OPMODE_HIGHPREC       (3)
> +#define TI_ADS7142_OPMODE_STATUS_HS_MODE               BIT(2)
> +
> +/* Input config register */
> +#define TI_ADS7142_CH_INPUT_CFG                                0x24
> +#define TI_ADS7142_CH_INPUT_CFG_TCSE                   (0)
> +#define TI_ADS7142_CH_INPUT_CFG_SCSE                   (1)
> +#define TI_ADS7142_CH_INPUT_CFG_SCPD                   (2)
> +/* Analog mux and sequencer registers */
> +#define TI_ADS7142_AUTO_SEQ_CHEN                       0x20
> +#define TI_ADS7142_AUTO_SEQ_CHEN_CH0                   BIT(0)
> +#define TI_ADS7142_AUTO_SEQ_CHEN_CH1                   BIT(1)
> +#define TI_ADS7142_START_SEQUENCE                      0x1E
> +#define TI_ADS7142_START_SEQUENCE_SEQ_START            BIT(0)
> +#define TI_ADS7142_ABORT_SEQUENCE                      0x1F
> +#define TI_ADS7142_ABORT_SEQUENCE_SEQ_ABORT            BIT(0)
> +#define TI_ADS7142_SEQUENCE_STATUS                     0x04
> +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK      (0x06)
> +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_DISABLED                (0x00)
> +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED         (0x02)
> +#define TI_ADS7142_SEQUENCE_STATUS_SEQ_ERROR           (0x06)
> +/* Oscillator and timing control registers */
> +#define TI_ADS7142_OSC_SEL                             0x18
> +#define TI_ADS7142_OSC_SEL_HSZ_LP                      BIT(0)
> +#define TI_ADS7142_NCLK_SEL                            0x19
> +#define TI_ADS7142_NCLK_SEL_MSK                                0xFF
> +/* Data buffer control register */
> +#define TI_ADS7142_DATA_BUFFER_OPMODE                  0x2C
> +#define TI_ADS7142_DATA_BUFFER_OPMODE_STOP_BURST       (0)
> +#define TI_ADS7142_DATA_BUFFER_OPMODE_START_BURST      (1)
> +#define TI_ADS7142_DATA_BUFFER_OPMODE_PRE_ALERT                (4)
> +#define TI_ADS7142_DATA_BUFFER_OPMODE_POST_ALERT       (6)
> +#define TI_ADS7142_DOUT_FORMAT_CFG                     0x28
> +#define TI_ADS7142_DOUT_FORMAT_CFG_12B                 (0)
> +#define TI_ADS7142_DOUT_FORMAT_CFG_12BCH               (1)
> +#define TI_ADS7142_DOUT_FORMAT_CFG_12BCHDV             (2)
> +#define TI_ADS7142_DATA_BUFFER_STATUS                  0x01
> +/* Accumulator control register */
> +#define TI_ADS7142_ACC_EN                              0x30
> +#define TI_ADS7142_ACC_CH0_LSB                         0x08
> +#define TI_ADS7142_ACC_CH0_MSB                         0x09
> +#define TI_ADS7142_ACC_CH1_LSB                         0x0A
> +#define TI_ADS7142_ACC_CH1_MSB                         0x0B
> +#define TI_ADS7142_ACC_STATUS                          0x02
> +/* Digital window comparator registers */
> +#define TI_ADS7142_ALERT_DWC_EN                                0x37
> +#define TI_ADS7142_ALERT_DWC_EN_BLOCK_EN               BIT(0)
> +#define TI_ADS7142_ALERT_CHEN                          0x34
> +#define TI_ADS7142_DWC_HTH_CH0_LSB                     0x38
> +#define TI_ADS7142_DWC_HTH_CH0_MSB                     0x39
> +#define TI_ADS7142_DWC_LTH_CH0_LSB                     0x3A
> +#define TI_ADS7142_DWC_LTH_CH0_MSB                     0x3B
> +#define TI_ADS7142_DWC_HYS_CH0                         0x40
> +#define TI_ADS7142_DWC_HTH_CH1_LSB                     0x3C
> +#define TI_ADS7142_DWC_HTH_CH1_MSB                     0x3D
> +#define TI_ADS7142_DWC_LTH_CH1_LSB                     0x3E
> +#define TI_ADS7142_DWC_LTH_CH1_MSB                     0x3F
> +#define TI_ADS7142_DWC_HYS_CH1                         0x41
> +#define TI_ADS7142_PRE_ALT_EVT_CNT                     0x36
> +#define TI_ADS7142_ALT_TRIG_CHID                       0x03
> +#define TI_ADS7142_ALT_LOW_FLAGS                       0x0C
> +#define TI_ADS7142_ALT_LOW_FLAGS_CH0                   BIT(0)
> +#define TI_ADS7142_ALT_LOW_FLAGS_CH1                   BIT(1)
> +#define TI_ADS7142_ALT_HIGH_FLAGS                      0x0E
> +#define TI_ADS7142_ALT_HIGH_FLAGS_CH0                  BIT(0)
> +#define TI_ADS7142_ALT_HIGH_FLAGS_CH1                  BIT(1)
> +
> +#define TI_ADS7142_THRESHOLD_MSK                       0xFFF
> +#define TI_ADS7142_HYSTERESIS_MSK                      0x3F
> +
> +#define TI_ADS7142_HSO_FREQ                            20000000
> +#define TI_ADS7142_HSO_NCLK_MIN                                21
> +#define TI_ADS7142_HSO_NCLK_MAX                                255
> +#define TI_ADS7142_HSO_MIN_SS                          78431
> +#define TI_ADS7142_HSO_MAX_SS                          952380
> +#define TI_ADS7142_LPO_FREQ                            10504
> +#define TI_ADS7142_LPO_NCLK_MIN                                18
> +#define TI_ADS7142_LPO_NCLK_MAX                                255
> +#define TI_ADS7142_LPO_MIN_SS                          41
> +#define TI_ADS7142_LPO_MAX_SS                          583
> +
> +#define TI_ADS7142_CHANNEL_COUNT                       2
> +
> +struct ti_ads7142_channel_config {
> +       bool alert_low;
> +       bool alert_high;
> +       int high_threshold;
> +       int low_threshold;
> +       int hysteresis;
> +};
> +
> +struct ti_ads7142_channel {
> +       struct ti_ads7142_channel_config config;
> +       u32 channel;
> +};
> +
> +struct ti_ads7142_config {
> +       bool osc_sel;
> +       u32 n_clk;
> +       int buffer_mode;
> +};
> +
> +struct ti_ads7142_priv {
> +       struct mutex lock; /* For syncing access to device */
> +       struct regulator *avdd;
> +       struct regulator *dvdd;
> +       struct ti_ads7142_config config;
> +       struct ti_ads7142_channel *channels;
> +       u16 *scan_data;
> +       bool irq_present;
> +       bool monitor_pending;
> +};
> +
> +static const struct iio_event_spec ti_ads7142_events[] = {
> +       {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_RISING,
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE)
> +                               | BIT(IIO_EV_INFO_ENABLE),
> +       }, {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_FALLING,
> +               .mask_separate = BIT(IIO_EV_INFO_VALUE)
> +                               | BIT(IIO_EV_INFO_ENABLE),
> +       }, {
> +               .type = IIO_EV_TYPE_THRESH,
> +               .dir = IIO_EV_DIR_EITHER,
> +               .mask_separate = BIT(IIO_EV_INFO_HYSTERESIS),
> +       },
> +};
> +
> +static const char * const ti_ads7142_ain_names[] = {
> +       "AIN0",
> +       "AIN1",
> +};
> +
> +#define TI_ADS7142_BUFFM_NONE                          0
> +#define TI_ADS7142_BUFFM_STOP_BURST                    1
> +#define TI_ADS7142_BUFFM_START_BURST                   2
> +#define TI_ADS7142_BUFFM_PRE_ALERT                     3
> +#define TI_ADS7142_BUFFM_POST_ALERT                    4
> +static const char * const ti_ads7142_buffer_modes[] = {
> +       [TI_ADS7142_BUFFM_NONE]         = "none",
> +       [TI_ADS7142_BUFFM_STOP_BURST]   = "stop_burst",
> +       [TI_ADS7142_BUFFM_START_BURST]  = "start_burst",
> +       [TI_ADS7142_BUFFM_PRE_ALERT]    = "pre_alert",
> +       [TI_ADS7142_BUFFM_POST_ALERT]   = "post_alert"
> +};
> +
> +static int ti_ads7142_reg_write(const struct i2c_client *client, u8 reg,
> +                               u8 data)
> +{
> +       u8 buf[3] = { TI_ADS7142_OC_SINGLE_REG_WRITE, reg, data };
> +       int ret;
> +
> +       ret = i2c_master_send(client, buf, sizeof(buf));
> +       if (ret >= 0 && ret != sizeof(buf))
> +               ret = -EIO;
> +
> +       return ret == sizeof(buf) ? 0 : ret;
> +}
> +
> +static int ti_ads7142_reg_read(const struct i2c_client *client, u8 reg,
> +                              u8 *data)
> +{
> +       u8 buf[2] = { TI_ADS7142_OC_SINGLE_REG_READ, reg };
> +       struct i2c_msg msg[2] = {
> +               {
> +                       .addr = client->addr,
> +                       .len = sizeof(buf),
> +                       .buf = buf,
> +               },
> +               {
> +                       .addr = client->addr,
> +                       .flags = I2C_M_RD,
> +                       .len = 1,
> +                       .buf = data,
> +               }
> +       };
> +       int ret;
> +
> +       ret = i2c_transfer(client->adapter, msg, 2);
> +       if (ret >= 0 && ret != ARRAY_SIZE(msg))
> +               ret = -EIO;
> +
> +       return ret == ARRAY_SIZE(msg) ? 0 : ret;
> +}
> +
> +static int ti_ads7142_data_buffer_read(const struct i2c_client *client,
> +                                      int length, void *data)
> +{
> +       int ret;
> +
> +       ret = i2c_master_recv(client, data, length);
> +       if (ret >= 0 && ret != length)
> +               ret = -EIO;
> +
> +       return ret == length ? 0 : ret;
> +}
> +
> +static int ti_ads7142_soft_reset(const struct i2c_client *client)
> +{
> +       u8 buf[2] = { TI_ADS7142_OC_GENERAL, 0x06 };
> +       int ret;
> +
> +       ret = i2c_master_send(client, buf, sizeof(buf));
> +       if (ret >= 0 && ret != sizeof(buf))
> +               ret = -EIO;
> +
> +       return ret == sizeof(buf) ? 0 : ret;
> +}
> +
> +static int ti_ads7142_address2channel(struct iio_dev *indio_dev,
> +                                     int address,
> +                                     struct ti_ads7142_channel **channel)

This could be simplified a bit to return "const struct
ti_ads7142_channel *" and then when NULL is returned, the caller
assumes -ENODEV.
Though, in  ti_ads7142_ist()  care should be taken to assign  ret =
-ENODEV; but that's only one place.


> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int i;
> +
> +       for (i = 0; i < indio_dev->num_channels; i++) {
> +               if (address == priv->channels[i].channel) {
> +                       *channel = &priv->channels[i];
> +                       return 0;
> +               }
> +       }
> +       return -ENODEV;
> +}
> +
> +static int ti_ads7142_sequence_start(struct iio_dev *indio_dev)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +
> +       return ti_ads7142_reg_write(client, TI_ADS7142_START_SEQUENCE,
> +                                   TI_ADS7142_START_SEQUENCE_SEQ_START);
> +}
> +
> +static int ti_ads7142_sequence_abort(struct iio_dev *indio_dev)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +
> +       return ti_ads7142_reg_write(client, TI_ADS7142_ABORT_SEQUENCE,
> +                                   TI_ADS7142_ABORT_SEQUENCE_SEQ_ABORT);
> +}
> +
> +static int ti_ads7142_osc_set(struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       int ret;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_OSC_SEL,
> +                                  priv->config.osc_sel ? TI_ADS7142_OSC_SEL_HSZ_LP : 0);
> +       if (ret)
> +               return ret;
> +
> +       return ti_ads7142_reg_write(client, TI_ADS7142_NCLK_SEL,
> +                                   priv->config.n_clk);
> +}
> +
> +static int ti_ads7142_input_cfg_set(struct iio_dev *indio_dev)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +
> +       return ti_ads7142_reg_write(client, TI_ADS7142_CH_INPUT_CFG,
> +                                   TI_ADS7142_CH_INPUT_CFG_TCSE);
> +}
> +
> +static int ti_ads7142_dout_format_set(struct iio_dev *indio_dev)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +
> +       return ti_ads7142_reg_write(client, TI_ADS7142_DOUT_FORMAT_CFG,
> +                                   TI_ADS7142_DOUT_FORMAT_CFG_12BCHDV);
> +}
> +
> +static int ti_ads7142_osc_calc_set(struct iio_dev *indio_dev, int request)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       bool osc_sel;
> +       u32 osc_freq;
> +
> +       if (request <= TI_ADS7142_LPO_MAX_SS) {
> +               osc_sel = true;
> +               if (request < TI_ADS7142_LPO_MIN_SS)
> +                       request = TI_ADS7142_LPO_MIN_SS;
> +               osc_freq = TI_ADS7142_LPO_FREQ;
> +       } else {
> +               osc_sel = false;
> +               if (request < TI_ADS7142_HSO_MIN_SS)
> +                       request = TI_ADS7142_HSO_MIN_SS;
> +               if (request > TI_ADS7142_HSO_MAX_SS)
> +                       request = TI_ADS7142_HSO_MAX_SS;
> +               osc_freq = TI_ADS7142_HSO_FREQ;
> +       }
> +
> +       priv->config.osc_sel = osc_sel;
> +       priv->config.n_clk = (osc_freq / request) & TI_ADS7142_NCLK_SEL_MSK;
> +       return 0;
> +}
> +
> +static int ti_ads7142_osc_calc_get(struct iio_dev *indio_dev, int *result)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       u32 n_clk;
> +       u32 osc_freq;
> +
> +       if (priv->config.osc_sel) {
> +               // Low power oscillator
> +               n_clk = priv->config.n_clk;
> +               if (n_clk < TI_ADS7142_LPO_NCLK_MIN)
> +                       n_clk = TI_ADS7142_LPO_NCLK_MIN;
> +               if (n_clk > TI_ADS7142_LPO_NCLK_MAX)
> +                       n_clk = TI_ADS7142_LPO_NCLK_MAX;
> +               osc_freq = TI_ADS7142_LPO_FREQ;
> +       } else {
> +               // High speed oscillator
> +               n_clk = priv->config.n_clk;
> +               if (n_clk < TI_ADS7142_HSO_NCLK_MIN)
> +                       n_clk = TI_ADS7142_HSO_NCLK_MIN;
> +               if (n_clk > TI_ADS7142_HSO_NCLK_MAX)
> +                       n_clk = TI_ADS7142_HSO_NCLK_MAX;
> +               osc_freq = TI_ADS7142_HSO_FREQ;
> +       }
> +       *result = osc_freq / n_clk;
> +       return 0;
> +}
> +
> +static int ti_ads7142_hth_set(struct iio_dev *indio_dev, int channel,
> +                             int threshold)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       int ret;
> +
> +       if (threshold < 0 || threshold > TI_ADS7142_THRESHOLD_MSK)
> +               return -EINVAL;
> +
> +       ret = ti_ads7142_reg_write(client,
> +                                  TI_ADS7142_DWC_HTH_CH0_LSB + channel * 4,
> +                                  threshold & 0xFF);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client,
> +                                  TI_ADS7142_DWC_HTH_CH0_MSB + channel * 4,
> +                                  (threshold >> 8) & 0xF);
> +       return ret;
> +}
> +
> +static int ti_ads7142_lth_set(struct iio_dev *indio_dev, int channel,
> +                             int threshold)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       int ret;
> +
> +       if (threshold < 0 || threshold > TI_ADS7142_THRESHOLD_MSK)
> +               return -EINVAL;
> +
> +       ret = ti_ads7142_reg_write(client,
> +                                  TI_ADS7142_DWC_LTH_CH0_LSB + channel * 4,
> +                                  threshold & 0xFF);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client,
> +                                  TI_ADS7142_DWC_LTH_CH0_MSB + channel * 4,
> +                                  (threshold >> 8) & 0xF);
> +       return ret;
> +}
> +
> +static int ti_ads7142_hys_set(struct iio_dev *indio_dev, int channel,
> +                             int hysteresis)
> +{
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       int ret;
> +
> +       if (hysteresis < 0 || hysteresis > TI_ADS7142_HYSTERESIS_MSK)
> +               return -EINVAL;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_DWC_HYS_CH0 + channel,
> +                                  hysteresis & TI_ADS7142_HYSTERESIS_MSK);
> +       return ret;
> +}
> +
> +static int ti_ads7142_buffered_setup_and_start(struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       struct ti_ads7142_channel *channel;
> +       int i;
> +       u8 alert_ch = 0;
> +       u8 buffer_op_mode;
> +       u8 seq_channels = 0;
> +       int ret;
> +
> +       if (!priv->config.buffer_mode)
> +               return 0;
> +
> +       priv->monitor_pending = false;
> +
> +       ret = ti_ads7142_sequence_abort(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_osc_set(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_input_cfg_set(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_dout_format_set(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       switch (priv->config.buffer_mode) {
> +       case TI_ADS7142_BUFFM_STOP_BURST:
> +               buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_STOP_BURST;
> +       break;
> +       case TI_ADS7142_BUFFM_START_BURST:
> +               buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_START_BURST;
> +       break;
> +       case TI_ADS7142_BUFFM_PRE_ALERT:
> +               buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_PRE_ALERT;
> +       break;

the indentation of the break; statements is a bit odd;
IIRC, they usually go aligned with the case block;
though i could be wrong;

> +       case TI_ADS7142_BUFFM_POST_ALERT:
> +               buffer_op_mode = TI_ADS7142_DATA_BUFFER_OPMODE_POST_ALERT;
> +       break;
> +       default:
> +               return -EINVAL;
> +       break;

also an unreachable statement

> +       }
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_DATA_BUFFER_OPMODE,
> +                                  buffer_op_mode);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_OPMODE_SEL,
> +                                  TI_ADS7142_OPMODE_SEL_MONITORING);
> +       if (ret)
> +               return ret;
> +
> +       for_each_set_bit(i, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               seq_channels |= 1 << i;
> +       }
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_AUTO_SEQ_CHEN,
> +                                  seq_channels);
> +       if (ret)
> +               return ret;
> +
> +       if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> +               goto seq_start;
> +
> +       /*
> +        * Pre and post alert settings
> +        */
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_PRE_ALT_EVT_CNT, 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_LOW_FLAGS,
> +                                  TI_ADS7142_ALT_LOW_FLAGS_CH0
> +                                  | TI_ADS7142_ALT_LOW_FLAGS_CH1);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_ALT_HIGH_FLAGS,
> +                                  TI_ADS7142_ALT_HIGH_FLAGS_CH0
> +                                  | TI_ADS7142_ALT_HIGH_FLAGS_CH1);
> +       if (ret)
> +               return ret;
> +
> +       for_each_set_bit(i, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               ret = ti_ads7142_address2channel(indio_dev, i,
> +                                                &channel);
> +               if (ret)
> +                       return ret;
> +
> +               ret = ti_ads7142_hth_set(indio_dev, channel->channel,
> +                                        channel->config.high_threshold);
> +               if (ret)
> +                       return ret;
> +
> +               ret = ti_ads7142_lth_set(indio_dev, channel->channel,
> +                                        channel->config.low_threshold);
> +               if (ret)
> +                       return ret;
> +
> +               ret = ti_ads7142_hys_set(indio_dev, channel->channel,
> +                                        channel->config.hysteresis);
> +               if (ret)
> +                       return ret;
> +
> +               if (channel->config.alert_low ||
> +                   channel->config.alert_high) {
> +                       alert_ch |= 1 << channel->channel;
> +               }
> +       }
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_ALERT_DWC_EN,
> +                                  alert_ch ? TI_ADS7142_ALERT_DWC_EN_BLOCK_EN : 0);
> +       if (ret)
> +               return ret;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_ALERT_CHEN,
> +                                  alert_ch);
> +       if (ret)
> +               return ret;
> +
> +       if (!alert_ch)
> +               return ret;

this looks the same as
          if (!alert_ch)
              return 0;
for a while, this looked like 'ret' was not initialized;

> +
> +seq_start:
> +       ret = ti_ads7142_sequence_start(indio_dev);
> +       priv->monitor_pending = !ret;
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_buffered_collect(struct iio_dev *indio_dev,
> +                                      int *channel_collected)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       int scan_channel_count;
> +       int have_valid_data;
> +       int data_valid;
> +       u16 data_buffer;
> +       u16 buffer[TI_ADS7142_CHANNEL_COUNT];
> +       u8 seq_channels = 0;
> +       int channel_address;
> +       int value;
> +       int i, j;
> +       int ret;
> +
> +       if (!priv->scan_data)
> +               return -EINVAL;
> +
> +       scan_channel_count = bitmap_weight(indio_dev->active_scan_mask,
> +                                          indio_dev->masklength);
> +       if (!scan_channel_count)
> +               return -EINVAL;
> +
> +       for_each_set_bit(i, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               seq_channels |= 1 << i;
> +       }
> +
> +       do {
> +               memset(priv->scan_data, 0x00, indio_dev->scan_bytes);
> +               have_valid_data = 0;
> +               for (i = 0; i < scan_channel_count; i++) {
> +                       ret = ti_ads7142_data_buffer_read(client,
> +                                                         sizeof(data_buffer),
> +                                                         &data_buffer);
> +                       if (ret)
> +                               return ret;
> +                       data_buffer = be16_to_cpu(data_buffer);
> +                       data_valid = data_buffer & 1;
> +                       if (!data_valid) {
> +                               ret = -ENOENT;
> +                               break;
> +                       }
> +
> +                       channel_address = (data_buffer >> 1) & 0x7;
> +                       if (!(seq_channels & 1 << channel_address)) {
> +                               dev_err(indio_dev->dev.parent,
> +                                       "%s: invalid channel address(%d)",
> +                                       __func__, channel_address);
> +                               return -EIO;
> +                       }
> +
> +                       value = data_buffer >> 4;
> +                       buffer[channel_address] = value;
> +                       have_valid_data = 1;
> +                       if (channel_collected)
> +                               *channel_collected |= 1 << channel_address;
> +               }
> +
> +               if (!have_valid_data)
> +                       continue;
> +
> +               j = 0;
> +               for_each_set_bit(i, indio_dev->active_scan_mask,
> +                                indio_dev->masklength) {
> +                       priv->scan_data[j] = buffer[i];
> +                       j++;
> +               }
> +               iio_push_to_buffers_with_timestamp(indio_dev, priv->scan_data,
> +                                                  iio_get_time_ns(indio_dev));
> +       } while (data_valid);
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_buffered_abort(struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret;
> +
> +       ret = ti_ads7142_sequence_abort(indio_dev);
> +       if (!ret)
> +               priv->monitor_pending = false;
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_manual_read(struct iio_dev *indio_dev,
> +                                 int address, int *val)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       u16 data_buffer;
> +       int ret;
> +
> +       mutex_lock(&priv->lock);
> +       ret = ti_ads7142_sequence_abort(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_osc_set(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_input_cfg_set(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_dout_format_set(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_OPMODE_SEL,
> +                                  TI_ADS7142_OPMODE_SEL_MANUALSEQ);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_reg_write(client, TI_ADS7142_AUTO_SEQ_CHEN,
> +                                  1 << address);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_sequence_start(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_data_buffer_read(client, sizeof(data_buffer),
> +                                         &data_buffer);
> +       if (ret)
> +               goto abort;
> +
> +       *val = (be16_to_cpu(data_buffer) >> 4);
> +
> +abort:
> +       ret = ti_ads7142_sequence_abort(indio_dev);
> +final:
> +       mutex_unlock(&priv->lock);
> +       return ret;
> +}
> +
> +static irqreturn_t ti_ads7142_ist(int irq, void *dev_id)
> +{
> +       struct iio_dev *indio_dev = dev_id;
> +       struct i2c_client *client = to_i2c_client(indio_dev->dev.parent);
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct ti_ads7142_channel *channel;
> +       u8 low_flags;
> +       u8 high_flags;
> +       u8 seq_st;
> +       int i;
> +       int ret;
> +       int channel_collected;
> +       s64 timestamp = iio_get_time_ns(indio_dev);
> +
> +       mutex_lock(&priv->lock);
> +       if (!priv->config.buffer_mode || !priv->monitor_pending) {
> +               mutex_unlock(&priv->lock);
> +               return IRQ_NONE;
> +       }
> +
> +       /*
> +        * BUSY/PDY fires when the sequence stopped in
> +        * trigger handler(ti_ads7142_trigger_handler),
> +        * if buffer mode is stop_burst, all the required
> +        * operations are in trigger handler, so irq handler
> +        * simple returns at this point.
> +        */
> +       if (priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> +               mutex_unlock(&priv->lock);
> +               return IRQ_NONE;
> +       }
> +
> +       ret = ti_ads7142_reg_read(client, TI_ADS7142_SEQUENCE_STATUS, &seq_st);
> +       if (ret) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: SEQUENCE_STATUS reg read error(%i)",
> +                       __func__, ret);
> +               goto final;
> +       }
> +
> +       if ((seq_st & TI_ADS7142_SEQUENCE_STATUS_SEQ_ERR_ST_MSK)
> +           != TI_ADS7142_SEQUENCE_STATUS_SEQ_ENABLED) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: SEQUENCE_STATUS error(%i)",
> +                       __func__, seq_st);
> +               goto final;
> +       }
> +
> +       ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_LOW_FLAGS,
> +                                 &low_flags);
> +       if (ret) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: ALT_LOW_FLAGS reg read error(%i)",
> +                       __func__, ret);
> +               goto final;
> +       }
> +
> +       ret = ti_ads7142_reg_read(client, TI_ADS7142_ALT_HIGH_FLAGS,
> +                                 &high_flags);
> +       if (ret) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: ALT_HIGH_FLAGS reg read error(%i)",
> +                       __func__, ret);
> +               goto final;
> +       }
> +
> +       ret = ti_ads7142_sequence_abort(indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       priv->monitor_pending = false;
> +
> +       channel_collected = 0;
> +       ret = ti_ads7142_buffered_collect(indio_dev, &channel_collected);
> +       if (ret && ret != -ENOENT) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: error(%d) when collecting result for %s mode",
> +                       __func__, ret,
> +                       ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> +               goto final;
> +       }
> +
> +       if (ret == -ENOENT)
> +               ret = 0;
> +
> +       if (!channel_collected)
> +               goto final;
> +
> +       if (priv->config.buffer_mode < TI_ADS7142_BUFFM_PRE_ALERT)
> +               goto final;
> +
> +       for_each_set_bit(i, indio_dev->active_scan_mask,
> +                        indio_dev->masklength) {
> +               ret = ti_ads7142_address2channel(indio_dev, i,
> +                                                &channel);
> +               if (ret)
> +                       goto final;
> +
> +               if (!(channel_collected & (1 << channel->channel)))
> +                       continue;
> +               if (channel->config.alert_low &&
> +                   (low_flags & (1 << channel->channel))) {
> +                       iio_push_event(indio_dev,
> +                                      IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +                                                           i,
> +                                                           IIO_EV_TYPE_THRESH,
> +                                                           IIO_EV_DIR_FALLING),
> +                                      timestamp);
> +               }
> +
> +               if (channel->config.alert_high &&
> +                   (high_flags & (1 << channel->channel))) {
> +                       iio_push_event(indio_dev,
> +                                      IIO_UNMOD_EVENT_CODE(IIO_VOLTAGE,
> +                                                           i,
> +                                                           IIO_EV_TYPE_THRESH,
> +                                                           IIO_EV_DIR_RISING),
> +                                      timestamp);
> +               }
> +       }
> +
> +final:

This final label looks a bit busy.
Maybe an idea would be to have 2 labels, and depdending on 'ret' you
do "goto {err,out}_unlock":

out_unlock:
      if (priv->config.buffer_mode >= TI_ADS7142_BUFFM_PRE_ALERT) {
              ret = ti_ads7142_buffered_setup_and_start(indio_dev);
               if (ret) {
                      dev_err(indio_dev->dev.parent,
                              "%s: error(%d) when starting %s mode",
                              __func__, ret,

ti_ads7142_buffer_modes[priv->config.buffer_mode]);
                      goto err_unlock;
              }
      }
      mutex_unlock(&priv->lock);
      return IRQ_HANDLED;

err_unlock:
       mutex_unlock(&priv->lock);
       return IRQ_NONE;


> +       if (!ret && priv->config.buffer_mode >= TI_ADS7142_BUFFM_PRE_ALERT) {
> +               ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> +               if (ret) {
> +                       dev_err(indio_dev->dev.parent,
> +                               "%s: error(%d) when starting %s mode",
> +                               __func__, ret,
> +                               ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> +               }
> +       }
> +       mutex_unlock(&priv->lock);
> +       if (ret)
> +               return IRQ_NONE;
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ti_ads7142_read_raw(struct iio_dev *indio_dev,
> +                              struct iio_chan_spec const *chan,
> +                              int *val, int *val2, long info)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret;
> +
> +       switch (info) {
> +       case IIO_CHAN_INFO_RAW:
> +               if (iio_buffer_enabled(indio_dev))
> +                       return -EBUSY;
> +               ret = iio_device_claim_direct_mode(indio_dev);
> +               if (ret)
> +                       return ret;
> +               ret = ti_ads7142_manual_read(indio_dev, chan->address,
> +                                            val);
> +               if (!ret)
> +                       ret = IIO_VAL_INT;
> +               iio_device_release_direct_mode(indio_dev);
> +               return ret;
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               ti_ads7142_osc_calc_get(indio_dev, val);
> +               return IIO_VAL_INT;
> +       case IIO_CHAN_INFO_SCALE:
> +               if (IS_ERR(priv->avdd)) {
> +                       ret = -EINVAL;
> +               } else {
> +                       *val = regulator_get_voltage(priv->avdd) / 1000;
> +                       *val2 = chan->scan_type.realbits;
> +                       ret = IIO_VAL_FRACTIONAL_LOG2;
> +               }

purely stylistic change; but this could also be:

              if (IS_ERR(priv->avdd))
                  return -EINVAL

              *val = regulator_get_voltage(priv->avdd) / 1000;
              *val2 = chan->scan_type.realbits;
              return IIO_VAL_FRACTIONAL_LOG2;

> +               return ret;
> +       default:
> +               return -EINVAL;
> +       }
> +       return 0;

This "return 0;" looks like an unreachable statement.
Some GCC versions complain about it. Not sure which.

> +}
> +
> +static int ti_ads7142_write_raw(struct iio_dev *indio_dev,
> +                               struct iio_chan_spec const *chan,
> +                               int val, int val2, long mask)
> +{
> +       switch (mask) {
> +       case IIO_CHAN_INFO_SAMP_FREQ:
> +               return ti_ads7142_osc_calc_set(indio_dev, val);
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;

Also, an unreachale statement.

> +}
> +
> +static int ti_ads7142_read_event_value(struct iio_dev *indio_dev,
> +                                      const struct iio_chan_spec *chan,
> +                                      enum iio_event_type type,
> +                                      enum iio_event_direction dir,
> +                                      enum iio_event_info info,
> +                                      int *val, int *val2)
> +{
> +       struct ti_ads7142_channel *channel;
> +       int ret;
> +
> +       ret = ti_ads7142_address2channel(indio_dev, chan->address,
> +                                        &channel);
> +       if (ret)
> +               return ret;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               if (dir == IIO_EV_DIR_RISING)
> +                       *val = channel->config.high_threshold;
> +               else
> +                       *val = channel->config.low_threshold;
> +               return IIO_VAL_INT;
> +       case IIO_EV_INFO_HYSTERESIS:
> +               *val = channel->config.hysteresis;
> +               return IIO_VAL_INT;
> +       default:
> +               return -EINVAL;
> +       }
> +       return 0;

Also an unreachable statement.

> +}
> +
> +static int ti_ads7142_write_event_value(struct iio_dev *indio_dev,
> +                                       const struct iio_chan_spec *chan,
> +                                       enum iio_event_type type,
> +                                       enum iio_event_direction dir,
> +                                       enum iio_event_info info,
> +                                       int val, int val2)
> +{
> +       struct ti_ads7142_channel *channel;
> +       int ret;
> +
> +       ret = ti_ads7142_address2channel(indio_dev, chan->address,
> +                                        &channel);
> +       if (ret)
> +               return ret;
> +
> +       switch (info) {
> +       case IIO_EV_INFO_VALUE:
> +               if (val < 0 || val > TI_ADS7142_THRESHOLD_MSK) {
> +                       ret = -EINVAL;
> +               } else {
> +                       if (dir == IIO_EV_DIR_RISING)
> +                               channel->config.high_threshold = val;
> +                       else
> +                               channel->config.low_threshold = val;
> +               }
> +       break;
> +       case IIO_EV_INFO_HYSTERESIS:
> +               if (val < 0 || val > TI_ADS7142_HYSTERESIS_MSK)
> +                       ret = -EINVAL;
> +               else
> +                       channel->config.hysteresis = val;
> +       break;
> +       default:
> +               ret = -EINVAL;
> +       break;
> +       }
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_read_event_config(struct iio_dev *indio_dev,
> +                                       const struct iio_chan_spec *chan,
> +                                       enum iio_event_type type,
> +                                       enum iio_event_direction dir)
> +{
> +       struct ti_ads7142_channel *channel;
> +       int ret;
> +
> +       if (type != IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       ret = ti_ads7142_address2channel(indio_dev, chan->address,
> +                                        &channel);
> +       if (ret)
> +               return ret;
> +
> +       if (dir == IIO_EV_DIR_RISING)
> +               ret = channel->config.alert_high ? 1 : 0;
> +       else
> +               ret = channel->config.alert_low ? 1 : 0;
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_write_event_config(struct iio_dev *indio_dev,
> +                                        const struct iio_chan_spec *chan,
> +                                        enum iio_event_type type,
> +                                        enum iio_event_direction dir,
> +                                        int state)
> +{
> +       struct ti_ads7142_channel *channel;
> +       int ret;
> +
> +       if (type != IIO_EV_TYPE_THRESH)
> +               return -EINVAL;
> +
> +       ret = ti_ads7142_address2channel(indio_dev, chan->address,
> +                                        &channel);
> +       if (ret)
> +               return ret;
> +
> +       if (dir == IIO_EV_DIR_RISING)
> +               channel->config.alert_high = state;
> +       else
> +               channel->config.alert_low = state;
> +
> +       return ret;
> +}
> +
> +static const struct iio_info ti_ads7142_iio_info = {
> +       .read_raw               = ti_ads7142_read_raw,
> +       .write_raw              = ti_ads7142_write_raw,
> +       .read_event_value       = ti_ads7142_read_event_value,
> +       .write_event_value      = ti_ads7142_write_event_value,
> +       .read_event_config      = ti_ads7142_read_event_config,
> +       .write_event_config     = ti_ads7142_write_event_config,
> +};
> +
> +static int ti_ads7142_triggered_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret;
> +
> +       if (!priv->config.buffer_mode)
> +               return -EINVAL;
> +
> +       /*
> +        * Start/stop burst buffer modes requires trigger
> +        */
> +       if (priv->config.buffer_mode <= TI_ADS7142_BUFFM_START_BURST &&
> +           !indio_dev->trig) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: Start/stop burst buffer modes requires trigger",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       /*
> +        * Start burst and pre/post alert modes requires irq
> +        */
> +       if (priv->config.buffer_mode >= TI_ADS7142_BUFFM_START_BURST &&
> +           !priv->irq_present) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: Start burst and pre/post alert modes requires irq",
> +                       __func__);
> +               return -EINVAL;
> +       }
> +
> +       priv->scan_data = devm_krealloc(indio_dev->dev.parent,
> +                                       priv->scan_data,
> +                                       indio_dev->scan_bytes, GFP_KERNEL);

the scan_data doesn't look like it would be awefully big;
so, it could be static buffer on 'priv';
it should be marked with ____cacheline_aligned  though  [if moved on
the priv object].
though, i don't feel too strongly about moving it;


> +       if (!priv->scan_data)
> +               return -ENOMEM;
> +
> +       mutex_lock(&priv->lock);
> +       /*
> +        * Start burst mode started in trigger handler.
> +        * Sequencer aborted here, just for safe.
> +        */
> +       if (priv->config.buffer_mode == TI_ADS7142_BUFFM_START_BURST)
> +               ret = ti_ads7142_buffered_abort(indio_dev);
> +       else
> +               ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static int ti_ads7142_triggered_buffer_predisable(struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret = 0;
> +
> +       mutex_lock(&priv->lock);
> +       ti_ads7142_buffered_abort(indio_dev);
> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static const struct iio_buffer_setup_ops ti_ads7142_triggered_buffer_ops = {
> +       .preenable = &ti_ads7142_triggered_buffer_preenable,
> +       .predisable = &ti_ads7142_triggered_buffer_predisable,
> +};
> +
> +static irqreturn_t ti_ads7142_trigger_handler(int irq, void *p)
> +{
> +       struct iio_poll_func *pf = p;
> +       struct iio_dev *indio_dev = pf->indio_dev;
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret = 0;
> +
> +       mutex_lock(&priv->lock);
> +       if (priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST) {
> +               ret = ti_ads7142_buffered_abort(indio_dev);
> +               if (ret) {
> +                       dev_err(indio_dev->dev.parent,
> +                               "%s: error(%d) when aborting in %s mode",
> +                               __func__, ret,
> +                               ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> +               }
> +
> +               ret = ti_ads7142_buffered_collect(indio_dev, NULL);
> +               if (ret && ret != -ENOENT) {
> +                       dev_err(indio_dev->dev.parent,
> +                               "%s: error(%d) when collecting result for %s mode",
> +                               __func__, ret,
> +                               ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> +               }
> +
> +               if (ret == -ENOENT)
> +                       ret = 0;
> +       }
> +       if (!ret &&
> +           (priv->config.buffer_mode == TI_ADS7142_BUFFM_START_BURST ||
> +            priv->config.buffer_mode == TI_ADS7142_BUFFM_STOP_BURST)) {
> +               ret = ti_ads7142_buffered_setup_and_start(indio_dev);
> +               if (ret) {
> +                       dev_err(indio_dev->dev.parent,
> +                               "%s: error(%d) when starting %s mode",
> +                               __func__, ret,
> +                               ti_ads7142_buffer_modes[priv->config.buffer_mode]);
> +               }
> +       }
> +
> +       mutex_unlock(&priv->lock);
> +
> +       if (ret)
> +               return IRQ_NONE;

maybe doing 2 labels here (with goto err_unlock/out_unlock) would be
an idea here as well;

> +
> +       iio_trigger_notify_done(indio_dev->trig);
> +
> +       return IRQ_HANDLED;
> +}
> +
> +static int ti_ads7142_get_buffer_mode(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +
> +       return priv->config.buffer_mode;
> +}
> +
> +static int ti_ads7142_set_buffer_mode(struct iio_dev *indio_dev,
> +                                     const struct iio_chan_spec *chan,
> +                                     unsigned int mode)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret;
> +
> +       if (mode > TI_ADS7142_BUFFM_STOP_BURST && !priv->irq_present) {
> +               dev_err(indio_dev->dev.parent,
> +                       "%s: no irq(BUSY/RDY) specified, mode %s is not supported",
> +                       __func__, ti_ads7142_buffer_modes[mode]);
> +               return -EINVAL;
> +       }
> +
> +       ret = iio_device_claim_direct_mode(indio_dev);
> +       if (ret)
> +               return ret;
> +
> +       priv->config.buffer_mode = mode;
> +       iio_device_release_direct_mode(indio_dev);
> +       return 0;
> +}
> +
> +static const struct iio_enum ti_ads7142_buffer_modes_enum = {
> +       .items = ti_ads7142_buffer_modes,
> +       .num_items = ARRAY_SIZE(ti_ads7142_buffer_modes),
> +       .get = ti_ads7142_get_buffer_mode,
> +       .set = ti_ads7142_set_buffer_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info ti_ads7142_ext_info[] = {
> +       IIO_ENUM("buffer_mode", IIO_SHARED_BY_ALL,
> +                &ti_ads7142_buffer_modes_enum),
> +       {
> +               .name = "buffer_mode_available",
> +               .shared = IIO_SHARED_BY_ALL,
> +               .read = iio_enum_available_read,
> +               .private = (uintptr_t)&ti_ads7142_buffer_modes_enum,
> +       },
> +       { },

the comma can be removed here;
since it's a null terminator;

> +};
> +
> +static int ti_ads7142_parse_channel_config(struct device *dev,
> +                                          struct iio_dev *indio_dev)
> +{
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       struct fwnode_handle *channel_node;
> +       struct iio_chan_spec *iio_channels;
> +       struct iio_chan_spec *iio_channel;
> +       struct ti_ads7142_channel *ads_channel;
> +       int channel_index = 0;
> +       int channel_count;
> +       int ret;
> +
> +       channel_count = device_get_child_node_count(dev);
> +       if (!channel_count) {
> +               dev_err(dev, "dt: there is no channel definition");
> +               return -ENODEV;
> +       }
> +
> +       if (channel_count > TI_ADS7142_CHANNEL_COUNT) {
> +               dev_err(dev, "dt: invalid number of channel definitions");
> +               return -ENODEV;
> +       }
> +
> +       priv->channels = devm_kcalloc(dev, channel_count,
> +                                     sizeof(*priv->channels),
> +                                     GFP_KERNEL);
> +       if (!priv->channels)
> +               return -ENOMEM;

It looks to me that this device has up-to 2 channels.
For such a low channel count, it may make sense to just keep a static
table of iio_channels pointers [1].

> +
> +       indio_dev->num_channels = channel_count;
> +       iio_channels = devm_kcalloc(dev, channel_count, sizeof(*iio_channels),
> +                                   GFP_KERNEL);
> +       if (!iio_channels)
> +               return -ENOMEM;
> +
> +       indio_dev->channels = iio_channels;
> +
> +       device_for_each_child_node(dev, channel_node) {
> +               ads_channel = &priv->channels[channel_index];
> +
> +               ret = fwnode_property_read_u32(channel_node, "reg",
> +                                              &ads_channel->channel);
> +               if (ret) {
> +                       fwnode_handle_put(channel_node);
> +                       return ret;
> +               }
> +
> +               iio_channel = &iio_channels[channel_index];
> +               iio_channel->datasheet_name = ti_ads7142_ain_names[ads_channel->channel];
> +               iio_channel->type = IIO_VOLTAGE;
> +               iio_channel->indexed = 1;
> +               iio_channel->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +               if (!IS_ERR_OR_NULL(priv->avdd))
> +                       iio_channel->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
> +               iio_channel->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +               iio_channel->scan_type.sign = 'u';
> +               iio_channel->scan_type.realbits = 12;
> +               iio_channel->scan_type.storagebits = 16;
> +               iio_channel->scan_type.endianness = IIO_CPU;
> +               iio_channel->address = ads_channel->channel;
> +               iio_channel->scan_index = ads_channel->channel;
> +               iio_channel->channel = ads_channel->channel;
> +               iio_channel->event_spec = ti_ads7142_events;
> +               iio_channel->num_event_specs = ARRAY_SIZE(ti_ads7142_events);
> +               iio_channel->ext_info = ti_ads7142_ext_info;
> +
> +               ads_channel->config.high_threshold = TI_ADS7142_THRESHOLD_MSK;
> +               channel_index++;

Also, here I think it may make sense to keep a global const-static
table of iio_channel object-parameters.
Then it can be assigned to the iio_channels [1] pointer-list and then
to indio_dev->channels/num_channels.

> +       }
> +
> +       return 0;
> +}
> +
> +static int ti_ads7142_parse_config(struct device *dev,
> +                                  struct iio_dev *indio_dev)
> +{
> +       return ti_ads7142_parse_channel_config(dev, indio_dev);
> +}
> +
> +static void ti_ads7142_regulators_disable(void *data)
> +{
> +       struct ti_ads7142_priv *priv = data;
> +
> +       if (!IS_ERR_OR_NULL(priv->avdd))
> +               regulator_disable(priv->avdd);
> +       if (!IS_ERR_OR_NULL(priv->dvdd))
> +               regulator_disable(priv->dvdd);
> +}

So, I've also learned this the hard way, but the general rule of these
callbacks is one per resource.
Something like:

static void ti_ads7142_regulators_disable(void *reg)
{
        regulator_disable(reg);
}

Then some calls are needed for each regulator.
Also, IS_ERR() can be used instead of IS_ERR_OR_NULL()
{devm_}regulator_get() always returns non-NULL.


        priv->avdd = devm_regulator_get(&client->dev, "avdd");
        if (!IS_ERR(priv->avdd)) {
                ret = regulator_enable(priv->avdd);
                if (ret)
                        return ret;

                ret = devm_add_action_or_reset(&client->dev,
                                               ti_ads7142_regulators_disable,
                                               priv->avdd);
                if (ret)
                        return ret;
        }

        priv->dvdd = devm_regulator_get(&client->dev, "dvdd");
        if (!IS_ERR(priv->dvdd)) {
                ret = regulator_enable(priv->dvdd);
                if (ret)
                        return ret;

                ret = devm_add_action_or_reset(&client->dev,
                                               ti_ads7142_regulators_disable,
                                               priv->dvdd);
                if (ret)
                        return ret;
        }


> +
> +static int ti_ads7142_probe(struct i2c_client *client,
> +                           const struct i2c_device_id *id)
> +{
> +       struct iio_dev *indio_dev;
> +       struct ti_ads7142_priv *priv;
> +       int ret;
> +
> +       indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*priv));
> +       if (!indio_dev)
> +               return -ENOMEM;
> +
> +       i2c_set_clientdata(client, indio_dev);
> +       priv = iio_priv(indio_dev);
> +
> +       /**
> +        * starting from v5.9-rc1 iio_device_alloc
> +        *  sets indio_dev->dev.parent, but older versions not :(
> +        **/
> +       if (!indio_dev->dev.parent)
> +               indio_dev->dev.parent = &client->dev;
> +       indio_dev->name = TI_ADS7142_NAME;
> +       indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +       indio_dev->info = &ti_ads7142_iio_info;
> +
> +       priv->avdd = devm_regulator_get(&client->dev, "avdd");
> +       if (!IS_ERR_OR_NULL(priv->avdd)) {
> +               ret = regulator_enable(priv->avdd);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       priv->dvdd = devm_regulator_get(&client->dev, "dvdd");
> +       if (!IS_ERR_OR_NULL(priv->dvdd)) {
> +               ret = regulator_enable(priv->dvdd);
> +               if (ret)
> +                       goto final;
> +       }
> +
> +       ret = devm_add_action_or_reset(&client->dev,
> +                                      ti_ads7142_regulators_disable,
> +                                      priv);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_soft_reset(client);
> +       if (ret)
> +               goto final;
> +
> +       ret = ti_ads7142_parse_config(&client->dev, indio_dev);
> +       if (ret)
> +               goto final;
> +
> +       mutex_init(&priv->lock);
> +
> +       if (client->irq) {
> +               ret = devm_request_threaded_irq(&client->dev, client->irq,
> +                                               NULL, ti_ads7142_ist,
> +                                               IRQF_ONESHOT | IRQF_SHARED,
> +                                               dev_name(&client->dev),
> +                                               indio_dev);
> +               if (ret) {
> +                       dev_err(&client->dev, "Unable to request IRQ %i",
> +                               client->irq);
> +                       goto final;
> +               }
> +               priv->irq_present = true;
> +       }
> +
> +       ret = devm_iio_triggered_buffer_setup(&client->dev,
> +                                             indio_dev,
> +                                             &iio_pollfunc_store_time,
> +                                             &ti_ads7142_trigger_handler,
> +                                             &ti_ads7142_triggered_buffer_ops);
> +       if (ret)
> +               goto final;
> +
> +       ret = devm_iio_device_register(&client->dev, indio_dev);

Usually "return devm_iio_device_register(&client->dev, indio_dev);" is
sufficient.
The rest is syslog spam.

> +       if (ret) {
> +               dev_err(&client->dev, "Failed to register iio device");
> +               goto final;
> +       }
> +
> +       dev_info(&client->dev, "%s is a %s device at address 0x%X",
> +                dev_name(&indio_dev->dev), indio_dev->name,
> +                client->addr);
> +final:

This 'final' label looks odd.
It looks like all 'goto final' calls in this function could be
replaced with 'return ret'
And the return below could be 'return 0;'


> +       return ret;
> +}
> +
> +static int __maybe_unused ti_ads7142_suspend(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +
> +       mutex_lock(&priv->lock);
> +       do {
> +               /*
> +                * Keep all regulators on when the device in autonomous
> +                *  monitoring mode.
> +                * The device can wake up the system with ALERT pin
> +                */
> +               if (priv->monitor_pending &&
> +                   (priv->config.buffer_mode == TI_ADS7142_BUFFM_PRE_ALERT ||
> +                    priv->config.buffer_mode == TI_ADS7142_BUFFM_POST_ALERT))
> +                       continue;
> +
> +               if (!IS_ERR_OR_NULL(priv->avdd))
> +                       regulator_disable(priv->avdd);
> +               if (!IS_ERR_OR_NULL(priv->dvdd))
> +                       regulator_disable(priv->dvdd);
> +       } while (0);
> +       mutex_unlock(&priv->lock);
> +
> +       return 0;
> +}
> +
> +static int __maybe_unused ti_ads7142_resume(struct device *dev)
> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct ti_ads7142_priv *priv = iio_priv(indio_dev);
> +       int ret = 0;
> +
> +       mutex_lock(&priv->lock);
> +       do {
> +               /*
> +                * Nothing to do when the device in autonomous monitoring mode.
> +                */
> +               if (priv->monitor_pending &&
> +                   (priv->config.buffer_mode == TI_ADS7142_BUFFM_PRE_ALERT ||
> +                    priv->config.buffer_mode == TI_ADS7142_BUFFM_POST_ALERT))
> +                       continue;
> +
> +               if (!IS_ERR_OR_NULL(priv->avdd)) {
> +                       ret = regulator_enable(priv->avdd);
> +                       if (ret)
> +                               continue;
> +               }
> +               if (!IS_ERR_OR_NULL(priv->dvdd)) {
> +                       ret = regulator_enable(priv->dvdd);
> +                       if (ret)
> +                               continue;
> +               }
> +       } while (0);

This while(0) loop looks a bit funky.
I understand why it's here; but it still looks a bit weird.

> +       mutex_unlock(&priv->lock);
> +
> +       return ret;
> +}
> +
> +static SIMPLE_DEV_PM_OPS(ti_ads7142_pm_ops, ti_ads7142_suspend,
> +                        ti_ads7142_resume);
> +
> +static const struct i2c_device_id ti_ads7142_id[] = {
> +       { TI_ADS7142_NAME, 0 },
> +       { }
> +};
> +MODULE_DEVICE_TABLE(i2c, ti_ads7142_id);
> +
> +static const struct of_device_id ti_ads7142_of_match[] = {
> +       { .compatible = "ti,ads7142" },
> +       {}
> +};
> +MODULE_DEVICE_TABLE(of, ti_ads7142_of_match);
> +
> +static struct i2c_driver ti_ads7142_driver = {
> +       .driver = {
> +               .name = TI_ADS7142_NAME,
> +               .of_match_table = ti_ads7142_of_match,
> +               .pm = &ti_ads7142_pm_ops,
> +       },
> +       .probe          = ti_ads7142_probe,
> +       .id_table       = ti_ads7142_id,
> +};
> +
> +module_i2c_driver(ti_ads7142_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Jozsef Horvath <info@ministro.hu>");
> +MODULE_DESCRIPTION("Texas Instruments ADS7142 ADC driver");
> --
> 2.17.1
>
>
