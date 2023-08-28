Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749B378B154
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbjH1NIC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231714AbjH1NHo (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:07:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF2ACC;
        Mon, 28 Aug 2023 06:07:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7A2DD61BE2;
        Mon, 28 Aug 2023 13:07:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9D2C433C8;
        Mon, 28 Aug 2023 13:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693228061;
        bh=Q3LE0iQJI1xchevaEPiexMt4SmGiYSeC4tYhZlrGScM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=meL5Rq1MRiLrevEbB0n6gLpQHnVY8z+uaed7PIZt9MI0ht3l33FbcgM7GmWRFYAri
         bPFcWCNfSqA5Y+XdPA/qygHNzD0SUBGoJKeBF9iJyO1PCAhPLQkIlRYVq+B59zZU0A
         LGfkQMENT0KhkCcuoA6E4LeP1qBtj955RxW8DBlmK3lT9/pQmHp4ccJSP6tUffKTaI
         06YylZIAZmZ7GIsSCALsWo58hB1WSSiBc8HB0TRTRZu2mrSkywKQmDFlz/YfiTB4qN
         CocTuc6W005wUpI3vOIm+HGOR2W4Vs5dCcIkVL12srouN4Tk4iid9v5t3QTbq+uOhq
         lQovfQz1Cs34Q==
Date:   Mon, 28 Aug 2023 14:08:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jakob Hauser <jahau@rocketmail.com>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: magnetometer: yamaha-yas530: Drop enum
 chip_ids
Message-ID: <20230828140801.1a60e547@jic23-huawei>
In-Reply-To: <ZNsgFG2aL78IKbYq@smile.fi.intel.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
        <20230812065741.20990-3-biju.das.jz@bp.renesas.com>
        <ZNsgFG2aL78IKbYq@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Aug 2023 09:49:56 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Aug 12, 2023 at 07:57:41AM +0100, Biju Das wrote:
> > Drop the unnecessary enum chip_ids by splitting the array
> > yas5xx_chip_info_tbl[] as individual variables.  
> 
> In my opinion this is an unneeded churn.
> I leave this to Jonathan to decide.
> 
Agree with Andy.

I don't care strongly about doing it one way or another. But as
it's already done via an array - better to leave it like that
and avoid the churn.

Jonathan

