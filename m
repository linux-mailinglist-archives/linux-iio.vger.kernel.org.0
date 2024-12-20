Return-Path: <linux-iio+bounces-13727-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 890319F9A17
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 20:16:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 708111886D1F
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 19:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AAE2206B9;
	Fri, 20 Dec 2024 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l4enO0hk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E2921CFF0;
	Fri, 20 Dec 2024 19:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734722178; cv=none; b=G7xJPGECGWkpQ5HBpUuwQK8wZySZOQojy2uKCib2EaSnv5a7tedtIwsdMB15pCTe72+cseJaPcBPFIlxlcR0vw0JkYce4rHooMvT6zTY7/FFFaQYPmgC7GnHzVwmBLSmPeUrm0nCo4+//Ff37EHF11oTjuvuiQxY0ggs8C/KH4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734722178; c=relaxed/simple;
	bh=I643DwvqBzrmpkd9/0WO7g45CYal1YEc+dZTmIiyD1g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BQYfDiluFenfIakKe5EHSWmY3EzoxPGPca6KYzx8Ok0qgmoXD9eF3FcCQ914q0tWX8QfiOTjbljz7m9nTxVzgisJo8pxVb1tisuctfUgCLkuCwm054/86R56iassotTiIfPiDoop9qdrnoQRTk1FAqlg1A8nM0RmkCN1RfelO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l4enO0hk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E977C4CECD;
	Fri, 20 Dec 2024 19:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734722178;
	bh=I643DwvqBzrmpkd9/0WO7g45CYal1YEc+dZTmIiyD1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l4enO0hkkbSSbuW8Y0zDIg+lapfbiqVfbc6E19X4BBWJMipG4EUwa8DJ/qIC+Bsz9
	 ZVFbYBessj5sVZxnekot7fXpw2RnVHEieVd9rmZNL9zmrWxKDHA2FTEPca3b+xeJas
	 aiEKIuS09zoM3j9eJZEXrfLYslYmldmh/Lu1GepbS5oPMeMyl2VpX1NgKIkmCrR+A4
	 VnwBXJAFIaVcJ37FAg7bEUHgoOg+xQzgw3nwPUubf54rDAbbSFzTd19QtR4tbnTmSn
	 gKpK1dpnCeTkdDstm0BVGE1klKtTNwaShpB8nr0fGQLHoRltqa29GwnJuhmrbBhKfD
	 AUyML6Ye/Y4oQ==
Date: Fri, 20 Dec 2024 19:16:09 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yasin Lee <yasin.lee.x@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, yasin.lee.x@outlook.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: proximity: hx9023s: Added firmware file parsing
 functionality
Message-ID: <20241220191609.5bc87451@jic23-huawei>
In-Reply-To: <20241216-hx9023s-firmware-20241209-v2-1-ce1b0a1121d0@gmail.com>
References: <20241216-hx9023s-firmware-20241209-v2-1-ce1b0a1121d0@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Dec 2024 15:59:40 +0800
Yasin Lee <yasin.lee.x@gmail.com> wrote:

> Configuration information is now prioritized from the firmware file.
> If the firmware file is missing or fails to parse, the driver falls
> back to using the default configuration list for writing the settings.
> 
> Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to take a look at it.

Thanks,

Jonathan

