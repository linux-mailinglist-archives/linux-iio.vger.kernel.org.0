Return-Path: <linux-iio+bounces-19440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A0BAB295C
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 17:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6861189709C
	for <lists+linux-iio@lfdr.de>; Sun, 11 May 2025 15:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC36925B68D;
	Sun, 11 May 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d/WkzIak"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2E7464;
	Sun, 11 May 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746977185; cv=none; b=kMJuXlOQwtZbPAZtD2p8bZQmy/vPAjG+ND7vjhnq04Y4AajgMM6xobwdQNnWBJtVAcGkEfDSnutCT1+zFVQOpksA9hgqGeHYfqLsFMTIaKAg6NKjQuJwr/LU67wvNdNrfo7AgCPc3ikNCV5lY8CAi8BGTsbLsPUNLZaJqnrTwis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746977185; c=relaxed/simple;
	bh=mWTm+Sf5gFjVL0uIAw+P6B725BFz5zznGOoAvlQOLAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KD73oXqiEJetUBFxjCYXrsO3ZmFUv94oaPx0bpdaseUZ1xaQut3m1iHYtFXGdxTvKRh5Wb2W/W/8Q24di9HsAU9jHD+a8+lhQfjbP2VLgV7Q3C8KiERqf9w3K/3x55e+kcruE7iJVAXKgttIeflEp8RaIEw9gtcJbEtpUpLbylI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d/WkzIak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C34C4CEE4;
	Sun, 11 May 2025 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746977184;
	bh=mWTm+Sf5gFjVL0uIAw+P6B725BFz5zznGOoAvlQOLAo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d/WkzIakH9MZXp49qrJgU/90ES73cafAef1GgkjZB1mYWcvGPt6TMOONg+hkvgpHP
	 6Eg9MpMmC0gocZU47TbtOEfB30Qq/03CDpEPiTYDu99Jehi7jYfSP8M1ortIrW9ANE
	 L0299ppGCkdL8nzubBb2BhR7qIrUQ/6NPhUxxQX+KHG0nSTzpxsPOQNJzN0Odjj71+
	 rNLnZScZZi4ni0BMsw/t4yLV3Ph07QiDL/AUofiw7J3u7VnKNV26WBCHIhXWs19GNp
	 3z/bXi7Vze0xPIKfA9dKpFaYHSaNBGxbvtq4Q1ZFZqsVt2sImdRJZqzgWSes3mLr4Q
	 Eqz7Qix8+n96w==
Date: Sun, 11 May 2025 16:26:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Brajesh Patil <brajeshpatil11@gmail.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 3/5] iio: magnetometer: qmc5883l: Add initial driver
 support
Message-ID: <20250511162618.34883bcb@jic23-huawei>
In-Reply-To: <297ec0b1-d6a4-4fc9-95c7-e7f3bef53d97@baylibre.com>
References: <20250508120900.114348-1-brajeshpatil11@gmail.com>
	<297ec0b1-d6a4-4fc9-95c7-e7f3bef53d97@baylibre.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 8 May 2025 11:03:51 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On 5/8/25 7:08 AM, Brajesh Patil wrote:
> 
> This needs a description that explains why we would want to add this to the
> kernel.
> 
> > Signed-off-by: Brajesh Patil <brajeshpatil11@gmail.com>
A jumped on top of David's review (note I cropped lots of good feedback so do
look at his reply!) and added a few things.

J

> > diff --git a/drivers/iio/magnetometer/qmc5883l.c b/drivers/iio/magnetometer/qmc5883l.c
> > new file mode 100644
> > index 000000000000..68597cdd0ca8
> > --- /dev/null
> > +++ b/drivers/iio/magnetometer/qmc5883l.c
> > @@ -0,0 +1,471 @@

> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		ret = regmap_read(data->regmap, QMC5883L_CONTROL_REG_1, &rval);
> > +		if (ret < 0)
> > +			return ret;
> > +
> > +		rval = (rval & QMC5883L_ODR_MASK) >> QMC5883L_ODR_SHIFT;
> > +
> > +		if (rval >= ARRAY_SIZE(qmc5883l_odr_map) || !qmc5883l_odr_map[rval])
> > +			return -EINVAL;
> > +
> > +		*val = qmc5883l_odr_map[rval];
> > +		*val2 = 0;
> > +		return IIO_VAL_INT;
> > +	}
> > +	return -EINVAL;

Probably can't get here - which is good, but if you can't drop this line.

> > +}

> > +static const struct iio_info qmc5883l_info = {
> > +	.read_raw = &qmc5883l_read_raw,
> > +};
> > +
> > +static const unsigned long qmc5883l_scan_masks[] = {0x7, 0};

static const unsigned long qmc5883l_scan_masks[] = { 0x7, 0 };

> > +
> > +static int qmc5883l_probe(struct i2c_client *client)
> > +{

...

> > +
> > +	data = iio_priv(indio_dev);
> > +	data->client = client;
> > +	data->regmap = regmap;
> > +	mutex_init(&data->lock);
> > +
	ret = devm_mutex_init(&data->lock);
	if (ret)
		return ret;

Cleaning up mutexes only does stuff in debug modes, so traditionally we didn't
bother but now we have devm_ handling it is a nice to have thing.


