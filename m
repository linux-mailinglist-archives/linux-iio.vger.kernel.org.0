Return-Path: <linux-iio+bounces-7384-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBC8929357
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 13:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABF9282990
	for <lists+linux-iio@lfdr.de>; Sat,  6 Jul 2024 11:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E76BFB5;
	Sat,  6 Jul 2024 11:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pdbVrXBM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAE417722;
	Sat,  6 Jul 2024 11:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720266113; cv=none; b=FGyObo6At4fR9rZa8U8jQSn5WDBNQZovWFFvGzZj+dOgMfhGF2DLATDqirmxZeEjj8lIQMSlglzUXSaKmI5tOrBlRTUf+5QZML3wVCUkhWXqXwRq8ahNJRwfJ5TGFExnmrtLFHHd/5+YUaokUkGKww2E6lK6BtecVhg/319vSjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720266113; c=relaxed/simple;
	bh=ZpiVxTkDAGl22bjAArHNJMuQ2aUZXYATBN98gMUP21o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=seH+fK8+/3YRavF2FhxJuUtzkIsZlyRY+IOyNptssQlWHL4F32Egced8+VtLt4bM6J6B9EeyntLIZx/Hlvd65q7ZjNc8HAg/AyKxigaFNLf9A6YvpXbvd6nTbiD+HK+tymfZ99f2YCjPmwONSq0kEZuh5HdSmNWvStpZRXWi4Kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pdbVrXBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B5CC3277B;
	Sat,  6 Jul 2024 11:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720266113;
	bh=ZpiVxTkDAGl22bjAArHNJMuQ2aUZXYATBN98gMUP21o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pdbVrXBMMhrkNbPlOYhoopbfyJZKXKB7YfADm1W4wkui0/I0wSjo+olFCsab1Eq49
	 CUPuhVMV/weIvaJwy+S45vFVEouTkc5c/yMdtq3WzO2bhDpYuQHrYnov/ArFFLWucA
	 FDOu4lk3VM57dcQaPwXoMIfSQR9b19FvAmoJWqxGdN9zaBh9OKgxv9zm+ReHpTmeKA
	 Z/jsHtxUKg8+q0PcGbxEcj2BpSYr0Q+HVxJpsdhwpvJ+AEi++AC5QVZHvmvOmekWq7
	 ZHHxuL3Hn0JfbFUTrDP62xwihhbonXFMHtgtUoZwyrIEKPSC4Z2zhmuZg8N4bFyPo8
	 dxKj4EKuBlqhQ==
Date: Sat, 6 Jul 2024 12:41:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Aleksandr Mishin <amishin@t-argos.ru>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Lars-Peter Clausen <lars@metafoo.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Datta Shubhrajyoti
 <shubhrajyoti@ti.com>, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
Subject: Re: [PATCH v2] staging: iio: frequency: ad9834: Validate frequency
 parameter value
Message-ID: <20240706124146.036f152a@jic23-huawei>
In-Reply-To: <59cc60a1-f6d6-4f9f-bc36-6b06315eaee4@suswa.mountain>
References: <20240703104734.12034-1-amishin@t-argos.ru>
	<20240703154506.25584-1-amishin@t-argos.ru>
	<59cc60a1-f6d6-4f9f-bc36-6b06315eaee4@suswa.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 18:29:43 +0200
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Wed, Jul 03, 2024 at 06:45:06PM +0300, Aleksandr Mishin wrote:
> > In ad9834_write_frequency() clk_get_rate() can return 0. In such case
> > ad9834_calc_freqreg() call will lead to division by zero. Checking
> > 'if (fout > (clk_freq / 2))' doesn't protect in case of 'fout' is 0.
> > ad9834_write_frequency() is called from ad9834_write(), where fout is
> > taken from text buffer, which can contain any value.
> > 
> > Modify parameters checking.
> > 
> > Found by Linux Verification Center (linuxtesting.org) with SVACE.
> > 
> > Fixes: 12b9d5bf76bf ("Staging: IIO: DDS: AD9833 / AD9834 driver")
> > Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> > ---
> > v1->v2: Check if clk_freq == 0 directly instead of fout == 0
> >  as suggested by Dan  
> 
> 
> Thanks!
> 
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
Applied and marked for stable.

> regards,
> dan carpenter
> 


