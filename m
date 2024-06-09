Return-Path: <linux-iio+bounces-6109-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2105F9015E1
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 13:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 012051C2017A
	for <lists+linux-iio@lfdr.de>; Sun,  9 Jun 2024 11:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A029D0B;
	Sun,  9 Jun 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvA2gFdv"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD43D556;
	Sun,  9 Jun 2024 11:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717931586; cv=none; b=GzgM4eN/Hvnu2Ow1TwE9mE1lnl+2gB5bGNcBNALLc1GVbc0vCTBRWx1/8rAfS8GEgdaFsV5NV2vIOjzlLQpLe6bzM4iOg8hP+xNyOhLyOj5LYHga6eUShSlilEOmiK22Pha+f+a17eFdMALN9RPKO2+u/M/0eiHXoMB24+942tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717931586; c=relaxed/simple;
	bh=Z3+Awxfxa8KCWGaWER0TC/hsJfL+g2wt5iEYfTrw768=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M3B9oSLFvzlMgbzD7yJ1gis3p3KuZY8NUs6fuoz3/7T5zOm5O5NzId7jKVNrvRSz4jjasta8AMYaGkAt1wr84Cvf3pexMfzEZSzvSmOKKbIZdX1SDjXNGNmmuIEMLFXwPMqZz+5morb9uoTBACuJ+sR7WbxPDtMxv+m6uXXcXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvA2gFdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6281BC2BD10;
	Sun,  9 Jun 2024 11:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717931585;
	bh=Z3+Awxfxa8KCWGaWER0TC/hsJfL+g2wt5iEYfTrw768=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AvA2gFdvuwrl8OXi/9NUypgsEclOqtfUGJA7Dy4tmgkJ3xTGYGF0s3gb0dvH04CNG
	 zoXlbQh9xodYy3fNChTYLkqY7/4Sc63GGEUv3yQkGmDzVd7mnz9jiUar9LL/cyGnIE
	 bSJXdlMArHrlQPfUvFkF3RCNljUPWExmgld3CXweKAr+HUxXKnH+g18L+kjVR/7kuh
	 tZXoLe3ROkGSJ3yyOylnixS/4tZrCnvSUGGk+5kyxcZNV6bC3bo5/CIuOiAZ+T4FNY
	 DXc2+iLrx6OchqaDJnoYCOp9MKyns6PNNFfzsyAgMyu+xOdsTG4DHbkQkST/n+noBC
	 esuwofbsImQaw==
Date: Sun, 9 Jun 2024 12:12:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: dpfrey@gmail.com, himanshujha199640@gmail.com, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 mike.looijmans@topic.nl
Subject: Re: [PATCH v2 19/19] iio: chemical: bme680: Refactorize reading
 functions
Message-ID: <20240609121234.7a458c4a@jic23-huawei>
In-Reply-To: <20240606212313.207550-22-vassilisamir@gmail.com>
References: <20240606212313.207550-1-vassilisamir@gmail.com>
	<20240606212313.207550-22-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 23:23:13 +0200
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> The reading of the pressure and humidity value, requires an update
> of the t_fine variable which happens by reading the temperature
> value.
> 
> So the bme680_read_{press/humid}() functions of the above sensors
> are internally calling the equivalent bme680_read_temp() function
> in order to update the t_fine value. By just looking at the code
> this relation is a bit hidden and is not easy to understand why
> those channels are not independent.
> 
> This commit tries to clear these thing a bit by splitting the
> bme680_{read/compensate}_{temp/press/humid}() to the following:
> 
> i. bme680_read_{temp/press/humid}_adc(): read the raw value from
> the sensor.
> 
> ii. bme680_calc_t_fine(): calculate the t_fine variable.
> 
> iii. bme680_get_t_fine(): get the t_fine variable.
> 
> iv. bme680_compensate_{temp/press/humid}(): compensate the adc
> values and return the calculated value.
> 
> v. bme680_read_{temp/press/humid}(): combine calls of the
> aforementioned functions to return the requested value.
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

LGTM. All the other patches I didn't comment on are fine.
5 can wait for the non fix part of the series as it's just a typo.
7-14 look fine but probably have to wait for 1-4 and (v3 of) 6
to get into the upstream of iio.git.

16,18,19 all look good.

Note given you have two series that are dependent on fixes
I might take v3 of patch 6 then send another fixes pull request
before I rebase the main togreg branch on char-next (once it
has those fixes). 

Getting complicated this cycle as a lot in flight!

Thanks,

Jonathan

