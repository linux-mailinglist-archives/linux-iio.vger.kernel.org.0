Return-Path: <linux-iio+bounces-25239-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8858CBED438
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 18:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 34B4934D459
	for <lists+linux-iio@lfdr.de>; Sat, 18 Oct 2025 16:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEF0254864;
	Sat, 18 Oct 2025 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQQnaqZg"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0193225A29;
	Sat, 18 Oct 2025 16:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760806546; cv=none; b=b+xXwPz2/tGMe2OAQcXh0Nwj1f73J7SR8f+1X8CDNdPLX6xFem8Pfy5hANH8Z0+m4c+MqwcRkseOfmw1x6dGT9oS0Gj3BfSpvJ13tHi0qrV9htQE6OQ38xMs69JWJgbLzVDGigScWuQjXjonf57glmBL8B3V4xT9hH3xwv2d3hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760806546; c=relaxed/simple;
	bh=kodWhCixvYh7Pmt9QY0YU4GOmmbMSq8/Zr0eun3TwJc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K2yswujPgTlGQZ2FRVtNm77i4iTKXoLP1STS+xFBcJ6QdbKdfJEmJ+3WU6MFBQ4rWcIpfu21841KXJ+terEsw2pGHQCDX1Jt6SJ+xRBk1DziuE5YVqjKQTySovswvyLXKrgksVPX8ZJ4KZ1HC6cero4yh2bK4ZmU8pXbd272hYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQQnaqZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC4AC4CEF8;
	Sat, 18 Oct 2025 16:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760806545;
	bh=kodWhCixvYh7Pmt9QY0YU4GOmmbMSq8/Zr0eun3TwJc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WQQnaqZgBvFexNB6V3aQLXqPYM3fmdotcVzZr9Ms1I6H6rgbUekv5m1vZClCvy/KA
	 5UOQx3VhPvupxfkc+N0+usD5vHLXVR9ouMe0OsXnVckB0YkE8B5dSQWJWOTVGcGy5S
	 kEVnwyNZpvBmuVbtbVLQ/sLN9QiAQjGU3CWV5/ETyV3/OXP/cp0Oe4OGfgRqyZyCRY
	 yXDGljTy4R+GHWk82fvIS2YjHQIdJ+P0EHPj8G7bPNMzTAUXHx3L17jSc5I2tTs9UX
	 WJiZiJIPFW2mFipQyoRYmZLfxXU1ApCRrXFaBjX4q63kNwhCPlWyYiRPl5LxKQ8z77
	 njP8fJYNREbDA==
Date: Sat, 18 Oct 2025 17:55:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] iio: accel: bma220: white space cleanup
Message-ID: <20251018175540.4008e24f@jic23-huawei>
In-Reply-To: <20251014-bma220_events-v1-1-153424d7ea08@subdimension.ro>
References: <20251014-bma220_events-v1-0-153424d7ea08@subdimension.ro>
	<20251014-bma220_events-v1-1-153424d7ea08@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 19:42:57 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Clean up white space inconsistencies from the last patch series as
> requested by Jonathan.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied. thanks.

