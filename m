Return-Path: <linux-iio+bounces-21012-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C1EAEC106
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 22:32:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DC2A1C4712A
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C514C2288F9;
	Fri, 27 Jun 2025 20:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="U0p0qXbq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEDD2CCA9
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 20:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056367; cv=none; b=Fbqk/NF1w69IvCu40jW9apAfDVLod0/odJEVxzYjpEGXo0tCtzCqAPZHzJRgCzn8OWjrYet7HApfrf2DZmPP3/a9uQYDQcrObq8dhhW3Um5fnPnAOZ3JwwThbwe5uI1TgiQEDzHNo8vDv+Y4WqdaumudnEapZai5bDLTrYbJlJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056367; c=relaxed/simple;
	bh=IDPrpIyVvRgSr2ZbdswIDGez7eFpJld3p2kUMrb9wuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z8Io5aA0Oxcuci7U/pGgEEH1nkuyQaiEE77xptrxD5PDVDeiv0p+PuGy4A+1DpbEGxvXu68X2P1YrhqDNFxUL4zsbIvyJ5hsEiZE4QyLg4U2F1tu+VTWbZSL7b0plhhOl59m46Jr7I31OICATP7CNHGZURm3eFGTHP5/L2TAJ+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=U0p0qXbq; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-72c27166ab3so208096a34.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 13:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751056365; x=1751661165; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fxxJVAuITfeFuKBhm74QOGA6/KTq2RtogFp6PLr2NWA=;
        b=U0p0qXbqjAER1E7atJ7/2ngWu6V8O8dyTdM2AjQx83YQ/lkkd6SLIXQkej6CQqHKDG
         GoGH5mBL2LCC6RSa7BZVJ4rAufiif4z+34psdHjuSBZedP2n5KrarBhiymBSbbKERcvY
         p8j6DWDjaI1KAIVbeYpENYBMlKXxSWpuq+PTp2sxUPYH3K3glK52Mp0ayynGa40ZxyaF
         Xet6rvKa1ZbR41mzxGXGvervcz2RTPEH/nyPIsuNr1RvwQXzWjU2Idk0AzDbBw7a8U/d
         Fd1ykWW27uFPTCRqkClt0qGjUX8seHN2uYCLzcxMCegySBHONDTHm3rUd657epIVkrCf
         hahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056365; x=1751661165;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fxxJVAuITfeFuKBhm74QOGA6/KTq2RtogFp6PLr2NWA=;
        b=IQgP8lR5Xpvh0f5FfmQyekMOEWFBkaqjR/xbDfM1tiu0tntteeaZAGnKOfZCYs92sF
         3P36AiG/BYt3jyM7EzDffVuGi/UrR1W+2XcGtmVKEy/hDpjWUVyjn+yG+q5dBwzDHD8Z
         2Qg6eEjOGVbbsS89OjCFYZRj01bxAvDlaTW53NhfhzuQnjh1VewgD02T2eECnpV4t4zv
         ZcgWePsG0+b0/aBYE1jNZ0sHdCf9CI1P3gWRHZuqFSF7uG/6TYYuR4kz+v1wkpFaSpQN
         TCvJ1UMJGN1zKS58ulqrQHPawJYJ6Iz+40wOZ0yTdIr2xYeMeYW15/f+nRYtMVewH7+S
         IKBA==
X-Forwarded-Encrypted: i=1; AJvYcCVlVG4OLCBG5+uQZNi6QCgTpaAL4oLP7V2rsDRx1jtdTtQEgVllKyRPYbbvIlGLKHXiS/JJKfPOBZE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCQCsoJsRMYoS6rDVVgd8qwChddTsqSsHdiOr7y/dY2o6AmLwT
	/KMWKnLl2ZJLSiE0aJsaUrqBPdPbaeHTil218VxgO4XsVgd2cU1jbb6YaTeTbawEzGM=
X-Gm-Gg: ASbGncvGjJGICmMAp+EGGvDESyXhuLBoTF9npMOMcpaoLf9TH+dWylaZ4nnMYnT6bsy
	wEUMeQo82mMqMNC3yuN5iPIIW7rDXdmrhFFZJY5X4DFJGQ5yRKXUwiqx6JzITXnFW4XLT/budhk
	T3s160S72nDcARIr3TBp/Jb7LOTL+BoyFUVIJwaAgHr4V1XUo7Uo5004jqTsMxGSeOgqTGfKJOF
	0up09ivI6zS957f2P+ZFWY1AkIU6jN1w7kUzGBCHr0Q0GTBSA4gK3JutCWdnUPTJPx3Gyw9JRus
	yizE8mN+Pb/ZeF+Ln2vvW57LlNUzCfyvc0AlSffRoGV8u0Sp1zfn9x7UaiLUw2O+v4vBDzVZjWI
	hAGXrek+o/OJkireUgdXsVLyGGgOsCJnvEOghRavUJg+rGsM=
X-Google-Smtp-Source: AGHT+IGWKYpvpagCApwnJlXX3gZzQRWpYwcRUEZj3b9BUxUrQ3Di96C9uBw6U2LmMWpj7SyRsppMow==
X-Received: by 2002:a05:6830:358f:b0:72b:93a0:706e with SMTP id 46e09a7af769-73afc5fc0e1mr2924527a34.23.1751056364922;
        Fri, 27 Jun 2025 13:32:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:1715:453e:e133:7d6? ([2600:8803:e7e4:1d00:1715:453e:e133:7d6])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73afb100941sm499701a34.47.2025.06.27.13.32.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jun 2025 13:32:44 -0700 (PDT)
Message-ID: <364b2846-e299-4be5-aadf-0668445c715d@baylibre.com>
Date: Fri, 27 Jun 2025 15:32:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
To: Abdalla Ahmad <Abdalla.Ahmad@sesame.org.jo>,
 Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Gabriel Shahrouzi <gshahrouzi@gmail.com>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
 <aF7kW6xRxRb0VN5H@smile.fi.intel.com>
 <AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/25 2:29 PM, Abdalla Ahmad wrote:
> Hi

...

> 
>> Ideally this should be dropped from any global header file. If one needs
>> something like this, it can be propagated via software nodes.> Well, Including it in include/linux/iio/ made sense to me, would you please elaborate?
> 

No one uses platform data anymore. We use linux/properties.h instead to give
named properties for this sort of thing. So the right thing to do would be to
create a proper devicetree binding for the chip to define the properties and
fix up the driver so that we can move it out of staging. Then the header file
would just be deleted as part of these changes when we stop using platform
data.

If you don't care about the driver and just want the TODO to go away, then
we can just delete the comment since it is no longer applicable. It doesn't
make sense to move the header out of staging without moving the rest of the
driver out of staging at the same time.


