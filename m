Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3C13E3215
	for <lists+linux-iio@lfdr.de>; Sat,  7 Aug 2021 01:20:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244751AbhHFXUe (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 6 Aug 2021 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbhHFXUe (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 6 Aug 2021 19:20:34 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7335BC0613CF
        for <linux-iio@vger.kernel.org>; Fri,  6 Aug 2021 16:20:17 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so24968438pjs.0
        for <linux-iio@vger.kernel.org>; Fri, 06 Aug 2021 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pdp7-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=A7MOmpgEuMZIGFZg74MXJEhJzrqICIrbDA0FiBYQvIg=;
        b=kSGP9IbkfYYngHWQosX1MsraPhjZaVpO6UTVPCKT9wHfvw7mzB2YryiFOsDM1nWpW0
         GaD1N3FbmCFVuNu7VREEpIe6sJZ6MgDpMOexmkcaCvgRa0zHHtejEchXkvacLmtnfdpQ
         GPRF+yqimEOX4Cp2n6pr4zQH0bF7NnJZcNEG6RkK6ufVtWHybZ7+9YxA/uSC56Eh9oIE
         QRz8ScJ3T6NHr3pgDP/r+N+qgBcCsfrcJoSOE+DdYAfEAA2pGaFFPruJu05/6JYNNN6J
         ASCjqBDT1h65b3vpyfh/DIVRfTRl5GQPp5QrtG8xtuibtvHL3lUUbsXnnEcMyDbyTHng
         YW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=A7MOmpgEuMZIGFZg74MXJEhJzrqICIrbDA0FiBYQvIg=;
        b=rRGGhcJHBrXzt7pToNaVHY8TarDbeCdJmZuh2vhqGjKhZ6OlU706RKyY0SFpHWVcBa
         DRna0WgEEC6L9Fb8La7GjRaRoPpQQb4QzcDUipsGMNkVdgo5om5Ct3JGIQiaeB+nUkKa
         aIu4nGrAjp4Gh+1yfreh7OiuXXQ8VBFnVHIJJrTvFB6OWuLQPlNASLxoAAtufqKUY00p
         giOpZTfF9hfUc1IXH/iOAolpU1OgcIfrx3bdVL07boocyhzklktZrZsg/QsJV/a9+nhf
         NIZdkFVjOATBJQhvGis84C/9KoeAbul00vrjRCzOuA0jnUA/m6MzRxjUys84eNXiCGc/
         1I8g==
X-Gm-Message-State: AOAM531P3BkQAi7AuwnEPvC/IVe6wVH0FRcusjRmylA8LrrFU6d1iloj
        ucSmQzjL/xre4hmmnwgPF8IXoQ==
X-Google-Smtp-Source: ABdhPJxawqr9WDdGGIylQyRMmCtfywTwhxnbmrhJNdsHRk8Qt/iS1TBQ9ZScOoiF+M3U37vo0eS4FQ==
X-Received: by 2002:a17:90a:e541:: with SMTP id ei1mr17039815pjb.190.1628292017053;
        Fri, 06 Aug 2021 16:20:17 -0700 (PDT)
Received: from x1 ([2601:1c0:4700:2330:53cd:ae60:170f:1d3e])
        by smtp.gmail.com with ESMTPSA id t12sm13233222pgo.56.2021.08.06.16.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 16:20:16 -0700 (PDT)
Date:   Fri, 6 Aug 2021 16:20:14 -0700
From:   Drew Fustini <drew@pdp7.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>
Cc:     linux-iio@vger.kernel.org
Subject: iio: temperature: ltc2983 probe failure
Message-ID: <20210806232014.GA81404@x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello - thank you for developing the LTC2983 driver. I am using that
part in a project connected a Zynq-7000 SoC. I first tested using spidev
and I was able to do channel assignment, start conversion and then read
the conversion result. In this test, it was channel 10 configured as a
single-ended direct ADC.

I next replaced spidev with this device tree node inside the spi0 node:

        sensor_ltc2983: ltc2983@0 {
                compatible = "adi,ltc2983";
                reg = <0>;
                spi-max-frequency = <4000000>;
                #address-cells = <1>;
                #size-cells = <0>;
                /* ADC0_DATA_RDY (H11) is connected to MIO GPIO[2]
                 * MIO GPIO[0] is GPIO 54 so MIO GPIO[2] is GPIO 56
		 * /
                interrupts = <56 IRQ_TYPE_EDGE_RISING>;
                interrupt-parent = <&gpio0>;

                adc10: adc@10 {
                        reg = <10>; /* channel 10 */
                        adi,sensor-type = <30>; /* direct adc */
                        adi,single-ended;
                };
        };

The ltc2983 driver probe then runs at boot, but the probe would always
fail. The cause is that ltc2983_setup() would return -ETIMEDOUT. From
drivers/iio/temperature/ltc2983.c:

1363 static int ltc2983_setup(struct ltc2983_data *st, bool assign_iio)
1364 {
1365         u32 iio_chan_t = 0, iio_chan_v = 0, chan, iio_idx = 0;
1366         int ret;
1367         unsigned long time;
1368
1369         /* make sure the device is up */
1370         time = wait_for_completion_timeout(&st->completion,
1371                                             msecs_to_jiffies(250));
1372
1373         if (!time) {
1374                 dev_err(&st->spi->dev, "Device startup timed out\n");
1375                 return -ETIMEDOUT;
1376         }

I found that if I comment out the "return -ETIMEDOUT" on line 1375 then
the drivers work fine. I can read from channel 10 okay:

  # cat /sys/devices/iio:device1/in_voltage0_raw
  4925

I have a logic analyzer connected to test points on all the traces going
to the LTC2983. At power up, the INTERRUPT line is low on and then goes
high after about 100 ms and stays high.  I believe that this is expected
per the datasheet [1] on page 9:

  INTERRUPT (Pin 37): This pin outputs a LOW when the device is busy 
  either during start-up or while a conversion cycle is in progress. 
  This pin goes HIGH at the conclusion of the start-up state or 
  conversion cycle.

From page 16:

  Start-Up. After power is applied to the LTC2983 (V DD > 2.6V), there
  is a 200ms wake up period. During this time, the LDO, charge pump, 
  ADCs, and reference are powered up and the internal RAM is initialized
  Once start-up is complete, the INTERRUPT pin goes HIGH and the command
  status register will return a value of 0x40 (Start bit=0, Done bit=1)
  when read.

Why does ltc2983_setup() call wait_for_completion_timeout()?

I do not think there would be anyway for wait_for_completion_timeout()
to succeed. I don't see a reason to expect that ltc2983_irq_handler()
would run. The handler is installed just prior to ltc2983_setup(). 

1468 static int ltc2983_probe(struct spi_device *spi)
1469 {
<snip>
1495         /*
1496          * let's request the irq now so it is used to sync the device
1497          * startup in ltc2983_setup()
1498          */
1499         ret = devm_request_irq(&spi->dev, spi->irq, ltc2983_irq_handler,
1500                                IRQF_TRIGGER_RISING, name, st);
1501         if (ret) {
1502                 dev_err(&spi->dev, "failed to request an irq, %d", ret);
1503                 return ret;
1504         }
1505
1506         ret = ltc2983_setup(st, true);
1507         if (ret)
1508                 return ret;

Why does the probe assume that that there would be a low to high
transistion on the INTERRUPT pin after calling devm_request_irq() and
before calling ltc2983_setup()?

I believe the transistion happens once ~200ms after power on (I see it
happen within 100 ms on logic anaylzer) and when conversion completes.
When I read in_voltage0_raw, I can see on the logic analzyer that the
INTERRUPT goes low when the conversion begins. It later goes high again
and the conversion result is read ok. This works as expected.

I could see using wait_for_completion_timeout() as way to sleep until
the chip startup period is over. However, -ETIMEDOUT should not be
returned in that case as it causes the probe to fail, even though the
chip is actually working ok.

I hope I have been able to explain what I am experiencing. I do have
detailed debug logging and logic analyzer catpures that I can share.
I wanted to first see if my concerns over wait_for_completion_timeout()
make sense or not.

Thank you,
Drew
