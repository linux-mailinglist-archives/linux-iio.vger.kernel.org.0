Return-Path: <linux-iio+bounces-10257-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FD7E991F52
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 17:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC9C42828DE
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D82917ADE2;
	Sun,  6 Oct 2024 15:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUQJU+ik"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC25817A5B6;
	Sun,  6 Oct 2024 15:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728228295; cv=none; b=u1nZ3huYd+SMsB4wekAtcUFIvtplahH/9x/0yAkZolKw6jsJz//GuyVAi8JM+qTu5mBjN3cY9yBoMbxpwjfR6oxfpqaAlV2kBhZVAeBmNKPpoLF2fCuOe5cbSgM7Vx0xulkrZty4w0vV8H3n6ZyRC0k23Ytrj+KlvSPmgZBegwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728228295; c=relaxed/simple;
	bh=v7RyxtP+3zTGkoDvgx5RNwbjNMv9S875mKBktDCLqtc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EupyetrGYGYJqcnT7lo/KvEYM/yLcbz0dB5Z014HOtL6nfSxfonPRqi9bRpS7eRgNryOkooJmbrXKGyWdXdVCKodww0BVaOS1V4gHPW0KgL/nMHX9NKraE7P9q0GDsrKAgLbXrfdKe2k/hEjbFq/UWSrxL0MYaE11Gg7HCA08Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUQJU+ik; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F30C0C4CECE;
	Sun,  6 Oct 2024 15:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728228294;
	bh=v7RyxtP+3zTGkoDvgx5RNwbjNMv9S875mKBktDCLqtc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUQJU+ikbznK/6eKBNBZ7GYmLKXYnSkeyH4WDq/tlFFLpC9/AK1MA0KbJmg9KbIib
	 bPjlPyBe31UqWmRKFwBWZfA61DU9YtzMSA90MYdM2wylgLG54Xe2ZcWm9GccxnqE+C
	 hMIaCBcmEG0qGJBE1xzZJO/4UngXI5snHGK9/LIIpCau2q68g5gDfGOUR54KcQ3vUZ
	 QprFwRNL7Zo2KaXinWIUfE/yAR9EnWIGn1u7dofrxUNSkQjmVrIaDp/p3pMw8Hrbxt
	 VcJ6+f2tWSHTRkOnt6WJEzcTmfy6yivQHVYm+KiZcFlwnZdPHMrNnWgtgQf28NZPJz
	 fouUZtj3hPHzg==
Date: Sun, 6 Oct 2024 16:24:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Per-Daniel Olsson <perdaniel.olsson@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <rickard.andersson@axis.com>, <kernel@axis.com>
Subject: Re: [PATCH v2 0/2] Support for Texas Instruments OPT4060 RGBW Color
 sensor.
Message-ID: <20241006162446.51a93744@jic23-huawei>
In-Reply-To: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
References: <20241005165119.3549472-1-perdaniel.olsson@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 5 Oct 2024 18:51:17 +0200
Per-Daniel Olsson <perdaniel.olsson@axis.com> wrote:

> This patch series adds support for Texas Instruments OPT4060 RGBW Color sensor
> using the i2c interface.
> 
> The driver exposes both raw adc values and calculated lux values though sysfs.
> Integration time can be configured though sysfs as well.

Lux is a unit with a particular light curve.  It has no defined meaning for
color channels.  As a result we usually only have colors as intensity channels
(unit free).  If it is possible to compute an estimate of the illuminance then
that can be a separate IIO_LIGHT channel.

> The OPT4060 sensor
> supports both rising and falling threshold interrupts. These interrupts are
> exposed as IIO events. The driver also implements an IIO triggered buffer with
> two triggers, one trigger for conversion ready interrupts and one trigger for
> threshold interrupts. The typical use case for this is to define a threshold and
> listen for the events, and at the same time enable the triggered buffer with the
> threshold trigger. Once the application gets the threshold event, the values
> from the time of the event will be available in the triggered buffer. This
> limits the number of interrupts between sensor and host and also the the usage
> of sysfs for reading values after events.

We have had various discussions of threshold triggers in the past, but I don't
think we ever merged any (maybe there is one somewhere?) The reasons for that are:
1) They are hard for generic userspace to understand.
2) For light sensors the input tends to be slow moving - grabbing one reading
   on a threshold interrupt is rarely that informative (or are you grabbing them
   on dataready once the threshold is breached?)
3) If we want to do threshold triggers we should really add generic infrastructure
   for them based on adding an in kernel events consumer path and a way to
   instantiate a trigger based on any event.  Doing it in a single driver creates
   an ABI we won't want to retain long term.

So how important is this feature to you and why?  Maybe it is time to finally
take a close look at option 3.

Jonathan

> 
> Changes in v2:
> - dt-bindings: Removed incorrect allOf.
> - dt-bindings: Changed to generic node name.
> - Correction in opt4060_trigger_one_shot(...) for continuous mode.
> - Correction in opt4060_power_down(...), wrong register was read.
> - Corrected usage of active_scan_mask in opt4060_trigger_handler(...).
> - Clean-up of various comments.
> - Link to V1: https://lore.kernel.org/lkml/20241003164932.1162049-1-perdaniel.olsson@axis.com/
> 
> Per-Daniel Olsson (2):
>   dt-bindings: iio: light: Document TI OPT4060 RGBW sensor
>   iio: light: Add support for TI OPT4060 color sensor
> 
>  .../bindings/iio/light/ti,opt4060.yaml        |   51 +
>  drivers/iio/light/Kconfig                     |   13 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/opt4060.c                   | 1216 +++++++++++++++++
>  4 files changed, 1281 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/ti,opt4060.yaml
>  create mode 100644 drivers/iio/light/opt4060.c
> 
> 
> base-commit: 0c559323bbaabee7346c12e74b497e283aaafef5


