Return-Path: <linux-iio+bounces-10514-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E063199B559
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 16:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 968F01F22909
	for <lists+linux-iio@lfdr.de>; Sat, 12 Oct 2024 14:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB301925A8;
	Sat, 12 Oct 2024 14:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5qXowmG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F03691E481;
	Sat, 12 Oct 2024 14:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742383; cv=none; b=bdepXVnJlLj6HKHBSuQRuJaVqR34+Dc0tWpHeqFqbrlKbGDitXoBr8xkMLldeIG4BvPMfjuXECmuvYmQWau6fZkiUrw8qQ49EPB6pfYWxHNzautz04SwqP+rs4FvHvtIKKrhkGPXA1qYdOTxfJebAgsF6jBoJhRe83IRe0pisqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742383; c=relaxed/simple;
	bh=LE6pKsITwGzkRTuRFHGO7N8dIIweBV5uI/AAlPe/eJY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hl20Bv+xuwPsMK5Q+Bf85BgXsCp5fHzmmxOolcSU3cyCCSeU7AaXjDkbIXOK5mT/R/kPPKvQUSgP20Xw7+XDwIH8HM542s5YIcwM00RXGAFEk/PeivJlAYT4W3C4c+pbI+893yGpWF6aoC+EwS52qeMsGO3/kv3E4DWWku4GU18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5qXowmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC00FC4CEC6;
	Sat, 12 Oct 2024 14:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728742382;
	bh=LE6pKsITwGzkRTuRFHGO7N8dIIweBV5uI/AAlPe/eJY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=F5qXowmGjQSueJ30lQVUD2YXDw8xSUu58H2aY2XjbAbRVNbriYOvatelu251f5WU3
	 4/epL/0pENbPYGOpsOynAdvDCx1WMJYOB2FpbCDQwY3rZvBHBsLpcA7V13+hFDcNaC
	 0c6y66+IzW85YANBW5VRiWTy7+BeSr6UUx3y0YfYPhp/6meuxJldWZewoCRX8B4MjL
	 CJZ2c5LaLz6hMTJ2iKaZCQyl2SLkGvfDTaGIsCiuu4O0oK08T/LzbwAUtz6xMSgUHt
	 spXYcqMfvTHCY6SIkAMiCRXUFk01uoVqPHNB3XNnMQo3RSYlZKOQ1FhtbGp0VONjA3
	 C3XUvXmiqQXvQ==
Date: Sat, 12 Oct 2024 15:12:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Rishi Gupta <gupt21@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add entry for VEML6030 ambient light
 sensor driver
Message-ID: <20241012151258.008d19af@jic23-huawei>
In-Reply-To: <20241008-veml6030-maintainer-v1-1-701accdba961@gmail.com>
References: <20241008-veml6030-maintainer-v1-1-701accdba961@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 08 Oct 2024 18:22:07 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> Add an entry in the MAINTAINERS file for this driver after contributing
> to it.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Thanks for taking this on.

Applied.
> ---
> Maintenance of this driver has been agreed with the original author,
> who has been added to the recipients.
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9ed1921f6bf2..7beb8e6656ee 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24732,6 +24732,12 @@ S:	Maintained
>  F:	drivers/input/serio/userio.c
>  F:	include/uapi/linux/userio.h
>  
> +VISHAY VEML6030 AMBIENT LIGHT SENSOR DRIVER
> +M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
> +F:	drivers/iio/light/veml6030.c
> +
>  VISHAY VEML6075 UVA AND UVB LIGHT SENSOR DRIVER
>  M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
>  S:	Maintained
> 
> ---
> base-commit: 33ce24234fca4c083e6685a18b460a18ebb5d5c1
> change-id: 20241008-veml6030-maintainer-4cddc8d7e9bf
> 
> Best regards,


