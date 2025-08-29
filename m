Return-Path: <linux-iio+bounces-23399-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63276B3C334
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 21:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D1327B7FB9
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 19:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DB024418E;
	Fri, 29 Aug 2025 19:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="3YB22hFK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA60B2417D1
	for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 19:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756496209; cv=none; b=dGeTdDlp5/Y68hXYoGB9JLG5VpDTe9Bysp5QfPGE8epO/naoIUZMEz4ce4Ojx+P+b1gqHjannMRe86Rsn7q4gDStksqIEKf4aY1+6CRSI+C+tL7x/W8IBi3B2kphAnPqqKHMsKmCcgasXeXPw8J0IfFxXwsnbeAy+buCCZODgSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756496209; c=relaxed/simple;
	bh=j9/zs3DzwPfXvdpJMbMm17iNjJOHTALKsWVQf588f/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kfR5vapbodbKyaUhGBNdBY2a3/xXEy2ytU6Tnmug/sqBlvgr80L7B3XZOcAQRX3thMJtuYXvWPQHZzwQSTFUsLk1Jgo8YiAwmUADHJbh3VkdLCVzMtlHz3jn+pVC3qCqYkFk+i700WfgL2G57URJiRtsL3xoZCbXAj8cuGKHeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=3YB22hFK; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-745514a7b1fso698163a34.2
        for <linux-iio@vger.kernel.org>; Fri, 29 Aug 2025 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756496205; x=1757101005; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l5wFPgG8+kGlbWw0vVHwkPA8651tLivp0zt7xRaHtk8=;
        b=3YB22hFK6t/tWAsBKlKwIe+y4BqHv9b7EEKyPgQ10U2aXjcFWuSL3I1yW8D6Hw0AW+
         krM3S853kjMEqZVJpOki2Tu9gQIpM04wBzvzlulmLmOnE9i6Hw4B9R9YGU+z1NJGh0Hm
         tMXrn6++BztBP+yPkmhwaF6NMQvNBu+iiQn12IDQEQYSdxNRq7kClOOp95Clvh63pxn/
         O92G+SPrSuVMmgAe0BXGuECloqoeD61rEAf8+uhMDateSrvnCFYeCmSRLqN/Rv5e+fjp
         5WHTABzYyAjls8twh+teG7hVJxDaTVZesukl78/MVQHpehJw6gA1HbA2IpjYkk+v8lhc
         Py8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756496205; x=1757101005;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5wFPgG8+kGlbWw0vVHwkPA8651tLivp0zt7xRaHtk8=;
        b=fF8f7u+LAKO/k7AOMqt+oZ/UYKyzake1t04tqvpYtcsa6Pu+21HC/AUc+Qz5avRH2+
         4VWnXoeap+olOuPyg/fG9ydPF4jC35kir6+A37bua1lPHSICNIVxq8wQBIGnyxQvnSQZ
         6cBehq3yUiUmUP7byHgRIBF/KbGuA9cXvFCbxru3McJYwcF/R4q29MTp7nHrYGyf371/
         C3ExZRDJrUAJLd4BVMjReeHlOd0AlwVW08pNBMr2kTzJew5NKUvlVIkrP/nZshbQnzA1
         SuiMhkb2+wXIIcjlJBLEAH9JIYYJYCtlKDSGLp+TNDv1Q4jiJbycWasX/pAUG4NwtxkN
         85HA==
X-Forwarded-Encrypted: i=1; AJvYcCV2WkzBjPZWgdswzexgCztzGfC7D7MhCQkYTkkPXmdgE5z4oMh05YjcTbP/TJ65WPVNsb9C4m4VS8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YznwujEsjjwFWlMalZKEmsjBEZz+McqZMhjL7w27t3ZI0eX5wLY
	hK6q+P3zHPitQyEhOOJC2yQgi0r4bazZRgUuctfpUwsF2ALWx2a5Bt0eeTNPodvUZLw=
X-Gm-Gg: ASbGncsORuEe21ifDqcmKxN9T6yzP93pa7IMUtNEr/VopElcVgsA8daJ5p3noYPZB67
	z08G8lVkG3T5NdahYdElR3HbUqW6L4CjGG5wY/Gs8eIeT2/8E8DzB7jutjkkpb8HWKReKzNAk6y
	lxXBJ5qGx7r98wTRMDfETG3IZBAmB6Uwd9jIRQS1izs0ya11btNO46eQN9k67uEo5ah3eTy2zXF
	AUPcOz5FYcDFYm2h0YcU9yJbkNwYO1gqqEb5IW2cPZQ5UWlg9NqM0bqpvGhRgReM0wMc7UtsAzx
	A1U8JIMwSmca4sYW8OAlJ/x9lYN7nnn/2I2fGJxJAQ+bNYq+/BdczXn/lChBN+6EXFa8Ioaoy6d
	GplwEI2UAJqejPuKjvUzMavSZ1MmhcBqIXW36w0uX2bw9dfzxnzdlwYobL3nW8WftX7duJgI/Ca
	Ixw93Kc1visg==
X-Google-Smtp-Source: AGHT+IGbpxjEich0l11Kif6Yw3AW0cxQTiekdjGQDOk7KPD7cDY7n0i8k2PCtI5oXon+AaezHGCtMg==
X-Received: by 2002:a05:6808:2187:b0:437:d7b0:878c with SMTP id 5614622812f47-437d7b08d5dmr5070233b6e.20.1756496204928;
        Fri, 29 Aug 2025 12:36:44 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:8d0a:2553:5881:1318? ([2600:8803:e7e4:1d00:8d0a:2553:5881:1318])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-315afe69465sm1589729fac.28.2025.08.29.12.36.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 12:36:44 -0700 (PDT)
Message-ID: <c4336dfa-e185-429c-8e96-99a3ea99322f@baylibre.com>
Date: Fri, 29 Aug 2025 14:36:43 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/6] iio: add IIO_ALTCURRENT channel type
To: Antoniu Miclaus <antoniu.miclaus@analog.com>, jic23@kernel.org,
 robh@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20250829115227.47712-1-antoniu.miclaus@analog.com>
 <20250829115227.47712-2-antoniu.miclaus@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20250829115227.47712-2-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/29/25 6:41 AM, Antoniu Miclaus wrote:
> Add support for IIO_ALTCURRENT channel type to distinguish AC current
> measurements from DC current measurements. This follows the same pattern
> as IIO_VOLTAGE and IIO_ALTVOLTAGE.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
> ---
Reviewed-by: David Lechner <dlechner@baylibre.com>


