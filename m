Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAE1C5EF32
	for <lists+linux-iio@lfdr.de>; Thu,  4 Jul 2019 00:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbfGCWje (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 3 Jul 2019 18:39:34 -0400
Received: from mail-io1-f51.google.com ([209.85.166.51]:33636 "EHLO
        mail-io1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbfGCWje (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 3 Jul 2019 18:39:34 -0400
Received: by mail-io1-f51.google.com with SMTP id u13so4392267iop.0
        for <linux-iio@vger.kernel.org>; Wed, 03 Jul 2019 15:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=apbpQgsM9P8RgKgguAMqOVPSIuY71JIGNQ9sYoq3x+A=;
        b=NVoQJL69txqMXIcHCUfLlO8wZLSGJ1M5yEBCzrpivMN7VFNTAnz4vaUK60P3Az1w6t
         2uCePRxIVJdCck6/1PLbAtk361XuytpdGLilZ1qir7wd2RYESHwdhy5m2wsmGgbsg5u9
         dQqdeXHncPN+cQYMKZ2SYAg4ENXfmathWKWIj+EqFMgzTBw59qDUiH9SW7c07A2sP2Sh
         FkeJ6bSkme7FQpM/JEEUi9EO1LXI4fxl1IY7ofYTjFmrV5scNZUwR/lv2bjn2JzShihF
         uT3VaXtvdbYdjptQI9bGZ8EO23GmO7p/jrRU4B9m0lDCvsWc3xQY0so7ehnKdlY7/QCQ
         tVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=apbpQgsM9P8RgKgguAMqOVPSIuY71JIGNQ9sYoq3x+A=;
        b=XAms7G1mDK9m9AIDDOGHrhI5/4f1eGlol1VhmIfRGcPXtnYCOINCjl/E2MpEmZuoAJ
         FzH9F24bkDi9qSfcCUNMvHpT0yGx43jBdgn5JMHNSGHsjbmrjfhov/cY5SZ8SvxPulqr
         YR8U1Qtp5XI1/4uj/CDDWMmDTH7Tt62+2vQjoKb1TPXqxwRfBNMKtOKj4o3T0IZCiRc4
         aTuvquNz0NtFL96XlSJZo2s/+Rd9TsZIpVIIpv4AuCe3KazBzZANAnC5Io9si8XfQF9b
         DjD4XtjWQMjr1YJeyUHZnn8Jiu+6oiEfhDOJsZCL5/erekFBrP0n1ZEo38Ip8ShW13rT
         HUjA==
X-Gm-Message-State: APjAAAWGRnUwDta7D7JvtZyeGMGYgsBYQb8AMoCStLa3OeLBDStrlLge
        P3F+mApfADSlmp72X8dZmFzZ0pxMk66uC6VpKayWO2tWE37p9Q==
X-Google-Smtp-Source: APXvYqwZm/Sym0Z6lZQ0PFHYoFXmkxQglByFctrOj+nbziZMHV+wVTVJFI8PHYAoRnxQ2TsMmOZYOFeUjc9EG87FFtA=
X-Received: by 2002:a6b:7311:: with SMTP id e17mr43988601ioh.112.1562193573016;
 Wed, 03 Jul 2019 15:39:33 -0700 (PDT)
MIME-Version: 1.0
From:   Bobby Jones <rjones@gateworks.com>
Date:   Wed, 3 Jul 2019 15:39:22 -0700
Message-ID: <CALAE=UDOxK=u_WH9dmGpd+NoCHwykbbQvxZLpW7MawoGes_gxA@mail.gmail.com>
Subject: FXOS8700 Accelerometer/Magnetometer Support
To:     linux-iio@vger.kernel.org, utkarsh.gupta@freescale.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Utkarsh and linux-iio,

I'm interested in adding support for the FXOS8700 accel/mag device. I
was curious if there had already been an effort in mainline to add
support and could not find anything in the latest pulled version of
the testing branch. However looking at the list archive I saw an email
back in 2015 from Utkarsh who asked about implementing a driver for
the same device [https://marc.info/?l=linux-iio&m=142920413702776]. My
question for Utkarsh and/or the greater linux-iio mailing list is if
there had been any further effort since then that I can help finish?

Otherwise as someone new to driver development in general, I'm looking
for any advice to get me started. I did see a NXP aka Freescale driver
[https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/misc/fxos8700.c?h=imx_4.19.35_1.0.0]
for the device but it doesn't appear to follow the iio api from what I
can tell. Is it worth taking that driver and trying to get it to fit
into the IMU api or should I start from scratch?

Thanks,
Bobby Jones
