Return-Path: <linux-iio+bounces-17982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45860A8685D
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 23:34:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531919A5CC0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Apr 2025 21:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049FA28541E;
	Fri, 11 Apr 2025 21:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HruehXBh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C2F21ABD1
	for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 21:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744407282; cv=none; b=eVlUkQRhXCZfKfKj4M8PuVKbJfmj4d00r+P1BBzVyNhsnQS+uVxzIDgEkBI9LAGvqAozgrAtZG6CP/gVkYS9cfVihjOS0eWyF9DWucAeoD75U+gVxYGs0912VOIdoSjaKH2C1U30dN+6avWrYY5xL6MX0Ec1L86E5TeJGCCOkYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744407282; c=relaxed/simple;
	bh=UsuOUVs4NwELwNwSX0Bgh+EAg2cLBqxhBbxUoeHSL5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BHoLaB6voVE0EUr1FHzTYS90RceacLTc5GMbBEgoJXA5blPOr62c6lDdyA16SrCynMdpL37s88calASYP6SOryWSdMUrxBXLxHmqXxPIlLucKEKl6MZ7gl4BKbcal2+jugYBVy9OT3rNkOcoYuNhfiR4nK5zYboIJiCtiSRWLBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HruehXBh; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-72c0b4a038fso1465834a34.0
        for <linux-iio@vger.kernel.org>; Fri, 11 Apr 2025 14:34:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744407279; x=1745012079; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=as3E2mrPIuHM1s1m9bfd6iooaf1VCjja8T+SbJMdAm4=;
        b=HruehXBh0P932UuiUEEJheJZcv6qb0GGtTh3hAclinomPEHq1sMh/YR8wSZlYm14Wo
         rxUmUlMamtl7cQnkt9xUVwt8gss0xYo50FODgh6LrDWKV+zCM4Xax+7BazCxg2KpJRMq
         3j7K3qHGu38WZTaMc2Vd3fkmd/wGfLXu0HPmFKFaQ5LgZBGGEhmKZWWFro0v6Z0V5Qo6
         +Yp1EoKmh9+XB9yoWcGstblItAzewxmbb4ikDP8kRnaDU/zssifpRqHm7wvMS9sj9UT+
         IzSIKzX+Fh9s1oQjCvxoKrs3N3yN1YDon4CSNUamCEl9Df2duYg/vbZUwcyC9UNMRHly
         q55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744407279; x=1745012079;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=as3E2mrPIuHM1s1m9bfd6iooaf1VCjja8T+SbJMdAm4=;
        b=EjI3NsnI/z96J3N3Yg14ZCydKGowqOBFJifvUY9GnaiqWheZdng4z+cNyIdWR+U0bN
         j5Ucm2K0cbfsbW54LhfEYKRPykaQxkJ9nkHE9Y1Krncbjb6M4IIKpAM7K43NwYo9iCMq
         QvgQ2gm69aQ//vk5cN1fn+szCfXwgD0fyw6baG+/i8N570Ctz4X6MJue1RBp7KvR6/ou
         Cuv4l0jI+RtHnJQDYOu2DZoMfjj0hEXZUvSGJ4SeqTdoCsKpTNPE1FsFoMqyUaFqK8vf
         pNEAgZJ3KeWx2cturK6IndJMieEczvaQN/KJFMDCjBbb2G7+QIatU4NSZxXbjniD3aQp
         Zpig==
X-Forwarded-Encrypted: i=1; AJvYcCUpeQH+qUEmo1+UNDs+6Iv/2Gy/DkrETgN7x7/cGt0TxWZSuT6unHkCnnWA1GCifFSORFsNr7+dQ6s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCgPO8b8BHJBxrzt7+KaK3iW/1p6sQqUIAHh32Ytyp7ii0nn3I
	imoVwnrvWc/wxpXjDZKfqtxpK94laXCO/y1lBaAcz2KOrsljAWCiRjVO8RFDzlc=
X-Gm-Gg: ASbGncsHzuEp8XzmwwmKTO3diMd7QtKI10i+YO5Yc9JZtLhOaWk4oohgmq+QdJWsgQ9
	QDeOXJg/JP6pIrO/vn+NXaQygFfKbgSFFPxO52LHSzQSi8uPbJdNg6J6v7drWHr05sVlLK9KLsP
	8vOaeJDlSw2zck9Bb3oeyfq+LARvpyOfT+c1TDyOuG7JVpIxBFUjmuzds4PyXc1fNRoJiEA+Cjl
	nUQAAORFqjRlwfCTxxjXESpwa+zhiSQDQIHk39jj3kID7y3QxWM6fLIyaW9QLOQrGFpoHniOK33
	KtsBOboOY8WOy1RnW0Wxr+04a33Limdh8ecYqPmJLtneq48fCL9Bjkk8eKx9K3zBI4ymv2Bjx3G
	iog==
X-Google-Smtp-Source: AGHT+IFia0+JD7Bk1sblu9KkY0P0eLwIFimi39lyJO7o+rk+NZQsxb0C39VjjslJKGVt14SR6x22LQ==
X-Received: by 2002:a05:6830:6108:b0:72a:1ec6:d47b with SMTP id 46e09a7af769-72e8639fa66mr3413906a34.22.1744407279293;
        Fri, 11 Apr 2025 14:34:39 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-72e73e4c563sm1093255a34.46.2025.04.11.14.34.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 14:34:38 -0700 (PDT)
Message-ID: <7a6764d8-05ed-43d6-965d-0778f34efc17@baylibre.com>
Date: Fri, 11 Apr 2025 16:34:38 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Adding support for QMC5883L magnetometer to IIO subsystem
To: Brajesh Patil <brajeshpatil11@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, marcelo.schmitt1@gmail.com
References: <Z_UvBIsQ4rdIYTN8@brajesh-IdeaPad-3-15IAU7>
 <22034f6d-f2ee-4792-a3c0-a5c0d69ef25f@baylibre.com>
 <CALJe6R3YfhdLKDVBZ=NgO+m64wHHqvFf5tt1T-2pWnr29wE94Q@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CALJe6R3YfhdLKDVBZ=NgO+m64wHHqvFf5tt1T-2pWnr29wE94Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 4/11/25 2:46 PM, Brajesh Patil wrote:
> Thanks a lot for the response and suggestions.
> 
> I'll take your advice and start with a minimal implementation focused on basic functionality. I will first get the driver working reliably with raw data readings via the IIO subsystem. Once that’s done, I’ll gradually build on it with additional features in future patches.
> 
> I’ll make sure the devicetree bindings are complete and properly documented in the first patch, as you suggested. I’ll also look at similar existing bindings to maintain consistency.
> 
> I’ll begin development and testing shortly and will share the patches once I have a working version.

Be sure to read https://www.kernel.org/doc/html/latest/process/submitting-patches.html
too. Then you will know that the mailing lists will ignore html email like your last
reply and other important things that are expected when submitting patches. ;-)


