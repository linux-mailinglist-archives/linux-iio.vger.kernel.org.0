Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD6F28A370
	for <lists+linux-iio@lfdr.de>; Sun, 11 Oct 2020 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390354AbgJJW5F (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 10 Oct 2020 18:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731415AbgJJTWi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 10 Oct 2020 15:22:38 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C71522403;
        Sat, 10 Oct 2020 16:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602347956;
        bh=LrxTBhOIRAvOVxxLMPo1bOOzACc+zp1p+bdGylDekVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YGQczH9xZlIu2suyiXmFhkMiyEN8OrcjJRqvpomls3kvVIyXXK3QXzH91BbigN4jV
         FbL+ddUHB1LRmEDBedebkmXmkMCh6N1VF+AfZ3AHZD0veK8scsm2dYhI988AwBbOAU
         lenjuLug3UrNA3/lJyIwt4g2tepiZl/zt+m6B690=
Date:   Sat, 10 Oct 2020 17:39:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] iio: sx9310: Support setting various settings
Message-ID: <20201010173910.2fbfe6e8@archlinux>
In-Reply-To: <20201007011735.1346994-1-swboyd@chromium.org>
References: <20201007011735.1346994-1-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue,  6 Oct 2020 18:17:29 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> I need to configure various settings such as thresholds, gain factors,
> etc. on this device. Some settings matter at boot, while others can wait
> for userspace to configure things. This patch series adds support to
> set these various bits in the registers of this device.

Looks good to me.  I've applied them to the togreg branch of iio.git and
pushed out as testing for the autobuilders to see if they can find any
issues.  Note that I can still add tags etc for now if anyone
wants to send any!

Thanks,

Jonathan

> 
> Changes from v2 (https://lore.kernel.org/r/20200930075728.2410327-1-swboyd@chromium.org)
>  - Rolled in a fix from Gwendal on last patch to simplify if-else logic
>  - Fixed binding and picked up Rob's reviewed-by tag
> 
> Changes from v1 (https://lore.kernel.org/r/20200903221828.3657250-1-swboyd@chromium.org)
>  - A bunch more patches for userspace settings
>  - Removed body thresholds as they're probably not used
>  - Removed compensate common as it probably doesn't matter
>  - Moved thresholds, gain factor, hysteresis, debounce to userspace
> 
> Stephen Boyd (6):
>   iio: sx9310: Support hardware gain factor
>   iio: sx9310: Support setting proximity thresholds
>   iio: sx9310: Support setting hysteresis values
>   iio: sx9310: Support setting debounce values
>   dt-bindings: iio: sx9310: Add various settings as DT properties
>   iio: sx9310: Set various settings from DT
> 
>  .../iio/proximity/semtech,sx9310.yaml         |  63 +++
>  drivers/iio/proximity/sx9310.c                | 508 +++++++++++++++++-
>  2 files changed, 565 insertions(+), 6 deletions(-)
> 
> Cc: Daniel Campello <campello@chromium.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Gwendal Grignou <gwendal@chromium.org>
> Cc: Evan Green <evgreen@chromium.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: <devicetree@vger.kernel.org>
> 
> base-commit: 1bebdcb928eba880f3a119bacb8149216206958a

