Return-Path: <linux-iio+bounces-15290-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7B3DA2F80B
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF5A188922E
	for <lists+linux-iio@lfdr.de>; Mon, 10 Feb 2025 19:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBD525E466;
	Mon, 10 Feb 2025 18:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ8Ren6E"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E2179A7;
	Mon, 10 Feb 2025 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739213992; cv=none; b=cOcRNqdkY8cuxlWBBe2lG48USHDubjJXeHiYz+UhwF+fY+UHuC74EWZsrfIi6IxPqAiyuO43X/6RMDE4oYHNZ27s2cCsIN8srMq5IYlT7w2Gn7WGKcnWG8n9NEsA4nW32EY08bKZUlNOE3gdEvyIpawO2DDQuBb3pu+w4DSWms8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739213992; c=relaxed/simple;
	bh=0kby5yzJ82YbE3sKuDLWqLhBQL7R07TemAKHUgP/q9c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SQuDxXUGG1JEmCButs8w+jf8e2NNQ9G3TQQs8XUE3L6OAuC9P8gsuoDjwh6cVhdWDHHObxLDNyH0Be26Z8kN+jKbj2l0EeJVD4p4RflvWLswIkpd+V3bQlsH1p5TjN5Zf/+D+m66ZOsZcU67k1gUOUrG9BRd4siLJ9IPrCn9Gas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ8Ren6E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5793EC4CED1;
	Mon, 10 Feb 2025 18:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739213992;
	bh=0kby5yzJ82YbE3sKuDLWqLhBQL7R07TemAKHUgP/q9c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kJ8Ren6Eb0rHZRUGgGe/ygbmSbsKib6UTxgaPeoLeQzDz+BCg2sSCFfrZoRik11gi
	 CPWDrzTLAeohqWo8BX8xgiCqDiXdMlG4c0bsDxyHpeY9Gycwn8vomG1eLpjbUm2OqQ
	 m63eYY1uA1E26Di7hXjDNe8Zyoch/sOWBDxy0TyVaZtvOOWZx2DLIRBZOw84Y6dIuO
	 ofSW2r6aIqyQZ8nwdGlevx/8UtEAa79cHbSCJYcpY/9xp9ivEqgjRLFbTqaqa90Di/
	 dgXMsGfr26Jq0O5yfkC8//nduDnhZX3lHKK8AABKM4CJjuFmj9bJBb5pTCL8wsKstG
	 eWxlICOHaWvgA==
Date: Mon, 10 Feb 2025 18:59:40 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Uwe
 =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <ukleinek@kernel.org>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, David
 Jander <david@protonic.nl>, Martin Sperl <kernel@martin.sperl.org>,
 linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Axel Haslam <ahaslam@baylibre.com>
Subject: Re: [PATCH v8 00/17] spi: axi-spi-engine: add offload support
Message-ID: <20250210185940.441a0b8f@jic23-huawei>
In-Reply-To: <544c0100-54a9-40e6-b9b7-b79555056237@sirena.org.uk>
References: <20250207-dlech-mainline-spi-engine-offload-2-v8-0-e48a489be48c@baylibre.com>
	<544c0100-54a9-40e6-b9b7-b79555056237@sirena.org.uk>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Feb 2025 14:36:24 +0000
Mark Brown <broonie@kernel.org> wrote:

> On Fri, Feb 07, 2025 at 02:08:57PM -0600, David Lechner wrote:
> > Only very minor fixes in this revision.
> > 
> > Also, now that trees are rebased on v6.14-rc1 we no longer have
> > dependencies for the IIO patches. So Mark can pick up all of the
> > patches if we want to go that way. In any case though, Jonathan will
> > need an immutable branch since we have other IIO patches in-flight
> > building on top of this series.  
> 
> The following changes since commit 2014c95afecee3e76ca4a56956a936e23283f05b:
> 
>   Linux 6.14-rc1 (2025-02-02 15:39:26 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git tags/spi-offload

Thanks. Merged into IIO and patches 8-17 applied on top with a few tweaks
to the patch as mentioned in reply.

Pushed out for now as testing to see if 0-day spots anything new

Thanks,

Jonathan

> 
> for you to fetch changes up to 700a281905f2a4ccf6f3b2d3cd6985e034b4b021:
> 
>   spi: add offload TX/RX streaming APIs (2025-02-07 20:17:11 +0000)
> 
> ----------------------------------------------------------------
> spi: Add offload APIs
> 
> This series adds support for offloading complete SPI transactions,
> including the initiation, to the hardware.
> 
> ----------------------------------------------------------------
> David Lechner (5):
>       spi: add basic support for SPI offloading
>       spi: offload: add support for hardware triggers
>       dt-bindings: trigger-source: add generic PWM trigger source
>       spi: offload-trigger: add PWM trigger driver
>       spi: add offload TX/RX streaming APIs
> 
>  .../bindings/trigger-source/pwm-trigger.yaml       |  37 ++
>  MAINTAINERS                                        |  12 +
>  drivers/spi/Kconfig                                |  15 +
>  drivers/spi/Makefile                               |   4 +
>  drivers/spi/spi-offload-trigger-pwm.c              | 162 +++++++
>  drivers/spi/spi-offload.c                          | 465 +++++++++++++++++++++
>  drivers/spi/spi.c                                  |  10 +
>  include/linux/spi/offload/consumer.h               |  39 ++
>  include/linux/spi/offload/provider.h               |  47 +++
>  include/linux/spi/offload/types.h                  |  99 +++++
>  include/linux/spi/spi.h                            |  20 +
>  11 files changed, 910 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/trigger-source/pwm-trigger.yaml
>  create mode 100644 drivers/spi/spi-offload-trigger-pwm.c
>  create mode 100644 drivers/spi/spi-offload.c
>  create mode 100644 include/linux/spi/offload/consumer.h
>  create mode 100644 include/linux/spi/offload/provider.h
>  create mode 100644 include/linux/spi/offload/types.h


