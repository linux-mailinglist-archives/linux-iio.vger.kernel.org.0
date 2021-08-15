Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5403ECA4A
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbhHOQsi (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:48:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhHOQsi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:48:38 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47395604AC;
        Sun, 15 Aug 2021 16:48:04 +0000 (UTC)
Date:   Sun, 15 Aug 2021 17:51:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     linux-stm32@st-md-mailman.stormreply.com, kernel@pengutronix.de,
        a.fatoum@pengutronix.de, kamel.bouhara@bootlin.com,
        gwendal@chromium.org, alexandre.belloni@bootlin.com,
        david@lechnology.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syednwaris@gmail.com, patrick.havelange@essensium.com,
        fabrice.gasnier@st.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, o.rempel@pengutronix.de,
        jarkko.nikula@linux.intel.com
Subject: Re: [PATCH v15 07/13] docs: counter: Document character device
 interface
Message-ID: <20210815175102.4a10a28f@jic23-huawei>
In-Reply-To: <a6f7be32b8ff7cc1e8e416599820a30fa9aab9f5.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
        <a6f7be32b8ff7cc1e8e416599820a30fa9aab9f5.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 21:37:32 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> This patch adds high-level documentation about the Counter subsystem
> character device interface.
> 
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Hi William,

Trivial probable typo inline.

I'm struggling somewhat with these interfaces because I simply don't know
enough about how people use counters to know whether they provide everything
people will want. They feel similar to the event handling type functions you
can set up in motor drives, so they may well make sense, but ideally
we need review from someone (other than yourself!) who actually uses this
stuff on a regular basis.

If we don't get any additional review I guess we go ahead anyway
next cycle.

Jonathan

> ---

> +
> +Counter events can be configured by users to report various Counter
> +data of interest. This can be conceptualized as a list of Counter
> +component read calls to perform. For example:
> +
> +        +-------------------------------------------------+
> +        | COUNTER_EVENT_OVERFLOW | COUNTER_EVENT_INDEX    |
> +        +========================+========================+
> +        | Channel 0              | Channel 0              |
> +        +------------------------+------------------------+
> +        | * Count 0              | * Signal 0             |
> +        | * Count 1              | * Signal 0 Extension 0 |
> +        | * Signal 3             | * Extension 4          |
> +        | * Count 4 Extension 2  +------------------------+
> +        | * Signal 5 Extension 0 | Channel 1              |
> +        |                        +------------------------+
> +        |                        | * Signal 4             |
> +        |                        | * Signal 4 Extension 0 |
> +        |                        | * Count 7              |
> +        +------------------------+------------------------+
> +
> +When ``counter_push_event(counter, COUNTER_EVENT_INDEX, 1)`` is called
> +for example, it will go down the list for the ``COUNTER_EVENT_INDEX``
> +event channel 1 and execute the read callbacks for Signal 4, Signal 4
> +Extension 0, and Count 4 -- the data returned for each is pushed to a

Count 7?

> +kfifo as a ``struct counter_event``, which userspace can retrieve via a
> +standard read operation on the respective character device node.
> +

>                                                                       Block for the entire subsystem

