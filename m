Return-Path: <linux-iio+bounces-10953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C359AB75A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 22:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47DE61C23ACA
	for <lists+linux-iio@lfdr.de>; Tue, 22 Oct 2024 20:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC7E21C9EA4;
	Tue, 22 Oct 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b7GlvJWY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B757148314;
	Tue, 22 Oct 2024 20:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729627370; cv=none; b=aRmssdBOdWUIeqErv8qWKXXgtN08wAP9c/kL653qahb6tl83QfGCXXx1Gaa7T2J22Hwu0ojIHwIPNGLscnzqVgolEmZUbHLdXzoxx/XWBdc9/LQ1DZJ45M/aGaeP1qHcYF0FLb3EAQhXJDL6LzxesP5GWoqyDgZ0Fqnn38BMGkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729627370; c=relaxed/simple;
	bh=K/0cq2A2Zdsoq/7MCZkWP3DN95N87xlLtfL7UuCOg4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ihLpIDMdIFKCT4XVoh6OMUUOtq9Jk7K/insZzLPuAx6G1L4LQ41QGz4o3RvN7e71fUtHgeLALvVVFbCeLZC+b3Qen8w+Q/3puqo5bPhrPBHxFDdVFJtH1vd2LmvSuLzPp0+vRlRg0Ahqx/m0Vb+AXJT2zTfEldetImsXHFZydP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b7GlvJWY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A41C4CEC3;
	Tue, 22 Oct 2024 20:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729627370;
	bh=K/0cq2A2Zdsoq/7MCZkWP3DN95N87xlLtfL7UuCOg4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=b7GlvJWYjr8bIddB7tqBqkp5AqF82AxFaYWAV3PpHqkrv986qs30K4kl2nDrjhSCW
	 TSxjbTBpVIEAnjqSiarEjXSb8d4d6ZaVicNmpNSkU6LfK6Y0oUoOFhCcVedqPWZxfB
	 N2vkts0FvZn3S1SMrDpldwk4WFZZbu9mwcKUcUVAtLh0xogLQ6q2OD1xmxtikCU0FG
	 oJONsQBt2jH9N1q/9bQ5mMH4pgwZfiQd7Rabyf/LmICB79hBCmFVW0hJnsBGFOML7m
	 BrJc7Q/Y/N0XdVer1YQ3uilgcALJ/Um5Vlw63d+O6hEXF34UERM4uiIR8i6hx2s6KK
	 Y9mFb9wXEXBhA==
Date: Tue, 22 Oct 2024 21:02:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Julien Stephan <jstephan@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/5] iio: adc: ad7380: fix several supplies issues
Message-ID: <20241022210239.6a61b32f@jic23-huawei>
In-Reply-To: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
References: <20241022-ad7380-fix-supplies-v3-0-f0cefe1b7fa6@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Oct 2024 15:22:35 +0200
Julien Stephan <jstephan@baylibre.com> wrote:

> Hello,
> 
> This series tries to fix several issues found on the ad7380 driver about
> supplies:
> 
> - vcc and vlogic are required, but are not retrieved and enabled in the
> probe function
> - ad7380-4 is the only device from the family that does not have internal
> reference and uses REFIN instead of REFIO for external reference.
> 
> driver, bindings, and doc are fixed accordingly

I considered a few responses to this series.

1) Asking you to pull the fixes to the front even though it would be painful.
2) Asking if the missing supplies patch should really be tagged as a fix.

In the end I opted for the variant that may just confuse the stable folk
the most and just took it as is + added stable to the 3 fixes.  Hopefully
it will be obvious they should just pick up all 5 (or maybe not the docs).

You are correct that the refactors make it easier to review the fixes
and this is a fairly new driver so I'm not that worried by pushing back the fix
as it's only to 6.11.

Applied to the fixes-togreg branch of iio.git.

Note the side effect of this is timing is tight for having this available
in the char-misc-next branch, so it may push back additional device
support until next cycle.

Thanks,

Jonathan

> 
> Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> ---
> Changes in v3:
> - Use fsleep instead of msleep
> - Add all trailers from review
> - Link to v2: https://lore.kernel.org/r/20241021-ad7380-fix-supplies-v2-0-2ca551b3352a@baylibre.com
> 
> Changes in v2:
> - Fix kernel test robot warning about variable uninitialized when used [1]
> - drop commit removing supply description in bindings
> - after discussion on [2] we decided to add refin supply here, as it
>   will be needed in the futur
> 
> - Link to v1: https://lore.kernel.org/r/20241007-ad7380-fix-supplies-v1-0-badcf813c9b9@baylibre.com
> 
> [1] https://lore.kernel.org/oe-kbuild-all/202410081608.ZxEPPZ0u-lkp@intel.com/
> [2] https://lore.kernel.org/all/20241015-ad7380-add-adaq4380-4-support-v1-0-d2e1a95fb248@baylibre.com/:warning
> 
> ---
> Julien Stephan (5):
>       dt-bindings: iio: adc: ad7380: fix ad7380-4 reference supply
>       iio: adc: ad7380: use devm_regulator_get_enable_read_voltage()
>       iio: adc: ad7380: add missing supplies
>       iio: adc: ad7380: fix supplies for ad7380-4
>       docs: iio: ad7380: fix supply for ad7380-4
> 
>  .../devicetree/bindings/iio/adc/adi,ad7380.yaml    |  21 ++++
>  Documentation/iio/ad7380.rst                       |  13 +-
>  drivers/iio/adc/ad7380.c                           | 136 ++++++++++++---------
>  3 files changed, 110 insertions(+), 60 deletions(-)
> ---
> base-commit: 1a8b58362f6a6fef975032f7fceb7c4b80d20d60
> change-id: 20241004-ad7380-fix-supplies-3677365cf8aa
> 
> Best regards,


