Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 374A15272BC
	for <lists+linux-iio@lfdr.de>; Sat, 14 May 2022 17:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiENPtu (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 14 May 2022 11:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbiENPts (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 May 2022 11:49:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E1B2674
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 08:49:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6276A60F68
        for <linux-iio@vger.kernel.org>; Sat, 14 May 2022 15:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 955A7C340EE;
        Sat, 14 May 2022 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652543386;
        bh=Fl4QwbT27BXMDmofeX0tgCOs80iohgnrhqXSlDorTwg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bi7DdScLNFAU/fQhgytUa1mfU43rYgaWnCbX+ryyuAeRiyxz+T7v3jH8ie1p9Lxkb
         yV9X5AQC6WY/8wimcQgMkwcdAEQP+O9s9qOUaYeaB+rI2ssLrOfgg9QqpAcFS8PKk9
         eO0H1OEzKTLcM6KEVd98Hs7ryb6W+U/z2OTrsx7Jn0pD9I488f/G4S0ENgRQNGsO+W
         ug5KZIuFuX4KJGYECzyZDp+ZLZl5MzWdlC4KFPnGaOrqVYlpmDHXoJPOohF5WNfxD6
         SUOf3eg80HI9u4CN8wuHW4cmgWzF3PyukA/O+cepGBgGUZDUO9xiXXZMUU1te10cg4
         HxgAOIfZjitaA==
Date:   Sat, 14 May 2022 16:58:22 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Zheyu Ma <zheyuma97@gmail.com>, lars@metafoo.de,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: gyro: mpu3050: Fix the error handling in
 mpu3050_power_up()
Message-ID: <20220514165822.1be198d3@jic23-huawei>
In-Reply-To: <CACRpkda9Gbo9R15qRm35nwdjba0t79H=68+LuPL-HFbFgrONrw@mail.gmail.com>
References: <20220510092431.1711284-1-zheyuma97@gmail.com>
        <CACRpkda9Gbo9R15qRm35nwdjba0t79H=68+LuPL-HFbFgrONrw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
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

On Fri, 13 May 2022 00:08:37 +0200
Linus Walleij <linus.walleij@linaro.org> wrote:

> On Tue, May 10, 2022 at 11:24 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
> 
> > The driver should disable regulators when fails at regmap_update_bits().
> >
> > Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>  
> 
> Looks correct!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
I'm not going to rush this one in as

Applied to the fixes-togreg branch of iio.git and marked for stable
(I was a bit borderline in deciding on stable marking but meh, it's safe
enough as fixes go and real issue, even if one we are unlikely to hit)

Thanks,

Jonathan

> 
> Yours.
> Linus Walleij

