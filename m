Return-Path: <linux-iio+bounces-21116-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0377AECED4
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:58:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22BF4172741
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC29235341;
	Sun, 29 Jun 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NaH86OP5"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252D41FE45D;
	Sun, 29 Jun 2025 16:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751216324; cv=none; b=nvqs1DtarhHdLqe41Iz24MvtMXRRXWWBUkWOipYgIMoSERIMJTqfPXnpLmK+240in+gWHwr1WeVvk6SakotQk2PfbVkoBFJTCPk6/yARB3pF7ZRiwVl7QgQxgOuDOuAT2DmU/Kbb1j5r8pkzSY4JR/h/A7Jc0tSJw2Cz5u+AvWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751216324; c=relaxed/simple;
	bh=AZL07K9yhl1TMeuWuZEjnE6P0P1K6QtCGjf46WWEoC8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pZz0m5hF+9ScHXIHLo5SveJYwClTFOKdG4Hg83T+CYNmLEaKxSvmDli/gAY9ahz/b5NfSpVFnV/GAg0r+79SO0k1XYdbJJaMCYPF4JaODr8zjmfcRffXa67oUuqClG+lQQQxyY0aE8fPizkwIZaIbyqOFkVzkD2J83jWKUeKt3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NaH86OP5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E1FC4CEEB;
	Sun, 29 Jun 2025 16:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751216324;
	bh=AZL07K9yhl1TMeuWuZEjnE6P0P1K6QtCGjf46WWEoC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaH86OP5kqYk12JmPlqTGeuB12jVCDChXp6Xcc3hJta5KXear6On9pgzPg842rH8Q
	 jK+3+FQur9MV4FMQ5bS/dYZjV1yAyfb5gkG+jRySjY9DALSTvQk6StpdgyirhjZBuH
	 Nc9MXk+eGZpXnhC2lQw51jAOOMQvCGiyoFeH77I6ZY5fi6ag1I5/IPCQu8xuTIy2Vn
	 ek+iEqGDOyfhnNWI5vPmCxf7XIFSm5B6TK4/hZZwhQGSmx0t6ZKRk6gJuT4OM0F/l4
	 cm5QqrjH88YnLZkZD7gZzE4Na46jktxLVs/FwqFXQiS5nSTOwrgjhb+7EB4turC4LF
	 UQebrOjqaYyRw==
Date: Sun, 29 Jun 2025 17:58:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: qcom-vadc: make scale_adc5_fn const
Message-ID: <20250629175837.694d3aeb@jic23-huawei>
In-Reply-To: <20250628-iio-const-data-9-v1-1-188ca6e904ee@baylibre.com>
References: <20250628-iio-const-data-9-v1-1-188ca6e904ee@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 28 Jun 2025 11:36:01 -0500
David Lechner <dlechner@baylibre.com> wrote:

> Add const qualifier to struct qcom_adc5_scale_type scale_adc5_fn[]. This
> is read-only data so it can be made const.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied to the testing branch of iio.git. I'll let 0-day poke at it for a
while so there is time for additional review if I've missed something.

Thanks,

J
> ---
>  drivers/iio/adc/qcom-vadc-common.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
> index d5209f32adb3e265acd51d56dda32e6d0be42e21..b03cf584b1657ed39a325fcdbdd9dea96f171f8b 100644
> --- a/drivers/iio/adc/qcom-vadc-common.c
> +++ b/drivers/iio/adc/qcom-vadc-common.c
> @@ -330,7 +330,7 @@ static int qcom_vadc7_scale_hw_calib_die_temp(
>  				const struct adc5_data *data,
>  				u16 adc_code, int *result_mdec);
>  
> -static struct qcom_adc5_scale_type scale_adc5_fn[] = {
> +static const struct qcom_adc5_scale_type scale_adc5_fn[] = {
>  	[SCALE_HW_CALIB_DEFAULT] = {qcom_vadc_scale_hw_calib_volt},
>  	[SCALE_HW_CALIB_THERM_100K_PULLUP] = {qcom_vadc_scale_hw_calib_therm},
>  	[SCALE_HW_CALIB_XOTHERM] = {qcom_vadc_scale_hw_calib_therm},
> 
> ---
> base-commit: 14071b9cf2d751ff9bc8b5e43fa94fbf08aceea1
> change-id: 20250628-iio-const-data-9-688cc6e2c7a0
> 
> Best regards,


