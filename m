Return-Path: <linux-iio+bounces-19436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA06AB294E
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:12:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528821706C7
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C78B25B68A;
	Sun, 11 May 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvRKZM6t"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04041EA80;
	Sun, 11 May 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746976327; cv=none; b=C+qHE+ENKCXx+g+WSr8CrtjxAKk/9Hscm55X/VIekcn9NSFRBldcTdqyYRr/krV3VZwaFPZ8CABNcxFMp3b8lRrG2v6ozvWjDInNRMtKdVOhtZ94YcV6Uf2iG9N0THqgx+Yo44pW2Oy2zsbJRCEXZPOfIj+qWwbRT6QRP7Ll3Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746976327; c=relaxed/simple;
	bh=Ga7nasTnkzSVBFjKdfycTMcJIC33sJcG8DvRyvreocw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KHbUv6CnouvXIpLfq8/zzVEx6pRmhoNS5QW75jKYF8n5SqJL4bnXm9Jz5eBGVB+dYfbmz+XlfgHzVMJhVzMmGrGsibDuOMOi/qChjfB6E1XIge5Hj75xp8Pnp2WoiStiEgVxsXleqw5y0p7y/JNi/HEWxSTk5dDjHMySp84CCPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvRKZM6t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FAFCC4CEE4;
	Sun, 11 May 2025 15:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746976325;
	bh=Ga7nasTnkzSVBFjKdfycTMcJIC33sJcG8DvRyvreocw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kvRKZM6tSbXxxU9KluH4fpZlHddG9a2UCbCiaKSeykruBd6edHmqH//FiPTGkvVk6
	 MQ2r+FpBccSVn8Q/Yy47Mj0ncwqrHJoBrq32wK/ewHBPxHHu5X/BphnxAbirfb9UOu
	 p6FIXMsUQMQGBw4V06TsfSo5wNlFJAYwJXBB0upiLLhWDZO/ARFy+AIdd5WjqupAsi
	 k76sVuO4GrUEnKDET+a2kYwyXhbPg2rrbwSDSolhLF3bw3zDlICVNd2of4G8J/4Y/P
	 NM1lb1iML7CQB7Ibdx3UCoN4Uff325l0N13F5xrLGZWtD8PrAQun5SuAeYpJyi8jRh
	 2GJmcLIpPxw1A==
Date: Sun, 11 May 2025 16:11:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <andy@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <marcelo.schmitt@analog.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
 <conor+dt@kernel.org>, <marcelo.schmitt1@gmail.com>,
 <linus.walleij@linaro.org>, <brgl@bgdev.pl>, <lgirdwood@gmail.com>,
 <broonie@kernel.org>, <jonath4nns@gmail.com>, <dlechner@baylibre.com>
Subject: Re: [PATCH v7 00/12] iio: adc: ad7768-1: Add features,
 improvements, and fixes
Message-ID: <20250511161153.6e459745@jic23-huawei>
In-Reply-To: <cover.1746662899.git.Jonathan.Santos@analog.com>
References: <cover.1746662899.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 14:02:50 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> This patch series introduces some new features, improvements,
> and fixes for the AD7768-1 ADC driver. 
> 
> The goal is to support all key functionalities listed in the device
> datasheet, including filter mode selection, common mode voltage output
> configuration and GPIO support. Additionally, this includes fixes 
> for SPI communication and for IIO interface, and also code improvements
> to enhance maintainability and readability.
> 

Hi Jonathan,

Looks like the remaining feedback is minor (and had none to add),
so this might make this cycle.  Unfortunately I'm travelling this week
but I'll try and grab some time to pick up a few things that are very
nearly ready like this.  Anyhow, hopefully v8 is the magic one.

Thanks,

Jonathan

> ---
> Changes in v7:
> * Added a new patch to reorganize driver headers.
> * Added the new files to MAINTAINERS.
> * Added dependencies to constrain the use of trigger-sources and
>   adi,sync-in-gpios properties at the same time.
> * Self triggering is enabled only when the trigger-sources property is
>   not defined. Added TODO to support other trigger sources when the subsystem
>   is available.
> * Refactor code to avoid forward declarations.
> * Mentioned that sampling frequency changes is not allowed in
>   buffered mode.
> * Addressed review comments, see individual pacthes.
> * Link to v6: https://lore.kernel.org/linux-iio/cover.1745605382.git.Jonathan.Santos@analog.com/T/#t
> 
> Changes in v6:
> * Changed description and addressed other nits in the gpio-trigger patch.
> * Rewrote the #trigger-sources-cells description and removed mentions 
>   to offload engine.
> * Added adi,ad7768-1.h header with macros for the trigger source cells.
> * removed of_match_ptr() from regulator_desc.
> * Replaced deprecated .set callback with .set_rv in the gpio controller
>   patch.
> * Use `trigger-sources` as an alternative to `adi,sync-in-gpios`
>   (now optional), instead of replacing it.
> * Check trigger source by the compatible string (and the dev node for the
>   self triggering).
> * Addressed review comments, see individual pacthes.
> * Link to v5: https://lore.kernel.org/linux-iio/cover.1744325346.git.Jonathan.Santos@analog.com/T/#t
> 
> Changes in v5:
> * Added gpio-trigger binding patch.
> * Include START pin and DRDY in the trigger-sources description.
> * increased trigger-source-cells to 1: this cell will define the trigger
>   source type.
> * Fixed the holes in the regmap ranges.
> * replace old iio_device_claim_direct_mode() for the new 
>   iio_device_claim/release_direct() functions.
> * Changed some commit messages.
> * Link to v4: https://lore.kernel.org/linux-iio/cover.1741268122.git.Jonathan.Santos@analog.com/T/#t
> 
> Changes in v4:
> * Added missing `select REGMAP_SPI` and `select REGULATOR` to the device's Kconfig.
> * VCM output regulator property renamed.
> * Added direct mode conditional locks to regulator controller callbacks.
> * Renamed regulator controller.
> * Created helper function to precalculate the sampling frequency table and avoid
>   race conditions.
> * Link to v3: https://lore.kernel.org/linux-iio/cover.1739368121.git.Jonathan.Santos@analog.com/T/#t
> 
> Changes in v3:
> * Fixed irregular or missing SoBs.
> * Moved MOSI idle state patch to the start of the patch, as the other fix.
> * fixed dt-binding errors.
> * Trigger-sources is handled in a different way, as an alternative to sync-in-gpio.
>   (this way we avoid breaking old applications).
> * VCM output is controlled by the regulator framework.
> * Added a second regmap for 24-bit register values.
> * Add new preparatory patch replacing the manual attribute declarations for
>   the read_avail from struct iio_info.
> * included sinc3+rej60 filter type.
> * Addressed review comments, see individual pacthes.
> * Link to v2: https://lore.kernel.org/linux-iio/cover.1737985435.git.Jonathan.Santos@analog.com/T/#u
> 
> Changes in v2:
> * Removed synchronization over SPI property and replaced it for trigger-sources.
> * Added GPIO controller documentation.
> * VCM output control changed from an IIO attribute to a devicetree property (static value).
> * Converted driver to use regmap and dropped spi_read_reg and spi_write_reg pacthes.
> * replaced decimation_rate attribute for oversampling_ratio and dropped device specific documentation patch.
> * Added low pass -3dB cutoff attribute.
> * Addressed review comments, see individual pacthes.
> * Link to v1: https://lore.kernel.org/linux-iio/cover.1736201898.git.Jonathan.Santos@analog.com/T/#t
> 
> Jonathan Santos (11):
>   iio: adc: ad7768-1: reorganize driver headers
>   dt-bindings: trigger-source: add generic GPIO trigger source
>   dt-bindings: iio: adc: ad7768-1: add trigger-sources property
>   dt-bindings: iio: adc: ad7768-1: Document GPIO controller
>   dt-bindings: iio: adc: ad7768-1: document regulator provider property
>   iio: adc: ad7768-1: add regulator to control VCM output
>   iio: adc: ad7768-1: add multiple scan types to support 16-bits mode
>   iio: adc: ad7768-1: add support for Synchronization over SPI
>   iio: adc: ad7768-1: replace manual attribute declaration
>   iio: adc: ad7768-1: add filter type and oversampling ratio attributes
>   iio: adc: ad7768-1: add low pass -3dB cutoff attribute
> 
> Sergiu Cuciurean (1):
>   iio: adc: ad7768-1: Add GPIO controller support
> 
>  .../bindings/iio/adc/adi,ad7768-1.yaml        |  68 +-
>  .../bindings/trigger-source/gpio-trigger.yaml |  40 +
>  MAINTAINERS                                   |   4 +-
>  drivers/iio/adc/Kconfig                       |   1 +
>  drivers/iio/adc/ad7768-1.c                    | 905 +++++++++++++++---
>  include/dt-bindings/iio/adc/adi,ad7768-1.h    |  10 +
>  6 files changed, 918 insertions(+), 110 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/trigger-source/gpio-trigger.yaml
>  create mode 100644 include/dt-bindings/iio/adc/adi,ad7768-1.h
> 
> 
> base-commit: 9415c8b5b9b7ba927d98f80022a2890e8639e9e4
> prerequisite-patch-id: fbb33747cd0293bacd5b6d801d6cfc087449a28e


