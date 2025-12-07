Return-Path: <linux-iio+bounces-26890-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EBECAB6B4
	for <lists+linux-iio@lfdr.de>; Sun, 07 Dec 2025 16:35:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CA803014A11
	for <lists+linux-iio@lfdr.de>; Sun,  7 Dec 2025 15:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 502902638BA;
	Sun,  7 Dec 2025 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MtKH9tY2"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC03B8D60;
	Sun,  7 Dec 2025 15:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765121737; cv=none; b=GpaUEe7gXnV67DnBrldUN+oj+ubTOjvDK08tr8UfXTZhsvea7A9OtQEYt3xH8e/7LcnWxrVuv39WB94FVWD7hyuMM+So+Q4vNeEHyGDZks6Y1348lyShN7hlXfo4stCmZpofI0WBETX3nJZ1lq9o/TGJzKXQuB8XhFyANCv8BhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765121737; c=relaxed/simple;
	bh=bjBPrBoWEJig6/XYiDP8EEjg+vlgTWZ5lOCF0oeLmlk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r9JRA7E/E8HBoHASQHE83WUeOpgX6RGs0JOE/aXanGS/fe5uo+A86ICxhDSseQRsyGzN+ZMNLkbPqBR0jMXsaTaohMOfVKyq3JS8XCwm0fFzeRSRZ/d8d5D4e6REL9/Kwxz7kQNwtffk6QTeCwtRr23Y88ij3mwIiLFuMV3csGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MtKH9tY2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09664C4CEFB;
	Sun,  7 Dec 2025 15:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765121737;
	bh=bjBPrBoWEJig6/XYiDP8EEjg+vlgTWZ5lOCF0oeLmlk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MtKH9tY2NteAKzPVj9aWectc+aRRzZm62LxHdEF/75yP3vTlBGtFdkCHconeUnpMp
	 TPo6Fvay0V1OO+32aGWYxgAt8yklc2eFWvtVVUF2W/ndhwbAxzi+VnkoqmmJVtd23U
	 R0Gh6YoxL74/Hfxu9K3cM73rpOyZ/i+eFZeusCgllyTuNorQbqqP6D9bo700HdZ2cV
	 V9VZHxMj42I0E+x3dD/GqUKFOEX92mURoQjCpMskKppZs3WYkPxAFJzcDoZ24pLnEI
	 XOrwDQtMBrKDKOmtT80e20mw1pWMscdNNpTaD5rNiZPNy6j5dKc6cvPkgBxzJZn9or
	 vtJyTavcHD/Dg==
Date: Sun, 7 Dec 2025 15:35:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/9] iio: imu: st_lsm6dsx: add event configurability
 on a per axis basis
Message-ID: <20251207153528.266a167f@jic23-huawei>
In-Reply-To: <20251201100018.426749-8-flavra@baylibre.com>
References: <20251201100018.426749-1-flavra@baylibre.com>
	<20251201100018.426749-8-flavra@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  1 Dec 2025 11:00:16 +0100
Francesco Lavra <flavra@baylibre.com> wrote:

> In order to be able to configure event detection on a per axis
> basis (for either setting an event threshold/sensitivity value, or
> enabling/disabling event detection), add new axis-specific fields
> to struct st_lsm6dsx_event_src, and modify the logic that handles
> event configuration to properly handle axis-specific settings when
> supported by a given event source.
> A future commit will add actual event sources with per-axis
> configurability.
> 
> Signed-off-by: Francesco Lavra <flavra@baylibre.com>
Applied.

Thanks,

Jonathan

