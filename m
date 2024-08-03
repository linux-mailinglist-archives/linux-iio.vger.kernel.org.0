Return-Path: <linux-iio+bounces-8203-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A52BF946A12
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 16:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 604EB281B90
	for <lists+linux-iio@lfdr.de>; Sat,  3 Aug 2024 14:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105EB14F131;
	Sat,  3 Aug 2024 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RhzHhAbW"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29E8E54C;
	Sat,  3 Aug 2024 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722695126; cv=none; b=oIzocJYPt6WFXRgx1O2H5JUpJgqB8k6dknoVXnIvX89jYxcANNrMyFyYEegSTi+LPnLReyQR7gXrJRuyv7sNEX3ICLZEIpplKO0o92ewVtW1AmlFDPjmCPI6PIcMWZcszF8hMlxvOwH080MMPynOhIfJKD4Z4ev82nXbiXsR4sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722695126; c=relaxed/simple;
	bh=LfgedwEQLNEm6eaWnDwudIvblflafEj5Mgli7B9IMB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+Mfh21D1XHMQ2VrPW8oRSjbvXm3IQhxekR0Bstkb8ZFfs+54y1g8Z5k69OJ/spQOeAVp7vNM7zOYKkcSHkysaU3nFiQC+D75882/ZNryZV8VbBWOpsGnxjvcV/tqYObmuAxhalTMXgqW1hGP3jfEA802FtyV5QmMTfbBcdl/FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RhzHhAbW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1737DC116B1;
	Sat,  3 Aug 2024 14:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722695126;
	bh=LfgedwEQLNEm6eaWnDwudIvblflafEj5Mgli7B9IMB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RhzHhAbWQfy3xALyEzmvGEXEIxZdK6ps62aFbVgnhfLFrMec/AIVLMJ1c7uhn4pHh
	 VDFo3Y/NovERJdONlmK4xYTYfqYgKKGEMLThmwglstX6Z7/7KvLTd4g/+45D+z9FVd
	 606rzNCiqu/Mtddg53XmoCjI97UKsR2Hdw+5Ob28FROa21HuMfWlOlNTH61M3e9Foe
	 M7T3BDupd58rSupGI2OKeWjM0ZkJNWaJq785/6AgMlWGeH3wlTbUipwVVEckh0Y1QY
	 8jyjRQfZcuAYEiKY0GRobhpOiYHODGjnxjn4M2Xe+QYvVu5pdYPEYqNEzTT9myyJ2+
	 rnpLkTgzST5zA==
Date: Sat, 3 Aug 2024 15:25:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Trevor Gamblin <tgamblin@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, David
 Lechner <dlechner@baylibre.com>, Uwe Kleine-Konig
 <u.kleine-koenig@baylibre.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] iio: adc: add new ad7625 driver
Message-ID: <20240803152515.2f61eb5e@jic23-huawei>
In-Reply-To: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
References: <20240731-ad7625_r1-v1-0-a1efef5a2ab9@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:48:02 -0400
Trevor Gamblin <tgamblin@baylibre.com> wrote:

> This series adds a new driver for the Analog Devices Inc. AD7625,
> AD7626, AD7960, and AD7961. These chips are part of a family of
> LVDS-based SAR ADCs. The initial driver implementation does not support
> the devices' self-clocked mode, although that can be added later.
> 
> One aspect that is still uncertain is whether there should be a
> devicetree property indicating if the DCO+/- pins are connected, so
> specific feedback on that is appreciated.

Would be good to give more detail. What is DCO?
Seems to be a delayed clock skewed so it aligns with the data being
out in response to clk. Host drives clk, but samples on dco.

Given the device needs to do slightly different things depending
on whether that is what the host is using, I think it definitely does
need to be in DT.

Maybe you need to represent it as the ADC also having a PWM
output that the LVDS DT node binds to if present.  That binding
then indicates to the ADC driver that it needs to operating in the
mode that doesn't send the synchronisation 101 pattern.
If you are always representing the ADC and the lvds side of things
as a single node, then need a flag in here somewhere so we can
tell if they are in use or not.

Given this exists as a potential difference between two separate
parts pf a system I'd definitely think about whether we can give them separate
representations with clear 'connectivity' between them

One of those cases were a bit of ascii art would probably be good
to put the problem clearly for the DT reviewers.

Jonathan


> 
> The devices make use of two offset PWM signals, one to trigger
> conversions and the other as a burst signal for transferring data to the
> host. These rely on the new PWM waveform functionality being
> reviewed in [1].
> 
> This work is being done by BayLibre and on behalf of Analog Devices
> Inc., hence the maintainers are @analog.com.
> 
> Special thanks to David Lechner for his guidance and reviews.
> 
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> ---
> Trevor Gamblin (3):
>       dt-bindings: iio: adc: add AD762x/AD796x ADCs
>       iio: adc: ad7625: add driver
>       docs: iio: new docs for ad7625 driver
> 
>  .../devicetree/bindings/iio/adc/adi,ad7625.yaml    | 176 ++++++
>  Documentation/iio/ad7625.rst                       |  91 +++
>  MAINTAINERS                                        |  11 +
>  drivers/iio/adc/Kconfig                            |  15 +
>  drivers/iio/adc/Makefile                           |   1 +
>  drivers/iio/adc/ad7625.c                           | 626 +++++++++++++++++++++
>  6 files changed, 920 insertions(+)
> ---
> base-commit: ac6a258892793f0a255fe7084ec2b612131c67fc
> change-id: 20240730-ad7625_r1-60d17ea28958
> 
> Best regards,


