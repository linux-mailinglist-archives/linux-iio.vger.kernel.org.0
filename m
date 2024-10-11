Return-Path: <linux-iio+bounces-10473-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D62599AC49
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:04:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB4D1C258B3
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA911D07BB;
	Fri, 11 Oct 2024 18:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lr1PVRSC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE101FB3E6;
	Fri, 11 Oct 2024 18:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728672917; cv=none; b=OVTJD1t34LLPR6rLyWzsOcVTmjvesPk+8Tfuv30xOWr8LNNT8R2vOKqEewWAELVG4gJVLO3FzklLl6VVYgvLxRwVNZ/aVr+0zpgRIK4Eu92YOM6kvnnJDbqRFukqGaW8+0KvBJE8s91XeV+GCupDG2HP6SAzyrU59nRi3P7gxz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728672917; c=relaxed/simple;
	bh=avUie1XybX32xCpy0BSDmElObaD3ApfTk5kqbXM06Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u72NNAV3SeYuNZ2JF0/2fCJNFPAfFHZXz1RdQoll+9zAQURSK7wWiQnj3vtz8i7WpfdCkZXZnFmc+3iQ8SbsSZLR53PYEu2/zcykkWQ1Ey92L2UspBDN/NJNZUocD2pPF+qRekPIY2u4K/DTw+eSb6x/WzZAEAKKUZgJKgYihyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lr1PVRSC; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-37d461162b8so1467206f8f.1;
        Fri, 11 Oct 2024 11:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728672914; x=1729277714; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RFJCa2W/BBibS0dH25Sv8O9GKK/u5oDUJ14JeWn1ZDk=;
        b=Lr1PVRSCar4qV9igRt1XvRpMDVC4rZpcqmF00yKarYqiXqf6z1E6rWP/JQCIbpF3cB
         ILD3FAPeWahzV9XhDhQ3Hg73ox8eCygZAdkgM+OV/Z4/5IWY2574USGC62vzmNhAe97a
         jH5ZN9B0brakiSffhiA01Oqcn9a6UsUOzrhK0gAcSTfwifepYjIN5jS5ZeF9Tj/mwMxD
         4eD5R9V16/2DZu9X8iG1Ogu6Y+eulRKv0VMrIEICOOWSnEYgRvtS1Y+utmmGRHF/Sjeg
         xj/zM9ljWqiSnuvrxxzL4UmN3UwzV8af/vIixdNqgsjXKhQMDGGRlVaKRd3puKJsxSfM
         ez+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728672914; x=1729277714;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RFJCa2W/BBibS0dH25Sv8O9GKK/u5oDUJ14JeWn1ZDk=;
        b=auvwxnl4r1NBskzODQc8FQfkvpoFuFRpyuPlGh4qp+XqidGe5f4HQgKZWJO4wcQJ0q
         TdxRuLgnioMelFWv5Tyb2goGBUMkbhSMuOpYmFati/Xm3djbj+g7moA24BbDePRTpn0/
         T+m2Rqq8QMBCGGe/xODzpOWfngwD99ox1yC5TXXBILie2Au+bKqA063D5279kvLB7Za3
         SD9vdeA+iSyWqM2i7fDyvgrl3BM+7LVoh9HvcXIardnJB9DaYCG1qaR5o3GA0QQUsHTn
         aHi3HvZUxaxNERmKpcpQrf2xZmr7ys3cGjd2JmvynPJzTqRUWcdvb2DYrQzZz68JUpB7
         Xlvw==
X-Forwarded-Encrypted: i=1; AJvYcCUEgtHOTNTmU2gE0j11ChzqbAETGvZWw2Fdoexo/eAv2aE3EVwBXXbje26ZlzoF0G+0DhkA4gTSR4cu@vger.kernel.org, AJvYcCWmpA5Empc2f9UtSFG6/91qcE4vfBLWCTYr3OH9OEjDb7nEgmclboJYAv2xquM+THXDQ+tfgYCrqCNSA2wm@vger.kernel.org, AJvYcCXco3lrzo5y9U1m0wu4Xoj9C4U55UVxQctPVkzjqwHCl1vkUfV1A7glpkSjBNiB8v2kIAZ3DaVsjADl@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo8fIlP+Op7fAsLrm1gtrAPmYbH2PMdA63XgwPp1ahz/l9perc
	+WIT+ieF1CVunXQBNC6uaxT7sXETHI94Tl+bDLa/jndDDWGfC7zxPz9bDCmbKnE=
X-Google-Smtp-Source: AGHT+IGWWbqipErwdC8aIJnZ5+k1L8L0vs8BTHdd1eokxSO7fFyjeJggJP8WsHXDwUtLi/RRbjhaNA==
X-Received: by 2002:a5d:4490:0:b0:37c:c80e:d030 with SMTP id ffacd0b85a97d-37d5ffa5accmr449633f8f.53.1728672913663;
        Fri, 11 Oct 2024 11:55:13 -0700 (PDT)
Received: from vamoirid-laptop ([2a04:ee41:82:7577:73c8:39ee:29b7:ae8c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6b8d13sm4541928f8f.25.2024.10.11.11.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2024 11:55:12 -0700 (PDT)
Date: Fri, 11 Oct 2024 20:55:10 +0200
From: Vasileios Aoiridis <vassilisamir@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, anshulusr@gmail.com, gustavograzs@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 07/13] iio: chemical: bme680: add regulators
Message-ID: <Zwl0jmF093JHb2aE@vamoirid-laptop>
References: <20241010210030.33309-1-vassilisamir@gmail.com>
 <20241010210030.33309-8-vassilisamir@gmail.com>
 <Zwj4Unpcq2w7V4eq@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zwj4Unpcq2w7V4eq@smile.fi.intel.com>

On Fri, Oct 11, 2024 at 01:05:06PM +0300, Andy Shevchenko wrote:
> On Thu, Oct 10, 2024 at 11:00:24PM +0200, vamoirid wrote:
> > From: Vasileios Amoiridis <vassilisamir@gmail.com>
> > 
> > Add support for the regulators described in the dt-binding.
> 
> ...
> 
> > +static const char *const bme680_supply_names[] = {
> > +	"vdd", "vddio"
> 
> Leave trailing comma.
>

ACK.

> > +};
> 
> ...
> 
> > +	devm_add_action_or_reset(dev, bme680_regulators_disable, data->supplies);
> 
> No error check?! Why?
>

You are right, I should put it, I probably didnit see it!

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Cheers,
Vasilis

