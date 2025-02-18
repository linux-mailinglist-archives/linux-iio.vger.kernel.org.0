Return-Path: <linux-iio+bounces-15750-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95ADAA3AA66
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 22:03:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBB1B3AD8E2
	for <lists+linux-iio@lfdr.de>; Tue, 18 Feb 2025 20:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138602862AC;
	Tue, 18 Feb 2025 20:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="RGZ+lDda"
X-Original-To: linux-iio@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8D2862B4;
	Tue, 18 Feb 2025 20:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739911964; cv=none; b=bA7WKtHMCjq1LkTljYn0VnwqRRakl9ESv9yZi0KQUsJAOb8XOpHOUrzhRbdONuaXelFI22eJBersJbP4GIeml11SG6xSIwNnw/EGuHFMb98Mx57eLV7mNGbsjV0VK8McxHniGbOavnIluynE44Cqq1naxiM8qD37162IToMfBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739911964; c=relaxed/simple;
	bh=8jNMU8ip6rBeSpqlISiaPJWQQi8raU32gK6jMCIpWKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mOzZE91ff0fL7yzajQXFyNNt32ylrN5L0hi9bghGGwUwMKjDweh1Wp4XY629p4/SIGuEnpQKYnyVCbq53D729Iyh79q4ZnHyh9jOGZCY8t2zoMosmg1aDucKIY99lRcLtnTQzN5ZNYmV6+aP8SRPK8phjvSaWbgHZ7JNc84FC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=RGZ+lDda; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 41147411AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1739911962; bh=8jNMU8ip6rBeSpqlISiaPJWQQi8raU32gK6jMCIpWKM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=RGZ+lDdax8qjIOiB5ZacnAgWnZTgsFpylEbMW51u+P/MIZ4iyhn77FaRGI2dDgZ/7
	 PSdVV5Ab40gE18mE/GC17G4zDapRXyDnjvtMyLX/X1z8KjuhPso6bXPWo8AreECp1G
	 98znlH/rTluOQYNBlOJ3zgZgHPpYqLWuZudgxDv3yJkDcFhOdWhqo1YhFEhOHIeY4A
	 VAIzOxV+UDEcDyE8DFXCRzajUWTxsxZbIOIWZNKLrJ8usY8w0570cRguzaHptPlgAX
	 T0ovBK0bp9qEs6SV4ZG5qi7exbun4747718D6XGCFauEWi9SsploIuqSqI6XFFY4zS
	 3PACaipur3xJQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2d7f::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 41147411AF;
	Tue, 18 Feb 2025 20:52:42 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Bagas Sanjaya
 <bagasdotme@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Andreas Noever <andreas.noever@gmail.com>, Avadhut
 Naik <avadhut.naik@amd.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Eric Dumazet <edumazet@google.com>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Lars-Peter Clausen <lars@metafoo.de>,
 Michael Jamet <michael.jamet@intel.com>, Mika Westerberg
 <mika.westerberg@linux.intel.com>, Paolo Abeni <pabeni@redhat.com>, Sean
 Young <sean@mess.org>, Yanteng Si <si.yanteng@linux.dev>, Yehezkel Bernat
 <YehezkelShB@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, Pawan Gupta
 <pawan.kumar.gupta@linux.intel.com>, James Morse <james.morse@arm.com>,
 "Nysal Jan K.A" <nysal@linux.ibm.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Sourabh Jain <sourabhjain@linux.ibm.com>,
 Stephen Rothwell <sfr@canb.auug.org.au>, Frederic Barrat
 <fbarrat@linux.ibm.com>, Andrew Donnellan <ajd@linux.ibm.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Naveen N Rao
 <naveen@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-iio@vger.kernel.org, linux-media@vger.kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 workflows@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/9] Extend automarkup support for ABI symbols
In-Reply-To: <20250212135808.58d2f032@foz.lan>
References: <cover.1739254867.git.mchehab+huawei@kernel.org>
 <Z6yFG_NntQfkwYli@archie.me> <20250212135808.58d2f032@foz.lan>
Date: Tue, 18 Feb 2025 13:52:41 -0700
Message-ID: <871pvvnffq.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:

>> WARNING: Documentation/ABI/testing/sysfs-class-cxl not found
>
> I need to double-check verify this one, as it didn't appear on
> my tests. Are you getting it against docs-next or linux-next?

I get this one too, FWIW.

I've gone ahead and applied the series, but this would be nice to get
cleaned up.

Thanks,

jon

