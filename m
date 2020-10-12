Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6628B60D
	for <lists+linux-iio@lfdr.de>; Mon, 12 Oct 2020 15:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389016AbgJLNUZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 12 Oct 2020 09:20:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388353AbgJLNUZ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 12 Oct 2020 09:20:25 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13C632078E
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 13:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602508824;
        bh=9l4YIqa8NBQp7plJ84iajuadQ/crixYsu8J8Uoa7/G8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vYAD5XLGe9KbesINex0JPIUZ2QJmPzFR3hkj1EcdDVA1kxeq51Ro/tFqU80ks8ZkA
         mz2bCcMVO41MkEBlSaLZ/dCzrpXaAGEPDRcWK+uGV6heNHRIDTE0RXHwQoNf+zFkvM
         4iY0Py6qHExcKSZepX0bhVQQp0RGGuAkX5ZjKwug=
Received: by mail-oi1-f182.google.com with SMTP id c13so18682151oiy.6
        for <linux-iio@vger.kernel.org>; Mon, 12 Oct 2020 06:20:24 -0700 (PDT)
X-Gm-Message-State: AOAM530SepQOCaDxulMEdGFS4ZM7nQNB21vwhrCb7c7qsc/fqU8mjCSp
        OHrX3/sviG+aFgNVV713/0WGb4XNiBpp/yhGew==
X-Google-Smtp-Source: ABdhPJwImGkOM2w2RtCqF730aJPPuOxzw22Owqae1V08MCNSW6NnTgJq3MoNsB98Ju2jh/WNvgS2YalILtt+hbf5OOY=
X-Received: by 2002:a05:6808:10e:: with SMTP id b14mr11133026oie.152.1602508823291;
 Mon, 12 Oct 2020 06:20:23 -0700 (PDT)
MIME-Version: 1.0
References: <20201011170749.243680-1-jic23@kernel.org>
In-Reply-To: <20201011170749.243680-1-jic23@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 12 Oct 2020 08:20:12 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK2wUcJgcCTswAU-eqqZDwMJUq5MuMWwwke_UZbtqXJHg@mail.gmail.com>
Message-ID: <CAL_JsqK2wUcJgcCTswAU-eqqZDwMJUq5MuMWwwke_UZbtqXJHg@mail.gmail.com>
Subject: Re: [PATCH 00/29] dt-bindings:iio: Another set of yaml conversions.
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sun, Oct 11, 2020 at 12:09 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> This set mostly consists of low hanging fruit along the way to converting
> all the existing IIO bindings.
>
> A few questions scattered throughout though.  Whilst my skills in these
> are hopefully improving it seems there are still plenty more corner
> cases that I'm not sure how to handle!  I'm sure I'll have forgotten
> something that I should already know as well.
>
> I'm expecting some of these to bounce due to changes of addresses etc.
> If I can't track down up to date emails, I'll switch them maintainer
> to myself on the basis I'll be reviewing any incoming changes for these
> anyway.
>
> Thanks,
>
> Jonathan
>
> Jonathan Cameron (29):
>   dt-bindings:iio:humidity:hdc100x Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:humidity:htu21 Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:humidity:st,hts221 yaml conversion.
>   dt-bindings:iio:humidity:dht11 yaml conversion
>   dt-bindings:iio:pressure:ms5637 Drop separate doc + add to
>     trivial-devices
>   dt-bindings:iio:pressure:murata,zpa2326 yaml conversion
>   dt-bindings:iio:pressure:meas,ms5611 yaml conversion.
>   dt-bindings:iio:pressure:hoperf,hp03 yaml conversion
>   dt-bindings:iio:proximity:semtech,sx9500 yaml conversion.
>   dt-bindings:iio:proximity:st,vl53l0x yaml conversion
>   dt-bindings:iio:proximity:ams,as3935 yaml conversion
>   dt-bindings:iio:dac:ti,dac5571 yaml conversion.
>   dt-bindings:iio:dac:ti,dac7311 yaml conversion
>   dt-bindings:iio:dac:ti,dac7512 yaml conversion
>   dt-bindings:iio:dac:ti,dac7612 yaml conversion
>   dt-bindings:iio:dac:ti,dac082s085 yaml conversion
>   dt-bindings:iio:dac:adi,ad7303 yaml conversion
>   dt-bindings:iio:dac:maxim,ds4424 yaml conversion
>   dt-bindings:iio:dac:fsl,vf610-dac yaml conversion
>   dt-bindings:iio:dac:microchip,mcp4725 yaml conversion
>   dt-bindings:iio:dac:maxim,max5821 yaml conversion
>   dt-bindings:iio:dac:nxp,lpc1850-dac yaml conversion.
>   dt-bindings:iio:dac:adi,ad5758 yaml conversion
>   dt-bindings:iio:temperature:melexis,mlx90614 yaml conversion
>   dt-bindings:iio:temperature:melexis,mlx90632 conversion to yaml
>   dt-bindings:iio:temperature:meas,tsys01 move to trivial-devices.yaml
>   dt-bindings:iio:temperature:maxim,max31856 yaml conversion.
>   dt-bindings:iio:temperature:maxim_thermocouple.txt to
>     maxim,max31855k.yaml
>   dt-bindings:iio:temperature:ti,tmp07 yaml conversion

For the series,

Reviewed-by: Rob Herring <robh@kernel.org>

Though, you didn't Cc the DT list so no semi-automated checks will run
which would have pointed out the problem Lars-Peter did.

Rob
