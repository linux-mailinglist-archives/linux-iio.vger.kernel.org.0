Return-Path: <linux-iio+bounces-9570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ACFA9791A1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41CE51F22242
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EF91D0178;
	Sat, 14 Sep 2024 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjAlnfoE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215041CE6E9;
	Sat, 14 Sep 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726325542; cv=none; b=ZSej1l/4cOWgwwORokn9KZPZKauiYxb1ysS+sg7bPmmBs9xzN+n2lNIFWHiFnA/eCCGXmbjYa5JiZ1mVIjOe7QK94/yAgBzdDk9fwFXEG1gxffOJ9FdoiB5kKuYwo94QYgaf3OW1wkZG77qFchKDemgQq01YMNzI5GAmK3626Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726325542; c=relaxed/simple;
	bh=eoN5o6nUSBidhEjsQt+9L8Y6N6dW/4NAnRr/dt3LPr4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HuZKrCRwM98wyc2lmLJ4cGMTlGtg9cd35z8AQJQVm51DgHaneXn7M2aUIx6PBu6emdFSC3bn9hvh0vv3rES6HckXvz8RR+/Z2AuaixmyKRVV4ZONIBNAaMjRff5WfYvm+rvBQbd4r8qtk8ZRbJ5Yj/drHHvkc/znmbq3+vjXP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjAlnfoE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B02DC4CEC0;
	Sat, 14 Sep 2024 14:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726325541;
	bh=eoN5o6nUSBidhEjsQt+9L8Y6N6dW/4NAnRr/dt3LPr4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MjAlnfoEUR+zf1f9GFv/mDfbkbnQEgoO58uVNLPXysXV1rtOIMAkhM+rMIPr+maSp
	 N4xr8duL2zbVxUCEdsTgqilf5kvToE6DN6N3mOSuAp8MogoQD5mVuC3xugo2sFWsbT
	 nBLXIhw5WhHJmYajTzafcVEYBMoyBACn6L4hT5aHBKmH8IYdPezs56bEIK6CONnMfn
	 FD4VgLSwMm9nWDf2SMIX1lvuFiJOlWlCRf1lNwquuL1O1hAktqgjfdNp0dn6CYL2/c
	 O2i/RO1ePmF4bQzVh9OrZbDM5WJ4/wLLIZ5tQJ9R736IIsaXOiYCh5YjjC4LLSMUq7
	 lDdZ9vYjmQptg==
Date: Sat, 14 Sep 2024 15:52:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Rishi Gupta
 <gupt21@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/7] dt-bindings: iio: light: veml6030: rename to add
 manufacturer
Message-ID: <20240914155213.73544102@jic23-huawei>
In-Reply-To: <20240913-reenact-unifier-f1b070d9fb38@spud>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-1-0b09c0c90418@gmail.com>
	<20240913-reenact-unifier-f1b070d9fb38@spud>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 17:53:31 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Fri, Sep 13, 2024 at 03:18:56PM +0200, Javier Carrasco wrote:
> > Follow the common pattern manufacturer,devicename.
> > 
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>  
> 
> Acked-by: Conor Dooley <conor.dooley@microchip.com>

Applied.

