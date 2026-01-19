Return-Path: <linux-iio+bounces-28008-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D841D3B74E
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:31:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 104543007F34
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E77284B58;
	Mon, 19 Jan 2026 19:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/yDFoiV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0A2475E3
	for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 19:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768851108; cv=none; b=cy3jQBB7CvWqFlBWa3wYjXfRTvDmsGS2d8ISaOqDBshQX9Oit+FONHX9iCUlhN5IRSLEV2x0MzDwiosDZ1WVq7LyRCddsYL7q8IA1UnTIa70B+kqAbUE6XgY0c1HgNSlNy5C62c/ohqY4vo8bP797Eiwh2MMfCNqqvAgXKex7eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768851108; c=relaxed/simple;
	bh=x2b9lNEGCQygYR/3W/mNW1fFVMbpAS2G13sb1IHGSSE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rI2fK5xuIUGBzD/VIVEIA3ogZgqCPnSfUMdDNRqU3yctTQh/bdBx7OnUGRarRSLPCfNzyuajgBNYymX3sapZBTaYBmu6zH7fESh0Fgw/gr8KPKDLM43If/XVo4NUt1S22c/m3rPduoZGnbDdPMBP5AAlpXEJ4DW8BpmcXEDZrxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/yDFoiV; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-559f4801609so1759513e0c.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Jan 2026 11:31:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768851106; x=1769455906; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x2b9lNEGCQygYR/3W/mNW1fFVMbpAS2G13sb1IHGSSE=;
        b=S/yDFoiVmdmfE1HymPUfNvw+Dwzz7lZ5VAIeAZlikbnsJuXI3PEjaDxpkLp1tPiFtY
         ghGIcNVRCA7NKH90cDmxOCMTHVXarSBS3jHl+Xs2tiYAKg9wHRqTePeUObJZ1u/5d/C3
         /Ul21Q3k9y7u6UCYm3Xr+78MFQ5RxEax0zch3gov17hT5OnYBHNJ227EJluWsz5bOO36
         K1aWy0z9AMGsOelgWDEK+9C1EmnjQ/a2XEA5D7kUWM7cVz6aBmL8aZDabgIjqywWj02G
         2oEtrM6UV6DI3trJZmJtIMPCpkeyKHNlHjl5jVVCpGdFhZwZYZXuhKf36IUFKnbnIQvK
         1DKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768851106; x=1769455906;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2b9lNEGCQygYR/3W/mNW1fFVMbpAS2G13sb1IHGSSE=;
        b=oVxzcHDL0/XSKjsx4smk/RaFDzCvKal2sGReEa/YDGiTU5bZsb5GFFMT6vavA7pDGy
         Uj1LJUygspK5NsJ016HfPTBoroIVLQHY8FafkfOhRajQeDG58s0i1HKkaC9d1LZivK0m
         e4H50Oql95FUvr4+0VlGDIbDBtrGVolvgQCmwUEoqxMQCLljbR5Rf4rawrmagWBRSeI7
         BzBHTPuCYyqhGrIoef0rQBYIsRva5yeI6fIVU0JigCIwKjyo80Avq/O/Qj2lwW732KNR
         jhc6XBSyeIp23REfPl0ERP9N9N/4zRrjaHsECMR1BtryA+rYmcafMYuDfGxQgpyyq40T
         yyaA==
X-Forwarded-Encrypted: i=1; AJvYcCW0wzMh5IJkiJIy1AZZFu2ZKap1zIY013QJE/Lr6g3GCxHlQYkBw/EBuAgRTI4Y0yXH+bJajxqiKgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0tXMIFl2EJwsTRNow4BO2AVwaVPSK0/XtXMYcQ4InWPk8/IC7
	8d/cLF4ut/Jm+dtAFePNW6GqWrZXAVPfijACuUZeVK/hdxK7sZNRj8Kg
X-Gm-Gg: AY/fxX64xT+GWDfpWsdrXXxNIcnFCqa0IyIKio6Lr6OF8Bb46WxFC5UCfcdMESvQyfF
	ar7hByEQRTDAFzrSxcPTZ2on192W/uX6oHQz8hP+xq4Z/1LjXIe8Jzu1Z36CBgSVjN8ZWBHhdRN
	iRY9oUPWsgi8RniyGRRF+Fnfkk64GvCafS7QzxYgTrn6Hlc1Cd39KOqlhuUwnzMPxSUwxUqdtZS
	99Geb8PoktkUmeBB26RINzGsa1k1l6ZfKpDHewmCK9oWSS5TtDx/3m8uXn+jrRk0eh6ITC8RbUq
	yxg5lz5S+AkUTaMO0I0wxMuyy1KYKK+wDhh/5euOfIXesrJlXHVez+miJJpajGhm+wfDzkxNZTm
	yfpLauhkjTtCkBEqzMtHRLUebjAh/xXLeu0aKBnouJTEMhS8eeOdDLzwvXaB3EAFPsj1G13neNg
	BLXA==
X-Received: by 2002:a05:6122:3d46:b0:563:5a97:ad78 with SMTP id 71dfb90a1353d-563b5c35871mr4451376e0c.6.1768851106440;
        Mon, 19 Jan 2026 11:31:46 -0800 (PST)
Received: from localhost ([2800:bf0:82:11a2:7ac4:1f2:947b:2b6])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-563b70e7eaasm2974068e0c.12.2026.01.19.11.31.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 11:31:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Jan 2026 14:31:38 -0500
Message-Id: <DFSTDSO5P9RC.DGCGPD10KYPG@gmail.com>
Cc: "Lars-Peter Clausen" <lars@metafoo.de>, "Michael Hennerich"
 <Michael.Hennerich@analog.com>, "Jonathan Cameron" <jic23@kernel.org>,
 "Benson Leung" <bleung@chromium.org>, "Antoniu Miclaus"
 <antoniu.miclaus@analog.com>, "Gwendal Grignou" <gwendal@chromium.org>,
 "Shrikant Raskar" <raskar.shree97@gmail.com>, "Per-Daniel Olsson"
 <perdaniel.olsson@axis.com>, "David Lechner" <dlechner@baylibre.com>,
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, "Guenter Roeck" <groeck@chromium.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <chrome-platform@lists.linux.dev>
Subject: Re: [PATCH v4 4/7] iio: core: Add cleanup.h support for
 iio_device_claim_*()
From: "Kurt Borja" <kuurtb@gmail.com>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>, "Kurt Borja"
 <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260118-lock-impr-v4-0-6c8d0aee8ed2@gmail.com>
 <20260118-lock-impr-v4-4-6c8d0aee8ed2@gmail.com>
 <aW3oEZ2WSp0JGl90@smile.fi.intel.com>
In-Reply-To: <aW3oEZ2WSp0JGl90@smile.fi.intel.com>

On Mon Jan 19, 2026 at 3:15 AM -05, Andy Shevchenko wrote:
> On Sun, Jan 18, 2026 at 10:44:31AM -0500, Kurt Borja wrote:
>> Add guard classes for iio_device_claim_*() conditional locks. This will
>> aid drivers write safer and cleaner code when dealing with some common
>> patterns.
>>=20
>> These classes are not meant to be used directly by drivers (hence the
>> __priv__ prefix). Instead, documented wrapper macros are provided to
>> enforce the use of ACQUIRE() or guard() semantics and avoid the
>> problematic scoped guard.
>
> Acked-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Hi Andy,

Thank you for your feedback!

--=20
Thanks,
 ~ Kurt

