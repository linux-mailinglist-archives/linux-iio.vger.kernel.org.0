Return-Path: <linux-iio+bounces-6289-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F9C9097D1
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 12:58:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70FD21F22171
	for <lists+linux-iio@lfdr.de>; Sat, 15 Jun 2024 10:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54439AE7;
	Sat, 15 Jun 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDPsCn8C"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A03710A1E;
	Sat, 15 Jun 2024 10:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718449130; cv=none; b=RRnHez94QbRZL+0uVmUrKYB9+gpznqM0uTPnWF/3PhHir8eo/4KEc4d0O+TDovVAMNNiLSyR5EbHwgFfJ0MzrMNuF8GFhBPfHw9hSDXS+00gSDrPisC2XMvCsPO7GyTtJ/KunXWtlgynz6b7tCnBBXwuv0adZfO2dxs90b/RGrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718449130; c=relaxed/simple;
	bh=6gLpOjQTe62mKE/6lFyVmrZFRTz5mT/LwMFTyqJjxDw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cWCwXFkcziYqdM1j3VlLW6Z98qP+bRH5vD7RG25NgLLxeHf8R/b1mzSnFFP2j0l+jCtdsQ6+a1/8B09In6qL8FKyEjYBIKgTYUuPpqTC2vRLAVNLgRT+1+Ut/bj3LMYfTTPnvlZqtsDOK2Gox30y3Y4cwVgfSLHey3AzLuB4IUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDPsCn8C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1181CC116B1;
	Sat, 15 Jun 2024 10:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718449130;
	bh=6gLpOjQTe62mKE/6lFyVmrZFRTz5mT/LwMFTyqJjxDw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDPsCn8CNj6WXoNHv3DVPYIvXUrSNuzDO52kPNUSfKi7y/b0bTYvfRsJWUo/RJKyn
	 PTD7YdhjRcM/QZkqd3Azi6yyAGyntVzOLhyduG66bAUpsp4ok+sILM7ebAmX4JmlWb
	 F/BYhPcLOR+ZdGaSQQQjZbGJdJje+mB3LSXVrXh5205Uj6YSitInNFtaBM0GeyGX+C
	 9hBBqRWqvtnQp3J8hlbjDKeFpYjxZptge4XyHS2caFFHjxnqCgVba7iMpBde6Ej5WC
	 pHCKK62wrFsla+ki38eJyiCJmAh25lpLqZlfgPVizNY2fr06DyPtfoHBmAMsa/7Zel
	 1B6Dlve0vjh7A==
Date: Sat, 15 Jun 2024 11:58:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: Alisa-Dariana Roman <alisa.roman@analog.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Michael Hennerich
 <michael.hennerich@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Alexandru Tachici
 <alexandru.tachici@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark
 Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 1/5] iio: adc: ad7192: Clean up dev
Message-ID: <20240615115840.6b2ae684@jic23-huawei>
In-Reply-To: <20240613114001.270233-2-alisa.roman@analog.com>
References: <20240613114001.270233-1-alisa.roman@analog.com>
	<20240613114001.270233-2-alisa.roman@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 14:39:57 +0300
Alisa-Dariana Roman <alisadariana@gmail.com> wrote:

> Clean up by using a local variable struct device *dev. Also use
> dev_err_probe where possible.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
Applied to the togreg branch of iio.git and pushed out as testing

Thanks,

Jonathan

