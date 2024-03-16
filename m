Return-Path: <linux-iio+bounces-3558-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41CE087DA4F
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 14:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E042F281F49
	for <lists+linux-iio@lfdr.de>; Sat, 16 Mar 2024 13:40:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF0E18AF8;
	Sat, 16 Mar 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvqkylY1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C3D28EA
	for <linux-iio@vger.kernel.org>; Sat, 16 Mar 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710596450; cv=none; b=rKcBXxPGwPzM7z3/pdrltRVgxv3Jle61eebMCAuiZ1xOgWDNx0PS/1bXQ0UvFQxJlrViO5vowf7+31Q4ZDq7mzunJLfZ2TOBglGo55veyp3pqms4s079FooBBg15gsnSqrz+9lFiEsuxJQEf7suxy8KDFZ9yiW6QzBbJGIfyaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710596450; c=relaxed/simple;
	bh=TgQHFHhVvNGjdsUWUtPcY+I34esPdZ7jW1t5eZzCESU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BmgckPvPa49dsAHQw9+m6G2/RZKodEtJtQRTopbvVjC1V2KG9kFDXHqbI15QMOus3EIEfbyNadtL9Ykj2Q11PiJiQMuS1zV5dQHe6xOL93TOVgWkI5hC98XJa3aiHUmcAo0uLIZJ+t9ZeCKpTwLoFhnINXb4At899T+w0KaUj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MvqkylY1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DAEC433C7;
	Sat, 16 Mar 2024 13:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710596449;
	bh=TgQHFHhVvNGjdsUWUtPcY+I34esPdZ7jW1t5eZzCESU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MvqkylY1SSqobERh8w9ytAxfIXEAQetr6YQVWheQTqzaGHnWWKAG7kGhFpUNhPKZs
	 Nt7xMB+u+eg2qAWkVp2kD4awy0Cs4WbAj0M2qOUgnADNAsJGXWIUVCiO6H4j+rfelC
	 JzAH5/M/1mQoeTO73CN12L9OhMzw7tM/MZGSs/BG7cF/EooimjSM71XnpsBoxgH5qM
	 +wRqIv2Jg2tM4oSbjybMLBnIbr1uQO9vE+dDxxAF4RDEK5Bw5LDYKNVAwPwF1Vswjh
	 DUw34fAas8q/VZWOYepcskjtjHMN2cojWkxTxnr5ogWcgC8zyPdsm02sT+F4IyQGum
	 rLv0pwZ3LeVag==
Date: Sat, 16 Mar 2024 13:40:35 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: Fix the sorting functionality in
 iio_gts_build_avail_time_table
Message-ID: <20240316134035.5eb47a69@jic23-huawei>
In-Reply-To: <ZfS0Rhk5WTJbwXU/@cy-server>
References: <ZfHM73ZqgnCp6CZv@cy-server>
	<a59061f8-5caa-43d4-bd4f-5ac4c39515ba@gmail.com>
	<ZfS0Rhk5WTJbwXU/@cy-server>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 15 Mar 2024 15:49:10 -0500
Chenyuan Yang <chenyuan0y@gmail.com> wrote:

> Hi Matti,
> 
> Thanks for your reply!
> 
> > I think the suggested-by tag is a bit of an overkill :) I don't feel
> > like taking the credit - you spotted the problem and fixed it!  
> 
> You did help me figure out the real issue here and how to fix it :)
> 
> > Do you think you could fix the removal of the duplicates too?  
> 
> Sure, I can help to implement the deduplication logic.
> Here is a potential patch for it based on your help.
> Besides, I changed the stop condition in the inner loop to `j < idx`
> since the current last index should be `idx - 1`.

Matti, I didn't follow why duplicates are a problem?

Sure the code is less efficient, but do we end up with a wrong
answer as a result (I've not checked logic, but I'd expect either
first or last of repeating values to be used depending on the alg).

I'm not convinced adding to complexity of the code is worthwhile if
its not a functional problem.  I would expect a unit test to verify
that duplicates aren't a problem though (given you have unit tests!)

Jonathan

> ---
> diff --git a/drivers/iio/industrialio-gts-helper.c b/drivers/iio/industrialio-gts-helper.c
> index 7653261d2dc2..32f0635ffc18 100644
> --- a/drivers/iio/industrialio-gts-helper.c
> +++ b/drivers/iio/industrialio-gts-helper.c
> @@ -375,17 +375,20 @@ static int iio_gts_build_avail_time_table(struct iio_gts *gts)
>  	for (i = gts->num_itime - 1; i >= 0; i--) {
>  		int new = gts->itime_table[i].time_us;
>  
> -		if (times[idx] < new) {
> +		if (idx == 0 || times[idx - 1] < new) {
>  			times[idx++] = new;
>  			continue;
>  		}
>  
> -		for (j = 0; j <= idx; j++) {
> +		for (j = 0; j < idx; j++) {
> +			if (times[j] == new)
> +				break;
>  			if (times[j] > new) {
>  				memmove(&times[j + 1], &times[j],
>  					(idx - j) * sizeof(int));
>  				times[j] = new;
>  				idx++;
> +				break;
>  			}
>  		}
>  	}
> 


