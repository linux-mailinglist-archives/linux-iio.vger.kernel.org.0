Return-Path: <linux-iio+bounces-26108-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D130FC4446D
	for <lists+linux-iio@lfdr.de>; Sun, 09 Nov 2025 18:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 513944E63A2
	for <lists+linux-iio@lfdr.de>; Sun,  9 Nov 2025 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918DD3074AF;
	Sun,  9 Nov 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ShYh8nZk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC44307486;
	Sun,  9 Nov 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762708732; cv=none; b=YaLnf2r18F41W0XWLJzt5l6a1EhpiWvcpR32aTSPwyNMh9fbH2/9WzfGIS2NDEFetxnxU/ycCFy7SXAQW8VZYi5s6P9fZVz6o9S0DG8UQlLflZ0PAYUNcA8GW09GFjupjc98Hf6IasR8N3VxrLna3+uiDTS1pEell+wzNbfYKAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762708732; c=relaxed/simple;
	bh=Q2fI1+bHl2Igjaaj5gGVaw6PsXmW3Hxdw7GJHyoQ7fM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NeWnti4xDQ83vd7mWVJutZe/EZJzB+kWUvS5mv1DNibx3bgZFHe+ZNSfLSdaa1uvHb0EB8Fq7j8uzhnz+urxD6hhCdyAxWnrgPl59qQHUqToW0qDoYZ++9cOh3u0ZlI/No9DEuVYrN2dJJmlbrloQKqucSdY/w10IQXluwBoQfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ShYh8nZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7C9C4CEF8;
	Sun,  9 Nov 2025 17:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762708730;
	bh=Q2fI1+bHl2Igjaaj5gGVaw6PsXmW3Hxdw7GJHyoQ7fM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ShYh8nZkIBR/kVDC9zLZdxVo0r0K3HN49U7eRUY+J7Osd76wuA37J+8oKfB3SiRDs
	 N2dgvujFyfwhTziuGEIrdDjoTbbHDIu/ybUMvQe5QHeF6ugEe6oudsZldOixkIR5xa
	 PsZb5fg/1v8f+cPgrZTxJJEwsd+xybiFjRoaeQDwVe/5KytTBMm8222tDWRNxWHQlc
	 tpLOPyX5EargCDgIugB5UB4E4aKo4DbosnMJiGnlDgqQSh7cL9xJ48OIfFx/Top+27
	 culYwopnIW8pdMwHN8SvJvPgSeNcNdjK+1KpLWL3TZeKwL3Zbld+YlXySz5e0L15eG
	 T5lCMk1HDlgQQ==
Date: Sun, 9 Nov 2025 17:18:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: ABI: adl8113: add documentation
Message-ID: <20251109171822.135460aa@jic23-huawei>
In-Reply-To: <20251108174357.3748-4-antoniu.miclaus@analog.com>
References: <20251108174357.3748-1-antoniu.miclaus@analog.com>
	<20251108174357.3748-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 8 Nov 2025 17:43:54 +0000
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add ABI documentation for the ADL8113 Low Noise Amplifier,
> covering the 4 pin-selectable operating modes.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

I'm still reluctant to have a mode parameter because they are close
to unusable because they always indicate something highly device
specific that no generic userspace can make use of.

My hang up continues to be that the first two are normal _scale
controls, but the 2nd two are saying use this path for the signal
with analog components in it, but providing no info on what that
means wrt to what is measured.

If we do go ahead with this, then it needs a more specific name
to avoid trampling on the namespace as "mode" would.
> ---
> 
> Changes in v2:
> - Enhance external_bypass_a mode description: clarify signal routing from RFIN to OUT_A and from IN_A to RFOUT
> - Enhance external_bypass_b mode description: clarify signal routing from RFIN to OUT_B and from IN_B to RFOUT
>  .../testing/sysfs-bus-iio-amplifiers-adl8113  | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113 b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> new file mode 100644
> index 000000000000..6e3994283a45
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-amplifiers-adl8113
> @@ -0,0 +1,32 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/mode
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute allows the user to set the operation mode of the
> +		ADL8113 Low Noise Amplifier. The available modes control signal
> +		routing through different paths within the device.
> +
> +		The supported modes are:
> +
> +		* internal_amplifier - Signal passes through the internal low
> +		  noise amplifier (VA=0, VB=0). Provides 14dB gain.
> +
> +		* internal_bypass - Signal bypasses through internal bypass path
> +		  (VA=1, VB=1). Provides 0dB gain.
> +
> +		* external_bypass_a - Signal routes from RFIN to OUT_A and from IN_A to RFOUT
> +		  (VA=0, VB=1). Provides 0dB gain.
> +
> +		* external_bypass_b - Signal routes from RFIN to OUT_B and from IN_B to RFOUT
> +		  (VA=1, VB=0). Provides 0dB gain.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/mode_available
> +Date:		January 2025
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this attribute returns a space-separated list of all
> +		available operation modes for the ADL8113 device. The modes
> +		control the signal path and determine whether the signal passes
> +		through the internal amplifier or various bypass paths.


