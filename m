Return-Path: <linux-iio+bounces-15587-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51546A375CF
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 17:33:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278621888EC4
	for <lists+linux-iio@lfdr.de>; Sun, 16 Feb 2025 16:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A077199EB0;
	Sun, 16 Feb 2025 16:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amin34Yy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24FB318024;
	Sun, 16 Feb 2025 16:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739723601; cv=none; b=ZeXLaEvVPIFkOv3+CtoR4m2XoCd2XXl03A00RYV4lGbZicZlB+Zsgw7VRJStPBaPK9Ts0oPu3fETifh3b4A31phymSN+UgPsSyhqIBB/p+gnMR0KVyuVhyYTdycoyI80/gKs+W6NCokFTsxg1lwW+ZJS+PKWro4fzf6pKxV3qvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739723601; c=relaxed/simple;
	bh=yVfFGre5pKFBf/Wjd8cEUun0ZmJ00U6LxY4jEpsc/Wo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AdloALe1906f+znoSEWLJubutbIsvlgioUyttuGVecUVfG1s0wLqzXAK5I+zQ4G5aTS9HR8VAui2klhHf9/iuI2jf6aEdyMjCjWFrwnUlSzy+XXxPH4ZG1d3DgBk+P6g+M4YkmeoqGpJSvkUUn719D3svVoPvIIjr8K557AzlZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amin34Yy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDDFC4CEDD;
	Sun, 16 Feb 2025 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739723597;
	bh=yVfFGre5pKFBf/Wjd8cEUun0ZmJ00U6LxY4jEpsc/Wo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=amin34YyhxBmzjHJyo5mT5kLGVyM/ta+RXSTKBLvCeB5VjJYUHoSeiSOtHiu2+7i7
	 OjZG/ej93CsOe9JjRZ3yPsXmWRTKZN/K4lEzuoD6+L6u/ggSUwiJvEG75/fuswSmbA
	 8/WeCxnu+FVwKt9Z3qXZFlIZhPWx44TqqJSSb2WwKfuTJ+rctBOvkJ/BYEKQ9QmSgt
	 mVN3+6U22aSSdiR6Gml4mPxY2pDuRzQROkXNcSwthxkjoz9jy8CTVInfmSqqUSVbG5
	 +9atz9qsRvNXumL/SZOKKZ0beOeJG3LUzkSCPqXCqMhzHGRRaxb0FVIYEN8xfrm5jc
	 4vx0obcv3Qm5A==
Date: Sun, 16 Feb 2025 16:33:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lars@metafoo.de>,
 <Michael.Hennerich@analog.com>, <marcelo.schmitt@analog.com>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <jonath4nns@gmail.com>, <marcelo.schmitt1@gmail.com>,
 <dlechner@baylibre.com>
Subject: Re: [PATCH RESEND v3 17/17] iio: adc: ad7768-1: add low pass -3dB
 cutoff attribute
Message-ID: <20250216163308.78680337@jic23-huawei>
In-Reply-To: <50098494d2d3d50fe914de1f966d86c6fff7ecfc.1739368121.git.Jonathan.Santos@analog.com>
References: <cover.1739368121.git.Jonathan.Santos@analog.com>
	<50098494d2d3d50fe914de1f966d86c6fff7ecfc.1739368121.git.Jonathan.Santos@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Feb 2025 15:19:10 -0300
Jonathan Santos <Jonathan.Santos@analog.com> wrote:

> Ad7768-1 has a different -3db frequency multiplier depending on
> the filter type configured. The cutoff frequency also varies according
> to the current ODR.
> 
> Add a readonly low pass -3dB frequency cutoff attribute to clarify to
> the user which bandwidth is being allowed depending on the filter
> configurations.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v3 Changes:
> * None
> 
> v2 Changes:
> * New patch in v2.
> 
> OBS: should i drop this?
I think keep it as potentially useful and is compliant with the ABI
even if a little unusual.

Jonathan

