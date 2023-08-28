Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6B078B1D5
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 15:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbjH1Nbq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 09:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231311AbjH1Nbl (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 09:31:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7B8A7;
        Mon, 28 Aug 2023 06:31:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A612F614BB;
        Mon, 28 Aug 2023 13:31:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 900C7C433C7;
        Mon, 28 Aug 2023 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693229494;
        bh=OuE9G9ngRPWg6RrL8zYjsyTxYQ8cAl/K4ikMGUZhsWI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lCP8os6uOe+XtUU0JrRwitGTSETaCVODLomVjNQJezD5LYuXBGOW5wpA3km1dS2vS
         OMBbf9T9aqFekwUw3eOgOAeCKYo1POpx9ObXQRAEZjLen+xUGUzex7mDBjDsasrLtX
         DWBJdu6h9ob6mFoQgKn5vtgrQyF7r9YKzElV/88VCz/0KndyP5RYtDbizhP177tTnh
         jMyXk/HmfnxGWh1oBpCvvyO4cO1h7c294ipn5lHx7Wnp7GP2u7k0234hoTtvDIDmBJ
         EqNO4bH3s63Mh4PYf/tXbIvqcTnZUNBoeV+vZmrnIQAFLVfIRq4z3MSPTsytlvNNI6
         qZNDK5mI4iCQg==
Date:   Mon, 28 Aug 2023 14:31:54 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Crt Mori <cmo@melexis.com>, Rob Herring <robh@kernel.org>,
        linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: Convert enum->pointer for data in
 the match table
Message-ID: <20230828143154.29b4f7ba@jic23-huawei>
In-Reply-To: <ZNsnD954MkGBVlV4@smile.fi.intel.com>
References: <20230812141044.151520-1-biju.das.jz@bp.renesas.com>
        <ZNsnD954MkGBVlV4@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 15 Aug 2023 10:19:43 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Aug 12, 2023 at 03:10:44PM +0100, Biju Das wrote:
> > Convert enum->pointer for data in the match table, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> > bus type match support added to it.
> > 
> > Replace enum->struct *bma180_part_info for data in the match table and
> > simplify bma180_probe().  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied. Thanks,

J
