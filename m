Return-Path: <linux-iio+bounces-8298-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E655A949715
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 19:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14E5D1C20994
	for <lists+linux-iio@lfdr.de>; Tue,  6 Aug 2024 17:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B36459164;
	Tue,  6 Aug 2024 17:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AeVhgAe7"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39612A1C5;
	Tue,  6 Aug 2024 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722966508; cv=none; b=kWP0gov9n8kjenLs4DMVSunoTMH7uNlpDCjTT5eBZAiQyTVNYRb4vkikMaR54fFJkes0f9Xu+Yb2V8ddUHv5yg7257LBbQKGi2Q0uS7cBDOGEVv9CzrOUCk+0tQw5P1QTnScSbJLUueo0V9YL+0m/Gkm9Od60i+QU3QWdBM72Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722966508; c=relaxed/simple;
	bh=vBDC4xo9mbVO1SY74xWdWYDnd5MRWexVdsUupjrLjyg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWFG4+xEC0YvZmdUxum2iB7VvMCvIFqxk2meuiU5oL8APZd9TZ4QBQbnYcZ3ALodueuIWlra76GCKf6SBPWPfjIr+9/JeWfw8vitolv6zokK0RvHFfZGsQ3Ig4csm9+1UKIb1ZlcLpOB2YDm4cHfrJ6cHKzwi1Zc7f0JkUmS8hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AeVhgAe7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso680720b3a.2;
        Tue, 06 Aug 2024 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722966506; x=1723571306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Cdrno72hqQxJb3X2e7mH5XWUDnJWg3spI0M3gLifjw=;
        b=AeVhgAe79/ITpogYc2gGQzkQGpj2SNulO9IgopU+LZkp/WxxVdAN80LnvSzR2fsR5C
         NMOX/vEHLT41szR37cHx/MD6G9CoTJ1uoEK4MB3de/1EUXZUqX3liGJhLOBLshJRbht/
         mTgng7HVzmYjR7TbHP1eBRcI2C5Zr5zA4ZHNj4NLKNXckAwRiOnhABgqRWz/Yph7FcsN
         OKxB8QK7nlhesTOX/1ORhSk9kMI4kMN1D9CLbXHtM+LYBcHlXoNguJLvxZl5tIMtzN2P
         +C3rbE1TcqE/pFY7oJYuIQPL8WdOOukjYitNnX78/BxfJ6dqs+zrtQdvqY4ceqBmNuzJ
         VdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722966506; x=1723571306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Cdrno72hqQxJb3X2e7mH5XWUDnJWg3spI0M3gLifjw=;
        b=jDh+xGKcNRIBL8GOI8pCAjT3X4kUYH2LFjejCaBmgic4wU6fiJMmcwPoInIaXTsS9H
         sC25vDr5+V8MT+fpAJzc7Uinbjwro429yoJUxai0v4SQ474UWpe1uSN3Dikr1j6ETDvt
         vMmjc18ARjWF9ejezXcIBi5wAbPJNB5son+X6nRaZYMAULztUt3+KbO9VxuBaVnjmX/A
         okzfEo+S6AXk5VC/SuW4tsv8grSyaWcU4qpKa+tKvlDhUy0DSHzu+kd6apCENabZz3/F
         rCnwyIerymGx7xoKIl0CJhKbsk1kxixUO8GM7toK8nxFmaQWpVPkOAn2zQKBunCqW5RJ
         LkuQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgyPskx3OVvYuRr/VqlTdvuQ7L6UGRydj+G7VP8ChndOcHqnrDIt9XsvMMYsOGLc0hJEH6H9CDl3o1intinN6IaZUXE55WJ0PdYw4SZxQeIM7R6LQgeBA/9wkJnZCE1kgxKL2YaUd1
X-Gm-Message-State: AOJu0YzxMKshunSYtgwSAbMR08M4DyBppcWcyTbL2KXVSMULGH4EK7nY
	1MMBZAnoclgpCsxGoIQ1k+26Q3pZO+EFuaLxEbjjLHiLFvPrei4y
X-Google-Smtp-Source: AGHT+IHF6ZPuSk0kgk91RJ7K16gv5yUw2DkiVVYF4+Fqgd7PX6IJ8xGEME+Z0x/y2rTs1lRZLulxNg==
X-Received: by 2002:a05:6a00:c95:b0:70e:9213:f321 with SMTP id d2e1a72fcca58-7106cfcf2a5mr15610008b3a.14.1722966506066;
        Tue, 06 Aug 2024 10:48:26 -0700 (PDT)
Received: from embed-PC.myguest.virtualbox.org ([122.169.160.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec401c9sm7247174b3a.53.2024.08.06.10.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 10:48:25 -0700 (PDT)
Date: Tue, 6 Aug 2024 23:16:31 +0530
From: Abhishek Tamboli <abhishektamboli9@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
	biju.das.jz@bp.renesas.com, nuno.sa@analog.com,
	skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: accel: bma180: Fix dataready interrupt to use INT2
 pin
Message-ID: <ZrJhd7wd5R+GwoYj@embed-PC.myguest.virtualbox.org>
References: <20240805173237.475797-1-abhishektamboli9@gmail.com>
 <20240806173228.264f0114@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806173228.264f0114@jic23-huawei>

On Tue, Aug 06, 2024 at 05:32:28PM +0100, Jonathan Cameron wrote:
> On Mon,  5 Aug 2024 23:02:37 +0530
> Abhishek Tamboli <abhishektamboli9@gmail.com> wrote:
> 
> > Update the interrupt configuration to use the INT2 pin for
> > the dataready interrupt.
> > 
> > Address the FIXME: support using the INT2 pin.
> > 
> > Signed-off-by: Abhishek Tamboli <abhishektamboli9@gmail.com>
> Hi Abhishek,
> 
> That's not the intent of that FIXME.  It's pointing out that the driver
> does not currently support the wiring configuration where only INT2 is
> connected.  The change you have here breaks the configuration where
> only INT1 is wired or both are wired (as it will register the
> interrupt handler on the int1 pin, not int2).
> 
> I'm guessing that is the situation you have is int2 only?
> 
> To handle this you need to add the firmware queries to identify the
> interrupt by name. See for example driver/iio/imu/bmi323_core.c
> bmi323_trigger_probe()
> 
> 	fwnode = dev_fwnode(data->dev);
> 	if (!fwnode)
> 		return -ENODEV;
> 
> 	irq = fwnode_irq_get_byname(fwnode, "INT1");
> 	if (irq > 0) {
> 		irq_pin = BMI323_IRQ_INT1;
> 	} else {
> 		irq = fwnode_irq_get_byname(fwnode, "INT2");
> 		if (irq < 0)
> 			return 0;
> 
> 		irq_pin = BMI323_IRQ_INT2;
> 	}
> 
> This defaults to INT1 if available, but will find INT2
> if interrupt-names is provided in DT and specifies that only INT2
> is present.
Thank you for the guidance. I see that I misinterpreted the intent of 'FIXME' comment.
I'll work on implementing the logic to query the firmware for the correct interrupt
configuration, as you suggested. I'll refer to the example in bmi323_core.c and update 
the patch accordingly.

Thanks
Abhishek Tamboli
> 
> > ---
> >  drivers/iio/accel/bma180.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> > index 6581772cb0c4..d44409afffbf 100644
> > --- a/drivers/iio/accel/bma180.c
> > +++ b/drivers/iio/accel/bma180.c
> > @@ -126,7 +126,7 @@ struct bma180_part_info {
> >  #define BMA250_SUSPEND_MASK	BIT(7) /* chip will sleep */
> >  #define BMA250_LOWPOWER_MASK	BIT(6)
> >  #define BMA250_DATA_INTEN_MASK	BIT(4)
> > -#define BMA250_INT1_DATA_MASK	BIT(0)
> > +#define BMA250_INT2_DATA_MASK	BIT(7)
> >  #define BMA250_INT_RESET_MASK	BIT(7) /* Reset pending interrupts */
> >  
> >  struct bma180_data {
> > @@ -425,10 +425,9 @@ static int bma250_chip_config(struct bma180_data *data)
> >  	if (ret)
> >  		goto err;
> >  	/*
> > -	 * This enables dataready interrupt on the INT1 pin
> > -	 * FIXME: support using the INT2 pin
> > +	 * This enables dataready interrupt on the INT2 pin
> >  	 */
> > -	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT1_DATA_MASK, 1);
> > +	ret = bma180_set_bits(data, BMA250_INT_MAP_REG, BMA250_INT2_DATA_MASK, 1);
> >  	if (ret)
> >  		goto err;
> >  
> 

