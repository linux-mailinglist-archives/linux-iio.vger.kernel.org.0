Return-Path: <linux-iio+bounces-12593-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA8C9D770C
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373DA163C1E
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5642113A244;
	Sun, 24 Nov 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hTLqCFp/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6C6130A54;
	Sun, 24 Nov 2024 18:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471288; cv=none; b=e1Vg27eGUZLChudq4EsIPutvciHlLElWbgMKnVIQT8m8iaSebhYVsuaYkjKvS889So2TBllV55SyPObw2du0+omfL9+Um8C3fa0LgmOArzM5U5QRuAbvy/MXrVTSgWHZU8twBZO6FPJsxBHhir0/aNCmk7pIGcY9VGM19qjzUHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471288; c=relaxed/simple;
	bh=vVFfqmCJuVV2rIhUhVNKznqiST37KbTK0iu+yyTqwkg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CR6QaEPqVKRpccMzTqyoUB/cp+TMd6zd5PocXnWxsToIfPLlhLkWwBeF/s2i11E0mWTBnkvCGYpC+lcK5BA6JlIvXalu9+BODBZL53otwCkhGYB7FwPtcT4YLK8dPRBK38Au4nb+3Vb4uTeHeHgaQB4oPgeZ+TJiTdbDJVjA9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hTLqCFp/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4334C4CECC;
	Sun, 24 Nov 2024 18:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732471287;
	bh=vVFfqmCJuVV2rIhUhVNKznqiST37KbTK0iu+yyTqwkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hTLqCFp/MIl6bIDjjTQfPurnaIep1lGMs5V5VR4T6S8IgGHIZ2ULBIxqqu3fjCjtV
	 bHThZxbl5EE8rkaNankmaQT5B4cV2WaePKeH8i4xQbTg6yzj8XWViACwo7u2yxDgRI
	 jtVYw68HbGh0/KlavoHhSBWx3jfDkW6VAo48DlJQdmz3Jr7/ZaSS3TqS1De1lsdBEO
	 Kemy+HEPVl9r8Fwp+vXOc5ak2BJpE4F/4+Ihtnk6erFsBZuH1Kryx+w5hVInAPf8WE
	 v+o+5dGS8EZtzfOoHi2HZgBN7DNYZL0FaGJoNPDu3uKHCs4BXIAp/D4w2o1O8Mgrk0
	 D0XdGUDmDdLPQ==
Date: Sun, 24 Nov 2024 18:01:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 03/22] iio: accel: adxl345: rename struct
 adxl34x_state
Message-ID: <20241124180120.5528e84c@jic23-huawei>
In-Reply-To: <20241117182651.115056-4-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-4-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:32 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Rename the struct "adxl345_data" to "adxl34x_state". First, the
> data structure is supposed to be extended to represent state rather than
> only hold sensor data. The data will be a separate member pointer.
> Second, the driver not only covers the adxl345 accelerometer, it also
> supports the adxl345, adxl346 and adxl375. Thus "adxl34x_" is a choice
> for a common prefix.
No to the wild card x.  Long experience has shown that manufacturers
almost never respect naming sequences so we simply name everything after
one supported part number.  It seems like a good idea, but we've been
bitten before.  

I'm fine with the _data to _state change but please combine with the previous
patch to void unnecessary churn where the same line gets updated twice.

These two changes are very closely related so fine to do them in one patch
in my opinion.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 3fb7a7b1b7..30896555a4 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -17,7 +17,7 @@
>  
>  #include "adxl345.h"
>  
> -struct adxl345_data {
> +struct adxl34x_state {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  };
> @@ -43,7 +43,7 @@ static int adxl345_read_raw(struct iio_dev *indio_dev,
>  			    struct iio_chan_spec const *chan,
>  			    int *val, int *val2, long mask)
>  {
> -	struct adxl345_data *st = iio_priv(indio_dev);
> +	struct adxl34x_state *st = iio_priv(indio_dev);
>  	__le16 accel;
>  	long long samp_freq_nhz;
>  	unsigned int regval;
> @@ -99,7 +99,7 @@ static int adxl345_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
> -	struct adxl345_data *st = iio_priv(indio_dev);
> +	struct adxl34x_state *st = iio_priv(indio_dev);
>  	s64 n;
>  
>  	switch (mask) {
> @@ -181,7 +181,7 @@ static void adxl345_powerdown(void *regmap)
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		       int (*setup)(struct device*, struct regmap*))
>  {
> -	struct adxl345_data *st;
> +	struct adxl34x_state *st;
>  	struct iio_dev *indio_dev;
>  	u32 regval;
>  	unsigned int data_format_mask = (ADXL345_DATA_FORMAT_RANGE |


