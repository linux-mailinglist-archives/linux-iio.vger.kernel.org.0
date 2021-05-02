Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D291370EA6
	for <lists+linux-iio@lfdr.de>; Sun,  2 May 2021 20:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbhEBS5W (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 May 2021 14:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbhEBS5W (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 May 2021 14:57:22 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a01:238:4321:8900:456f:ecd6:43e:202c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B1EC06174A;
        Sun,  2 May 2021 11:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VBTTy7k+huYU3zxutkN/KQuF7HJDfyzE1NG/2AtC+u4=; b=XJJR8tFmyTGgOJrEguEHEBB5xv
        7DKOO2TuI/BBXPiAPxWDsts9fWuMnv9gFPap/2m6EAOH37MnV9tPt9XVS1xR77PtlcrI7sPp7l3Dt
        dDRYhLESFc3abF1JDkTWMebrX0uBoa00ygn56OjWrFFK7C4YzltSBBPnAPVOaRl7buwg=;
Received: from p200300ccff41ea001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:ff41:ea00:1a3d:a2ff:febf:d33a] helo=aktux)
        by mail.andi.de1.cc with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1ldHGS-0002Dz-HA; Sun, 02 May 2021 20:56:24 +0200
Date:   Sun, 2 May 2021 20:56:23 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-iio@vger.kernel.org, jic23@kernel.org,
        linux-hwmon@vger.kernel.org, jdelvare@suse.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>,
        letux-kernel@openphoenux.org
Subject: Re: [Q] tps65185 EPD PMIC temperature interface - which subsystem
Message-ID: <20210502205623.447e3853@aktux>
In-Reply-To: <88f0fb11-1021-32e7-272c-d2080d716690@roeck-us.net>
References: <20210430232404.26d60fef@aktux>
        <20210501030213.GA3198376@roeck-us.net>
        <20210501102101.087c1f1d@aktux>
        <88f0fb11-1021-32e7-272c-d2080d716690@roeck-us.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Score: -1.0 (-)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 1 May 2021 12:05:15 -0700
Guenter Roeck <linux@roeck-us.net> wrote:

[...]
> > Well, I try to give first some missing context. It is about temperature
> > compensation, not cooling vs. overheating protection. EPDs behave
> > different at different temperatures, so the driver needs a temperature
> > to compensate for it.
> > EPDs need also a bit more exotic voltages, so usually there is a
> > separate PMIC for them. Usually that PMIC can also deliver a
> > temperature. So drivers for that should consist of
> > - mfd (obvious)  
> 
> I would disagree. The presence of a thermal sensor does not make a chip
> a multi-function device. Many Ethernet controllers have thermal sensors
> nowadays. That doesn't make them multi-function devices.
> 
well, there is one difference here, the ethernet controllers have
probably thermal sensors for monitoring themself. Here is thermal
sensor is not intended to monitor the EPD PMIC itself. But yes, it
makes life easier if I do not need to have a mfd.

> > - regulator (also obvious)
> > - something for providing the temperature (and that "something" is not
> >   that clear to me as there are several subsystems dealing with
> >   temperature)
> >   
> There are distinct use cases. iio is for industrial io, thermal is for
> thermal management, and hwmon is to expose sensor data to userspace
> for hardware monitoring. Normally one would pick the (or a) primary
> use case and go from there.
> 
> For the tps65185, I could imagine using the thermal sensor for hardware
> monitoring, and I can imagine its use for thermal control. I don't really
> see a use case as industrial io.
> 
[...]

Industrial io would be if the main intention is to measure room
temperature.

> drivers/mmc/host/sdhci-omap.c seems to do something similar, and doesn't
> have trouble using a thermal zone for it.
> 
yes, that is similar.

> > Vendor kernels in the wild additionally provide temperature by abusing
> > the regulator API which is IMHO not acceptable.
> > 
> > But if that thing would in to the iio subsystem, I would simply be able
> > to use iio_channel_get() to get the sensor from the device tree and
> > iio_channel_read() to read values from it. There is a iio_hwmon and no
> > hwmon_iio, so if someone wants a hwmon interface for it, it would not
> > block anything.
> > 
> > The main point about writing this mail now is that I do not want to
> > submit a driver, spin some polishing rounds, then somebody says:"Please
> > go to subsystem Y, not X"
> >   
> 
> You seem to be set in going along the mfd/iio path, though, which is fine
> with me. It is not me you'll have to convince, after all.
> 
I am not that fixed anymore, you opened my eyes for alternatives.

Thanks a lot for your explanations and examples, that really has helped
me to understand things better.

Regards,
Andreas
