Return-Path: <linux-iio+bounces-21049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A059AAEC885
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 18:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5B5189EADF
	for <lists+linux-iio@lfdr.de>; Sat, 28 Jun 2025 16:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE1624C67A;
	Sat, 28 Jun 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jt0MFByD"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165602192F4;
	Sat, 28 Jun 2025 16:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751126727; cv=none; b=o6x1mbcGqiLVLWFVb2SrLJnbI+kq3hYh8UoOHvTbIoprnPJW+NVQXFDMMSRSQKLUKJVjlxCkmWuRtr4n2av1Tu15/lCHo+K1SRcIqPo2OP8dmL7u5zE1gYYjFFf8hRB7o1IcQloGu3GVX0J5ceMLvgxk/msxLqaBBjD6VCJe8Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751126727; c=relaxed/simple;
	bh=i44bSo3w1WuHMM+FIy0u4zyggRyGMy5klAsjyD3h30M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HRyoN0NQb99W4iLFro5GJ+Iy3tZyiKfwusfL+QFCleBkY8ky4D8xjw7JlLR7XgFznuGELyYPqpAiynKcvyuIqk71UxlQgcX+fx1fhQenusWtBC6elPAUxmjqBb6e9qHi5P5xX+KbXzv/aJ8oX+UfGWD2STywf7mOMAVLGIPWDSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jt0MFByD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66E3C4CEEA;
	Sat, 28 Jun 2025 16:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751126727;
	bh=i44bSo3w1WuHMM+FIy0u4zyggRyGMy5klAsjyD3h30M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jt0MFByDCJtN0PZAiJbddGWkOlazsvLUeF5Ts1kzi5vPBF5bf4A5rXTOCXy3v9PLZ
	 hUQq8W+uA2mJ3un3l4OvrSgkJiwu87gt5jJH+sti71p1EjhDphapmPMh/wvmFhB/He
	 yi/z7BxGtIO53vNyV4gkt/DtxaHy/E6WzC8yaX3yhef8NElyyJb76bZ6qNi9AK9kW3
	 C+1m8cJcm+Me5uk4FsRUSApIwn1yzL7no0Yua4NDhIQnXrWTpgSkxDugLNY0q6s2ck
	 K4M4bCtlopwKkLxC4Jpl4/uq7FogAFPxWMtO7uFmAiWFn/H6xcNoDfSilMUPcg4e2K
	 vp7MHodveOp9Q==
Date: Sat, 28 Jun 2025 17:05:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, corbet@lwn.net, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v10 3/7] iio: accel: adxl345: add activity event feature
Message-ID: <20250628170521.0b201ceb@jic23-huawei>
In-Reply-To: <CAFXKEHbGThKzMxg=aZMgVEZ2S2hUoGAOoE5wu_vCuzEPqL0+cA@mail.gmail.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
	<20250622155010.164451-4-l.rubusch@gmail.com>
	<aFkfjAekGJTU5o71@smile.fi.intel.com>
	<CAFXKEHbGThKzMxg=aZMgVEZ2S2hUoGAOoE5wu_vCuzEPqL0+cA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> >  
> > > +             axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> > > +                             ADXL345_ACT_Z_EN;  
> >
> > I think
> >
> >                 axis_ctrl =
> >                         ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;
> >
> > is slightly better to read.
Ugly enough I'd just go long on this one - it's on a little over 80 chars anyway.

                 axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;



