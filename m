Return-Path: <linux-iio+bounces-26548-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1F2BC92D12
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 18:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E24144E2656
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 17:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85037333440;
	Fri, 28 Nov 2025 17:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHZPkkfn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6E3332EC9
	for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764351612; cv=none; b=mtBJKRJhsaAAnSodM3+qHBhFCQLCkIr8tV+kp5G+tvSwQ3pndeIPoMHa5Uhh2mgsF9LJzsmdLEOFaFPx5eGS11buGaALlBniF2NLD4eI6JnrSOrZ6GMED/47CmjFGWf8B3ULXAtB9/ORge5pIHtf3ztfjtKBJyvsLf/Z/sVek9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764351612; c=relaxed/simple;
	bh=O3gwZTCrjFoeqf+4ZZG/d68f+S5hhU8HJwBqekuNMGA=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=rz/R6tExVR4oMDlDQD0V6F2Jkzy7JQ9VRaJ9anmv5ZjJgxYcR5qswqmlzMO005IoeCg62Q825CLNrofub90kvf27FQcKGpIZG5xGcv4dZau9n7fZ09OqEjKMcLrCZGjC1hlCWoK9CkvjKQ0GDb3ObtW3CrA1FcfTBDBdQRoIz+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BHZPkkfn; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-55b155c9ab2so640471e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 28 Nov 2025 09:40:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764351608; x=1764956408; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ksf9bpHNFLQpJsZYVUeK4l3VWIZV+1TA8e1+Ve8vX3E=;
        b=BHZPkkfna4KayLc1o458l5oA2AVaiqU/d6U4sniNrf3ijQ7XYEi+hIt8mWinIQvjzC
         GMEsYJbSo+PXit5owWSYfZT69Yw8llUO7SaFaR3jGWMZkv6tUESm51lJLobKTlDEoKMG
         H4mJkaSnuXRRxNO1bTYFuQt2Zp0TYazFWus0FoW13O3kQHft5g5+Y+HigwSakOZ8sAV5
         bZsuvLOYFzjsWZy8NZXaQJOrLDlQkHqUNq5ADwxWDX+rjdGUKsEV/9N2JhUgw2wVQlMH
         cZw/rrjeHt4wg5Jptjps+uJnrfck5Z6rQWjrd4EJk8cy/5IbUlpkXUra/7OYsRcbodY0
         Suqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764351608; x=1764956408;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ksf9bpHNFLQpJsZYVUeK4l3VWIZV+1TA8e1+Ve8vX3E=;
        b=uQBbtTkT+saVC4CyUqPEpkMNwhVdoQeKbdNtVIfioNcLM9imx1Ij1MGwxnoO6/Sy3U
         ghk3VqpHFZV8M8jRBraPq5BeKJdDnivJ3zTdzrBXP/jmr11xG2xh9ET/Y9SmWdzs0PUx
         FqliZhIO86BT14RSocFPpH0ZhXXY+fHigQOaLbZs3p2dhd09f1DgvCEOW9Mcpnl4D9Iy
         cGM+qAt5vIDMVFNvJABlv/eDrlxbb+z9TjC1xQE4z1atsj4kAjmgvJHZIoPYoFpZwQAi
         pX6cYQRMq383RbM+TnT0SgkPlNcAaus/BvAsMFcetRNbJzsxk5iULvoRkjQNm3X5V2F1
         MKzw==
X-Forwarded-Encrypted: i=1; AJvYcCVCNQKAQPOdbbBYUS7XlS6hhYDP8ZnvYh0KsLnwTzt//5NiTG3SzGDVmS0hUulipjA+B+NV2mVssys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ240DcDG8x/XsIxQJRgrqjNYGh4MY9GBpgUvqUalyEaXauI+F
	DKC96ubWBlq53gkJ72y892i16EFAEs/DCDmkyAH/sBAH9S9mbONvDwdWnoHuMg==
X-Gm-Gg: ASbGncuOP6+rfZ1FPHWitpNFj2cfND+9xzMMrqXPbpv6lfIzplTZJ5W/I5gbb52O26/
	Mvg/BO1elqdDpIQxt3wizJN9ZI2+PObnk7CH6Cg/NNXI7ZeRMFJClqeVMVQW9Y6qnXv+dDPC55i
	j75EdgOnprsa2golUJhsAxTf7xqJP4fdnYoKSdGMYNTaMkfkqMdpsA0rf5dOHkH8zUqI5txF1yy
	PvFfUAFZGIGiB0dm34LVRTR3D88C48szDe/HTNdgx6AEMFcfSAP6ozVDBlPc7AbsL9UfXKRlzEY
	PFCr+glCJrD1wCUww9wNfdeRU+HUV4ck/PwSE4BuDBonhR/OBZ4Vt298BpnPjXETdiR7Fry63n3
	7UaKIY1ia4rege2NwzGQWGNGR1A1ziXVhZ1fmRobxByd0xkBXu9V0cPISOqkP2Jg8J4vCGXqLx8
	KJDqPKog==
X-Google-Smtp-Source: AGHT+IFe8GiAMTa0/l9shgwgJWoUbKMN6FN3Mnu2XXuSPGgXKPKMwILFzaMqyMjJpH018s1tlchfJw==
X-Received: by 2002:a05:6122:6b1b:b0:55b:9bee:ff61 with SMTP id 71dfb90a1353d-55b9bef0f0amr7951568e0c.16.1764351608522;
        Fri, 28 Nov 2025 09:40:08 -0800 (PST)
Received: from localhost ([2800:bf0:4580:3149:7d4:54b1:c444:6f2f])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55cf5186d0csm2161858e0c.20.2025.11.28.09.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Nov 2025 09:40:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 28 Nov 2025 12:40:06 -0500
Message-Id: <DEKIG2EXEUS9.28A50WAN06ZMQ@gmail.com>
To: "Krzysztof Kozlowski" <krzk@kernel.org>, "Kurt Borja"
 <kuurtb@gmail.com>, "Jonathan Cameron" <jic23@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Tobias Sperling"
 <tobias.sperling@softing.com>
Cc: "David Lechner" <dlechner@baylibre.com>, =?utf-8?q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Jonathan Cameron"
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
From: "Kurt Borja" <kuurtb@gmail.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
 <20251127-ads1x18-v2-1-2ebfd780b633@gmail.com>
 <bc76c2c9-ceb6-4ba4-80f0-8a114c5da033@kernel.org>
In-Reply-To: <bc76c2c9-ceb6-4ba4-80f0-8a114c5da033@kernel.org>

On Fri Nov 28, 2025 at 4:43 AM -05, Krzysztof Kozlowski wrote:
> On 28/11/2025 04:37, Kurt Borja wrote:
>> +
>> +  interrupts:
>> +    description: DOUT/DRDY (Data Out/Data Ready) line.
>> +    maxItems: 1
>> +
>> +  drdy-gpios:
>> +    description:
>> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). Thi=
s allows
>> +      distinguishing between interrupts triggered by the data-ready sig=
nal and
>> +      interrupts triggered by an SPI transfer.
>> +    maxItems: 1
>> +
>> +  '#address-cells':
>> +    const: 1
>> +
>> +  '#size-cells':
>> +    const: 0
>
> These two properties are not correct now - you do not have any children.
>
>> +
>> +  '#io-channel-cells':
>> +    const: 1
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - vdd-supply
>> +  - '#address-cells'
>> +  - '#size-cells'
>
> And they should not be required.

I'll drop these. Thank you, Krzysztof!

>
>
> Best regards,
> Krzysztof


--=20
 ~ Kurt


