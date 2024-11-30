Return-Path: <linux-iio+bounces-12858-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB379DF139
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 15:39:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D3BB2117C
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 14:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62BAC19CC24;
	Sat, 30 Nov 2024 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C6xI8xhs"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15DCA22066;
	Sat, 30 Nov 2024 14:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732977533; cv=none; b=ZpK2fPerZZ26ZLvlDr9cosCprteFcBlLuC5tzqntSV6ic4SwyIB7o5CDe/mOqCXZCxA3nahiLx7NZOQpkqU2RP3bqHpYEKZpZmGcbaQMeGTAqYaEXbXxKXkiSAf54RvvqcebyIXAjjCgdZitJQXzzowuyF0OP6n3Kroi8E5cX0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732977533; c=relaxed/simple;
	bh=QCPo4jXBpcB4DpefDlo0VJK7XXro8x4Hb1AhIGZvSn8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fFFzV3u9fmjW9qelufn5M5TZXaFIdW26n1C6nuoFHQOAFSOrJ9nW6DgsNFtJFNUSvsXB1CPJzitDCx6mnmc4Tkkcsqh2nBzvf97Ak9Me9MwhDrxS/6DfS4/BrJdo5Vz0vu0tmiln/CYeUAb3g69gJWs6mLqKgdbYSajcHTLM4sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C6xI8xhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C931AC4CECC;
	Sat, 30 Nov 2024 14:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732977532;
	bh=QCPo4jXBpcB4DpefDlo0VJK7XXro8x4Hb1AhIGZvSn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C6xI8xhsgKziHqKNSSdgUD6emEOO36YBbx0jdInDo4jjIVOWHbzAvoF16R1hz/flH
	 BG3fOlcCvdz55DXlEtkC0MOjyDPQNV/BOmqZEuBym/M+3bwXyPgsOHzVLgpVkjoENo
	 n3QfE/+LXiCoIQ5bJLAmAKeuuyLsy4KbVrpyYdFKswVtixhRcqtpMblmxKctsgaAxD
	 2RcItqG8NipNwiI/xt4RnQVODt2LkQTyj9zT15dLBNGu7wWbUVHpBeuwqjGZ/vekNV
	 1tFL4bwwEe7kCaqYlmm8P10IF39F3MPCdRspEDkJOgBjt+4Y6LaQjBOQd1FnsbqPNd
	 2bAktGe7BxKSw==
Date: Sat, 30 Nov 2024 14:38:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	0001-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org,
	0002-dt-bindings-iio-light-Drop-BU27008-and-BU27010.patch@mva-rohm.smtp.subspace.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>, Marek Vasut <marex@denx.de>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Drop BU27008 and BU27010
Message-ID: <20241130143842.34d29a51@jic23-huawei>
In-Reply-To: <cover.1732819203.git.mazziesaccount@gmail.com>
References: <cover.1732819203.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Nov 2024 21:34:54 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Drop the support for ROHM BD72008 and BD72010 RGB sensors
> 
> I accidentally hit a BU27008 data-sheet which had a big red text saying
> "Obsolete". After a few queries I received a word that the ROHM BU27008
> and BU27010 RGB sensors were cancelled and never entered mass production.
> Supporting not existing hardware makes no sense, so it's probably best
> to drop the drivers and dt-bindings.
> 
> There is still a RGB sensor from ROHM called BU27006.
> https://www.rohm.com/products/sensors-mems/color-sensor-ics/bu27006muc-z-product
> Based on a quick glance this should be very similar to the BU27010. If
> someone wants to create a driver for this, then the bu27008.c might be
> worth looking at.
> 
> As writing of this I don't have the BU27006 at my hands, and when I
> asked about creating a driver for this IC from the HQ ... I got an
> impression that at the moment ROHM rather pays me for doing something
> else. So, currently I have no plan to add support for the BD27006.
> We can always dig the bu27008.c from the depths of the git, if it later
> appears such a driver would be a good idea.

Applied.  I'm not going to rush it in because a driver for hardware
that no one has is not really a problem as long as no one does any more
work on it.  So queued up in my testing branch which will go upstream
next merge cycle.

You have my sympathies wrt to wasted work!

Jonathan

> 
> Matti Vaittinen (2):
>   iio: light: Drop BU27008 and BU27010
>   dt-bindings: iio: light: Drop BU27008 and BU27010
> 
>  .../bindings/iio/light/rohm,bu27008.yaml      |   49 -
>  .../bindings/iio/light/rohm,bu27010.yaml      |   50 -
>  MAINTAINERS                                   |    1 -
>  drivers/iio/light/Kconfig                     |   16 -
>  drivers/iio/light/Makefile                    |    1 -
>  drivers/iio/light/rohm-bu27008.c              | 1635 -----------------
>  6 files changed, 1752 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27008.yaml
>  delete mode 100644 Documentation/devicetree/bindings/iio/light/rohm,bu27010.yaml
>  delete mode 100644 drivers/iio/light/rohm-bu27008.c
> 
> 
> base-commit: a61ff7eac77e86de828fe28c4e42b8ae9ec2b195


