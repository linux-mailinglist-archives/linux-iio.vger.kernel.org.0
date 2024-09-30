Return-Path: <linux-iio+bounces-9934-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7486398A7AE
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 254951F22A89
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 217D8198A06;
	Mon, 30 Sep 2024 14:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQ5Zak9X"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48771198848;
	Mon, 30 Sep 2024 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707683; cv=none; b=MoSSzb2Ck7EgkWAwVdsdOI5k9paOSEc//xod16zhlGe3XhcXAZOS430jcXH7W0x8eKv0vCvABvHCHIOyn8B1wuaUQ8S8fYOdUPM4sve6+HaQkZ0IEw1Ob6SWBJktue5qWD3pGm7/4XCsApLf9v9cLICVOUu9an+ZBuAKCw4rbP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707683; c=relaxed/simple;
	bh=kIa/0M+YcSi8+ecH0lZS7VUSNbP4IxvNJkfLuTOGS8s=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=r1XVrff52nugmRYzQmlXR17bhIinKcJfvzXF6P0TRZEZr6RyceHIZHEYZ/30oiWHR6bokUoUHrUsTT7aLopYrV71IzPg1LBmVd9Eh3b/pMWXwqPBM0Rxtuqj2dN2b4mDfkIXj31/TQ5+MEb/s3afhOKKohPK8qIH3gBBaboxy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQ5Zak9X; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fabe5c8c26so22718731fa.2;
        Mon, 30 Sep 2024 07:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727707680; x=1728312480; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vYO6LBz3ZoiGwSs6654oQ2oioIT6eerJxGZ3LD6Y/eo=;
        b=fQ5Zak9XlECjEnOlAJgRvLQsQ3ucLVeliVE1/RVetlaEVlCI8Vfr6PEVLJUZW8BlyI
         YYqDMAUZC94wxvBGOpJfNf6biFyeY9ehxCliTFaI237wiJ2wrbqgEcsdgolZ/4UHiiwJ
         Vu5zxikO5XIwbZLfPCg2WXcjTFYTjbj2KOWQncqvBMDwZhgpk5RCaA10vNMrBr/OJGu8
         +FeVW3I9F4HVxScaw2BGjqWUE0iIH/bKoHsanU+eN/7kL2NJGutJ/HzUWz9wmwQVjGJd
         yEF2EnQyR5PtHD4ug/7Zroj+M7GNtVayagQ3cHKsgduT8I5UGVAaMtgmx3Rd9S7fP53b
         ANEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727707680; x=1728312480;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:to:from:date:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vYO6LBz3ZoiGwSs6654oQ2oioIT6eerJxGZ3LD6Y/eo=;
        b=uO64ma8OMJGDXmAeVFFxWkHMaaWl+vtO20o1+BlYt0iNwf6pgXgJAqjX1qiC7P1M3P
         rM61RUo9XySCXn+EvXy0u2TdzCXq9CxFnhbvfr3kJcqYOiatlJBna0X/crMgUQFQmJAp
         z3pm4emZWxGJKSIjvNsMV1OVVQXBz5FTDh4j1m4agQcgjAyEQfByisjTEsbh+xGbhZUH
         p1qQfn13jwGUsIRNnyugHHldkCZF5+XP68+Cxh17tsCuaF2jQTOLPxuDnmP71cX+UZEN
         82hEkpkn6oDmr2FwJzdQxGgy1eOB+asXdn9+JfXgUlyq83QjsgYOaZJPwnfL8/l6G3+H
         HDNA==
X-Forwarded-Encrypted: i=1; AJvYcCVFfkmgPd30evDW15e6ESCQmVaEErw212m+/OJa/SCvrMtsEfhlkhmGAsAk/kBdFIMMRPLqyAeo8mCwC0f4@vger.kernel.org, AJvYcCW0WpRJLKYnct2uPf9g6f/ZfgrstAb7WCDXWpbKLGIZchmTxWkNZ/vEY8Wv4kS+ATkD6h8QDQmQbj4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyuNJmW2LdfYeP/T3UI6R6njBStD3SvdId+A1PeAu2pFpZWv101
	/Te9tW6902e/uzHLtFYkBQgzMTrG+tAe1jNscNZ0WeuTjjQ2Stgk
X-Google-Smtp-Source: AGHT+IHLAar2nM30F/RgPYEhuBacvCi6ojvUEcHCIDmaXRjcq0pAw6O3gnaam1M3CjwcIweSPxxHTg==
X-Received: by 2002:a2e:b8d6:0:b0:2f3:d8dd:a1f6 with SMTP id 38308e7fff4ca-2f9d41c2c87mr64128971fa.40.1727707680020;
        Mon, 30 Sep 2024 07:48:00 -0700 (PDT)
Received: from [127.0.0.1] ([46.234.214.159])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f57de11aasm105175675e9.16.2024.09.30.07.47.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2024 07:47:59 -0700 (PDT)
Date: Mon, 30 Sep 2024 16:47:50 +0200
From: Denis Benato <benato.denis96@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>, David Binderman <dcb314@hotmail.com>,
 "jagathjog1996@gmail.com" <jagathjog1996@gmail.com>,
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: =?US-ASCII?Q?Re=3A_linux-6=2E12-rc1/drivers/iio/imu/bmi323/bmi323=5F?=
 =?US-ASCII?Q?core=2Ec=3A133=3A_Array_contents_defined_but_not_used_=3F?=
User-Agent: K-9 Mail for Android
In-Reply-To: <14a21c87-22f9-4637-b663-bb0a28fe8e46@metafoo.de>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com> <14a21c87-22f9-4637-b663-bb0a28fe8e46@metafoo.de>
Message-ID: <A9EB783B-50AA-4C9B-BDF8-A9E7B8CC7BFA@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 30 settembre 2024 16:19:14 CEST, Lars-Peter Clausen <lars@metafoo=2Ede>=
 ha scritto:
>On 9/30/24 06:49, David Binderman wrote:
>> Hello there,
>>=20
>> I just tried to build linux-6=2E12-rc1 with clang=2E It said:
>>=20
>> drivers/iio/imu/bmi323/bmi323_core=2Ec:133:27: warning: variable 'bmi32=
3_ext_reg_savestate' is not needed and will not be emitted [-Wunneeded-inte=
rnal-declaration]
>>=20
>> A grep for the identifier shows the following strange results::
>>=20
>> inux-6=2E12-rc1 $ grep bmi323_ext_reg_savestate drivers/iio/imu/bmi323/=
bmi323_core=2Ec
>> static const unsigned int bmi323_ext_reg_savestate[] =3D {
>> 	unsigned int ext_reg_settings[ARRAY_SIZE(bmi323_ext_reg_savestate)];
>> 	for (unsigned int i =3D 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i=
++) {
>> 	for (unsigned int i =3D 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i=
++) {
>> linux-6=2E12-rc1 $
>>=20
>> I see no mention of bmi323_ext_reg_savestate[ i]=2E Is there a possible
>> cut'n'paste error in one of the two for loops ?
>Yes=2E Do you want to send a fix?
>
Hello,

I think fixes are pending already in one of Jonathan Cameron's branches=2E

Best regards,
Denis Benato

