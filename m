Return-Path: <linux-iio+bounces-27450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8ADCEC796
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 19:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B4753025337
	for <lists+linux-iio@lfdr.de>; Wed, 31 Dec 2025 18:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863773064A9;
	Wed, 31 Dec 2025 18:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTIeLiGG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5F930596D;
	Wed, 31 Dec 2025 18:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767206109; cv=none; b=R5Wbx8totVSk2k2QHLJW1ziP31SpSAnF/o1jw5A2zuqyMd7uwb9Am2zn6TKGfsHPKxz7f04OaQhzn9+9XCsJs91ywJ3+6bQyT2oOFWRmhhVKan503TT7R2ZSBEX/kUy+L9eK3MW/BAdbD3Ii5S668P7Bcv6tRkg7KhTIHiCxPlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767206109; c=relaxed/simple;
	bh=1gKaAaDWngc09h7jLSPvqo8YVe3MpyDLC3yRlnMdTcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VvzQdBAvk7AIIuT13OUWm4tPtx7zzhE3dADMrp1EmLyqCjOfznYe5uHa28MQ3ud06Bbq129KDCrr1tW2VQaX2akFadyuXp5v0PWX+rcWgb7DNxa9/rsTv+91HG48rJW7MYr4wZ284VuJlKUkorzD+Yj7Ntz3XPncFe/K/rlX5YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTIeLiGG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81423C113D0;
	Wed, 31 Dec 2025 18:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767206108;
	bh=1gKaAaDWngc09h7jLSPvqo8YVe3MpyDLC3yRlnMdTcQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YTIeLiGGlekT1Tv9H3QaPix3UnDY2ZijzrDhsDUuLFuG8DW9fMffaMlnW28Vv+gcg
	 X56zF0Xb/X0sjrgHhDtB86m7CI9O721SlgkaKjUbl6nDerrz+BUSQ1sh3BCGBfnv7b
	 YHLhRHfK2nvSOij4EBngZ6OCdxEDrt6PmROhmn20v74oYqoFvQzIZl/AvqosRr9ZY0
	 1NjxD+SefxApNGXAwFukqsKSqI/W53QG4G9DeX77gJ0VNRftY8Emuh84CT/8RBMRSF
	 NsXhBQbHyjvsvF7wR0VA63izyOyeFD1UEug4+8dHK+fxDQtRXAO44u0wYp7i+hZHvR
	 k/uUIjXI5AtgQ==
Date: Wed, 31 Dec 2025 18:35:02 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tomas Borquez <tomasborquez13@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 6/6] staging: iio: ad9832: add sysfs documentation
Message-ID: <20251231183502.26182f0c@jic23-huawei>
In-Reply-To: <20251230203459.28935-7-tomasborquez13@gmail.com>
References: <20251230203459.28935-1-tomasborquez13@gmail.com>
	<20251230203459.28935-7-tomasborquez13@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Dec 2025 17:34:59 -0300
Tomas Borquez <tomasborquez13@gmail.com> wrote:

> Add sysfs ABI documentation for the AD9832/AD9835 Direct Digital
> Synthesizer chips, documenting frequency, phase, output control,
> and pin control attributes.
> 
> Signed-off-by: Tomas Borquez <tomasborquez13@gmail.com>
Hi Tomas,

Good docs, one entry of which reminded me we tend to use powerdown for
output devices rather than _en (for enable)

Jonathan

> ---
>  .../iio/Documentation/sysfs-bus-iio-frequency | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 drivers/staging/iio/Documentation/sysfs-bus-iio-frequency
> 
> diff --git a/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency b/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency
> new file mode 100644
> index 000000000000..10627c19bdb7
> --- /dev/null
> +++ b/drivers/staging/iio/Documentation/sysfs-bus-iio-frequency
> @@ -0,0 +1,40 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequencyZ
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Frequency in Hz for symbol Z of channel Y. The active
> +    frequency symbol is selected via out_altcurrentY_frequency_symbol.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phaseZ
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Phase offset in radians for symbol Z of channel Y. Valid range
> +    is 0 to 2*PI (exclusive). The active phase symbol is selected
> +    via out_altcurrentY_phase_symbol.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_frequency_symbol
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Selects which frequency symbol is active for channel Y.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_phase_symbol
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Selects which phase symbol is active for channel Y.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_enable

Ah. I probably led you astray on this in an earlier review. Would be _en
and added to the standard docs in sysfs-bus-iio in the block that starts with in_energyY_en

However, I think that might not be the right attribute to use based on this
being more similar to a DAC channel than those which are about enabling internal
accumulators. For a DAC the common terminology is about powerdown  (so effectively !enable).
That lines up with the use of SLEEP here on the datasheet.

So I think this should be out_altcurrentY_powerdown and documented in the block
with out_altvoltageY_powerdown in sysfs-bus-iio with a tweak to make the descriptive
text cover currents as well as voltages.

Obviously remember to flip the sense of the control though.

> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Enables (1) or disables (0) the output for channel Y.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altcurrentY_pincontrol_en
> +KernelVersion:	6.19
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +    Enables (1) or disables (0) hardware pin control for frequency
> +    and phase symbol selection on channel Y. When enabled, external
> +    pins control symbol selection instead of software.


