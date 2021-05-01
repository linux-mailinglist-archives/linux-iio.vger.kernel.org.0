Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0BC370666
	for <lists+linux-iio@lfdr.de>; Sat,  1 May 2021 10:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhEAIV5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 1 May 2021 04:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhEAIV5 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 1 May 2021 04:21:57 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4EDC06174A;
        Sat,  1 May 2021 01:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=OS//dJfPUEblU6DbP4b8oY9qxu9Htv5W8P3YQWiRCWw=; b=BwmjJZgaREoB96JPrwqq1AFFlQ
        eSZZJm2xt+WrjI+mx8LUykrPgaCupTF+qZb6xiVFDHU/LTyrvpbMf8Sbqa5KBJnboa+7C5U6JgP3i
        uvFf8A7ljG8qTqjcpSHQc3NHqNrz0lA/xa6maTVKWDvAMnLjh0BUyzfO3feOlTR5zFUo=;
Received: from p200300ccff2cbd001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff2c:bd00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1lcks2-0002TM-AX; Sat, 01 May 2021 10:21:02 +0200
Date:   Sat, 1 May 2021 10:21:01 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        letux-kernel@openphoenux.org
Subject: Re: [Q] tps65185 EPD PMIC temperature interface - which subsystem
Message-ID: <20210501102101.087c1f1d@aktux>
In-Reply-To: <20210501030213.GA3198376@roeck-us.net>
References: <20210430232404.26d60fef@aktux>
        <20210501030213.GA3198376@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 30 Apr 2021 20:02:13 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

> On Fri, Apr 30, 2021 at 11:24:04PM +0200, Andreas Kemnade wrote:
> > Hi,
> > 
> > I am going about to clean up stuff to further upstream support for my
> > ebook readers. One question arises about the temperature interface of
> > the EPD PMIC. Vendor code uses regulator_get_voltage in the EPDC
> > driver to read a temperature in celsius and provides temperature through
> > the regulator interface (besides sysfs/hwmon). That is ugly. But what
> > are the options, if a kernel consumer should be able to reference it via
> > devicetree phandle and read out from it? I see temperature sensors
> > both in the iio and the hwmon subsystem, but do not find a description
> > why these things are there. If I put it into the iio-subsystem
> > iio_channel_get() and friends can be used, if I understand things
> > correctly, there are no such functions in the hwmon subsystem, so I
> > would not be able to use it there. So the better choice is to put it
> > into the iio subsystem?
> >   
> 
> I am guessing a bit here since a lot of context is missing. Presumably
> there is a regulator driver. That regulator driver could register itself
> with the hwmon subsystem using [devm_]hwmon_device_register_with_info()
> and tell it to register a thermal zone sensor. It should then be possible
> to read the temperature of that sensor using thermal_zone_get_temp().
> 
Well, I try to give first some missing context. It is about temperature
compensation, not cooling vs. overheating protection. EPDs behave
different at different temperatures, so the driver needs a temperature
to compensate for it.
EPDs need also a bit more exotic voltages, so usually there is a
separate PMIC for them. Usually that PMIC can also deliver a
temperature. So drivers for that should consist of
- mfd (obvious)
- regulator (also obvious)
- something for providing the temperature (and that "something" is not
  that clear to me as there are several subsystems dealing with
  temperature)

 
And on EPD controller side I would like to be able to define (besides
other things) in the device tree
  epd-temperature = <&some_sensor>;

So your idea was to have that temperature sensor as a hwmon and
providing also a thermal_sensor. If I understand correcly that would
also require me to define a thermal zone where I can add the
thermal sensor and which I could then reference somewhere.
According to devicetree/bindings/thermal/thermal-zones.yaml defining
trip points is required. That does not make sense in this context So I
am wondering whether I am right there since it is not about
overheating but about compensation. And there is only a
thermal_zone_get_zone_by_name() but not a thermal_zone_get_sensor_by_name().
Maybe I am getting something wrong.
Vendor kernels in the wild additionally provide temperature by abusing
the regulator API which is IMHO not acceptable.

But if that thing would in to the iio subsystem, I would simply be able
to use iio_channel_get() to get the sensor from the device tree and
iio_channel_read() to read values from it. There is a iio_hwmon and no
hwmon_iio, so if someone wants a hwmon interface for it, it would not
block anything.

The main point about writing this mail now is that I do not want to
submit a driver, spin some polishing rounds, then somebody says:"Please
go to subsystem Y, not X"

Regards,
Andreas
