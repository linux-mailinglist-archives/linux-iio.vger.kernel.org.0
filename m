Return-Path: <linux-iio+bounces-9009-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF3696892A
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 15:49:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365B11F214D6
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 13:49:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9504E20FA8B;
	Mon,  2 Sep 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WiZM7fpu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC10219C540;
	Mon,  2 Sep 2024 13:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725284974; cv=none; b=vDnspsxdIY03VKleIqvAoaM+tblcvThm/1fU5txz4nrEcyjVkN8IglGFvfREm6M0pN8WNLXlOQj3YjV5v02B2G6XI8siWj89xzvo3IFlnZ5t1bwQvRexUEYwCwwV2/5qfjKFO0iqM/+jxTywREtkv9UEbufoR6A6MxdMA66O5bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725284974; c=relaxed/simple;
	bh=MuotcNC2Ofew4o0lVYVFeCTkWuoce6Q350Mri7/FVBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMpoD95txgvyTsIjJBy4v9lMOSPmGMCDfuLFyBrG9LdwSEvS6gzYojh2Nt9yFvA4XgVz2vMpJj0OMCTMEEgaLEzhsd7OkhARYlFMTEA2rfG9wtGIPcM47KcOmEI+Yw5+UK0y7HQUYgcFcPi+wD1GxAtC2pYkBd1K2QA8vHqNfI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WiZM7fpu; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7c691c8f8dcso2752408a12.1;
        Mon, 02 Sep 2024 06:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725284972; x=1725889772; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2ZzNZuMV6SaDDF9OnPRif3c6ztK8frZW+O83/6cgM8w=;
        b=WiZM7fpu1vQ238qqA/vNZLK00pOZSI12GwyYCL8dyGxpYBYjuSyW2/yyJIDVRxHPwr
         w94yRBDxkV+g9aJPSlTLAf7f9ukE4NbhuuOLmzxTh/qHFVwzw8yBp0hcA1uqpbF4elus
         FtHK8yMOF+C13yq+n1WyfHhdeaNN8hY28OAVMLd+/cR1N8pPo0kdVfLrbtKcNkDnCV/j
         eukV7AeZpob98poDZCGocmw5bvUWjDMeBoWX3fwKYMKBm5ikHFWHFknHPFqZXi+3QDhE
         SFxTt6W4xRcajfk5R0dq8mTtsUouzZh4l3iqFPr1D1Ggx9bkyhuTklFG8bd+2TkZuhHM
         vhbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725284972; x=1725889772;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZzNZuMV6SaDDF9OnPRif3c6ztK8frZW+O83/6cgM8w=;
        b=q0cK1CVWfQURowjNB/e18uzObt8K3mbX7J299CDwmYtFj8DL6+2lkfcC8H3GoGHo2d
         aZ0bJl5lS5ytdpEZEtRa5sYxqOQIuN2Akhzo6EcVrw+lIAWihtNwh8RMfwI2sEGxGA/5
         zcJBt8KYM01LGf7VTmQgzDyF4rTeskVdHCFrvXlz1GnYRSPxwRJpu5jZSvSzgF0/6CAv
         NRUZKgD4DnyWIwGxNvNZg3v50dm+Vkt3eLXiJhpyggBO6hsAPFr60ZyHTXDvlAU7X0FB
         guYxuMTWbsalw/PUSQOGA5wppj/KOhigRBOMsOwQUQfYPmbmjgglZpOD0a5JE8esQ4pO
         gCIw==
X-Forwarded-Encrypted: i=1; AJvYcCV17+LbITnLIi3T0aBFKPr/5OIhTopHjkk/+mt+veFqLKoB+QN37J0OkBMzaEhf4wNpXDDzbZL2GHJX@vger.kernel.org, AJvYcCWB4ZzkHQXpFlPakHCL2Y6F6JDgw15PTiuZmkDam9yjeoKvrbqWEpZW8vQTrdyb2O8c7UM8BclIXNFO@vger.kernel.org, AJvYcCXH8CrEPr8YejB8ywrhQohRUwunVOR6YSy/6WZr1alIohr71uqM876l0AYF8OS+mn8MjNkxxCKOvJknd9M=@vger.kernel.org, AJvYcCXwEBvNrj0iZa0BKRIRoUr3qQJdyawiPA/ritCE7rMLDJbcerl1OhuSskhITAvtz1mFPai0QKsI9cN/@vger.kernel.org
X-Gm-Message-State: AOJu0YysaOfdHFPCgUC2dAVmEsGSLcg+O5A0WvtFxgoiQNIudWYvWlmd
	9rXJhquyzwHEy2BlclwQkpCLMr03KwFsY8quI9T1StdVshjQBslekbSACA==
X-Google-Smtp-Source: AGHT+IGTYRCQphBuR1X+mGfL82ToqwFirApgXdl0UeJzvWzyxi5CY28AejzRR3pPYW4A2gzvjdwvuw==
X-Received: by 2002:a05:6a21:3a93:b0:1cc:c202:b289 with SMTP id adf61e73a8af0-1cece2d1d10mr7906460637.0.1725284971892;
        Mon, 02 Sep 2024 06:49:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d85b12553asm9176058a91.22.2024.09.02.06.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 06:49:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e389bd50-7ab8-4ccf-b85b-052da4669159@roeck-us.net>
Date: Mon, 2 Sep 2024 06:49:28 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: AW: [PATCH 1/2] dt-bindings: hwmon: Introduce ADS71x8
To: "Sperling, Tobias" <Tobias.Sperling@Softing.com>,
 Conor Dooley <conor@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "jdelvare@suse.com" <jdelvare@suse.com>, "robh@kernel.org"
 <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>, "corbet@lwn.net"
 <corbet@lwn.net>, Jonathan Cameron <jic23@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <BE1P281MB24208CB90AF549578AA5C384EF972@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
 <20240830-chaos-unrivaled-04c5c4c6add9@spud>
 <BE1P281MB2420F7EDCFFB8C5B2528F680EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <BE1P281MB2420F7EDCFFB8C5B2528F680EF922@BE1P281MB2420.DEUP281.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/2/24 05:58, Sperling, Tobias wrote:
> Hi,
> thanks for the feedback in general.
> 
>>>   Documentation/hwmon/ads71x8.rst               | 140 ++++++++++++++++++
>>>   Documentation/hwmon/index.rst                 |   1 +
>>
>> And these two documents are not dt-bindings, so they should either be in
>> their own commit or alongside the driver. Not sure how Guenter likes
>> things.
> 
> Ok, probably misunderstood some documentation then, that everything in
> Documentation/ should be a separate commit. Would move it then alongside

Sure, but it doesn't say that it should be a _single_ separate commit.

Guenter


