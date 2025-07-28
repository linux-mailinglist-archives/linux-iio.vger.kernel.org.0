Return-Path: <linux-iio+bounces-22113-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5D50B141BA
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 20:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29ED74E16F7
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 18:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE98D21D3D6;
	Mon, 28 Jul 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKTMAQD/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 680191C1F0C;
	Mon, 28 Jul 2025 18:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753726091; cv=none; b=GfzWbXfkaCar0O0e6j/jBqyHfAXd14nFluqQ6hXDUbAzLRgCf16n54GcmZLiYbkufQoAif5yOUOKvo3t6zC4cIoEvud4V5bPqxFEDHl8PM4p36PrQ3Gnb+7ynzGkS72prMDba/Oup+/BjWyg7raeIwep5liamDEYfMV6Z/Usb5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753726091; c=relaxed/simple;
	bh=Nn+8+5TIqCxhjEjHZjg5gKvzDxk8MRLFME//QnuZ6rA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qnb4ebh/+dd0026rSCHBUmorMSQPTzCgcdm31svRhzd/s2m8VZd1WGGy4idIEENHZw9xlF7GLV0+snvnZcRLxQdCxOcO/MDZ2rjhhBRzUFZ4IPY4gNDE639fe8qEkzKO5CKg7HNAD9mKRQI23MxlFxtFrSGO4R+1PEmuzgPf1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKTMAQD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5EE2C4CEE7;
	Mon, 28 Jul 2025 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753726090;
	bh=Nn+8+5TIqCxhjEjHZjg5gKvzDxk8MRLFME//QnuZ6rA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XKTMAQD/gSUGDHxsmWWXJlSTMXUXMSiPUcjm6QCRa/kZQIPMHH8GFa3WyJxmzRhiK
	 O9LqGlnO0cx8AzPAor0uTp0gB8JQmfpXuGMsGoULCs2W38JFda4L7IFCHsJZi2vgK0
	 6/aaTxeD6Hbyf/GMgTTCsW7rHlcAqD93q7C9o50gNDF+lKhCJE/bbhVjMgg6SP+2PS
	 CyuHu3Iwz1sFMug9k/UxvMWSMaFeeKkzI3brI/O7GrQnRfRsw8Brp+BTfOSpEpc25c
	 wr0NfkXiX93LntiBPKo/T8HDQ6z996VPwbQPN/iTeKLW/+Yq/xrV7/IUQJyrGPn1N7
	 6ozRjhKDNu+Ng==
Date: Mon, 28 Jul 2025 19:08:03 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: anshulusr@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] iio: light: ltr390: Add debugfs register access
 support
Message-ID: <20250728190803.583181f3@jic23-huawei>
In-Reply-To: <20250728161445.13261-1-akshayaj.lkd@gmail.com>
References: <20250728161445.13261-1-akshayaj.lkd@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 28 Jul 2025 21:44:41 +0530
Akshay Jindal <akshayaj.lkd@gmail.com> wrote:

> Add support for debugfs_reg_access through the driver's iio_info structure
> to enable low-level register read/write access for debugging.
> 
> Signed-off-by: Akshay Jindal <akshayaj.lkd@gmail.com>
Applied to the testing branch of iio.git.

I'll rebase that on rc1 once available and then push out as togreg
(which is what ends up in linux-next)

Thanks,

Jonathan

