Return-Path: <linux-iio+bounces-10414-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B1F9991A2
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 21:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41F0BB2B2B3
	for <lists+linux-iio@lfdr.de>; Thu, 10 Oct 2024 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016F91CF2AC;
	Thu, 10 Oct 2024 18:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qj9LOLwx"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FBA1CEADF;
	Thu, 10 Oct 2024 18:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728584989; cv=none; b=hlpOlYtrKbIc9kzVn6a/Lx7sjevY2XBdqafmoHbUAS7uR/nC0krqj3Zb5rKZaJwTgzT599uNqVRUVrFnTBU5wTYXekkGOSuGAnyA+Imwolp0niTmXUysAAsjwWQ9pc8K0sIwzLZ6UftaEgHGREdB1BH8WfYV8pIOZgKTvZLEcIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728584989; c=relaxed/simple;
	bh=YKLjkVlxwBmT5A/q2i8zQdwxTh1oWBvJWM4Gwd6artY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSp4zgKaRgkAIKOBapZvvrGCNIKH9Pui4QFWBLpxWFcQ1wM4PvnKPQ4/CV5H+MbiYLZq/APi1DdHD/rhDmfstYIgBEaigEDDTTNis5hF6yK9eAyt4d3euFvCGuexLhw6N1VRrsLwCA/pMqhjxduB4FdbGP15SCaSNB6cGirUBgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qj9LOLwx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 458A2C4CEC5;
	Thu, 10 Oct 2024 18:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728584989;
	bh=YKLjkVlxwBmT5A/q2i8zQdwxTh1oWBvJWM4Gwd6artY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Qj9LOLwxXYGSzMlCV8tdWRMSU6EtDbawbgcjtJBLyyCP8BiYLRVEvvIwfnvb9RAeP
	 ZRnjk4qf1MgDf3T5Kf3ooufIpMbjbmlUE6+Hk2xbZS+QSS/nyRBOuWhMjZn05S/4JF
	 Qu+yyuGVpjSeuhaTgmtFRd/3LPGBv267tkFsPaHm+kEZHhTWoiMfc2cb+5hML9YNQW
	 Z5xNovLLzNq6X7fN7lFPpC8Mpa92RTcKvuQRWRToFkFM1ddScGYyPqESMJknmDyn3N
	 AJeLvVVU9wJT98X2X3KJURcRSyKFsKRBiCqaLgjWuqKK+eyo5VRAIUJLnykR5wbFIS
	 0AAGUI6XS8pZg==
Date: Thu, 10 Oct 2024 19:29:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, David Lechner
 <dlechner@baylibre.com>, Antoniu Miclaus <antoniu.miclaus@analog.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Cristian Pop
 <cristian.pop@analog.com>, Mircea Caprioru <mircea.caprioru@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>, Marcus Folkesson
 <marcus.folkesson@gmail.com>, Fabrice Gasnier <fabrice.gasnier@st.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: {amplifiers,dac,frequency,resolver}: add
 missing selects in Kconfig
Message-ID: <20241010192940.136a4408@jic23-huawei>
In-Reply-To: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
References: <20241007-ad2s1210-select-v2-0-7345d228040f@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 07 Oct 2024 22:06:37 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series adds some missing selects in the Kconfig entry for the
> following drivers:
> - ad2s1210 (BUFFER, TRIGGERED_BUFFER, REGMAP)
> - adf4377 (REGMAP_SPI)
> - admv4420 (REMGAP_SPI)
> - ada4250 (REGMAP_SPI)
> - ad4770r (REGMAP_SPI)
> - ltc1660 (REGMAP_SPI)
> - stm32-dac-core (REGMAP_MMIO)
> 
> Usually you will not notice the missing dependencies, but tiny
> config files where those drivers are include will lead to multiple
> errors when compiling and linking.
> 
> The issue was found while compiling the ad2s1210, and then I looked for
> other cases where REGMAP was missing.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
This is a pain. I was going to just flip the order of these, but turns
out that not only was it spaces rather than tabs but there weren't
even the right number of spaces.  As such I can't just have a mix
briefly and fix it up once I can take the white space patch.

Ah well, it's not that large to have as a precursor to a fix.
Applied both patches to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> ---
> Changes in v2:
> - rebase onto iio/fixes-togreg to drop applied patches.
> - Split [4/8] and extend the code formatting to adrf6780.
> - Link to v1: https://lore.kernel.org/r/20241003-ad2s1210-select-v1-0-4019453f8c33@gmail.com
> 
> ---
> Javier Carrasco (2):
>       iio: frequency: {admv4420,adrf6780}: format Kconfig entries
>       iio: frequency: admv4420: fix missing select REMAP_SPI in Kconfig
> 
>  drivers/iio/frequency/Kconfig | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> ---
> base-commit: ccf9af8b0dadd0aecc24503ef289cbc178208418
> change-id: 20241003-ad2s1210-select-a0a73a48038a
> 
> Best regards,


