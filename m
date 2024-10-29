Return-Path: <linux-iio+bounces-11578-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A87FE9B54A8
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 22:03:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5411D1F238F5
	for <lists+linux-iio@lfdr.de>; Tue, 29 Oct 2024 21:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C7D1DE892;
	Tue, 29 Oct 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIpVNrQU"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633A53207;
	Tue, 29 Oct 2024 21:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730235793; cv=none; b=ChcFgFYan26jdMoQOC+ePOk2N+zu6VQT2ccnzt5XdxpYM297uqfT+kLH+LKyL2YJ4DL2s3ICjCoc4BJPMPwC5jaBrrABwh6ITWDEx9m3Ja1umLFTet+yMz1gD1Qg8N/NJTaZwyO2/2J1lUfY+wbHOwMpea2sfw1JefsBX4Dxi4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730235793; c=relaxed/simple;
	bh=3ghwukNeM2q7VMP/oG2hQUj9C73ztVIyaRwJwryvlt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXVhDpLZVffjf5llUUgg6y8Tr7kRLWRbHpjn8bgWyEm+GgZWrjCQU2+KrexqfE9eo7b7fXlGlrsOf+dhR9GQyYOlFip2rn4ngmgpR047JPWLkRi2c62ilhvDJmGUvrUDXjzBulk3uE5zgZ9ws2MICkHafmh158Dz4sfvPDyLW18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIpVNrQU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0510C4CEE4;
	Tue, 29 Oct 2024 21:03:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730235792;
	bh=3ghwukNeM2q7VMP/oG2hQUj9C73ztVIyaRwJwryvlt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bIpVNrQUtI3dNEfntAM19LfnrJmhdx8NN/0jttfsv0ZwVlmZMwlHkpcU2n0hs2L50
	 0BHFx9wVaCkVX+ckYNYXQtZv0DF08C3BACAEofSZ94DvtN7ToG/Kv4d/ZxEBodDT/y
	 AEzy4uR3wyyw+WPpDkQ+xN0yZ/BN1O65O31TZSFjL/UjcIObwJW9ZkHKCpH2jDKMjT
	 KQIfZ2YbbZH01Q7qFr8Y3F2zXX5YHyMptqrD/lOfv7zHfCJVKlXAX1kAFXhBNf2UpF
	 4PNNhmoAuCeC+Ryn1FlR+3bGivtEh2eYwZ4xzWfdCBIhP6AS0z+b+CpqqPOZoDQacX
	 T45Pf35GeTcuA==
Date: Tue, 29 Oct 2024 21:03:06 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matteo Martelli <matteomartelli3@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: core: add docs for read_avail_release_resource
 callback
Message-ID: <20241029210306.53a26274@jic23-huawei>
In-Reply-To: <20241029-iio-read-avail-release-docs-v1-1-36919fbd1869@gmail.com>
References: <20241029-iio-read-avail-release-docs-v1-1-36919fbd1869@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Oct 2024 17:11:54 +0100
Matteo Martelli <matteomartelli3@gmail.com> wrote:

> The read_avail_release_resource function was introduced in
> commit 8a63e3033e72 ("iio: core: add read_avail_release_resource
> callback to fix race") without its description. Add it now.
> 
> Signed-off-by: Matteo Martelli <matteomartelli3@gmail.com>
Excellent thanks.  Squashed into the original commit and fresh tree pushed out.

> ---
> Link: https://lore.kernel.org/lkml/20241029155022.5f777572@canb.auug.org.au/
> ---
>  include/linux/iio/iio.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iio/iio.h b/include/linux/iio/iio.h
> index 747e89975d369f3c76aa49a96a7dc09f185e2557..3e5c1c3d8f7165f3185ae7893d922e42e930853f 100644
> --- a/include/linux/iio/iio.h
> +++ b/include/linux/iio/iio.h
> @@ -434,6 +434,10 @@ struct iio_trigger; /* forward declaration */
>   *			type and the number of vals is returned in length. For
>   *			ranges, there are always three vals returned; min, step
>   *			and max. For lists, all possible values are enumerated.
> + * @read_avail_release_resource: function to release the available values
> + *			potentially allocated during a read_avail() call. Input
> + *			arguments should match those provided in the
> + *			corresponding read_avail() call.
>   * @write_raw:		function to write a value to the device.
>   *			Parameters are the same as for read_raw.
>   * @read_label:		function to request label name for a specified label,
> 
> ---
> base-commit: 9b4071ab8cbe28bd1bc4c533ab944771731fe5f8
> change-id: 20241029-iio-read-avail-release-docs-a2b681e77794
> 
> Best regards,


