Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96EBBBD9E8
	for <lists+linux-iio@lfdr.de>; Wed, 25 Sep 2019 10:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391340AbfIYIcj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 25 Sep 2019 04:32:39 -0400
Received: from mail-io1-f52.google.com ([209.85.166.52]:38147 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388045AbfIYIcj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 25 Sep 2019 04:32:39 -0400
Received: by mail-io1-f52.google.com with SMTP id u8so11622168iom.5
        for <linux-iio@vger.kernel.org>; Wed, 25 Sep 2019 01:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BHSqfET/v0VOqVkRgYfeqgKZdLBryNUUngLfhvTg3eE=;
        b=Mvn+xFy1fsIUIn4KjRkB1jcDLVNlcbrjMuo777H8U2ogjy7MpktoZN4it0SCulFcjS
         F4yuMnUZAUpJKWQ5PYDcmJuDWzb+FW1LTIOQjBpdpT3glC3Bhg+o8d9BZVUVfyGOSdhR
         cidJtOJVwuxL74D6HIiRt+DC+pahQDIoXYDtwVEPYy/DI7IIKoSSm7k5dNq6yghQfKMe
         1TwMyHHJgemHj6Q4plTMm2od8/ie5IzTHUtfSyknzDPpS5Rg1i76AvJhe75KJiFLlMgt
         U4dZlVdSKZKF/9NqHs9TSRE93bEQGYMCDg+FkrQ7owqW5i9NVKI0PtqfkswuEosElCv5
         uVcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BHSqfET/v0VOqVkRgYfeqgKZdLBryNUUngLfhvTg3eE=;
        b=oA2/lLlnwqCMxUs7vJFiiEqR0VHCqx2+PsEW6ARtx5k+eoiyKO8NxS0u1v5l+V6zE1
         c1l1N/CbRkusLimFCvp3C1YoJkUkXNzemypPDaakUwUNKfmrejg809CLwr5u+PxivtAN
         0AhCVYHwimuYS8o5sx8S9czcfK2Osilqp6talB1WDnLx7M1DXviCDqA3oMXvIaqQcZHa
         pM59d4fEJycySCyhZMKKIaH2ky3ty4+pA8K4a8HSzQ7OyYSSyg+6TM3Z2CBmtHva8Nrk
         lpAfEVTIGY1V19ZKoZncyAjCNVZtSBH7yBHKTGdyi5axhxl7/YnwLthL1AhkqBqCbfRW
         iY6A==
X-Gm-Message-State: APjAAAXCTdQXxRICJxAm2X5AYhw4bvzAWI9tRvSDfHr73GiPrRk2Nzfz
        +sEv7kM/2ETnz/YRaBrTCUdPSH2YmAgsQVEgDIwxzg==
X-Google-Smtp-Source: APXvYqwH8uhlqnUXuE3lOBTiowf8S3XZZjuT45gaRADxfhmLKcFmYQiPYbXC5mi1JnmvxHCMyA0/Z8H2D3iLazRE35c=
X-Received: by 2002:a5e:960f:: with SMTP id a15mr513194ioq.13.1569400358384;
 Wed, 25 Sep 2019 01:32:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190925081836.GA22717@SARKAR>
In-Reply-To: <20190925081836.GA22717@SARKAR>
From:   Crt Mori <cmo@melexis.com>
Date:   Wed, 25 Sep 2019 10:32:02 +0200
Message-ID: <CAKv63utZ+JSL=PH10bQdCYbrzoy0XBc_+UrVNFwTS2dkyjjxOw@mail.gmail.com>
Subject: Re: Hardware prerequisites for driver development
To:     Rohit Sarkar <rohitsarkar5398@gmail.com>
Cc:     Linux Iio <linux-iio@vger.kernel.org>,
        linux-newbie@vger.kernel.org,
        driverdev-devel@linuxdriverproject.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Rohit,
There are many companies for hobbyists which sell sensors included in
IIO subsystem and for sure some electronic component store in your
local area. Price of sensor can be from 0.10 USD to 10 USD. Then you
plug this sensor to your Linux board (Beaglebone Black is Linux
Foundation preferred, although there are others including Raspberry PI
- can even be RPI Zero if you are on a budget, Odroid, Linaro, ...)
and you will need to provide correct voltage/current for the sensor.
Easiests is that you pick sensors which are 3.3V or 5V domains,
because you have pins on most Linux boards with this voltages and
these pins supply enough current for most iio sensors. Then you just
connect (wire) power pin on sensor to power pin on your board, and
then communication pins from sensor to board and ground from sensor to
board. Some addition into dts will be needed for the Linux to know
where your sensor is connected at, but then it should work as
plug-and-play.

I hope I did not miss too many steps in between :)

Crt



On Wed, 25 Sep 2019 at 10:18, Rohit Sarkar <rohitsarkar5398@gmail.com> wrote:
>
> Hi,
> This is probably a real rookie question.
> I have been interested in contributing to the driver subsystems such as
> iio. I have submitted some minor patches but nothing substantial.
> I feel that I need some hardware to be able to contribute more.
> What hardware would I need to get started?
> Where would I get this from?
>
> Thanks,
> Rohit
