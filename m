Return-Path: <linux-iio+bounces-21114-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1B6AECEC7
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2019173C53
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14932231A37;
	Sun, 29 Jun 2025 16:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ea8MndG4"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48864685;
	Sun, 29 Jun 2025 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216002; cv=none; b=PlVs3llexleTfkfswLmuA7Q/ge/nyGg4sK2YSGXXgGJcDbdSEHbhe+ZbpADkhmIT9vNdK1OsQJy8Xsd9Jz/Ikj/fIggJrbwGViaCWzEgnAgeuXR+GbA1GDbG23Xq7FskNhirp9iecCbcmDGy+49yyMZsBR82CR8U0ZgJ0pQCO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216002; c=relaxed/simple;
	bh=wfF0KxgnccudDGzBMgGKyWRW64uLP0uEYIwKOk/1MYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tk+GFYVHfuzGOAPCq1GBW0tHCEYkPHdfMUKMOB0VMwMBamIqhudiv/5khdzMt8xq0CdfYl7NE3oNX++7ghaPyJFB3M8865c1lGcGr6RiLsKerhe3mnk8QUfS07wYaRoyQHO2XaoKxNapHgs9Ji+aesvjVeUdz0+WCxyjZMgVKnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ea8MndG4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 770D2C4CEEB;
	Sun, 29 Jun 2025 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216002;
	bh=wfF0KxgnccudDGzBMgGKyWRW64uLP0uEYIwKOk/1MYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ea8MndG4X5FSxHCKCAKuxv1y5sUAQU4z2GqxSRkIDVQU+r8gRrgVfxKs+8AkC0Spj
	 YtdVZG/1gwrL0T11kkOxPpK+MHUaSuXgi3ElzRyS0dKiuE5rsYi7FTrNwPozBp0QI7
	 YWEqOMtySe8KNmO25fIwypY+TZzdwJGoP27tYluMo8KP+SMwwgwsqETQtQzVMDDkPD
	 gNNmunY+eP14LwFuO3i29Va9fC/hj9u5bgkMSuQwN4rVdyVFlcZ/EqVOjVjdgy+HfO
	 av7+/OjsI9NN+gu5i/lqxQbBbIOJjDICxEdQka1JrnXfqfsnsY1lxhd/EQJzuUjIHD
	 XkwleCTCkI98w==
Date: Sun, 29 Jun 2025 17:53:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Chen-Yu Tsai <wens@csie.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: axp20x_adc: make axp717_maps const
Message-ID: <20250629175315.65a2aca2@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-7-v1-1-10008d0a4c2f@baylibre.com>
References: <20250628-iio-const-data-7-v1-1-10008d0a4c2f@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:23:58 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct iio_map axp717_maps[]. This is read-only
> data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.  Plenty of time for
additional comments / tags etc.

Jonathan


