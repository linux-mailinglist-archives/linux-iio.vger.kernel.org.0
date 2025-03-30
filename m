Return-Path: <linux-iio+bounces-17380-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D87EEA75BA1
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 20:02:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B485168B4E
	for <lists+linux-iio@lfdr.de>; Sun, 30 Mar 2025 18:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD511DB546;
	Sun, 30 Mar 2025 18:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z4hP+rzV"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED017A2EB;
	Sun, 30 Mar 2025 18:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743357722; cv=none; b=L6m5EEYTcF902sgHucOyVFYQicShpz2eDIfFPkD2HQ5MVOkgQA3eaAnk1mco9rdwo5xdHQZEY+NtfTUReX1ZWCN7sd8zOVoWJWDtZm6Hk9tjg+qfkQEXwWaFqxmKIu0R2c8iLk1XLRbu16sKhli1OSxgI5hPV0JcbCqjZU68F1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743357722; c=relaxed/simple;
	bh=y7IkYINZoPrWXl6a8K3ucfDC03WxLH++U30E6uOvYb4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tRS3MwTO88dGIA5elGVMn8NfQ6NX9tT7LMgQZs7BHjd/J6YJ58SKz/M7ByECwvLchai5TMNwZ3h2Wnlk2VZQ4ZCVj7Y+tn4A27b9HgV+fvOLgGabjDa5nEXw5XjqBVSJwhwyB2eKxzZXXbEsvPz6FZv7D53qf8n5rOqf3jFDfjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z4hP+rzV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B3DAC4CEDD;
	Sun, 30 Mar 2025 18:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743357721;
	bh=y7IkYINZoPrWXl6a8K3ucfDC03WxLH++U30E6uOvYb4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z4hP+rzV7380qV4YLkBo565XtlM4fEuqA2exN2jP/TO1Cw11H8teELJRTK5FKC1gW
	 4Oul+9aMqUmG6dPz2FVp4L9Vow7zKNbnQFKCHZtqKvX1r7VXInIX3gHDcPlbM8u88n
	 2svvK4tdF/lPxxSJsq/4t8voSOSU91HswfYA0IieYGNYjpSEn+STE/ABSrpyrM/rch
	 +oR6JTx0IZSpQ8Tmp/hVO5o/99DIjUVb+cx9zcYpSAhbH/A6IEz0J8nzhs/JhevRFd
	 J1Z80cd1+7fS02nRedwrZXRO638TRXjVURS0L7XAVltFWXH0LlVbec/vLtDXelk6IR
	 IV2z6f97Ly6nA==
Date: Sun, 30 Mar 2025 19:01:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, Michael Hennerich
 <Michael.Hennerich@analog.com>, Angelo Dureghello
 <adureghello@baylibre.com>, Alexandru Ardelean <aardelean@baylibre.com>,
 Beniamin Bia <beniamin.bia@analog.com>, Stefan Popa
 <stefan.popa@analog.com>, linux-kernel@vger.kernel.org, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2 08/10] iio: adc: ad7606: drop ch param from
 ad7606_scale_setup_cb_t
Message-ID: <20250330190152.28268e84@jic23-huawei>
In-Reply-To: <20250318-iio-adc-ad7606-improvements-v2-8-4b605427774c@baylibre.com>
References: <20250318-iio-adc-ad7606-improvements-v2-0-4b605427774c@baylibre.com>
	<20250318-iio-adc-ad7606-improvements-v2-8-4b605427774c@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 18 Mar 2025 17:52:16 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Drop the ch parameter from the ad7606_scale_setup_cb_t functions. The
> same info is already available from the chan param via chan->scan_type
> and chan->channel, so the parameter is redundant.
>=20
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied 3-8
Thanks,

Jonathan

