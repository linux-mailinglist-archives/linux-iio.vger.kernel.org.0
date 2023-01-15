Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF366B33B
	for <lists+linux-iio@lfdr.de>; Sun, 15 Jan 2023 18:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbjAORjR (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 15 Jan 2023 12:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjAORjQ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 15 Jan 2023 12:39:16 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 15 Jan 2023 09:39:14 PST
Received: from fgw21-4.mail.saunalahti.fi (fgw21-4.mail.saunalahti.fi [62.142.5.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE98C5594
        for <linux-iio@vger.kernel.org>; Sun, 15 Jan 2023 09:39:14 -0800 (PST)
Received: from localhost (88-113-26-56.elisa-laajakaista.fi [88.113.26.56])
        by fgw21.mail.saunalahti.fi (Halon) with ESMTP
        id 5fe83ce8-94fb-11ed-a85e-005056bdd08f;
        Sun, 15 Jan 2023 19:38:08 +0200 (EET)
From:   andriy.shechenko@saunalahti.fi
Date:   Sun, 15 Jan 2023 19:38:03 +0200
To:     =?iso-8859-1?Q?M=E5rten?= Lindahl <marten.lindahl@axis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH v3 3/3] iio: light: vcnl4000: Add interrupt support for
 vcnl4040
Message-ID: <Y8Q5+9WogoIeFMmX@surfacebook>
References: <20230110134323.543123-1-marten.lindahl@axis.com>
 <20230110134323.543123-4-marten.lindahl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230110134323.543123-4-marten.lindahl@axis.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Tue, Jan 10, 2023 at 02:43:23PM +0100, Mårten Lindahl kirjoitti:
> Add support to configure proximity sensor interrupts and threshold
> limits for vcnl4040. If an interrupt is detected an event will be
> pushed to the event interface.

...

> +	ret = i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> +	if (ret < 0)
> +		goto out;
> +
> +	val = (u16)ret;

Why do you need casting?

-- 
With Best Regards,
Andy Shevchenko


