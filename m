Return-Path: <linux-iio+bounces-22794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E1EB28D30
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 12:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C235C1D00077
	for <lists+linux-iio@lfdr.de>; Sat, 16 Aug 2025 10:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B86829D283;
	Sat, 16 Aug 2025 10:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqDAnCVw"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F279429D262;
	Sat, 16 Aug 2025 10:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755341879; cv=none; b=Ds87iVJw1pGPL9C6oz7rw0Bu8GjfhFL4QMiwFaSesPnK1WEkrUXxIJoLqtUC7hHBjt76jvzIM92jP792RtNUP1OakB1atrDJHiUXtz81rQpRRPIy032nFK/xVSdcdKN0qu8xhcakJy04A8dto0tjvLDZda9P3oT/Cz2Cz3N+ssY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755341879; c=relaxed/simple;
	bh=BmnKj/KqQeG+5+VUrGMSDYCqRLaWptlK1BOEnB0DXfo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i06wII8hJD+zMm7w9nC+34Fh1cFyYUaxtCu9+FgDXg9IdLsH/ncaOqiO3RrZxHnI3SWpj+blgfKWvJoqXHWkIITt0TOQXQWrLTJRjK+KWX2sqaanau4CkugixGedUUJ19rUb+S+pUePPQvUZyd6Fl0RQz+7Tjl6ZWuwr/lY1ttc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PqDAnCVw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCBEC4CEEF;
	Sat, 16 Aug 2025 10:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755341878;
	bh=BmnKj/KqQeG+5+VUrGMSDYCqRLaWptlK1BOEnB0DXfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PqDAnCVweBcclBkp1MVayeeStbsyMAssvC8U5V4c4RIUBhQpXrWJoSDoX5/sqKLhy
	 XlEpnd55moCykWH5KUl9H39ttwdoJHATwKi7wzCv+9RKEJBJN1nxuJdi0Q/2OjNLZ8
	 xue7Om/qWIwRcrzYVdcMKmhneCQloG0dh9ch7gxVwpAehJjGfMAsttuzjxqqQs1Fro
	 3SPIsl0+N6/LVLzQMZvpA3Au2xr9furemb5CF+Ys+t47Ar0aWrBKKuPBuj87z8iK0j
	 HEd7lS3aVW/4fv+n+vrBhAkbxVqUa50FXbRlLQ4Axo76JTLzb8wi4Gft7IE7KZ63MU
	 jS2ELQKnzy7NA==
Date: Sat, 16 Aug 2025 11:57:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Erick Setubal Bacurau <erick.setubal@gmx.de>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, corbet@lwn.net,
 linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs: iio: bno055: Correct wording in driver
 documentation
Message-ID: <20250816115749.40aa0a06@jic23-huawei>
In-Reply-To: <aJ8-0gzc_XJ_1YoI@archie.me>
References: <20250815070001.55185-1-erick.setubal@gmx.de>
	<aJ8-0gzc_XJ_1YoI@archie.me>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Aug 2025 21:06:10 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> On Fri, Aug 15, 2025 at 09:00:01AM +0200, Erick Setubal Bacurau wrote:
> > Fix typos and improve wording in the bno055 driver documentation.  
> 
> Looks good, thanks!
> 
> Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
> 
Nice.

Applied to the togreg branch of iio.git.

Thanks,

Jonathan



