Return-Path: <linux-iio+bounces-5131-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 711288C95FB
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7834B20DD4
	for <lists+linux-iio@lfdr.de>; Sun, 19 May 2024 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E626D1BD;
	Sun, 19 May 2024 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WkDpWN0u"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCC2744A;
	Sun, 19 May 2024 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716145266; cv=none; b=b4Q75WPdTsZRfoYKhVvdcVfEFTQUzBzOYveZ4SO2WEOhDgTzEAtzRd8HOCg0y4z3cjxhtdEdJCHujCu+PGn+vpsLJ1n31jXTENfJwqYAoAOQomeWXhqdw/NI02KY+yncQo4FD+PorbzD8mggv0IBhyh61KvdnfRDn3AcRuAtvGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716145266; c=relaxed/simple;
	bh=+NTM2AFV/JYg98I3O8bGHst8v5arhPNwUTtTa3tWfY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N1zH2OnY0CvzjNu2FLySF1AZrZIwcij95onOu57NZ6h2zwg5iSmIC4LSrGEG8V2PkznS8Xn9CW43jRDYVinDEjn6ogVLa6RTwdehTcMVsYzQeIPLW+0jkkQGSo/2KBdd2IGDwqMhxcQHvj1CYT2kgOt7KTmuqgawDv8V6PdbLJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WkDpWN0u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE31C32782;
	Sun, 19 May 2024 19:01:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716145265;
	bh=+NTM2AFV/JYg98I3O8bGHst8v5arhPNwUTtTa3tWfY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WkDpWN0u2reyaLj3i7CshFz8cj0YJiQy9QsrYy+2Bnpo2+dEgt7MpqqzQP0eTaUkb
	 Mp6owEfPAyudlg7H1ZRkf47updK1krUdqPnCi9az+MQlm91f+lode/OI2uPxPZrsO0
	 DdSIonO+cwtmfePzIp9F+qn2HEH1fIBWJoP+lEJA7nlWd/Ew4h0j2HOqNnOMKEiAHr
	 BmCYjmMuxkiLbVscfhU3X0PD3e1Jj7JTqQqhy5QJ2cBR9+jcts372f8GH04IMgwgKd
	 CdJjxL9pCEyTTcTP1UBJ9NqhYtQ/2ttH4BpfUL3NA+tcoWCaHoIb3/09ZPTzlItnSa
	 LYd0efhomaxfA==
Date: Sun, 19 May 2024 20:00:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Crt Mori <cmo@melexis.com>, Lars-Peter Clausen <lars@metafoo.de>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
 error27@gmail.com
Subject: Re: [PATCH v2] iio: temperature: mlx90635: Fix ERR_PTR dereference
 in mlx90635_probe()
Message-ID: <20240519200053.3ad535ae@jic23-huawei>
In-Reply-To: <b6f1d062-5f09-4d57-aa24-e8515c5cebcf@oracle.com>
References: <20240513203427.3208696-1-harshit.m.mogalapalli@oracle.com>
	<20240519132940.3714e57b@jic23-huawei>
	<b6f1d062-5f09-4d57-aa24-e8515c5cebcf@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 May 2024 19:06:55 +0530
Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:

> Hi Jonathan,
> 
> On 19/05/24 17:59, Jonathan Cameron wrote:
> > On Mon, 13 May 2024 13:34:27 -0700
> > Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com> wrote:
> >   
> >> When devm_regmap_init_i2c() fails, regmap_ee could be error pointer,
> >> instead of checking for IS_ERR(regmap_ee), regmap is checked which looks
> >> like a copy paste error.
> >>
> >> Fixes: a1d1ba5e1c28 ("iio: temperature: mlx90635 MLX90635 IR Temperature sensor")
> >> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>  
> > Please make sure to pick up tags given on earlier versions.  You dropped
> > Crt's Reviewed-by without giving a reasons. I've put it back.
> >   
> 
> Sorry, I thought we should not add tags as v1-->v2: is for addressing 
> the reviewers(Crt's) comments.
> 
> I will keep this in mind.
It's a case of judging if they are likely to mind the changes.
Here Crt had confirmed he was, so easy decision!

If you drop a tag, just say why below the --- in the patch.



> 
> Thanks,
> Harshit
> 
> > Applied to the fixes-togreg branch of iio.git and marked for stable.
> > I'll be rebasing that on rc1 once available. Until then it won't be visible.
> > 
> > Thanks,
> > 
> > Jonathan
> >   
> >> ---
> >> This is found using smatch, only compile tested.
> >> v1->v2: Address Crt's comments.
> >> ---
> >>   drivers/iio/temperature/mlx90635.c | 6 +++---
> >>   1 file changed, 3 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/iio/temperature/mlx90635.c b/drivers/iio/temperature/mlx90635.c
> >> index 1f5c962c1818..f7f88498ba0e 100644
> >> --- a/drivers/iio/temperature/mlx90635.c
> >> +++ b/drivers/iio/temperature/mlx90635.c
> >> @@ -947,9 +947,9 @@ static int mlx90635_probe(struct i2c_client *client)
> >>   				     "failed to allocate regmap\n");
> >>   
> >>   	regmap_ee = devm_regmap_init_i2c(client, &mlx90635_regmap_ee);
> >> -	if (IS_ERR(regmap))
> >> -		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> >> -				     "failed to allocate regmap\n");
> >> +	if (IS_ERR(regmap_ee))
> >> +		return dev_err_probe(&client->dev, PTR_ERR(regmap_ee),
> >> +				     "failed to allocate EEPROM regmap\n");
> >>   
> >>   	mlx90635 = iio_priv(indio_dev);
> >>   	i2c_set_clientdata(client, indio_dev);  
> >   
> 


