Return-Path: <linux-iio+bounces-18002-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 074C8A86CC4
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 13:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357D31B80206
	for <lists+linux-iio@lfdr.de>; Sat, 12 Apr 2025 11:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B831C861E;
	Sat, 12 Apr 2025 11:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhTpejpO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C31714A1;
	Sat, 12 Apr 2025 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744457102; cv=none; b=KrJYx7nPEIMDmA3HrMm7SywBfm0EPlLFhCDzvuPHy7mqb/LmU1Sd4hxLmkZ901yZ0KoomathivfQ99YbA0cEC4zATvc38Y5AwmtwPZ9wZyEoWYymuD9pYmpDHwwmwmMog3/Zkk7jqUxNL2MrkbLzup8BvM5O1n202K6KHQDhWyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744457102; c=relaxed/simple;
	bh=ZaM2TeSFoCPZVM18egIjPf1OdX0rAkfIaNxZwU2/GeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A0OR8E8UjcGg6emzw0fqpZZmtPJxa3lnKa5RyXUVvkRGHhKD1nexVMy3l3ZI+t8YCoGQ614S0bBF+GnB/xyJxUmo+j/mkBzJ7K6ov6afyLqq46ITI1sKkj6MgbzBNUZK8VSu99MNeBnHhA1x06TDE/XOsycqLLwRO32UJmvHd4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhTpejpO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626C9C4CEE7;
	Sat, 12 Apr 2025 11:24:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744457101;
	bh=ZaM2TeSFoCPZVM18egIjPf1OdX0rAkfIaNxZwU2/GeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DhTpejpOjYCA7bDwnTxCXM0OtaqKz3LDQtoR3YiokaReXDRODFD5qBWiuDP2Jj3GO
	 Yj11rhfq0yoq0Et8ZG77OwViFoU6RJVtJblyNp8Iw3KtiG4zQ4WNwMdsSSrKlKTRyw
	 qt8QvRi4y+4wSt9l8wvdhBzrD1bPL/omUoa07IBOniBZpljsi2DoCEwsbEs7itd8El
	 PN1LGaDyT3PUASRSOgkpAkUUBi2tNPyW4O4818sSLPUc0ALkXl0fzPn1XfN5+Od8Z6
	 Fosw7zhw9Qbz+qFW1jV1e75s0tTh6/OyAhRCJwQI/x0yv80u6KE2JZrbsq6YKhqamv
	 B/rZN+E/ztAvA==
Date: Sat, 12 Apr 2025 12:24:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Lorenzo Bianconi
 <lorenzo@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/3] iio: Fix wakeup source leaks on device unbind
Message-ID: <20250412122454.2a34182b@jic23-huawei>
In-Reply-To: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
References: <20250406-b4-device-wakeup-leak-iio-v1-0-2d7d322a4a93@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 06 Apr 2025 22:01:41 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> Device can be unbound, so driver must also release memory for the wakeup
> source.
Applied to the fixes-togreg branch of iio.git.

I haven't marked them for stable as seems the resource leak is fairly
harmless.

Jonathan

> 
> Best regards,
> Krzysztof
> 
> ---
> Krzysztof Kozlowski (3):
>       iio: accel: fxls8962af: Fix wakeup source leaks on device unbind
>       iio: adc: qcom-spmi-iadc: Fix wakeup source leaks on device unbind
>       iio: imu: st_lsm6dsx: Fix wakeup source leaks on device unbind
> 
>  drivers/iio/accel/fxls8962af-core.c          | 7 +++++--
>  drivers/iio/adc/qcom-spmi-iadc.c             | 4 +++-
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 7 +++++--
>  3 files changed, 13 insertions(+), 5 deletions(-)
> ---
> base-commit: a4cda136f021ad44b8b52286aafd613030a6db5f
> change-id: 20250406-b4-device-wakeup-leak-iio-4457b99b6a91
> 
> Best regards,


