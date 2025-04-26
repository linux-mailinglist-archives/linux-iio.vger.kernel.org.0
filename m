Return-Path: <linux-iio+bounces-18694-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FCA9DB74
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 16:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607CC46662E
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 14:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A12231B6CE9;
	Sat, 26 Apr 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtmJUuld"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E09725C6FF;
	Sat, 26 Apr 2025 14:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745677226; cv=none; b=Z1+mNE/23cm53/CKbifM0b5s2CEFVTCR77CV9tPVkT9EF6RFA8g6h56MF7YOSDp/QYkcPleXP9PdrsxVpvluYxbfFM8TNTYgobp/RVDtRNwjWaFl2G0E0/90Q8ECY86DyzueNIg1HcyNJGW4M8U1DJFE2U2sQbrbH/noBtBb4DM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745677226; c=relaxed/simple;
	bh=5Uon2gRZdUaSn4ImWtnBX/kiy8Z4P8jGNyZyrZfRl3k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK8L327V9rf5hgx22xTDhWzzvX1X06EuHs8uPlRbFqEidPbG7w9Mz1g5koYC2Y0cACjg5Vm6lAGuj3s3dYqe/aaN54htiMIKbDVzQWGklIgYh3QnycRJamGLYtqmiUwj+POvigf9IxRpp0CeT+0kh5M7bMzPfkamwew929ZK2qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtmJUuld; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A96C4CEE2;
	Sat, 26 Apr 2025 14:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745677226;
	bh=5Uon2gRZdUaSn4ImWtnBX/kiy8Z4P8jGNyZyrZfRl3k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XtmJUuldqLnv7iQI/6rwNupe9BizkcaJNyBcQi24uA0qXPG1H0ehZBV+/nWXfbGjc
	 dzOX+A+cC1WW5LCPRTfRy+P11Nv7/XJbDB7LPwdQL15W2WauzyszdE3mKMKq6vD/0w
	 65rRZQl1W/EF86hlLDVSPw8SKWYa08b69GnI+zoxrUMOAcgComs96+GYCHGJMVoOTe
	 F4FqLdxd+Ao41EL2n5SSm5A6psOKljKEIPQAz/Q/il3NJc+lp/7qYpuP7h88HcF2Q4
	 2l+KQGtKB/XHVZMLuhDjb5ngpsEyz8NEIKBRQ5bL70cddTpgDKH9v7kXu3LiFpTN5x
	 +UR6/7ILmgklA==
Date: Sat, 26 Apr 2025 15:20:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Marius Cristea <marius.cristea@microchip.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH] iio: adc: PAC1934: fix typo in documentation link
Message-ID: <20250426152020.1b00cdca@jic23-huawei>
In-Reply-To: <3a6d1f46-2f6c-47af-ab6d-10afb22c440e@baylibre.com>
References: <20250424-pac1934-doc_link-v1-1-9832445cb270@microchip.com>
	<3a6d1f46-2f6c-47af-ab6d-10afb22c440e@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Apr 2025 08:43:35 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 4/24/25 3:06 AM, Marius Cristea wrote:
> > Fix a typo,(PAC1934 -> PAC193X), into the link from an application note
> > related to the ACPI device definition.
> > 
> > Fixes: 0fb528c8255b ("iio: adc: adding support for PAC193x")
> > Reported-by: Matteo Martelli <matteomartelli3@gmail.com>
> > Closes: https://patch.msgid.link/172794015844.2520.11909797050797595912@njaxe.localdomain
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---  
> 
> Reviewed-by: David Lechner <dlechner@baylibre.com>
> 

Applied.

Thanks,

