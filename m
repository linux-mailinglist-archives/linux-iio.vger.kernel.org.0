Return-Path: <linux-iio+bounces-12863-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 843409DF224
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 18:08:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD8FEB21651
	for <lists+linux-iio@lfdr.de>; Sat, 30 Nov 2024 17:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7221A38C4;
	Sat, 30 Nov 2024 17:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QV6ICuRe"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322A68468;
	Sat, 30 Nov 2024 17:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732986525; cv=none; b=NdA3wxHzf2a5NrqU6iAPwEgX/bw8MC2X2dhNp5Yge6zBEo5/XbhxRmAL9EERw8UwsXAfHVGiy0Lqk3yUciEa7sFSR1wN7uXkUfp7gj2TbBRLr/raxZ0dw8Su93E9rRWLRPmRUivgA0hvGVnpT+1AUeELdAr/72wciRUa5IhAALo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732986525; c=relaxed/simple;
	bh=5e6YqVUZ69xowZP6jLn3HCJyFj/teuC7HKPN6hs3H6w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=koY007Qych9Ms7Qwpgcrjtp9hBU94zikUymUShOVbOt8XcQ6uE4PWnC+TfOtnyhIn1NY7A8q2GUxwTm7IU5cPW43JLeEvL06euYYYepmUj8hTDKOioinI/H5DdI37AxcVRuZ1TC/Il2W70HOmQE3teJxhe9a+qHATpQbqQ2LW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QV6ICuRe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D40BC4CECC;
	Sat, 30 Nov 2024 17:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732986524;
	bh=5e6YqVUZ69xowZP6jLn3HCJyFj/teuC7HKPN6hs3H6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QV6ICuRe50K0sZ/zsWOjhq+vcnA1lfh2G1F172EBAOXwc2ihH/3YwQk5XElzg2gw0
	 NqjbXYxCBSnqhWZialLoGJelCiQl5uiEfxlDgXPcdF8SaQFjtSjmDUtj6fB6eguF57
	 fBOKWPZwHF7dehVR0myAmYzsw9z7tK8X7aiQBkwjSAuiMjw4jS4dume8LB0dbo98Ui
	 k5O86jDlQrIKG1g2sMUCTiuKRTGJ4Prng55mlHD3eH89zSoklMLvKdP4J2c3oCXWR4
	 kD/L+OYoOx3r+Glp/bYBYdPUedkUkeqN82W9sd530+gJ/85fTQDaSDLFVQCmWtjjUT
	 iq+9PTIZlvyRw==
Date: Sat, 30 Nov 2024 17:08:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Robert Budai <robert.budai@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, "Ramona
 Gradinariu" <ramona.gradinariu@analog.com>, Antoniu Miclaus
 <antoniu.miclaus@analog.com>, "Rob Herring" <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 1/7] iio: imu: adis: Remove documented not used elements
Message-ID: <20241130170835.4c00162d@jic23-huawei>
In-Reply-To: <20241125133520.24328-2-robert.budai@analog.com>
References: <20241125133520.24328-1-robert.budai@analog.com>
	<20241125133520.24328-2-robert.budai@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Nov 2024 15:35:08 +0200
Robert Budai <robert.budai@analog.com> wrote:

> This patch removes elements from adis.h that are documented
> but not used anymore.
> 
> Signed-off-by: Robert Budai <robert.budai@analog.com>
Applied to the testing branch of iio.git.
I'll rebase this early next week after rc1 is out then pushing out as togreg
for linux-next to pick up.

This patch is kind of separate to the rest of the series so can be applied
on it's own.

Jonathan

> ---
> 
> v2:
> - added patch as requested in previous review
> - signed of by submitter
> 
>  include/linux/iio/imu/adis.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
> index e6a75356567a..4bb98d9731de 100644
> --- a/include/linux/iio/imu/adis.h
> +++ b/include/linux/iio/imu/adis.h
> @@ -99,7 +99,6 @@ struct adis_data {
>   * @spi: Reference to SPI device which owns this ADIS IIO device
>   * @trig: IIO trigger object data
>   * @data: ADIS chip variant specific data
> - * @burst: ADIS burst transfer information
>   * @burst_extra_len: Burst extra length. Should only be used by devices that can
>   *		     dynamically change their burst mode length.
>   * @state_lock: Lock used by the device to protect state


