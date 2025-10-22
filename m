Return-Path: <linux-iio+bounces-25360-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B5BFDC13
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 20:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F71D3A8120
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 18:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0284135B131;
	Wed, 22 Oct 2025 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kRSQfzQb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5CF2C15A3;
	Wed, 22 Oct 2025 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761156166; cv=none; b=CqVXU8zK7Jqstc0XcTvLLT7Wz4FY5YTw8JGmRi3WnWwc56/25uYlTf8ZbjKVOjpKi2U27LiCN6e+YN2t2HJSQgyHYRpBTvjKUwtvcE/nj1zZ9yJ41jqlWlJyx+CEj1JKesdGcYI5s027IoBn0+xlQenbkU4Q0lOZ/dOj9ZRp6DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761156166; c=relaxed/simple;
	bh=t6re2ND5xvyQd8HtMTpq3kkOWyOG9TYuAIaDpEvjOQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jv7c0aWb2I1ZVkRd5UIXfdC/tJLKDmMlcRedXsH+kC0CA8Wz5au+37UWB1PEDHzvOmRWzdvPKZzfN8x5AEQ3b2q5h++8OT4dAn317EzsYWqBXqdTAgkDgvnbV3nqnV5IjOVknepFovvxUO8Xul5x2A/fVtxb136gCQMKw/NzE3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kRSQfzQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD82FC4CEF7;
	Wed, 22 Oct 2025 18:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761156166;
	bh=t6re2ND5xvyQd8HtMTpq3kkOWyOG9TYuAIaDpEvjOQg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kRSQfzQbRzHGOr8/Ez2kbRgscly43BftApw4dJ0BsLb/ejI+ra7B+xvXDMQd9ooBQ
	 mgBsOUDV0WE2xW3CaUxonL67Jx6apEW6UoGmo3JRnQ5ZVZJ3sRmyoKJ7MEkMxjNOXB
	 6Uc3YJlCVF6BsqEDJjG8W6kLcvbJh/kTOni6dejWT/xUSCjfvT5Y6l9YfeP0q3XKt9
	 xSMfJ2af8HZ+Xj8h5fwCfnOdVmVemPNUyGZI9OADlRQcc3KO33F/VArTf6wQ4ylIB7
	 JhCW/pSQGesJabSaDj5R3tPikBonHjcC8dMcd/x8mGPpp38AA5uKdr6RQLvUgvCoot
	 lLpth379YZ2HQ==
Date: Wed, 22 Oct 2025 19:02:42 +0100
From: Conor Dooley <conor@kernel.org>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: jic23@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ad4080: add support for AD4083, AD4086,
 and AD4087
Message-ID: <20251022-humility-deplored-6b57f6a003de@spud>
References: <20251021105349.21145-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ycL1A/d2LH3RopiF"
Content-Disposition: inline
In-Reply-To: <20251021105349.21145-1-antoniu.miclaus@analog.com>


--ycL1A/d2LH3RopiF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 21, 2025 at 10:53:42AM +0000, Antoniu Miclaus wrote:

>   dt-bindings: iio: adc: adi,ad4080: add support for AD4083
>   dt-bindings: iio: adc: adi,ad4080: add support for AD4086
>   dt-bindings: iio: adc: adi,ad4080: add support for AD4087

Acked-by: Conor Dooley <conor.dooley@microchip.com>


--ycL1A/d2LH3RopiF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaPkcQgAKCRB4tDGHoIJi
0koeAQCoXdpuPKX9OLkK1soR9DBnPA6rXtb4J6ikRHT+2EpyCwEA9sRs2WP+Bl08
wzvW9xfY1cYsnP3naSW+Wvco9RH+KwY=
=0fYs
-----END PGP SIGNATURE-----

--ycL1A/d2LH3RopiF--

