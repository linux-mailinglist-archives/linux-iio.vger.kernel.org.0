Return-Path: <linux-iio+bounces-12000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D2D9C0DF0
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 19:39:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1BC7284546
	for <lists+linux-iio@lfdr.de>; Thu,  7 Nov 2024 18:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3575B217306;
	Thu,  7 Nov 2024 18:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNAG+MJt"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D362101BC;
	Thu,  7 Nov 2024 18:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731004760; cv=none; b=QcSsvb3cre1HbOON5hXEpWYYo6gvzxpke1BCDC/sLibn+/EzSwHtVUHCNwJnhNYBHAP0oIzdVHKCUd0RAFl9zgNgjg1Kxeh76df6/Z582khWX7OPk8PkDg6xbg4y4TjL35UdGFJ3UT9aNy4t7hdYmeITmZ0LGTDIo5qURYmEs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731004760; c=relaxed/simple;
	bh=hCkkdu73hQGPvGzbLfLCeST5jOjzoBQGbV91cnCWD0U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTaRnzFZq5q+3JS1F8vbOXuky00QXVIcPS9f3fcPkE7TzQevX8hrUFQbUK7+pWId8K9slXdFUSU98pEw1OV3UMpA4A5PL3Ybx87/hTgViMgHPY+o4o7mTgRReDFke/zpBhwU2auSmUyO1OMUappwGA0QbdiEN/gzsS9ygQ/TMzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNAG+MJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35012C4CECC;
	Thu,  7 Nov 2024 18:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731004758;
	bh=hCkkdu73hQGPvGzbLfLCeST5jOjzoBQGbV91cnCWD0U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNAG+MJtqHQORwp12W5tqpy9AAV068tUC/40ZMwFjqFKc50LIauzpv1OtqbuA3LQv
	 jWUDMxma1PnUoWCF/mGwLDjr4W8tJqEdnWSaLhjaQbebBOPs7/bakm3BtSrFag/KGz
	 wHr/0wKFTOSQNSU1SfeECNKsQw94TVXcMmR1q/6qpX6kWwd1K1hPsskytoBoaxMUrB
	 WJ8snLcan8XDZOZsv8qeY2A9/CQl253SqDTnvIryx79ceR3wAirhjHfQryPnmkege4
	 xIcOCgY875h/5nyPpAnBQ4+6CBjU+4sUpUPIM6mEZa7SWnTawONAMlak7Lom8rUjki
	 vxF1qhLvwONyQ==
Date: Thu, 7 Nov 2024 18:39:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dominik Karol =?UTF-8?B?UGnEhXRrb3dza2k=?=
 <dominik.karol.piatkowski@protonmail.com>
Cc: lars@metafoo.de, gregkh@linuxfoundation.org,
 parthiban.veerasooran@microchip.com, christian.gromm@microchip.com,
 sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, Michael
 Hennerich <Michael.Hennerich@analog.com>
Subject: Re: [PATCH 1/4] staging: iio: Remove TODO file
Message-ID: <20241107183908.248ed108@jic23-huawei>
In-Reply-To: <20241107172908.95530-2-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
	<20241107172908.95530-2-dominik.karol.piatkowski@protonmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 07 Nov 2024 17:30:51 +0000
Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@protonmail.com> wro=
te:

> Remove TODO file, as it only contains contact information.
>=20
> Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@pr=
otonmail.com>
> ---
>  drivers/staging/iio/TODO | 5 -----
>  1 file changed, 5 deletions(-)
>  delete mode 100644 drivers/staging/iio/TODO
>=20
> diff --git a/drivers/staging/iio/TODO b/drivers/staging/iio/TODO
> deleted file mode 100644
> index 0fa6a5500bdb..000000000000
> --- a/drivers/staging/iio/TODO
> +++ /dev/null
> @@ -1,5 +0,0 @@
> -2020-02-25
> -
> -
> -Contact: Jonathan Cameron <jic23@kernel.org>.
> -Mailing list: linux-iio@vger.kernel.org

kernel.org entries tend not to get stale very quickly.

Indeed redundant.  I'll assume Greg will pick this up if he is
happy with it.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hmm. We should probably write a meaningful todo for the left over
IIO drivers in staging beyond 'fix the driver, mostly ABI issues'
but doing so involves going half the way to actually fixing them.

Every now and then I moot just deleting them all and instead
poke Analog to remind them these exist.

Michael, consider this another poke :)

Jonathan


