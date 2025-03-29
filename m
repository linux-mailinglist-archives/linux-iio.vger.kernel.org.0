Return-Path: <linux-iio+bounces-17324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CE4A75695
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 15:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E06C18907A6
	for <lists+linux-iio@lfdr.de>; Sat, 29 Mar 2025 14:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8E51CFEC3;
	Sat, 29 Mar 2025 14:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oqku1uwJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97279322E;
	Sat, 29 Mar 2025 14:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743258136; cv=none; b=DOfhDq3kN78Ek8GiFI1sOMTuGtI2dzRteg2bDD1gaNSFYixTKpV8M3G1BERu2VwE183DCQpYNfQx0z422OvAuRPnbaRatp9XCKf2KaiPyBCxd87JnzQw75Ot5eRO72TiwSd05fk3EPbQPC+Vb7fUkVKuvn16Ynktv0IzbCv97IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743258136; c=relaxed/simple;
	bh=W5zXdE0gSDbdo+ZO1IehbQPjJEje+9os6N/+p39ckoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A//RQrSG1Crs4ATSxw0d1sKOzbO8IWYfJV646n8VLKXgUHmVKkHt/sJO76QNRxckCmGfhmfakIBHLag+IqzpXGPAHbtGQXL3S1xNw0IA/bc0VoTiaeT3qdsfXcAkkROXRi6Nj6udz0ZMIlHJfpG1ouYLjCr2NPeV4RCGQbrsyrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oqku1uwJ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso5016576a91.1;
        Sat, 29 Mar 2025 07:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743258134; x=1743862934; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ea4oCi4ZzhEYMXRj+gFFnpg9NYvTMUNz38hrWaosUeo=;
        b=Oqku1uwJ+tqI2ilAkZCnXSZ5PDz31j7XLokUMpQfy5tnmVcnIeZTF69m8Vj3Nn1IwY
         Zmma8xYDlb1CT9eqljC6tQvdzg2Hh8pOXKqboaXQLMxw0b/i3K7xjBDkDUJBPnznT7/V
         N74HcmVByDks5ebg+PTiPaltIEHLNAbkqJW4xouqN1Xerzpps7zRQCd2ZleGuwdL4tJQ
         EbFqt+FHVCRQOU5jkgRa3TWDD8XXVW08YfYhFZ9vTWixoiVmrQ2kOqTauspvEAIGD8BV
         1Yr7er93Vr2h9RMHlLErkZFTvhrQhYnIk2l5kmZSTtSSKlGSNaqssFechRghICjG/vDt
         N1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743258134; x=1743862934;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ea4oCi4ZzhEYMXRj+gFFnpg9NYvTMUNz38hrWaosUeo=;
        b=Y+kwwB0drGisaYOD+4HeHCVQ/kHmVv1awmiRNsWDRn26j9PaG01pSU/ixQbkHhas9b
         jzEFSus9pkJOeYUtJjj10WVNTWu1NUJ9F8AcVzPZknpS10Zs8Zaizq9GygCfPM+tkU7F
         bVLKC2z4hHyehQxis6Clds+pOQ+i2jiVhNllPIDxgDmmUYjGpkztPuY3Iw1PyoRcQ9iI
         d+NNv5Iz3Swyr3M5gCsJjlQNMVxtvIRSrfgpvdvYxSnPbFIOnr3IzIYGJz+5iFvgO4oa
         xNGrQouQFMxnFYs3ni6I4hlugTCWa6RveCTwOTHx1zmRL804EDE0RUPeTV+2ZuvNlyXn
         NRKg==
X-Forwarded-Encrypted: i=1; AJvYcCVWtvdy59wOlRC4Y6H+yQNCzKW97LX0K64fsLlrMjqsEY+OcJVGbGhRFC7p9v8wcwkCYgxrLbeN9IAJmeGq@vger.kernel.org, AJvYcCX0g4xxI+tl667A5wAxMWxX2M+ryHcAh26PlK0o+1+3LQr4hBvHHjB6P5TfyM4fUS1z8f1edrV+NKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMEsnvwtbPTEq7PaljXJ2ky53tYxm9ceYIffjqOTq7xd6htBeu
	sOTL5bitxQl2+XaMpb3LZAKsrN2X07pEDprUklKB6Pal1dLgVKGMVdLFB3ea
X-Gm-Gg: ASbGncvpToxwVFsmayrquq/EL7CxeLlALlDo6P9CjWOoErVRyb4iG0eAf7DzjTzeQPe
	qt5YqBvGwGKgj3cTta2nj53zGcNY/kSS+QA3H3vOQFyP7+I+0wKQKV2uUl5LYbMkeMXRLjvBqnj
	9yghUJd1HEc64Vqrpudehw64Ae5E9LOWN24I/5xS84mthv6UXUhx2gNFoRY3o2jbEwMmEMJ+BSi
	DH3KkIOi0Brl2YWEliDyceZjVqd16nOqeo0gHUn1JaSeoLZtCE2eaSBUnqm0y1GP32Y1zkROQMC
	JlkRL6+wO+E7BfjzobGzN70UbRXToo+xaWpCldNHoeKcvh4AMkwRZw==
X-Google-Smtp-Source: AGHT+IGcNqsUrcUuHeUJn55qlKvxmXVIIhmFGZGGh4XAsazGs1VCjfeK5+AAkcRyEIw9NxzbLlLU7A==
X-Received: by 2002:a05:6a20:9f07:b0:1f5:9cb2:28a2 with SMTP id adf61e73a8af0-2009f644838mr4606265637.19.1743258133640;
        Sat, 29 Mar 2025 07:22:13 -0700 (PDT)
Received: from localhost ([2804:30c:b03:ee00:e0b8:a8b8:44aa:8d0b])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af93b8ad842sm3278024a12.50.2025.03.29.07.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Mar 2025 07:22:12 -0700 (PDT)
Date: Sat, 29 Mar 2025 11:23:15 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: rose <i.roseoriana@gmail.com>
Cc: marcelo.schmitt@analog.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, dragos.bogdan@analog.com
Subject: Re: Guidance on GSoC 2025 and Future Involvement in IIO
Message-ID: <Z-gCU0apzDaKu1h0@debian-BULLSEYE-live-builder-AMD64>
References: <Z-HSqixMyrfqAtq1@epsilon>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z-HSqixMyrfqAtq1@epsilon>

Hello Roseoriana,

Glad to know about your interest in the IIO driver GSoC project.
If you haven't already, please, have a look at the project page
https://wiki.linuxfoundation.org/gsoc/2025-gsoc-iio-driver.

On 03/25, rose wrote:
> Hi everyone!
> 
> 
> 
> Hope you're all doing well.I'm a CS student and has been interested in Linux kernel development,
> 
> While I'm still new to kernel contributions and open source in general,I'm really eager to learn and get started.
> 
> As a beginner, I find it a bit difficult to find good resources that could help me get comfortable with IIO or kernel
> 
> development. If anyone has some time, I’d really appreciate any suggestions or recommended resources that could help me.

The Linux Foundation offers a free introductory course for kernel development:
A Beginner’s Guide to Linux Kernel Development (LFD103)
https://training.linuxfoundation.org/training/a-beginners-guide-to-linux-kernel-development-lfd103/

Alternatively, I'd suggest to go through some of FLUSP's tutorials
https://flusp.ime.usp.br/kernel/qemu-libvirt-setup/
https://flusp.ime.usp.br/kernel/build-linux-for-arm/
https://flusp.ime.usp.br/kernel/modules-intro/
https://flusp.ime.usp.br/iio/iio-dummy-anatomy/
https://flusp.ime.usp.br/iio/experiment-one-iio-dummy/

> 
> I’m also interested in participating in GSoC 2025, but after looking at past proposals and timelines  that is 
> 
> asking for the exact time line which i  dont  know  yet  and have no experince  in contributing  so ,  I’m not sure if
> 
> someone totally new to the Linux kernel would have a good chance of getting accepted. Do you think it's worth applying,
> 
> or should I focus on contributing first and try in the future? Any advice would be really helpful!
> 
>  Looking forward to your thoughts.

I've added a proposal template to the project's page that might help in planning
a timeline. Though it will help you elaborate a good proposal if you have
previous contribution experience. Anyway, both plans are valid. You may apply
for GSoC 2025, and you may also start contributing to IIO. If you end up not
being accepted for GSoC 2025, you may consider contributing to IIO throughout
2025 and early 2026 to become a strong candidate for GSoC 2026. Choices are yours.

> 
> Thanks,
> Roseoriana
> 

Regards and best of luck,
Marcelo

