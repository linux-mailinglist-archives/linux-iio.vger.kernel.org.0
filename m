Return-Path: <linux-iio+bounces-10242-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E39F991E93
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 15:37:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DB091C20D06
	for <lists+linux-iio@lfdr.de>; Sun,  6 Oct 2024 13:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8382A176AA0;
	Sun,  6 Oct 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSU5DShf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E27EC5;
	Sun,  6 Oct 2024 13:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728221827; cv=none; b=Ve2y2Szl9Tb/e3D1hOc5DIqGr0zExhexOnJe1rzkBIcfPThTsedIKqJEaB1F2JfsSxzoN8G+GcxnLd53/P4zIMB9CeyxaupMfwFKEYX1y1sDducMhZSKdIpRH1YOAu3/pAOhs6gFy0yoc06InxndrJst5JrHbeART9YzPkwINxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728221827; c=relaxed/simple;
	bh=Nx+i9/q3KA5QkLQt6ZzaBs2eIOoDJ/mDZdZr5vTKTQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iEX7HHtkrAxyZoARIC8KbKgny9VW45IdnDgrdN5vImxCDbwbzO+VwBElfK8Kp/ag9gRWO8ZwDHBZiE5CiTAH6SQ6BsUVF/BMo/iiahD/e/RQfhMkRXlGHLLTCTO0q8gT93+sPNGcNJmo8W/5h677Z27zXKxPbC1LvReFE/3rIW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSU5DShf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 792C4C4CEC5;
	Sun,  6 Oct 2024 13:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728221827;
	bh=Nx+i9/q3KA5QkLQt6ZzaBs2eIOoDJ/mDZdZr5vTKTQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iSU5DShfxeIwxDj/VtX5r6XCrd23B9VsZbkxuq4pcQBLF8nS2e554jv6D/mZhHlGF
	 ZJwua53g3W7CEQ1r2fRL9lQ/QEPXgktgAKC60X7mEyZQ4LNqXipRbYsvviunkWH8fW
	 ipLDl9UJbfdurjc0ae5nJP2djk4jaAhYZXsLJ1j6CyYrnaRtt+5KuwpH+MHevcKI3n
	 eh6QANuzNpDB47DZk9bH4d4Q9/rSW32sjJ1l4IiqoYhW8C1+cwplCTFYsTQ6ZNTvK7
	 0m80xh8u70j9YMTIfZeywG03SI2BThbOJ0yevbGSI6U4bFbqPAyS3axkhH89qGeeAS
	 juP42T/3T6l/g==
Date: Sun, 6 Oct 2024 14:36:57 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol via B4 Relay
 <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Cc: jean-baptiste.maneyrol@tdk.com, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Update email addresses and add missing
 MAINTAINERS entry
Message-ID: <20241006143657.1d9f0e11@jic23-huawei>
In-Reply-To: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
References: <20241003-invn-maintainers-email-update-v2-0-ca5a4928eb22@tdk.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 03 Oct 2024 15:38:21 +0200
Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org> wrote:

> Migrate invensense email addresses to TDK domain. Add missing entry
> for iio inv_mpu6050 driver.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Applied.
> ---
> Changes in v2:
> - Fix missing signed-off
> - Link to v1: https://lore.kernel.org/r/20241003-invn-maintainers-email-update-v1-0-7e4062ad68cf@tdk.com
> 
> ---
> Jean-Baptiste Maneyrol (3):
>       MAINTAINERS: iio: migrate invensense email address to tdk domain
>       dt-bindings: iio: imu: migrate InvenSense email to TDK group domain
>       MAINTAINERS: iio: imu: add entry for InvenSense MPU-6050 driver
> 
>  .../devicetree/bindings/iio/imu/invensense,icm42600.yaml       |  2 +-
>  .../devicetree/bindings/iio/imu/invensense,mpu6050.yaml        |  2 +-
>  MAINTAINERS                                                    | 10 +++++++++-
>  3 files changed, 11 insertions(+), 3 deletions(-)
> ---
> base-commit: 550aaa170cd9176655382364308d2ff54623b30b
> change-id: 20240923-invn-maintainers-email-update-ac2b3c74e4f1
> 
> Best regards,


