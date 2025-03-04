Return-Path: <linux-iio+bounces-16346-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FA16A4E131
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:38:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B97C83BD531
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918A120C48A;
	Tue,  4 Mar 2025 14:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cfy8P4FI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45A3A20B1E8;
	Tue,  4 Mar 2025 14:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741098474; cv=none; b=DM6LoKJ3WByz2g+qver5QdBjgUoFLOj8Q/wUJg1LWioO2uE4VECFhPKT/IYdhhxqshiC94AAICaYQGljoeyPIXEorBSz8T8iWTMt8UykVhJmqLVD31Ira7qHHP1nJWqeunviqiHGy3wDAm5+l/nilKyr1Gx0LcRFsnXlpJ+xHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741098474; c=relaxed/simple;
	bh=zwBkiv0jR98E/16OURLG7ddEECe4p2gZPQLDDNbkETY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bj3xHQG7P/hWiywKxiS6nbvf3H++O4UBcf6o5tBl14dI405ditGo2bCON6Vud31bVdIShgMi9sXd+p8nGMfAsfWF796STU7Mys3swFhkkyJK3IX2cTeAHKhi+PMwlM5XjvqfPrqT3A/3kBoClZQlBUDbT14D1xu042bzu12paww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cfy8P4FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF688C4CEE5;
	Tue,  4 Mar 2025 14:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741098473;
	bh=zwBkiv0jR98E/16OURLG7ddEECe4p2gZPQLDDNbkETY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cfy8P4FIB6sGg2BeSAzl/qCC9hAIio4DBHuGNnd823DCSYSnCPV+d96oJVXONNaWn
	 MwuvSOC9fSqxzhieTayC0Smm4BMfDp7Xu+3YqIbnJeAdabFK2eVkP+podTPl0ktZ+B
	 TseGs1rv78goEpg95cwc+EADppnb5uJqNtS6vioy4y3e6CXpS2eIUHmHiyrmkNl/GW
	 R4qI0FNuFUS4qoK3lbq3CU5KcXkuHIgbaS0a0p9EzkEZIOZ+vLwWq/cKXmedIzxdaF
	 6r+9MmTKBoZRUMiNLZB7FCgmiA0c2n8KpHd2iQbnmukZjmKUqdsg6n6hEiWzm25bRm
	 uBvHQa2ar2Pqw==
Date: Tue, 4 Mar 2025 14:27:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-fbdev@vger.kernel.org, linux-iio@vger.kernel.org, Michael Hennerich
 <michael.hennerich@analog.com>
Subject: Re: [PATCH] MAINTAINERS: remove adi,ad7606.yaml from SEPS525
Message-ID: <20250304142742.7ea52a67@jic23-huawei>
In-Reply-To: <20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-v1-1-a4e4f1b824ab@baylibre.com>
References: <20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-v1-1-a4e4f1b824ab@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 03 Mar 2025 14:39:57 +0000
David Lechner <dlechner@baylibre.com> wrote:

> Remove Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml from
> STAGING - SEPS525 LCD CONTROLLER DRIVERS. This was likley a copy/paste
> mistake. There is no bindings file for SEPS525 since it is only in
> staging.
> 
> The removed file matches Documentation/devicetree/bindings/iio/*/adi,*
> under ANALOG DEVICES INC IIO DRIVERS already so wasn't just misplaced.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I'll apply it.

Jonathan

> ---
> This falls under FBTFT which is currently orphaned, so someone else will
> have to volunteer to pick this up.
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8e0736dc2ee0e33544fa373a4978b7dae18c040c..215dbaeedced8473b5b339329b3596a2fbfd13b1 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -22512,7 +22512,6 @@ STAGING - SEPS525 LCD CONTROLLER DRIVERS
>  M:	Michael Hennerich <michael.hennerich@analog.com>
>  L:	linux-fbdev@vger.kernel.org
>  S:	Supported
> -F:	Documentation/devicetree/bindings/iio/adc/adi,ad7606.yaml
>  F:	drivers/staging/fbtft/fb_seps525.c
>  
>  STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER
> 
> ---
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6
> change-id: 20250303-maintainers-remove-adi-ad7606-yaml-from-seps525-lcd-controller-b77d4c4bf54a
> 
> Best regards,


