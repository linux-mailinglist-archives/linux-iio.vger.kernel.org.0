Return-Path: <linux-iio+bounces-19636-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1811CABB10E
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 19:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDF1F3B6B14
	for <lists+linux-iio@lfdr.de>; Sun, 18 May 2025 17:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B3221B1A3;
	Sun, 18 May 2025 17:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sY73vQvr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D25BF155A30;
	Sun, 18 May 2025 17:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747588733; cv=none; b=aKDpw2ZT4VpOSq3cCHZQBed+BLwdluakZob+XpaXnkeu5hXMkfJ3oCU9WB5z+dY48yQdv10Po+lra00WeDlfX1PM1nhq3fbqAQjkfptRtCw+I45VrlOnXHTaEssUgNTftExxmkD6NQHfSwhrcDvKz+A3t0ltoUMpWLDdg9pXPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747588733; c=relaxed/simple;
	bh=PLAv4M08UX4Kf2i4c71WVEZ1AhpPSWsTE1pNdBvI/YU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BoUoDUVHmCDlV99qHdTJSsilIIftyZEG7P5WUaV6nCIsabuW9I/qyXJ9ccF1+YprsX5lBP1Zz9XYSJJ4te/8GyNzXf+P1o3OId2Yx0qQtMwpDlukmGPuCCVQULOumHrbLzxmkB1Yk6CDKIkdxvGPf1kd3UrDD0NmE+k1RnQfyqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sY73vQvr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B532C4CEE7;
	Sun, 18 May 2025 17:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747588733;
	bh=PLAv4M08UX4Kf2i4c71WVEZ1AhpPSWsTE1pNdBvI/YU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sY73vQvrtF9KV7NtGUOEbw05dM8Q1Ub8/8mTNyUTd3Xvk4NXF7d8z3zvaiEmm1kPJ
	 Gg7w3m09HFFXRT/HCzDpayu3RUpkgykVO+r2OtJIQmYHyW7pTv2ULJ2s6Fsd2AjUMd
	 q56LivcwHNBukXYibsRMhYEMvtEoV89oegZI6KMfvZKVpfdPORnxuvnOytqsKwlqiy
	 WJ7C/D1TxRaJ2fxLdA9emEaWz6Ubh5RfT6vJAHyISQcm9YpN5g6DerlcOtGKXzFxqk
	 9Mdj9yJxfAQel/E76ceymoNCrDARTwy0mWVwDMMeV4P77UIGQxxuekUXJ3QH3jWNOU
	 w+xZVcgHfV2hw==
Date: Sun, 18 May 2025 18:18:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <robh@kernel.org>, <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v6 06/10] iio: adc: adi-axi-adc: add data align process
Message-ID: <20250518181845.23bbe771@jic23-huawei>
In-Reply-To: <20250516082630.8236-7-antoniu.miclaus@analog.com>
References: <20250516082630.8236-1-antoniu.miclaus@analog.com>
	<20250516082630.8236-7-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


>  
> +static int axi_adc_ad408x_interface_data_align(struct iio_backend *back,
> +					       u32 timeout_us)
> +{
> +	struct adi_axi_adc_state *st = iio_backend_get_priv(back);
> +	bool sync_en;
Not used.

Make sure to run your test builds with W=1 which I think would have
warned about this. Fixed up.

> +	u32 val;

