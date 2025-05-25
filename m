Return-Path: <linux-iio+bounces-19879-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE06AC34AA
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 14:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BE7018951DA
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 12:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5E201F17F7;
	Sun, 25 May 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEp9sqsw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DA63FC1D;
	Sun, 25 May 2025 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748177408; cv=none; b=CV4UoVAA5b7+EFx76v+CcZiZ4cZtAsP2ZX5qzrcDHNbwigwPozUu75o5Qv+MCIjNN0JH7ZtltiSHbDtTv6SSWKtVAbIrpvSNgwroqXIQ6ESRBykgUOWqpTMgaPLj1QdJSwZcBgW6QAI/AkkLoKCNe0Ef5D9PBTM4CrreUe0NP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748177408; c=relaxed/simple;
	bh=VwGekPQN5JsFdsF+OPdDj/9R00wkcNBHVf0uPODFCxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvePRIs1h8DJT3qk10eL+flhjwl7Zz2LF/fSSLU3aeu7Y1HPMmLjeoP4A4pcwYjqWFNcJvThJW7iQ/y3V2yJ4wLW61CnGeRmX2sQIFu4op1zz4jzJjXimG+cvYrP4aN49BuigwS4aWHEBJKSWcoScZdOWk4BWQIg/ydtwdzvY0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEp9sqsw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91967C4CEEA;
	Sun, 25 May 2025 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748177407;
	bh=VwGekPQN5JsFdsF+OPdDj/9R00wkcNBHVf0uPODFCxk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mEp9sqswa5PowQdCbn/y2AaSWGxxn7wZdsaN/vWO4KTVTiiRPDSztHTT4miWlFyJd
	 c++EuPM8gAzv3qihsy4+MAYMD+NdOACwIQ1wcxQiiJp8dle2ztfTKHqsHNg6mlT5lj
	 3EDrq7kWO6Gbn82HkDsuv3V1DpDuc+NJAQT4yhIzNiVLHBe7HFQVteA4FOuPviuB5D
	 GxF7PFNWIBhL5tdZHzCTgOLDyYlL3NOtZrqxTQr+/Uw4hjk+B4jUJAQLJgGulE2wHc
	 eXeBm2QHzB0oCZveCzO9FnUPTbXIkTmM2kRjUMCmxA/Fhclnj6dnP//ZMEwRga6yXx
	 gHwezMKo0FaLw==
Date: Sun, 25 May 2025 13:49:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 corbet@lwn.net, lucas.p.stankus@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iio: accel: adxl313: add power-save on
 activity/inactivity
Message-ID: <20250525134958.19fec8c6@jic23-huawei>
In-Reply-To: <20250523223523.35218-1-l.rubusch@gmail.com>
References: <20250523223523.35218-1-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 May 2025 22:35:11 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> The patch set covers the following topics:
> - add debug register and regmap cache
> - prepare iio channel scan_type and scan_index
> - prepare interrupt handling
> - implement fifo with watermark
> - add activity/inactivity together with auto-sleep with link bit
> - documentation
> 
> Since activity and inactivity here are implemented covering all axis, I
> assumed x&y&z. Thus the driver uses a fake channel for activity/inactiviy.

Hi Lothar,

I think on this occasion you were a bit too speedy in sending out a new
version.  Might have been better to wait at least 1-2 weeks at this point
in the cycle, or until you had a few more reviews in at least.

I don't mind that much, but it does create noise on the list and tends
to reduce the focus patch sets get a little.

Jonathan

