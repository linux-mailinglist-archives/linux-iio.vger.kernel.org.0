Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 521BA33A709
	for <lists+linux-iio@lfdr.de>; Sun, 14 Mar 2021 17:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234049AbhCNQzi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Mar 2021 12:55:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:55980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhCNQzJ (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Mar 2021 12:55:09 -0400
Received: from archlinux (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9CA64DE1;
        Sun, 14 Mar 2021 16:55:07 +0000 (UTC)
Date:   Sun, 14 Mar 2021 16:55:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>,
        Robin van der Gracht <robin@protonic.nl>,
        linux-iio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v8 0/2] add support for GPIO or IRQ based event counter
Message-ID: <20210314165504.536d9ba6@archlinux>
In-Reply-To: <20210301080401.22190-1-o.rempel@pengutronix.de>
References: <20210301080401.22190-1-o.rempel@pengutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  1 Mar 2021 09:03:59 +0100
Oleksij Rempel <o.rempel@pengutronix.de> wrote:

> changes v8:
> - use use enum index instead of enum value for the counter function
> - register signal unconditionally and return error is signal revel is
>   read 
> 
> changes v7:
> - make most of structs dynamically allocatable to assign IRQ based
>   description to the signal
> - assign dev name instead for driver name to the IRQ
> 
> changes v6:
> - rename it to interrupt-counter
> - driver fixes
> - device tree fixes
> 
> changes v5:
> - rename it to event counter, since it support different event sources
> - make it work with gpio-only or irq-only configuration
> - update yaml binding
> 
> changes v4:
> - use IRQ_NOAUTOEN to not enable IRQ by default
> - rename gpio_ from name pattern and make this driver work any IRQ
>   source.
> 
> changes v3:
> - convert counter to atomic_t
> 
> changes v2:
> - add commas
> - avoid possible unhandled interrupts in the enable path
> - do not use of_ specific gpio functions
> 
> Add support for GPIO based pulse counter. For now it can only count
> pulses. With counter char device support, we will be able to attach
> timestamps and measure actual pulse frequency.
> 
> Never the less, it is better to mainline this driver now (before chardev
> patches go mainline), to provide developers additional use case for the counter
> framework with chardev support.
> 
> Oleksij Rempel (2):
>   dt-bindings: counter: add interrupt-counter binding
>   counter: add IRQ or GPIO based counter

Series applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan

> 
>  .../bindings/counter/interrupt-counter.yaml   |  62 +++++
>  MAINTAINERS                                   |   7 +
>  drivers/counter/Kconfig                       |  10 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/interrupt-cnt.c               | 244 ++++++++++++++++++
>  5 files changed, 324 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/counter/interrupt-counter.yaml
>  create mode 100644 drivers/counter/interrupt-cnt.c
> 

