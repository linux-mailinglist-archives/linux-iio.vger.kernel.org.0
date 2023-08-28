Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190CD78B5B8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbjH1Q6y (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232733AbjH1Q6r (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:58:47 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275FAAD
        for <linux-iio@vger.kernel.org>; Mon, 28 Aug 2023 09:58:45 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafZU-000526-RU; Mon, 28 Aug 2023 18:58:36 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qafZS-0005Ug-No; Mon, 28 Aug 2023 18:58:34 +0200
Date:   Mon, 28 Aug 2023 18:58:34 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: tmp117: Convert enum->pointer for data
 in the match tables
Message-ID: <20230828165834.rnzauc7y43l7oeke@pengutronix.de>
References: <20230812161154.196555-1-biju.das.jz@bp.renesas.com>
 <20230828172628.76beca65@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828172628.76beca65@jic23-huawei>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-iio@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 23-08-28, Jonathan Cameron wrote:
> On Sat, 12 Aug 2023 17:11:54 +0100
> Biju Das <biju.das.jz@bp.renesas.com> wrote:
> 
> > Convert enum->pointer for data in the match tables, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> > bus type match support added to it.
> > 
> > Add struct tmp11x_info and replace enum->struct *tmp11x_info for data in
> > the match table. Drop tmp117_identify() and simplify tmp117_probe() by
> > replacing device_get_match_data() and id lookup for retrieving data by
> > i2c_get_match_data().
> > 
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> 
> +CC Marco who has been active on this driver recently.
> 
> I'll apply it in the meantime, but still very much open to review comments.

LGTM, thanks for the work on i2c_get_match_data().

Reviewed-by: Marco Felsch <m.felsch@pengutronix.de>
