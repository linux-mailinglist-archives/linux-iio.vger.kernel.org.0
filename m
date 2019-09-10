Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 460D9AF2A4
	for <lists+linux-iio@lfdr.de>; Tue, 10 Sep 2019 23:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfIJVg6 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 10 Sep 2019 17:36:58 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:46346 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbfIJVg6 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 10 Sep 2019 17:36:58 -0400
Received: by mail-io1-f52.google.com with SMTP id d17so19156949ios.13
        for <linux-iio@vger.kernel.org>; Tue, 10 Sep 2019 14:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2+waLgqfXokGn77wkTtox3UdCuaNvFVIvAt2NqOQFL4=;
        b=Ie+5jAMM5Ei2TSNPzfFWakinlVdjxQyr5E2cGkSip7BfpFpoCKjVbBLh59hwkOdHgE
         vMyFuu/R1oYJIaF6ma9fDYhhwhGgt9Sb94COxCYKGLPw4gc25oJRFKDihdeXYVz4VQb/
         +JLLUAr8pI4/sTV1eBgd34ShlpJG33OtkjaOHAuiup2p72CxyeTQIMQ10mxLZSZwFY5Q
         JMziIfFZqdgnr5lW6A+ugJ6owO0OTVhlpCPZ8eQvN8edGO9P4uRrW8UGZcKRCLYazQ0P
         orVcEDRzykzp6sRd0pKiQ9IMt5NntjNa7m+y1Bhj13LIFnpAOqx6/d6tiSUAKwUQuz6+
         9KYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2+waLgqfXokGn77wkTtox3UdCuaNvFVIvAt2NqOQFL4=;
        b=E0ZYrrnGArBHh5uXTe3x7cghMYgux3RXjcZaD2a/f0Fob51TvvVaKewoqmPE/Nhp0l
         FVPgfUsdeSTMYBCvVEJFzTMK7IuPcwQzauAQp6aKPXmqX1WOcyQoqCTY8xI0AdlRojCP
         ydQn0NkliEWkJN191+Aih0MaKeIoAJ93piX1MaXs++uS4bJw0EllmZPn3a2xlePW3efy
         FnCWBCZzvwI2+S6sdy61NHLEab/hfc7JNzwk9D5+pSy2ueQgNJDcyGoV8IQpk7F9tMOa
         kNg0EoxtrRbzRXiQWzguRfzAvIBR4Iq3Pjeh2ig/SJAzDrMqZE2T2wpjuj4bDUm1w6VL
         X46w==
X-Gm-Message-State: APjAAAWlvC7Vasry9sySzRtOZV3oLXIDW6tYAJ21Qo1er6v/O31CU6cm
        JETE0KOm52Ipcyf7CNHGYjgnigyDAGViJ68OH/IB/n5seoY0zA==
X-Google-Smtp-Source: APXvYqxsQIio1amF7upYsfWemQfd69NZN5RjWZjLJ0YkiLI6CEiEa5kLxi7dNNserf+u0Ubg9fxEM+QoBL5KQBaNFr4=
X-Received: by 2002:a6b:db09:: with SMTP id t9mr836916ioc.211.1568151415671;
 Tue, 10 Sep 2019 14:36:55 -0700 (PDT)
MIME-Version: 1.0
References: <CALAE=UBN7ZPGTHB_jgSje0zG3mCvE8auW1FTrbjn=KbJzN_How@mail.gmail.com>
 <20190714161623.0127bbcb@archlinux>
In-Reply-To: <20190714161623.0127bbcb@archlinux>
From:   Bobby Jones <rjones@gateworks.com>
Date:   Tue, 10 Sep 2019 14:36:44 -0700
Message-ID: <CALAE=UBhLi=B09FZhZOO3PAsjVTPDP1kkH=AG4V5UrmC=wXhWg@mail.gmail.com>
Subject: Re: FXOS8700 Accelerometer/Magnetometer Support
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hello Jonathan and iio,

I've finally been able to circle back to this effort. I've spent some
time last week referencing the misc driver I linked to originally
while refactoring the BMI160 imu driver as a starting point (it
honestly just seemed like the simplest 2-sensor device) and am a
little stuck with the implementation.

When defining the iio_chan_spec structs that will be assigned to the
iio_dev.channels array, everything makes sense when the fxos8700 only
has 1 sensor enabled. It is my understanding that the
iio_info.read_raw function will be called with the type/channel and
the proper regmap calls I've set up will be made. Now my confusion
begins when considering how to support both devices enabled. According
to the datasheet this means that "hybrid" mode is enabled, which
halves the data rate and requires a single burst transaction to read
all of the output data registers. If any data output register is not
read, that data will be lost. So when the IIO subsystem calls on a
single channel for data and the unit is in hybrid mode I don't see how
I can avoid loss of data.

I'm assuming there is a different way I should be setting up the
iio_info and iio_chan_spec structs but I'm not sure how to go about
it. I believe this may have something to do with the
iio_info.read_raw_multi function and the
iio_chan_spec.info_mask_shared* fields. Can anyone provide input? If
it helps I've posted my wip at
https://github.com/Bobby-Soliis-Jones/iio_imu_fxos8700.

Thanks in advance!
Bobby Jones
