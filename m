Return-Path: <linux-iio+bounces-6442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C75D90BF31
	for <lists+linux-iio@lfdr.de>; Tue, 18 Jun 2024 00:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17925281BFC
	for <lists+linux-iio@lfdr.de>; Mon, 17 Jun 2024 22:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93F51991BB;
	Mon, 17 Jun 2024 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="cMTWlvI6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25416188CCB
	for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 22:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664545; cv=none; b=YNMdxoeuVF3ei7ZtsqR8rKplPBLahCI8YzfECt+piNSMiySb4+/xE1G1FWxSR4WFZBVpoEbZ/ze8Z5qT+/b7+K6iELYuecr9QHwnrl5I7wj6SMso16Egi31Wyq4u6WW1tU0crQjp/R/MMpIszIsWudK3uBpxNdTTu1x26MFWfwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664545; c=relaxed/simple;
	bh=ueYzZgbvAUNDZkrGEz6vOlDUxD8uOeTU0sliktE6zI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dsi+XtJc6IwsiNbz3qZeim50mDcWdlW6lPPM/r2JXHlkNLLM+sw0dnS6jP+ScYfCEyLaHH//094HP9GSvbhxNAiN4sY2esaGMoftAtCdHMr7UtIZU7Lv0kfXnSpZQNxa3guHa70khLMxP/p1DNAfaqXeCsxnlI8mJ66jCGbN1cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=cMTWlvI6; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7955ddc6516so346965685a.1
        for <linux-iio@vger.kernel.org>; Mon, 17 Jun 2024 15:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1718664543; x=1719269343; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xM8jG/UsV813oqKhDlzQa/ArpF3gbsVPG1rs8S8vCkE=;
        b=cMTWlvI6u87kbM5ZOQF4KOQ0c0G9VesFQjRBc1ECjOCAjdxVHJr3Ij1dN4N8KuyUPO
         CLi9iZSVbP/ajKhf0ndWpxwT6RKEx65Ys6yrBNBOZj8lmzHbCv46pIXfthEgSTaItOph
         m8vcmD2FssE2W+uy+TdOfBSIB+VKsYklW5mXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718664543; x=1719269343;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xM8jG/UsV813oqKhDlzQa/ArpF3gbsVPG1rs8S8vCkE=;
        b=KTmt4hd6acb1XXeM5110Ivja8ZiyCiK7Fb3p1mNat0d/jE6bVkoJ7pJeY+RbYzx5nj
         tCweIq8klQVcGOh83T4yfN48L/oCYXNYmHnWSTGB1xfZPcUr0wpieZJtYnJ7fxJXtS9g
         4Xa3MggeGonIFfuVHiT5mVI01p8h9BUe4wr9JmiHfVM9orT3KPVJxHwhdLZwesBXGkFQ
         HJIDGqS9K+eCEyj57IITNmd86tDX14K2USayOtpQh7m4NxRbarct/CkZXFYv+rBrYK7O
         RWILJdUo3clQNjYOG1ISOEODZZMdK/7ahZ/iZJZIRbSzJyelSKgOTYkVC3Qv0fKR1Qdc
         XTqA==
X-Forwarded-Encrypted: i=1; AJvYcCUaKsMkMg01c0jesLJybxFlIWHuYBXdNK/pm+ksqBZ4cdCfR5tGAaDC1t27Sjc8o3XbfspzOQRxfUWYwWFQ4FqqyfQPIlYAbPZT
X-Gm-Message-State: AOJu0Yzspnj0TJKYO+C1bgWMSppaEirOoFojaupF3zOBYICKktRsmq1d
	UhCWaFGHypFGOxDOB9wx9iQlwVbn3G3AdMFj4llDORl609+j/w6NSk8ZH5EhTg==
X-Google-Smtp-Source: AGHT+IG1TVLwkGCX9fV8eplKGeOZTo6xGldUqIBRIebpDcT4omSEc99laqur9v3lhz3IaqOpqZt9Sw==
X-Received: by 2002:a05:6214:2d0b:b0:6b4:35fa:cc17 with SMTP id 6a1803df08f44-6b435faccf0mr3968436d6.20.1718664543067;
        Mon, 17 Jun 2024 15:49:03 -0700 (PDT)
Received: from [10.66.192.68] ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b2a5ee1327sm60264676d6.118.2024.06.17.15.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 15:49:02 -0700 (PDT)
Message-ID: <25275668-0441-4015-9a94-aab305865fae@broadcom.com>
Date: Mon, 17 Jun 2024 15:48:56 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/vmwgfx: Fix missing HYPERVISOR_GUEST dependency
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 lkp@intel.com, zack.rusin@broadcom.com, dri-devel@lists.freedesktop.org,
 daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, linux-iio@vger.kernel.org,
 jic23@kernel.org, lars@metafoo.de, nuno.sa@analog.com,
 dragos.bogdan@analog.com, anshulusr@gmail.com, andrea.collamati@gmail.com,
 oe-kbuild-all@lists.linux.dev, x86@kernel.org
References: <202406152104.FxakP1MB-lkp@intel.com>
 <20240616012511.198243-1-alexey.makhalov@broadcom.com>
 <20240617090709.GCZm_8vdnLzt048UH_@fat_crate.local>
 <0a29389e-8ba2-48c5-bb26-381de58a62fb@broadcom.com>
 <20240617211758.GKZnCoBvT2enGx5p5r@fat_crate.local>
Content-Language: en-US
From: Alexey Makhalov <alexey.makhalov@broadcom.com>
Autocrypt: addr=alexey.makhalov@broadcom.com; keydata=
 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 EuY0
In-Reply-To: <20240617211758.GKZnCoBvT2enGx5p5r@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/17/24 2:17 PM, Borislav Petkov wrote:
> On Mon, Jun 17, 2024 at 01:51:23PM -0700, Alexey Makhalov wrote:
>> Not really a gcc related, but the matter of a config file. It is
>> reproducible if CONFIG_HYPERVISOR_GUEST not set, but CONFIG_DRM_VMWGFX=y.
>> And this combination was allowed before the fix.
> 
> Using their config:
> 
> $ grep -E "(CONFIG_DRM_VMWGFX|CONFIG_HYPERVISOR_GUEST)" .config
> # CONFIG_HYPERVISOR_GUEST is not set
> CONFIG_DRM_VMWGFX=y
> CONFIG_DRM_VMWGFX_MKSSTATS=y
> 
> $ make ...
> 
>    OBJCOPY arch/x86/boot/setup.bin
>    BUILD   arch/x86/boot/bzImage
> Kernel: arch/x86/boot/bzImage is ready  (#2)
> $ gcc --version
> gcc (Debian 13.2.0-25) 13.2.0
> $
> 
> So no, I can't reproduce with my compiler.
> 

That is interesting! Happy to debug it, but unfortunately I can not 
reproduce your "good" compilation without the fix.
I tried
"gcc (Ubuntu 13.2.0-23ubuntu4) 13.2.0" in Ubuntu, and
"gcc (GCC) 12.2.0" in Photon OS.
All of them fail with an "undefined reference to `vmware_hypercall_slow'"

