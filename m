Return-Path: <linux-iio+bounces-17085-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83424A6879F
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 10:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C33BE828
	for <lists+linux-iio@lfdr.de>; Wed, 19 Mar 2025 09:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90FE525290E;
	Wed, 19 Mar 2025 09:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HG58fynA"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C942517BA;
	Wed, 19 Mar 2025 09:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742375659; cv=none; b=dS4aVHr22cccfP8u9FVzj7QqQlb8EEWBdXX6QXZjDJeYKfLWY+DAee+0U/QK2i5e7CnQIsAi4GjSvYFT0RkP1tBsAakJDYE4XVn6ZA2I5Av4aw6ULLoBXhwFLjex65OxVTAYPlw9UTiAAQM1sI0xal+JWQm+cwjMkuc+SAeMwnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742375659; c=relaxed/simple;
	bh=XdS1NuBTNPI8EbspZkgmDkzsxbnsfiBkaasENWKebyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYtIFGSJzYoNc6JIzB2ThanPq2tlaX0tWEpmcULzwy2DghLwISH6oaOBA9nuKCG21++GG9XjP/6DO90jGfEh6IMIbQ2//U1id1F92yTvIQwj2fJsn30xnwDoIu3QVRQvMSoepN2Oi8dUfhs5b9T7dpTehsWbT6LKelXGMmPfDck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HG58fynA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C683C4CEE9;
	Wed, 19 Mar 2025 09:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742375656;
	bh=XdS1NuBTNPI8EbspZkgmDkzsxbnsfiBkaasENWKebyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HG58fynAOirqpqCgKvcRpEdKeBxKdFnnGmCZWxwjU8CEzsIvUFQdr+ZroDam0zQkd
	 GhPp22v9L7aaHom0ihQmDyXOWclsJSvS7P7kQYe+WrQGqZcV5fiF6QCuWwTb8LBcnR
	 gtY1iWUrcp1xMG7cnRYGs9k0LOI1gTSWy0wq972A33y1vB6UONEKXvTfXvzU06nnDt
	 H++LS49Hzz0vOov17WiWtP41/kz8jTxYONKnDHkkxgmzwuYV1sUwaoRQrAM09kIGAf
	 NYfWO0od/rV2YyOtynf+SL7NZwEA36wf6xCg8wHejq97HDiHuPaPWeNbrw20rcvFfU
	 QKoP6GfZ4DVCA==
Date: Wed, 19 Mar 2025 09:14:12 +0000
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, linux-iio@vger.kernel.org,
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2][next] iio: cros_ec: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <Z9qK5B-SgR_aQozc@google.com>
References: <Z9lE6IVDeC5lnChN@kspp>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9lE6IVDeC5lnChN@kspp>

On Tue, Mar 18, 2025 at 08:33:20PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> Use the `DEFINE_RAW_FLEX()` helper for an on-stack definition of
> a flexible structure where the size of the flexible-array member
> is known at compile-time, and refactor the rest of the code,
> accordingly.
> 
> So, with these changes, fix the following warning:
> 
> drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c:39:40: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Tzung-Bi Shih <tzungbi@kernel.org>

