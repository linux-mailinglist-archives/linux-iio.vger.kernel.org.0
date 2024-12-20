Return-Path: <linux-iio+bounces-13722-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B62F79F943D
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 15:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BABEF188C8A7
	for <lists+linux-iio@lfdr.de>; Fri, 20 Dec 2024 14:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C26215F7D;
	Fri, 20 Dec 2024 14:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="c3MomHsA"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7CC186607
	for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734704840; cv=none; b=TGbdi1L+QoxYVOE9d2zqiZutCr/zQ10IQz/9pCGF129fWSAIqsub+xd9H2+XkSTqVUoFPVHb+rG5y/L7DafVPIq04JEdy/oSuN+NhncwBuWQ54cIfG8mxPACJ12TbgZ6S8Pct46mGOH0gvhDCMO/ue1MElJAhAA6RXmtJ4qSUAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734704840; c=relaxed/simple;
	bh=LVL3APt8w4ilvr2FlejQYMKKS0B08LDRJeGHPA9hak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMw/6081a/X5IuKIpETPuyZrTZEee4fV6j6A/dsBFRxpvCpunmBDHGKwKA+vMKw+GN+wKHoEaypATQA+JPj6n0OK47Ete/guXi5wfzMEmcK0GP8nNOjCQIsj19Td/yVRLvWpvFHi8iLV8pnIqE4IshcuvqsQbNBG3yOmDyNt+ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=c3MomHsA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43622267b2eso19963455e9.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Dec 2024 06:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734704836; x=1735309636; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8Hj19uI5dcumZ2p5TeL9XzxIcFxbI6DML72hc9BJx4=;
        b=c3MomHsAQYxcLyilPYjTOHHBbqmfNLO4QdUXwlpD/frhvvhDit5Bz/3BmMglTkwCn9
         sGYjNRiM5uTlig9+C1FjmMzY1e97DFhSlFt0c+chleyLHkVL9xBJ5boCSoz8kPfrcGpF
         1svx4qX+xBQLrmzJ4+6GquZyk62E54K0Ixodr8ZyvDW9Reym69dyZ57peNVD7t5Q9eJf
         ta3Hb/8Vmw4mOWohEwj4pWqg1cqSUzbTV9KFAfqAe3LMugtv9CAmKvsR6ZLvL6daPFVh
         TzkBGZDJhDyyQ4O1ZdWNP6GPY8JDgDp8fIEqXqesHDBzRFtTSZ1dJXhxbRLPJmjhuGcg
         PrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734704836; x=1735309636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8Hj19uI5dcumZ2p5TeL9XzxIcFxbI6DML72hc9BJx4=;
        b=pqsMNOpJyl5wlExeud12mRc7OSJAPXk4nO9CrxCJtEcNgpuFKMMkE36E4TcmM/R/vF
         GJF5geLsr3d5phCEKL3qxOdCidUzZ4pRnhFtCQMU4ZTrq71pQpnVR0C5mo6Ct21e3vdS
         dlxNifKWsVOf7b9gRqFdSv38KUzkJhYj9UzPqHKgQDVwQUtgCvs0uJDN6lGIH3ebkBbh
         TYJ6HQpZriM0DXbudAFmQri9goXOBN0O5SgUwgIkMbaUgU5XU8BpBwmc+e/Kdy97AmVB
         unlt1/RWDhE8Xf0k8Rb4hQMiuUi88ldy+sUb7B70wre+24rV5V9Axi/qarq8YyD6ikCJ
         uF5A==
X-Forwarded-Encrypted: i=1; AJvYcCUCa1kG5N092OoES5VXSwBU054/7wHTXKrYyuKfF47muatTsiIfnM70ETc7zcrtTHUNkACin43dLMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3pobVEXKD0+4CaLt1bjkDrxNYKRP/0MJZfmzBNSlIz1EFiVx3
	ZPSh57YAJH4Zd76wwDKqlNHPE2WcuAjfucmXebuMkuzv4Cj5G8T4DIo5vBnOVGQ=
X-Gm-Gg: ASbGncuVWIkbsdDMN2lQXgZF0uoAfhsUgYbs2NMvWva4EqXuOquBy9nyWUWoeZZzh4D
	yPC4M0q0iN8wnnGvylsKMb84HVm7fH907VrKKAbQsR3p8XDg0kMylVwi2Ems1aXeIAGtr/vCh+S
	cucKOL3e/36AyTXZJ9HeMuBXuzVxTd/EC+7BsQQsLbo+ijNG4sSR4dlo1JkTc4DKJHQMDlINGbi
	UjoVUj936Hzrv5CtuRa0fVQOStAJLeR/GOGWvcEqNNNSXWIf9Sx2j2SRLTsXVKfspB8j18jxDAh
	dmi3SwgEDi96sFJ6kCFfQ2M=
X-Google-Smtp-Source: AGHT+IH3EYmzTyANIK4ByW5axFM6hELX2B4oHwpp46jsoFeS8QvzAomgrRoDjnIkEP9BB6wAiK7Smw==
X-Received: by 2002:a05:600c:4f11:b0:435:9ed3:5698 with SMTP id 5b1f17b1804b1-43668b5e09bmr24152555e9.24.1734704835796;
        Fri, 20 Dec 2024 06:27:15 -0800 (PST)
Received: from dfj (host-79-17-239-245.retail.telecomitalia.it. [79.17.239.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43656b11d1dsm81831505e9.25.2024.12.20.06.27.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 06:27:15 -0800 (PST)
Date: Fri, 20 Dec 2024 15:25:45 +0100
From: Angelo Dureghello <adureghello@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Mihail Chindris <mihail.chindris@analog.com>, 
	Nuno Sa <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/8] iio: dac: ad3552r-hs: exit for error on wrong chip id
Message-ID: <urrbejidktwg4sgmsteemmthjk6kl3piljio4bvhntquqoujte@xkty43eqtuod>
References: <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-0-856ff71fc930@baylibre.com>
 <20241216-wip-bl-ad3552r-axi-v0-iio-testing-carlos-v1-6-856ff71fc930@baylibre.com>
 <20241219165446.7b8d0a9a@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241219165446.7b8d0a9a@jic23-huawei>

On 19.12.2024 16:54, Jonathan Cameron wrote:
> On Mon, 16 Dec 2024 21:36:26 +0100
> Angelo Dureghello <adureghello@baylibre.com> wrote:
> 
> > From: Angelo Dureghello <adureghello@baylibre.com>
> > 
> > Exit for error on wrong chip id, otherwise driver continues
> > with wrong assumptions.
> Why? Chip ID does not define all future compatible parts, just the
> ones we know about today.
> 
> The reason not failing is that the moment we do exit on a mismatch
> we can never support fallback device tree compatible IDs.  Is there
> no chance that ADI will release a backwards compatible part in the
> future that we'd like to work with old kernels?
>
> Any mismatch in DT vs hardware present is considered a firmware
> bug, not a kernel problem.
> We used to reject missmatched IDs but after a long discussion with
> DT maintainers it became clear that broke their model.
> 
Ok, i will apply to what decided so.  

> Thanks,
> 
> Jonathan
> 
> > 
> > Signed-off-by: Angelo Dureghello <adureghello@baylibre.com>
> > ---
> >  drivers/iio/dac/ad3552r-hs.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
> > index 8974df625670..e613eee7fc11 100644
> > --- a/drivers/iio/dac/ad3552r-hs.c
> > +++ b/drivers/iio/dac/ad3552r-hs.c
> > @@ -326,8 +326,9 @@ static int ad3552r_hs_setup(struct ad3552r_hs_state *st)
> >  
> >  	id |= val << 8;
> >  	if (id != st->model_data->chip_id)
> > -		dev_info(st->dev, "Chip ID error. Expected 0x%x, Read 0x%x\n",
> > -			 AD3552R_ID, id);
> > +		return dev_err_probe(st->dev, -ENODEV,
> > +				     "chip id error, expected 0x%x, got 0x%x\n",
> > +				     st->model_data->chip_id, id);
> >  
> >  	/* Clear reset error flag, see ad3552r manual, rev B table 38. */
> >  	ret = st->data->bus_reg_write(st->back, AD3552R_REG_ADDR_ERR_STATUS,
> > 
> 

