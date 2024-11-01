Return-Path: <linux-iio+bounces-11734-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 010049B88F8
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 02:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9289A283293
	for <lists+linux-iio@lfdr.de>; Fri,  1 Nov 2024 01:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8C383CC1;
	Fri,  1 Nov 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="rntnZJtv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70323134BD;
	Fri,  1 Nov 2024 01:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730426347; cv=none; b=J8t2uwk3kiDjfwb3lvCbmjmbEMApGGkfMGKcuci8Kzu79Dw1DMSM8A9+yIfx4gCQsl1iW7vvTkkG5NCg3BYUkpTV5jg3J0xt1R/F5Obz5EU8tYTAuaF7/gb5xxIBnfluDT8ed4njpkfKryRQdjKNN8YO1XeCPAboRSPAosQ4b50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730426347; c=relaxed/simple;
	bh=TvrKcZwqprZLdfSEr9lFsVxUlYYJfz4G5/jolpSn4nM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=AA64NpbhMyugG77Fi4BqVmwAAARFv3h7cyqJPnqdDrsgra75XRwoxOKkQW3k07SMD+Qok5zV8s7sB8kbjgFqDkKzJLnwBhOCags+6yISvPaaJoiJeICTxs6zaWzS0+QFgiR8c6QBL15jRfu75U3TU/imLRjRyBpVgmqpN0GpjVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=rntnZJtv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A120CC4CED0;
	Fri,  1 Nov 2024 01:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1730426346;
	bh=TvrKcZwqprZLdfSEr9lFsVxUlYYJfz4G5/jolpSn4nM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rntnZJtvp+p1AqhVD+TGZ+9Y5EHJ+dIFb2YE8c6Y5YjhYLrQqNQEEG35cmREqu33A
	 M4KOL05SMuczGOqOeC1LyscXZCjpGt+PFMtqSA0Ln2eIoA/PJceBAazlo6BT6mqwkC
	 PmkKNWwMR5YUsBMgkbYD1jeNKlmGKTOzd1x+G0js=
Date: Thu, 31 Oct 2024 18:59:06 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandru Ardelean <aardelean@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 jic23@kernel.org, bartosz.golaszewski@linaro.org,
 gregkh@linuxfoundation.org
Subject: Re: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
Message-Id: <20241031185906.064d733825c176addd48a733@linux-foundation.org>
In-Reply-To: <20241031063707.795842-1-aardelean@baylibre.com>
References: <20241031063707.795842-1-aardelean@baylibre.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 31 Oct 2024 08:37:06 +0200 Alexandru Ardelean <aardelean@baylibre.com> wrote:

> A bug was found in the find_closest() (find_closest_descending() is also
> affected after some testing), where for certain values with small
> progressions, the rounding (done by averaging 2 values) causes an incorrect
> index to be returned.

Please help us understand the userspace-visible effects of this bug.

Do you believe the bug is sufficiently serious to justify backporting
these fixes into earlier kernel versions?  If so, are you able to help
us identify a suitable Fixes: target?

Thanks.

