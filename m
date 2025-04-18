Return-Path: <linux-iio+bounces-18262-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF83A93988
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 17:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F388176F31
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A408B210186;
	Fri, 18 Apr 2025 15:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DITjlsuJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556FC1DED51;
	Fri, 18 Apr 2025 15:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744989783; cv=none; b=Ag4f3chMiQwCtWLanY25fPJZEDGiBu6z0kWfqziiF5/UIXbsQF8g4rnP51Q0koJLOxOMckbN4gBziyBWPu6ye6/uEStYNrMeAqlD8kbWUSmNZv6Tbr0hCwBaxux4G3gAyi8gMjpHwnA9APcpIOLp27VqujTPqLyBaYyNE65onwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744989783; c=relaxed/simple;
	bh=pbWtmfd10K7q4ZDUSypEbM7fRJN34wwNxcSXHDvf0EE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gpjHwc3PEhm29iRp0KckPFsmfDJ9y2d+GkjR/qkssLleGlY0uCcD1G2smX6sx4RwECPow7vp6txqBXdMaJ/cs8GRIPD1bkbVd5n1oE/PCmScUPx7/tirSRbeHS8QLd9zHFBfBvVCQeGhpLraNDRy54251IW1o9GOuUfNxffCsOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DITjlsuJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFF3C4CEEB;
	Fri, 18 Apr 2025 15:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744989782;
	bh=pbWtmfd10K7q4ZDUSypEbM7fRJN34wwNxcSXHDvf0EE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DITjlsuJqllnMOUmAoIopYicEffwuaP8iCNLTqRfLvk1xIJOCVG/MaYjFtCdinTV3
	 56AyM0N1FtjkReOHT0k9lozN2HncQBgxrkhYF1F/GMpuScDPspTwjIxhvARsDkV8og
	 774ZWMonXSp7zYETENfqHr6MFxliF/na+Fajnbu/Vz4KseGawKTnznnVGBoUi/keD7
	 fHxphulsKHYH6SUBf9pSoo++W8iEZy/vt4/wtWdQHwjVUm3s53fTeBMeChXYKAbK3W
	 SvFyxg//8u6P+oajuUvSRdQavhCtTSU6sgap4NKvVyPO8iZ1oT5ldUOusiFfIoHKRQ
	 u2EWhaTvTMAPQ==
Date: Fri, 18 Apr 2025 16:22:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
 Michael.Hennerich@analog.com, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linux.dev
Subject: Re: [PATCH v2] iio: frequency: ad9832: Remove unused parameter from
 data documentation
Message-ID: <20250418162257.0e6af5e0@jic23-huawei>
In-Reply-To: <20250417173333.607844-1-gshahrouzi@gmail.com>
References: <20250417173333.607844-1-gshahrouzi@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 13:33:33 -0400
Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:

> This is a leftover from the patch: commit 566564e80b0e ("staging: iio:
> ad9832: use clock framework for clock reference").
> 
> The AD9832 driver uses the Common Clock Framework (CCF) to obtain the
> master clock (MCLK) frequency rather than relying on a frequency value
> passed from platform data.
> 
> Signed-off-by: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Applied.  

Thanks,

Jonathan

