Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D058BC92
	for <lists+linux-iio@lfdr.de>; Sun,  7 Aug 2022 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235640AbiHGSr5 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 7 Aug 2022 14:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbiHGSr4 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 Aug 2022 14:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E175D55A8
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 11:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8224861043
        for <linux-iio@vger.kernel.org>; Sun,  7 Aug 2022 18:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E59C433D6;
        Sun,  7 Aug 2022 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659898074;
        bh=KELhcMezbMpk1TJz1iqinfNl+u6+y/uBXvUBazgE1J4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b1bEhyUvlrnj0+TSScjsqaalFZkw+cJXUGd47xS56ovjp/dElGwudR7W/3qCuhBVS
         u6rub1kcIVzIsCpG0LPJVHJoCfJe0/jrwVKOEcFsc/VbEv0YH/KM3FRkY/NmOskdHq
         Xh0/vn49a5qz0mlEUJQ7tnmnyXmqiRVA4XwmKvQLlA0HGav1+gbLBTkqwhKZHccCWT
         qw1Vw+M6mllPfTDX0zTLYsRjLWFsUhcksXwc9Z7SXL6/JlvHsjMvMWSF6tSlouk1ud
         lZAm+8EwyLQYMV5bTlbNbRi9hV89fc4SYYSCrIuW4DVrj9Ory0zSRvDkpyY6WJqraN
         L8dOhey7CXYrw==
Date:   Sun, 7 Aug 2022 19:58:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     linux-iio@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 0/2] iio: magn: hmc5843: Trivial cleanup and refactor
 dev_pm_ops handling.
Message-ID: <20220807195816.00af4188@jic23-huawei>
In-Reply-To: <20220807184534.1037363-1-jic23@kernel.org>
References: <20220807184534.1037363-1-jic23@kernel.org>
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

On Sun,  7 Aug 2022 19:45:32 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> This driver was taking an unusual approach to handling the optionality of
> structures / callbacks depending on CONFIG_PM.  Bring it inline with
> other similar drivers.
> 
> Part of continuing to move IIO over to the new PM macros that don't require
> such complex handling.
Obviously setting a bad example here.  Should have include iio: magn: hmc5843 as
prefix for this cover letter.  Sorry about that!

> 
> Jonathan Cameron (2):
>   iio: magn: hmc5843: Drop excessive indentation of assignments of
>     hmc5843_driver
>   iio: magn: hmc5843: Move struct dev_pm_ops out of header
> 
>  drivers/iio/magnetometer/hmc5843.h      | 13 +------------
>  drivers/iio/magnetometer/hmc5843_core.c |  8 ++++----
>  drivers/iio/magnetometer/hmc5843_i2c.c  |  2 +-
>  drivers/iio/magnetometer/hmc5843_spi.c  | 14 +++++++-------
>  4 files changed, 13 insertions(+), 24 deletions(-)
> 

