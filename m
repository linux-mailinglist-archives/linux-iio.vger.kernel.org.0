Return-Path: <linux-iio+bounces-22491-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50415B1F4CA
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 15:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D74A189E9B4
	for <lists+linux-iio@lfdr.de>; Sat,  9 Aug 2025 13:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084FA26E711;
	Sat,  9 Aug 2025 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZKabPf3S"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A39D1D61BC;
	Sat,  9 Aug 2025 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754747478; cv=none; b=hXF9VLPbIMEz3hveV1Joy6+EkYTG6nF1wpGpN/0hQdAeAr1I260Wx7lPgiH7hlrps8uARECTKC2DBGxpsQIj+ktwfGwU/+K69LyRc4qtrHBSu+cETZg56laZZuVxPmIq3oI6jakrLR8OyMBMvYjk1x1KCkVR6dY6BIpW8HEz/kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754747478; c=relaxed/simple;
	bh=1CkWIYU9TiZBzPgfU8euPX2L38utanqE8VHj514fMNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3F7MqehGGLcJS91ttKHLfk/d7rSvUNUeziDnSbBTaSLw8B9oTY+011YoyCW12WTALgjo/9rm4UrQTFEF7HNnR7MYIURm/20MxJIh7Iii0dQ5rve7PRaHQQACj7DL6kFki0Am035erK7qQyPUr5UTnSOgProKcmJs4e57aneD/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZKabPf3S; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-76bc55f6612so2899534b3a.0;
        Sat, 09 Aug 2025 06:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754747477; x=1755352277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PHGHdetss61Sc0mfujVjdXkttn0zgYYmgZcXGuGxpUg=;
        b=ZKabPf3S4p1OaYeMn9a19xG1vnT8OQU46TEsMKlzNTvebeY4h+byQWWUHPMH7CZUFD
         /m1798jjhWhmsqxqzHaNhTWmoFOkDkNNYcJiQ27+mZf4LfccB3q4JCoL8oWqvfBJEqH4
         F9omC5tSJ5RegUNxsBYDoaa8nYaDQz3Iu/qnEQ7m6/+/qpQPBkWa3CPi/9Ft9F7YtFoF
         J90cF4HKBB8TAyRW1OMA1ts+1p3ivKqBmtT4ttJz4DUrZwZe07Nz4fVo59Goo+htYxwb
         FgNzAJNEsOx0Y4FAMT/gXng04Ozhv5hWB4nCBBaZOBAjQXZWfub8kH9SAuyTzyjaY3Jz
         n9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754747477; x=1755352277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PHGHdetss61Sc0mfujVjdXkttn0zgYYmgZcXGuGxpUg=;
        b=DNq4skin3kVsTlMZLjcmbSh2Blvk0rh9rWMSZtTDaHvA5e7BEG1T1T7XjEoomDSZxO
         UIlA+YaYMs6lLVEPlFyM6HbdEIxf3ldFZnVwsIEe0PnTldQpgjrmujuXdl/P2Crk9sas
         kFP1byPI4XxlWdhdhEgWQ5vOwbyrJHhXAdy0CtzjRsjW6cpIPPkKHJTYA0W6KXR8TiU1
         4ha71nnXtsjF7RZbJWeqsjZU90yaDf1JjReL2XJIrN7I++5R6NeNw6+FARtT1Huuki6X
         7iQLr8rOCTdBgcVqyLzayNL+33pVofH+FFTeuyfnq8eG2V/+ke4Qir8apxuTVrsmns4d
         yjQg==
X-Forwarded-Encrypted: i=1; AJvYcCWEOMtL/PcxDO0Ub+P9x85YY4Bc+EnPwKbJykNmcrIXKA33rKux+eaM6A7HwCGEzxQgrlGpVjPOj0JutbH7@vger.kernel.org, AJvYcCXMYxTgRBK9ohe7SD+uum8STedL0bRN66AJWv3er1Yq9syKm7zUmAj00vk5P7TBJOdelRrr/5QDxeY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs71jt0fUfEHcuSgQymPw0r6sRp/IwdYvOTr72r0xeGYX/cZYR
	Zo435fIA6czMVnfjDf0DsA884zYYSVYqZMH4Bmhg1JEz/7Tj70E5ZnjS
X-Gm-Gg: ASbGnctxouqqnpnQUaOI1/dUQo2D1siXATlWZZh/gLkz2p3O1rlK1qhSl3qdGeo/Y6T
	tlfbnuWrcyb1VcxY+9itChzuHGXgUqlxb7H981cmZlhQD8HIdyap2kdk6gRopm9NR85wig2wfMs
	LF3srZaXvbwiJqs0WnLa6RG81+LByOop1Drlz6LuLSjcoOBRgCmwA8sTV44590+ZQWKxI/pF5cI
	eLJrI9ZjrwWLwnq2KYou4F5elgY3hIY21Pp4AiPAzUItbb69KAYw6tRjno6hAn5nhEekAR+jEBZ
	R3DXvK29vKWFlHtP7byXLaznnM54sH1Yo/RMJSmrIJ0RNcGWe4dzUeLPpq5QimeMCpHFBL9iIwT
	xrucwMEPmezcVvsORPc5/ZH2orgF4XIIaoYVGYm/JNA==
X-Google-Smtp-Source: AGHT+IFhwSyIVLsc0VjIyhOgFApol7RJrQu8U52Gnc3jHjzczZ/isefoEOSJP86rPX6uNN1evgBA7Q==
X-Received: by 2002:a05:6a20:2444:b0:240:1dca:d144 with SMTP id adf61e73a8af0-24055558e7bmr10966679637.8.1754747476695;
        Sat, 09 Aug 2025 06:51:16 -0700 (PDT)
Received: from localhost ([2804:30c:1f50:da00:c6fb:5400:5af6:282f])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-76bcce8a838sm22718366b3a.32.2025.08.09.06.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Aug 2025 06:51:15 -0700 (PDT)
Date: Sat, 9 Aug 2025 10:51:28 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
	andy@kernel.org, dlechner@baylibre.com, jic23@kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH] MAINTAINERS: Update max30208 maintainership
Message-ID: <aJdSYIv8_QX0WwdI@debian-BULLSEYE-live-builder-AMD64>
References: <20250808190203.7493-1-marcelo.schmitt@analog.com>
 <CAHp75Vc1KgiDUUEjeEKdrSfom6NThPG-383O=sezydnrZLoGqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75Vc1KgiDUUEjeEKdrSfom6NThPG-383O=sezydnrZLoGqg@mail.gmail.com>

On 08/08, Andy Shevchenko wrote:
> On Fri, Aug 8, 2025 at 9:02 PM Marcelo Schmitt
> <marcelo.schmitt@analog.com> wrote:
> >
> > Update MAX30208 temperature sensor driver maintainer.
> > The previous maintainer's email bounces and no longer works.
> > Also mark the driver as supported.
> 
> Reported-by:
> Closes:
> 
> ?
Reported-by: Dave Hansen <dave.hansen@linux.intel.com>
Closes: https://lore.kernel.org/linux-iio/20250808174901.4556B33A@davehans-spike.ostc.intel.com/
> 
> Otherwise LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>
> 
> ...
> 
> > -S:     Maintained
> > +S:     Supported
> 
> Just curious, are you really having this as a day job task?

There is a request for MAX30210 support and so this driver may get extended to
also support that part. Though, even if we end up with a separate driver for
MAX30210, it feel unlikely to me that people lost interest in MAX30208 
as that's still in production according to MAX30208's page [1].

[1]: https://www.analog.com/en/products/MAX30208.html

> 
> -- 
> With Best Regards,
> Andy Shevchenko

