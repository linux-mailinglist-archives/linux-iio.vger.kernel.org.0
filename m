Return-Path: <linux-iio+bounces-12258-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D59C8C58
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 15:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0C691F22AD1
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 14:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AFC13A409;
	Thu, 14 Nov 2024 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PH3EBi4V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191AF3BB24;
	Thu, 14 Nov 2024 13:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731592786; cv=none; b=hkjZTW4/0W7TjzQu/byvOuWH0i5HAEvh88dMtn/qOtITsSLgREg+Jwq9NCs/Ot6cJgvrSdlNs97//fM2Rhf5s40kWHj5Nxj4hlqOO+0kSEt1vioY0lNGwhuRD5M2O5kvoWOJ8N0vYMiyFy4a2ufkvBDidDL2eTFz+LoeayPLNUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731592786; c=relaxed/simple;
	bh=st3ZJaTgzg0Q7HS9Zd/0/LvKr8GBoyzIyfkT1MeMkQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ca/zj31mWoa/a38AcOMvFpLwNCM3GoYBPA+g3/ZXHZU0TYBY/azs3qWMG6VoE81lAi0KswRSgRvx96rHqMPDxRst35BD9vaVi1AiDTECxIW+gEvu1wCzwJXxHJHM2/cTXGeV35QDy12DOZQ/oGUgzlLmSHcRQbwBamV3jHbSFpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PH3EBi4V; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5cec93719ccso754160a12.2;
        Thu, 14 Nov 2024 05:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731592783; x=1732197583; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X6eLuWYyfigYmEkgfeOfnEFTkRCPuPKOBVwDODGgCHQ=;
        b=PH3EBi4VcEXkXtc4TpnaAWS/pxip0SLY6V7JRNFkgERpm70XdXpfAWxpT0b0Q+3xXh
         oPW7fswQOIRzTkb0u3ToKp5VfMqSeIad9It0VjOR43QrKwUiJTPSISWWOfFFL6HV32wq
         O/C7o42KoShbpy20Fc76JRqz5R2XQEZc2LXY79yiHP4Koolu/j9a3jHVZrYzUEDKw9+y
         eFwa71Di54eYyINOsV8nwVgtFdUSCVTwuq84BWXH6HmZbxmig91Y2xiIqI+dX6eakhmJ
         TQAjh1lLeGelv1yqO0tqh5Igxh0A82zUionhwzbj4D2c1wcSeYf9vx9dvVDHk5m6u4pA
         rPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731592783; x=1732197583;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6eLuWYyfigYmEkgfeOfnEFTkRCPuPKOBVwDODGgCHQ=;
        b=KyGrk07dqmkRp5ZASLI7Dapw0pQ9fEgOnuwIt/ogabN6e1i1pVQtl6uyi/J1755IAr
         h+BJhFbRk7OrYzHlZmRf2+KMegRP9O67XVhl/NW+vMEw/EUZ4tmDeOKo32axtzIKgfsu
         /E+h928JVnXp9WdQOwlh8D3ykYtYZYYSm3cYcmY06/OxHVT6WNjNSLE+hfaqTXMbWSug
         /XPNUc0oWIez1Lt2fOcObH8HXOZjhBD+B5VeGW/4FdeBGc/DNr+jSzDW9s17CHmHmjcx
         ppOEphrk2aaDtePCLQ2MT7mX1nRpvBSR9JoNRbRX72F7b3aQCmRxU5XPnhWdcBz6aBlH
         8c1g==
X-Forwarded-Encrypted: i=1; AJvYcCUd9NpOOH2kHw0oC7eVuKzXZ+fLt9yhvN+wE84kmXWsUzKXXfSvnRL8ByhX3dnGwjQMIgFFV2vWPHvNJp6L@vger.kernel.org, AJvYcCVfGNzmDNKPcsnJtnSoRlJQriRjO5IxctWouNZm1+Qff4P3batD/THkt0LJy0q+HhW2Bl3lslhJ4JIk@vger.kernel.org, AJvYcCWsDBOEDLAHuCkfasu+q8pPENIijZDuwcobSVwdpPkbBau9k7HQIxOHTNxFpa32LCWh/vnwFEhRNsyI@vger.kernel.org
X-Gm-Message-State: AOJu0YzlQuJgv3doQrMbJao347hUE4BhBukREUFoPerNg3250JHa+7Tw
	uwFq//TUghJQ1yih+CAVCmRnb2BFKcVUQAktNCktldcLzw5zlXxU
X-Google-Smtp-Source: AGHT+IHwYGIEKERhQFxmc9MhQHw4vw4OF1GEeUoqtJTrXpRyP41UFT1nafl6A2SUeeliOrskvr1WXQ==
X-Received: by 2002:a17:907:2d91:b0:a9a:3dc0:8911 with SMTP id a640c23a62f3a-aa1b1057243mr1006541966b.16.1731592783172;
        Thu, 14 Nov 2024 05:59:43 -0800 (PST)
Received: from [10.10.40.97] (91-118-163-37.static.upcbusiness.at. [91.118.163.37])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa20df1c53asm66915966b.15.2024.11.14.05.59.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 05:59:42 -0800 (PST)
Message-ID: <68f41c2f-3fbe-40bc-a4ec-a6c0ae6862e0@gmail.com>
Date: Thu, 14 Nov 2024 14:59:41 +0100
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: iio: frequency: Add ADF4382
To: Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Kim Seer Paller <kimseer.paller@analog.com>,
 Antoniu Miclaus <antoniu.miclaus@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241114130340.7354-1-ciprian.hegbeli@analog.com>
 <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <20241114130340.7354-2-ciprian.hegbeli@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/11/2024 14:03, Ciprian Hegbeli wrote:
> The ADF4382A is a high performance, ultralow jitter, Frac-N PLL
> with integrated VCO ideally suited for LO generation for 5G applications
> or data converter clock applications. The high performance
> PLL has a figure of merit of -239 dBc/Hz, low 1/f Noise and
> high PFD frequency of 625MHz in integer mode that can achieve
> ultralow in-band noise and integrated jitter. The ADF4382A can
> generate frequencies in a fundamental octave range of 11.5 GHz to
> 21 GHz, thereby eliminating the need for sub-harmonic filters. The
> divide by 2 and 4 output dividers on the part allow frequencies to
> be generated from 5.75GHz to 10.5GHz and 2.875GHz to 5.25GHz
> respectively.
> 
> Signed-off-by: Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> ---

...

> +
> +  adi,cmos-3v3:
> +    description:

A nitpick I overlooked: default.

> +      Sets the SPI logic to 3.3V, by defautl it uses 1,8V.
> +    type: boolean
> +    maxItems: 1
> +



