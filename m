Return-Path: <linux-iio+bounces-6632-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9835E910C12
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 18:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5464C287989
	for <lists+linux-iio@lfdr.de>; Thu, 20 Jun 2024 16:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E90E1B29BF;
	Thu, 20 Jun 2024 16:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu2Yr48S"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C02E1AD486;
	Thu, 20 Jun 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718900445; cv=none; b=I0roc0AsvK4Gcb98YAkimsxEPPRhDTM7xWmFiFxp5zNzAVpAm0UJCZ54QCXj0sRRzl0VXZgdYxvORAR1HJX5vyqIMcgKy98sZydjzuEFkQwYL6X2ACCljr/r/qoXcy7x9vwH4C/mcXSE1fAEN9Mt76wYd1rVFbFm1mgFAlLKW/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718900445; c=relaxed/simple;
	bh=Ei2mXhkMdIXa7FVDgJeUlvKaLLb4XZD4GhWPWTEbGqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TPvWNeIBBlcTJZlnS5kqmpTP/fmBml74q+SQQE1V+yn07o0nr621BZsxw2PefO471L8kV371hadAFZQDWqBFjX9iRkkge06IcPp1hgSDbLddr6w5VTpLZd9GJcMuWSlC7bVVFG7l4XEy5mMtd5JetnTNqaWCBtRckbI8W7LG07A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu2Yr48S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412CEC2BD10;
	Thu, 20 Jun 2024 16:20:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718900445;
	bh=Ei2mXhkMdIXa7FVDgJeUlvKaLLb4XZD4GhWPWTEbGqs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nu2Yr48SMT1dEChkQZ4vicJt/c6nYv2Fw6IWSIcipsJAWbcMdGVKjF05YMka0KIq3
	 cQDU4SVfXPJx7LUIewT3F/xj9S9fMLKu7L18ycjslIuHn+0wmfiYmmo5jnusXD5h1O
	 dYgcJwPXw+fYdUIEhzuXZNoYOlj7XCgUMlRRfNxn3ZprHWDKCC5DuZX+SN5yRTWK4J
	 fjedakvvr6In6GUx7mW6m2s/kaWMeGf6SkNUA5lAafrSIuPws0f8+cidLkm18FWTBY
	 cvlElmnH/l6zdndlkAzl/4WZNPK4Lit46hXHzM9/IgkfrCm4sZJVdKw6GgKdjlgQYQ
	 rSLyTWdke1/Vw==
Date: Thu, 20 Jun 2024 21:50:41 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Paul Cercueil <paul@crapouillou.net>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Jonathan Corbet <corbet@lwn.net>, Nuno Sa <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v12 0/7] iio: new DMABUF based API v12
Message-ID: <ZnRW2axOg7gtKzz0@matsya>
References: <20240620122726.41232-1-paul@crapouillou.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620122726.41232-1-paul@crapouillou.net>

On 20-06-24, 14:27, Paul Cercueil wrote:
> Hi Jonathan,

Hey Jonathan,

Assuming we are fine with this series, how would you like to proceed.
Would you be fine with me picking the dmaengine bits and providing a
signed tag for you to pull?

-- 
~Vinod

