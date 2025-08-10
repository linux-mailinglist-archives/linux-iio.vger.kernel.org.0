Return-Path: <linux-iio+bounces-22522-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFF3FB1FBB6
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A59B1893069
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 18:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50261DDC1B;
	Sun, 10 Aug 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odJG6gJh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F2518C02E;
	Sun, 10 Aug 2025 18:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754850629; cv=none; b=bvySZP8s2+gpMx2EkLimpXdU64VsOplrB9XwvUtEH1clO+756r06Wx5HHmJG1anMT2JOi622VCJKqARGdVyeA3lU7Rgl4TKkwQRtG+4pdabLcMr1WjRiDXvbl9w03fQhiUTpyvbt2QgHQX1f6fWld76blBFeJ7SmLzy8eFBaP5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754850629; c=relaxed/simple;
	bh=BDEwxdP6aRMHliLQFbvtUXExAgSE5ZNqRkzrfSLCK18=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=td4ECuwJ+KXvDVb7XINbSleFl7HA+emUe7Ai5knruCHcRxw3SXKeE/e6EaJ6ov5DAzahrCVfAwUelhXFjNc+ugwnfCHPJCDd0w/JsTtA9KSf9dACXrCYiADDoMu78xfRSQ1I4hvyMPIDFAliOP9qUTVl9NkUj6lkVtfdxDA05S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odJG6gJh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7628C4CEEB;
	Sun, 10 Aug 2025 18:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754850629;
	bh=BDEwxdP6aRMHliLQFbvtUXExAgSE5ZNqRkzrfSLCK18=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=odJG6gJhbVnnwy/20Dbnp2QMhB/bcLH31yZ2VSB++KMff3smByWkNKLVtzHw2yjkE
	 NOdVpCWFw7Ki36+/xEOiLAOSZHR3smSzdXtJiBxUEKEnoUd2BBCFG2UxBpcyZejZ5t
	 VwoLYSfsTlqqSeWZeodAZsvjSuG0sLzNfXRD5s0zB0ukw6ZsBpXK8cey9XVaCeSwvW
	 Z93bEEem+BR+i99vDjvbWM8Jz24AXOVJVZ206cfzF0Vyk4bztr/vcSoWMArocJIWr4
	 BFS7gjNzhRIujPptMbpU2W73Gr+V3oLcEMrWOUMYwvIh7h4AC61nKhKbdpUpql/fp6
	 IEcDA4PiEATiw==
Date: Sun, 10 Aug 2025 19:30:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andreas Klinger <ak@it-klinger.de>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
 andriy.shevchenko@linux.intel.com, arthur.becker@sentec.com,
 perdaniel.olsson@axis.com, mgonellabolduc@dimonoff.com,
 muditsharma.info@gmail.com, clamor95@gmail.com, emil.gedenryd@axis.com,
 devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] iio:light: add driver for veml6046x00 RGBIR
 color sensor
Message-ID: <20250810193017.571cdf40@jic23-huawei>
In-Reply-To: <20250728075447.338725-1-ak@it-klinger.de>
References: <20250728075447.338725-1-ak@it-klinger.de>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 09:54:43 +0200
Andreas Klinger <ak@it-klinger.de> wrote:

> This patchset adds an IIO driver for Vishay veml6046x00 RGBIR color sensor.
Tweaks as per comments on patch 2 and applied to the testing branch of iio.git.

I'll rebase on rc1 in the next few days and then push this out as a tree linux-next
picks up.

Thanks,

Jonathan

> 
> Changes in v7:
> - Thanks to the reviews of Jonathan and Andy improvements in the PM could be
>   implemented like removal of pm_runtime_mark_last_busy() and consistency in PM
>   handling in some functions.
> 
> Changes in v6:
> - Thanks to the in-depth review of Andy many datatype improvements were
>   realized.
> - According to Jonathans review change the channel types from IIO_LIGHT to
>   IIO_INTENSITY.
> 
> Changes in v5:
> - Thanks to the feedback of Andy and further explanations of Jonathan many
>   improvements could be implemented.
> - add documentation in kernel-doc format
> - iio_push_to_buffers_with_ts() is not used as also testing against
>   linux-stable where it is not available so far.
> 
> Changes in v4:
> - implement feedback from Andy and Jonathan
> - implement feedback from vendor (reading interrupt register as bulk read)
> 
> Changes in v3:
> - implement a lot of feedback from Jonathan
> - change scale value to real factor of lux per raw count instead of hardware
>   gain  
> - optimize code by using more lookup tables
> - remove unimplemented threshold functionality
> 
> Changes in v2:
> - fix missing include for example in vishay,veml6046x00.yaml
> 
> Andreas Klinger (3):
>   dt-bindings: iio: light: veml6046x00: add color sensor
>   iio: light: add support for veml6046x00 RGBIR color sensor
>   MAINTAINER: add maintainer for veml6046x00
> 
>  .../iio/light/vishay,veml6046x00.yaml         |   51 +
>  MAINTAINERS                                   |    6 +
>  drivers/iio/light/Kconfig                     |   13 +
>  drivers/iio/light/Makefile                    |    1 +
>  drivers/iio/light/veml6046x00.c               | 1031 +++++++++++++++++
>  5 files changed, 1102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/vishay,veml6046x00.yaml
>  create mode 100644 drivers/iio/light/veml6046x00.c
> 


