Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5491591BCC
	for <lists+linux-iio@lfdr.de>; Sat, 13 Aug 2022 17:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiHMP6O (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 13 Aug 2022 11:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239916AbiHMP6N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 13 Aug 2022 11:58:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0629A458
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 08:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2386760EDD
        for <linux-iio@vger.kernel.org>; Sat, 13 Aug 2022 15:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BB31C433C1;
        Sat, 13 Aug 2022 15:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660406291;
        bh=ceKjfOU+qa6dTZOmXkp1HJZm+9HWaf0aEYW48oIV/5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dAn50h+KWw2awfkZNfZIV08w90pu1ak7+Zw40Zz5VYY+uWX5sjc8Z/FVfFLRJ8M/S
         4rfcA9FsHP/MDAqBU9b/t+ihUBDfY5MNKy629hoT9fb/Rm10eLkoJSpuO8xBTruF6U
         g2Azndi2Uz+ZJ3MqEwqHSGBEB19Oh4FLw2fGyBYCFzDWICWNDVRTuj2bk5Nj4JzwaW
         ljABJrmtk2BrGIJKfYKRVFJ48LbURJmLcWxWTKVS2KL0JxlIC4iPbkc7GB+DZL90gd
         bN3vSElZuJWd2JhEU/6l02VZgd8gSJH0h/yAtOfcnWRN7t7lw3j7xzGlgiC/ccwQz1
         E7YQeMJKn1rpA==
Date:   Sat, 13 Aug 2022 17:08:40 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] Trivial cleanup and refactor dev_pm_ops handling.
Message-ID: <20220813170840.5228861d@jic23-huawei>
In-Reply-To: <CAHp75VePiBGRmKJiPbHtyX_waO8Qb6hkM0+pNh3kx_Let5MHPw@mail.gmail.com>
References: <20220807184534.1037363-1-jic23@kernel.org>
        <CAHp75VePiBGRmKJiPbHtyX_waO8Qb6hkM0+pNh3kx_Let5MHPw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 8 Aug 2022 11:22:00 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sun, Aug 7, 2022 at 8:38 PM Jonathan Cameron <jic23@kernel.org> wrote:
> >
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >
> > This driver was taking an unusual approach to handling the optionality of
> > structures / callbacks depending on CONFIG_PM.  Bring it inline with
> > other similar drivers.
> >
> > Part of continuing to move IIO over to the new PM macros that don't require
> > such complex handling.  
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Thanks,

Applied

> 
> > Jonathan Cameron (2):
> >   iio: magn: hmc5843: Drop excessive indentation of assignments of
> >     hmc5843_driver
> >   iio: magn: hmc5843: Move struct dev_pm_ops out of header
> >
> >  drivers/iio/magnetometer/hmc5843.h      | 13 +------------
> >  drivers/iio/magnetometer/hmc5843_core.c |  8 ++++----
> >  drivers/iio/magnetometer/hmc5843_i2c.c  |  2 +-
> >  drivers/iio/magnetometer/hmc5843_spi.c  | 14 +++++++-------
> >  4 files changed, 13 insertions(+), 24 deletions(-)
> >
> > --
> > 2.37.1
> >  
> 
> 

