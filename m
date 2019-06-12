Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2C7641ECA
	for <lists+linux-iio@lfdr.de>; Wed, 12 Jun 2019 10:16:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbfFLIPt (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 12 Jun 2019 04:15:49 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:42749 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730629AbfFLIPt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 12 Jun 2019 04:15:49 -0400
X-Originating-IP: 92.184.112.14
Received: from localhost (unknown [92.184.112.14])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 568C224005D;
        Wed, 12 Jun 2019 08:15:35 +0000 (UTC)
Date:   Wed, 12 Jun 2019 10:15:33 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Ladislav Michl <ladis@linux-mips.org>
Cc:     linux-iio@vger.kernel.org,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Georg Ottinger <g.ottinger@abatec.at>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>
Subject: Re: [RFC] iio: adc: at91: fix acking DRDY irq (again)
Message-ID: <20190612081419.GM25472@piout.net>
References: <20190611115603.GA11086@lenoch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611115603.GA11086@lenoch>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 11/06/2019 13:56:03+0200, Ladislav Michl wrote:
> Driver also contains some code for TC triggers. How is that supposed to
> work? [**] The very same manual states in chapter 39.5.5:
>   "If one of the TIOA outputs is selected, the corresponding Timer Counter
>    channel must be programmed in Waveform Mode."
> There are two drivers touching TC: drivers/clocksource/timer-atmel-tcb.c
> and drivers/pwm/pwm-atmel-tcb.c, they seem to conflict each other and

They don't, they can work simultaneously, on different TCBs. I'm still
planning to rework pwm-atmel-tcb to switch it to the proper binding.

> none of them is anyhow related to ADC driver. Here it would seem
> appropriate to have TC MFD driver and allocate timers for ADC, PWM and
> clocksource from there.

No, MFD is way too late for clocksource, this would break some platforms.

However, there is definitively some timer framework that is missing to
allow handling of timers that are not used as clocksource/clockevent
devices. So indeed, there is a missing piece to make the TC trigger
work.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
