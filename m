Return-Path: <linux-iio+bounces-5570-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 262E88D6C86
	for <lists+linux-iio@lfdr.de>; Sat,  1 Jun 2024 00:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6039283D5C
	for <lists+linux-iio@lfdr.de>; Fri, 31 May 2024 22:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8681204;
	Fri, 31 May 2024 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X21Mtcjz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221C71CAA6;
	Fri, 31 May 2024 22:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194810; cv=none; b=jxfECTEAgRiIRGCDdrByUZpbJWZ0Vwf5KxMvcqdNwu7BjVK4RXzt99bvDs7DbhciCw8YStfkJu0pEtmUxLU5A8bJbg2LTV9W0FBWhc2erHqD/k0MgwWKWBNEzXsQuaEjUufbhQ849oE9TpPv3U7e/srgNujcKMf36N4PJCK8buA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194810; c=relaxed/simple;
	bh=kPNxWOqffNYweFz1w0R42jipwdfaVcEnOUKmBk/CYAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OIVjK9OXnm7De4lbGnOdYOZfOZzfJ847+knLCVP+7QdJrixtlsKQEj4bKNOJ+nWQlzJep+0+MTNUiPM9s/EDufoJNVy3x3VST2ofpXPU9bE6X/A8gkehb55R/FqxV1hbZeElTz6N8ISik4sts9saUclHVPHvzUY+Ra+UmUQT9hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X21Mtcjz; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1f62fae8c1aso13562535ad.3;
        Fri, 31 May 2024 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717194808; x=1717799608; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MTVn4kCFDkf4PIAody7HhlH/4YGWUj7NrXDBaHmcQqo=;
        b=X21Mtcjzs2AqHE1CqblGd1WIvw+lv2AFpH5ryXOPqkRVO11IGzWuGRfY6odBMdizTs
         1o/G6sFlV8GEBTZekOwweaFAZKU4PFyoS1KMZeE4aXBjww9xNGTeirVkOJ61ISnEJSSA
         4hXUMhHzMkv7XAlP5ipMbXimKeFgEcVgsbi7rIxoD+EdMIFYUfG/JCLXho7qZebkU7hA
         cttDjmtFXKZV3xx20jdgqSxVEp5anHOJTEE2G9+f2ZXTGI3qKTxg5AYmiLcckw9B5WuQ
         6wz5/Wc4ROh3AaX96i08rj9slVEYBvjznS6sRHgH2KNfNKp94Cjoo1bLvV6dOSAdheJr
         u5WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717194808; x=1717799608;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MTVn4kCFDkf4PIAody7HhlH/4YGWUj7NrXDBaHmcQqo=;
        b=MuciGr/qiDRyBOmNWmjzD7D+3B06s2w/mZA42ML226EwAG1PiNS4cG1HBk4OoCmp79
         8nQARq7+axnZkKTD9CloR2H+8jPq2zglo8CiDgDPnFG+13PXLh5xKOln3VAg6V2qcXJH
         SI5pZqgp+zv4dSREiKNNny32xOHJJRFIXas4VdntHaGURhyrMffGsegr/8AjxfUUM15L
         pyCYdKB7qWI+dX3uk/CbVqbVRkIujDmgpGX0XLJS3Krs/xe6gO8FhhE0pL/3qJTi3dJR
         oAoMTnApPW4QdLG3z0jPU/qk778np1kGe1xfNwWzkAcGU2B++l7esyvkdUi2266TpN10
         20PA==
X-Forwarded-Encrypted: i=1; AJvYcCX/ci4w3Cg65XPUsppfZbYbPiYWyEQ0bMk/ZrWNbxeAd4/yftHM4kq4NPf12+TFWEpt58zVA2Pc4f2cL6+a3SJv1mGZjQllw3Y3M4Ci18VulDI6Cod9eMyCfVfFje3zhF2Oak4Pjv1tkmpTVr3Zn7vlkDFC/UVHGZCccsbPt72cuIgvLQ==
X-Gm-Message-State: AOJu0YxC81jg/1KIAUSijoNumO8ZrIUyYVg3FNom2vrxxfPelFpHKb5C
	WiG/bvCmfsQXRPrKE2oNvvrOoP351rVHTJK2pWdxMcH8UIX2WtT2jgqmHrqqeHc=
X-Google-Smtp-Source: AGHT+IHBFjWuB8hFdhRnfjBkt/UJyLwv9fC/QGGFUq6rS2EiqteUwj7E4+QqUPBR7ZYqqD6O8S2qkw==
X-Received: by 2002:a17:902:fd0c:b0:1f4:92bb:6604 with SMTP id d9443c01a7336-1f637005f62mr27952425ad.20.1717194808287;
        Fri, 31 May 2024 15:33:28 -0700 (PDT)
Received: from archlinux ([189.101.162.253])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f8544sm21820615ad.239.2024.05.31.15.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 15:33:28 -0700 (PDT)
Date: Fri, 31 May 2024 19:33:20 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lars@metafoo.de, christophe.jaillet@wanadoo.fr, 
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] dt-bindings: iio: chemical: add ENS160 sensor
Message-ID: <xnxbqzcb3qhbyidnlaveghmw6xm2ughhjbl36f2u3eeybyyogf@o7lhi2raw32o>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
 <20240529001504.33648-2-gustavograzs@gmail.com>
 <20240529-upper-brisket-f326418bcfc2@spud>
 <20240529-rule-asparagus-2e7015bdb50d@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529-rule-asparagus-2e7015bdb50d@spud>

On Wed, May 29, 2024 at 05:37:17PM GMT, Conor Dooley wrote:
> On Wed, May 29, 2024 at 05:36:38PM +0100, Conor Dooley wrote:
> > > +      gas-sensor@0 {
> > > +        compatible = "sciosense,ens160";
> > > +        reg = <0>;
> > > +        spi-max-frequency = <10000000>;
> > 
> > If you want to include this, you need to add an
> > allOf:
> >   - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > above. Otherwise this looks pretty good, so with that added
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> (Please make sure to actually test it next time!)

Hi Conor,

I'll fix it in v3.
I had some trouble running the dt_binding_check target, but I got it
working now. I'll remember to run it in the future.
Thanks.

