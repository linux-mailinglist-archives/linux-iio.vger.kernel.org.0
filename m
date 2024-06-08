Return-Path: <linux-iio+bounces-6045-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BD69011A7
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 15:18:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEE40282911
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 13:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1917921D;
	Sat,  8 Jun 2024 13:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="civ589GA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC113A8D8;
	Sat,  8 Jun 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717852724; cv=none; b=psl8Jmix7WerlxXwKqovOs3Nx5xK6MdzpXkYPhp6GqPiCo1mwS946WtnvRlwJD3jpJGJxF6DkzAfiTeVvq1A206Yj0MP/Di8MXoUp5ub2wbTA5NfGXrOUHLMw4y8rKZugj/foRev/3lb0ZEwOlmOFWwaGmIFRuYWoQxj/v3g9K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717852724; c=relaxed/simple;
	bh=VDWy8tEmwwlhgYITkqlIVnQZivo0hojpfbF+2pgX82U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TM9xojxHltJ+B8jrTs9SvpsOZocEBnzV6T/wXrIdmo9Rae9JIlb7yFe2ka9Is9KgVYob1sy7WLvuHfd0uDjXRCjDpSffpR+lw7bCP5LwlY1b/+7qWRMZYOB+HVsWqUACLkHVi4FAccDQkP6HsjSYM37jCDTqbSRWfbwDcj6Ha8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=civ589GA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF4BC2BD11;
	Sat,  8 Jun 2024 13:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717852723;
	bh=VDWy8tEmwwlhgYITkqlIVnQZivo0hojpfbF+2pgX82U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=civ589GA+0Ootf3amW/5FXeaUyXJsP8+k/5nmtYjgTqYwVQX+K4M8KMhKuE3Bcpdg
	 sR8X4ukVOo4UplbDc+74zjyGVlOJe678fSuZCedlefpEQ+T5YhOy/gdQEat4TXXVcw
	 C4HVKTbSOad1B+WKJqvJ4hm4gmMt1a8vkfPxlhmb2LbLU6Hdhac99Q6dRb0rnSaB8C
	 wXJuwr4KP5XJXurBSIqoo9nJgMz1jXFs6B76JdFhvfMhrETMl/DqZaTGMY2PSDWp8U
	 cKfsyBjCkXsUBLVkJ34+Wnp4rCQw1nLSkMimdo9JTSP9nmvmcDS1jyHet6GFn07jpM
	 RxL1xqoTSuNbQ==
Date: Sat, 8 Jun 2024 14:18:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, wens@csie.org, ee.jones@linaro.org,
 sre@kernel.org, lgirdwood@gmail.com, broonie@kernel.org, lars@metafoo.de,
 andy.shevchenko@gmail.com, linus.walleij@linaro.org, brgl@bgdev.pl,
 michael@walle.cc, samuel@sholland.org, linux-iio@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/13] Add support for AXP192 PMIC
Message-ID: <20240608141832.7fdc9eb8@jic23-huawei>
In-Reply-To: <1535049f-1e4c-446b-8070-6f51877b2649@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
	<1535049f-1e4c-446b-8070-6f51877b2649@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 17:12:51 +0200
Alex Bee <knaerzche@gmail.com> wrote:

> Hi Aidan,
> 
> Am 17.10.22 um 01:43 schrieb Aidan MacDonald:
> > This series adds support for the AXP192 PMIC to the AXP20x MFD driver
> > framework, including support for regulators, ADCs, and AC/USB/battery
> > power supplies.
> >
> > v6 is a resend of v5 from July -- the patches haven't changed at all
> > but I've rebased them on the latest git master branch.  
> I'm not entirely sure if I've found the latest version of the patches - at
> least b4 didn't find a newer. It looks a lot like only mfd and usb-power
> patches have been applied for some reason. Are you planing to resend the
> other ones?

This was delayed originally by a dependency on a header in mfd and that is
obviously resolved now.  I think everyone was expecting a resend
of the series or for Lee to pick up the dependent ones and so we all
stopped tracking it.

Anyhow, I had the two IIO cleanups already, but I've now picked up
the 3rd patch (where the dependency was) as well.

Thanks,

Jonathan

> 
> Regards,
> Alex
> 
> > Aidan MacDonald (13):
> >    dt-bindings: mfd: add bindings for AXP192 MFD device
> >    dt-bindings: iio: adc: axp209: Add AXP192 compatible
> >    dt-bindings: power: supply: axp20x: Add AXP192 compatible
> >    dt-bindings: power: axp20x-battery: Add AXP192 compatible
> >    mfd: axp20x: Add support for AXP192
> >    regulator: axp20x: Add support for AXP192
> >    iio: adc: axp20x_adc: Minor code cleanups
> >    iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
> >    iio: adc: axp20x_adc: Add support for AXP192
> >    power: supply: axp20x_usb_power: Add support for AXP192
> >    power: axp20x_battery: Add constant charge current table
> >    power: axp20x_battery: Support battery status without fuel gauge
> >    power: axp20x_battery: Add support for AXP192
> >
> >   .../bindings/iio/adc/x-powers,axp209-adc.yaml |  18 +
> >   .../bindings/mfd/x-powers,axp152.yaml         |   1 +
> >   .../x-powers,axp20x-battery-power-supply.yaml |   1 +
> >   .../x-powers,axp20x-usb-power-supply.yaml     |   1 +
> >   drivers/iio/adc/axp20x_adc.c                  | 356 ++++++++++++++++--
> >   drivers/mfd/axp20x-i2c.c                      |   2 +
> >   drivers/mfd/axp20x.c                          | 141 +++++++
> >   drivers/power/supply/axp20x_battery.c         | 142 ++++++-
> >   drivers/power/supply/axp20x_usb_power.c       |  84 ++++-
> >   drivers/regulator/axp20x-regulator.c          | 100 ++++-
> >   include/linux/mfd/axp20x.h                    |  84 +++++
> >   11 files changed, 856 insertions(+), 74 deletions(-)
> >  


