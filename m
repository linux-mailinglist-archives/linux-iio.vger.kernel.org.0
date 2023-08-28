Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFAD78B540
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjH1QTu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232743AbjH1QTm (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 12:19:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FEA12F;
        Mon, 28 Aug 2023 09:19:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E48B763304;
        Mon, 28 Aug 2023 16:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF26C433C8;
        Mon, 28 Aug 2023 16:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693239576;
        bh=gFQvXyg/vDldrLxaeGv6Mmc+3uJgkUu964k7SBhhiXs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Bdzz+uQ1rifyOKTDVtaYuUylafipSPcS+7TY/+6648EKlQIP3dBWjfrmrHV1gbN7x
         nTj4NKOV6SFSzQH+JBN+BkVGR++LTjEfKoOxwzWndWDnuG1PHiSe1+nXe3v1azY5/5
         ksls1RsBUnOVLmjoyZA6QLw0ubFtIs6RgF344C3Vua2l/COZTaQaxbEt0qlzUQ/808
         0IZr6Icq/HikZVDBXHjGd3NM2sF9qtAv3xzbUNQl1U4xLL2EirrjxekERvKT3f41Yg
         spidwHvTQauss1Mdhsy2P/9jZx4Yx3qrMtTSAS11Bi5z1nCMErAjyQg5I4Oj3UVuJ3
         XnduxqpQhI6FQ==
Date:   Mon, 28 Aug 2023 17:19:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] iio: potentiometer: ds1803: Convert enum->pointer for
 data in the ID table
Message-ID: <20230828171958.0828436a@jic23-huawei>
In-Reply-To: <ZNtKtES3GtLKd1eI@smile.fi.intel.com>
References: <20230812144106.163355-1-biju.das.jz@bp.renesas.com>
        <ZNtKtES3GtLKd1eI@smile.fi.intel.com>
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

On Tue, 15 Aug 2023 12:51:48 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Aug 12, 2023 at 03:41:06PM +0100, Biju Das wrote:
> > Convert enum->pointer for data in the ID table, so that
> > device_get_match_data() can do match against OF/ACPI/I2C tables, once i2c
> > bus type match support added to it.
> > 
> > Replace enum->struct *ds1803_cfg for data in the ID table and simplify
> > ds1803_probe() by replacing device_get_match_data() with
> > i2c_get_match_data().  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

Applied
