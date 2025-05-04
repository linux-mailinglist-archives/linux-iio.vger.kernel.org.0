Return-Path: <linux-iio+bounces-19050-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2D1AA87F8
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8235A1898D3B
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345621D63CF;
	Sun,  4 May 2025 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="diEQgoGH"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7031B3957;
	Sun,  4 May 2025 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375646; cv=none; b=kWpuYYlAGanHnd0RosVPD3VuNGSbhQpdsj+wnyYLa3a52+xBpMu39K2kByVVSm1wU/J6wsCK2PM/U+DzLsC9Zreb4XpxfGezcjnMXeP+4y8nFCV/wSf7/4f1APOqDWSSJuzLQNG7kUEgQ3/UCErAWmI2KxxaybYAk8LmvKorbQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375646; c=relaxed/simple;
	bh=8SGKrwFsi6MSGg1AkOsX7EbuWyf4IOy6I9k86qXwR5o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QJppkii1pv5na5j1iCOOGWSfdcy7ciJuVHsA9VO0fBMn/ZBz1lf3QbAX1Ev3yhft0CEjiclF513NtSyVXFKHiGjEbC8lt1qyuE+IfewobWsaRt0uN0nqbPNV3WQZyqP7sTK+lJta8Rob0jc6r3v8D93zj0lATbjPxr1uuwIzvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=diEQgoGH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B47C4CEED;
	Sun,  4 May 2025 16:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746375645;
	bh=8SGKrwFsi6MSGg1AkOsX7EbuWyf4IOy6I9k86qXwR5o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=diEQgoGHb4QlcwRjRjhFNpHordBbmX2YI7DoQFo0LlesJA9RE/dzCML+UxCx7sW0D
	 89I5ZRX1FvabdAg4KLmjy491B7qQex8Mw+E82cv6NnLFOEt0tL5Ku91Ud7xtkJQQxl
	 /kqQIS4N4fC2UevTvNmGITHZR+57QFnlkyTl0YJ0gj/XIafkRnqojzi0sQ1j1/IoXG
	 gza8fKcWPhsqlmyLxQnZqZ+SaEGclgAFql4pQ29LEpXKnB/uxC0b/CgSuG3DVe3S0i
	 /xcZw0hDBPweZAi+fnHfKXrphoDbjv+zRlCwubC92upOyveDn7f7/W5CJDPAUIPGdv
	 AZVHVN5f4KkUQ==
Date: Sun, 4 May 2025 17:20:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] iio: adc: Add initial support for TI ADS1262
Message-ID: <20250504172034.2ab4936a@jic23-huawei>
In-Reply-To: <20250501100043.325423-1-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 15:30:38 +0530
Sayyad Abid <sayyad.abid16@gmail.com> wrote:

> The ADS1262 is a 32-bit, high-resolution delta-sigma ADC communicating
> over SPI. It's designed for precision measurements.
> 
> This initial driver provides the basic functionality needed to:
>  - Probe and register the device via SPI.
>  - Expose standard IIO channels for reading raw voltage samples.
> 
> Basic testing was performed on a Raspberry Pi Zero 2W using the hardware
> SPI0 interface. The connections used were:
> 
> +-----------------+            +-----------------+
> | RPi Zero 2W     |            | TI ADS1262      |
> | (SPI0 Pins)     |            |                 |
> |-----------------|            |-----------------|
> | MOSI            |----------->| DIN             |
> | MISO            |<-----------| DOUT/DRDY       |
> | SCLK            |----------->| SCLK            |
> | CE0             |----------->| /CS             |
> | 5V              |----------->| DVDD, AVDD      |
> | GND             |----------->| DGND, AGND      |
> +-----------------+            +-----------------+
> 
> I would greatly appreciate any feedback on the driver structure,
> IIO integration, SPI communication handling, or any potential issues
> or areas for improvement you might spot.
> 
> This series is broken down as follows:
>  Patch 1: Adds the core driver code (ti-ads1262.c).
>  Patch 2: Adds the Kconfig option.
>  Patch 3: Adds the Makefile entry for compilation.
>  Patch 4: Adds the MAINTAINERS entry.
> 
> Thanks for your time and consideration.

Hi Sayyad

As a general rule, an RFC is usually meant to contain a list of open
questions or some clear statement on why it is not ready for consideration
as a final driver submissions. Often that is something like some other
ongoing discussion that needs to conclude.

I'm not seeing such questions, so I'm guessing this was just a bit of
a lack of confidence?  In general it looks pretty good so drop the RFC on
v2 :)

Jonathan

> 
> Sayyad Abid (5):
>   iio: adc: ti-ads1262.c: add initial driver for TI ADS1262 ADC
>   iio: adc: Kconfig: add Kconfig entry for TI ADS1262 driver
>   iio: adc: Makefile: add compile support for TI ADS1262 driver
>   MAINTAINERS: add entry for TI ADS1262 ADC driver
>   dt-bindings: iio: adc: add bindings for TI ADS1262
> 
>  .../bindings/iio/adc/ti,ads1262.yaml          | 189 ++++++++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/adc/Kconfig                       |  12 +
>  drivers/iio/adc/Makefile                      |   1 +
>  drivers/iio/adc/ti-ads1262.c                  | 438 ++++++++++++++++++
>  5 files changed, 647 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1262.yaml
>  create mode 100644 drivers/iio/adc/ti-ads1262.c
> 
> --
> 2.39.5
> 
> 


