Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E405925A3
	for <lists+linux-iio@lfdr.de>; Sun, 14 Aug 2022 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240258AbiHNQ4F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 14 Aug 2022 12:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbiHNQzV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Aug 2022 12:55:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8EBBB95A1;
        Sun, 14 Aug 2022 09:43:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49A53B80B79;
        Sun, 14 Aug 2022 16:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 938C1C433C1;
        Sun, 14 Aug 2022 16:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660495421;
        bh=w28eigQrYF9kqUXrPHiDGC54RLAzgkZZJ8ZUkhuRrDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cko5FOh+GYBb9X32kNljB9YAmx7a2G1rWkTX1GYT5STm/8L0uzdqP1tThbHZ6WawQ
         VIGjRPojcCITN76ZHRHy1HJW56ywLmQWsAm+ZBHpTKPx8DtAmnK3r6mcjD2rGFg5LM
         PpGjJ5isZd7+5ggewIYeKoscNpH5rIn4nGLrRgq5kErlP3Vx8uw8TbktfS2J124XXH
         npV5Xv3U6RT6uRazNV3qC2sjl1e6UQ7EEREB9xDw3nV+24c4k7qvWsvQvQ/0/OX7dg
         AQ64Pp5or7XYABEI8h2O1z4S3PSN03dlJncyNHlBZCefYslSIbyLUgssz7HXkxlxCI
         bJquOQSNo2xGA==
Date:   Sun, 14 Aug 2022 17:54:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v6 00/14] Add support for magnetometer Yamaha YAS537
Message-ID: <20220814175410.321a66bc@jic23-huawei>
In-Reply-To: <cover.1660337264.git.jahau@rocketmail.com>
References: <cover.1660337264.git.jahau.ref@rocketmail.com>
        <cover.1660337264.git.jahau@rocketmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Aug 2022 23:54:05 +0200
Jakob Hauser <jahau@rocketmail.com> wrote:

> This patchset adds YAS537 variant to the already existing driver for
> Yamaha YAS magnetometers.
> 
> Patch 1 is a fix on the current driver.
> Patches 2-13 are cleanups and refactoring.
> Patch 14 finally adds the YAS537 variant.

Series applied.  That build bot issue on v5 took me rather by surprise.
Good to see the resolution looks pretty nice.

I've applied this to what will become the togreg branch after rc1 is out
and I can rebase. In the meantime pushed out as testing so the build bots
are forced to take another look at it on top of my current tree.

Thanks to all who have been reviewing this one and to Jakob for persisting.
Unless anyone spots anything critical, let us do as Andy suggested and
carry out any further tweaks as follow on patches.

Thanks,

Jonathan
