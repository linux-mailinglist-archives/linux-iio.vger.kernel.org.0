Return-Path: <linux-iio+bounces-21489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17711AFEE14
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 17:52:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C9FF7A768E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jul 2025 15:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C892E8DF6;
	Wed,  9 Jul 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4004DYN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877311C861E;
	Wed,  9 Jul 2025 15:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752076313; cv=none; b=PPcEXzlyh8NJPLSJXB66rdtFH7BHMSw7puiOGKo+a3wvwJdVTQM7AbhS7mZUcYsNy82I6B7VBa6QH6z0fPshY0UUaHkuIaJ533767xGUr5cJTdkXVwvw9XbiPgBc5tzrSMBxgyFCJHhA+sG4tjE0hdXH+759B3FyKY7sOtEO1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752076313; c=relaxed/simple;
	bh=NG8CyYp+iUwexEUDhr3HehkhK/DI0dNzlH1iM98OlVs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sfw78YUyFr/8kOKnrW+cv/6YALO8b0qm28VtQRpd+7It3CIQdJiUVEcHGLe6L3bhUep8HTwkrO2ZNLGeq5IKz8IK/lpRx6tKF+MNmwaoaXXfzKxQFhqoGueods2R+RW6wp0R4iXtvXbL1LiskUGYVYJQrlA7Ky/xnsLyQoTOBCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4004DYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF098C4CEEF;
	Wed,  9 Jul 2025 15:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752076313;
	bh=NG8CyYp+iUwexEUDhr3HehkhK/DI0dNzlH1iM98OlVs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A4004DYNmTB30CAteC5mvwmOyTmJTG1jt7jQKgMVnZADRsaG07onp0XvffZ8l9ENC
	 loF64wPD64lU8OCSXVuVR63O7K2m4c4nxeZE8LodiwlDeSUmbXtMi7A/7cb17bA62w
	 IkV9k8+EWKFkxmgAuPwzmz8UhDNmrtGeA7TQY/uC2fXXjtVM+LkZmJkWnYr3ieE1Vz
	 ynL47rt8V/K6rIwM+DkVWLxT6D/dBqbSyvSobackAjedpUWJjrvzmgSFfgOElk+Sri
	 GMyUnzDGUuKoxy/ipn2eiTpHZchbpaZrNN38/4ejnERv+7LsH31tBvr6/Grvct7KC/
	 O4Mf1nOCGFnSg==
Date: Wed, 9 Jul 2025 16:51:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rui Miguel Silva
 <rmfrfs@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Julien
 Stephan <jstephan@baylibre.com>, Waqar Hameed <waqar.hameed@axis.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/12] iio: gyro: Remove redundant
 pm_runtime_mark_last_busy() calls
Message-ID: <20250709165144.62c3cad9@jic23-huawei>
In-Reply-To: <20250708231152.971602-1-sakari.ailus@linux.intel.com>
References: <20250708231144.971170-1-sakari.ailus@linux.intel.com>
	<20250708231152.971602-1-sakari.ailus@linux.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  9 Jul 2025 02:11:52 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> wrote:

> pm_runtime_put_autosuspend(), pm_runtime_put_sync_autosuspend(),
> pm_runtime_autosuspend() and pm_request_autosuspend() now include a call
> to pm_runtime_mark_last_busy(). Remove the now-reduntant explicit call to
> pm_runtime_mark_last_busy().
> 
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  drivers/iio/gyro/bmg160_core.c     | 4 +---
>  drivers/iio/gyro/fxas21002c_core.c | 2 --
>  drivers/iio/gyro/mpu3050-core.c    | 3 ---
>  drivers/iio/gyro/mpu3050-i2c.c     | 1 -
>  4 files changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
> index 781d3e96645f..38394b5f3275 100644
> --- a/drivers/iio/gyro/bmg160_core.c
> +++ b/drivers/iio/gyro/bmg160_core.c
> @@ -309,10 +309,8 @@ static int bmg160_set_power_state(struct bmg160_data *data, bool on)
There are only two places where this actually takes a runtime variable on
value.  So if you do introduce the helper Andy suggests then
only apply that in those two cases.  Push the direct get/put down to the
call sites for all the others.

>  
>  	if (on)
>  		ret = pm_runtime_get_sync(dev);
> -	else {
> -		pm_runtime_mark_last_busy(dev);
> +	else
>  		ret = pm_runtime_put_autosuspend(dev);
> -	}
>  
>  	if (ret < 0) {
>  		dev_err(dev, "Failed: bmg160_set_power_state for %d\n", on);


