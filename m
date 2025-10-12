Return-Path: <linux-iio+bounces-24954-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E2188BD0370
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 16:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AE9004E8029
	for <lists+linux-iio@lfdr.de>; Sun, 12 Oct 2025 14:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E99A28505C;
	Sun, 12 Oct 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J/Dx+WOF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5D28469A;
	Sun, 12 Oct 2025 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760278933; cv=none; b=iwaBRagkcMFj5XqQTkogrFCY73xX+quKAFPWzZj9jXZO9KczkjnVc1ZgTE8Oy8T1pwC0SxsMSh5oHhQGUG9fRvrz7bV0Jj8/+SCSBYRyc8/Mde73ZlsbBbSrN6or0hVFs6Q7T5OIuCR35guhXyzx7OO2DGNWC3XWsVolnq5U8o4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760278933; c=relaxed/simple;
	bh=P9GPkAGwQpqroO8w0rXgiEyyDDU97Dt+fSA9fOo0iio=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uGfhbVfKoRpYxOFDezgK5nSqnTh6VlSk5+Yt+bk1/iQ4MXJf/Xh4srzKeqqqjkorHOl3riuQAvD3tVKP2IMTjEk2QE6WiZEYfWLBeV9aCPSJnKv7mf3fJY6s/qEfm0ayj8TwaR5h5sdvxtrn3b+aq8DMlgwjJnmVpz6WhuRojmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J/Dx+WOF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93541C19421;
	Sun, 12 Oct 2025 14:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760278933;
	bh=P9GPkAGwQpqroO8w0rXgiEyyDDU97Dt+fSA9fOo0iio=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J/Dx+WOFQRAnfp3KzRVnuGs2xoq1KHBBVLaNg3rbAUG2Pl065mdQ+vce22Urpksa3
	 hTgZdiJ+LdTEIoYKDNykER293pWSRTznSMjCiOls+RtrirmgDYwOwFheXup2eumarl
	 DUaorp1HQMV/LdwKI4CScCuUUZ8R4CAmhJRF9ViD2ep8viJ2ux1j255UjieKP5N1ZV
	 rPizObVw+EC2O3iqQu1Jm1rpmBLQWRW4MMUuIM/Dc4thVOPaRfOQwx+/WJeqa/qwPE
	 bp4xANHOj+RUv1yhHSJ3h5LTJmSYqmPPGy3zgkjYTNGgzh3/zp9B3w+j1JXcz6zLbi
	 mbc+YfD+eYsqw==
Date: Sun, 12 Oct 2025 15:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/19] iio: accel: bma220: relax constraints during
 probe()
Message-ID: <20251012152205.5cf855c9@jic23-huawei>
In-Reply-To: <20251005-b4-bma220_improvements-v4-2-0f449ba31585@subdimension.ro>
References: <20251005-b4-bma220_improvements-v4-0-0f449ba31585@subdimension.ro>
	<20251005-b4-bma220_improvements-v4-2-0f449ba31585@subdimension.ro>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 05 Oct 2025 16:12:11 +0300
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Do not return error if the chip id being read is not the expected one.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>
Applied.

