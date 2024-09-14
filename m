Return-Path: <linux-iio+bounces-9546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E013A9790B8
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 14:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B1F51C21B49
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 12:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FF219E7FC;
	Sat, 14 Sep 2024 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A+vLP9CS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C7D168DC;
	Sat, 14 Sep 2024 12:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726315677; cv=none; b=KYwwIWXucg9OHw+89eRHRxc0I5/heQ3Tw4wA2mNKlUzMvMO8npMEnoQZZOwp69gzsFMIfWq6Lvwy7s5++cp/ze0TnEfofeeRtP4sKSPJFGuNSHggouRzO6EHo6NTlwdSpp2hUNU8KQtGZ+d7FI314eIxmsNHhPJ1JmzMhUMsooA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726315677; c=relaxed/simple;
	bh=xj1P/lNUeuPWC65QqK1OBKQUVgjurRWAO7FpMFL0wY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r2eollBF90m4+UfpdcirdpGiHv4Ne/aPy/WtNfgVGPwXULMeN7xBqw6xmnXqjh3/RjKt74UpOIjSxtLjPVQbIW9wxbWyC3iObXkxHG7HZsOlAQOYHDVRKWeEH6uLuG7RfxSZn9HCZjrq4AdFJhVPrJKQQTqo1TIBilQzlWkd5/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A+vLP9CS; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-378c16a4d3eso1829558f8f.1;
        Sat, 14 Sep 2024 05:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726315674; x=1726920474; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bWpKGlxK4GME83ljPjG17Dzvcobt5ADnZCeF6SIfVso=;
        b=A+vLP9CS4tghmSrNHufmT3ObsTcDuSUS6oBZjaDJdF5rk1yoVxIfaBV7DDw8t+UXu5
         TV7sipgxRsexWB+BMSC4tScmXE7ttFGgNXiZexynBgXWKNw3nIwLkGc7IZJJw31SXSyp
         AHpfi2/3J+hDeVBvrcoJDAljrpty2Ep1P154mluYgMKJqgub+wQTQARjKgRT/hsGT2qo
         48iqGfjPEEs11vlow21aMD+rftJ/Wxi4axfXNrB05wqqcXYhuvE1R/mX9qY5tw/3m8Lm
         i7Ay/MgPEsWs8OdS8QCQiLMQ2ZcH4DmD6rIFf2kaIONiV9c1rQmWOkIqhD/hQDeWaCwd
         Z2Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726315674; x=1726920474;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bWpKGlxK4GME83ljPjG17Dzvcobt5ADnZCeF6SIfVso=;
        b=aUIeynligCdJg02CyYXn+hzBqRQITnLRHVXYVvwgGP6B9UM2tiAVmjMLHq7SqrDuUr
         VCxbflWjoG4ftAa2lK+r5aYG3kvC93IjSOeWoCtU9nHdNP1ZD8/im/2bYl+Fm9so4IRs
         irHD4AQO6m6E2EBHvdzH4k+6HK1PC2nD4zVi6xh7+Aaj6I/QnaEOSrnx4OcMx+meO8Ga
         RysjQMkIN7w274RK9ga4Y12lFr0qf1BF+xcHqcSC1p3LcnKRJaMKiiYahcGkl+dRfsUy
         HUD1ez+qEEE3y3XczqUzI0dgaUc2I3vV4NVKEx1Mzli7BfG9cwxlbWFQKUrfbiNlDZ7f
         KaGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVze/OfluCmUVHzfwIUgmYBVfVCJKxhV08ckCfznHcBeoVCKCB5akPwfPe+AGjgFx1898FB5xwC8+KQZsEU@vger.kernel.org, AJvYcCWLw589wUfmhF7qLd1RoY8TkwiHnFJWt5a1hWgVNlAbOEy8ilpgQLFwOZStrT14Qo+00Mt+eMUX0AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFGaRFgaqtCTXu8qRrddGe0ajCsvUax2DTqV8pobIwZ5XjXCmr
	wbqN1MA8MLbY9aqjSPQZ/qSX5TAJXpqATNcw3frNr45/Xkru/a6r
X-Google-Smtp-Source: AGHT+IHrOiopLO/QQSAN+ztzI0kzQbkgyux3FU7M0LmcRufZN3Is7/Kry7o8upEpcSw6OeWKvRn6eg==
X-Received: by 2002:a5d:6d89:0:b0:374:c847:867 with SMTP id ffacd0b85a97d-378d62360e7mr5845029f8f.47.1726315674067;
        Sat, 14 Sep 2024 05:07:54 -0700 (PDT)
Received: from [192.168.1.127] ([151.49.241.219])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-378e7800374sm1604686f8f.79.2024.09.14.05.07.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Sep 2024 05:07:53 -0700 (PDT)
Message-ID: <2cad9977-7133-4d53-a704-4ef80093f2db@gmail.com>
Date: Sat, 14 Sep 2024 14:07:48 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: There is a potential buffer overflow issue in bmi323
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: jagathjog1996@gmail.com, jic23@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <66e2b969.170a0220.29a2d3.4b31SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Language: en-US, it-IT, en-US-large
From: Denis Benato <benato.denis96@gmail.com>
In-Reply-To: <66e2b969.170a0220.29a2d3.4b31SMTPIN_ADDED_BROKEN@mx.google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/09/24 11:50, Qianqiang Liu wrote:
> Hi,
> 
> I reviewed the following code in drivers/iio/imu/bmi323/bmi323_core.c:
> 
> 2245         for (unsigned int i = 0; i < ARRAY_SIZE(bmi323_ext_reg_savestate); i++) { <-
> 2246                 ret = bmi323_write_ext_reg(data, bmi323_reg_savestate[i], <-
> 2247						savestate->reg_settings[i]);
> 2248                 if (ret) {
> 2249                         dev_err(data->dev,
> 2250                                 "Error writing bmi323 external reg 0x%x: %d\n",
> 2251                                 bmi323_reg_savestate[i], ret);
> 2252                         return ret;
> 2253                 }
> 2254         }
> 
> The array size of the "bmi323_ext_reg_savestate" is twelve, and the
> array size of "bmi323_reg_savestate" is nine.
> 
> Is it possible that "bmi323_reg_savestate" may have buffer overflow
> issue?
> 
Hi,

You are very right and that is copy/paste mistake that was not flagged as a warning by gcc.
Thanks for letting me know!

There is currently a fix already sent for review here:
https://lore.kernel.org/all/20240909-iio-bmi323-fix-array-ref-v1-1-51c220f22229@kernel.org


Best regards,
Denis Benato

