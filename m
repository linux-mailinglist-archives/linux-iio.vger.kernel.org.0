Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385145F236F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Oct 2022 15:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJBNul (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 2 Oct 2022 09:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiJBNuk (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Oct 2022 09:50:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BFB2A702;
        Sun,  2 Oct 2022 06:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BA5D2B80025;
        Sun,  2 Oct 2022 13:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA8DC433C1;
        Sun,  2 Oct 2022 13:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664718636;
        bh=C774BntxTk3Prk2DsQ9puZQrHyY1eCDeBabGqq2Q9gU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HQZToQ41+kdTmLKhf3ph3tdL6QWlnAsMfVOSuwjJ3ZRgMbtK1ZiX9kkxo5WvWZ9Co
         uaxjP3IPbO9lPG+VTjrTnvRg2iRB0DiL9s1sAhldwaiDLgbrtW8VDMuRiLGDkYe6CZ
         m/kpdE/YQWgQk/++v9fY8J0Zc84P1irl6eNwYZZiSUHDzwzPnjoP8OsYeFrvDBx5vZ
         5pnL43xbDjTZfRviUlBEzcelPzBCvrBUEFZGCyZ3MBi4m32IWepQv75VIgP5yW0qpJ
         RASVBZLXWSzWZ6OnLi+/BqN8qOsHCAWGeGEksO8jZrS8Tcjinqqx5TJPMmNiuTBqlg
         5dnL0SKEtEk4g==
Date:   Sun, 2 Oct 2022 14:50:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matt Ranostay <matt.ranostay@konsulko.com>
Cc:     gupt21@gmail.com, benjamin.tissoires@redhat.com, jikos@kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v6 3/3] HID: mcp2221: add ADC/DAC support via iio
 subsystem
Message-ID: <20221002145052.036003b5@jic23-huawei>
In-Reply-To: <20221001005208.8010-4-matt.ranostay@konsulko.com>
References: <20221001005208.8010-1-matt.ranostay@konsulko.com>
        <20221001005208.8010-4-matt.ranostay@konsulko.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Fri, 30 Sep 2022 17:52:08 -0700
Matt Ranostay <matt.ranostay@konsulko.com> wrote:

> Add support for 3x 10-bit ADC and 1x DAC channels registered via the iio
> subsystem.
> 
> To prevent breakage and unexpected dependencies this support only is
> only built if CONFIG_IIO is enabled, and is only weakly referenced by
> 'imply IIO' within the respective Kconfig.
> 
> Additionally the iio device only gets registered if at least one channel
> is enabled in the power-on configuration read from SRAM.
> 
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>

I'm never particularly keen on drivers from elsewhere in the tree gaining
IIO support - but that's just because it can make a bit of a mess of
changes to the IIO subsystem itself.  Having said that, this code looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

