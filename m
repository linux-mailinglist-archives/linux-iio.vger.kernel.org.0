Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D91578B106
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjH1Mup (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 08:50:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjH1Mu0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 08:50:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBA7107;
        Mon, 28 Aug 2023 05:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B09AE64781;
        Mon, 28 Aug 2023 12:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546B5C433C7;
        Mon, 28 Aug 2023 12:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693227023;
        bh=MbQoEIXMuaNJzjz9uMSa4zwmOMSFlS9dpa0CtiWq1Z0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TG6P2YyCXSZs0CUD1pg4gPkEBx6gqpj8oHYqFrYF7gS9onKpN/VBT+Fx3seZe8cEi
         fPr/aONJjI1xqwblpj58ZqFWJKjz3E7bwmInzKK5gTjxeRw2XNeZGLk3/XIFxNaqAB
         tRjYGoR1yS5MaS9Ht3F4J5ZFmdC9JjBzAqYK6lxqQNmW0/5Z4ilJr3DnzKyzeCgDhY
         1pqgqQ2XwuBvwMFqdeQWBlz5cdwt0K3SxFh9u8WZlN62p9xFhxz0x+2U2mXVNCcKZL
         CRy5J6I390i40wSObCWQGY1g6x+ml0WC87657qn/LOy/a4pgn1RYnrIERU/mT3lOB0
         XwLSKTnH6b28w==
Date:   Mon, 28 Aug 2023 13:50:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5p?= =?UTF-8?B?Zw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, Sean Nyekjaer <sean@geanix.com>
Subject: Re: [PATCH v2 0/2] Match data improvements for ti-dac5571 driver
Message-ID: <20230828135040.37e1aeb7@jic23-huawei>
In-Reply-To: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
References: <20230818173907.323640-1-biju.das.jz@bp.renesas.com>
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

On Fri, 18 Aug 2023 18:39:05 +0100
Biju Das <biju.das.jz@bp.renesas.com> wrote:

> This patch series aims to add match data improvements for ti-dac5571
> driver.
> 
> v1->v2:
>  * Split the patch into two.
>  * Added patch#2 for sorting match tables.
> 
> Biju Das (2):
>   iio: dac: ti-dac5571: Use i2c_get_match_data()
>   iio: dac: ti-dac5571: Sort match tables
+CC Sean,

Applied to the togreg branch of iio.git and pushed out for now as testing.
I'll be rebasing that tree on rc1 once available, so I won't push these
out in a form linux-next will pick up until then.

Thanks,

Jonathan

> 
>  drivers/iio/dac/ti-dac5571.c | 48 ++++++++++++++++--------------------
>  1 file changed, 21 insertions(+), 27 deletions(-)
> 

