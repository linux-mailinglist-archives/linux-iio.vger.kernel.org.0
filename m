Return-Path: <linux-iio+bounces-25635-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB32BC1DA02
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 23:53:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CB2C422F49
	for <lists+linux-iio@lfdr.de>; Wed, 29 Oct 2025 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F7432E2661;
	Wed, 29 Oct 2025 22:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="niecThrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9C2E0904
	for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 22:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761778424; cv=none; b=jhkf9Yz8MvCjKA1jkHo6HpOY6qN8bHxCBYtsT3ODPLMZ3yuGHnxMYYngZqCUGPSJU25c/Gh6QTYK1BMpIxt2ut9DOVPVmKbFXh/g7qfqeltoYfsQSaciM6lzpzjkkLLchIjAgZsxTD0CJcoH3LaxsS3vfHyBbCX0sdNGX8UnZ9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761778424; c=relaxed/simple;
	bh=6afH+QhCPNPbHmf2zzXPVjLSY3IrDgmnwd+wzSW/Pg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETWARHdv0CASTS6SgODCEjGHD0miliHNZ5QnZRc46qH00XWileeBgJOL71MWoZMtBNUVjsgu9pzGbX0xvpWj7L1jbSRLx7/AGc0BgBeo7bnzFL90smTGbHkPShIKQ1/n8Yxt/+KlJbP3riM1S07cbyITGtGwRoRVnvYJJkUN8Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=niecThrT; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-475d9de970eso2668935e9.1
        for <linux-iio@vger.kernel.org>; Wed, 29 Oct 2025 15:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761778421; x=1762383221; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtKJsiXDL751j5BdlDwZfCkv3rUdNfZTZglnQO4jotg=;
        b=niecThrT6nrPkfXWmj0Ch1azJWpFTeUmYSAsRCgDaoKOV6tHmoo1cd3NiOc+8iT+GC
         xLUAfsV3PEeHDLqBJI21txRNZK5vtDP+TbZwS1/9HOVCYEFuK3nxNoEp7f8URqFUsNWl
         LU3gaN92mkzMd7Z3Ows2AyEN/PD1U2ShI+rBWUKkvVIcQ4HKM/u8Qzj/giSS6TPV2d3c
         Atc/0imBB9w7p5t2w44+Au2Q/2sMoFc8ah4RnmZnpwRDfDjTJBEQcvGRwWTJiXQqGz7m
         J+bnazlRPDWnA5wBOTZHQ4SKKEyyV0mf1jkbSB65bm62bCNzmpl3jpM9WN+K2mqxSSBz
         9LtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761778421; x=1762383221;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtKJsiXDL751j5BdlDwZfCkv3rUdNfZTZglnQO4jotg=;
        b=kjN38SZxcT0lmcpXSLybAGZ5s1ofUBWBsTJLmGMBkq3VjaM9vg8RdrpjQrNKpkMOej
         Vb4wM1nhZ0g/XJcFXFZKaUmtI9kuriRLAHpsl5BD6N3X6EFuTbsa1xwj1iM+z/pF21rJ
         qIKC+kh3BIUhjtALstU4Ac7dkwiBl0q5+iPJe+Lw1ajcNIFr1WDTTi1qOBfEPhosEz8o
         U/k7/KkPTpzr2DVTe+OchZyWAqiAauv32xGh1lA5bihWXJTR6j0RnODknuC6Vvj3SI7R
         uyel2evTE8gk65+5/+rCea/T5rgA1mvUyaUMKh1Fu+CqUogYjii4Yl8003cqXEcwLHiC
         M/DQ==
X-Gm-Message-State: AOJu0Yw81G4IrFDmNEUXB1M+DW3fklIfIBwm3bErUiJ6lFqwLz6NiTiB
	ZGRnKpgu1VLp7slIj0Pyjv042ckItvoGARMJ9bInaj3WCCJXBxPiU+CK
X-Gm-Gg: ASbGncv2sLdz66akV3Q79eXODLiyLp+mCpjO1yiKgaOtr4ef9yRcX3uhq2lGkJ00/8E
	cX9FQ25/Z5ShqVhr5T0nbBJWHqubOg6yjbNVuHCjTy+4gPLDoucqpJr+RABWXkMvC1bBsQEM7TN
	+Lv5i+5mEfdUYtYjbgoimrpYqZluIvTQ5YmSwwaRLxn9eMWqFFewV8WdyOI1xS7dyi0z9uumTxz
	+sZppSMJrm6Ti7bticx2nMPc5iPkX0789tzkbVi2IrsetoUyf+sZIp8PTo9rT6aKYAid6jE9riM
	tfzc4yJtvf3yFjh9yjrqO3IpjKLG7ObPqBTelaYdEiPXlxOMkbB9/CUliIKlCUkfsxmN0s8E/Fh
	zlG2QzRieAE78GpM6GnYoIf7pgvE6MeJtx+CIJXNYL4FBq1FDHLA/b+4vMYcEfHzIQ/cP1umtb/
	F4m3ovstiuWEJuVwAGxKNWyPw=
X-Google-Smtp-Source: AGHT+IFl2QPmnw6vWzhlAk8MgN3iqddED++bTzbKLRdW8yHZMNja5zQqoc+eIa1FwXkZ8arwijkLXA==
X-Received: by 2002:a05:600c:3b85:b0:475:e007:bae0 with SMTP id 5b1f17b1804b1-47726736870mr7650665e9.16.1761778420596;
        Wed, 29 Oct 2025 15:53:40 -0700 (PDT)
Received: from antoni-VivoBook-ASUSLaptop-X512FAY-K512FA ([78.211.131.34])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a7csm28660606f8f.8.2025.10.29.15.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Oct 2025 15:53:40 -0700 (PDT)
Date: Wed, 29 Oct 2025 23:53:29 +0100
From: Antoni Pokusinski <apokusinski01@gmail.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: mpl3115: add ctrl_reg4 to mpl3115_data
Message-ID: <20251029225329.w45xcszkmaaygogr@antoni-VivoBook-ASUSLaptop-X512FAY-K512FA>
References: <20251028213351.77368-1-apokusinski01@gmail.com>
 <20251028213351.77368-2-apokusinski01@gmail.com>
 <aQJM6u9pGSdds0X3@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQJM6u9pGSdds0X3@debian-BULLSEYE-live-builder-AMD64>

On Wed, Oct 29, 2025 at 02:20:42PM -0300, Marcelo Schmitt wrote:
> Hi Antoni,
> 
> The patch itself looks good to me.
> I just wonder if it would make more sense to squash it with patch 2 since part
> of the code here is changed again in that patch (the mpl3115_set_trigger_state()).
> 
> On 10/28, Antoni Pokusinski wrote:
> > Cache the value of CTRL_REG4 in the mpl3115_data structure. This is a
> > preparation for adding support for the threshold events.
> > 
> > Signed-off-by: Antoni Pokusinski <apokusinski01@gmail.com>
> > ---
> >  drivers/iio/pressure/mpl3115.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/iio/pressure/mpl3115.c b/drivers/iio/pressure/mpl3115.c
> > index c212dfdf59ff..4cc103e20a39 100644
> > --- a/drivers/iio/pressure/mpl3115.c
> > +++ b/drivers/iio/pressure/mpl3115.c
> > @@ -83,6 +83,7 @@ struct mpl3115_data {
> >  	struct iio_trigger *drdy_trig;
> >  	struct mutex lock;
> >  	u8 ctrl_reg1;
> > +	u8 ctrl_reg4;
> I think this ...
> 
> >  };
> >  
> >  enum mpl3115_irq_pin {
> > @@ -376,6 +377,7 @@ static int mpl3115_config_interrupt(struct mpl3115_data *data,
> >  		goto reg1_cleanup;
> >  
> >  	data->ctrl_reg1 = ctrl_reg1;
> > +	data->ctrl_reg4 = ctrl_reg4;
> >  
> >  	return 0;
> >  
> > @@ -390,12 +392,15 @@ static int mpl3115_set_trigger_state(struct iio_trigger *trig, bool state)
> >  	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
> >  	struct mpl3115_data *data = iio_priv(indio_dev);
> >  	u8 ctrl_reg1 = data->ctrl_reg1;
> > -	u8 ctrl_reg4 = state ? MPL3115_CTRL4_INT_EN_DRDY : 0;
> > +	u8 ctrl_reg4 = data->ctrl_reg4;
> and also this is changed again in patch 2.
> 
> I don't see much advantage in having it separated from patch 2.
> Might be simpler to just squash patch 1 and 2.
Sure, I'm also in favour of including all this in a single patch. I've
send these separately thinking that it might be slightly easier
to review this way. Anyway, will squash in v2.
> >  
> > -	if (state)
> > +	if (state) {
> >  		ctrl_reg1 |= MPL3115_CTRL1_ACTIVE;
> > -	else
> > +		ctrl_reg4 |= MPL3115_CTRL4_INT_EN_DRDY;
> > +	} else {
> >  		ctrl_reg1 &= ~MPL3115_CTRL1_ACTIVE;
> > +		ctrl_reg4 &= ~MPL3115_CTRL4_INT_EN_DRDY;
> > +	}
> >  
> >  	guard(mutex)(&data->lock);
> >  
> > -- 
> > 2.25.1
> > 
Kind regards,
Antoni


