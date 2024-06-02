Return-Path: <linux-iio+bounces-5604-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 389AF8D74DD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA99B1F2149F
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5393E381C6;
	Sun,  2 Jun 2024 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zyn0ne7O"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0216F2628D;
	Sun,  2 Jun 2024 11:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717326593; cv=none; b=ABLtshAZtq/AopqyYc9PD+MaOjLD0iIFVdu7Ojn7L9W1Y+QM61WqClWl1S5SJ3bCSrOHc0rhVHQv73FXtB2JwYXFWTDZikm5xgbagEnXbXM+qqk+wjfxyQtpPFXIzGOYgxvQPVEvn9zwI7IqoE0H3zzbbRS/tIqgu+rE/niL8xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717326593; c=relaxed/simple;
	bh=cfbf03OulDYQmcs0w0xse2RMWbAz+WYhvFWB8CikIzU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kjFZSzckN99Eb+sG3wYA4iats5PS5ec9y2WFgEUDIckA1MqaC6CyShD32YdXgXAWqzJwGtbWY09V3hBqLdzYdRXlwBCNdbI7tOgVg4MMbiyqslk9VtXnECi9JZD5pRXv7PxhrT83hzPEcYvqfuo19KGv/uBlnHi3COJSgoyT6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zyn0ne7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5CDC2BBFC;
	Sun,  2 Jun 2024 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717326592;
	bh=cfbf03OulDYQmcs0w0xse2RMWbAz+WYhvFWB8CikIzU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Zyn0ne7Ok4mffR0SzG9cnem9XATyQk8yTpJswfEBVFA7idGvtD4mfrpeTjBaS5kCv
	 S45bQ8BHwOfqmLlFCXwJLZtDc9teZSrsOCsiltyqVBfWkXEKoye4TyPLm6Gw6Kx9uj
	 b1jdZOmGnXzumanueB11Hguo7YCO691kleR4NjKpkW0LBmOxww2mwLfm+w3SL1WHnI
	 5CP99CvZdms0KOQsMIE7tpUPHjqSzOHSqNCRxOGBX7LvfZBRwwnx4+wws6ok0EDoYa
	 aspxv1fiscwPJczuR+Do7dVgikz7mtjaAC4GziPffSs0BI4luRLGvd7CXOQEpz2Gxw
	 z7UD7qvJj5MzQ==
Date: Sun, 2 Jun 2024 12:09:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, robh@kernel.org, nuno.sa@analog.com
Subject: Re: [PATCH v5 0/9] adis16501 and adis1657x support
Message-ID: <20240602120941.34bb294d@jic23-huawei>
In-Reply-To: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
References: <20240527142618.275897-1-ramona.bolboaca13@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 17:26:09 +0300
Ramona Gradinariu <ramona.bolboaca13@gmail.com> wrote:

> Add adis16501 and adis1657x support in adis16475.
> 
> Ramona Gradinariu (9):
>   dt-bindings: iio: imu: Add ADIS16501 compatibles
>   drivers: iio: imu: Add support for ADIS16501
>   iio: imu: adis_buffer: Add buffer setup API with buffer attributes
>   iio: imu: adis16475: Create push single sample API
>   drivers: iio: imu: adis16475: generic computation for sample rate
>   iio: imu: adis_trigger: Allow level interrupts for FIFO readings
>   iio: imu: adis16475: Re-define ADIS16475_DATA
>   dt-bindings: iio: imu: Add ADIS1657X family devices compatibles
>   drivers: iio: imu: Add support for adis1657x family
> 
>  .../bindings/iio/imu/adi,adis16475.yaml       |  31 +
>  drivers/iio/imu/Kconfig                       |   4 +-
>  drivers/iio/imu/adis16475.c                   | 807 +++++++++++++++---
>  drivers/iio/imu/adis_buffer.c                 |  32 +-
>  drivers/iio/imu/adis_trigger.c                |  37 +-
>  include/linux/iio/imu/adis.h                  |  21 +-
>  6 files changed, 792 insertions(+), 140 deletions(-)
This seems to be based on a tree that is missing your sync mode fix from
last cycle.  I've applied and fixed it up but please check the result.

I also fixed up Dan's report.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look at it.

Thanks,

Jonathan

> 
> --
> 2.34.1
> 


