Return-Path: <linux-iio+bounces-13885-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA57A01455
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE0A07A164A
	for <lists+linux-iio@lfdr.de>; Sat,  4 Jan 2025 12:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB0C189B8C;
	Sat,  4 Jan 2025 12:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7g8FhlE"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E051C01;
	Sat,  4 Jan 2025 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735994384; cv=none; b=dRemn6iHyBz1pkU/erafQwYiygisdnmJ4NMvp25HaAcNcBOK2rfYCazlhV3lxTYWUUC9r20VO/oEumtoIBlu/J4TbXvucmA+sBZ54jcYO09wzhHCy2axX/XW3TvfKAxRGXA/0+PUkEawVIQYomDDOCDN2EHCXyK75BTK2VgC8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735994384; c=relaxed/simple;
	bh=jSKmsazX+Pnz3pwW7kxYsij7/QU4ZBp5U/98fNHNuj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AM9/EWd/Xg4rwyfUhM5Z4YbEnwuEC2O/fWW3H/sLRTMzoYFUmbqTB5nXX4WInZ4O7Lk79CPc/VN6O5hWJpZK4b8pompLLxP0eHhcdFydXUj45RivbaEmaLc+gDfI1hw/kYGykLvPVpwbVZtI/7FzxaExrFHG0AZReOQmLNwtKGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7g8FhlE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D64C4CED1;
	Sat,  4 Jan 2025 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735994383;
	bh=jSKmsazX+Pnz3pwW7kxYsij7/QU4ZBp5U/98fNHNuj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K7g8FhlE7IzyTiWQRoWxlkag4EOiJivDbnFGreOTBGkdSQQYXuKnOrAS2O1NV709l
	 H2KuREqPwUjPFysoJtIuFODEwyWpGHn/fb5KSFhVTiJMTI2rajvbsxfTd0TT3OROsH
	 ydRpMGMbwTto2GS/Ja4bzDFZsBUEuqkVNjanR7gKOiWrw7M2brIOZgWC9mT7GCZSxz
	 KmF7pPU6tLizR5QUpLQOHehM5WI/noIJUBDL/ATynbRzxoJNTBPMPHFP32TGXlte1Q
	 k3d1WHl7pg/lAGPrgKgtrEFWMv2o51U8ORhpYXE6jRS1iI26PtEKyBMAdFh6sbqt/6
	 YuBx4UvK92aIw==
Date: Sat, 4 Jan 2025 12:39:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Matti Vaittinen" <mazziesaccount@gmail.com>, "Lars-Peter Clausen"
 <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v3 2/2] iio: veml3235: fix scale to conform to ABI
Message-ID: <20250104123935.08018aae@jic23-huawei>
In-Reply-To: <D6PR0XZ27Z67.1IJEM2DOL18QY@gmail.com>
References: <20241230-veml3235_scale-v3-0-48a5795e2f64@gmail.com>
	<20241230-veml3235_scale-v3-2-48a5795e2f64@gmail.com>
	<D6PR0XZ27Z67.1IJEM2DOL18QY@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 31 Dec 2024 09:39:03 +0100
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Mon Dec 30, 2024 at 4:13 PM CET, Javier Carrasco wrote:
> > The current scale is not ABI-compliant as it is just the sensor gain
> > instead of the value that acts as a multiplier to be applied to the raw
> > value (there is no offset).
> >
> > Use the iio-gts helpers to obtain the proper scale values according to
> > the gain and integration time to match the resolution tables from the
> > datasheet. When at it, use 'scale' instead of 'gain' consistently for
> > the get/set functions to avoid misunderstandings.
> >
> > Fixes: c5a23f80c164 ("iio: light: add support for veml3235")
> > Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
> > Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > ---
> >  drivers/iio/light/Kconfig    |   1 +
> >  drivers/iio/light/veml3235.c | 237 +++++++++++++++++++++++--------------------
> >  2 files changed, 130 insertions(+), 108 deletions(-)
> >  
> 
> @Jonathan, if you apply this patch in its current form, could you please
> fix the message from "iio: veml3235:..." to "iio: light: veml3235:..."?
> I just noticed that the "light:" bit is missing.
> I can send a new version if that's preferred.
> 
> The applied patches from this series did not have this issue.
Applied to the togreg branch of iio.git and tidied patch names as suggested.
As normal pushed out briefly as testing for 0-day to have fun with it.

Thanks,

Jonathan

> 
> Thanks and best regards,
> Javier Carrasco


