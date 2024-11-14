Return-Path: <linux-iio+bounces-12261-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7841B9C8DB4
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2DC171F23FC0
	for <lists+linux-iio@lfdr.de>; Thu, 14 Nov 2024 15:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 700E65674D;
	Thu, 14 Nov 2024 15:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1u6SOaW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83551C68F;
	Thu, 14 Nov 2024 15:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731597424; cv=none; b=CVZljbuqjUOvh/kL1ZVF8RIyUx2rrFJLQPJzY0R3HNc/qq+r3SWuXOlwJc/Opfik918ATp5gpNfc+x2YU44yyGmvuNQ7AjiQb1PuX9ZUQRlHj4An6h0t8ygAr4fkY0ymPcJiyjm56ua44gJpwnOu8ArsepMoMCUUKyJgJv7r6wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731597424; c=relaxed/simple;
	bh=Q53Ic01HLtpIHqWLvJyKZj1a+099VDGe9zfLNq4lzJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YtRElpJqWoaWR+De611ceOMKn2dISH0D3P9F8Rp/mH3klGDxM1s36rQ6EjcckYL04+nsrU3UXBTahHXY5AcxWktWjAqxQbJ6Ln3ieH7WEKWnzB2uNKHHPmy4f22g2ZxCGgoCAA8NylZ2wfcDElCy7xxs3jb2buPSSdXXwXn+TlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1u6SOaW; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7eab7600800so89021a12.1;
        Thu, 14 Nov 2024 07:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731597422; x=1732202222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JotrJzBpOeR2thJqFXFw5L3unIDcudiSGFOlUbzMd08=;
        b=R1u6SOaWSQbaeeGnUPiCBUxi6IaNplaXrNPT2PJX7UO9xRA6/XGNceEmNOTIGHed+z
         Kg37c6g65paBVbPjrp7wSs5DN6Ny7bHfdabsxa43URJgjpSEzXfgdKLMxzaF+SllDCF9
         hgmd4PYXqtIUmLVAR6L7lg5FqL2r7bsOqu+VZ5AAPkXccs7u1WABG0lclfsuyilLR1iC
         ckqqeP2vixqY2fzofuYWJA7vx13s/aFgMplPjw/sUuq4KQQ2nP1XcWWN8eYrW7hkUX5X
         U+vq1GPiOLv13ShJ0sdXILavC5O78CjRnVcpfN21B1ymRCnrcaTq/6j/fCPW9wizdF+r
         S2NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731597422; x=1732202222;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JotrJzBpOeR2thJqFXFw5L3unIDcudiSGFOlUbzMd08=;
        b=Z4dOlyl9m9JJ7B+2ngivHcwotiGS3Ju8SDiIZsJVCOyRYUPgGCLHoJEmQbYukYyoov
         5Mu3ImvDK2ovNgUWkF0iDw0xR2Rud7dIVxrToJJamZkvQKb+EV4EsKHIOsw5GnfyyDgb
         SjsF9nvVkx9ABxb+vlYK212vi6Wkoj4rE7afiC5PEst68wpLsfMfEGJR9JLF5MeBNjGi
         peW5Vk9re05UNkEb+Yop2n6CcL6cF/TzPh7J1vuGwMTU01TR9D3GK3nyYF2oYwrqaCkE
         uvC5ArceGHKaQNrdZuZPIjjEvQAG9njnmmNquaPNWmyDKILbipPNgLDeHpy2ejJKp6y1
         tuVA==
X-Forwarded-Encrypted: i=1; AJvYcCUaeCCNTtoAch1rGgBH7mFJZVUdQ1qLpzrSyuO2gAh+0a4qFXwnGbLcjFGasnoLUgEtqYNzpSHz0GxoqvOm@vger.kernel.org, AJvYcCUckih6DlUEXj+lUxsOjz4DfMOKqXXp7ZBDqgKcVHhcxbv+XX5Igo+XFphNeoZuLsrx6KW0zGapV0cN@vger.kernel.org, AJvYcCVGSKs62Ik/wn5x23dsySASt5/Biv1VTTUewA6WzZ0EPnD5dE3kYPJCK7gqJ88CjoHrcDP+RgiMEOOm@vger.kernel.org
X-Gm-Message-State: AOJu0YxBQcj73Gs+Y2zZl9Uqdm8BBYWCICt+kIpUWiUTdDmwnBS7REJB
	RBnSXsWyfhUgCtDPAAnYqkUjwrCyxULeOnHmv75G2n4Eq57vcFAd
X-Google-Smtp-Source: AGHT+IFOzdCgJiTSHKh+t6Z6Xi2n3e3XGot6bXk4vTvc/TZ9/DAIaY0+AeU1fVaH8kKFm27vl/aK5A==
X-Received: by 2002:a05:6a20:8403:b0:1d8:a203:95a4 with SMTP id adf61e73a8af0-1dc2296d9b1mr15461701637.5.1731597422055;
        Thu, 14 Nov 2024 07:17:02 -0800 (PST)
Received: from [100.116.227.126] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7f8b36dac83sm1215797a12.14.2024.11.14.07.16.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 07:17:01 -0800 (PST)
Message-ID: <b59f6933-e1f1-49e9-be61-3e3b4323da87@gmail.com>
Date: Thu, 14 Nov 2024 23:16:51 +0800
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: tyhx,hx9023s: Add performance
 tuning configuration
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, yasin.lee.x@outlook.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241017-add-performance-tuning-configuration-v3-0-e7289791f523@gmail.com>
 <20241017-add-performance-tuning-configuration-v3-1-e7289791f523@gmail.com>
 <20241020140638.127a9dbf@jic23-huawei>
Content-Language: en-US
From: Yasin Lee <yasin.lee.x@gmail.com>
In-Reply-To: <20241020140638.127a9dbf@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/20/24 21:06, Jonathan Cameron wrote:
> On Thu, 17 Oct 2024 18:36:44 +0800
> Yasin Lee <yasin.lee.x@gmail.com> wrote:
>
>> When hardware design introduces significant sensor data noise,
>> performance can be improved by adjusting register settings.
> Questions inline. Mostly around why these controls belong in DT.
> What do they have to do with hardware / wiring etc rather than being
> appropriate for userspace controls.
>
> So almost all are definite no to being suitable for device tree bindings.
>
> Jonathan
>
Hi Jonathan,

Thank you for the suggestions in your recent email. Following your 
advice, I discussed these configurations in detail with engineers from 
the HX9023S supplier. Based on their feedback, these settings are not 
intended to be exposed to end-users. Typically, these configurations are 
adjusted during the DVT phase of the end product by the supplier to 
optimize performance, after which they are finalized and not meant to be 
modified dynamically at the user level.

Given this approach, it seems more appropriate to provide these settings 
as part of a firmware file, allowing the configuration to be kept 
internal and managed without user-level access. If this approach aligns 
with your thoughts, I can prepare and submit a new patch focused on 
firmware parsing and handling for these configurations.

Thank you again for your valuable guidance, and I look forward to your 
feedback.

Best regards,
Yasin Lee



