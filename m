Return-Path: <linux-iio+bounces-7794-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4EB939410
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 21:16:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6900E1C2150F
	for <lists+linux-iio@lfdr.de>; Mon, 22 Jul 2024 19:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA7438DD6;
	Mon, 22 Jul 2024 19:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AT9BCsxh"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582FB14287;
	Mon, 22 Jul 2024 19:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721675758; cv=none; b=uDSLoz4zMfCfnDvARwqSnRjYfce+Li8HKItDSNiIohiwek6Ri8qbmPS/5WyudVRMlFr69bCcxpawlbL05JKlS/yNUhV5BknKD8Xn2jd+GdX5670ZqWyuyknOOzEKeiKyP5xK4MJ3AvV9Q6pqneQvcamWhpZL1HUFDOwRxzsRIp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721675758; c=relaxed/simple;
	bh=WVY+AkD7g4G+jyPp7Le/5xFjdMjntzVxcHnRY57NjqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aotuc7naMJpb5+qpMtNl//Phh6j3Rv5ypBHz4Okg6eHD/GLQyt5KHexHp5NaZB137e0tRbR0wqAIN5YwpalMcHx7oNieMl24xAksFR4hyJp31Q/56JHiY9v0n6KwgnCywMUGSeM92ZCWk8ZcacIWTwGYFwIH6bbBso5SQmej7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AT9BCsxh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E82C4AF0B;
	Mon, 22 Jul 2024 19:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721675757;
	bh=WVY+AkD7g4G+jyPp7Le/5xFjdMjntzVxcHnRY57NjqA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AT9BCsxhwLic0XzDg1cFCmhPnvAlmv6Iv8hSVp/cU15okDlds/6elXYgD7aIMvHgM
	 /dXXR/bYhVG4Ebx8Rv8RdEwdWQVL51pDsJgf6b8NQyhVNhM2XKVEqtjgiInfQEeQSC
	 xakkFdUyrOiwOZfxXv0wVXhwZvy2/cAv6Vom4LdyjB78qILhLdAm+PuEyqJwfOY37y
	 CAOJzClwpUfvYwdVGLjQYCJ7jjIW2ueJkje+crtZy+RzFlZ0khgF6NAZsf+Ccx/BzL
	 neHBBxeo0BR2eh/wbgJkjzu8MC93vowO5pPOsHqeZHYhYthBCkT2aZXgEQlkKoAsEs
	 AQnB/xCKmrkTg==
Date: Mon, 22 Jul 2024 20:15:49 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, linus.walleij@linaro.org,
 biju.das.jz@bp.renesas.com, javier.carrasco.cruz@gmail.com,
 semen.protsenko@linaro.org, 579lpy@gmail.com, ak@it-klinger.de,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/10] iio: pressure: bmp280: Use sleep and forced
 mode for oneshot captures
Message-ID: <20240722201549.709dc107@jic23-huawei>
In-Reply-To: <20240721221156.GD325365@vamoiridPC>
References: <20240711211558.106327-1-vassilisamir@gmail.com>
	<20240711211558.106327-8-vassilisamir@gmail.com>
	<20240720122802.2c899ee7@jic23-huawei>
	<20240721221156.GD325365@vamoiridPC>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


> > >  
> > >  	.trigger_handler = bmp580_trigger_handler,
> > > @@ -2503,6 +2721,16 @@ static int bmp180_read_press(struct bmp280_data *data, u32 *comp_press)
> > >  	return 0;
> > >  }
> > >  
> > > +static int bmp180_set_mode(struct bmp280_data *data, u8 mode)
> > > +{
> > > +	return 0;  
> > Add a comment on why these are stubs.  It's in the patch description, but
> > better to have it recorded in the code.
> >   
> 
> I didn't add because as you can see below there is another function exactly
> like this one that doesn't have one. Should I add also to the other one?
Hmm. Maybe? :)

> 
> > > +}
> > > +
> > > +static int bmp180_wait_conv(struct bmp280_data *data)
> > > +{
> > > +	return 0;
> > > +}
> > > +
> > >  


