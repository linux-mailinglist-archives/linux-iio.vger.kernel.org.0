Return-Path: <linux-iio+bounces-4411-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C1A8AC046
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 19:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E2F2816BC
	for <lists+linux-iio@lfdr.de>; Sun, 21 Apr 2024 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B292942D;
	Sun, 21 Apr 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iws7QWWk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78F71BC4B
	for <linux-iio@vger.kernel.org>; Sun, 21 Apr 2024 17:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713720458; cv=none; b=Ur/5WYasJeCfPwAGRhcyqsLtRDQJXYHQEDqK+ukMWqF6lgPhDkg5nMzET0B25Qw2g4S11fh+FQssuCjZh/RzYDWAUabf7qpn/md2T6OGu9q+GlynJ16O6cwATqUWQnFtomU1SzojKc84sAUce0T9zFQSt79aboh3kjN/vgOz5JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713720458; c=relaxed/simple;
	bh=pb3wQyc0TTJ9vvFtTjLx22bGhrOlZq2ApuLoImfLYYg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kT6U5vOxkHGtRVNkUYvFmeaS3XMLxgJrpejHcq2TeShCXhnIQuHUQ9R4RfmBGe+Jp/Z5pZmspS/0ll/PCh668N1AJ9BFiLtXW1T1kRI2hmXY0gpgQuadx6HJU/PkrMCpK3GRBbU6Ddfn4+DLIUtAb985QNH47lMbdoBRgscf/HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iws7QWWk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F72EC113CE;
	Sun, 21 Apr 2024 17:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713720458;
	bh=pb3wQyc0TTJ9vvFtTjLx22bGhrOlZq2ApuLoImfLYYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Iws7QWWkNRJzepmXnnR6zEcsxhT5Q34VTd1ptPvVDQ4tp9Tciwbt9SxkpJ+PzsDcR
	 6X2PkGiVCm29D4jq+3oAwBrOtecKDtAuDM/DjHtdNfjOFl7X3QUdH/0WuAHw5UR/Fl
	 Xo8zqApd2B0sd0jIkikPNTo6UgFkDVCgbpg5BZBslaPLMa3UNbjAW5i73kDDr6tqc1
	 W7ZeeborUuF5TJ4GTuZW5aj4yUGY7sPuC6yRwl2TkyCoFpSoOXe+TFhJ+Cj5wCzqsJ
	 gDBdNkOv1PY30idCdk/rYdpV6pKCjORJH4IsfmbKPjAK8TxfP4wzBcj4YJYTmgBQiJ
	 AEfVuKFussQaw==
Date: Sun, 21 Apr 2024 18:27:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bertin Salvador <lorenzobs@usp.br>
Cc: Briza Mel Dias de Sousa <brizamel.dias@usp.br>,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ti-ads131e08: Fix a style problem in
 struct declaration.
Message-ID: <20240421182726.6ec2af1f@jic23-huawei>
In-Reply-To: <20240420182744.153184-3-lorenzobs@usp.br>
References: <20240420182744.153184-1-lorenzobs@usp.br>
	<20240420182744.153184-3-lorenzobs@usp.br>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 20 Apr 2024 15:27:44 -0300
Lorenzo Bertin Salvador <lorenzobs@usp.br> wrote:

> There was a blank line missing after declarations in struct tmp_buf.
> 
> Co-developed-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
> Signed-off-by: Briza Mel Dias de Sousa <brizamel.dias@usp.br>
> Signed-off-by: Lorenzo Bertin Salvador <lorenzobs@usp.br>
That's a checkpatch.pl (I assume) bug.
These are both declarations, just the second one is more complex than most :)

Feel free to try and fix check patch but this isn't something we are going
to 'fix' in code.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ti-ads131e08.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ti-ads131e08.c b/drivers/iio/adc/ti-ads131e08.c
> index cb04a29b3..fcc0276bf 100644
> --- a/drivers/iio/adc/ti-ads131e08.c
> +++ b/drivers/iio/adc/ti-ads131e08.c
> @@ -102,6 +102,7 @@ struct ads131e08_state {
>  	struct completion completion;
>  	struct {
>  		u8 data[ADS131E08_NUM_DATA_BYTES_MAX];
> +
>  		s64 ts __aligned(8);
>  	} tmp_buf;
>  


