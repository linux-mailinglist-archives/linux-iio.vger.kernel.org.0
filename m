Return-Path: <linux-iio+bounces-747-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7325980A2D9
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 13:12:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BF3B20B48
	for <lists+linux-iio@lfdr.de>; Fri,  8 Dec 2023 12:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439AF1BDFA;
	Fri,  8 Dec 2023 12:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WC5AQWzC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD3A1732;
	Fri,  8 Dec 2023 04:12:31 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-5c68b5cf14bso1466382a12.0;
        Fri, 08 Dec 2023 04:12:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702037551; x=1702642351; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AozbGFqEn0GtuaRRztv4dxJBWbiu0FurdKtwmKWIc9A=;
        b=WC5AQWzC+IxPh7UiOo0fZQzXCXyxe4KznMsFpO4jQbNNW4tRlWxKNG0VzI4f4seyYm
         tzsPL/RA/V99x5D5a2oPpmFj2r8QmgMkvmNCWIufiZbpFS0vvFJlyhBpCLJqXMTtfyAr
         InQZ5DEnzd6pCjAmgzWMyTNhng/rlF62VukvCPLOw3nLtJ2mEFTtU3e12SIOaHA4K4sm
         dpMpmNsefmmZ0Oa+T5zFITTZlA8P3WTtTP9C3t0aUDAw505CrRmljQqxQA8GN/shJnU0
         wwWGVMKpb66baF4PZFkIJicsNUSn/7c1ceXwNuCz9Gjp9+47yCbCoDDvbjVuhd81rVUb
         0jpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702037551; x=1702642351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AozbGFqEn0GtuaRRztv4dxJBWbiu0FurdKtwmKWIc9A=;
        b=gbMGykFzfsCCzNpjo60WvxKZ2u8biMRalYfd7cM/0mFgtwinN18vnp1P+DQ0Bmrcs5
         e4SYgEg3ImwlQ73Q5agPm2/HkN8q9HnramJjX7cYigG3D73spFiAjCljx6EOBY5li88w
         h0Q1Rqwoqn46xtTU8G6Uv5rFxW0tSKNAXqkola3FgASyW6uQqv813E2B/NpSpMjWkIs9
         ciwSrTuBSNuO9Qoz9f2Gp2iI0y6vgJleuDH9Rx8w0bdozpN2CSbtqZomL51v4lFo585f
         Dy+MGFAfhqtcSB6NNdqoECR+ImLd9KKjic68DHb7omgaZqBtSpoKaU/4NLxZhNJmFef2
         ohpQ==
X-Gm-Message-State: AOJu0YzmIGQCRt/FxPChb3fjN4rawDmkBtb2wuu3pIDBycOsr1FMTZ+q
	V2BUgQwkuKDE1/fWjrN0RDk=
X-Google-Smtp-Source: AGHT+IFY+/uhWgfKPVe7OXQjSGhKj6Zlc3IpGzetkpzNXo74TJysMAEFAbfeTkg7xg+SRWu3b5k0iA==
X-Received: by 2002:a05:6a21:188:b0:18f:97c:9262 with SMTP id le8-20020a056a21018800b0018f097c9262mr4479155pzb.71.1702037550641;
        Fri, 08 Dec 2023 04:12:30 -0800 (PST)
Received: from localhost ([2804:30c:95c:8600:5b2d:e35b:5f45:dc84])
        by smtp.gmail.com with ESMTPSA id m9-20020a62f209000000b006cb903ab057sm1420826pfh.83.2023.12.08.04.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:12:30 -0800 (PST)
Date: Fri, 8 Dec 2023 09:12:17 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Joe Perches <joe@perches.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, apw@canonical.com,
	dwaipayanray1@gmail.com, lukas.bulwahn@gmail.com,
	paul.cercueil@analog.com, Michael.Hennerich@analog.com,
	lars@metafoo.de, jic23@kernel.org, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	dan.carpenter@linaro.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 13/13] MAINTAINERS: Add MAINTAINERS entry for AD7091R
Message-ID: <ZXMIIbZHvnsqZdw4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1701971344.git.marcelo.schmitt1@gmail.com>
 <b55d378dd8b6dbe787a83b5a0a1f3f05b2530eab.1701971344.git.marcelo.schmitt1@gmail.com>
 <26ceceaec7dfe109b43c8677f74d91c5c893ac60.camel@perches.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26ceceaec7dfe109b43c8677f74d91c5c893ac60.camel@perches.com>

On 12/07, Joe Perches wrote:
> On Thu, 2023-12-07 at 15:43 -0300, Marcelo Schmitt wrote:
> > The driver for AD7091R was added in
> > ca693001: iio: adc: Add support for AD7091R5 ADC
> > but no MAINTAINERS file entry was added for it since then.
> > Add a proper MAINTAINERS file entry for the AD7091R driver.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -1126,6 +1126,18 @@ F:	Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> >  F:	Documentation/devicetree/bindings/iio/adc/adi,ad4130.yaml
> >  F:	drivers/iio/adc/ad4130.c
> >  
> > +ANALOG DEVICES INC AD7091R DRIVER
> > +M:	Marcelo Schmitt <marcelo.schmitt@analog.com>
> > +L:	linux-iio@vger.kernel.org
> > +S:	Supported
> > +W:	http://ez.analog.com/community/linux-device-drivers
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r5.yaml
> > +F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r8.yaml
> > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.c
> > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r-base.h
> > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r5.c
> > +F:	drivers/iio/adc/drivers/iio/adc/ad7091r8.c
> 
> Maybe use wildcards?
> 
> F:	Documentation/devicetree/bindings/iio/adc/adi,ad7091r*
> F:	drivers/iio/adc/drivers/iio/adc/ad7091r*
> 

Good idea, will do for v4.

Thanks

