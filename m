Return-Path: <linux-iio+bounces-22811-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35B40B28DF4
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 14:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0EA6D7B4557
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AFF2DFA34;
	Sat, 16 Aug 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAO1gN0N"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A556323D291;
	Sat, 16 Aug 2025 12:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755348955; cv=none; b=qsZojL8v3KuZCeEeXENt2ktSk9u7Sdsp0D+W200QFJLC5bxINcgUJCOcLKXRLIW7y4EIR+RlXY+nVRfyXgu2CA8SxzLBRWA6GnN6zXOAyXlYTRiQqwOKSLYSX99fb4cFx9EN4e49czpRq+EiW6+hOjIL9mBCYNoYwvV0Bbqew7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755348955; c=relaxed/simple;
	bh=P+D75MyVifQL7tDuakNzZ9agkknvPrUgW6XT6jLTc98=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HKMH4iljKKyVU/t0DLoQqon8+jqyRntVj6FlhB0+j5PUKPr2Nr4Nqpx4Ims8LbkEDOGLUB/cwn3WjAaw0cXdYO+jjBicQ5pCDk7in7+vQiBFdSkcqj/9gEhSRd63Zir1DlwHmSc/k8x6cc84zgBMRi48RLGKVZT/82WCOiUrqDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAO1gN0N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E67C4CEEF;
	Sat, 16 Aug 2025 12:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755348955;
	bh=P+D75MyVifQL7tDuakNzZ9agkknvPrUgW6XT6jLTc98=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bAO1gN0NEZvgTKb+vacMEG2XXp7t1zqZo8XMTonK7jEke8x5fg2x/WhnC8eiYZQ2A
	 Q0YxNpcWydumpPTd/PD+niGRc6qSKbVE8X56qD5zVc8BU/ke7DHVx1zMBgeltE727f
	 A+O/DtjVeEtqUDWTFeY86mLU8cMDEGni0ZdT0OJLId7iZXKYmthmC2WEnqHH/+/OjA
	 wVhnQpWSra9zyl4JmcbSH607N5m+UjFXZcnijXLy4jrL1NWrKPyBv5yi2UgJaKZbul
	 oBdFvKCkTwbyUpcM0XNbBMKQ5PcNDGhEu4bXF3yfLFiYL42uYc37mBIP2lHS2kGh6Z
	 t4EUw8ObKgmKw==
Date: Sat, 16 Aug 2025 13:55:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrew Davis <afd@ti.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] iio: health: afe4404: Do not store dev pointer in
 device struct
Message-ID: <20250816135547.617de9e7@jic23-huawei>
In-Reply-To: <20250813225840.576305-4-afd@ti.com>
References: <20250813225840.576305-1-afd@ti.com>
	<20250813225840.576305-4-afd@ti.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Aug 2025 17:58:38 -0500
Andrew Davis <afd@ti.com> wrote:

> The device *dev is only used in probe(), so no need to store it
> in the device local data struct. In all the places in probe()
> we did use that, just use a new local variable for the same.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
Applied. I'll hold off on 2,3,5 and 6 until discussion on the question David raised
is concluded.


