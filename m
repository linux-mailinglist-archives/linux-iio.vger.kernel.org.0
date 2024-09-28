Return-Path: <linux-iio+bounces-9825-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97B60989009
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B4AD1F21E80
	for <lists+linux-iio@lfdr.de>; Sat, 28 Sep 2024 15:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403AF224F2;
	Sat, 28 Sep 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1pD7TI7"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2613224D2;
	Sat, 28 Sep 2024 15:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727536728; cv=none; b=OJBi+zrsPiZA33Q1g+dhXv8ERtQkqjAxPI77cL4tyPZjcoUt/ErmsB8l9QilwDiaPe9iREtutcyOZHmF2HNAIgwtTlnKp8fHv/VUFrHvNwNTiAxEzS/vNzb246OOD30pIoMXZc/ruglM1vQw0otc/L2tOVnRtPjekmP7Aw00tAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727536728; c=relaxed/simple;
	bh=lM1NkKdFqy71VsSFSQOZW91GjJapyQAbXGht+KbE9RU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5ZAzjg2ZGpnGlVJegHw3W2wmLtgD5ItU+QXHPo2pc8++5wer42meYU43SUFBju4hBN5MAzJrP5SwvoWWhGauJxp3fIRd8d/ZWs7tTLNY/xnZ8Xw8FWQ5siuRyXSlq8Wzfjsth72nn6BPSxcWoOSKYrQL/2pxZ4FpJC/asBLMWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1pD7TI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB475C4CEC3;
	Sat, 28 Sep 2024 15:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727536727;
	bh=lM1NkKdFqy71VsSFSQOZW91GjJapyQAbXGht+KbE9RU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X1pD7TI7JNzYWMu8nWCCJZytfU9KCahVkKtlvWppJYQMF3dwm3spa4WJgHWfteim/
	 s3HtUKAFtu6HD5Hzs1sucO4T10+OzewUiiYx/xO8p6g3gg/xut55161PdiIdNDoGsZ
	 +7QV1HKM0aYJ8jxaOB8us9Mkgjxc/xHuRsULpZI6i4xYGRpvvygrg1gpjv7vdr49yS
	 hz+J3ZBItvHZ6PFwUE77RvVuLjgmXeM6kRxyPO7mOXo18F/erp00OxchF9BqvElPuU
	 ZOYrzOnHnxRPFAE8xbx+ojxV8zN1s1gcZrONWH7Qsb8dIqvzyG3BHGq5TOLbDlM7x6
	 aVn35zDVif0Og==
Date: Sat, 28 Sep 2024 16:18:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Denis Benato <benato.denis96@gmail.com>, Jagath Jog J
 <jagathjog1996@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iio: bmi323: Fix some bugs in suspend resume
Message-ID: <20240928161839.6cdf7b18@jic23-huawei>
In-Reply-To: <e5a7bfc4-7c30-4d68-a522-1d780e910da1@stanley.mountain>
References: <e5a7bfc4-7c30-4d68-a522-1d780e910da1@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 17:09:03 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> These were a couple bugs I found using static analysis.
> 
> Changes in v2:
> Added an error message in patch 2.
Both applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan

> 
> Dan Carpenter (2):
>   iio: bmi323: fix copy and paste bugs in suspend resume
>   iio: bmi323: fix reversed if statement in bmi323_core_runtime_resume()
> 
>  drivers/iio/imu/bmi323/bmi323_core.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 


