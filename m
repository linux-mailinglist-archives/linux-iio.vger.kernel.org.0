Return-Path: <linux-iio+bounces-18462-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A6679A952E9
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 16:41:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 938093AF9E3
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 14:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F43019F116;
	Mon, 21 Apr 2025 14:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nX8BVjRX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FB0D530
	for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 14:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745246485; cv=none; b=G7rZyaSByrdSf7qgUEA1K0oBfJwG5+PXoaIuH+xywR7RgGJZHLw2IpzmTIzNQJbPRL1vIJg3vPhIn0TMN0ApMbRilt0Ndz4LE+CWdXs7/cI0J0yYBZcEAPNGsF1kmz2SS+2GJYH9neCP+XxpLDz7UBu36FKMYzT1arZ+570fmdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745246485; c=relaxed/simple;
	bh=z4hsUjTmgn4x2Qlja9cEIXfaxux3zARdhF55pxlyzno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOtI7dISw3/17CgLmfX8R66WZU4iywpIbmp4SDctYH45V6SmsnBiGx+pHvJqCDkapzQJGByTBWuSpDgmvu+7M8sodhPv+U7r+rxNLTro5HNlCN03lYL4Gk8xMvz2wHB9Scy879YBqF3AwDOUc4i0rsIXBUypxame4rvgTec4TkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nX8BVjRX; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22c3407a87aso60729175ad.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Apr 2025 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745246484; x=1745851284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AThKNvS+LEtPQcQ1zqzU3fyh8P9YMerouUnLdQ5AE24=;
        b=nX8BVjRXfo/4a+6Ipn3Th14fGGQ5cpC78FCEuuHaPvVav6EWLtH4kSMKTW/I9dgzVN
         F3i8T5SMn36U4mU4cioDX6n98p/TJkWgWa0gSY6pBMh0FYlOuFcs4A4lXr7VWMRH22p+
         Ld7n4YTkSUFkBz/MH0mPRZlajW0HgsbpidIZNA8E89VXCK+IsdIklpu5M/vGWnk/BU8a
         gTi5J2ugPoxDvmw9l7L1iUanFDkvlYoInpAg4yHXgjqqm4IOjD/rGmtBQN5L165+6L2i
         Wbrn4qaoUxzlRK3dgBRtswFq6JpXiuBs8z1u7XHeQDwLCOeH8k3DVCXztyhdN7K0K4x0
         369g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745246484; x=1745851284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AThKNvS+LEtPQcQ1zqzU3fyh8P9YMerouUnLdQ5AE24=;
        b=nQbbyDasYW1eHVqObMWnZinag+4/oiAK7kOz14j0jKp7M2l9Oa4xkjGmAnNe66jPZO
         XE0osZittPs0lT++h++b7YdKWoGu4wbKbOR2xeaSj3Tp6JjhwIyTavu7HI0UlkJ4OBHo
         fg5asxmESMT1il2GDxq25wOnWd87zpPKkAuIZdLE/8uzD9Q7TfnBlcKidS23J/pNYgGT
         FOUVJ/QvU+Qb0VmgfLKGDCCXWgjOncoo9DmqIZnkg2crz3gYn4BQ0ZueevDtRKSaTx4T
         h+ulPl4H43EDyCzzKd+NtccS8Cw9oWEyBvMS3DURx7bmCIoekHtFLsln6LZWyx/VVSBF
         vKkg==
X-Forwarded-Encrypted: i=1; AJvYcCVKDRuW5MJMPLeskpMyn3JcLkaq8uYkTtnjFPkSCEXmAba+3b/ZETeynA3TOyOZN0WVdtN97i2sUIw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/dUPawH+FRM8wRGRDGVDbkXyxBMxDnmAFfRjICKKscCbmUa+9
	QU5iNwXJsQtsFTl66/dFhbjOrNc4kMc0XrAjPjn1g1QQ2iu0xhfS
X-Gm-Gg: ASbGnctjDtsELnfqNF6PxzOJ6MK82NitEtFY7o9eJarYfTS5R1/qjXh96RFoOZLyAC8
	WbkPQs/uNQSrS3PeFOXViNCnOtdx0+nf79xK3Gz6YirqQ2Ek4nYTDwFfrpPeqBOo0EzNMuFlVGH
	eAOISWKo20ntgPddt+c5kF5hDXl9ECQaJml/dpUwfB2cRg2wFbJ7dbayffvSaqC6aePueICozTQ
	XAYB0uHoFF3Sl9+0hMcQ6mxE1ka2RR8Td4FF4Yr0P8BaJNAO/sNj94rzlsEdPFztvVrDay44Ecr
	RR7DR4DNr4T1pRUZ6HI5sn488cRdycRQpVOLCfVz66SUj/0=
X-Google-Smtp-Source: AGHT+IEse9mE/oxi9u55vUIQKS5t45jNi6gBD02ampcCDhtuvJtVzIPBeqx8Lq6xJFAQQQDr5oU7DA==
X-Received: by 2002:a17:903:191:b0:21b:b3c9:38ff with SMTP id d9443c01a7336-22c53607e15mr163719635ad.37.1745246483624;
        Mon, 21 Apr 2025 07:41:23 -0700 (PDT)
Received: from localhost ([2804:30c:90e:1e00:5265:5254:2e32:7e5])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22c50ed247esm66500145ad.208.2025.04.21.07.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 07:41:22 -0700 (PDT)
Date: Mon, 21 Apr 2025 11:42:36 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	=?iso-8859-1?Q?Jo=E3o_Paulo_Gon=E7alves?= <jpaulo.silvagoncalves@gmail.com>,
	nattan <nattanferreira58@gmail.com>, lucasantonio.santos@usp.br,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: ti-ads1119: Prevent concurrent access during
Message-ID: <aAZZXKkZxmuYXZl0@debian-BULLSEYE-live-builder-AMD64>
References: <20250419232316.36002-1-nattanferreira58@gmail.com>
 <c2golk6627ybfpw3t7lnerritq2yysi5zhdlvahnvhxoevmojn@j3d2stvivkyk>
 <20250420211706.GB5621@francesco-nb>
 <20250421142359.11fb483f@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250421142359.11fb483f@jic23-huawei>

...
> For debug access it 'depends'....
> 
> Some cases are easy reasons to add this protection
> 1) Accesses can't happen at all because to talk to the device and read
>    registers etc requires some mode change (e.g. recent drivers that
>    can only access config registers when the bus is operating in particular
>    modes, or where we have to use a slower SPI bus rate).
> 2) There are register banks involved. So a single write can leave the
>    driver talking to the wrong registers...
> 3) Driver uses multipart reads / writes (similar to register banks)
>    In most cases this is a device specific thing and should use a local
>    lock to serialize accesses.  On occasion that is too complex to make
>    work with debug so we restrict debugfs access in general.
> 
> Other cases are less obvious.
> 1) Bus traffic in general might slow down a transfer and break things
>    because of timing. I.e. missed samples.  That can happen for all sorts
>    of reasons anyway so should only be a momentary problem.
> 2) They might changes settings.

Does the case of configuration/setting change apply to IIO device properties?
Let's say for example a device starts running a buffered capture with some
certain input gain configuration and goes filling IIO buffer with the data
from the device. At some point while the buffered capture is running, the
user uses debugfs to change the gain configuration. The _scale attribute
will not correctly convert all buffer data to mV units. Would cases like that
be something to prevent? Or we consider those to be fine since a debug feature
was used?

Thanks,
Marcelo

> 
> These less obvious things are a case of thinking it's a debug
> access. We tend to not prevent actual deliberate state changes as that's
> someone shooting them selves in the foot and they get what they deserve.
> 
> So what is the case we are protecting against here?  The description
> definitely needs more information to justify this patch.
> 
> Jonathan
> 
> > 
> 
> 

