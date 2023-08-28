Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F5678AEAE
	for <lists+linux-iio@lfdr.de>; Mon, 28 Aug 2023 13:22:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjH1LVa (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Mon, 28 Aug 2023 07:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjH1LVY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 28 Aug 2023 07:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6B3E7;
        Mon, 28 Aug 2023 04:21:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53CFC621A6;
        Mon, 28 Aug 2023 11:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 302C8C433C7;
        Mon, 28 Aug 2023 11:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693221677;
        bh=TZmKaBVmangkdek3JbxffDFdaDrgU4VpX7OVExruEfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CAOIx8+oJ5YLBqNsoJ3Zma8bAKfR58Pw6JZbEQDDSvJLT16zDT3eI56RuFGTNfZV0
         /ZGbnJHdDm9U1J3SthBVK1nM4Yi51RPkuWXpQyICyqR3IKDrP3Gecnh0OrXXJRNuYy
         uK0L7dhEg2Ao92mE6wQbZM0ijVGvvoR0fHJNOoP7+l035jY6VoIYbO2tQQ+CHr5ks3
         19uMRRjGdenyyS6seT8DBIEXoQYsTMSlMVD0iUhDA/Sl0Qpiw9CcXLDIn3Pnk2QKk0
         hjMJEeg0O7TinVzeZZiEk63zDzHpH3DJh6AAi0p3PfBr0gwJoYZpdRcEfkBd10XhPF
         CKTskRgK8ft4A==
Date:   Mon, 28 Aug 2023 12:21:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        Rob Herring <robh@kernel.org>, linux-iio@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 2/2] iio: accel: mma8452: Sort match tables
Message-ID: <20230828122136.27a3dba7@jic23-huawei>
In-Reply-To: <ZONiWnLpY7FD/+lj@smile.fi.intel.com>
References: <20230818184033.335502-1-biju.das.jz@bp.renesas.com>
        <20230818184033.335502-3-biju.das.jz@bp.renesas.com>
        <ZONiWnLpY7FD/+lj@smile.fi.intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 21 Aug 2023 16:10:50 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, Aug 18, 2023 at 07:40:33PM +0100, Biju Das wrote:
> > Sort ID table alphabetically by name and OF table by compatible.  
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Series applied to the togreg branch of iio.git. I'll push that out
as testing until I can rebase on rc1.

Thanks

Jonathan

> 

