Return-Path: <linux-iio+bounces-18436-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA70CA95166
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D048169537
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4EB265614;
	Mon, 21 Apr 2025 13:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+CjTLsJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBF9264A86
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 13:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745241137; cv=none; b=T4ASUkcUBDb9mNCeL0G2ZXncz0WBjxx/xxZZhOJclXxixqI6tIw2o0HfkfgwsDMjr410X90h2hTs1w004KlDtr4tCNeIk89fHOadfUKsr60/BHi4lJrfpwF6iOSVMkmJ75QNSnEpByBTzeGlSJ3Uq7l+L1VhPiSAo1p74LeJdXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745241137; c=relaxed/simple;
	bh=piKrDlPqgj6AvtCN8xPcTY3wRQn60sXpDDVDy5YJ2/s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dI3tge6FAQ3OStEC+KaFdZ0J0/zV2uMkKHzlo92jUwDLiDEdGTr52UeHuXE8uMQRcz8RlY8J7qI56o8bb6tK3iVzco6Kq+3Dh5CyMwj1hQis9rwSupA0x+hr5JszMuMSqqID6x8eBQOLlj7f7S15F/Yr6QMze6GppKtPBHMJAm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+CjTLsJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A5FBC4CEE4;
	Mon, 21 Apr 2025 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745241136;
	bh=piKrDlPqgj6AvtCN8xPcTY3wRQn60sXpDDVDy5YJ2/s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=O+CjTLsJ3FoFnLsOgq+QLjSzXfPGfTU6wxQqL/1EeZb9Rmd2TbnrczaxKRG7XcBkz
	 XNLW6VPxcY0NWnbMl1N3oCIlzsRU445j3OCe5ErY4xvItMbKb2R2Rz3JP9T2YFP7oh
	 pLrNq8HxpbPShwFS9Nn0xZziV7DIr3PgrNClUKh5r7ZDSNSoflV34dRNZeBXo6dq1Z
	 k0JMkERnVBVfO6RweBDSjhMtfq2FlBqJFnEvJkMAFKLmf7uzQOKS73HctYD+SgADUF
	 CRKFOCEMv+wQ2mU5tazPQ89O9uJhDZPmeTRxjdKiMmQyKB66B6dP2tLb8MIOKQrs16
	 STMW8oBBEzeRQ==
Date: Mon, 21 Apr 2025 14:12:09 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: nattan <nattanferreira58@gmail.com>, subhajit.ghosh@tweaklogic.com,
 lucasantonio.santos@usp.br, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: light: apds9306: Refactor threshold get/set
 functions to
Message-ID: <20250421141209.04f51a39@jic23-huawei>
In-Reply-To: <aAU8ZczOnIIOcCOC@debian-BULLSEYE-live-builder-AMD64>
References: <20250419232128.35759-1-nattanferreira58@gmail.com>
	<aAU8ZczOnIIOcCOC@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 20 Apr 2025 15:26:45 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> Hello Nattan, Lucas,
> 
> Not sure it's worth extrancting the event direction comparison into that
> separate function. Even though there is less code repetition, we now have an
> extra comparison to handle get_thresh_reg() return. Despite of that, see
> comments below.
> 
> On 04/19, nattan wrote:
> > From: Nattan Ferreira <nattanferreira58@gmail.com>
> > 
> > Refactor the apds9306_event_thresh_get and apds9306_event_thresh_set functions
> > to use a helper function (get_thresh_reg) for obtaining the correct register  
> Wrap commit description to 75 columns.
> 
> > based on the direction of the event. This improves code readability,
> > minimize the number of lines  and maintains consistency in accessing
> > threshold registers.
> > 
> > Signed-off-by: Nattan Ferreira <nattanferreira58@gmail.com>
> > Co-developed-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > Signed-off-by: Lucas Antonio <lucasantonio.santos@usp.br>
> > ---
> >  drivers/iio/light/apds9306.c | 38 ++++++++++++++++++++----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
> > index 69a0d609c..8e1cdaeb0 100644
> > --- a/drivers/iio/light/apds9306.c
> > +++ b/drivers/iio/light/apds9306.c
> > @@ -6,7 +6,6 @@
> >   *
> >   * Copyright (C) 2024 Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>
> >   */
> > -  
> This doesn't seem to have any relation with the intent of the patch.
> Drop this unrelated change.
> 
> >  #include <linux/bits.h>
> >  #include <linux/cleanup.h>
> >  #include <linux/delay.h>
> > @@ -744,20 +743,28 @@ static int apds9306_event_period_set(struct apds9306_data *data, int val)
> >  	return regmap_field_write(rf->int_persist_val, val);
> >  }
> >  
> > -static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> > -				     int *val)
> > +static int get_thresh_reg(int dir)  
> Even though these functions are declared static, it's common patter in IIO
> that driver functions start with the name of the driver. So, it would be more
> conventional to call it apds9306_get_thresh_reg().
> 
> >  {
> > -	int var, ret;
> > -	u8 buff[3];
> > -
> >  	if (dir == IIO_EV_DIR_RISING)
> > -		var = APDS9306_ALS_THRES_UP_0_REG;
> > +		return  APDS9306_ALS_THRES_UP_0_REG;

Just one space after return

> >  	else if (dir == IIO_EV_DIR_FALLING)
> > -		var = APDS9306_ALS_THRES_LOW_0_REG;
> > +		return APDS9306_ALS_THRES_LOW_0_REG;
> >  	else
> >  		return -EINVAL;
> > +}
> > +
> > +static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> > +				     int *val)
> > +{
> > +	int reg, ret;
> > +	u8 buff[3];
> > +
> > +	reg = get_thresh_reg(dir);
> >  
> > -	ret = regmap_bulk_read(data->regmap, var, buff, sizeof(buff));  
> There is now a blank line between function call (apds9306_get_thresh_reg()) and
> the return check, which is unusual in IIO. Drop the blank line between those
> 	reg = get_thresh_reg(dir);
> 	if (reg == -EINVAL)
> ...
> 
> > +	if (reg == -EINVAL)
> > +		return reg;
> > +
> > +	ret = regmap_bulk_read(data->regmap, reg, buff, sizeof(buff));
> >  	if (ret)
> >  		return ret;
> >  
> > @@ -769,22 +776,19 @@ static int apds9306_event_thresh_get(struct apds9306_data *data, int dir,
> >  static int apds9306_event_thresh_set(struct apds9306_data *data, int dir,
> >  				     int val)
> >  {
> > -	int var;
> > +	int reg;
> >  	u8 buff[3];  
> Add a blank line between local variable declarations and rest of function code.
> > +	reg = get_thresh_reg(dir);
> >    
> Another blank line between function call and return check to be dropped here.
> 
> > -	if (dir == IIO_EV_DIR_RISING)
> > -		var = APDS9306_ALS_THRES_UP_0_REG;
> > -	else if (dir == IIO_EV_DIR_FALLING)
> > -		var = APDS9306_ALS_THRES_LOW_0_REG;
> > -	else
> > -		return -EINVAL;
> > +	if (reg == -EINVAL)
> > +		return reg;
> >    
> 
> Regards,
> Marcelo


