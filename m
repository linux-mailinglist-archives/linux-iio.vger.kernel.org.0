Return-Path: <linux-iio+bounces-17206-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C4CA6CB24
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 16:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4356C188D616
	for <lists+linux-iio@lfdr.de>; Sat, 22 Mar 2025 15:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EEE22FDF0;
	Sat, 22 Mar 2025 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b="wX3DUzqk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mx-out.tlen.pl (mx-out.tlen.pl [193.222.135.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0074189BB1
	for <linux-iio@vger.kernel.org>; Sat, 22 Mar 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.222.135.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742656811; cv=none; b=IZtUekNMwSIBDqRPMPNzrDMEnsBNQCsAKCbE7hweTNJ1pdznHf2TFzjj14Su4PeDaOm4VweRDkTZ1ahlvlsc7CsasLiyVBVTz7gT5JnNLC10F1TxGQJyEveYZtQRhjpeCg+DddP9BDq7Z2jrYzxrPhpE7Idw/6epfvSrfNkjBck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742656811; c=relaxed/simple;
	bh=lbnWtlHDwmQu+U4pYCrRSnISSwQxw4/w+NG/FpA+ePA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NNYCWDlS6bu9RichKPqiGtq1hxcfPhsyMaBVLjwdkoYdDr4BIfX0HmWfhVYevoOQoWLMT+4QG39vlwOEnmX5zoFoptIkdC92dqsC8bns/UeKOltpt6Vcl+GfNBG2DZwjOGak59F5OZiFA+CqFuR1wU6eTSzbf/eyaKrecxtSxSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl; spf=pass smtp.mailfrom=o2.pl; dkim=pass (2048-bit key) header.d=o2.pl header.i=@o2.pl header.b=wX3DUzqk; arc=none smtp.client-ip=193.222.135.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=o2.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=o2.pl
Received: (wp-smtpd smtp.tlen.pl 4294 invoked from network); 22 Mar 2025 16:13:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=o2.pl; s=20241105;
          t=1742656406; bh=Gj7aLWvFrMBjZ/TgcFCJw3zewFcRX+wjHcjwWaIyWGk=;
          h=Subject:To:Cc:From;
          b=wX3DUzqkz2NJWMI31FK2U7X1MKwgwwCoX9J+t/X7SLU5w1Htj+23YeOPZvSYkxdYx
           7Io9r/BEH2YAn92J0H5VRuxQpawqi7Loccub2AGb+uU934DdHXquEDI/1TN5aoMocP
           5zApmJsQO/HDVQVedqXzXa9+pkc0oJJ2Fhm1BC6Iwk/IuxuW7dwHoA8kTpHHa55ucB
           aa4a8y//zW5bFW3o5U8WbGiCKTv18AFyj2SeI18GMprF1H2NxbUIF+riGKg6E5omyv
           ODbdXr2KXB7SziCOvJMpLYbipvsFyHt/r2J6vBCfaCxz0VN0P5sycRGTTXFAnbaLmT
           fMDXQtFp4MVUg==
Received: from apn-78-30-75-41.dynamic.gprs.plus.pl (HELO [192.168.1.22]) (mat.jonczyk@o2.pl@[78.30.75.41])
          (envelope-sender <mat.jonczyk@o2.pl>)
          by smtp.tlen.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <david@ixit.cz>; 22 Mar 2025 16:13:26 +0100
Message-ID: <5642f2cb-ce34-4474-bb32-50f028a007ad@o2.pl>
Date: Sat, 22 Mar 2025 16:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] x86: Kconfig cleanups and help text improvements
To: david@ixit.cz, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
 linux-iio@vger.kernel.org
References: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
Content-Language: en-GB, pl
From: =?UTF-8?Q?Mateusz_Jo=C5=84czyk?= <mat.jonczyk@o2.pl>
Autocrypt: addr=mat.jonczyk@o2.pl; keydata=
 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
 TANkZ3QqXNX2
In-Reply-To: <20250321-x86_x2apic-v3-0-b0cbaa6fa338@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-WP-MailID: 6ec931b71409fd83336a765f8d20eaaa
X-WP-AV: skaner antywirusowy Poczty o2
X-WP-SPAM: NO 0000002 [cYEt]                               

W dniu 21.03.2025 o 21:48, David Heidelberg via B4 Relay pisze:
> I'm resending this mainly because of the first patch, but I find
> all other patches worthy too, so here is the rebased bulk.
>
>   - David

Hello,

Well, thank you for taking care of this. I have quite a lot of unfinished
projects and not so much time for kernel dev now. I'd also like to apologise
for not having responded to your latest e-mail.

Greetings,

Mateusz

> ====
>
> Hello,
>
> There are some problems with Kconfig help texts in the kernel. They are
> frequently confusing and use language that is difficult to understand
> for people unfamiliar with the feature. Sometimes, the help text was not
> updated after important kernel or ecosystem changes. References to
> something "future" or "old" are also usually given without specifying
> any dates.
>
> First version of this patch series was sent out in February 2022.
>
> Greetings,
> Mateusz
>
> Signed-off-by: Mateusz Jończyk <mat.jonczyk@o2.pl>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
> Changes in v3:
> - Rebased against latest next-20250321.
> - Dropped deprecated patches:
>     2/10  "x86/apic: fix panic message when x2APIC is not supported"
>     4/10  "x86/Kconfig: drop X86_32_NON_STANDARD"
> - Dropped patch I was not very sure about, as there are other refs:
>     10/10 "x86/Kconfig: remove CONFIG_ISA_BUS"
> - Link to v2: https://lore.kernel.org/r/20220911084711.13694-1-mat.jonczyk@o2.pl
>
> ---
> Mateusz Jończyk (7):
>        x86/Kconfig: Enable X86_X2APIC by default and improve help text
>        x86/Kconfig: Always enable ARCH_SPARSEMEM_ENABLE
>        x86/Kconfig: Move all X86_EXTENDED_PLATFORM options together
>        x86/Kconfig: Update lists in X86_EXTENDED_PLATFORM
>        x86/Kconfig: Document CONFIG_PCI_MMCONFIG
>        x86/Kconfig: Make CONFIG_PCI_CNB20LE_QUIRK depend on X86_32
>        x86/Kconfig: Document release year of glibc 2.3.3
>
>   arch/x86/Kconfig | 85 ++++++++++++++++++++++++++++++++++++++------------------
>   1 file changed, 58 insertions(+), 27 deletions(-)
> ---
> base-commit: 9388ec571cb1adba59d1cded2300eeb11827679c
> change-id: 20250320-x86_x2apic-7e92d0f4c47d
>
> Best regards,

