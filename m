Return-Path: <linux-iio+bounces-9932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E798A777
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 16:43:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40C2EB21E1E
	for <lists+linux-iio@lfdr.de>; Mon, 30 Sep 2024 14:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47FBE1922F9;
	Mon, 30 Sep 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b="Kc35nYQx"
X-Original-To: linux-iio@vger.kernel.org
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83F7192B7A;
	Mon, 30 Sep 2024 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.137.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707372; cv=none; b=smSEhHuLPo63DDHjf3ew6wxwzLWewaPGoBTgPM8EWhpeiT+VC9qL9jwoZjN61KznsRhxtvtok+xEct049Hze4CwJrBaLjPTkw99GDPVdxePTglDVNSZ8AE1LfrjkCbOCWf4bkgDpPWaxYB8npoUYmdwr15F8Eh5jxMgmpoCWZYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707372; c=relaxed/simple;
	bh=W9bsvYrAThKR+wftdAQLaVFdtP9YWRFxLvhXAJHD9Ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m7s6XvwlCIH7jTO2YCdt6Fao+IALz3p7AxxOM44mUBe/CeGla7beOEjitqp5Jo8x2QGsKkrB82zXI8rwdeK7SIh2dg4IKHOatr6USTgnXoNOcHKzHgX/KSXMHZHtSInmEIgyeh44z+gxdS0ng+wiMRE6PQhTiju7n9JSgZf5rPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de; spf=pass smtp.mailfrom=metafoo.de; dkim=pass (2048-bit key) header.d=metafoo.de header.i=@metafoo.de header.b=Kc35nYQx; arc=none smtp.client-ip=78.46.137.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=metafoo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=metafoo.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
	s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID;
	bh=hR24CTg5rXq5zAgUEFlysfp4eqif9NCMaCtlEIjL1ss=; b=Kc35nYQxSdgWvDl6NclGdQQkzV
	8opDuFyEkLPzubJAyJtmrnVnYOzlPqFNxb4HSkw/qcbBQosdk6xDvMCLQYCXwXx+8iM4h96oFRWJZ
	sEWF9Zf5BPN63cgHO4ZA/3WKDfCTDYjQnAffkmr2GnN7gSbU7UaC6bVaVyZO8VBsoH4moVtRA3gAe
	zdLJZPiLrRG5vfXWnMxRirxTvBfXvmWSpG/HQV16JP8qRDflRGKqlO1V9/FTnKa2nHIxZWJ6dALXk
	cSLvZUgBzSJQLJHSXADXooDmbY8ABwI2qCcS7EGCoUTkK/McN5rlPcK/HjSIt/Rkjxl9cu4JRaLX3
	SRoCzbPA==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www381.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <lars@metafoo.de>)
	id 1svHF7-000Cak-7g; Mon, 30 Sep 2024 16:19:17 +0200
Received: from [136.25.87.181] (helo=[192.168.86.26])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <lars@metafoo.de>)
	id 1svHF7-0001nY-01;
	Mon, 30 Sep 2024 16:19:16 +0200
Message-ID: <14a21c87-22f9-4637-b663-bb0a28fe8e46@metafoo.de>
Date: Mon, 30 Sep 2024 07:19:14 -0700
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
 "jic23@kernel.org" <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Language: en-US
From: Lars-Peter Clausen <lars@metafoo.de>
In-Reply-To: <AS8PR02MB10217F8B5827B69E6438488679C762@AS8PR02MB10217.eurprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.10/27413/Mon Sep 30 10:48:24 2024)

On 9/30/24 06:49, David Binderman wrote:
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
Yes. Do you want to send a fix?

