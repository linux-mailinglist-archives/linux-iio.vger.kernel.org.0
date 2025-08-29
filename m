Return-Path: <linux-iio+bounces-23375-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5886B3BDDB
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 16:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF2B41886640
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336551A238F;
	Fri, 29 Aug 2025 14:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GurNBUas"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9666F06B
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478004; cv=none; b=k/88Nl/Mgks5GAQwtlE2GwD1gr13ufZao2h1hkbej3xB+ySxJwUe+6Wr69kpaQ657+9bLi+fP1P0djbPFQ3FvlPyA1IIBDP7o+kTtf/0RF/kED/aZinvWJ/jr0/bm+MuU3lbF2HahpTZtI+sZQj59S105cq4om7SlyUBtzwUuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478004; c=relaxed/simple;
	bh=l81BdILnAHK6FsYs0Y9jQzHxRexRXeF2IVvV05O2aJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FCy0mgpKzAF1U9s3Ku9xS5RzBS0z5T6YQJMRULeZI7F/DaFkqyDvBCTY6/s3jntxVWCduIpctqjLgmxi+UU5y+hK7+SdGnf7Lx3v0MI0if8neyeDG9pkDWDCZYw7b74QX8ZSp9Pjl5HjMblktmxKcBwbLhM/V4dDR7u8dF0q/+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GurNBUas; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-315a297f9a3so1371941fac.3
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 07:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756478002; x=1757082802; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fccWCsPWspsXnmo3DlJfxRVUkNV3yNEWzivtfiAC5t4=;
        b=GurNBUasxkcNb2xf0WdafjxGoUIsVLUdB6UJ280nuLIyrkinrVK4XINFUP9OmV7Df1
         WtOh5hxY2Qqf8Hon+Su5NPvpHV/UX2nNMDchQdlZ8GDRY4toKQ3dHGUstiCE616eA2b0
         57BUPOXS/qg3ftumDvbjaYUCAMb14UcDipObRKhbYVj86zyr6SqeAQ17DEwbWaNWtoT4
         HKTrb7ySt5zIFrJglBLFIBCDW1JmFdaWJvR59ZHEd8txkGUYR7H1S/s+1phfF9K2ZRjU
         Pt6eKzpOCLqk4gasbQ/IblubroLaLw3bHEpRWF0e5o6eht+I0Xor6kDhhu1qy/gxRtNb
         t+rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478002; x=1757082802;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fccWCsPWspsXnmo3DlJfxRVUkNV3yNEWzivtfiAC5t4=;
        b=XqwKHSYR2fGt/lsE8O6AIgCGXGJqiRfru4Dtcqgvnj0fbqP7a4CDNdZtm5PqI0UCyI
         mDxlpe/I3dXFS39SNNpqZqIjgBfd1LT02uDwxjRwoILeAawqev1PDKY6ThvLtO/iN4YI
         xsX0VQP9GO6NTCLpCqOI9pVXrIuUAt6z8N/9YoUAGkqnno3yeptIPdEfBU/AlVtVbn4Y
         PF7oWCKJw4ngLUCWrF9gRw1UW09GjgIB7rCoTzxTEt/t5EB9ncyqsC+MbnTsWMxCKipE
         GLRr2OASajhL0pEKQ+lz73o+R+UwU8KS0u72ctJJfsd5SWlYH0e4b3TMyhP5XN2Uyz//
         UcfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVMQkTS3miF6DvV8HI7YoauEOwScm7lLiUKV09ZK2r5ZNIT+Txxdc7FXciGQtyrSZNGNqi60kwz0uY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAg35Nc4AbztK2NWLk/x1GZ2kJSR7mlxLvJG+jS2sdws/Hnbdp
	HyKOgGm9JC9nR3e8GkTopsewb49gpaWwDVWjYG8t8l6RqASLznu3epgA4HaMlbteHhI=
X-Gm-Gg: ASbGncuim78qi6Selb7XHDgEy3mGEbW3Iz/DWmwbYdRJtge5hCgoRNqLOuN7px83yX0
	lQRpf/uXU3HI5GrR9Si0sX1NXi2otIADMdhcjPVv9A3HAfHf4avzs9Rf4xBGiOFEsDri16sy0T8
	7unMx7QxG12a99IOThxg0bRwubXfG3Lg5Youy0DbqefQXPulGBxlSsuGn2ERluPts8EyZWbVIo7
	UemAiWPR/Ey1Ng4AzXEFTqHKoPbrtIvOg+xofC7nFi9Sir8KZkDIakDPVEuTN72/EAkO5LLjCFq
	q6SWDhIzpCisBycfx8JDxSzY9z1H0lSU5iBMEa94xpxZoDQdSeF50J+GE82D4b+YA+yZ2YtneAh
	rgnC9eDpPEwXr9b33z6MC9GFTm3wa8eKET90JQEOyb+GoeAb+jFXEYZvWXnk3OHuq7LkEqaiqwf
	M=
X-Google-Smtp-Source: AGHT+IHPpzypiunukkYsGFJCzAm3KCAiiuwpfLa8vQc27XWjVfIJq/1M89o3sxi98PpV5EJf7pg5qQ==
X-Received: by 2002:a05:6870:2b0f:b0:30b:ac14:2b3e with SMTP id 586e51a60fabf-314dcdcc95amr13932019fac.37.1756478001574;
        Fri, 29 Aug 2025 07:33:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afc59dc7sm1348162fac.10.2025.08.29.07.33.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 07:33:21 -0700 (PDT)
Message-ID: <34290faa-0e0d-4935-a8c7-b2b1b052e37e@baylibre.com>
Date: Fri, 29 Aug 2025 09:33:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Dixit Parmar <dixitparmar19@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
 <20250829-fluorescent-delicate-pogona-c96b5f@kuoka>
 <CAFmh=S3jKfGMek=ZPUrfgh9fXZaaq6zNBOmCyEpoe0qGpfbt5w@mail.gmail.com>
 <75b2db61-84ad-47a4-b809-da7e63e8dec8@kernel.org>
 <CAFmh=S1K5Okfs30m-d-etXhpPTgQ=pb9+Xnr0DWZ5AXkqFKQ5g@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAFmh=S1K5Okfs30m-d-etXhpPTgQ=pb9+Xnr0DWZ5AXkqFKQ5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 7:05 AM, Dixit Parmar wrote:
>>>>> +INFINEON TLV493D Driver
>>>>> +M:   Dixit Parmar <dixitparmar19@gmail.com>
>>>>> +L:   linux-iio@vger.kernel.org
>>>>> +S:   Maintained
>>>>> +W:   https://www.infineon.com/part/TLV493D-A1B6
>>>>> +F:   Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
>>>>
>>>> There is no such file here. Apply this *patch* and check by yourself.
>>> That file is being added as a separate patch(Patch 2/2) of this same
>>> patch series. It's already reviewed by you only(based on the name).
>>
>> No. Read my comment again:
> I am not sure If I understood what you exactly mean. Below is what I
> understood, please correct me if I am wrong.
>>
>> "Apply this *patch* and check by yourself."
>>
>> It does not matter if you add the file later. The file does not exist
>> now, here.
> 
> I have applied the patch on the latest mainline kernel codebase, it
> gets applied successfully.
> But yes, as you pointed out the
> Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> file does not exist by applying JUST THIS patch. That is because that
> file is introduced by a separate patch under the same
> patch series mentioned below.
> If this is not what you mean, I'd request to clarify to help me
> understand your concern.

Each patch should stand on it's own and not depend on later patches.
As you said below, the dt-bindings patch should come first in the
series. It is OK to also include a change to MAINTAINERS in that patch.
So you could include only this part:

+INFINEON TLV493D Driver
+M:	Dixit Parmar <dixitparmar19@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+W:	https://www.infineon.com/part/TLV493D-A1B6
+F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml

in the dt-bindings patch and then add:

+F:	drivers/iio/magnetometer/tlv493d.c

in the later driver patch.

This way, each F: entry is added in the same patch as the new file
it refers to.

> 
>>> https://lore.kernel.org/linux-iio/20250829-tlv493d-sensor-v6_16-rc5-v5-2-746e73bc6c11@gmail.com
>>>>
>>>> Your patchset is still incorrectly organized. See submitting patches in
>>>> DT dir.
>>> By "incorrectly organized" do you mean order of the patches in the
>>> patchset or anything else?
>>
>> I pointed to the docs, is anything unclear in there?
> I did referred the docs you
> pointed(Documentation/devicetree/bindings/submitting-patches.rst), as
> per that only one point which is
> being missed here that is #5 _The Documentation/ portion of the patch
> should come in the series before the code implementing the binding._
> That is applicable to dt-bindings patch of this patch series as the
> dt-bindings patch is a seperate patch.
> Apart from that, is there anything you think this patch is missing,
> kindly guide me.
> 
> Thank you for review,
> Dixit


