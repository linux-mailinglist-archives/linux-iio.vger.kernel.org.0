Return-Path: <linux-iio+bounces-21007-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5E3AEC050
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 21:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25547640ACB
	for <lists+linux-iio@lfdr.de>; Fri, 27 Jun 2025 19:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12159194C96;
	Fri, 27 Jun 2025 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QRXI3WYu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A311DE4FB
	for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 19:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751053540; cv=none; b=tiWXo3KdnoSOIMAT/Hdt9OVVdYnrVk5gmYvPP0bsv1JkdyPUFJALOrrmJI8RMHsTDCjEZzUyn+t5RDty02RlkgbGA4gqjHYzuglcr7Ijti0HpxnQCy4LIM0nQx/k5mcRwC4MdbbbdrKQNdRAeA4KGc7zHJwFSN1wxY4GsyLg9g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751053540; c=relaxed/simple;
	bh=QRn5xwx7XJKMLTne51Uubho7iQaz55Fgt6gUQUEa2PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FTATuEU9PHDRaRvZ9+I42s1Xj/m+1fgy+KJSi8O1i6/VX80jfDy2KG/gFQBqMTwNRTtobR0J9bDOukVt6yRWQq/I85TuXKA1ZKXTV/Y0YXtnE3YgoFMZS108MKKPNn5enI8MSTuXw1c1NS6SO43n4qOkH8AJ/dplquu/h/YJQrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QRXI3WYu; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-40a55314d06so855532b6e.1
        for <linux-iio@vger.kernel.org>; Fri, 27 Jun 2025 12:45:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1751053538; x=1751658338; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1PHv1VdGkBxI9IqaoEgDKrlQycIIKb+rA84lWs0tETQ=;
        b=QRXI3WYu0jZnIkPFd6x9XR8k9w54hQre+vuDzfli9td5qEtrvlaU496TjpMvSgSan+
         Su6yPiHLlIETR+im2sJbTBmN6jmNF+2D1c1bppaJ0pH8uxvUv3NI0xZx4SpbgcE5dr8d
         f05HJNplmHbjJT1sqBIDO1PpWJNPpYmfOV/Cgap22nMz6EUr40eTPQSrIHUT1T3QoJMk
         J1aFIKCZfi2CTOLfUKluLZ1/hscJbCo4zY63/LLLNG8sSnSvNcz/XUczxOtf3bIX7ElN
         Vl2cmFZlns3/ptg1HMAnceWGaa9Aw9AKcbC/vcToI39q1VnobEOeMR0f7bIhyAbv2/5L
         yYBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751053538; x=1751658338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1PHv1VdGkBxI9IqaoEgDKrlQycIIKb+rA84lWs0tETQ=;
        b=iPRIhlwsTEkzIfiCoZ/UENsAD3blV8V5LdQXD66fkkrgegqQc2wbmFk5mFx2uF6sMD
         2c1ybw2+hptq3Nxx64n3YdXnnDyLq19ywuXiaEmyXoAtem7MQ9eibYhkrtRaXYR1B9A7
         Pr0Pw+asFJaeKCG0asuEAmEJkEEE2gYnwiA2eui5V3Fobv+pByvt8ntGSQBWJbHYO/My
         hvz0M6DE7RZRGm0ms57Mr0u5BD4Yqc1G3tZW0irQ0xq8BP4A7iLLEsCcpvbYvyEnfHoW
         pbKgRN5J+BU01S0y5cUeMOxWVPZlS7mUp7X5Mh70n6B1ZAH2bwETNWUtGJo2JH5XR/y4
         cj2g==
X-Forwarded-Encrypted: i=1; AJvYcCVnI8pTYoOwZJwuj0TpgY4QanHExqRigGpjwg3ee5JOn3iufv7wTtqfS29UY+HyJTdBpLrbkxVCYUc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL4HXuToDzw2ALs72se0dT2j59WKNGyp6aUJlh3CWCpAUWNDMF
	esXI4hEVcocTYKYUkGCGMQBtGOQtl/BUaGSzJZJPu0Zj6h7JWgJHLa4RhiVGXZODI20=
X-Gm-Gg: ASbGncu4dQqbRHEuz5hpTFluesDHbqFoe14v3fAhCHDR3XPfDtO+vpxS5BZs5WYXNUJ
	3fYiA2OLBrm91q+SM1lWpGOgAh8SCJ/etwJVjptvC/Wg/TctRkKOOxc0nUU5eZ2jGgVC4lFan1X
	nC+WGUsR8BKRq5ECHuMh8vcsXm1Mq4ygwC+Qf84W6r7MSvXPgCzOg9BIrLu+tV/wuAm1tAl8Fqb
	aQHpaccNZDrKD9+j1t5aY4dLxWRFi/k8l93EK+HwgedMlwr6DRLFkTiON6oWT7YK8DBf37asmws
	aip5Wg1UqJW7o1SNUipB5ej8r+7nxTpUdw5eh8VgXCb6iiJGv2Zr2KIRzegamLLsZu2xeA==
X-Google-Smtp-Source: AGHT+IGOy33iVFqaz2J3YryBDyHCiRkin6krtfcbh3XEjok/Bk15oJetu93it8PEur2H1TKYtZrRnQ==
X-Received: by 2002:a05:6808:300f:b0:404:c561:6225 with SMTP id 5614622812f47-40b33e4a4ecmr3388652b6e.30.1751053538324;
        Fri, 27 Jun 2025 12:45:38 -0700 (PDT)
Received: from localhost ([2603:8080:b800:f700:f3a4:7b11:3bf4:5d7b])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-611b848b3f6sm312396eaf.9.2025.06.27.12.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 12:45:37 -0700 (PDT)
Date: Fri, 27 Jun 2025 22:45:36 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Abdalla Ahmad <Abdalla.Ahmad@sesame.org.jo>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gabriel Shahrouzi <gshahrouzi@gmail.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
	"open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH] drivers: staging: iio: frequency: ad9832.h: Fixed TODO
 note.
Message-ID: <36b382da-dc1c-4aeb-add0-a96082ea71d9@suswa.mountain>
References: <20250627175114.548076-1-abdalla.ahmad@sesame.org.jo>
 <aF7kW6xRxRb0VN5H@smile.fi.intel.com>
 <AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM9PR08MB6114261F0CA8CD89EC443E59A145A@AM9PR08MB6114.eurprd08.prod.outlook.com>

On Fri, Jun 27, 2025 at 07:29:36PM +0000, Abdalla Ahmad wrote:
> Hi
> 
> > Nothing of the above explains "why you are doing this".
> 
> The original TODO in drivers/staging/iio/frequency/ad9832.h was:
> > TODO: struct ad9832_platform_data needs to go into include/linux/iio
> So I guess if it really needs to go into include/linux/iio and ad9832 being a DAC, then include/linux/iio/dac/ is the appropriate place. Otherwise, the TODO note needs to be removed.
>

Please, change your email client to line wrap at 74 characters.

The way you quoted Andy's email it weird as well.  You'll want to
configure your email client to do it properly.

regards,
dan carpenter


