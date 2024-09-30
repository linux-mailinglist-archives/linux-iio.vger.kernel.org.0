Return-Path: <linux-iio+bounces-9919-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F6E989D7F
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 11:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9D51F21FF8
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7ABD170A0C;
	Mon, 30 Sep 2024 09:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h+dEl9Wn"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F08A2FE33;
	Mon, 30 Sep 2024 09:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727686832; cv=none; b=ZEprOTi249JglpynI7bSvXn2+fYoVD4UiX0OQd1tVeXHes2wTVti9234hkX89OFRI2qdOD0dFoFSx5kMIWX02faM1Uu04QmX6F91AfvK0ifoYXRN7btJogCPcrG67sxPCvr0YEZDze+iWp1mMcimZGL605gRsje8wo4SqM42T/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727686832; c=relaxed/simple;
	bh=oquogEt/lJMT938jn9FtjKjoSmX99x/hqCmt2JjytyU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OYtNbd/5YRb6F+3XXjKvzrK05K8rhxKkDtIuM5hhG43qbMEmysux3uY+2xDpj4Pu6bQqrX4ii4Z45LxWbSwulabNdpeMQ55q8XT5hyZbaFNKZkQU1iwGIhx7eE2jeQVKx2dso8OaG3/ts1CTUFWWc5mZFWenRNKRAM0MNwSRMDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h+dEl9Wn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06D8C4CEC7;
	Mon, 30 Sep 2024 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727686831;
	bh=oquogEt/lJMT938jn9FtjKjoSmX99x/hqCmt2JjytyU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=h+dEl9WndJgNcVi7Duxu1pyFQeaThi05Z9X7fKkY3oMQwj+6BflV08E3Bjf656wO2
	 zas7z9WK1Xa3nsF0llQC0jgiPi0pEusVMLKkYKUtgWwJgIuizsJ4u63XuMMbd4+/7u
	 cXnuYE5ciCXUJE7Um8QKl0/JvbpSmLWoeJSAIMK3/+dat5TFL5hUCavNmzJKpwheLn
	 6iM9Eu6mnsm3fmHTNkxlvJZZGUHpL8YXRvH+ALqd8u+umNRmaMyKSvXePSLHBJD3tM
	 aJrmnI93D8k0yDTv/WM8k90lcKHN9tCqH7c2WB606thGMyJsa4T3UzH3QYpO7IH8ry
	 JJQRNvolQdHvA==
Date: Mon, 30 Sep 2024 10:00:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 0/7] iio: light: veml6070: update code to current IIO
 best practices
Message-ID: <20240930100022.1c9bfe2e@jic23-huawei>
In-Reply-To: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
References: <20240929-veml6070-cleanup-v1-0-a9350341a646@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 29 Sep 2024 22:38:45 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> This series updates the driver in preparation to add new features. The
> cleanup consists of:
> 
> 1. Device-managed registering for:
> - iio device
> - action (unregister i2c device)
> - regulator
> 
> 2. Code update to use a guard for the mutex handling and
>    dev_err_probe in the probe function.
> 
> 3. Devicetree support (document the device bindings and register the
> compatible in the driver).
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Nice.  Applied to the togreg branch of iio.git and pushed out as testing.

thanks,

Jonathan

> ---
> Javier Carrasco (7):
>       iio: light: veml6070: add action for i2c_unregister_device
>       iio: light: veml6070: use guard to handle mutex
>       iio: light: veml6070: use device managed iio_device_register
>       iio: light: veml6070: add support for a regulator
>       dt-bindings: iio: light: vishay,veml6075: add vishay,veml6070
>       iio: light: veml6070: add devicetree support
>       iio: light: veml6070: use dev_err_probe in probe function
> 
>  .../bindings/iio/light/vishay,veml6075.yaml        |  3 +-
>  drivers/iio/light/veml6070.c                       | 63 +++++++++++-----------
>  2 files changed, 35 insertions(+), 31 deletions(-)
> ---
> base-commit: 4057951fb272efda718dca665f6607c348d5785b
> change-id: 20240929-veml6070-cleanup-70b609bb1f0f
> 
> Best regards,


