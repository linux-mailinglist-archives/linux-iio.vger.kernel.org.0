Return-Path: <linux-iio+bounces-15970-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC4FA40A46
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 17:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE56E189E36C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E373F1FF7AD;
	Sat, 22 Feb 2025 16:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JI1FFG2/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0541C5F37
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 16:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740242941; cv=none; b=mWFwfAP+H1eQEo0m1Cat51TuTUzmfnL/Eq0P4USkIFCSN4tzj7XScXRPVBupEkP33vAuVeGwMbcORa97DAv5IrEcKbKy7h/MqpS2t0tyijq7V0Cy1psSbOyKljbqi4fn/AKWnft7u4WTlCwyiqPnDRZwExutPAWn9lY4hGZV0gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740242941; c=relaxed/simple;
	bh=V9sIK9nN7xF6r05xVvkKJj0FTsVBne9Efnq8Hm+LXdI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UmQAi2VojA2OQVXbewKf6HLOkDlP++qKtevuWVWNsb9Zr55Nntfv+4xueJk5Nfh5uU50SK29aQPIBhDJo2DJ8WfYzy36RRkpLK9q8Y5tkJVse3L/X+yaZp52xr1G2hGLIWQE6XKuuNgz7hqL4f2arQ+ei/1iPNt52AmRE8eWSzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JI1FFG2/; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5fcfeda1040so1124925eaf.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 08:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1740242937; x=1740847737; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vMyJEwuWpazd/Z9urlp5ndDQadfQgcDXcxg9H5b+Om4=;
        b=JI1FFG2/E5SNPXEP+HoQwS39NJq8UqQ0mjcXsPGB1jo45F915lBkgCvXk38FLGrQUs
         MCxpS1H37dWboK1pdsu3/Gumgy2SmbN07qg6kjsjWn9xS8hKo3/QrMouV9KWh/OB+4zL
         Je6OcQJSMCIQkZyLKR82nWi4mRXVW9NVDK+GmC7kAFleTwqkWkinKSeRVQbrom02c981
         IlQd9DTq91/+GSIFeio0r8b/XF4fzJrpymSGUq1eu/W9Od0GHB+Qp4SPg5hlb2AEdWyV
         8JPxzTyZyqv5CvAVbjlospCbLQBMr0CYoAM6RrgbD5X56zojV3R6MsjTliA/7RpEAXfJ
         /R9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740242937; x=1740847737;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vMyJEwuWpazd/Z9urlp5ndDQadfQgcDXcxg9H5b+Om4=;
        b=br2kAahbMMBtVBkeycpT0mvt+mG+xR/n9DUJbyjHjrnS0HNVlCOaNW3ffJrWlGp0IM
         2GnIHG8AsWhm0pVK69NxUtfc8hxaKWi7jLYKzO2cJDxFZebwCkrfMufZJfzQSokEKDo5
         Wv36j6hSRK8N4RvK8QR0sFNsdckWqgnWD5rqGbwcj32mnYy52lT54RE/VE8acQZOAzwC
         lIWrbmYQq57JapNjt5kIS9QVGAsH1A/CbfnBAu4DaJuoSO6+HS98GHNXePJ8th/GsK0t
         NJEvQ9ns0roPh0/FkzeeDpEo02MSCobD11DWaCB/n1umNEp0LxTZ1Bxc2e6eQzhLnQHQ
         Emaw==
X-Forwarded-Encrypted: i=1; AJvYcCVUKlIQ3skmE1COCVpQP4F4Dw1Ij8ppXnIcpaWLiM8USPOe6ZFGMOr6An8wJrElIbWBH0a/bR20Kvs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPZZNpcH3z78JjyCO6JOiwipgD2QLEeNGTtV5HBH3N42gJoCwl
	ZqPq0KbcPoHjfBYADugTctVYJAfCXs4d13J1tJB+UCpzTG6uhV0PYMqCtc3alPA=
X-Gm-Gg: ASbGnctSg7eQQJoNQwdZt339o0Y54luHKcUIHDG3iRsa7L6i79m9ZCYT8TXDhXAkuih
	kZh2TPp3DER2r5iBwkS9WrN0D4ODHT0jCUY0kxe1FKR/SkVEkV6qDxNiSQMok92wCL4IRhzo+zq
	9ZU3OVNRlRE943gHa4uep/UbVmT/xb59Ic297zJS1e/6iA+zABC61bInJOrUvo86lTdfyt/miaG
	+jyfjuOysRE+MgNnhw8TcONXVzhwCm9kNkxGeCuIEVnMca7k2bbWDY1FjL8y1ixjyILtVWNF28F
	j96ViGK/wtUV97/fv/Md6flANdWtpKua8Tm1aBumyHCNKHvYbDhUZ0yv/6CXQEg=
X-Google-Smtp-Source: AGHT+IHK0RqgTC6ib0kEaDmEH0Eseg0plSYmKizgmQl2o0SS2ejBy2EE0/ENmsD9a6VI8s1LOdR0WA==
X-Received: by 2002:a05:6870:6b97:b0:2b8:ec17:66e9 with SMTP id 586e51a60fabf-2bd50cdbd64mr5924008fac.11.1740242937154;
        Sat, 22 Feb 2025 08:48:57 -0800 (PST)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2b9548878adsm7409873fac.17.2025.02.22.08.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Feb 2025 08:48:55 -0800 (PST)
Message-ID: <81edbe7d-d6a7-4df0-b27d-8f542e56450c@baylibre.com>
Date: Sat, 22 Feb 2025 10:48:54 -0600
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] Documentation: iio: Add ADC documentation
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jic23@kernel.org, lars@metafoo.de, corbet@lwn.net,
 marcelo.schmitt1@gmail.com
References: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <e6ac2a595f06ba2d5ff0eb86e5895479c9dd797f.1739998491.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/19/25 3:00 PM, Marcelo Schmitt wrote:
> ADC inputs can be classified into a few different types according to how
> they measure the input signal, how restrained the signal is, and number of
> input pins. Even though datasheets tend to provide many details about their
> inputs and measurement procedures, it may not always be clear how to model
> those inputs into IIO channels.
> 
> For example, some differential ADCs can have their inputs configured into
> pseudo-differential channels. In that configuration, only one input
> connects to the signal of interest as opposed to using two inputs of a
> differential input configuration. Datasheets sometimes also refer to
> pseudo-differential inputs as single-ended inputs even though they have
> distinct physical configuration and measurement procedure.
> 
> Document consolidated ADC input types and how they are usually described
> and supported in device tree and IIO, respectively.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


