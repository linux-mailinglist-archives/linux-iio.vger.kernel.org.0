Return-Path: <linux-iio+bounces-18728-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8AAA9E302
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 14:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F148175115
	for <lists+linux-iio@lfdr.de>; Sun, 27 Apr 2025 12:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 427CB523A;
	Sun, 27 Apr 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UC3fFTnp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F311C4A01;
	Sun, 27 Apr 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745757484; cv=none; b=qNDpMCA74SpqLvWaNCFlBAfVxnD6Z58EmZKH6ry3vj2QdL8mQGgn3Ths2KeMgH5PAJZR7HCmCjIYcEwOPmBUCkdeiMNXwknIPNxtnkMdHmlOAzRbunhsjB59mn44DKvlPTcnE1wQHSLJMZ75qL3iz8z+mfFUAwYwaqWSad68wZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745757484; c=relaxed/simple;
	bh=PaE830UpuRis4GjvhoF8ftqXnDFLB+SlTd4/zdUTiHA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QysxCK0YMSWzm8unGd76d8oDeciOqqf3u+L/BUwsFS33uWED7wpz5uld1TjwkHKT7RwV3tM2pnq26ANgALa1feSdOAgK/h5l37Isrm8qnNjnaweAL+2kYT/XcDoJ2usMJ/T+0NSTIrEYTfQPyt6IZyHoBrbYMye2ALDlvrChuF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UC3fFTnp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F267DC4CEE3;
	Sun, 27 Apr 2025 12:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745757483;
	bh=PaE830UpuRis4GjvhoF8ftqXnDFLB+SlTd4/zdUTiHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UC3fFTnpiUYAVoNrEZvHIGVrHr3iF0y4Y1+P5pTxhLLmta5+thC6uDzE8grky/06A
	 L7PZZz9UWe1PQvn/Mbn3Tln5U5OJUuHzNLfW4HryygcG2iScoks/JUInQE3o5BpYdx
	 quSpHEPljTUbh7ZosOvemjocLV6IZvoWDeNgAHXjWdJLmgOXb7UhgpjBgWlOrpXtTm
	 SGozW+uqnI9dqza1vOwHpDkpT5yw3spTVEXK/BMIHq/vCIYOuNgZFsncd68WpiuGiR
	 D9NpLaErTv7RTz7HoeYMrlL/bvARIdHKgqns2fAs3vksUWZj+aR9LtiKGDdnzHFvhN
	 238WjazjIIWBA==
Date: Sun, 27 Apr 2025 13:37:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 07/11] iio: accel: adxl345: add g-range configuration
Message-ID: <20250427133756.790a19fb@jic23-huawei>
In-Reply-To: <20250421220641.105567-8-l.rubusch@gmail.com>
References: <20250421220641.105567-1-l.rubusch@gmail.com>
	<20250421220641.105567-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Apr 2025 22:06:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce a mechanism to be able to configure and work with the available
> g-ranges keeping the precision of 13 digits.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

> +
> +/* scaling */
> +static const int adxl345_range_factor_tbl[] = {
> +	[ADXL345_2G_RANGE]  = 1,
> +	[ADXL345_4G_RANGE]  = 2,
> +	[ADXL345_8G_RANGE]  = 4,
> +	[ADXL345_16G_RANGE] = 8,
This isn't used for a few more patches... I moved it whilst applying

> +};
> +


