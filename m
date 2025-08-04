Return-Path: <linux-iio+bounces-22296-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD25FB1AADD
	for <lists+linux-iio@lfdr.de>; Tue,  5 Aug 2025 00:26:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AB2718A0A71
	for <lists+linux-iio@lfdr.de>; Mon,  4 Aug 2025 22:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4139A28FFC6;
	Mon,  4 Aug 2025 22:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lOojAZIk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E0E238C07;
	Mon,  4 Aug 2025 22:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346368; cv=none; b=ToR3OsR32x6BqxOg/wytwyCNR9d9YmWwoQp0fWRJrKrYV5u5lJniVGuX8SWWM2Bv1H1LN860j4ZcHDlVPFeQD7xOGRdU701M2BTjuQHh2+VMiPjmb3+Nuy56l8PyQRyYsxx2Tz1hTTA3QYbpQpJgWe5yu41fXftSGKiRDPDGBWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346368; c=relaxed/simple;
	bh=kVJ24A/+EOTmI95tP9xa83xvhY8dX4CrI8wTpeNdBFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lkVyAmmZNCBhuWiGkm55AnvNKCPS0bBA+6Y842CHFrnUjtymD6ThfMaUJnCJbw/57rnj4sJbcOH5qSZzt7ahpRf6u9FuxR8nUuk7z7husyL5JqQ9gfCuIaZrQz0k31ylowII7ZnNkAwcrxGqSNX9Qlb8znszyUUudUZauA833/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lOojAZIk; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76bdc73f363so3040136b3a.3;
        Mon, 04 Aug 2025 15:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754346366; x=1754951166; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=T6BVFrBwbS56dQYxtGm8nysX8Qp9r4lFOJoA7FIQG3E=;
        b=lOojAZIkc8wN9YviEei6QYcKG9Bmw1Lzu1G0FhH5QSvgt2pglHAbtf2XkKNx+ypYWG
         bIW6yCTwmHv1j4gs1YglcqCKsio8VfclXVWI4Ki7KRJWCl/17tRPvSGbARAv3U4kpIbx
         5GF4VZaHpelSVoHQ4TyorCm5HtkFHOW+LNdSt5aOsnPhK2idnmgMNPPpEz/C1DWDyFeL
         hTZzS07cEvdtgQ0LQf9yzFqqCRXGudlQxZfvQ8fiJzQ6RPcj6N55eT2NYfj5hj9kbIPb
         SJJeoQrCzL9ceEeHN9YHdaOvKnAq5D+AmQi8yndVnskq6byn+hFHELqTXHzap6wQTJ3p
         mYag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754346366; x=1754951166;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6BVFrBwbS56dQYxtGm8nysX8Qp9r4lFOJoA7FIQG3E=;
        b=f5EzW0Eg/248nirQG6izzL2Icy5HG/rHml5Rc/Z/2UwoSkrf7pY+TRwohmRPK2bv7N
         R1AN1F2p75b7nHc5coT1jCDyWRYQmRHuRqQQpFQnWQEQFednXtjgEfS2tiaYo46mZOn7
         mGqnq+rGreSMernpDlIK7EaKC4MnPdo9VcJj6co9nW/EW/sXofDaFuPXS69t6wTzG4GE
         4YBcv9ozPkfHNJMgp0sDyomGfRyLM9N6B1SRdTeq1VeLnIdxQWT+7L7DiVnZlHnG54H3
         dIYoaIMfuaMXsWvWHz0+Y1Pz3H7Z3o5XVNLUgSbcYnOawDwa8Dt8Nxl6lsoQmRYYax/O
         RyiA==
X-Forwarded-Encrypted: i=1; AJvYcCUZumFnFDTU7pLcoRtS5MhHOm87aI34OqhwZC817kPKz1u5pmYdo1Ebwd5d4CrnfNGly3dbU/LqE8o=@vger.kernel.org, AJvYcCWcTMLUDaAvrDL6SpTztxOqQSGc494YbYiM4+g93RG3GzqoLCTJXb3KxTk6kZNOspQ8zUarpgTrNWWOzDR8@vger.kernel.org
X-Gm-Message-State: AOJu0YzuYqhl9RC+TvNAL7jw9LHLtNKoFwYc8ABcz/UcbsjkHKEE40uU
	oAXCNbasqGWpM+iJ1LoRV4QzWtILdhOeXyRmISd0EJKyrB7K+TJCKWS4
X-Gm-Gg: ASbGncuHzFIaCIDum47T8wWAxV5KQ6jWQzWEQAFqVxZwR3Yko0vpu0b72L5crq/2tOt
	iAtrwlFyrwodOFFPsi2IulcMOoziCt4ZFG7NKCdDIuPppyuJG4upM4ezCo3RADjrwnqJkZBX9z6
	EpmrMoaHUn/HM7I7Ig9B3b0xyow48ogwhW1iM/mI+g+TPPK5/XZD79fM//xPhR35a4qfA7yCD4q
	jFU7IG0DR5wm/tEOJ78ZSmV8Kgvg68cVGC2xgR3tyqDi3IbWF18kGSH32MzHS2kGfTniFQUdRHw
	HLcvQBVdnMLvNIQOUOlLi/j7qqHNguu1UpEMKEVj+hSSFlLiCpgh/0Lo2e3UP4ZM55Q8VA+vvSS
	H9co3Mg==
X-Google-Smtp-Source: AGHT+IHfUmglXfHbkwX9hQG0wXyNcOTcSKyPNK6ScJGbjgKlV63OlHoCXSfuiZaJIC9tTuOdXI3jhg==
X-Received: by 2002:a05:6a00:2195:b0:736:a8db:93bb with SMTP id d2e1a72fcca58-76bec311038mr13783835b3a.5.1754346365903;
        Mon, 04 Aug 2025 15:26:05 -0700 (PDT)
Received: from archlinux ([2804:14d:90a8:4498::6b2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd88dbsm11400458b3a.103.2025.08.04.15.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 15:26:05 -0700 (PDT)
Date: Mon, 4 Aug 2025 19:26:03 -0300
From: Gustavo Silva <gustavograzs@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Alex Lanzano <lanzano.alex@gmail.com>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <raapwni4cn2lmazn7n2yvmjocmgntwram4wj2guvo5vwslhjbl@ni3elcf4ptn7>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
 <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
 <aHYIBReTFqJMtiXW@smile.fi.intel.com>
 <vlpqd3jeszhgpcob7qyzp5vljdowwu26my7xuwuvfftf54zg35@czxhsjejgdkm>
 <aHd2s987EMCdgdrJ@smile.fi.intel.com>
 <20250724162227.065d20a0@jic23-huawei>
 <aIKlC-HlP3nX-ERA@smile.fi.intel.com>
 <20250727164909.1833c4bc@jic23-huawei>
 <20250802125821.2ae1b17b@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802125821.2ae1b17b@jic23-huawei>

On Sat, Aug 02, 2025 at 12:58:21PM +0100, Jonathan Cameron wrote:
> > 
> I got lost in this thread, so perhaps am assuming there is a v5 to come.
> 
> Maybe just send one anyway even if no changes as it'll jump up my list to look at.
> 
> Jonathan
> 

Hi Jonathan,

Yes, I’ve yet to send v5. Just a quick reminder: patches 1 and 2 from
this series were already accepted as of v3.

Regarding v5, would it make sense to split it into two separate patches:
one for the motion events and another for the ABI documentation?

