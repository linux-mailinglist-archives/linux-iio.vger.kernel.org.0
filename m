Return-Path: <linux-iio+bounces-24979-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E6092BD0691
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 17:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B1C354E2D5A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 15:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D590025A343;
	Sun, 12 Oct 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSYBnsbK"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F0612B94;
	Sun, 12 Oct 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760284533; cv=none; b=KQ+x8IMU1xThNboJzu+SjWR1szIxhcJShpZO6nENL0OW6vOlAd9268tketlFJJJ9Tp5dE6Abg3Z9JzUTFx6rPmmMBbQNeb0ehwptPa6GBqFB9l9fHBVeOEjj/ie7DbrgWdanq/GPA2i4RRJVvkiI/HEAKxLsEulA1qACp6zUlOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760284533; c=relaxed/simple;
	bh=CV5rh/V2mOpSDrqe7y6NtlcKTEk0aGknPy0WEppMuTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nv7e8T7NNvSLB2HbeLDiweuEcxbhuYeDCfhvD0KfoLd+1dNfg1TH0bGo2L87FAySNb8C90a3EjeUwtjwQayn7e1F541IanQjipOLjdQI0BjSfWzLu3Ekjmb9ZrpfGsO/wVmGDNdAlnp4FcbCsKfbB9xIuNrBZm/gFnqCm/l+hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSYBnsbK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C773C4CEE7;
	Sun, 12 Oct 2025 15:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760284533;
	bh=CV5rh/V2mOpSDrqe7y6NtlcKTEk0aGknPy0WEppMuTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HSYBnsbKNXKwaNSHzQs4BBX39L41RvBWaiCdfvNL9LE+3Sj0ZMQeA+gpPlau3xmho
	 FH/u5boej8HOlKoaQQV/hUg4xPwH6I3Psi1gMv0+fjWV9DND4pTV8KTd+hZ64CsqX5
	 2PvG6/MwznRfcZONYJ+bpt7MK+gvUTwpskPQPyjDoFU/azqTdhUKfEVT3KsSTBzziB
	 xLwnvm7rORV292jY7QUyQ3v7YNSW0OvvikyR2LIq3mCXA2YzbWQnqakZL1zzs3lM3w
	 rqdNrB/eoRZ+EWiNAvDUSLK9F0ap6iwcs7NfEd8gx+X+fH7pQI5w2dhIodSFwfYHcz
	 cojYlYCIiH5Wg==
Date: Sun, 12 Oct 2025 16:55:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: dan@dlrobertson.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/6] iio: accel: bma400: Refactor GENINTR config and
 register macros
Message-ID: <20251012165524.16a14412@jic23-huawei>
In-Reply-To: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
References: <20251007055511.108984-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 Oct 2025 11:25:00 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> This series refactors the BMA400 driver with a focus on generic interrupt
> configuration and related register usage. The main changes reduce
> usage of hard-coded values by introducing macros and formula-based
> register addressing, and add a centralized lookup indexed on iio event
> direction.
> 
> Alongside these updates, the series also reorganizes and renames register
> and field macros for consistency with the datasheet, and extends comments
> for additional clarity.
> 
> All patches are pure refactoring. No functional changes are intended.
Other than comments in patches 1 and 4 this series looks good to me.

Thanks,

Jonathan


