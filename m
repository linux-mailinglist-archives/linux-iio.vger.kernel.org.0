Return-Path: <linux-iio+bounces-24972-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A16BD05ED
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 044171890AF5
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0482F25E5;
	Sun, 12 Oct 2025 15:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaZXVfB/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61092ECE83;
	Sun, 12 Oct 2025 15:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760282681; cv=none; b=K0Bj2I1Dbkg9fA2Sw1o3UdLYS98VSA1nWuQEyCzhVIilHva1t0S8vUf89sZvRXZC3czKqhEIkDSsccaFxK6VYSwW7n/0X5nokeshpvTmqt5YXc73puh7TgQllZgQf2W7DNLeAGcXtNsM/zmto0M4f+6fqhc3B4PEe5A5YA9e53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760282681; c=relaxed/simple;
	bh=g2SFX0qPxTVarJxY/3TZfIJCCltx2hbCOXAn1Im6VrU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MErAGv99B1hJElzxgTdXMRF7TDQAklYnUEWiDkpORzvO1dYDj60BxUUk3lcL0IKa8JM77ySatrROKyzQGyo9RLBTLCgmvovU29XHitVey+VXefaKHs+wl/4rw4KCkhDlPXb0scESqz37Fo3ik+JebJborCeG3ABzh/Pp2aeP/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaZXVfB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6440C4CEE7;
	Sun, 12 Oct 2025 15:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760282678;
	bh=g2SFX0qPxTVarJxY/3TZfIJCCltx2hbCOXAn1Im6VrU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XaZXVfB/Gc5GeRmmPeaK58oiWeIscQ1U4heLvUqE7IjbYkUCHU1DRDDL1ZsXWN3tp
	 JaPYd5+miWYmz/4fEG3e667GZY1i+10AKzJiMybvElZIoK+/SaU2HzbQAjAii/DUMY
	 WA+R3UmbjqiaNw8+CxxaFZUPSgJPD1tt5c9B7Fz4ffzOGyNN9YIAsa3cGAiEIStsV4
	 QXbRGYcI0m76knAdaWzMRdAxqEb0gCYUWI3UStqpUe55kXE0hwiE4K7/5Wknbyt6bp
	 il3WGYxpXOCOko0R4FEKCzMn6P+8xmQb6Y5u7pMHfsgzcOHU7RLYjEpcS8Cny1/U8c
	 xmCn6qzVXDWEA==
Date: Sun, 12 Oct 2025 16:24:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 19/19] iio: accel: bma220: add maintainer
Message-ID: <20251012162429.47d24cad@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-19-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-19-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:28 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add maintainer for this driver.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied. Thanks for stepping up to maintain this going forwards

Jonathan

> ---
> v1->v4 no change
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f090c2f6e63a0d255a025885cc4573f5802ef159..aaeb4ae6fd2282264da7e61b6fc32c00fc90a5ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4402,6 +4402,13 @@ F:	include/net/bond*
>  F:	include/uapi/linux/if_bonding.h
>  F:	tools/testing/selftests/drivers/net/bonding/
>  
> +BOSCH SENSORTEC BMA220 ACCELEROMETER IIO DRIVER
> +M:	Petre Rodan <petre.rodan@subdimension.ro>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/accel/bosch,bma220.yaml
> +F:	drivers/iio/accel/bma220*
> +
>  BOSCH SENSORTEC BMA400 ACCELEROMETER IIO DRIVER
>  M:	Dan Robertson <dan@dlrobertson.com>
>  L:	linux-iio@vger.kernel.org
> 


