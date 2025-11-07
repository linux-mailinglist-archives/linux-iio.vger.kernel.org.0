Return-Path: <linux-iio+bounces-26000-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F077C3DFE1
	for <lists+linux-iio@lfdr.de>; Fri, 07 Nov 2025 01:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4BB13A66CD
	for <lists+linux-iio@lfdr.de>; Fri,  7 Nov 2025 00:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9618E2DF121;
	Fri,  7 Nov 2025 00:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeyBxaaY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE2D592E
	for <linux-iio@vger.kernel.org>; Fri,  7 Nov 2025 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762475833; cv=none; b=lxS0smxgRzEJz/DusIJ4SU+IRCPeUWTs+FIPn/V++ur/lVjXdVoFP3zZXJrk/wSIwf5boyoPjD40lrS73batnvp4M/9PqfcciJ8sOrKwH1CDjjzuSvnwCHxQUSJMoP4EGzATlNT5UQHvqmTM/1jqhmM586uRGDJ53IpWyPTwFtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762475833; c=relaxed/simple;
	bh=d1l9qD8XMmXnPbkbd2q3urs/Adm6B+48QfkVXhWo5WQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZauJqhB1XZlVnlb+l4PT98vXt6apHaM/X4/jwt3yyDRP2YcInVsFXA17e43k47WIncqwYYb3HbQ1J8S5Ok1P1/ovG276PF8g9M8S9XlGvDMEBeetpzsfjEpfqft1NstNbMbuM4hQlTf7Z2kL1tBR3RL9ioCcTpv3vKHYl/WxK0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeyBxaaY; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-27d3540a43fso1772845ad.3
        for <linux-iio@vger.kernel.org>; Thu, 06 Nov 2025 16:37:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762475831; x=1763080631; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EGwKa6L5Ov6plBuAr/eqPUtlUlTY9hpPNgc95wLo4Wc=;
        b=PeyBxaaYRAJ5H3XAxCnWKN8iwQ8SPXdVJ4q5M/B8lGYFCyrmERrittV4xLZ9kwDZz5
         ZiwvH/vxsetNCuIpEtEIfX46MbeASMLFqEFygy0f/cuxB6+TUW7kEudlcOnEbZI2X5Dy
         zhDQiN+WMIkzkO6UKVeJ54z3Gc7Bw7bCUlP3R2Rj3XRhhE/Amr9SOF4FRgmy9E+/M6Gr
         eRJS8Q/OZ8MYu2dQGbgOEdpSXwBSxXSpULMbISGfeCBx/vogU1QR341/+FeCH/aIdGd0
         7rEZ4HDC8wffrNHuED4TukyxS9w8Eq+39gBxJ+LcpLMyvxCAp4t7dWHk43dXvGdEkbZf
         kXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762475831; x=1763080631;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EGwKa6L5Ov6plBuAr/eqPUtlUlTY9hpPNgc95wLo4Wc=;
        b=i7xnWya1VK6jZw99zqYqgulQiDJxQQarGzmORH67Ao9NhpxDq7jULnHimexYyKYosq
         sjiqfS76ye+taOaSFRk5RO05/Lz14WPHXufFpZue8GQdk87g/UD3ZnjRBq3Jx1+OcKpc
         mlX904Hye2GDJGgc9PbejiuopRr8mjct+OoAkaz43SKirmBXF36br0VXB6BymnPsk0NB
         xDEAjWklQda8XBYi40Thft4JWO9nZccDx6repzeb0WE5BPIxhgFFIjtIeLmHIPFPrDei
         s79zvWfT0jU81i45QSqbIFOx3UapkdMJejch6kk0hLEjmG8HY34R3Q6nO/9+JeTRIpAf
         3wVw==
X-Forwarded-Encrypted: i=1; AJvYcCXUwvdiBA2BmYC4PePy8Do7LIGjO1pq7ibi8ozE0aSg3HV3xJteiw9tixArtmkjICr3y/5u9cgiy0I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UKJnfO1hJfx6pHUdkBBHiO2UjxMIpvfAhUQJdHhRZeicUUZ9
	BQ+9v8XLPEq2qBHOmf7dT7eH8b9S83bHghm1/Rg+KNuDGNS0h5S3v723
X-Gm-Gg: ASbGncvBo6ipvoqERt+VCoYtaSyN5/mW8J4JEpKP319jcpOyQjn44GUPW0oGkUxXKWJ
	8P80oF9d+R2nRh0vXntQOVXW1QTIWfaSPBL/a7x68P3ul6/o7g4+QvB9WhTPEHHBLaP7YBzVthk
	JUuDHUQPWyZxdf1rdCpy3fYVh0ssyxV/ONKMcyVW6PQNOnmcDGeooPJR+/WvFQPb/y2ehEHBktB
	KdQe2ymcKp7fwOBRShKJACCEOq21RsGXhG1NgvNhTnZGfMiN3HRdELwVo3RE6JCj5rwK7v3nFyO
	T0GFnzy9Bc9W2Bl9HNI+/M1g0oyLHM2vaY60Js/wYyWROOb773OQuOvD6BRHd73Ggqvxff9GIKl
	qdsPvZRnQLSne2f/KHC2UVt3kZhCMGMd4WeKi1IR4jdgMODXwD/nRHS8+rF/NmDiHzJH8tbZX2p
	jbMqmsRUGWfw==
X-Google-Smtp-Source: AGHT+IGsX68vkUOfybe6fYTABJfgjkBDAPQcEmi2OR60iXxAl7RD78CS1D3hRiQCZfO6bdtQf8LCCQ==
X-Received: by 2002:a17:903:22cb:b0:295:8a21:155a with SMTP id d9443c01a7336-297c045f08fmr16886375ad.35.1762475831225;
        Thu, 06 Nov 2025 16:37:11 -0800 (PST)
Received: from [192.168.0.125] ([189.6.209.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c92cddsm41715735ad.83.2025.11.06.16.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Nov 2025 16:37:10 -0800 (PST)
Message-ID: <c39a2980-f5e5-44aa-9fd3-20e0658f62dc@gmail.com>
Date: Thu, 6 Nov 2025 21:34:50 -0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: proximity: Add Lidar-lite-v2 and
 v3
To: Krzysztof Kozlowski <krzk@kernel.org>, robh@kernel.org,
 krzk+dt@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, conor+dt@kernel.org,
 mranostay@gmail.com, wbg@kernel.org
Cc: ~lkcamp/patches@lists.sr.ht, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20251102221643.9966-1-rodrigo.gobbi.7@gmail.com>
 <20251102221643.9966-3-rodrigo.gobbi.7@gmail.com>
 <d30dc192-e37d-49d6-97c7-26e90a7ae6f9@kernel.org>
Content-Language: en-US
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
In-Reply-To: <d30dc192-e37d-49d6-97c7-26e90a7ae6f9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/3/25 05:04, Krzysztof Kozlowski wrote:
> On 02/11/2025 23:10, Rodrigo Gobbi wrote:
>> Since v2 is not a trivial device, add it to a dedicated place. The v3 is
> 
> What is v2 and v3? This patchset is v3, don't refer to it in the commit
> msg. If you speak about devices then make it obvious. How anyone going
> through `git log` can figure out what is v2. Your patch mentions some v2
> and v3 but these are different companies, so somehow completely
> different products?

Sorry for the commit msg, I`ll make it more clear in this case. About different companies, yes,
that is true. It turns out that this is a "special" case because lidar-lite-v2
chipset was manufactured by Pulsedlight vendor. In other hand, the new version from
it, v3, was manufactured by Garmin, which acquired the Pulsedlight.

In previous versions of this patch I`ve reviewed both datasheets, and the pin-out 
is almost the same, that`s why I`ve added in the same binding.

Probably I`ll send a new patch version without using a patchset as pointed here and fixing the
subject/commit msg to make it more clear.

Feel free to suggest anything else or other concerns.
Tks and regards!!! 


