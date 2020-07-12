Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B545F21C984
	for <lists+linux-iio@lfdr.de>; Sun, 12 Jul 2020 15:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbgGLNfk (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Jul 2020 09:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:41058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728339AbgGLNfk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 12 Jul 2020 09:35:40 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C37D206B6;
        Sun, 12 Jul 2020 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594560939;
        bh=tA6inrUVMBbNMdDUv0sGKtGU7BZNsriyMOePDmhGwc8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G6zXdmu7qxU3Vgk93hqW3Jio/U+fyHYjuZ6eECAXysS9JNbx54qgm+1xOPFkY3CvE
         sAO9eEiWzoS7n0Z/bM2n5DGcqGeaYpYoG/b6YMyWqDk/d0GCdKy7MdMNkM6IOnVlvN
         1SxelAHXAGoVB/7aFwu7rmzvQfBKPvaWeBQBt72Y=
Date:   Sun, 12 Jul 2020 14:35:34 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kamel Bouhara <kamel.bouhara@bootlin.com>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH v6 0/5] Microchip TCB Capture driver
Message-ID: <20200712143534.278ea3c7@archlinux>
In-Reply-To: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
References: <20200706114347.174452-1-kamel.bouhara@bootlin.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  6 Jul 2020 13:43:42 +0200
Kamel Bouhara <kamel.bouhara@bootlin.com> wrote:

> Hello,
> 
> Here is a new counter driver to support Microchip TCB capture devices.
> 
> Each SoC has two TCB blocks, each one including three independent
> channels.The following series adds support for two counter modes:
> increase and quadrature decoder.
> 
> As for the atmel clocksource and pwm, the counter driver needs to fill
> some tcb capabilities in order to operate with the right configuration.
> This is achieved in first patch of this series.
> 
> Please feel free to comment.

As far as I can see we have all the necessary acks etc and it looks
good to me as well.

Shall I do an immutable branch with the whole lot or should we split it
up?  Patches 1 and 5 need to go through the same tree, but bindings
could go via another route.  I'm also fine if the whole lot goes
via the appropriate soc tree if that is easier.

Jonathan


> 
> Cheers,
> 
> Changes in v6:
>  - Rebased on top of v5.8-rc3
>  - Added Alexandre's ack
>  - Added Rob's ack
> 
> Changes in v5:
>  - Fix duplicate keys errors in yaml dt-schema
> 
> Changes in v4:
>  - Use existing binding to document capture mode of the Microchip TCBs.
> 
> Changes in v3:
>  - Updated the brand name: s/atmel/microchip/.
>  - Added missing kernel doc for new elements introduced in structure
>    atmel_tcb_config.
>  - Removed useless blank line
>  - Added an explicit clock removing path using devm_add_action_or_reset
> 
> Changes in v2:
>  - Fixed first patch not applying on mainline
>  - Updated return code to -EINVAL when user is requesting qdec mode on
>    a counter device not supporting it.
>  - Added an error case returning -EINVAL when action edge is performed
>    in
>    qdec mode.
>  - Removed no need to explicity setting ops to NULL from static struct
>    as
>    it is the default value.
>  - Changed confusing code by using snprintf for the sake of clarity.
>  - Changed code to use ARRAY_SIZE so that future reviewers will know
>    that num_counts matches what's in the atmel_tc_count array without
>    having to check so themselves.
>  - Fixed errors reported by dt_binding_check
> 
> Alexandre Belloni (2):
>   dt-bindings: atmel-tcb: convert bindings to json-schema
>   dt-bindings: microchip: atmel,at91rm9200-tcb: add sama5d2 compatible
> 
> Kamel Bouhara (3):
>   ARM: at91: add atmel tcb capabilities
>   dt-bindings: counter: microchip-tcb-capture counter
>   counter: Add microchip TCB capture counter
> 
>  .../devicetree/bindings/mfd/atmel-tcb.txt     |  56 ---
>  .../soc/microchip/atmel,at91rm9200-tcb.yaml   | 181 ++++++++
>  drivers/counter/Kconfig                       |  11 +
>  drivers/counter/Makefile                      |   1 +
>  drivers/counter/microchip-tcb-capture.c       | 397 ++++++++++++++++++
>  include/soc/at91/atmel_tcb.h                  |   5 +
>  6 files changed, 595 insertions(+), 56 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-tcb.txt
>  create mode 100644 Documentation/devicetree/bindings/soc/microchip/atmel,at91rm9200-tcb.yaml
>  create mode 100644 drivers/counter/microchip-tcb-capture.c
> 
> --
> 2.26.2
> 

