Return-Path: <linux-iio+bounces-10776-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D32D99A4DAB
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 14:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C489B25B28
	for <lists+linux-iio@lfdr.de>; Sat, 19 Oct 2024 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20F21E04A0;
	Sat, 19 Oct 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XujOr3JA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551E41917E4;
	Sat, 19 Oct 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729339656; cv=none; b=lwnjPdxDaA1IqkcRMaQ1gSqrKfqDBdAEDLteo1tLTcCp8PxoSMvhvqbbPPBglpaeIB18iLmSZnS0JgVNDpUsjp0C2K7L/zRQjFmylPejZs4WtJpo9HNrtq7AoWNLyNGOnTPE3MAM9UyhH2mDoPfKzUfnEu3rrl0THFQ2DTtZ4KY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729339656; c=relaxed/simple;
	bh=XMU5vMblnxpY3oDtwaA2eTHZOans/yr06uh4/zpbhX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITlnY7IwzALFFQPtT4zONOpFiZUZKCqGUbVDqCrY2IjM8cPfsf1sFUzqc3q9+9eLIcvJmGEiIr2H2HgYGZvGKGJ9mHsrWZzoHLEHddKDwjDbrOQ/e63okkypxX6TiAMWoPP80GWxYWvRzd1W0bUjKaeV5K7IeWgmX3PJIuBkE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XujOr3JA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9F5C4CEC5;
	Sat, 19 Oct 2024 12:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729339655;
	bh=XMU5vMblnxpY3oDtwaA2eTHZOans/yr06uh4/zpbhX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XujOr3JACR8UKLh9hYZFA6NZM2KBqppF8I4rpjSpbF0AKa01oA477sAxPHTneEA+T
	 3BtA7jxNFZ4qG8ijSjvevKS1W4T3Sz1G3SkHNLuB/7SdwajSiGPILN8YyO6uHjgERY
	 W2LcPYjSPFD0mA/UH51l4MNNDJC+Chy/rpH9P68H5mccBUkqjSIRSH002Kjr9iFuJt
	 JAqWw3MsDEVGcMMKECGMw/BH/7N3WhPqWeVi1GntxJpDSG35Iu0yE3Srwxbkx0gI8H
	 gVxw2gbLNEpFKlEUwR6IeAG7G8GoE57Kaq19gEpNCJzq1N1wLd40DNHAKuZOPdplgy
	 9XALvVhk4q4zQ==
Date: Sat, 19 Oct 2024 13:07:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, Alisa-Dariana Roman
 <alisa.roman@analog.com>, Christian Eggers <ceggers@arri.de>, Peter Rosin
 <peda@axentia.se>, Paul Cercueil <paul@crapouillou.net>, Sebastian Reichel
 <sre@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 0/5] iio: fix possible race condition during access
 of available info lists
Message-ID: <20241019130726.336a76d7@jic23-huawei>
In-Reply-To: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
References: <20241018-iio-read-avail-release-v4-0-53c8ac618585@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Oct 2024 12:16:39 +0200
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> Some iio drivers currently share an available info list buffer that
> might be changed while iio core prints it to sysfs. This could cause the
> buffer shared with iio core to be corrupted. However, note that I was
> able to trigger the race condition only by adding a delay between each
> sysfs_emit_at calls in the iio_format_list() to force the concurrent
> access to the shared available list buffer.

Other than the 'rules' developing around cleanup.h usage, the series looks
good to me.  Sadly that stuff is a can of worms for the unwary (and for
various reasons the usage doc got lost so the guidance is not quite in yet)!

Jonathan

