Return-Path: <linux-iio+bounces-10479-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC1299ACAE
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 21:32:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E42B2829CD
	for <lists+linux-iio@lfdr.de>; Fri, 11 Oct 2024 19:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B7431CF7DB;
	Fri, 11 Oct 2024 19:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mULvvqKu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7191CEE85;
	Fri, 11 Oct 2024 19:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728675165; cv=none; b=SaJ8nwUeelTuemnmYaL2B57+muhKdBC88h2qffZgBH5OIit/pgzjiF5Og6qgN91MVC1rU29vmCz6Qiklr+Gmwk05D1+mXOxIfdRk+Q++R3s4jrnvcVH0CvZ+rCDunc9kuFzBXYk6CkFBmNHLc0uTgKny8wMS+mwzuu5B7sab2uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728675165; c=relaxed/simple;
	bh=jTufO1eqHWvYONgG76j5xyUnwjzmD+Ejxhm+AhPj+AM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s9SD4yQsaNqvYK4jsrcQBbH2bT7iSOOTIq+vHPQuhyU5AuacrW+CHMuj3fYTKTFh5m13GtaBaFpnBMBYnikO5NMzYIliGd2p7JV1WDdDx7rfY4h+G0zS9s6U6QcxaKYXgseXEt3k/QMhcTOEuKBZ33z6ytrqOo0xJWXEpD3NWpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mULvvqKu; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d4ac91d97so1781803f8f.2;
        Fri, 11 Oct 2024 12:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728675162; x=1729279962; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+HS0NAdsOUYeGI7mRERtfLDO2iH3xgiX9etHXZcQn9A=;
        b=mULvvqKuDNaZgXFvTT4l0kDnQQszydvwDldHJi6ym8UHzLk8FBeAFftt6M5FwnSmrL
         2+1/kDhFGFiji6T/Vte1OB9RexpvMLDIjkbzASWOz60YiVnHqTEWdtz5NsiabOw83Zo6
         jyjvn9yhliqu7B8U6k5eRBmZCCleYxRlZ3YsQcKkosyh461WbBUl10o9bgfLElTTsVGU
         Cb221Uo3JbHGIeDCTiOkCUH9iaKnGMb1b9sJ/ASg0sYSkEnHMgLWl38h6CnVdUIE5LP+
         +Qk6QS0g1gwP5M9v+aedmsSYUMjuzDOwF3o5bl24sr63+MynlFuBhGfO1rtJFfAwwGKR
         lZNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728675162; x=1729279962;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+HS0NAdsOUYeGI7mRERtfLDO2iH3xgiX9etHXZcQn9A=;
        b=U5TNMXkphquSWxffPdOs1GJeDcH/+gHMYrB+vdxxOG23xcptsU5K92riZyGHEapOwD
         dPaowfoP5Wna3SGLEOTsjGt7ZPJi/D8J69s3KbJSq+zBMQFrCBv/Q8kpFi0ctB2pjITJ
         R6RIkpyjljTvkBlkCqWUtTx8TB8VVr7plNjcgjaML2JO/KMYnHv+AaKg0+5hd/7Em4MW
         VXqTX9ObXZxQ/XYToMgnsk3Crsfyva7x8/2tFJ3ugDOix2iHMK+7pa/rhF6ljg+AdbX5
         imYCdr2QJr+XckNcvXXsbvPZALvNFTeFd2na7CQvwBHQr1P74hxNk+fxiMzkzR0U/+XG
         XAAQ==
X-Forwarded-Encrypted: i=1; AJvYcCWMAUApi+XXTeN/LBVMNCAARm/0EOYVdM3vJ16IJj1LXP4/k6KmfzqqyJDgecQIaqHaIgtlNyz49rY=@vger.kernel.org, AJvYcCWXrrawtyZIMhGNJKRhpRysgRldkP6JFp9qdsG/B2HicjGewx7tW7UX+Q2DhWi4sIJU1kXD2VA2tLWdP9IY@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb1YO1OGlaJ3mrefNi7QMzwNnBYdmtti7rfaHppjx/t8EeuZZv
	YDuvx8nRBFTI8jOg6XEGOEvPsO824T10kBepePJinVoXVaYfG7Is
X-Google-Smtp-Source: AGHT+IF9+FsG+E30CjlRvWbpTNN1lU2HNefQEhmynyvChYP7LCMUBll81Ko+v5AnAFFcNs3NnrwZbQ==
X-Received: by 2002:a5d:62d2:0:b0:37c:d1c6:7e45 with SMTP id ffacd0b85a97d-37d600d2f59mr572270f8f.40.1728675161754;
        Fri, 11 Oct 2024 12:32:41 -0700 (PDT)
Received: from ?IPV6:2a02:8389:41cf:e200:55c0:165d:e76c:a019? (2a02-8389-41cf-e200-55c0-165d-e76c-a019.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:55c0:165d:e76c:a019])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d4b6b8d13sm4601028f8f.25.2024.10.11.12.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 12:32:41 -0700 (PDT)
Message-ID: <0ec5fd64-a172-4054-a2ef-1c12db41beb5@gmail.com>
Date: Fri, 11 Oct 2024 21:32:38 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] iio: Fix uninitialized variable
To: Vasileios Aoiridis <vassilisamir@gmail.com>
Cc: "Yo-Jung (Leo) Lin" <0xff07@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, ricardo@marliere.net,
 skhan@linuxfoundation.org, Jonathan Cameron <jic23@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Adam Rizkalla
 <ajarizzo@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
References: <20241011093752.30685-1-0xff07@gmail.com>
 <20241011115334.367736-1-0xff07@gmail.com>
 <26f2e35e-0a07-4b24-91a2-a48d4bc5dadc@gmail.com>
 <ZwlvJCxdiRqRWu6Z@vamoirid-laptop>
Content-Language: en-US, de-AT
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
In-Reply-To: <ZwlvJCxdiRqRWu6Z@vamoirid-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

...

> 
> Hi everyone!
> 
> So if you check also the conversations that we had here [1] and in the
> previous versions, indeed the idea behind the offset is to use it as an
> self-explanatory index to a char buffer that holds in fact s32 variables.
> 
> The data->buf here holds the values that have just been read from the
> sensor. If you check on the channel specification of this sensor,
> you will see ".realbits = 24" in both values that the sensor returns so
> hence the value 3.
> 

So you are using 3 = 24 bits, but s32 not as 4 bytes? the whole thing
would have turned into sensor_data[0], sensor_data[4], and no variables
implied, correct? But I am discussing too much for something that in the
end is more or less the same, I am fine with this proposal.

> I am not sure if it makes sense to use a macro here for each one of the
> 3's that are going to be used only one time each and in order to be more
> "consistent". But I might have a wrong view on this one so feel free to
> correct me!
> 
> For the initialization of the offset indeed, it was already mentioned
> here [2] this morning, but on a different patch!!! I couldn't get this
> error though with gcc...
> 
> Cheers,
> Vasilis
> 

At least for the things I do in the kernel, clang catches more issues
than gcc. Sometimes even gcc will not complain, and clang will fail to
compile (e.g. a goto before a cleanup attribute).

And if you run smatch before sending the series, you might discover a
couple of extra "surprises".

Best regards,
Javier Carrasco

