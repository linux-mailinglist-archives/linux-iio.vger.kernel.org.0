Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A574B77896E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Aug 2023 11:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjHKJIM (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Aug 2023 05:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHKJIM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Aug 2023 05:08:12 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A3D211C
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 02:08:11 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-583d63ca1e9so20268637b3.1
        for <linux-iio@vger.kernel.org>; Fri, 11 Aug 2023 02:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raspberrypi.com; s=google; t=1691744890; x=1692349690;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=liLW/nS6lNiVs7Mn3ykQKreqi50kVvFD0DECJxNhFVk=;
        b=i4m63y1134Kwii/iYQDy0q5giqzRxZAu0YyFSiwCXB++hdvlCUMOO+sN5ySaawRP4Y
         +HKzPExlNgVJdAiyZPxFopQXk8jnu3H0WwRFv1542ji+t0Dom6eK2De93MhuasbNGRa1
         vtlWPZiiJfN66UebIkYgmz3G6oQg9GQ2C7HXz7ZGZNY5KHCdVYsr9HiN7FHG8WKMR52i
         CFmZKCj8iL4+2MG+lkuUdkKOBQ4/e8FdcGfkCTWFQ55vdvHtGi3IjU3Y2f6VkrRqvaa7
         MBQdTjmI2gMOENEd4eRiHj0rq1qiBGmkrz7hE0cdVpCmk3zkUdQsskEV7d2MNTGUURys
         OtHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691744890; x=1692349690;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=liLW/nS6lNiVs7Mn3ykQKreqi50kVvFD0DECJxNhFVk=;
        b=GiJDxWx8RHt8FJuu3NjgnIuybLHdZWfiTHNkirryr6EmxjCXSABTuLTK0Li2zcSSW2
         I3Md1LUsHisjxtxmI0Nggjn7gCqoTjFfAYE973L1kq+E8LgR0KYfiAgVmDwESZtahRRU
         Sk2HyHkPyh0Aue5l0yblsWrnSkMRQX60Cc/3W+tfECcWupS1Mbci0Jp3pcg7JlsZTaDe
         1WWchQWo05GW/jvq5bj73+LrO5+MPg5vnQHXQsvGuauTtmQMQgO15+M6hhVDQkxkZAUg
         SYchbGicen73AG2cBL4XLoUKu68i8YZrObnC07YnIMKs1kqp2hlcNf55qYB7wyVpElXC
         BEvA==
X-Gm-Message-State: AOJu0YyFcHNWn7dNCDHtXMcAdDdSLdVmyZ2XZzTvVs6+gAce4hRcKxdz
        JE4ES2Tm28Poeiax9P0A8SUacTmoMdgdEh40d33Y7PMnVZi0Q7JBrIJrIQ==
X-Google-Smtp-Source: AGHT+IFJBa7drtmaWNpi9qpVHqFmas5+9ZlmgHWrYSUMdCvsnTdapuNcDdZAc9LcazLEEejpGtF2Wao0yDChBhyfnpo=
X-Received: by 2002:a81:a086:0:b0:571:bd3e:73ca with SMTP id
 x128-20020a81a086000000b00571bd3e73camr1318698ywg.16.1691744890738; Fri, 11
 Aug 2023 02:08:10 -0700 (PDT)
MIME-Version: 1.0
From:   Phil Elwell <phil@raspberrypi.com>
Date:   Fri, 11 Aug 2023 10:08:00 +0100
Message-ID: <CAMEGJJ3aiKUtTsHzVgbVEfiRUL+VV1zfc9-FoCRTjfWp4-=5ug@mail.gmail.com>
Subject: BMP180 (no) interrupt problem
To:     Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Jonathan and linux-iio,

I've run into a problem running a BMP180 over I2C - it's on a
Raspberry Pi, but I don't think that's particularly relevant. As it's
a BMP180 it has no interrupt signal, but it apparently shares an ID
with the BMP085 which does. As a result, the driver and bindings
sensibly treat the IRQ as optional.

The function bmp280_common_probe contains the following fragment:

/*
* Attempt to grab an optional EOC IRQ - only the BMP085 has this
* however as it happens, the BMP085 shares the chip ID of BMP180
* so we look for an IRQ if we have that.
*/
if (irq > 0 || (chip_id  == BMP180_CHIP_ID)) {
    ret = bmp085_fetch_eoc_irq(dev, name, irq, data);
    if (ret)
        return ret;
}

where the irq is passed in from the I2C or SPI framework. Inside
bmp085_fetch_eoc_irq it immediately does:

    irq_trig = irqd_get_trigger_type(irq_get_irq_data(irq));

irq_get_irq_data converts irq to an irqd, returning either a pointer
to the irq_data or a NULL. irq_get_trigger_type essentially just
indirects through the pointer to retrieve the irq_common_data pointer.

There is nothing to prevent irq from being 0, and in the case of a
BMP180 that is the expected value. This is where it gets strange: on
an ARCH=arm build I'm getting a valid-looking irq_data pointer back
for IRQ 0, but on ARCH=arm64 I get the more obvious NULL pointer,
leading to an exception.

I'm hesitant to suggest there's a bug in such old code, but I don't
understand why the condition in the probe function isn't:

    if (irq > 0 && (chip_id  == BMP180_CHIP_ID))

Do you have any thoughts?

Many thanks,

Phil Elwell
