Return-Path: <linux-iio+bounces-9929-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D02C098A67C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C7F31C22BED
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8384C190075;
	Mon, 30 Sep 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvQ0Trr8"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51218FDCD;
	Mon, 30 Sep 2024 13:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727704693; cv=none; b=lTKctx2sj074eG5orT75VDy6poiUqkFrkCaIms4TJWzADZy0d7RG5iaKmELr7mFOrAM5htEaJOc+kj06uFwBCEq0DzOyEgb/LKhUBe1W2jJb90MKaz9PRhgDp+1C+sNYTLmtm7QDq0JG/A+hceDoag6xRoUF8OXbKAfwMRC+ZQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727704693; c=relaxed/simple;
	bh=L7DfDC0dCUsWlXcdNM0l7Lfoxx3PDILbr+50s7zpM24=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bDpfL9Mn+9R2eczwgt8D3MwbVO62XFXqdO70x/5mEov0KZv5ah2lJwNmYm0MkL7447TeqGNJ43AGHM1vZRu+uHKhC1MJ1khVJJW8yc+WQfxlP2mGm/o9N4lL533xy/AJRbEAksLuoSWL/0HTxPvk7MHKO44hdgDy25Rpojo22QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvQ0Trr8; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c721803a89so5759306a12.1;
        Mon, 30 Sep 2024 06:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727704690; x=1728309490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xwI/LfAGe5Ta4KqJbBqHpgs9o265BV2ly47yzw3TuR4=;
        b=QvQ0Trr815/Q3A58nM000qydLrXFiDawFfT9Vsj1SCld0tWGL7foOWcR/4e540tvH2
         NU5X22wGcsBMrFyvWCOClShDxLy21rO3moDcfThRQeCR2VlH0mKbXqbPx9xiO9tRoI5P
         587CBhL1Oj96QsdKdU5enlLe6pT1GI2Nwr/KW25zCcCcXCkfopH0AD8jNjbTJrQtrImR
         0y5lZepliSMOgIAgUO2K8L8CIpg/qeOz6yCHVniN9yw5T1FWSlBihtV1UE0Wm4zS09/z
         5eouJVUOVv0yIKIgqh9t5NUtJnqfHMYShrwllHT2Xbue6msnXBoYyIqAOl9VqS7GDVMn
         vnKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727704690; x=1728309490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwI/LfAGe5Ta4KqJbBqHpgs9o265BV2ly47yzw3TuR4=;
        b=k0OSPxdnJMzmFX2Nzj46nxpY5xmMY8re2geYm+6yXjCVPav1nI3puojRFjjOkE3Wer
         DfTBIj3n3vA5voZnGUBPTFENzRrWeDfGT28+Sx0UuQQS+sree/ci1SlFK9Pl7ThnCAjX
         eH0egZHzeHt4hFgsKuyLj3O99IuRSCNImiQ7C/GwzKF69tfY37pwNdCFU3kSNf72wTrE
         SRlw2p0VXnLkl4fav7z6Jld2CR5+7iGx0BzLaOUwHKuZT+Zqi7LFpFGhTQ4dWa1VBm/K
         UKPvTdj6LIMBU2wB46wLnPo2M48WodTWT+kF5mXSBOcjB4d2DshwoRRojh2NH5aOHjQL
         zHXw==
X-Forwarded-Encrypted: i=1; AJvYcCU5twP1GyGKyf7hFxNQHOLRTMx7TwiOdhmOfGVjOAyDlpxQoZx9xJWI6leFctAdlsApTT+ymE5zg1NExDNc@vger.kernel.org, AJvYcCUtfVnhLaZtImcArRIw4Ich5btSil7szGfBtrPmmN0E8qFFXgxhoHkPtmY8rWrhhpdqOuRoIuuHMIU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6lKTF7JxokHwnUn0i6by/CmWPMJwbtrm5TjW0AiwrigATMVV6
	NoIjMaz4NY8N4eN5pUY0HTdlwrPICnFKE2Q27D1oNHExgcqduDAr
X-Google-Smtp-Source: AGHT+IEhBlg71y5VN7qEdltvm1fjcdU4jaRQNJrbL8qglt2lIooBcaADoNTAconMdwC6D6RIBBaxnQ==
X-Received: by 2002:a17:907:a08:b0:a8d:3e67:19fe with SMTP id a640c23a62f3a-a93c4a6996emr1349859866b.41.1727704689645;
        Mon, 30 Sep 2024 06:58:09 -0700 (PDT)
Received: from [10.10.12.27] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c27c70d3sm534039666b.78.2024.09.30.06.58.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 06:58:09 -0700 (PDT)
Message-ID: <7e9ae281-448c-429b-9ca5-86581f777f68@gmail.com>
Date: Mon, 30 Sep 2024 15:58:06 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-6.12-rc1/drivers/iio/imu/bmi323/bmi323_core.c:133: Array
 contents defined but not used ?
To: David Binderman <dcb314@hotmail.com>,
 "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>, "lars@metafoo.de" <lars@metafoo.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/09/2024 15:49, David Binderman wrote:
> Hello there,
> 
> I just tried to build linux-6.12-rc1 with clang. It said:
> 
> drivers/iio/imu/bmi323/bmi323_core.c:133:27: warning: variable 'bmi323_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-internal-declaration]
> 
> A grep for the identifier shows the following strange results::
> 
> inux-6.12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/bmi323_core.c
> static const unsigned int bmi323_ext_reg_savestate[] = {
> 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> 	for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) {
> linux-6.12-rc1 $ 
> 
> I see no mention of bmi323_ext_reg_savestate[ i]. Is there a possible
> cut'n'paste error in one of the two for loops ?
> 
> Regards
> 
> David Binderman


I think that is a bug in clang:

https://bugs.llvm.org/show_bug.cgi?id=33068

That happens because clang sees that bmi323_ext_reg_savestate is not
used but to gets its size, and that means for it that the variable is
not needed. That does not happen for example with
bmi323_ext_reg_savestate (right above bmi323_ext_reg_savestate) because
that one is used beyond ARRAY_SIZE.

Safe to ignore?

Best regards,
Javier Carrasco

