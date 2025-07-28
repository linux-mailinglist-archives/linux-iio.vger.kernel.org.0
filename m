Return-Path: <linux-iio+bounces-22080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 690E1B132B0
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 02:45:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 948871894EE8
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 00:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73477450F2;
	Mon, 28 Jul 2025 00:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MTpRkU6U"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E479E111A8;
	Mon, 28 Jul 2025 00:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753663539; cv=none; b=WNnz/SM6ApRZ7ubzA5lfekSp+3Xmwvl7boJSeaGSWeaIchXV96wtIHe5u+BFTBBqMWFcZlgDBYDAyIvwZHCGp+MllYGM8aj3iDVtdw62jeMHIPcLpedfkmFWKN/oeiuuQ4r+6fVNwUan6ZM5nTXvVXl26WzK76qJQBasrqV/ESE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753663539; c=relaxed/simple;
	bh=PJe/QWtuQgNlJRdht/jm/3bC7zW3ZyumvfeSC/WEeTY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lvoyhZVK66SmTYfa832ZYM095EorlYygTxWSE4dGrj69N/hGBRVm8hx9uKLUUbq9jgE0zz7PQdFSD8WTppuKLcKA/e+QBBRg37y6/xUr9f4o4ub33LGziZZZOsltUsOswXjwTAk7jFrvRunYvtMqNbtf1BY7KoAqHNspy2M7zjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MTpRkU6U; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-23dc5bcf49eso52648445ad.2;
        Sun, 27 Jul 2025 17:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753663537; x=1754268337; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5T+yxi+oFtyDX441V08XJ/CKd6RZ2Fb0DWbGHQ7r/KA=;
        b=MTpRkU6Ud8JkP5cMu47so/W39hcF1R6wVFFR2+SXUd9iIbJHhqMUo+WWlLl6ZisPj8
         D4DFPja71Xn62KxSrmzgHfedt2+L6X51CBfsr/RwEpHk47audTThDEVmpr0WxYx02ZPY
         uYdHmHtrGuXs7v4BZgchJhBchB5pO8usCI5ng5pwKaWr++hLshdOJVX5KibY6i9h7k2C
         G3Rrzxlg81msISNMGMkAvz/2+TefgHAtWUgnYFnaiffelJ6V407r0gLnHx6BYmQA5dvP
         QC2tNrm50krl4FRV/4WpvmImcwa6CeSpwP+rTw6d/pbqJMBqE9iN11P6va8gwiE055aO
         SVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753663537; x=1754268337;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5T+yxi+oFtyDX441V08XJ/CKd6RZ2Fb0DWbGHQ7r/KA=;
        b=Nobcseg4gydHtVn9lbrOqFs1fSxxNKRK/0JHRKBdYTx5GCdZuAYufJx0y6yUUCxVfY
         iNQqS3ENziHWcXMxx0cGRjZVDqwwi+0BSxwFFP+08gAZqw1GFsxV/G05XxKPR/LFsEQP
         QrJv5nFrbHPN3S6pQ3pkBiuKCVP33ezS7LV3l6ntuxJz4oSXxPFBoNO26m4Qd7QMROfM
         dqHI9fX7KG8Ep55dXJR+qzJRZsDa8ctOs0XUciBlDUg6O+nW4hh7P7t9Z+DFmWQVv+IT
         dMnLnt6JdUD1BTebeylwlm2HaS8s6cvqIs+0WEZoQUxG66w7vJoOYc6kz2UohA3HBtlR
         89Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUMCN+QIzX1PeqbijLQDI6IIAs5johLU6nrCUR/42NE8z1Ns+mpVb3sMNhlAYeLNMtJlTgRtNLM3Vn5v88V@vger.kernel.org, AJvYcCUSwoV7rWTQ0IQ8pMgpvrtrlQwzjM1k+O4A0sDNXRBYhDFy/qDA1MEBAAzjmJVi49JHeajOUPV4hWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETa9qVFaoS+P0lGzMs5kcNoHh+VuYZjDCfXcWbHUUNrVjn3tn
	2GWdBduCPr92gYucGQzJUSeTvyLvO3rXt7zkqNLP6+nlLd2aohUfVMoQ
X-Gm-Gg: ASbGncvnIbXpphN1Quj4JQjMMTfD+DJmeT1m/IR2GdMkIBqLwoqWpaQhaVn976BHlgi
	6zikaU157b2NobDQHCo1BOFYC799+jnVdxopHFrDnX2W3mwg74UutjFT1LJmSwJzfNatSCe9Mbl
	SBHz3BuPKmBdn7dVaF3PUlbude+ACW6Mu115goUVkaL8HQp758CKEDpuX9VjhAORTFIrFvG+wv4
	1UmLqQSgir41WGUffAjRZRt4M6B/6/ENsdNUu+8B2OznpdY23r+4D9jrYGS+OdXVPz9F5QmMTjs
	cF2+0OcFjVXHLxhbwGdNsTmEeX0orEPM9jK8p2rQOKAssVSRcIhOL6aNXSd+l1VPERUczsvDNdm
	I1BtGxIqvrDePg7UwoBoGiCryv9jDwzvbZIPTlTakz6soZhyZzYLjdrfuj2qnj2Dp1j42ySjvw2
	GlbCevD3/fM5xY
X-Google-Smtp-Source: AGHT+IFijFYSmKNXoLF7DEfKZxCuncb+t1/vpJ54akItJfQZ15ECtQAHgRz2NvMRW/Ou8q6QaH2amw==
X-Received: by 2002:a17:903:46cb:b0:238:2437:ada8 with SMTP id d9443c01a7336-23fb31b5729mr149924175ad.48.1753663536969;
        Sun, 27 Jul 2025 17:45:36 -0700 (PDT)
Received: from ?IPV6:2804:14d:4c64:81ec:4bc4:d34b:cde0:106b? ([2804:14d:4c64:81ec:4bc4:d34b:cde0:106b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24011bd1d5esm15213685ad.91.2025.07.27.17.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Jul 2025 17:45:36 -0700 (PDT)
Message-ID: <110ae613-e881-4c75-8edc-ac99df0cf061@gmail.com>
Date: Sun, 27 Jul 2025 21:45:32 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] iio: adc: spear_adc: mask SPEAR_ADC_STATUS channel and
 avg sample before setting register
To: Jonathan Cameron <jic23@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250717221559.158872-1-rodrigo.gobbi.7@gmail.com>
 <aIDoZHBjO4tU3Gkh@smile.fi.intel.com> <20250724134758.43df3ccc@jic23-huawei>
Content-Language: en-US
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
In-Reply-To: <20250724134758.43df3ccc@jic23-huawei>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/19/25 09:10, Jonathan Cameron wrote:
> On Thu, 17 Jul 2025 19:13:49 -0300
> Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com> wrote:
> 
>> avg sample info is a bit field coded inside the following
>> bits: 5,6,7 and 8 of a device status register.
>> 
>> channel num info the same, but over bits: 1, 2 and 3.
>> 
>> mask both values in order to avoid touching other register bits,
>> since the first info (avg sample), came from dt.
>> 
> I read this as meaning this is a hardening change against bad DT rather
> than a bug fix?
> 
> As such applied for next cycle to the testing branch of iio.git.
> 
> Thanks,
> 
> Jonathan

Sorry for the late response, yes, that’s correct — this is a hardening change.

On 7/24/25 09:47, Jonathan Cameron wrote:
> On Wed, 23 Jul 2025 16:49:24 +0300
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> 
>> On Thu, Jul 17, 2025 at 07:13:49PM -0300, Rodrigo Gobbi wrote:
>> > avg sample info is a bit field coded inside the following
>> > bits: 5,6,7 and 8 of a device status register.
>> > 
>> > channel num info the same, but over bits: 1, 2 and 3.
>> > 
>> > mask both values in order to avoid touching other register bits,
>> > since the first info (avg sample), came from dt.  
>> 
>> Is there any issue with a Shift key?
> Sprinkled some capitals.
>> 

I'll make sure to pay more attention to that in future patches.
Tks for adjusting it, @Jonathan. 
Best regards to all!


