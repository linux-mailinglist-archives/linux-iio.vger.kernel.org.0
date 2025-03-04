Return-Path: <linux-iio+bounces-16345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E6A4E074
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 15:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C610176541
	for <lists+linux-iio@lfdr.de>; Tue,  4 Mar 2025 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74730204F84;
	Tue,  4 Mar 2025 14:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="utvGqb8X"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE8C2045B2;
	Tue,  4 Mar 2025 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741097732; cv=none; b=MPQCNErifoIy/1e38whNL2rSZgIJLcc0CBA+ef7Ww0N3CFf0y8JcNY9ypNtiKXOgwei79LbC77y8Y6BQCdp7f+fhe50v4lbgrkA7ffpLxspeCJlw3rv+n/DnbPJ+oQoULZpG8LTB06ISGTQTUVXNnoXDuRH5vEesMzZ/FbK77Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741097732; c=relaxed/simple;
	bh=0nlyLAhLFDgXGjNZzNtBxtJ/fyjkwxl1E+9NxtdXPB4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJOrHzVh8a6LEYcO1jBczZDLOQp6C8jLXBwD0xpnO4xLqNWI63ChtgQNOT/UPp6Qygk2J6sxPLqYLGyUj2uJzGtwvXUTL0bRxbgeN0/PTX8qp5zGQucFk7hoRycCM1QJMuqLkWy2/L/SGzs/snOZR1y70eKszVzTsK3EaIY7JDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=utvGqb8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A7C4CEE5;
	Tue,  4 Mar 2025 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741097731;
	bh=0nlyLAhLFDgXGjNZzNtBxtJ/fyjkwxl1E+9NxtdXPB4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=utvGqb8XtBmeGnWeLTLQ6sw1qza+LwPM+B0U1hWSazYb1Dgj6sOmFR09ZC24mrILW
	 F/e11WitfBnssypca9eqo1L43hPkudj3J9RhOCLOQBBtp3UWBEzMpmxrycgERxdfWT
	 nsftRiYQPYkWPrQai2xI2KjEDX+yVFVO+vEQA03RUadpHCv8nMFktTgGu5NmW2WARi
	 20SWxGFRwSAQscwp5UW5E79Azm+/l4cewm6o/Wz27WgzSOLby3MGZPBh+sAIwaaNGb
	 gBc+YYOmR6iE7awjdlpIYelOC/q0vRosCe4DUumO5x4HWEbXF8kK2MHvp6b2OwD5d4
	 LbP1gc7s8AJXw==
Date: Tue, 4 Mar 2025 14:15:18 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sunliming@linux.dev, lars@metafoo.de, Michael.Hennerich@analog.com,
 nuno.sa@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, sunliming@kylinos.cn, kernel test robot
 <lkp@intel.com>, Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] iio: imu: adis: fix uninitialized symbol warning
Message-ID: <20250304141518.7389ef88@jic23-huawei>
In-Reply-To: <c5b70fd8-2d03-4179-a8b8-5ee827fff978@stanley.mountain>
References: <20250304060518.1834910-1-sunliming@linux.dev>
	<c5b70fd8-2d03-4179-a8b8-5ee827fff978@stanley.mountain>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Mar 2025 09:36:56 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

> On Tue, Mar 04, 2025 at 02:05:18PM +0800, sunliming@linux.dev wrote:
> > From: sunliming <sunliming@kylinos.cn>
> > 
> > Fix below kernel warning:
> > smatch warnings:
> > drivers/iio/imu/adis.c:319 __adis_check_status() error: uninitialized symbol 'status_16'.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <error27@gmail.com>
> > Signed-off-by: sunliming <sunliming@kylinos.cn>  
> 
> Huh...  Someone is using lei to get their email.  This patch is fine and
> it's theoretically the correct thing to do.
> 
> How the zero-day bot warnings work is the they are first sent to my gmail
> account and I look them over and either forward them or ignore them.  Here
> is the code:
> 
> drivers/iio/imu/adis.c
>    305  int __adis_check_status(struct adis *adis)
>    306  {
>    307          unsigned int status;
>    308          int diag_stat_bits;
>    309          u16 status_16;
>    310          int ret;
>    311          int i;
>    312  
>    313          if (adis->data->diag_stat_size) {
>    314                  ret = adis->ops->read(adis, adis->data->diag_stat_reg, &status,
>    315                                        adis->data->diag_stat_size);
>    316          } else {
>    317                  ret = __adis_read_reg_16(adis, adis->data->diag_stat_reg,
>    318                                           &status_16);
>    319                  status = status_16;
>    320          }
>    321          if (ret)
>    322                  return ret;
>    323  
> 
> So if __adis_read_reg_16() fails, then the next line is an uninitialized
> read.  But then the if (ret) check means that it's fine at run-time.
> It's a false positive.  The other thing to consider it the UBSan will
> also detect the uninitialized read at runtime and splat.  That's still a
> false positive but it's a headache.  But when I was looking at this, I
> decided that __adis_read_reg_16() was unlikely to fail in real life so I
> decided to ignore this warning.
> 
> Initializing the variable to zero doesn't change runtime for sane configs
> because everyone automatically zeroes stack variables these days.  It
> just silences the Smatch warning.  So I'm fine with this patch.
> 
> (This email is for information only in case you were wondering why the
> bug report was formatted strangely etc).
> 
> regards,
> dan carpenter
> 
Thanks!  That explanation has me agreeing that this patch seems to
make sense as fixing a warning that is reasonable if unlikely to
cause problems in practice. I've applied it to the togreg branch of iio.git 

Jonathan


