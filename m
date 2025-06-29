Return-Path: <linux-iio+bounces-21123-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D1AECEEB
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 19:11:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A991894F81
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 17:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D570E233D85;
	Sun, 29 Jun 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moWL4GNn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C7322FF39;
	Sun, 29 Jun 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751217086; cv=none; b=ZUIvar6XaT7j/52IFAMuWfnMkfj9cJIdajnTh3wO6Fe8bRtW3zibTLuN83C+bT8nS5SPFAXNKP0IH3T4JU52S1ClL4AHK/jJd4K5SRTmhGPoNc85zuA/ri8epuAOaLSwE/otkLhOtDF4joo2NR/udLZRw6BoAehR42qJR+xaY1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751217086; c=relaxed/simple;
	bh=NsxFsa31ErL1XisrpXp7338xKEiE/KAOJCfGNqkWzQs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J5lIYn+kOcCshy5HpZBK42IRSy5Dol4A2OxswOIT4w4WPDF7pIgQX2+q0h2fwMqTFZ5hLT8rQ/ZO8CCtP9JILnztCGTWhBf5vxJ1CeS6gqDrHp+OecMrRUfFsJ+pJx3IUOh1jv+pqa76CgG/Jy8NiUWKi8XgWWVyCkKNbl6sCvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moWL4GNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42CBC4CEEB;
	Sun, 29 Jun 2025 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751217086;
	bh=NsxFsa31ErL1XisrpXp7338xKEiE/KAOJCfGNqkWzQs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=moWL4GNnhaXC7AkD7RblJaJ38keQipD8d3KLxtsqI7EIXpfL2u3wGUO937Ig9eDhE
	 p2XJxaRr9j74NwzrpHIIcVnoM8AbD0UB1L/BfMjlNFnDmLI1DrmqjHuZopaLffUMuN
	 9NuyMRIBx9+jHzXAgGWGKpPjqkUgsDOEEG7YzZ1QkXWbl4iYZEN3QV01q29VtD0L+m
	 tpCO2KI9xmLIAQS9XQ1x+8OUbFEVvRhRrQItQQRR7nkVBbLQYbVOsxBF/1/SPUZet4
	 m/cZ3xZfAVPCyxPPZ7FNNzpsTGtZqG9+3zmRBenGrgKVI7sNfC7TVtUwvSBu9rCVjH
	 no+f2hIpkMuGg==
Date: Sun, 29 Jun 2025 18:11:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi160: make bmi160_regs const
Message-ID: <20250629181120.4e325b23@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-18-v1-1-dad85ac392ae@baylibre.com>
References: <20250628-iio-const-data-18-v1-1-dad85ac392ae@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 12:31:43 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct bmi160_regs bmi160_regs[]. This is
> read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied.
> ---
>  drivers/iio/imu/bmi160/bmi160_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/bmi160/bmi160_core.c b/drivers/iio/imu/bmi160/bmi160_core.c
> index 9aa54b95b89f96299e65b9cc00149bffe5f2e56a..5f47708b4c5dc5b2eb139b1c36542aae22a4cf43 100644
> --- a/drivers/iio/imu/bmi160/bmi160_core.c
> +++ b/drivers/iio/imu/bmi160/bmi160_core.c
> @@ -161,7 +161,7 @@ struct bmi160_regs {
>  	u8 pmu_cmd_suspend;
>  };
>  
> -static struct bmi160_regs bmi160_regs[] = {
> +static const struct bmi160_regs bmi160_regs[] = {
>  	[BMI160_ACCEL] = {
>  		.data	= BMI160_REG_DATA_ACCEL_XOUT_L,
>  		.config	= BMI160_REG_ACCEL_CONFIG,
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-18-b83bdb3e4d05
> 
> Best regards,


