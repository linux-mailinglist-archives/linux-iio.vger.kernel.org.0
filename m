Return-Path: <linux-iio+bounces-17288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF38A73680
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 17:15:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D811E3B7EBA
	for <lists+linux-iio@lfdr.de>; Thu, 27 Mar 2025 16:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4CC1A262A;
	Thu, 27 Mar 2025 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iO5xR8Z2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264419D882
	for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 16:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092090; cv=none; b=FcMyWOxcJPuGkS4Hhm9CCn8/dABA+8yF34I0JRSL9t+TcQsT0W7on8I3MPFd3YSS+iNSx18EO19kcRozw6gqGb8KIFNd+zO+tqvbjshP/YRVAuj9Muc3qNXtuZq5JyOKLkSjG2XFJ4feOMPL/e5Dq1EqYyQRdhpyoBu8YIVoZPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092090; c=relaxed/simple;
	bh=Amk6QMpffETB5UHAdzyexQClSs2Zm2hFX9nc8J7YUWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OE4JDMyoZGXVA5p0pUelcu/92vh1S8E1QzCsBB3cxea0to09sZPFxN/j2oH98nTyz88MoXjR519YCT64CcGTO1BFpsJI2a9eChvweqohNBAFVSSXwjRD86ec4oisdqpZm2Tijcjk40DyhQJJZ2tOaJzXJAxt6A+WzLUEWFXF5HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iO5xR8Z2; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-72bf87b8fcbso334117a34.0
        for <linux-iio@vger.kernel.org>; Thu, 27 Mar 2025 09:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743092087; x=1743696887; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AAevIfjZrxI0CofSj9kepLpMs0dL1bwqO8koew4382c=;
        b=iO5xR8Z2i/T5E0arTdkyBV1Kh31Pua+lenCSKl4ZNgm2hxzI22UdLSa6E3F3Z9XB4H
         QFXFM4bWgRXSgY1e/mC2a74LBcte6CPerFxIxlKkINUP/LqcYx/1cVJtT/vOPzkwkRDz
         gtJP8S7KM1qjVo1Zek/nAs1Zt3IQBycgK2MohKiawbQdbAPHKo0Krb0mlRNfCgOPbs+A
         W0lknRmwRH7EIcC3vIuuZV9Xmf+VBTklDCF6GyfEggFOEjaHHXhDevMol3hwZyjnT/1p
         0jFCxd0HoRobuj/Aqp/Ixnp2WapHjJ8sKk8/qmn1JcQiv1YB59qiuUi4lW9nSI+r8tsY
         mA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743092087; x=1743696887;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAevIfjZrxI0CofSj9kepLpMs0dL1bwqO8koew4382c=;
        b=gSCfAzJz5VJ0PFRwiVGu3Z88BGtFw48pbnXiGd3f0RnQvnV8SJSzT6BS1spqqoBlWI
         hki95hKnLp8/wabnT/N5PF0CBSNf8Vw16liBO/yhGdhoJnWXgSIijP69Kcgr/ftupetG
         I/IknzdQ9LVPFBaJQ6XM8l9qvp/Y17OhHuTp7DUq3DPXm8PSK4xX1zfDmOIdh3sJRXkb
         qKj4SJcShka6ktMmWQy7YIokaFEolwzeiayajT7KbRT8bogHXSFIX/cobMD9IA+0GbxZ
         eoyXYtA7MFlvVnvJrJ5z/Py5LDs3UpvK6ivTbTk9S88DHlsu7lT+uDwSP/wu09iideta
         9sXg==
X-Forwarded-Encrypted: i=1; AJvYcCXTXLygJ0JyQVeXbG9abH6WkdwmQZoyAsG1bIvFnR+Mr17H5JFIQg8nW+VY2HWsMBpbd3BnqZ9QnV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4CTc+eNSoQbtZ0rWI+5sf6j69S6hqF/9/vsm+5ANnma5GHbbs
	h9iJpekoHkphkU9qqy2csPdw1qsnyS9hCH21Gbpv3H6/ZjnSKCwKwJiXuwIUtGY=
X-Gm-Gg: ASbGnctMBtcRhQI1JE0vXawlTzAm32KhoU5HOJmwGOEmZaIDc/xxheKZbnKY47k6oIa
	J2jGECs2hSD9+m9zf8PeNnrjzfITi2R47hg7VoxUprHhZ7A2VqUIjaKxNbhol+rFp60u1F2Zpli
	/d0rsi5NasI2Y9ITina1INwAdWIerYQ+OKyh/QpUSqIePx9pXkp8xIz7tCj32IbptItrrEiVKTd
	hDp3vipf7v00pIj6A7nTeph7l05u6zgxT6iksUGUKF1i8G/l+ygg2Hh4wBSVgfZ4qbUUxwivonO
	nXtzTdr1QaRTuJbPD4DDmtxsESkwJfKhZ/PJBJiFyo/txP8sjHlQ8OL3ys/iYigTCvBXPioJK//
	YV+zchkinSMbWmHbX
X-Google-Smtp-Source: AGHT+IGhmMzIClBYofJv4eoA5F/6WFz3QHXKjDLXtrtWhz+tAV3S/U2DTzHrFXt3T2Du+DnNRiDZ5Q==
X-Received: by 2002:a05:6830:3149:b0:72c:3235:9c5b with SMTP id 46e09a7af769-72c4c9beaf7mr2779969a34.16.1743092087156;
        Thu, 27 Mar 2025 09:14:47 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72c58092526sm36834a34.5.2025.03.27.09.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 09:14:46 -0700 (PDT)
Message-ID: <c1433b12-4565-48d7-a8b9-ab5be3feacef@baylibre.com>
Date: Thu, 27 Mar 2025 11:14:45 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/4] Documentation: iio: ad4000: Add IIO Device
 characteristics section
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742992305.git.marcelo.schmitt@analog.com>
 <245b04928a4105d6c65a5f9b9b30204857e1f1d6.1742992305.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <245b04928a4105d6c65a5f9b9b30204857e1f1d6.1742992305.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/26/25 8:25 AM, Marcelo Schmitt wrote:
> Complement ad4000 IIO driver documentation with considerations about
> ``_scale_available`` attribute and table of typical channel attributes.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---


Reviewed-by: David Lechner <dlechner@baylibre.com>



