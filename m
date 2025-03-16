Return-Path: <linux-iio+bounces-16897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C47A6355F
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFF3B16BF83
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BAB51A314F;
	Sun, 16 Mar 2025 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p7nuvPx+"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BC24A06;
	Sun, 16 Mar 2025 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124532; cv=none; b=Cj5iHJAJy3y0jpZ9Ligs9fFIeGxHkkmeXGmw4DDTtiPedNC4tO2CqmokOOv6jI/LRpcYQO7myNKG7e4HEZPrf7phdxHLxHvKYv4zP19oFf7KAfinInP+ivF9OJhzMbRxBYn8gR9FoIsO2AtOphIC6orPVVV2bE/0MBCfpDpwLik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124532; c=relaxed/simple;
	bh=fKaDdLCbrZliNDRDoNchonFwvogX2TuT5tuOtUeU5Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVoy6LOP6Ck9vIMyj9bOjfGyZ1quqyDw4WnjRo+e5PdO3jDrNooXZKxSKzBK9Ul/NprsnDjS1vbytP8HpNBMOtZ+2dXaZHt6Cd0H4/lsRuyKFdfXiWBSKpYiveO15BiFVmn3cVGs1Koq0/aNpkMRWK08yFCA+DxuHGABPH1VGko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p7nuvPx+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80117C4CEDD;
	Sun, 16 Mar 2025 11:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742124531;
	bh=fKaDdLCbrZliNDRDoNchonFwvogX2TuT5tuOtUeU5Zk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=p7nuvPx+17QNMkuvDlwMr5DjpS5MQkgyENbsmqPrkuCQzsOn+JyzANEnmN8lCglDz
	 1kV9DMkZw6QhWdUup78IuYl9+CNyzUGXCGjkqrsVgevXE6IBNkJFHtvgQS1MIsU/uo
	 btqmIjcKB88s2Kiws553WEDVWnT9ADlNmjc1gFPSn29LFX0VcSzka5Gn+LnRj9fBdL
	 JQ0BKHsupJLu8TRnTVexJ5b9UVIsUXyO9XPT4YsMSspQs/afNtmQxpTV145KQRTX4K
	 mBm89Oh2z2Mu8x5I/RJ3/qPN1bY6pWlsLuK39trZFlOZVIqV+tCf57aa2WmP8P4jyr
	 yYzMez1q6dYJg==
Date: Sun, 16 Mar 2025 11:28:39 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 10/14] iio: accel: adxl345: add g-range configuration
Message-ID: <20250316112839.6124946a@jic23-huawei>
In-Reply-To: <20250313165049.48305-11-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-11-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:45 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Introduce means to configure and work with the available g-ranges
> keeping the precision of 13 digits.
> 
> This is in preparation for the activity/inactivity feature.

As with previous. This seems to be a separate feature to me and
that comment raises questions that we don't need to raise so
just drop it.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>


> +
> +static int adxl345_set_range(struct adxl345_state *st, enum adxl345_range range)
> +{
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_RANGE,
> +				 FIELD_PREP(ADXL345_DATA_FORMAT_RANGE, range));
> +	if (ret)
> +		return ret;

return regmap_update_bits() unless there is more coming here in later patches.

> +
> +	return 0;
> +}

