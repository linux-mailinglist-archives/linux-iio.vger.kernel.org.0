Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 361F6430836
	for <lists+linux-iio@lfdr.de>; Sun, 17 Oct 2021 13:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbhJQLJZ (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 17 Oct 2021 07:09:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:41122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235960AbhJQLJY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 17 Oct 2021 07:09:24 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C051760FDC;
        Sun, 17 Oct 2021 11:07:13 +0000 (UTC)
Date:   Sun, 17 Oct 2021 12:11:28 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-iio@vger.kernel.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Robert Nelson <robertcnelson@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] counter/ti-eqep: add support for direction
Message-ID: <20211017121128.60d85587@jic23-huawei>
In-Reply-To: <20211017013343.3385923-3-david@lechnology.com>
References: <20211017013343.3385923-1-david@lechnology.com>
        <20211017013343.3385923-3-david@lechnology.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 16 Oct 2021 20:33:37 -0500
David Lechner <david@lechnology.com> wrote:

> This adds support for direction to the TI eQEP counter driver. It adds
> both a direction attribute to sysfs and a direction change event to
> the chrdev. The direction change event type is new public API.
> 
> Signed-off-by: David Lechner <david@lechnology.com>

Trivial comment inline.

> ---
>  drivers/counter/ti-eqep.c    | 33 +++++++++++++++++++++++++++++++++
>  include/uapi/linux/counter.h |  2 ++
>  2 files changed, 35 insertions(+)
> 

...

>  static struct counter_signal ti_eqep_signals[] = {
> @@ -442,6 +471,10 @@ static irqreturn_t ti_eqep_irq_handler(int irq, void *dev_id)
>  	if (qflg & QFLG_PCU)
>  		counter_push_event(counter, COUNTER_EVENT_UNDERFLOW, 0);
>  
> +	if (qflg & QFLG_QDC)
> +		counter_push_event(counter, COUNTER_EVENT_DIRECTION_CHANGE, 0);
> +

Nitpick. One blank line is enough here.

> +
>  	regmap_set_bits(priv->regmap16, QCLR, ~0);
>  
>  	return IRQ_HANDLED;
> diff --git a/include/uapi/linux/counter.h b/include/uapi/linux/counter.h
> index d0aa95aeff7b..36dd3b474d09 100644
> --- a/include/uapi/linux/counter.h
> +++ b/include/uapi/linux/counter.h
> @@ -61,6 +61,8 @@ enum counter_event_type {
>  	COUNTER_EVENT_THRESHOLD,
>  	/* Index signal detected */
>  	COUNTER_EVENT_INDEX,
> +	/* Direction change detected */
> +	COUNTER_EVENT_DIRECTION_CHANGE,
>  };
>  
>  /**

