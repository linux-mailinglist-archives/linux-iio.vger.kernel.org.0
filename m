Return-Path: <linux-iio+bounces-23320-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 104F3B37382
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 21:57:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3693D1BA723C
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 19:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD4A35206D;
	Tue, 26 Aug 2025 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z69tHqKX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959DE30CD8E
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 19:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756238266; cv=none; b=UAzJSvyeImvKoD69dBMPU/2IgrOpGj0A/wxz4rwl81olZ196scqDQpg+sUOXSESp5BT1X1k4N2A4rcE8PRgh+Y9U0zYN9rg4i0btKonkBKkcFM+vcI1gTPpdDDo+s/UVHfnN+r6kxUloM+TZiDSOGU0b4PhpDuIKzqsDZYWfoF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756238266; c=relaxed/simple;
	bh=OSAIMiHx7xCAIVdT89ToiPUFtHGrPFurgj127/C65y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CBybdt2jMcw9TPesPDCesu7AsvSRWp+oq5YJB3x+REC27yhUhkLZZnun5Dtfyq62ucvniJFVgVEdIXxiY7+eDnSvWMA8c2hN2z+lW/xBRjCGI7g+69oaQO3Wuj4OPl2/7mJs+OHck8e3KRakZ24l6sz5/mFVNwKhfsGIwOCZ/kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z69tHqKX; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-74381f06578so2985753a34.1
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 12:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1756238262; x=1756843062; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rD4FOSkybBySQX0GMhHU44OFFNATUrye0v8Q+Al5+18=;
        b=Z69tHqKXIWSxvURaNvGZBX110Bi5Gk/PPP0eBE1I248P1S2RDQIic0oK/2nvA3odNt
         71xVYO5LxVEEr0PFN7/5WsIBBh0JInGuzdMYr7dWzObadLrwrDNoJ5smQwBx4jgEn/qQ
         +eaYG3WgM3sagIUXhEWiSWK4eFxzUuEc+FG8UVSn6+yUcFk5ojyN/HQcsvvIKn9H5xnt
         OvogxnAfBOc1sNImJI3qdzWtXCVoJg7NgcaHbzaBkbeFZi1XqRP386n3DYc229+Xv/AJ
         +TKYfL/XOEHrGv6gyK1hHkqJIUdxyQ/ehhz3B5H9O7EZxI/b8b+fULPgrRcGdKGvOcAU
         HODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756238262; x=1756843062;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rD4FOSkybBySQX0GMhHU44OFFNATUrye0v8Q+Al5+18=;
        b=eF7ogVltDC9/mhSaLhBWz46dKKn8Hd7LZcoWiZNsBjwHK6oddO4w0yv8UAkbRyQeQp
         NWVl4KqTCBeetaKpB9q5GrO8/FtT/o61R0ahBNgHWb8EQrkGsy2aW2dSdjM8KleoUl1y
         t/Lkh2lHMJ/CI9AMphsRBqNKimqOJemkE6Y54kSo9Jf+FsWkoIdUmgK2VpDOV3mQrwDq
         GEeVfx6dBF0x9skSg+5GWUdC6Oqe3kv4z+WbugFp/vx1otDnlPfN0ZYXlE0auA6Cp9Ux
         2jPFfHp8KnGWCQefCibBhcPV+pG+EisF1NO1PxoO/Qh2/3//gR1YPCsQnmrJVGhWkRO8
         caOg==
X-Forwarded-Encrypted: i=1; AJvYcCVRzwDNRSIQZMXM+tul/6F7MHm08yY2XxR41Tt+bbHX5XZSM7lEFDBCxktSLJJi7PJdl1RaSJ9XkMo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlCTYhAbxB6klyOTv7AJZ0dGW0NbSVBQHqgMR0Rlmen+8hoS1
	zmwNwgytzVg+wMVoa1P8gjMSP3PllFeoCZkLjUIumelLoJgGFCASl4bQlMFBEp+2gIQ=
X-Gm-Gg: ASbGnct+Cix5H/1aRQUFsBvdh+9ovmWOhX5U6rF358O12DJbdkVZpV0mgVlpo99Zb6F
	swv5+g1UWLVgjVcIncsBt629fPgdD9uFXgDNAY7zvBZu0SQNOQXbETxkvgj9gH0PcFMLfIRINa2
	LY1NekgyDwXb/ZLMSAIZX9AIYxi1ZrYCRmXXK9S9AIDWlBUEAcA0VrxOsYrZrqXoA88f5DCJsz1
	RunxCvm/RWw7GcDmZFuWxvbLqttsivI1u+PlKjfK7iq5AXgXrYbJCPntag0CTlcKAJRxVQJa8S/
	PdGQJRp+kYEcBKFTd5ZHMrKZqnqCCLhRFJv1gAAZsv50cYc5iwsBiR9UgpSrhr6AufshBX9Fk1X
	0jdss3ltLUfvWwrIUmUlrxIfaE9BmQQZvEbTF5XPIJ6C0B5XcTaclKCHmnbwIlHr2WHdx8fn2Cv
	M=
X-Google-Smtp-Source: AGHT+IFlF/SY8K8s1egUnDi0f5XVe2VDbtLheDYyL1cwcriCdcSgjHOdZRJc3fX8zkoVOjBKxAbiGw==
X-Received: by 2002:a05:6830:3749:b0:741:a52d:3946 with SMTP id 46e09a7af769-74500998888mr8899998a34.16.1756238262601;
        Tue, 26 Aug 2025 12:57:42 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb? ([2600:8803:e7e4:1d00:aa9f:f4cd:76b1:fecb])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7450e2892dasm2542047a34.17.2025.08.26.12.57.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 12:57:42 -0700 (PDT)
Message-ID: <9e5f3b88-d27e-4c0f-8569-dda353d006b6@baylibre.com>
Date: Tue, 26 Aug 2025 14:57:31 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in
 mhz19b_of_match.
To: Sidharth Seela <sidharthseela@gmail.com>,
 "gye976@gmail.com" <gye976@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/26/25 2:42 PM, Sidharth Seela wrote:
> Greetings,
> As the mhz19b has been discontinued [1]. I was wondering if the newer
> series sensors,
> could be added to the mhz19b_of_match, particularly "winsen,mh-z19c"
> and "winsen,mh-z19e".
> Note: In mh-z19 series 'e' [2]  'b' [4] doesn''t provide a
> communication scheme in its latest datasheet, only 'c' [3] provides
> such a scheme in its datasheet.
> 
> Refs: [1] https://www.winsen-sensor.com/sensors/co2-sensor/mh-z19b.html
> [2] https://www.winsen-sensor.com/d/files/mh-z19e-co2-sensor-manual-v1_0.pdf
> [3] https://www.winsen-sensor.com/d/files/mh-z19c-pins%26terminal-type-co2-manual(ver1_2).pdf
> [4] https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-manual(ver1_7).pdf
> Thanks,
> Sidharth Seela

What are the differences between the different series? Do they have
the same pinout? Do they use the same communication scheme?

If they are similar enough, we can make a devicetree binding with
a fallback like:

	compatible = "winsen,mh-z19c", "winsen,mh-z19b";


