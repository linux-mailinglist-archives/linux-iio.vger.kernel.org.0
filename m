Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31D63ECA51
	for <lists+linux-iio@lfdr.de>; Sun, 15 Aug 2021 18:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbhHOQzd (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Aug 2021 12:55:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42998 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229453AbhHOQzd (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 15 Aug 2021 12:55:33 -0400
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 152A561208;
        Sun, 15 Aug 2021 16:54:57 +0000 (UTC)
Date:   Sun, 15 Aug 2021 17:57:56 +0100
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
        jarkko.nikula@linux.intel.com,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v15 09/13] counter: Implement
 signalZ_action_component_id sysfs attribute
Message-ID: <20210815175756.5e627c3d@jic23-huawei>
In-Reply-To: <d72159ab7ebfe607d86c0ab472979e8eca6f16a0.1628511445.git.vilhelm.gray@gmail.com>
References: <cover.1628511445.git.vilhelm.gray@gmail.com>
        <d72159ab7ebfe607d86c0ab472979e8eca6f16a0.1628511445.git.vilhelm.gray@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon,  9 Aug 2021 21:37:34 +0900
William Breathitt Gray <vilhelm.gray@gmail.com> wrote:

> The Generic Counter chrdev interface expects users to supply component
> IDs in order to select Synapses for requests. In order for users to know
> what component ID belongs to which Synapse this information must be
> exposed. The signalZ_action_component_id attribute provides a way for
> users to discover what component ID belongs to the respective Synapse.
> 
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: David Lechner <david@lechnology.com>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---

>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
> index dbb507c9da11..11bef9f8190f 100644
> --- a/drivers/counter/counter-sysfs.c
> +++ b/drivers/counter/counter-sysfs.c
> @@ -393,7 +393,6 @@ static int counter_avail_attr_create(struct device *const dev,
>  	struct counter_attribute *counter_attr;
>  	struct device_attribute *dev_attr;
>  
> -	/* Allocate Counter attribute */

Trivial, but this is an unrelated change and shouldn't be in this patch (it's just noise).

>  	counter_attr = devm_kzalloc(dev, sizeof(*counter_attr), GFP_KERNEL);
>  	if (!counter_attr)
>  		return -ENOMEM;
> @@ -535,6 +534,46 @@ static int counter_name_attr_create(struct device *const dev,
>  	return 0;
>  }
>  
