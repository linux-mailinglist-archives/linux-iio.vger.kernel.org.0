Return-Path: <linux-iio+bounces-20838-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D116AE2F64
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 12:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4E5E3B0F53
	for <lists+linux-iio@lfdr.de>; Sun, 22 Jun 2025 10:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF9E1C84CF;
	Sun, 22 Jun 2025 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NflVXeM6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C183597E;
	Sun, 22 Jun 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750588401; cv=none; b=Ivw5KJN70rlCnf4jMDsWosXEBerchKouWzcWcII1A0FqLdpPmbgZ9zb/GeVxwNMcSXs9Jg6crUZRicbDDfUr9nQwzqe+SMlP4/U/YgcetuCA233K9RKlSYKijubCUFGoAfhgBgIvJnJ41cekejka4n07bocZxomabUL9gUXOP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750588401; c=relaxed/simple;
	bh=b9b5MF6Zks2TQjfQ9qZZjsvCg10QFCpVoKEPTqxud7A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bVGidJ4Y3gGZSp3i6/FpG/nVF6jBWnJWu1MOugt6ftB4rUL9ugi9DlA6ryyht1CSDeSLU3I1R//t9AWSVgQLzKPPR805F/QePVz/Pod5xmrAR7BhWhAFVXwba2zL/yqCTziEgXEUNc89ZVb7Q9XEbVz4Lk7LV3J2Oqrb2fd9L0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NflVXeM6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4150C4CEE3;
	Sun, 22 Jun 2025 10:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750588400;
	bh=b9b5MF6Zks2TQjfQ9qZZjsvCg10QFCpVoKEPTqxud7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NflVXeM6B6qv8UcBnss/N7rXoZ7V/Fa0auRghogwCNAjbS0diQ5bVKuNtN4O0HpF2
	 YHClvUvdVm0kTJpY6okbx8bWX/fRbmULLCaXISvnW2b7bvCzIkIZt/npqStq3wga/2
	 EyPoe6XGTrznb8VBf9m4GKrnKua71bXwO0qkHpSPs/v+hJHtScvHDWLcgqkTGh75OB
	 0eb98gMF90U5JajT6b3Nnesod344dtWnCNVGNMk/Mn2kZflY4ltLOGqkFGFpUQ4NX7
	 g0BvjXurNncOkns92X913FjbYkEfEo5jk1s+KcAqQJ9vYm0H8dO1NLd5htdfZemZgt
	 zx/Bp6SAx9sSQ==
Date: Sun, 22 Jun 2025 11:33:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Waqar Hameed <waqar.hameed@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, <kernel@axis.com>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] Add driver for Nicera D3-323-AA PIR sensor
Message-ID: <20250622113312.1e60b008@jic23-huawei>
In-Reply-To: <cover.1749938844.git.waqar.hameed@axis.com>
References: <cover.1749938844.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 Jun 2025 00:13:52 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Nicera D3-323-AA is a PIR sensor for human detection. It has support for
> raw data measurements and detection notification. The communication
> protocol is custom made and therefore needs to be GPIO bit banged.
> 
> Previously, there has been an attempt to add a driver for this device
> [1]. However, that driver was written for the wrong sub-system. `hwmon`
> is clearly not a suitable framework for a proximity device.
> 
> In this series, we add a driver for support for event notification for
> detections through IIO (the more appropriate sub-system!). The various
> settings have been mapped to existing `sysfs` ABIs in the IIO framework.
> 
> The public datasheet [2] is quite sparse. A more detailed version can be
> obtained through the company.
> 
> [1] https://lore.kernel.org/lkml/20241212042412.702044-2-Hermes.Zhang@axis.com/
> [2] https://www.endrich.com/Datenbl%C3%A4tter/Sensoren/D3-323-AA_e.pdf
> 
> Changes in v2:
> 
> [dt-bindings]
> * Convert `vdd-gpio` to a `vdd-supply`.
> * Rename `clk-vout-gpio` to `vout-clk-gpios`.
> * Add description for `data-gpios` explaining the rename to a more
>   descriptive name.
> * Drop all references to driver.
> * Remove unused gpio include in examples.
> * Re-phrase commit message to only describe the hardware.
> 
> [iio]
> * Add newline after variable definitions inside the for-loop in
>   `d3323aa_set_lp_filter_freq()`.
> * Remove error code in string in `dev_err_probe()`.
> * Remove driver name macro and use it inline instead.
> * Format filter gain arrays into one line.
> * Drop structure comment in `probe()`.
> * Format sentinel value in `of_device_id` with a space.
> * Rename `gpiod_clk_vout` to `gpiod_clkin_detectout`.
> * Request `vout-clk` GPIO to match rename in dt-bindings.
> * Use the regulator framework for supply voltage.
> * Use only one IRQ handler for both reset and detection.
> * Reword comment about Vout/CLK ramp-up behavior (it's because of VDD charging
>   up).
> * Add comment for why we have both `IRQF_TRIGGER_RISING` and
>   `IRQF_TRIGGER_FALLING`.
> * Rename `regmap` to `regbitmap` to not confuse with the `regmap`-framework.
> * Move `d3323aa_setup()` into the set-functions.
> * Use state variables in `d3323aa_data` instead of bitmap and move bitmap
>   handling to read/write settings functions.
> * Pad bitmap with compulsory end pattern in `d3323aa_write_settings()`.
> * Add `d3323aa_set_hp_filter_freq()` and allow userspace to set it.
> 
> Link to v1: https://lore.kernel.org/lkml/cover.1746802541.git.waqar.hameed@axis.com/
> 
> Waqar Hameed (3):
>   dt-bindings: vendor-prefixes: Add Nicera
I guess you didn't +CC linux-iio on this as I'm not seeing it locally.

Given the whole series including that patch will ultimately go through
the IIO tree, please make sure to include that on the next version.

Jonathan

>   dt-bindings: iio: proximity: Add Nicera D3-323-AA PIR sensor
>   iio: Add driver for Nicera D3-323-AA PIR sensor
> 
>  .../iio/proximity/nicera,d3323aa.yaml         |  60 ++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/iio/proximity/Kconfig                 |   9 +
>  drivers/iio/proximity/Makefile                |   1 +
>  drivers/iio/proximity/d3323aa.c               | 808 ++++++++++++++++++
>  5 files changed, 880 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/nicera,d3323aa.yaml
>  create mode 100644 drivers/iio/proximity/d3323aa.c
> 
> 
> base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282


