Return-Path: <linux-iio+bounces-7031-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C78791C653
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 21:04:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D651F22D21
	for <lists+linux-iio@lfdr.de>; Fri, 28 Jun 2024 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7E358AD0;
	Fri, 28 Jun 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzZzQTDS"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C874D27E
	for <linux-iio@vger.kernel.org>; Fri, 28 Jun 2024 19:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719601485; cv=none; b=ncqOC3b5sErWp4D90LW7Uq95VW6GRzBeKI10nUXODusxVo15Nl4xx1EDMEfCJ9WqKtUr5PwXusEZpmbzfpoOLmF54fdm3gAFaLhAHknMUvsE9JAIbJ5VtWC77rezhl9hjMsXO2LJAyFdnk1ApVyUImUAYz+fglRMETTRLQNInF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719601485; c=relaxed/simple;
	bh=hbA28QFV+zB+EohAy8hDUT7ICuUU8YJiVc5sZf+Ng8E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sr2QVU1ZZKgdkJ0VxyrIM4pYJmPwW1oqfQEAQn8ctwd2iZCxWNn77UbqFtzHmARyIBHucWTe65YwI6u6g+0zDkfJv+b8gCMd7EnkUvz//AOcYvGBUopRUDJQSKtTBuhRVnUT2lXJ5zch6YhVoaY2S3M5jqyryx46CLqrThTt7nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzZzQTDS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32D36C116B1;
	Fri, 28 Jun 2024 19:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719601484;
	bh=hbA28QFV+zB+EohAy8hDUT7ICuUU8YJiVc5sZf+Ng8E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tzZzQTDSbij0zgnCpUDN0nqdh4bwcoiBEf4PWA6mjIp8AqlPhtuNfILM3FwrX2+0H
	 A1cuqBNh5ZLJ++pNyK60sQWY66r+GuVBrGtKQ11kSZinQ7mcht1M2zTmYSp5U7ISq9
	 EwD4+Ea5Qrhc5V+fiWog6rSUFAeL2pRpdiJXwcvTYRdCZYEx7BBZ5x3o6gB1o5EKUp
	 ZWQvsNVsJDPHrAUB4GXUl+Xt6DOd6BL8x1/8cZIoeppLE4CC4eS+mRVuvCfZQEt1mF
	 8Vw7AuZaPBDa4aRc9TRuAOVxMcR6FCeR9hNxa3Y79OrU730KJVs+4XFi7jVK8CQS4+
	 sXdPFbyhh1Plw==
Date: Fri, 28 Jun 2024 20:04:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Liam Beguin <liambeguin@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] iio: adc: ltc2309: Fix endian type passed to
 be16_to_cpu()
Message-ID: <20240628200438.6c8af4db@jic23-huawei>
In-Reply-To: <20240625152126.GA1271121@shaak>
References: <20240624193210.347434-1-jic23@kernel.org>
	<20240625152126.GA1271121@shaak>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jun 2024 11:21:26 -0400
Liam Beguin <liambeguin@gmail.com> wrote:

> On Mon, Jun 24, 2024 at 08:32:10PM +0100, Jonathan Cameron wrote:
> > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > 
> > Picked up by sparse.
> > 
> > Cc: Liam Beguin <liambeguin@gmail.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> Reviewed-by: Liam Beguin <liambeguin@gmail.com>
Applied
> 
> > ---
> >  drivers/iio/adc/ltc2309.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/adc/ltc2309.c b/drivers/iio/adc/ltc2309.c
> > index 888a71454070..5f0d947d0615 100644
> > --- a/drivers/iio/adc/ltc2309.c
> > +++ b/drivers/iio/adc/ltc2309.c
> > @@ -103,7 +103,7 @@ static int ltc2309_read_raw_channel(struct ltc2309 *ltc2309,
> >  				    unsigned long address, int *val)
> >  {
> >  	int ret;
> > -	u16 buf;
> > +	__be16 buf;
> >  	u8 din;
> >  
> >  	din = FIELD_PREP(LTC2309_DIN_CH_MASK, address & 0x0f) |
> > -- 
> > 2.45.2
> >   


