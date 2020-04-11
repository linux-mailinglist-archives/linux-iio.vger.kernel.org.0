Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608D91A58B9
	for <lists+linux-iio@lfdr.de>; Sun, 12 Apr 2020 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgDKXbx (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 11 Apr 2020 19:31:53 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:60361 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbgDKXbs (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 11 Apr 2020 19:31:48 -0400
X-Originating-IP: 86.202.105.35
Received: from localhost (lfbn-lyo-1-9-35.w86-202.abo.wanadoo.fr [86.202.105.35])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id C998520004;
        Sat, 11 Apr 2020 23:31:45 +0000 (UTC)
Date:   Sun, 12 Apr 2020 01:31:45 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Kamel Bouhara <kamel.bouhara@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH 0/3] Introduce a counter inkernel API
Message-ID: <20200411233145.GC3628@piout.net>
References: <20200406155806.1295169-1-kamel.bouhara@bootlin.com>
 <20200411172259.GB95806@icarus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411172259.GB95806@icarus>
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

On 11/04/2020 13:22:59-0400, William Breathitt Gray wrote:
> I'm not inherently opposed to adding an in-kernel API for the Counter
> subsystem, but I'm not sure yet if it's necessary for this particular
> situation.
> 
> Is the purpose of this driver to allow users to poll on the rotary
> encoder position value? If so, perhaps instead of an in-kernel API, the
> polling functionality should be added as part of the Counter subsystem;
> I can see this being a useful feature for many counter devices, and
> it'll keep the code contained to a single subsystem.
> 
> By the way, I'm going to be submitting a major update to the Counter
> subsystem code in the next couple weeks that isolates the sysfs code
> from the rest of the subsystem -- it'll likely affect the interface and
> code here -- so I'll probably wait to decide for certain until that
> patch lands; I anticipate it making things easier for you here after
> it's merged.
> 
> For now, I want to get a better high-level understanding about how users
> would interact with this driver to use the device (input_setup_polling
> is a new call for me). That should help me understand whether an
> in-kernel API is the best choice here.
> 

Well, the goal is not really polling the counters but mainly exposing
the correct userspace interface for the rotary encoders that are
connected to quadrature decoders.

The input driver is using polling because this reduces the complexity of
the patches but the ultimate goal is to also have interrupts working.

I'm pretty sure the in-kernel interface can also have other usages like
for example iio triggers. I could envision having to read an ADC after x
turns of a motor to check for the torque.

I also think that having the sysfs code separate would help as it could
be considered as one of the in-kernel interface user.

BTW, do you have plans to add a character device interface?

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
