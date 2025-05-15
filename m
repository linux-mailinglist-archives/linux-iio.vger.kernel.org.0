Return-Path: <linux-iio+bounces-19550-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33630AB8CC4
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 18:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0D5C4C1965
	for <lists+linux-iio@lfdr.de>; Thu, 15 May 2025 16:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46751217663;
	Thu, 15 May 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iy67b19Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B1272638
	for <linux-iio@vger.kernel.org>; Thu, 15 May 2025 16:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747327638; cv=none; b=t9ZKriylJI6dpA/H7fUxvuAbYkxyQjK7u4X20foXBVkC2GnttFkUHlKkJr4rlrFF2eGaefcMzujfBSosnJY1eTa2b6GS3KeWUP/ANRg4slBDiw+KdJz90yAv9pT6JxxMtc95XD/kpzk9Avt3Nh7ro71/J5Pi/f6fbjN47OBXL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747327638; c=relaxed/simple;
	bh=90Dnb3G0DyeThH0+8N2Bpw2JjEGv/ggdHNyhqrskP3I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lPudw/j3ErqNawUZUlGyjP3wX0MoVdmwUQT/FpFqHVxrbWFEn8+FBlofD6//A5j6n8egR8CdJDKZHnniE/XqN2J0aSA7EP/B89MC82Xj8w+g636NXhiVKgUAgNWtewKldNf7Ce9PE2yyrRv0WJBdEoMTDyGlHTIos2t5aSYcXL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iy67b19Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4650EC4CEE7;
	Thu, 15 May 2025 16:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747327637;
	bh=90Dnb3G0DyeThH0+8N2Bpw2JjEGv/ggdHNyhqrskP3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iy67b19Z6CMiq6gF0dNxHv59wP3FKw3/wTIl4CXShj7r2x9zVskwFRw48EJ/p7S3u
	 /F3Fc+jjIb2qnfnk082lmfw6Ayrr8rZjYxSOJufCaOkSqPa7IZWywqozs1ypqxHVcG
	 v4jNKlcruNUlkM84pq855dKcWC9sgXozVDAF6Pj16LaO1qswU0M+6JsnfjIhMKC1dW
	 ge1rojPbr+6SC760SeLtHy0H7Fpy+k1xfEdk31HrHZgpLLe1f/ioFQ1s94XtoPUzQW
	 IHQ7rAp7zy8CuqCbobLzkZbUMX8ZIWS8k7MBxVZ3m+J1OUqNJZzn7nR26GuIU/cBKr
	 5SYh9tmSwVt5w==
Date: Thu, 15 May 2025 17:47:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Isabella Caselli <bellacaselli20@gmail.com>,
 jean-baptiste.maneyrol@tdk.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 rodrigo.michelassi@usp.br
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to
 use shared xfer logic
Message-ID: <20250515174711.78457e4b@jic23-huawei>
In-Reply-To: <aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
References: <20250507184539.54658-1-bellacaselli20@gmail.com>
	<aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 May 2025 15:39:33 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hi Isabella, Rodrigo,
> 
> This patch looks okay to me. Though, I think Jean-Baptiste made a valid point in
> v1 about inv_mpu_i2c_master_xfer() not implying any specific slave slot
> previously. I'd suggest to add a slv parameter to inv_mpu_i2c_master_xfer(), but
> that wouldn't make much difference since inv_mpu_aux_read/write() are still
> hardcoded for SLV 0.
> Besides that, I have one minor comment that's probably not a reason for a v4 if
> this is deemed to be good.

I'm looking for a tag from Jean-Baptiste on this.

Jonathan

> 
> Regards,
> Marcelo
> 
> On 05/07, Isabella Caselli wrote:
> > Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the common
> > I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now handles
> > starting and stopping the I2C master, waiting for completion, disabling
> > SLV0, and checking for NACK errors.
> > 
> > This refactoring removes code duplication and improves maintainability.
> > No functional changes are intended.
> > 
> > Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> > Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > ---  
> ...
> >  static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
> >  {
> > @@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
> >  	uint8_t d;
> >  	unsigned int user_ctrl;
> >  	int ret;
> > +	unsigned int status;  
> I'd declare status above ret, or together with user_ctrl.
> Just minor code style thing.


