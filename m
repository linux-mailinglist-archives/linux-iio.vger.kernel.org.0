Return-Path: <linux-iio+bounces-25238-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B05BBED432
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 483B834D34D
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382F3253359;
	Sat, 18 Oct 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmlCGkmt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DAF21CFEF;
	Sat, 18 Oct 2025 16:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806534; cv=none; b=nnas73HVZj8IATiCc8NONpf0M8vNzDp2noJEieRaEKiljMMFpm7T6tYy3ceHkLNrgG2paMw+zVv5ovODiwaMnRtXIU/G4dzmiP9d+FyDqv3g+s9qVRXBHCB1aTPbL1N8Kze+uX3nyOa20zntNTNzypKth8emo7ctzs8HUY/EM1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806534; c=relaxed/simple;
	bh=wQuVOUx1LwOrjJ/oM10Q4tmV44p2BRAttZ1zA7EnbBg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PeNPHPuEtJGI+GXrAgIrE43kxTKcCGoJBa3x/9w2HrISNWbzCsG2woHQnSAimXDWPeajqgYW1d71LydMDHbD6Gniei/4wCXa2TldacJUOSwpnCPVMl7kY9aCPRTXAQRvDNB4+nHLDX+cHvNyrwdPIqt8urVbzIaImWPwH+7fG1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmlCGkmt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAEB6C4CEF8;
	Sat, 18 Oct 2025 16:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806532;
	bh=wQuVOUx1LwOrjJ/oM10Q4tmV44p2BRAttZ1zA7EnbBg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SmlCGkmtQU9P0Y1LjRymqJG9fIGq6OVMDnNsMhM+rAiYKisexQLmxBPhlxLDA0+/5
	 3ywZW16MqimqdJ9cp4s4UX56hPG2pM6hGppAFx79O4YuGPJVNdM0R7jQzYg6CEjNVO
	 t2qGr2EJltnmAJ93Ec2v62B5+7ZW2jfdyYu13ooPBVlq2pwXZKRb+CZtrMW/zuAEoX
	 Q3dSfDQoZ3fKM828R2LAI/KdQwdmKt+hzEIXtzQKBlWPlwVElnxHxQWGlaTfhzclwj
	 jTaC6Em8LL07ipI4VrKByUjdvoXlutkarXfgujFf3YAy3l0TLZZ7ubHRYpgoVudzWC
	 DC7aO0NEYvYDw==
Date: Sat, 18 Oct 2025 17:55:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] iio: accel: bma220: remove useless include
Message-ID: <20251018175527.4b4db411@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-2-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-2-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:42:58 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Remove errno.h include from bma220_i2c.c since error codes are generated
> within bma220_core.c instead.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.
> ---
>  drivers/iio/accel/bma220_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/accel/bma220_i2c.c b/drivers/iio/accel/bma220_i2c.c
> index 5dc7c38f53b3..2b85d4921768 100644
> --- a/drivers/iio/accel/bma220_i2c.c
> +++ b/drivers/iio/accel/bma220_i2c.c
> @@ -8,7 +8,6 @@
>   * I2C address is either 0x0b or 0x0a depending on CSB (pin 10)
>   */
>  
> -#include <linux/errno.h>
>  #include <linux/i2c.h>
>  #include <linux/mod_devicetable.h>
>  #include <linux/module.h>
> 


