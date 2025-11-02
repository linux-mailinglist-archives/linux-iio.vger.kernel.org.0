Return-Path: <linux-iio+bounces-25798-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61154C28E30
	for <lists+linux-iio@lfdr.de>; Sun, 02 Nov 2025 12:33:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 201663B0E35
	for <lists+linux-iio@lfdr.de>; Sun,  2 Nov 2025 11:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B234E2C324C;
	Sun,  2 Nov 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R3/BlB9o"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEE012D1F1;
	Sun,  2 Nov 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762083219; cv=none; b=dezIoxOzTEPg4vKAEDzAqsHK5nqq+sJf7IzytkHKL0WCjVM8GLW0zFd9OZ3L6sTUyf5/9yWNXhedn3UQqqU0Xu5ehGkRW1nRHN1tQ+OOw92+koAPKC9Zl3Seo1iOuIvRoggxLMC8D/+UZJVtN5YdntWT7n77GY+08gJu/UiOMsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762083219; c=relaxed/simple;
	bh=Swduw/f/OMSzIli5wuBEYHWb/d/r5y8jnqH+8z8QNnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qalFNuH1uXR1yfGFanPxxFbjLSHNMieFADZ6YG22Kz48n+u5htYhgtP54QwfwlSi4NUgzMBZ/VEAUoOIuxz5ue06n6Y5sGqEnG45sS0pf8gAux2cTjU7XcxK8GtDhx5Fv2bDWcEQQmsRHthiWVQeQnl1Xu0WUG+sa4Otz0hVU8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R3/BlB9o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADB4C4CEF7;
	Sun,  2 Nov 2025 11:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762083219;
	bh=Swduw/f/OMSzIli5wuBEYHWb/d/r5y8jnqH+8z8QNnM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R3/BlB9odDVMSuQHsEZvJ/jbxzTmXIGWvz/bZBei+7bCjvBk5hmbmiYowU6O7pAAS
	 rSxoNc5S47hlQ6yFUMI8WMvBQJIzo/Xd4QpkeuBBL2KJW7clRfsWHM2LaV4rkDaUKl
	 9eoVYcTyrz/PABwclbE9kOVRXVyoQ5Z8muMDGoVT3ssgdA5u0pNMiGrq6e/27/Bveq
	 Z0e0kq4FVHbrBV2D30J+By4eIBQmC6/PeN1LfanQ58IjatNyaFCguiGnSSZTFJBRUf
	 8swjx5cllnmdZpx0nPpZDSq2mtR4hkmiW+V7/HkwZpyZ2pQk2hA1IocdKABQXfQbs7
	 etVKn1rcLgUQQ==
Date: Sun, 2 Nov 2025 11:33:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] iio: imu: st_lsm6dsx: make event management
 functions generic
Message-ID: <20251102113332.555a2c12@jic23-huawei>
In-Reply-To: <20251030072752.349633-8-flavra@baylibre.com>
References: <20251030072752.349633-1-flavra@baylibre.com>
	<20251030072752.349633-8-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 08:27:50 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In preparation for adding support for more event types, use an

General comment.  Wrap commit descriptions a bit longer.  Standard is 75 chars.
This is about 68.

> array indexed by event ID instead of a scalar value to store
> enabled events, and refactor the functions to configure and report
> events so that their implementation is not specific for wakeup
> events. Move the logic to update the global event interrupt enable
> flag from st_lsm6dsx_event_setup() to its calling function, so that
> it can take into account also event sources different from the
> source being configured. While changing the signature of the
> st_lsm6dsx_event_setup() function, opportunistically add the
> currently unused `axis` parameter, which will be used when adding
> support for enabling and disabling events on a per axis basis.

I have nothing to add to Andy's review on the code.

