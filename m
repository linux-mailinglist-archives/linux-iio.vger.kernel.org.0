Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3776266B341
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jan 2023 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjAORmH (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Jan 2023 12:42:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231484AbjAORlu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2023 12:41:50 -0500
Received: from fgw23-4.mail.saunalahti.fi (fgw23-4.mail.saunalahti.fi [62.142.5.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81E2113D1
        for <linux-iio@vger.kernel.org>; Sun, 15 Jan 2023 09:41:36 -0800 (PST)
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id da7e4c1f-94fb-11ed-877c-005056bdfda7;
        Sun, 15 Jan 2023 19:41:34 +0200 (EET)
From:   andriy.shechenko@saunalahti.fi
Date:   Sun, 15 Jan 2023 19:41:34 +0200
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3 2/3] iio: light: vcnl4000: Make irq handling more
 generic
Message-ID: <Y8Q6zrJ+AwzmO8KK@surfacebook>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
 <20230110134323.543123-3-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110134323.543123-3-marten.lindahl@axis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tue, Jan 10, 2023 at 02:43:22PM +0100, Mårten Lindahl kirjoitti:
> This driver supports 4 chips, by which only one (vcnl4010) handles
> interrupts and has support for triggered buffer. The setup of these
> functions is hardcoded for vcnl4010 inside the generic vcnl4000_probe,
> and thus ignores the chip specific configuration structure where all
> other chip specific functions are specified.
> 
> This complicates adding interrupt handler and triggered buffer support
> to chips which may have support for it.
> 
> Add members for irq threads and iio_buffer_setup_ops to the generic
> vcnl4000_chip_spec struct, so that instead of checking a chip specific
> boolean irq support, we check for a chip specific triggered buffer
> handler, and/or a chip specific irq thread handler.

...

> -		ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev,
> -						      NULL,


> +		ret = devm_iio_triggered_buffer_setup(&client->dev,
> +						      indio_dev, NULL,

What the point of this part of the hunk?

...

> +	if (client->irq) {
> +		if (data->chip_spec->irq_thread) {

I have checked the rest of the series and found nothing that prevents this to
be written as

	if (client->irq && data->chip_spec->irq_thread) {

This will reduce the noise in the patch.

>  	}

-- 
With Best Regards,
Andy Shevchenko


