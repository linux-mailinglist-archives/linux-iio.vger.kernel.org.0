Return-Path: <linux-iio+bounces-16898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49FA63564
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 12:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71F07189209C
	for <lists+linux-iio@lfdr.de>; Sun, 16 Mar 2025 11:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C8319ABD4;
	Sun, 16 Mar 2025 11:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VfUS/+XG"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E06FC5;
	Sun, 16 Mar 2025 11:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742124747; cv=none; b=gbS18Zoz4ho1lx/mvdgqQIpv/QJ996dA2cs9ma4QfRxYjHb6OoK1a5gtQlcSR3BuGwxgB2XPGeY2MsnQ31bR8r5KSzvTe8R9JYms2SaCt8mccCa6zmW1IeWs7szQ3Ef1MZPAFsIeJQ5M9AaferYWbeOxZ9/uEISQXbtEOQbDUUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742124747; c=relaxed/simple;
	bh=Lvu7a7eTOzHrg5Cfrf+UF8Gg+804kRfsWOMNQJ9ptxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=djDNBSp5rVYF/0UEoTyUVXSvTPVaw4DrN74VLwa/fscTar33ipfBflaL4VLizo3VPE+43j1b4YL6lQ/PQta1DfDF5AqvGlnFkGv1q+/TEcFpa/g6vlb7C0Hn+m3uyLbf6PZK7vrDvj9blfXmCMA1OCt2yuhDcDYoBWagW2m0xBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VfUS/+XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFFDC4CEDD;
	Sun, 16 Mar 2025 11:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742124747;
	bh=Lvu7a7eTOzHrg5Cfrf+UF8Gg+804kRfsWOMNQJ9ptxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VfUS/+XG8AXGEyoqG5Xl3Jv/aYgLjUhX5bpU1aJtPZI2eqFjqwIeHzU2p0OnXIS1c
	 kSxlPxEwt5kxJAY58Kv3TU6Zr6kywNCIwpCWzIlVSnUQvFm/9iPwRxMlVB/RqRD0QX
	 xK88gVEUrOac1L4MGTZ2FUqF5scYwu5qA6lIIC4F2CiGd4UWf5TJF9xAAcNWkdOVBD
	 M1qIjuv5JhSik4i18fm3ryuNpR46mT3+Xj8Ad94/XQab1wnGIG9MMTLpcnDfcsAhSr
	 dn6F2GXoU4ztSWRDN84L7Hrq7XjawsUej+5yVcsvILhgSzFpYWc0NLtd2HjSDDbg1i
	 /aK8D5IZwiZoQ==
Date: Sun, 16 Mar 2025 11:32:03 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v4 11/14] iio: accel: adxl345: add activity event
 feature
Message-ID: <20250316113203.695b69e8@jic23-huawei>
In-Reply-To: <20250313165049.48305-12-l.rubusch@gmail.com>
References: <20250313165049.48305-1-l.rubusch@gmail.com>
	<20250313165049.48305-12-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 16:50:46 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold stored in regmap cache. Initialize
> the activity threshold register to a reasonable default value in probe.
> The value is taken from the older ADXL345 input driver, to provide a
> similar behavior. Reset the activity/inactivity direction enabling
> register in probe. Reset and initialization shall bring the sensor in a
> defined initial state to prevent dangling settings when warm restarting
> the sensor.
> 
> Activity, ODR configuration together with the range setting prepare the
> activity/inactivity hystersesis setup, implemented in a follow up patch.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>

A few things inline.

Jonathan

> @@ -1176,7 +1373,8 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  	if (ret)
>  		return IRQ_NONE;
>  
> -	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl)) {
> +	if (FIELD_GET(ADXL345_REG_TAP_AXIS_MSK, axis_ctrl) ||
> +	    FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl)) {
>  		ret = regmap_read(st->regmap, ADXL345_REG_ACT_TAP_STATUS, &regval);
>  		if (ret)
>  			return IRQ_NONE;
> @@ -1187,12 +1385,22 @@ static irqreturn_t adxl345_irq_handler(int irq, void *p)
>  			tap_dir = IIO_MOD_Y;
>  		else if (FIELD_GET(ADXL345_X_EN, regval))
>  			tap_dir = IIO_MOD_X;
> +
> +		/* Activity direction is stored in the upper four bits */
> +		regval >>= act_shift;
As per feedback on v3 (late feedback that is), just add more defines
for these bits as the reuse adds connections that are kind of
coincidence rather than fundamental (bits 'could' have been defined
in any order or non contiguous) and lead to less readable code.
> +
> +		if (FIELD_GET(ADXL345_Z_EN, regval))
> +			act_dir = IIO_MOD_Z;
> +		else if (FIELD_GET(ADXL345_Y_EN, regval))
> +			act_dir = IIO_MOD_Y;
> +		else if (FIELD_GET(ADXL345_X_EN, regval))
> +			act_dir = IIO_MOD_X;
>  	}
>  

