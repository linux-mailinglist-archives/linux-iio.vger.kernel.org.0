Return-Path: <linux-iio+bounces-19888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D49AC34D8
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 15:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BB03A6026
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 13:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675B01F09A1;
	Sun, 25 May 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S/SsL96Q"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AD31E871;
	Sun, 25 May 2025 13:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748179069; cv=none; b=Jnllc3BuD3s4E8TMncG0mBtNZOFEOjEJnSNsRMKmF1XcfRoXhFswzJCperxOCuImcpwW6WHGmryVZKS3C6nHTcVLzGLvZSHHSArgSHFQnsmP2BCfZPDOeYkR/WPI2nJdO3FgnjsXf50rwE6JMB7YZmNCeqZp5/LWQqZ2hts6Ygc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748179069; c=relaxed/simple;
	bh=evmyeAQqgK356FnOm009PBsdEoCq2cCc2iofF1wjQG4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jv5l/jZiJwMf7fMGLphlB9X3Ddf6O/4+WidEHsYCD6pVQap3xZ3khkRQur+17KCvg0cngbAlEB/tvfeMiwN00Lvf/ZLi9XDEmFZvELR3wra6tQNAEamjp0h4e/CDnzgO4QgWIv3eGh5z4XryvMZyCIfSBc1n4Fjli2pNw9jH+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S/SsL96Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D3CC4CEEA;
	Sun, 25 May 2025 13:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748179068;
	bh=evmyeAQqgK356FnOm009PBsdEoCq2cCc2iofF1wjQG4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=S/SsL96QKRHqDtde5fqUG2JcF41WGesL6+EzYx1YRssmG2Twd6bu0401JyLxivBVC
	 3WsDEgQJbJgGbKrOMJLpv6ni2E5VHFucfAA/NA7X8ZAh9RX2Rz969g6OkzOeNsgMv8
	 7ULvAQTWjkvTmdQTBzolnzeeu3NykCQkCuKLhOzEVBQdpVBrMeq9PQiHC60RWXGJoo
	 2CAOfhGsfYn4lx9X9J9A0RZ+PyotVDANjCtFf+yaRS8RueRESvHl6dqVPaT3IPZG79
	 pvGZA9LNBqFiUa3W4tjHOtSUzrGPZoS3lJ0kpEox5tIUk/2z/AHg7xFGJP5ltJMmaK
	 N3s4NAld8RDxg==
Date: Sun, 25 May 2025 14:17:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org, mazziesaccount@gmail.com, Fabio Estevam
 <festevam@denx.de>, stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: adc: max1363: Fix
 MAX1363_4X_CHANS/MAX1363_8X_CHANS[]
Message-ID: <20250525141740.3c85e146@jic23-huawei>
In-Reply-To: <20250525115546.2368007-1-festevam@gmail.com>
References: <20250525115546.2368007-1-festevam@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 25 May 2025 08:55:45 -0300
Fabio Estevam <festevam@gmail.com> wrote:

> From: Fabio Estevam <festevam@denx.de>
> 
> Since commit 2718f15403fb ("iio: sanity check available_scan_masks array"),
> booting a board populated with a MAX11601 results in a flood of warnings:
> 
> max1363 1-0064: available_scan_mask 8 subset of 0. Never used
> max1363 1-0064: available_scan_mask 9 subset of 0. Never used
> max1363 1-0064: available_scan_mask 10 subset of 0. Never used
> max1363 1-0064: available_scan_mask 11 subset of 0. Never used
> max1363 1-0064: available_scan_mask 12 subset of 0. Never used
> max1363 1-0064: available_scan_mask 13 subset of 0. Never used
> ...
> 
> These warnings are caused by incorrect offsets used for differential
> channels in the MAX1363_4X_CHANS() and MAX1363_8X_CHANS() macros.
> 
> The max1363_mode_table[] defines the differential channel mappings as
> follows:
> 
> MAX1363_MODE_DIFF_SINGLE(0, 1, 1 << 12),
> MAX1363_MODE_DIFF_SINGLE(2, 3, 1 << 13),
> MAX1363_MODE_DIFF_SINGLE(4, 5, 1 << 14),
> MAX1363_MODE_DIFF_SINGLE(6, 7, 1 << 15),
> MAX1363_MODE_DIFF_SINGLE(8, 9, 1 << 16),
> MAX1363_MODE_DIFF_SINGLE(10, 11, 1 << 17),
> MAX1363_MODE_DIFF_SINGLE(1, 0, 1 << 18),
> MAX1363_MODE_DIFF_SINGLE(3, 2, 1 << 19),
> MAX1363_MODE_DIFF_SINGLE(5, 4, 1 << 20),
> MAX1363_MODE_DIFF_SINGLE(7, 6, 1 << 21),
> MAX1363_MODE_DIFF_SINGLE(9, 8, 1 << 22),
> MAX1363_MODE_DIFF_SINGLE(11, 10, 1 << 23),
> 
> Update the macros to follow this same pattern, ensuring that the scan masks
> are valid and preventing the warnings.
> 
> Cc: <stable@vger.kernel.org> #6.12
> Suggested-by: Jonathan Cameron <jic23@kernel.org>
> Signed-off-by: Fabio Estevam <festevam@denx.de>
I dropped the fixes tags and applied these already.

Thanks,

Jonathan

