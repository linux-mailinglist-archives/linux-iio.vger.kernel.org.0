Return-Path: <linux-iio+bounces-5296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7FC8CF044
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 18:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB3F1C20A20
	for <lists+linux-iio@lfdr.de>; Sat, 25 May 2024 16:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874D986272;
	Sat, 25 May 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FakiL7n/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479A485C77
	for <linux-iio@vger.kernel.org>; Sat, 25 May 2024 16:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716656068; cv=none; b=RNW3Eb2uc6fELtJdb8BTGyfNRFHdMWimefslYebJThow/VwqJMGhutrG9zxRl1bkJ3sbFDSw2Nw0UpYz6YoGB7OmpTN5/MGxGLpLKlY+84h8Dwe7rG7+s30oF3YISv0YkOqlzn+k9THHoE6+FRBoWbMdDdFFkDTTEelF4JjTwvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716656068; c=relaxed/simple;
	bh=RvNDfTe/OI5nqKzUKIxtRLW/491ypYm09eX/697yLws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eIaURI00i7Gb05cKyQ9QeI8JpJAppYnmTk/lyT45n4WF2URZ/73luiLj+sXZU20VYSMCyxpwbjB1LAV2hqjkUImnEzydbug74EP3pqkYi+ppNm17dOgY3hxc4nrsMiMTenFfxYMU8NRBhqjTp0h9sjmb/4z6RuNMYUzu1+SkgLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FakiL7n/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42810C2BD11;
	Sat, 25 May 2024 16:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716656068;
	bh=RvNDfTe/OI5nqKzUKIxtRLW/491ypYm09eX/697yLws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FakiL7n/gE+7Zl520k9QKqfcWk4jh12l7GtX+yPIWd7Nb8gsYkskiCccTCWzq+hk2
	 KGXFFCOaSMkAKFyKinEZGPh9Z0zxWRGVslbklHN2kTjxD9wn6Sbou7szFwDx0cUrFK
	 OofqqEURZrwO0cpr4G2/F/wT+7hM/yz//K+/5Tw8+vtl5YI53d1XZvlD08Ry58i9Hy
	 WUQXMFa2xgn2hgGxICmh+vg/0g54AThw3k5hAGhYYtwnE8+6rbxoFDzcB7BlIVkcto
	 nbzO90T1ylJK4ChTnvXCi4cRUEhiqsidCkoUw9jLLu4wTSaqzMbIgu84sYngtqf6P4
	 CKHq9uBoW5BwA==
Date: Sat, 25 May 2024 17:54:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org>
Cc: nuno.sa@analog.com, linux-iio@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, David
 Lechner <dlechner@baylibre.com>
Subject: Re: [PATCH v2] iio: adc: adi-axi-adc: make sure DRP is locked on
 enable
Message-ID: <20240525175418.7b537296@jic23-huawei>
In-Reply-To: <20240522-dev-axi-adc-drp-v2-1-b63c9790a48a@analog.com>
References: <20240522-dev-axi-adc-drp-v2-1-b63c9790a48a@analog.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 May 2024 15:14:56 +0200
Nuno Sa via B4 Relay <devnull+nuno.sa.analog.com@kernel.org> wrote:

> From: Nuno Sa <nuno.sa@analog.com>
> 
> When enabling the core, make sure DRP (Dynamic Reconfiguration Port)
> is locked. Most of the designs don't really use it but we still get the
> lock bit set. So let's do it all the time so the code is generic.
> 
> While at it add proper mutex guards as we should not be able to disable
> the core in the middle of enabling it. Also reduce the timeout time to 1
> microsecond as it seems to be enough and goes in line with what we have
> on the similar DAC core (adi-axi-dac).
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Sounds like a fix, so fixes tag?


