Return-Path: <linux-iio+bounces-17668-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF48EA7CE18
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 15:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 821BA188D5BB
	for <lists+linux-iio@lfdr.de>; Sun,  6 Apr 2025 13:21:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F2192036E2;
	Sun,  6 Apr 2025 13:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuTOp6Nr"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF4B42A83
	for <linux-iio@vger.kernel.org>; Sun,  6 Apr 2025 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743945662; cv=none; b=pCR7zbZ7PVtPuYIptcGg3UHDuiO+SRkRfnMLnnThzqmt0MTptaHvksaV+TiARbYHZ9fwqro0XyMT+y9MzJA39oFhiFoBSn6LyIKKTKc68l7wCYC8Xx48WNI/qU+JseNOb6OcNj9Ea1iuak0eWjCOtqr7r13qFfYLAWsYolQGy9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743945662; c=relaxed/simple;
	bh=/9G2G34+joPDjZ5qrLnwos/gEDQF/3m2xSJq7XXg8TM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fl6/XqyeOTqHTLBujCErdsrpSxNmcPQDBsiB2hkYGRNPuavqcUJsmDVTJ2JODMAhF4qkgPrKb3dQjxVdNqjCXRJxhajgJjLdrSjVD+UGii9dxgj8JD5KHHF9PInIrPB+b5+lwkwPwbCU0XQ5aj2lcc6OG8SBB8llGDault3wVHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuTOp6Nr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DF4C4CEE3;
	Sun,  6 Apr 2025 13:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743945661;
	bh=/9G2G34+joPDjZ5qrLnwos/gEDQF/3m2xSJq7XXg8TM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SuTOp6NrzTcU4xajx6sgYMJOVvH4EZDVwAX2pz8WifxYo7fNwxUp5mQo4zJWelJng
	 WzcUBSI78/ZhPwfGbWKQFzUYoZExSLfmo3luPyHrsLiGKDXfpauUsTGNiN2dBS7WpC
	 viJ6DOX2bT5T59MvytuoSDrqU6bsBA4GefMCM3yCPFUUiUHANSJ6Ref9FKTr8uCrj+
	 3K+06/3hWmUzcRI+CufWrwOP7Zz0HOKaX9/Sa6jlrUVDaet+kL1dy1aBZHM3+nFG7U
	 ykSOdaKL5oBSuszlNOO+KawN/AjN+nvRWUi7gSj8x1gW/kvxqkUY0UgGZ0tDyxiJhD
	 Pu4OG2w08SQwQ==
Date: Sun, 6 Apr 2025 14:20:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Cosmin Tanislav <demonsingur@gmail.com>, Roan van Dijk <roan@protonic.nl>,
 Jyoti Bhayana <jbhayana@google.com>, Nishant Malpani
 <nish.malpani25@gmail.com>, Eugene Zaikonnikov <ez@norphonic.com>,
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, Shen Jianping
 <Jianping.Shen@de.bosch.com>, Lorenzo Bianconi <lorenzo@kernel.org>, Matti
 Vaittinen <mazziesaccount@gmail.com>, Yasin Lee <yasin.lee.x@gmail.com>,
 Andy Shevchenko <andy.shevchenko@gmail.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 00/37] IIO: Sparse friendly claim of direct mode (the
 rest)
Message-ID: <20250406142050.33977c41@jic23-huawei>
In-Reply-To: <795a7c97-4d11-4277-91ba-77a5641759de@baylibre.com>
References: <20250331121317.1694135-1-jic23@kernel.org>
	<795a7c97-4d11-4277-91ba-77a5641759de@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 1 Apr 2025 14:13:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 3/31/25 7:12 AM, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Firstly, sorry for the huge patch set!
> >   
> 
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>

I've applied all these to the testing branch of iio.git.
Only changes were the typos and punctuation that Andy pointed out in
the final patch.  They didn't feel like the justified a v2.

Note that I'm not planning to push this out as non rebasing
until next weekend, so there is still time for additional review.

The namespace question can wait for another time.

Thanks,

Jonathan


