Return-Path: <linux-iio+bounces-9133-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FECD96B88A
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 12:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 936BF1C21838
	for <lists+linux-iio@lfdr.de>; Wed,  4 Sep 2024 10:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCE901CF7AE;
	Wed,  4 Sep 2024 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY7vWZlk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311F71CEEA7;
	Wed,  4 Sep 2024 10:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725445802; cv=none; b=WhEQs7vVw9SknQPEUOJhRkTg7LuZaXSzL2BoMgKW+62rJVY1yUqzffPSVdElsgXw1SJyBPyTiuvJmXST2Gw2F8jMRhjhUZJC4cwwFTcSOGnxDBY+ixMYIl9ROXsy8PKtmLYQ09B2J7iGA33AxNhPsYOG6zc/2l/195iLwbwPd8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725445802; c=relaxed/simple;
	bh=njGhOVEqs2VZKM3uyKmQ88RTiGLqN04rQTuxJVN0iPI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8SVLJLoRQwWgHkiq+dLzwJNApb0Jv703N6NPTZBdp9MAsbbCDfkbdXCx4u56Akf/PjCeoNJc64VSaItyZtYaIekk8KlYFZjPX467jASPP1cblGlmSjsvk2RqYF0yxoHsRSHU/ZL2uxSPytgu1vC6vWmQ/FS0RvU8s6o3pf3rzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY7vWZlk; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c3c34e3c39so546856a12.2;
        Wed, 04 Sep 2024 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725445798; x=1726050598; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nihBU/J39u74mRlIxma9Q/V3h+KUj+7kdXU2a336JmA=;
        b=PY7vWZlk+ly0HFBSXpDDednPEWf/Xs+74MgPMuDf7pQf5R31zR4zquE5OwrErskHfJ
         3dFH7b2tttpb/6HmxVNY/YGvdc9PceAJm9DjFPE1/qq1Y+R+kqvjsobWInLlVU18QPl+
         VTHp8VIKiApJNCUsa1TunqlENiizNNr3OFqQZO8n13w8ZwAbTRdTMe0A0fxtln0HxW5t
         KLpszyvIygODxOlfZq+JIM86IrXUY8aMnpZ3h/pBe2r6+eppfIg/VEF8racxyntek0CF
         WXkcGmMdQNnoohKb1kCXwGnaDbgMWyW36zdJ6IFt3bxYTO4McBAXA+mCoh0MJaIea5jE
         xcMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725445798; x=1726050598;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nihBU/J39u74mRlIxma9Q/V3h+KUj+7kdXU2a336JmA=;
        b=w0/OP11+3LAdpss1cS3v5+Fh1R14z2o9qMLdjYTCsdrweY1hG9b2yupvQ1jgLNnA9j
         CtPj0oZXbNPceaRLDDijfb0tOqbEum4P+IxxpQOYnJp6bLxAjD5wkN4Q6G/bI6OJpuc7
         5koZr/UqN/hnMtdtieF5b961q/XeSWqqIWUIpEqH6QLRE/k1zGVL8cYTYNLn/mkKGObu
         LRhqajWcPVFy3gjexkCbqrTAUt2e3OqmHaPrVpU8L/EOrM5R3PcHRRlawCE22NPRhr+W
         LA6wU9kTohkpJZTrCrZuj1TX2SqZ3kOdn8dmOPTeaGEv58/HnjYhB+Vp3kxITK6WcNlt
         U7Qg==
X-Forwarded-Encrypted: i=1; AJvYcCVQUIYGZ3/iVBJP2zoiflAtwz37W3LdUKJxIdF8PuSQzLmw7Lu0URnJyys9KLB7DYKXjqxe7kqhyjW+BI8x@vger.kernel.org, AJvYcCWDUjHq/gjcWDWwWywdLpsTzt0oZ0g/+3efPoz9gJKwjSsnoyHKS1aqL2iEOSoZLOyR57ctmNdT3hiz@vger.kernel.org, AJvYcCXu0F4yOsI/G4VfmhhsDkU2EGRC2F1MfqeiW6oDCxifBldJymBoPYoOzOxeEZ02OMpTo4l9yHOaWkpW@vger.kernel.org
X-Gm-Message-State: AOJu0YxHknziIxakRz55BOmZny/eNd4AS+bwi17qcmSsXMcuVXm6bLn1
	dcu+8/2L3dI8zyvKMc5L+dPOWvuSEzCsn8s1TRC29tuM15sp6+0V
X-Google-Smtp-Source: AGHT+IGP9esbSOn/3d7EfoywFr2wYtF4EOUSVynakrKbTMZYY6Eo65iN6z1a3fexsUAAv8j9yMP+5A==
X-Received: by 2002:a05:6402:5212:b0:5be:eb19:ee56 with SMTP id 4fb4d7f45d1cf-5c24377aa7emr9129464a12.24.1725445797557;
        Wed, 04 Sep 2024 03:29:57 -0700 (PDT)
Received: from vamoiridPC ([2a04:ee41:82:7577:2f85:317:e13:c18])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226ccff17sm7349081a12.73.2024.09.04.03.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 03:29:57 -0700 (PDT)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Wed, 4 Sep 2024 12:29:55 +0200
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, jic23@kernel.org,
	lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 0/7] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <20240904102955.GD44250@vamoiridPC>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <ZtcfCVcV_1hCVp7N@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtcfCVcV_1hCVp7N@smile.fi.intel.com>

On Tue, Sep 03, 2024 at 05:36:57PM +0300, Andy Shevchenko wrote:
> On Mon, Sep 02, 2024 at 08:42:15PM +0200, Vasileios Amoiridis wrote:
> > Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> for the patches 1,2, and 3.
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

Thank you very much for the reviews Andy.

Cheers,
Vasilis

