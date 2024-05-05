Return-Path: <linux-iio+bounces-4814-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D238BC2E4
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 19:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA44AB20F0F
	for <lists+linux-iio@lfdr.de>; Sun,  5 May 2024 17:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47D50297;
	Sun,  5 May 2024 17:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OwTjzDzy"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491571DFED;
	Sun,  5 May 2024 17:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714931437; cv=none; b=M7Ea+5w2o5CaoNQIUc4y5dCAdksZl2uIMYCdOPs6gB9oCxJmB0T4iSzNP+p84A0vBTpS0tmHVAD8JS1wfSjpKDhnKqQwkP7Qddx+FdggwdSUjUgPmX4Cpeif1vPqJgEA0foU6OqK+HXP1bEnHffyQmjSysF+0Qp/nJZt6Yuvgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714931437; c=relaxed/simple;
	bh=SglqQb0Kh3o6jlJVT0A56FCRoECB2030kwiT4iZEXDI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=giDtod2gb7oSWgUSLPZd2Net+8uRf+eLyqKnyceHIEdp5VUUFi1h+eK0Q7OPbbmKNJqtQ+urJ+rueVVZud0NC1s+dY7XmKazukZQ7rX8kN5s31W/NJ7MiAm2n+QTd3WlZHyYueY20k4V27u7PMSYczF5F/MUlQIRfCE2vlzfbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OwTjzDzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B891C2BBFC;
	Sun,  5 May 2024 17:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714931436;
	bh=SglqQb0Kh3o6jlJVT0A56FCRoECB2030kwiT4iZEXDI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OwTjzDzy9qvwP5Y9w0dwZfMVJaFbQzPf+opcEnONIyZxjReC3Q57lrBgjGhuNPxNk
	 YXD1qgbvTrLMHsiP1FxX210QA4VvFjcV/+MpqktbpCFTSToyh09FfBY3+fASMucUDk
	 3CqzVc/Cv/brZY9VgBCyO5qCMJT8mo4Y3VNRP4233zBGfQm9fu5CyskwLdSurKeMHB
	 HPN4WMThrgOCc/A1GSDa5/vE+LfQZ8q52/YHDlYUeelcYSOXU/TEaCD0cAX+/gi8pS
	 qUUIooEI/qFHIEE3nJlqblsvJzura/1GUarWDm25vqYDhVTWpgvmIUyh6bKtUlB6g1
	 LdFVz21PG+x4g==
Date: Sun, 5 May 2024 18:50:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen
 <lars@metafoo.de>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 Chenyuan Yang <chenyuan0y@gmail.com>
Subject: Re: [PATCH v2 0/2] Fix the iio-gts-helpers available times table
 sorting
Message-ID: <20240505185027.18809bfd@jic23-huawei>
In-Reply-To: <cover.1714480171.git.mazziesaccount@gmail.com>
References: <cover.1714480171.git.mazziesaccount@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Apr 2024 15:44:26 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> Fix the available times table sorting in iio-gts-helpers
> 
> This series contains a fix and test for the sorting of the available times in
> IIO-gts helpers. Fix was originally developed and posted by Chenyuan Yang.
> 
> Revision history:
> 	v1 => v2:
> 	  - Fix the sender for patch 1/2 (Sic!)
> 	  - Fix Co-Developed-by tag (drop this from Chenyuan who
> 	    is the original author)
> 	  - Fix the From: tag as instructed in:
> 	    https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Am I right in thinking this doesn't matter for existing drivers?
As such not high priority for back porting?

I'll assume that and queue it up for 6.11. If someone shouts I can pull the fix
forwards, but then we have the mess of chasing the testing in later.

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to poke at it.

Thanks,

Jonathan

> 
> ---
> 
> Chenyuan Yang (1):
>   iio: Fix the sorting functionality in iio_gts_build_avail_time_table
> 
> Matti Vaittinen (1):
>   iio: test: gts: test available times and gains sorting
> 
> 
> Chenyuan Yang (1):
>   iio: Fix the sorting functionality in iio_gts_build_avail_time_table
> 
> Matti Vaittinen (1):
>   iio: test: gts: test available times and gains sorting
> 
>  drivers/iio/industrialio-gts-helper.c | 7 +++++--
>  drivers/iio/test/iio-test-gts.c       | 8 +++++---
>  2 files changed, 10 insertions(+), 5 deletions(-)
> 
> 
> base-commit: 4cece764965020c22cff7665b18a012006359095


