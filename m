Return-Path: <linux-iio+bounces-12567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A69D6EF3
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 13:57:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B4C160EE4
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 12:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2211B3927;
	Sun, 24 Nov 2024 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JEez3j6n"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B591B2EEB;
	Sun, 24 Nov 2024 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732452332; cv=none; b=Yg4G/0+qELFH4FMSWm21IEzQKMIGMysl60wr5w+QN0x/6Vh2ZFGFCtz2EKCNiKXesk0zjxMfKliFBb201tlzKAVivic2U9E8V9tK565ZS74iRp8O8dcw6drLyJ/jWa1WVx0JFZ0UxkQUSL5GZcyKgtbbCXhTv9JABXUxoYdhmgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732452332; c=relaxed/simple;
	bh=/ViGX/4oytF2SXmn/VCG/JCUqKVhfDc6T+Z+kJC0y4o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lkV3BIBh1J2yNYxNLlFckIAzP8Muftf9UX6T8YWhzn+8j5e6ppH05djVNLByYhZsAnJIXFALmspxe6FepfXY99TQon/FMznCKbY4PqaZzojoTGGy5veJ169XlYBKFq20n2MKqSKJ7p1ceufXi9jZze/kFUPCOEXRp2LmA70f0og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JEez3j6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 677D9C4CED6;
	Sun, 24 Nov 2024 12:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732452331;
	bh=/ViGX/4oytF2SXmn/VCG/JCUqKVhfDc6T+Z+kJC0y4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JEez3j6njmdaBl0gG9HCt2UseKMzc8HPxV7QN/bMJ+8OGp+FsxHwlp5A0Gvb9d4ls
	 2c8IHgHXZS6TlufKWBJPzuEi67qvuPoOsmQHE8UGyeAPcaWRPUBav2TuKiMbf3Tb4S
	 5X2PLBAdxrJBFF/3OBu4oNE8AUl8W42z8lyloV5caOYypFkMJhw+cUr2zksWzPbgzO
	 cFdbWKRsSgse4l8TDMMZUYrgCDXaTOZx+bqUnwtUPNVTPMjyw0B7kn1fBj32IaDO1P
	 VoL6MaWeK09ZqLJXk2LBHJ6BTjMNRYii+Nne7FLgZZxm7w6A1oj14wdmQvu0WEIdoj
	 AzHMbEIxF6djg==
Date: Sun, 24 Nov 2024 12:45:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Michael Hennerich
 <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Jonathan Corbet <corbet@lwn.net>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 0/2] iio: adc: ad4695: move dt-bindings header
Message-ID: <20241124124522.3c1570e0@jic23-huawei>
In-Reply-To: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
References: <20241113-iio-adc-ad4695-move-dt-bindings-header-v1-0-aba1f0f9b628@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 10:55:18 -0600
David Lechner <dlechner@baylibre.com> wrote:

> During review, no one caught that the dt-bindings header was not in the
> preferred location when the bindings were created. Move the header to
> the correct location.
> 
Applied to the togreg branch of iio.git which will get rebased on rc1
when available .

Thanks,

Jonathan

> ---
> David Lechner (2):
>       iio: adc: ad4695: move dt-bindings header
>       dt-bindings: iio: adc: adi,ad4695: change include path
> 
>  Documentation/devicetree/bindings/iio/adc/adi,ad4695.yaml | 7 ++++---
>  Documentation/iio/ad4695.rst                              | 2 +-
>  MAINTAINERS                                               | 2 +-
>  drivers/iio/adc/ad4695.c                                  | 2 +-
>  include/dt-bindings/iio/{ => adc}/adi,ad4695.h            | 0
>  5 files changed, 7 insertions(+), 6 deletions(-)
> ---
> base-commit: 9dd2270ca0b38ee16094817f4a53e7ba78e31567
> change-id: 20241113-iio-adc-ad4695-move-dt-bindings-header-d6922ef7d134
> 
> Best regards,


