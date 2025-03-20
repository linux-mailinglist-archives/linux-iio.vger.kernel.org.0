Return-Path: <linux-iio+bounces-17162-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274DDA6AF63
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 21:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B9D3BA84F
	for <lists+linux-iio@lfdr.de>; Thu, 20 Mar 2025 20:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C1522A1E6;
	Thu, 20 Mar 2025 20:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LvCtxvMI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5D22A7F4
	for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 20:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742503688; cv=none; b=EpYFrat+lFKRRFL0IkU25dX8w4UvabX0Z4++Adom5J6EcSEIteurg5SrDQyRtG0kS9JOXZiO4XG3aXnXgv2kJiurXCUB/q7LBir5yu5sPuz9NnSA/1qJgRfLVawaBJXDKEllb5K89VHxk0aHsZ4ThhRO0KzC7PwtwTkzoPlB7yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742503688; c=relaxed/simple;
	bh=w4h+/8fL9J+p9KQSOjGKVkQlxbicGt5HKPq7/GWmc/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+FzoRmmD4wALekfjgVy67+AY+r6MubIxd2CcA01GVK8QQZn7YaduJRwGpniINWModCMeJhakG7LGkTf6riAhjxnHmg7DnVEA8cXvZTgN43zdgPNw73qdZ9Rm5utpL5vjaiH97/1qfGAjHJVPfjH5EJ3YimnSzEkGTTIPjDhIao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LvCtxvMI; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2c186270230so387436fac.0
        for <linux-iio@vger.kernel.org>; Thu, 20 Mar 2025 13:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742503685; x=1743108485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NOIKlzsIUoqxD9nEckILpbLfS+//3DA7P6FxcgFgX1I=;
        b=LvCtxvMICD4IOByaajO/ZmOevSbJlryjl5iuxcnKIQz6Rb1XO9TOBksx7Jj57gKNVm
         rfRuRLYqhMCVL0upmDT8FX4tM18QP5r/8rcjKrnFrE95rw/lBYIY7XJuqoqm1dKZksMf
         UlNBG/s2r5GBOWc9JG/6P72xysAoUNsaWpZMiKhqLktYhwCgq/C0z/U6N563k1wUqHBt
         +4KljHvXO3FThxYrNRG5W1dAVTUEy57bwQp1EXXquf8uRRrQuLOoct//dljW4CgR12nx
         zfkYl9zCSVEBrW7I0/Dk5SWJBkGxV9xqogL5zYVgyFROgzNJ0P5flyO0v6WzKk3hBHXM
         zy2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742503685; x=1743108485;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NOIKlzsIUoqxD9nEckILpbLfS+//3DA7P6FxcgFgX1I=;
        b=hLJqF9DhXyd8YNP3Sl4K+8wcdPy3uJ7kbiefw1gC+CyYCFGsLVu8kKLTF0lyNOngyv
         p56G5EfXqczqs4MMQEvUQFYBjbyLL5fkCvAIOG3w8lyM1QnRWUsxIyo8fjNRWZ7NW2oH
         FUr28VVb33p3xyeV2jFLSXLh5zFFFzThorzQgaHNNdfRrSKMsC98dxWc8Gp9xXnkfu04
         e3L98vLUt7BKI/HENOsGKzdAcceGAgQIcx6a9oCZqgMTy19PTy3wowsomtUgMZhx47xB
         8VF3o/KUwG1gcEOMYAtokz8o7/uChHdRqV9c2K2g7m/n8NbbuaB9Jq3QKOfzfx/mIRKO
         LhRw==
X-Forwarded-Encrypted: i=1; AJvYcCV+djE5wouNTeMOExwDFS4o4ip/oF1ZJLykylfaLCRvCD5Nf+zg62IV9j6/dnvAGvtetyh+kHZWBQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyszT58CozvzieC3XGXv2SRjjIIP+Z24xrdh0cTbE4UjdmTde8b
	rmz5xx1bY8QJld28N7OwD6TcqSQwnwin+YRq/gDwb8phZAzPpVhq3tG6NszKDTejBThKccOgW9O
	A0Rg=
X-Gm-Gg: ASbGnctxqmpKk/6KHKEB5D2GPFFgdrsF3932nFoyab1peik7hPsybiv0ZvZXf2Q0w50
	8isG1Ax5a1qM6BU90FozMdKilHD/WAwfSf1kudCoMauai96PCyIVqao/Y4H+MWFVN3zbgtlZgzu
	JVn8dHCMNUBmK+xVuFjTtbkCTAnkWeC0ZT193XldcmuadSqIn4EjUj6DENjgOWd/1GnJV6POYea
	2TOrb35igm3DNYjnEOAWsNxm4v0cR5bnjFa9WE0FolNyionosuZUECkx1iaAoOdF3R8uBhmLoGM
	xeS4C5mBXfB7qy02VZSphTAN0AekIhiPf+Nms9VMhvF3L4lU2q5K67JmTL2UrcbUF4GsdnIoeMO
	kSXibFw==
X-Google-Smtp-Source: AGHT+IE0vhpxH7UDXDB9KJbEa1T/74UWrlWb1s0UUKXXPblhRsfUxYaG9aNkhXf3SmFfKn141a/Obg==
X-Received: by 2002:a05:6871:28d:b0:2c1:62e9:584b with SMTP id 586e51a60fabf-2c7805b2ca4mr626009fac.39.1742503684988;
        Thu, 20 Mar 2025 13:48:04 -0700 (PDT)
Received: from [192.168.0.113] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c77f05ec85sm132955fac.32.2025.03.20.13.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Mar 2025 13:48:03 -0700 (PDT)
Message-ID: <fcbe9c0c-b088-4115-b5c3-8e6f8a0dc961@baylibre.com>
Date: Thu, 20 Mar 2025 15:48:03 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] Documentation: iio: ad4000: Describe offload
 support
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, Michael.Hennerich@analog.com,
 corbet@lwn.net, marcelo.schmitt1@gmail.com
References: <cover.1742394806.git.marcelo.schmitt@analog.com>
 <888928d2224f5dad03a86b7108217f7b4b078979.1742394806.git.marcelo.schmitt@analog.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <888928d2224f5dad03a86b7108217f7b4b078979.1742394806.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 9:58 AM, Marcelo Schmitt wrote:
> When SPI offloading is supported, the IIO device provides different sysfs
> interfaces to allow using the adjusting the sample rate. Document SPI
> offload support for AD4000 and similar devices.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


