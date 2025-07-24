Return-Path: <linux-iio+bounces-21940-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A220CB10825
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 12:51:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2FDB1CE707B
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 10:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B95026B09F;
	Thu, 24 Jul 2025 10:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQcHMZjK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECEED26B08C;
	Thu, 24 Jul 2025 10:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753354294; cv=none; b=m+0BJ9CekpcYx7cF+kpo0YNvk1engKL4PwHRaoKnz5IEld1FxUm5rKyVCaFFk++JWqQAHi7hhtUEa1XARJUWkmhtk/5+0yq6mOeG/1ypOqZ0pjITD2T/Wglv0o6FMxPJTfU2kQoICJRqsa20lIpkpUTh9w/dQ8hNjdAnU/u/uhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753354294; c=relaxed/simple;
	bh=cMHUTee42ir/svA7QsTg3fFIrTyR5Hn+drgtI/JFs0M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TfbZfU2/QMhQO2e9746wjn4L3fQJ+lk1JStK9Fv1wOewDjUK02yeGE7QBOtPhBY2fnWy1fqPy5y6NrdvOCDEJP95k0GzyJ2wmS1Ro2sE8K3/Dec6VGDuBLwtyxHK70rIyir7tH/3N/MnHxud23ibpQ2U8gcq8rwI+KAWTVMZP2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQcHMZjK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46801C4CEED;
	Thu, 24 Jul 2025 10:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753354293;
	bh=cMHUTee42ir/svA7QsTg3fFIrTyR5Hn+drgtI/JFs0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DQcHMZjKCt+FmST4M80tdg3hzHCCRw/Gmpv7s2pi639E6Be0gJbuzt5RM+Ds1oDOe
	 ZG+21YQUichTiotv9GvjbcHHkvhbLDW7VkyvGCuDPl1PtAHso5PXZlZbqTw0JZbBwr
	 XYiw81hywFhSU+9qYxa/jOHpoKLBXgO+O7dbwTh5U0vPJWh6pPd3A0VsWwboc3kK99
	 AmrbtwhwGn9SzUrPfR5pwEe4IchEaG7stRW4M+RqbUIWWzgLKQUS4C+14pDiFkS8kC
	 TuiDzqKs/SgmcomIYZVHCabpDlSOfcHlXxv5Iwv2RHApomvgRCf8g+2rtS833gG7eq
	 PtgKnUDK5VqyA==
Date: Thu, 24 Jul 2025 11:51:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: proximity: pulsedlight-lidar-lite-v2: use stack
 allocated scan struct
Message-ID: <20250724115127.19fc70d4@jic23-huawei>
In-Reply-To: <20250722-iio-proximity-pulsedlight-lidar-lite-v2-use-stack-allocated-scan-struct-v1-1-4c253339b941@baylibre.com>
References: <20250722-iio-proximity-pulsedlight-lidar-lite-v2-use-stack-allocated-scan-struct-v1-1-4c253339b941@baylibre.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 17:34:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Use a stack allocated struct for the scan data instead of using the
> driver state to store the struct. The scan data is not used outside of
> the interrupt handler function so the struct does not need to exist
> outside of that scope.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git.

