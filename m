Return-Path: <linux-iio+bounces-19910-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C659AAC35EC
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 19:23:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 959C13AF804
	for <lists+linux-iio@lfdr.de>; Sun, 25 May 2025 17:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF4220A5DD;
	Sun, 25 May 2025 17:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rVfAszUJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4521A76D4
	for <linux-iio@vger.kernel.org>; Sun, 25 May 2025 17:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748193832; cv=none; b=cgIpQ493/1k4C5Hsd9t3ygYbuGr4lPc/dFCror8s+GWaqIrdDK5XxAFw1+9qbIvwUR0IpxzF1qNcS9YqmzZi67LnYiZ3MJAgwjZuFhFJrE6CmxOE9rw/wnNj5D2dbGnYaQFXMGeGCE2u//otC9xRMLfEISZIM8Sn7RweuYpFmiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748193832; c=relaxed/simple;
	bh=FibB1DLqE7wZfdwYu88rHQZWoUOFroT1oiH35pELoME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kS1H1dMmPZlVEwNTasp0/06kx2DyOOcN4MaziYZhh0kHFJ7mBnPssMdpSJ0ZWMwQVdEgdVkrK96gR1/R6i8SEl+tfQErW43UvWhMTqVbInnVECoda+htdJxZ8NERafvEkumkXawy9Ob3nu5MSbGi6Q70AaY8Ehk/WjUUbA8bblY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rVfAszUJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBAC2C4CEEA;
	Sun, 25 May 2025 17:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748193831;
	bh=FibB1DLqE7wZfdwYu88rHQZWoUOFroT1oiH35pELoME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rVfAszUJOFUC2IzK1o/i5TBQAiloM5dq9FB5y6WxrnKWwmHoaYkdfI8P2OGP/ML6A
	 cSrX75nJ3MqtQBdxLADzNlbrgMtkOLBhxsaof+dwrfgtjXfiPJTEebDYW60Kw3MUer
	 Sk71WdzqUyx73rAawgytFG8LqYk4zSdyvR61gIvLCiTuvRhpkjBRO4xIxknZN9Op/6
	 XG/zWZwn5PhQia+ZpJQCIazoNQ7sYgii+4xiltQxGbv98EBsgYLrJ4XPC2TGcmLRtM
	 n1D0OXJG+JMBa+4xOq8JaRWoFc8y7L71hZJiW6L0i/NtqbN5ROpQarY6J3AsteGcwB
	 qsTX5v75W13ZQ==
Date: Sun, 25 May 2025 18:23:45 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Isabella Caselli <bellacaselli20@gmail.com>,
 jean-baptiste.maneyrol@tdk.com, lars@metafoo.de, linux-iio@vger.kernel.org,
 rodrigo.michelassi@usp.br
Subject: Re: [PATCH v3] iio: imu: inv_mpu6050: refactor aux read/write to
 use shared xfer logic
Message-ID: <20250525182345.351ec4cf@jic23-huawei>
In-Reply-To: <20250515174711.78457e4b@jic23-huawei>
References: <20250507184539.54658-1-bellacaselli20@gmail.com>
	<aB-dZecEekMsAEWj@debian-BULLSEYE-live-builder-AMD64>
	<20250515174711.78457e4b@jic23-huawei>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 May 2025 17:47:11 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Sat, 10 May 2025 15:39:33 -0300
> Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:
> 
> > Hi Isabella, Rodrigo,
> > 
> > This patch looks okay to me. Though, I think Jean-Baptiste made a valid point in
> > v1 about inv_mpu_i2c_master_xfer() not implying any specific slave slot
> > previously. I'd suggest to add a slv parameter to inv_mpu_i2c_master_xfer(), but
> > that wouldn't make much difference since inv_mpu_aux_read/write() are still
> > hardcoded for SLV 0.
> > Besides that, I have one minor comment that's probably not a reason for a v4 if
> > this is deemed to be good.  
> 
> I'm looking for a tag from Jean-Baptiste on this.

Jean-Baptiste. If you have time to look at this version that would be great.

> 
> Jonathan
> 
> > 
> > Regards,
> > Marcelo
> > 
> > On 05/07, Isabella Caselli wrote:  
> > > Refactors inv_mpu_aux_read() and inv_mpu_aux_write() to extract the common
> > > I2C transfer sequence into inv_mpu_i2c_master_xfer(), which now handles
> > > starting and stopping the I2C master, waiting for completion, disabling
> > > SLV0, and checking for NACK errors.
> > > 
> > > This refactoring removes code duplication and improves maintainability.
> > > No functional changes are intended.
> > > 
> > > Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
> > > Co-developed-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > > Signed-off-by: Rodrigo Michelassi <rodrigo.michelassi@usp.br>
> > > ---    
> > ...  
> > >  static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
> > >  {
> > > @@ -23,6 +25,7 @@ static int inv_mpu_i2c_master_xfer(const struct inv_mpu6050_state *st)
> > >  	uint8_t d;
> > >  	unsigned int user_ctrl;
> > >  	int ret;
> > > +	unsigned int status;    
> > I'd declare status above ret, or together with user_ctrl.
> > Just minor code style thing.  
> 
> 


