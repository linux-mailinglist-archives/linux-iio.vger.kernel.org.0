Return-Path: <linux-iio+bounces-9625-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19AA897AF49
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 13:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F0871F21DF0
	for <lists+linux-iio@lfdr.de>; Tue, 17 Sep 2024 11:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3439C16131A;
	Tue, 17 Sep 2024 11:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tKe3TFMN"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC37949659;
	Tue, 17 Sep 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726571597; cv=none; b=NMLrS69l2JflYpakJauZ2i1Q9SGYuRd0NInOGXD1RsOWZ3EIbH3SrVsM+sPUT+s7h2HrfvWSBvzmnRpAuidkKINm+51+Ze3t5Zw+i/j4f3l7cn2gRTeAPus+339LpMrYkjW37u/faVszwkDzWbOPTqhxz4uGvQSS+gRuXQRAS0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726571597; c=relaxed/simple;
	bh=6lkR70ZMKFHtrFZOKX0zZA/AWJe88OjDhpXj46DGRD4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hi/1IMya74K/Thts98EaCpqAuWYZ+YfhzU5I8KXJGyBhPxUceOmj6JJfxEArZodilqyo4NCCYMzV0eONktOiBV6VMvIGJ0bv3ow/9VwMjqlJrSYfRbkUSZ8aSFQjAnvhpeixjaXOur0AcAUK20myYQ8zgjgq+KUv5VEUdXyk1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tKe3TFMN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E32F5C4CEC5;
	Tue, 17 Sep 2024 11:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726571596;
	bh=6lkR70ZMKFHtrFZOKX0zZA/AWJe88OjDhpXj46DGRD4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tKe3TFMNitbuFMrUU3GCIuYvuEs7bFk5+1O/TzRFzH8dnh793KRnNIneE9khxIaFo
	 upcbNi6v5ApkWaxCM0NWt4yWdTyJedldNIysSiPribpTUbSjibECvBUpMOclfaysxN
	 6NiXwc65wKcrtoaum1CacZ5WEPKyQ8ZApYiM1wk9NiAJXvJsDA6UmR3zyxflt1zhz0
	 VxotGJFYmq/qiN6p5K7ujrCLDoMHRBnZDacgrYaTV3pyJDmxmuDzGImuRx/PBmiILP
	 VeeUF3VW388XPpAjej4OWKsY57RxbcgZvqvGu+YHxnwQ4cffefmU87evdyQnzah1HY
	 wAV90V+2ovfag==
Date: Tue, 17 Sep 2024 12:13:01 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com>
Cc: "lars@metafoo.de" <lars@metafoo.de>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "dima.fedrau@gmail.com"
 <dima.fedrau@gmail.com>, "marcelo.schmitt1@gmail.com"
 <marcelo.schmitt1@gmail.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Lorenz Christian (ME-SE/EAD2)"
 <Christian.Lorenz3@de.bosch.com>, "Frauendorf Ulrike (ME/PJ-SW3)"
 <Ulrike.Frauendorf@de.bosch.com>, "Dolde Kai (ME-SE/PAE-A3)"
 <Kai.Dolde@de.bosch.com>
Subject: Re: [PATCH v7 2/2] iio: imu: smi240: add driver
Message-ID: <20240917121301.3864a3f7@jic23-huawei>
In-Reply-To: <AM8PR10MB4721196E13BCDAD7ABAD8E85CD602@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
References: <20240913100011.4618-1-Jianping.Shen@de.bosch.com>
	<20240913100011.4618-3-Jianping.Shen@de.bosch.com>
	<20240914173229.57548005@jic23-huawei>
	<AM8PR10MB4721196E13BCDAD7ABAD8E85CD602@AM8PR10MB4721.EURPRD10.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Sep 2024 20:32:56 +0000
"Shen Jianping (ME-SE/EAD2)" <Jianping.Shen@de.bosch.com> wrote:

> >Hi Shen,
> >
> >I suspect I led you astray.  regmap core seems unlikely to feed us little endian
> >buffers on writes (they should be CPU endian I think) so there should be memcpy()
> >for that not a get_unaligned_le16()
> >  
> >> +
> >> +static int smi240_regmap_spi_write(void *context, const void *data,
> >> +				   size_t count)
> >> +{
> >> +	u8 reg_addr;
> >> +	u16 reg_data;
> >> +	u32 request;
> >> +	struct spi_device *spi = context;
> >> +	struct iio_dev *indio_dev = dev_get_drvdata(&spi->dev);
> >> +	struct smi240_data *iio_priv_data = iio_priv(indio_dev);
> >> +
> >> +	if (count < 2)
> >> +		return -EINVAL;
> >> +
> >> +	reg_addr = ((u8 *)data)[0];
> >> +	reg_data = get_unaligned_le16(&((u8 *)data)[1]);  
> >
> >Why is the regmap core giving us an le16?
> >I probably sent you wrong way with this earlier :( memcpy probably the correct
> >choice here.  
> 
> Yes, you are right. We shall use memcpy to keep the be CPU endian.  Just using memcpy may be not enough.
> 
> Shall we also change regmap_config.val_format_endian  from REGMAP_ENDIAN_LITTLE to  REGMAP_ENDIAN_NATIVE ?
> 
> This is to make sure that regmap_write passes the reg-value to smi240_regmap_spi_write without changing the CPU endian.
>
Hmm. I'd missed that control.  If the register data needs to be little endian
then it is correct to leave that set as REGMAP_ENDIAN_LITTLE as then
the regmap core will do the endian swap for you on Big endian systems.

If I follow that bit of regmap correctly it will then have the data
in the right order so the above still wants to just be a memcpy.

As it stands, on a Big endian host, regmap will use the val_format_endian
to decide to flip the bytes.  This code then flips them back again and
the value written is big endian which is not what you intend!

Easy way to check this will be to set it, on your little endian
host, to REGMAP_BIG_ENDIAN and see what you get in the value.
Then consider if you'd had get_unaligned_be16
then it would end up as little endian again.  This should mirror
the current situation if this driver runs on a big endian host.

Hope that confusing set of comments helps!

Jonathan

 


