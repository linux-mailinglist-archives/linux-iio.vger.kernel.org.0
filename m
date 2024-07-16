Return-Path: <linux-iio+bounces-7646-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C52932FB2
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 20:07:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91076B23280
	for <lists+linux-iio@lfdr.de>; Tue, 16 Jul 2024 18:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4986F1A01A6;
	Tue, 16 Jul 2024 18:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcLmMJh6"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A8D54BD4
	for <linux-iio@vger.kernel.org>; Tue, 16 Jul 2024 18:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721153268; cv=none; b=ACSCxOVpyC1hZwQY7/HtAzxFyh53heldQD0mLVyIil2CtQWrYdTMISfUi/URJwfaMZLIz6MNoe2YIpIxIJ8Tk4GECXjL1mwVIq9VutNPvj2zAxROpQU3mNClZV0PRQgJsq5OOugfOTRJ7WU9Pp3hrdsaRVVYd7d9vEGuj2YKPdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721153268; c=relaxed/simple;
	bh=xmkcIJGEbIVH4F1bNfKoWPJ/fdlyjl6vOBlP9Ft0vCc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd97hgg7bunxMR2fJFKFof7PftoUMf9FWekGSxUjUjoHXRxc1zeTkIamdQVShAlZjCJWSS60e6seHWNNA9awXw0DLlnz2tj6FkYOffweCojm/CrCcfLaRWK+wMbGZNkycBhaOXP90jZsegU4IS/QovvEK3Aj3eSDNWoRUVVOmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZcLmMJh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E159C116B1;
	Tue, 16 Jul 2024 18:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721153267;
	bh=xmkcIJGEbIVH4F1bNfKoWPJ/fdlyjl6vOBlP9Ft0vCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZcLmMJh66AeAdPU9f/KW+GAW7elaq7R6lRmUqpz1j9vNlRbD3qNdasJgpaNykS8/y
	 j8Feps/iNYCCKaWQg6Vztpwd2C/nGY2TyW0kOG1Dbl3W3e0ZC7VD97xH3KMmP/kx5n
	 LzoIWzEvriSXo+RaArdFyENucS6lJav9lD1zL/Rrhsbsb0vj6gqUlYKM9wHvDyvwUu
	 wlpPVO5fHNhwrg+c/k7bVYtLLtyUcVpTz6aunfqYlXMHgVYkSTFIFM4Won/scG50MA
	 NDzef/1KaMAEqyLlplPV2Q9fecfLc59+eWf7MKH/C9nPC9sZZ/cCa4SvyPQXnSFSf7
	 5rp7OjwSDG0sw==
Date: Tue, 16 Jul 2024 19:07:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno Sa <nuno.sa@analog.com>
Cc: <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>, Olivier Moysan
 <olivier.moysan@foss.st.com>
Subject: Re: [PATCH 2/9] iio: backend: print message in case op is not
 implemented
Message-ID: <20240716190743.551a0769@jic23-huawei>
In-Reply-To: <20240709-dev-iio-backend-add-debugfs-v1-2-fb4b8f2373c7@analog.com>
References: <20240709-dev-iio-backend-add-debugfs-v1-0-fb4b8f2373c7@analog.com>
	<20240709-dev-iio-backend-add-debugfs-v1-2-fb4b8f2373c7@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Jul 2024 13:14:29 +0200
Nuno Sa <nuno.sa@analog.com> wrote:

> For APIs that have a return value, -EOPNOTSUPP is returned in case the
> backend does not support the functionality. However, for APIs that do
> not have a return value we are left in silence. Hence, at least print a
> debug message in case the callback is not implemented by the backend.
> 
> Signed-off-by: Nuno Sa <nuno.sa@analog.com>
Applied.

