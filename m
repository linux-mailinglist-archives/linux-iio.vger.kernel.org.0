Return-Path: <linux-iio+bounces-12559-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D45539D6A4B
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 17:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67BBA16184F
	for <lists+linux-iio@lfdr.de>; Sat, 23 Nov 2024 16:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E402770B;
	Sat, 23 Nov 2024 16:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SDhvzgFm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3300566A;
	Sat, 23 Nov 2024 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732380420; cv=none; b=bVibc8oND5mKKyXa864zJg9Ljb2TtG9gSobdkbfcd+JV3BaJ1sl7sRwFnRKLh1HOeW63x3+JbsLLs4peqhGdoVDyDGdA0rk+fv0RNP05WPx8y/2BTepXX6ApG7B5RKIVN4raniJhQPUNonellhVB5/nc9wwIHvn8MxNpGBzBTiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732380420; c=relaxed/simple;
	bh=/mSPk4KVeH16EC5A2b6+i4e8AjUGk1JqjsAQAxsQFrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EHstTLLI+xwgXfqnOUBAHuDqrRCnSo6QcEaG0ZNBbEhgXfbI7GQnW35LUz23axJZU+viBVhTr64lLrqRcVJSlzxzWQuZbQgGSqPf7p7KIk1w/5nsp+omWxb29WtbzLgjQmTIFZzXiGT10OxpnqaCYQvGB7z8v9/rVxyPU1kWMGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SDhvzgFm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23751C4CECD;
	Sat, 23 Nov 2024 16:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732380420;
	bh=/mSPk4KVeH16EC5A2b6+i4e8AjUGk1JqjsAQAxsQFrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SDhvzgFmV/BjkWTbVUiW86e8VpdDZlzMMwCCG0JaZAot9CVG8t5Uh9HYSABOHOh4/
	 jnzQVCSIKHdb7lUH1mgWAav9cdyz/AZTcHP5RzRzLQDzi29+8W05P08etGc9FPv7CS
	 uHBvWXNsE3N2dKQUwScATNBP2/qfhluj8Ek0pZqr87HcVrcEry0g806XsdHmvteMLz
	 Ay18wRyJuqYB9dOKrQg9F6BLozhEDDesm64mCaZb9a5qU37VeF9jnBNDms41Ng2Ujm
	 j3qFSYIId2P27LhjoaMsv7U1qi9YpEzIfFnY+AZ1ZU+sYyrR1ZT9aDPlaBauf7N3CG
	 IPybnMq5iUjUg==
Date: Sat, 23 Nov 2024 16:46:54 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: Use __cleanup for a few ROHM sensors
Message-ID: <20241123164654.72e309d3@jic23-huawei>
In-Reply-To: <cover.1732193263.git.mazziesaccount@gmail.com>
References: <cover.1732193263.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 Nov 2024 15:04:53 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Use __cleanup.
> 
> The series converts the rest of the ROHM sensors (maintained by me) to
> use guard(mutex). This simplifies the error paths.
> 
> As a note, kx022a accelerometer driver is handled in another series,
> which also adds support for two new accelerometers. I did also patch the
> driver for the BU27008 and BU27010 - but when I was testing the changes
> I found that the BU27008 status is set to "obsolete". I'll try to dig
> some information about the BU27010 and decide if having the driver
> in-tree is still worth the effort, or if I should just send out patches
> to drop it all. Hence patch to rohm-bu27008.c is not included in the
> series. If someone is actually using the BU27008 or BU27010 and wants
> to patch it - feel free to pick
> 131315de97ff ("iio: bu27008: simplify using guard(mutex)")
> from
> https://github.com/M-Vaittinen/linux/tree/bu27008-cleanup
> 
Applied. Thanks,

J
> ---
> 
> Matti Vaittinen (2):
>   iio: bu27034: simplify using guard(mutex)
>   iio: bm1390: simplify using guard(mutex)
> 
>  drivers/iio/light/rohm-bu27034.c   | 73 ++++++++++------------------
>  drivers/iio/pressure/rohm-bm1390.c | 78 ++++++++++++------------------
>  2 files changed, 55 insertions(+), 96 deletions(-)
> 
> 
> base-commit: adc218676eef25575469234709c2d87185ca223a


