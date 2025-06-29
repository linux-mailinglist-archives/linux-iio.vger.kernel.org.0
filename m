Return-Path: <linux-iio+bounces-21127-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C32AEAECEFD
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E23833A683F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3722FE15;
	Sun, 29 Jun 2025 17:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oT2sOG9B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F081220F24;
	Sun, 29 Jun 2025 17:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217566; cv=none; b=aIY4ebSMmpt7wuSVyRFETU3VCbSvkh03jfbxg96pi1J1359vMqxaRYpVWZ05EBOOmfLqirBkDGJdJF/FtxSVLe2WdfzPx7OwSmoUcBm84I3KgjsOZv7gfOb9H5dnZC/gp+RDcumjOZs6e05RVWmj/1P3CFXJY7vvLSiJJjCSR98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217566; c=relaxed/simple;
	bh=YldNSOo0ZySWbU/1iFp8j6a/lwwvm0CIJ+m1U2LXVI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YkuakmQaERltDHbUfuv7GSZCT7eieUoB8kj8DlUQpJSmNenLUVveVIlKUevnjqkHXivWVBsRPVXovUEe/5BXfjHB9dsEvAIfErtvkPT9ufSiLFoX3TydgIcM77VWSUCJ6yPkClAnpBF+eD1kMP/vs50Z+XYt4dph/6mn9/ngKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oT2sOG9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4FAC4CEEB;
	Sun, 29 Jun 2025 17:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217565;
	bh=YldNSOo0ZySWbU/1iFp8j6a/lwwvm0CIJ+m1U2LXVI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oT2sOG9BKlRe2ndWTsEM3SwCkhnP+qUBzjyMMEcR4aSuvH+hWKIg5pC5XGEYtr2XB
	 nRkVAZDhnTG4MiOnDE/SO/Z0Zk66SazvpPe5GjmDgfxue4nC5CONXJHeOpc+VpVmbf
	 85RGqA5cMMWXiZh80xZoW2A4F5mFF3iYcrYFocJXPZNBdZJPZUl6Rle7O48m+CmO7g
	 uU8VfY5BOKNh+QHZpS8M9aubjwzxjpwa8Nwno5zmpZpZNSZB32xzkx7Jdoh0N6a/3f
	 R51Pvwquk7GvL30ckao8h5Nt7em49Q7eW4UDTw1yEkf7DJtlMVIH1qKeZyOvP1x5pf
	 Ho7O8SSO3Brrw==
Date: Sun, 29 Jun 2025 18:19:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: abp060mg: make abp_config const
Message-ID: <20250629181920.352b8227@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-23-v1-1-542cfadce9d0@baylibre.com>
References: <20250628-iio-const-data-23-v1-1-542cfadce9d0@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:58:11 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct abp_config abp_config[]. This is
> read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.

