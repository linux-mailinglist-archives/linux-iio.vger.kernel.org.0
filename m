Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C30478B158
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjH1NJG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:09:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232018AbjH1NIy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:08:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FB712E;
        Mon, 28 Aug 2023 06:08:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8844560C63;
        Mon, 28 Aug 2023 13:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFAA8C433C7;
        Mon, 28 Aug 2023 13:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693228128;
        bh=OQFgjRIqIwq6XT85Jt4ijzEToKnelfI/yCKLa1fl2OE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J90h/NgY6FaxvsATw5K/8BBxlt21OL5zhCWyA1DIKGcgWErqbxOO6VDTkKs5P/8Wb
         xZWJn2YbNDIijXmc3595RzYtevDOCEUeGfP/HnsAhptqR3322C66LtB0uVzlNrt4b9
         qObrZpCmGefccaiDM1L3+B19OoeJv2Q1N/Ucm34CSAND3l09u685TaFUFBMpzKolLN
         GBPiABXGdjOFKTrSNmR+A8qArqryYbYgirAvL9XEG7zw81EsbkmziBhD82bym1Z928
         AyE//AAb5IcOePhVckMTyzi5CtTuAB1CFRhrViAK+Clr009Zf9UNFiqEwJp1UonZWT
         WAolvFteMRwQQ==
Date:   Mon, 28 Aug 2023 14:09:06 +0100
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
Subject: Re: [PATCH v2 1/2] iio: magnetometer: yamaha-yas530: Use
 i2c_get_match_data()
Message-ID: <20230828140906.4ba41020@jic23-huawei>
In-Reply-To: <ZNsgKjxlvycW4UQc@smile.fi.intel.com>
References: <20230812065741.20990-1-biju.das.jz@bp.renesas.com>
        <20230812065741.20990-2-biju.das.jz@bp.renesas.com>
        <ZNsgKjxlvycW4UQc@smile.fi.intel.com>
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

On Tue, 15 Aug 2023 09:50:18 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Aug 12, 2023 at 07:57:40AM +0100, Biju Das wrote:
> > Simplify the probe() by replacing device_get_match_data() with
> > i2c_get_match_data().  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Applied just this patch.

Thanks,

Jonathan

> 

