Return-Path: <linux-iio+bounces-27381-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E6BDCE006C
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 75F61300501B
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 17:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6421D619F;
	Sat, 27 Dec 2025 17:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Guaht01e"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C983A1E66;
	Sat, 27 Dec 2025 17:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766857571; cv=none; b=X10zEy27PB8Ptg6Zi8k5E15G2aZvWzHvriCZOgCcGeDFgyGSwUakgjJX5v5dzX2606YMMnHxwSgRz9/vJFS+707VpAIf2whPQTRELQy0gMmqk2t7ZBguh1QOzDaafxjk4ont8I6GA2C9weXk+KAIOJ7xmwu5eLF2hy+NSwCYj08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766857571; c=relaxed/simple;
	bh=Oe1q4vqbiNucWodqKNEldX869a2igibZ1Zyy/x4dxzI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jtNjldqqRiBSvCmMbSJPZuU7tE5fSyug04zAyulpYkdkYo0IEtVc4HVtqmb4RkfynwtgG/qUmIQVjw5YaSe2NKiqxhkV59/ri7t61hpPwkFttSVsS4p5HWAp8GGlHpYHqXY3NUMxqYdqBwbMz0ycSoRRWN53ZTCouE7eCX7ohJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Guaht01e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52410C4CEF1;
	Sat, 27 Dec 2025 17:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766857570;
	bh=Oe1q4vqbiNucWodqKNEldX869a2igibZ1Zyy/x4dxzI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Guaht01elJXwVq7Fdbpz/qQYbI59qU+xUrCAd9PZ81+1ZSLncX6u3OoT7k2MYnKp1
	 2lRHo1PRPAhe9HqB3rbEFbCWGz40FWAJm0QYJiV20pYfYnbvM63NL1gElE9ykSm+1q
	 GSEzlbBYItyIQ6Rnj/GaF3WM4ZY63eSaV8uVkfZFnZvsVKYifoa52YYS/o/MNjgi69
	 B7qRuXsoevhfO1WqIKx9PuFrWLPiBVUz4TBx8FBHIlMTIk3PmJuZ6/fF5/itJ/gT5z
	 GQUAfZv98j+wtYaGT8h12A4f5yqBqSydQyuKWPE630do/2RjQPFRYv7r1sZ7LwA5RE
	 EMgg5MIkLNEDg==
Date: Sat, 27 Dec 2025 17:45:59 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Shrikant Raskar <raskar.shree97@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 heiko@sntech.de, neil.armstrong@linaro.org, skhan@linuxfoundation.org,
 david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] iio: proximity: Add interrupt support for
 RFD77402
Message-ID: <20251227174559.33539640@jic23-huawei>
In-Reply-To: <20251221083902.134098-1-raskar.shree97@gmail.com>
References: <20251221083902.134098-1-raskar.shree97@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 21 Dec 2025 14:08:58 +0530
Shrikant Raskar <raskar.shree97@gmail.com> wrote:

> This patch series adds:
>  - Add RF Digital vendor prefix
>  - YAML binding for RFD77402
>  - Add OF device ID for enumeration via DT
>  - Use kernel helper for result polling
>  - Interrupt handling support
>  
> These changes enable DT-based configuration and event-driven
> operation for the RFD77402 Time-of-Flight sensor.

Hi Shrikant,

I'm only seeing this cover letter (and lore doesn't seem
to have the patches either).  Probably need to resend them.

Thanks,

Jonathan


> 
> Changelog:
> Changes since v2:
> - Add 'Reviewed-by' tag to dt-binding patch.
> - Update commit message in OF device ID patch.
> - Update commit message in the third patch.
> - Replace rfd77402_result_polling() with read_poll_timeout().
> - Add 'struct rfd77402_data' details in kernel-doc format.
> - Arrange includes in order.
> - Add comment for completion timeout value.
> - Remove blank lines.
> - Indent the comments to code.
> - Convert mutex_init() to devm_mutex_init().
> - Remove 'IRQF_TRIGGER_FALLING' flag from devm_request_threaded_irq().
> - Drop the duplicate message.
> - Replace 'dev_info' with 'dev_dbg()'.
> - Update 'dev_id' to 'pdata' in rfd77402_interrupt_handler().
> - Drop 'interrupt mode' comment
> - Use 'if(ret)' instead of 'if(ret < 0) for consistency.
> - Use 'return i2c_smbus_write_byte_data()' in 'rfd77402_config_irq'.
> 
> Shrikant Raskar (4):
>   dt-bindings: iio: proximity: Add RF Digital RFD77402 ToF sensor
>   iio: proximity: rfd77402: Add OF device ID for enumeration via DT
>   iio: proximity: rfd77402: Use kernel helper for result polling
>   iio: proximity: rfd77402: Add interrupt handling support
> 
>  .../iio/proximity/rfdigital,rfd77402.yaml     |  53 +++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  drivers/iio/proximity/rfd77402.c              | 149 +++++++++++++++---
>  3 files changed, 183 insertions(+), 21 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/proximity/rfdigital,rfd77402.yaml
> 
> 
> base-commit: d8ba32c5a460837a5f0b9619dac99fafb6faef07


