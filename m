Return-Path: <linux-iio+bounces-10243-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F991991E98
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F1132822ED
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F322B176FC5;
	Sun,  6 Oct 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kwPryr9z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C84165F19;
	Sun,  6 Oct 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728222076; cv=none; b=muFxSI35WDUuqueOgN6NTMHskjYOEg8EQugX5T9T1ILk930Et4vkuPfnxgTKAvwkCckj7vV0PS64IfMnwFfNiXLfe41g4TQDbvPLRVhO0Ao3+Iihp79on/XEgaGGLEgnB5AVtq554AXSKx99+xeMwMO6fxwbTVc+Fc5ywu1Xdlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728222076; c=relaxed/simple;
	bh=K5npnAxiexyEfdq03gplw9O57YzXwDpNOCTcMAefvQA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oy5POlQWibNLP0OzySPAfP89NZydZ0POgBHiKwcZ7zf7AfPkZTp+wo5keVkOEDvFx8PE2bFgvzVrnMcpchoJEaoyM62KKhFckCp4pMqEr0Y78OH/0cqHQrCiyvfBybbswbrRN42aEu6WYTnsi8ihoTG9x6MK0EnP51kiRXxhNB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kwPryr9z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EF9C4CEC5;
	Sun,  6 Oct 2024 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728222076;
	bh=K5npnAxiexyEfdq03gplw9O57YzXwDpNOCTcMAefvQA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kwPryr9zZSYcVwAYwtEFngfzwcxq09/A35aTFcAVzaed8EdypCtDGXYbR2xckOxNy
	 cqSaugovHq2qpOHQ8t0G6LgxMzC94ZsyWVNBc9wQSpKvbgdNYg149vxmU4xRt+qPwV
	 u3ffgUjlC3ztBdyyD2fFBn1CZf69IFOvQyK4RBAsaAbJnSp5mpLFUotQVcCkZYMsNW
	 uNpnr4i6fb+OpuRoxP9rMGBgBBkg4E9XgMK463gLUg/VWLTrWpcDjQ9STraxxFV4VY
	 CVwMBhFo8SX+AGWGlZZx+SePQUR6EgoY9eXNVdKeSxmTjxZdg0SuhjatjC/t1412IQ
	 VJsNIWkx/nY8A==
Date: Sun, 6 Oct 2024 14:41:02 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Mihail Chindris <mihail.chindris@analog.com>,
 Olivier Moysan <olivier.moysan@foss.st.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, devicetree@vger.kernel.org,
 dlechner@baylibre.com, Mark Brown <broonie@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH v4 02/11] iio: dac: adi-axi-dac: fix wrong register
 bitfield
Message-ID: <20241006144102.4b44c09f@jic23-huawei>
In-Reply-To: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-2-ceb157487329@baylibre.com>
References: <20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-0-ceb157487329@baylibre.com>
	<20241003-wip-bl-ad3552r-axi-v0-iio-testing-v4-2-ceb157487329@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 19:28:59 +0200
Angelo Dureghello <adureghello@baylibre.com> wrote:

> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Fix ADI_DAC_R1_MODE of AXI_DAC_REG_CNTRL_2.
> 
> Both generic DAC and ad3552r DAC IPs docs are reporting
> bit 5 for it.

Reorder to come before the previous patch.
This want's backporting. The renames are good but too noisy to
backport if we can avoid it.

Jonathan

> 
> Link: https://wiki.analog.com/resources/fpga/docs/axi_dac_ip
> Fixes: 4e3949a192e4 ("iio: dac: add support for AXI DAC IP core")
> Cc: stable@vger.kernel.org
> Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
> ---
>  drivers/iio/dac/adi-axi-dac.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/adi-axi-dac.c b/drivers/iio/dac/adi-axi-dac.c
> index e83f70465b46..04193a98616e 100644
> --- a/drivers/iio/dac/adi-axi-dac.c
> +++ b/drivers/iio/dac/adi-axi-dac.c
> @@ -46,7 +46,7 @@
>  #define AXI_DAC_CNTRL_1_REG			0x0044
>  #define   AXI_DAC_CNTRL_1_SYNC			BIT(0)
>  #define AXI_DAC_CNTRL_2_REG			0x0048
> -#define   ADI_DAC_CNTRL_2_R1_MODE		BIT(4)
> +#define   ADI_DAC_CNTRL_2_R1_MODE		BIT(5)
>  #define AXI_DAC_DRP_STATUS_REG			0x0074
>  #define   AXI_DAC_DRP_STATUS_DRP_LOCKED		BIT(17)
>  
> 


