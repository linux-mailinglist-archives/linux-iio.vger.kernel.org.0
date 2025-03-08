Return-Path: <linux-iio+bounces-16563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FDBEA57B4A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 15:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 522433AFA40
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 14:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7A91DDC15;
	Sat,  8 Mar 2025 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e7KjkHbI"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF3B17C77;
	Sat,  8 Mar 2025 14:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741445761; cv=none; b=Ze5La3RiTglns10dN9tAfkRqb5eKetohApxRpuszniCEX1iWTaDFwbqbtsggVIt8Ru6PpljyN/UW2iAq2WTwFal8t8kAENE+2YUMDnCIFV0FpjuSfK3MfIjIBwxZmO30eFVUf3faOWznKyIJorTprwiW7JLqd4ltdfUm4MIQCT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741445761; c=relaxed/simple;
	bh=mb0JUBDCgBoLXGBTbaQxhvTXIEjCUu60lxP8c8upW3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BY9Qi0ZWTKBPd0ThhO0GhZ9jSuAnwQHRA/vTucunuyxld/BDnnVQXpcUwwbtMG0U/ImhPn6HaNkz60iUOO+vYJdz7F1TMXIuLCMzQAP3hqBrJWOggY9AjmnGVixJRsn31qXNGykMRasojmxqDtf+KHzDYuCIFKDBiW3vpc9qXy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e7KjkHbI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38A8CC4CEE0;
	Sat,  8 Mar 2025 14:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741445760;
	bh=mb0JUBDCgBoLXGBTbaQxhvTXIEjCUu60lxP8c8upW3Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e7KjkHbIXAqiMlJ80yLx7yW/Zoo48r6u7aPRmp76q3d6MiEiSe1BOwjTvZjpOU5BE
	 KiXtPq4HccKCxlpsYecb4/QYN4g1O+WJXs74xil3rFVe/7+l493WEDNI2dy3r4epes
	 OZT3V3hW6YyFHmK/sEWVBpqfjue1T4o1/eqUHBBVb//RkWzV4FCgPAxfU+/YkKGhSj
	 DzwYHjpUOBAY1HGrXWJZxvxg9PWCWBvAUTPolJj0S39pd0np7vkxahLtZ0b4On51ZX
	 Z5885NJX+EU9w6qiKpXFSD04ZhkS6AjYNGNOBfAZyrNPeeel0wMVcMmw95F0+mv5nb
	 5f5NolfD12e3Q==
Date: Sat, 8 Mar 2025 14:55:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: fix initial sampling frequency
 configuration
Message-ID: <20250308145551.06d9ca14@jic23-huawei>
In-Reply-To: <5se4isw4f6xpbub62tna53ah2qjcf3mwks23ifc2yn4u462lpn@u53frmcgjth2>
References: <20250304-bmi270-odr-fix-v1-1-384dbcd699fb@gmail.com>
	<20250305144928.1b9b483a@jic23-huawei>
	<5se4isw4f6xpbub62tna53ah2qjcf3mwks23ifc2yn4u462lpn@u53frmcgjth2>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 5 Mar 2025 21:11:54 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> On Wed, Mar 05, 2025 at 02:49:28PM +0000, Jonathan Cameron wrote:
> > On Tue, 04 Mar 2025 15:01:02 -0300
> > Gustavo Silva <gustavograzs@gmail.com> wrote:
> >   
> > > In the bmi270_configure_imu() function, the accelerometer and gyroscope
> > > configuration registers are incorrectly written with the mask
> > > BMI270_PWR_CONF_ADV_PWR_SAVE_MSK, which is unrelated to these registers.
> > > 
> > > As a result, the accelerometer's sampling frequency is set to 200 Hz
> > > instead of the intended 100 Hz.
> > > 
> > > Remove the mask to ensure the correct bits are set in the configuration
> > > registers.
> > > 
> > > Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>  
> > 
> > Hi Gustavo,
> > 
> > Please reply to this thread with a suitable fixes tag.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> 
> Fixes: 3ea51548d6b2 ("iio: imu: Add i2c driver for bmi270 imu")

Thanks. Applied to the fixes-togreg branch of iio.git.
Given where we are in the cycle I might just drag this into the pull
request for the next merge window.

Jonathan


