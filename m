Return-Path: <linux-iio+bounces-16878-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4BCA631CC
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 19:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0223E3B2089
	for <lists+linux-iio@lfdr.de>; Sat, 15 Mar 2025 18:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDCC205AC2;
	Sat, 15 Mar 2025 18:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvMvwA1B"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1C8188734;
	Sat, 15 Mar 2025 18:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742064178; cv=none; b=t9olhIEheKSpYlhA+GKWBqie6iyhjyKXeZSxTTxLvavLYla3d92E5hMbZhGJ5BYEzIddXa//2JNeyMHvfFnf4lMaYPeWMBsKWmLpKKky/UZAZHh/s7TMg/TAGJ4dBGvR4JPWOCSJeeotYLYnpAo+Cf4bWLz70SeFQotLG5ewKO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742064178; c=relaxed/simple;
	bh=CF3N/y/h6IoYkrV7l5KyVShMcxg8+vrteyJbwryMFE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G88PDJfpG7Gusr2vdV7McJqmQ55z7NImy7xgXbBpqLnVduNxYeBXV2H++f+BD9Y03CfoNP1UkX44pO9B4RJ1TrFegP9JSLEOoN9CV2f6hfF6iglT1cRY6E1LVIM74eww3jnv0lsaV+SX+PgJEFCXzyGa3cRXA9qeVpR7M6HMbZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvMvwA1B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5B9C4CEE5;
	Sat, 15 Mar 2025 18:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742064177;
	bh=CF3N/y/h6IoYkrV7l5KyVShMcxg8+vrteyJbwryMFE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hvMvwA1BBlZ+K6XDgGoB5lvqv0h6iEv8eeKYLsxgW4BJg9u3R6SiIchUGbyL/GjR5
	 7ldOaN5gmO4hXeBWhuNZgBDSOEwIvvYpuNYKq7SyRLmJluUwqqRbjnpyjCe6FM+9m/
	 X7HF82p7CGd/aZyAh1VSLy7AY7cWdw649I3wjoguqotihYTjFN+PCA/FG7CB6e2bl6
	 UV9GyEs3ZtG9HZwUg4pd4w1ueR48P/8dv8x8KZl7WaYpzC88sBwjnePw6T6f7bs90K
	 Pr7uHwC+L3PnWFWQV09jJj8qCPUqWzs9ErXyb2kocV76oy0ivkmGbhMvjOfFyBkVxG
	 GgdcNO/m7Rwfw==
Date: Sat, 15 Mar 2025 18:42:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Tobias Sperling via B4 Relay
 <devnull+tobias.sperling.softing.com@kernel.org>
Cc: tobias.sperling@softing.com, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: sort TI drivers alphanumerical
Message-ID: <20250315184249.075566a7@jic23-huawei>
In-Reply-To: <20250312-sort_ti_drivers-v1-1-4e8813e662d2@softing.com>
References: <20250312-sort_ti_drivers-v1-1-4e8813e662d2@softing.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 12 Mar 2025 16:29:40 +0100
Tobias Sperling via B4 Relay <devnull+tobias.sperling.softing.com@kernel.org> wrote:

> From: Tobias Sperling <tobias.sperling@softing.com>
> 
> Sort TI drivers again in an alphanumerical manner.
> 
> Signed-off-by: Tobias Sperling <tobias.sperling@softing.com>
Thanks,

Applied.

Jonathan

