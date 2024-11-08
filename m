Return-Path: <linux-iio+bounces-12023-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF939C1990
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 10:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9633E1F24237
	for <lists+linux-iio@lfdr.de>; Fri,  8 Nov 2024 09:56:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD141E1C02;
	Fri,  8 Nov 2024 09:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKn1UdaM"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEDD1E0E10;
	Fri,  8 Nov 2024 09:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731059801; cv=none; b=fWVG3CxOF920pnya6GefYlqrNB+J7lVdR1dm50xz4SFgss5JRyamzlHoPZQK8+EoaCzxXoTXHyBk2h0/AHFc4cmUGad3ycH/XjQIcXJu/hD3h41iSm79/txZBjpFm5s0gyVmR5W4TFgwxEgwAYsnCvTJsvweKVwu2lBbr7RrRHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731059801; c=relaxed/simple;
	bh=hYaMho2xmCZaKDNeS5BXAfI2dUcDW/vxWs5iXQ0WFAE=;
	h=Date:Message-ID:From:Subject:To:Cc:In-Reply-To:References; b=BVSs5BEmpfhaRh1uXYREBRZPMXL1EHmNs+Nx42OnOBmnxQWl2EF/LFX8L/xm/fj1Pv86fyqtWkFh9oKQWp7cqqcmjBqX+YojTF+mtGosc3Ajc+0KKIRRUo8r7zJkiInqaGRiIn1ZEMu3ZgH4OrujS4pmFyh+htOp4c0Bgi8ozFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKn1UdaM; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-37d6a2aa748so1168088f8f.1;
        Fri, 08 Nov 2024 01:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731059798; x=1731664598; darn=vger.kernel.org;
        h=references:in-reply-to:cc:to:subject:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aAr6sgwxPDvgR7Ievvwf3Fx3Iaha2fuCw5YJazZVzW8=;
        b=mKn1UdaMxVYA+LeBiI4Yby1Sm+COMtiim+d6ICoRaQfqVdHxPs6IT58YvJa5ClLm4s
         NxVEkXADrKsIkg+Gu0lHiOynoREsgBhyhhlaBQ49CLq+SjPw/I9Htl/2lYeLYuhu3jhh
         D/843gyeUikprzPsvLZrpsz2pXQmE/BftH7oMC0iRSQg/CFac6ZgSL1QL3VlwRHg9Eck
         Qu70/4Q92/dEOg9A5Es3R1JsgGtspWPh+7x86sd/s+JyhmNA1BTtyKt52EdD5LYR72LC
         zAuczp5s0sCn7lGC2EAfECUu9Vg8jgXASJq4rcupVjOfU1MbgJGKjD1dVCTCkpurTbTe
         Qk4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731059798; x=1731664598;
        h=references:in-reply-to:cc:to:subject:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aAr6sgwxPDvgR7Ievvwf3Fx3Iaha2fuCw5YJazZVzW8=;
        b=rbGRTBVBJNhEdmh+TGKtXhmoLkwE2bwJy45xx01Bmla0NRHX01aIi+/we1d0Tj91Dz
         MhzrX3jnkMnn8y+RQ2rBBnpixPmX1Ij03xY+d7nkvphQ7X9Hw6buHgAvGVTT46KOpAMx
         f6xiYjM0xvnp/MJ6zHFJvh3Dubo2vXlzIu9Aq8/AixtsLt66yUqEwCPljR4EYTsBu3Uv
         RaLLVdU+UhfZYnk8RAwn6/LyDcSA2DesFaoHl4r2vXQY0jzot1sfU1qP5oLLE02S1NeZ
         7TNXYwxHDIGGf3zxlfAX/Sjdq3ZoOkrAyAls8fFHhpWF4oLELl/UeDvGpDb8QOLm6Ix1
         UNsw==
X-Forwarded-Encrypted: i=1; AJvYcCU2cOUY+MQ5yhyuYFRm53SbyxxQGRLm3B8MeScP9hWHGW6F3ISLSlbmlUFsM1lPg9o5j51WKHan2X//gFhI@vger.kernel.org, AJvYcCW+Ih9QUS8nIa1gI37r8c48zCqrNrTzYCf0CSD2D93UGkXTxxLkF5KNkQSfjIw5kMRPlc8J+gBslC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESSkLgR4WdFCk/bQaN3t0AIcXFqB7oPBBqMCT0nACqYI2vAp4
	fRwPBz8CVAw4Tatl5FYoxOTCB+k9pqTkHk1A8owypIqGhexzz4Lv
X-Google-Smtp-Source: AGHT+IGoDRHZCbSpROoPOD3gnGRQWfsnf1DfpZ5BkN1VKMg3Ug8FJSJ5FYWfqj5MZ0fcRSw+0nzdcA==
X-Received: by 2002:a5d:59a7:0:b0:37d:3301:9891 with SMTP id ffacd0b85a97d-381f1866eefmr1537614f8f.17.1731059797799;
        Fri, 08 Nov 2024 01:56:37 -0800 (PST)
Received: from localhost (host-82-56-18-47.retail.telecomitalia.it. [82.56.18.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381eda07097sm4062228f8f.106.2024.11.08.01.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:56:37 -0800 (PST)
Date: Fri, 08 Nov 2024 10:56:36 +0100
Message-ID: <6069300280c17c4568bf4e3bcc826797@gmail.com>
From: Matteo Martelli <matteomartelli3@gmail.com>
Subject: Re: [PATCH v8] iio: adc: pac1921: Add ACPI support to Microchip
 pac1921
To: Andy Shevchenko <andy.shevchenko@gmail.com>, victor.duicu@microchip.com
Cc: jic23@kernel.org, lars@metafoo.de, marius.cristea@microchip.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <CAHp75Vd924pNBKkoWNse5Bjazrp9+HuqBJ5nj2tdk6vngaOiJg@mail.gmail.com>
References: <20241108085012.13147-1-victor.duicu@microchip.com>
	<CAHp75Vd924pNBKkoWNse5Bjazrp9+HuqBJ5nj2tdk6vngaOiJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>

On Fri, 8 Nov 2024 11:23:18 +0200, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> On Fri, Nov 8, 2024 at 10:52 AM <victor.duicu@microchip.com> wrote:
> >
> > From: Victor Duicu <victor.duicu@microchip.com>
> >

...

> > +static inline bool pac1921_shunt_is_valid(u32 shunt_val)
> > +{
> > +       return shunt_val > 0 && shunt_val <= INT_MAX;
> > +}
> 
> This basically is the (shunt_val - 1) & BIT(31) which can be used
> inline in the caller. Hence, drop this function and use the check
> inline. See also below.
> 

I think the current comparison check is more clear. Also my suggestion
to move the check in a seperate function was to keep it consistent in
different places since such check can change in future and one might
change it only in one place, as it was happening during the first
iterations of this series. However I am fine to remove the function and
move the check back inline in the caller as the check is now only in two
places and it shouldn't be a big deal.

...

> -- 
> With Best Regards,
> Andy Shevchenko

Best regards,
Matteo Martelli

