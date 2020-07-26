Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B55622DED1
	for <lists+linux-iio@lfdr.de>; Sun, 26 Jul 2020 13:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgGZL4n (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 26 Jul 2020 07:56:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgGZL4l (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 26 Jul 2020 07:56:41 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE99F20714;
        Sun, 26 Jul 2020 11:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595764601;
        bh=ZJT1Da/14DYI/doBGS43uuhmxB8V2xTbMZHt83SNCnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NX+Aa6VuqTHUgq9QYXfIY80u4nTyxH883tt6Gm5cmySXAC1PHQ2bavZi5ZWzZSpVc
         5G1wNjLc3AK6061cNIYSMY50n8U53HqOfC2O0eimf3d/R5n3sO64G5bs0Tk5Gb5X11
         83f+FM58DXN6mDqwP7KQjY1XMdYyVbg5uwwXaP9U=
Date:   Sun, 26 Jul 2020 12:56:36 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Daniel Campello <campello@chromium.org>
Subject: Re: [PATCH 0/3] Some sx9310 iio driver updates
Message-ID: <20200726125636.3aa003ad@archlinux>
In-Reply-To: <20200724213329.899216-1-swboyd@chromium.org>
References: <20200724213329.899216-1-swboyd@chromium.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 24 Jul 2020 14:33:24 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> These patches are only related because I'm looking at this driver. The
> first one resends the DT binding for the driver that was merged in
> v5.8-rc1 with a small change to update for proper regulators. The second
> patch fixes a few printks that are missing newlines and should be
> totally non-trivial to apply. The third patch changes whoami to unsigned
> to avoid confusing. The fourth patch drops channel_users because it's
> unused. The final patch adds support to enable the svdd and vdd supplies
> so that this driver can work on a board I have where the svdd supply
> isn't enabled at boot and needs to be turned on before this driver
> starts to communicate with the chip.
Hi Stephen,

I clearly made a mess of picking this driver up in the first place.

Anyhow, we now have two series in flight for the driver that, whilst
mostly independent (I think) will result in at least some fuzz.
If possible could you work with Daniel to send me one single series
with all the changes?

Thanks,

Jonathan

> 
> Changes from v1:
>  * Two new patches for whoami and channel_uesrs
>  * Use bulk regulator APIs for supplies patch
>  * Support both regulators
> 
> Daniel Campello (1):
>   dt-bindings: iio: Add bindings for sx9310 sensor
> 
> Stephen Boyd (4):
>   iio: sx9310: Add newlines to printks
>   iio: sx9310: whoami is unsigned
>   iio: sx9310: Drop channel_users[]
>   iio: sx9310: Enable vdd and svdd regulators at probe
> 
>  .../iio/proximity/semtech,sx9310.yaml         | 60 +++++++++++++++++++
>  drivers/iio/proximity/sx9310.c                | 46 +++++++++++---
>  2 files changed, 97 insertions(+), 9 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml
> 
> Cc: Hartmut Knaack <knaack.h@gmx.de>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Daniel Campello <campello@chromium.org>
> 
> base-commit: b3a9e3b9622ae10064826dccb4f7a52bd88c7407

