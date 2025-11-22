Return-Path: <linux-iio+bounces-26379-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3592CC7C022
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 01:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E192E3A5D17
	for <lists+linux-iio@lfdr.de>; Sat, 22 Nov 2025 00:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1BF1F130A;
	Sat, 22 Nov 2025 00:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jo4sToj2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E68B11D618E
	for <linux-iio@vger.kernel.org>; Sat, 22 Nov 2025 00:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763771146; cv=none; b=HVGV1lr0XJFzFVs17Q65i4EABvmteG1HTziOW84byGU5OUSH4Fu0/tsUQ6A97ATYNoRpWgB4KTnbPY6gvZogBk9+EsaOnblqSFEqAmrXzB3YBrNyXKOx4CU+ZHnbMHRoZ6UuVYeS/3yOsAMASkg0DitF8A5FD11i733RTh1qFzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763771146; c=relaxed/simple;
	bh=3FbzkVndmK8QpJownEkpXhfdxMtc5cCwZkNZ8Jg1ch0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=A5TlCyfMlOWci/L4D+sJ2jWQVNYTdDbm4fFQXXIxllXjnaVhh+eKi33IORqTXX0RzpulVCk2xKFhvmE/oAuZPaPfVjPdhufE4k/TRpKachkv4WXR2veps/0ysNEKHD3zp2HJXZP2xqoV+N5U2AbC56x64L/MXnetih2HfWqvOLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jo4sToj2; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-55b4dafb425so2303799e0c.1
        for <linux-iio@vger.kernel.org>; Fri, 21 Nov 2025 16:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763771144; x=1764375944; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0W8r43+CmjiXPg0JACx3RiyUF49vynFvG9uLrKdatF8=;
        b=Jo4sToj2OjpByJ4hiwCVPZ4hlAydPlMvRe/aHrINtxv06tJqsoz7vX0INLlI8nmld4
         2tihMeUCHmJlfRJNV6nQUEW6gxQhLYrLM0tCWt4nrNHcBwESPkzXBqur8C3xEEDrKXfS
         ltoBUw/SCrubLVlelFmHGfFcn2zNkdzyeoabUaDVhQzRq+XE79MovPE6lfXGomdgDuGX
         mcSA+/Wt1CC8Zw/5oJWqG19C4K7Myl/20i8xq9oWRMVqqa5y/SaQEy7qCnHlrEtI10rS
         CWLulsBS4VVnka8dvzrxziOpYsZfWa7gke9whHqVtEdC+/McYYo+R5MZ8DpvqFFVdtFN
         6rrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763771144; x=1764375944;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0W8r43+CmjiXPg0JACx3RiyUF49vynFvG9uLrKdatF8=;
        b=ZJ94V5d1rahMy924u8RF2+wlKQeQrd2atDVQpbyihOb0/0pGaSrbrxl+tzw9c4bpE4
         6r+7fjuQlE69b5EbTNxZ5wKDPmlO/FSjIB+btM7xhCIbiYLwoB8SJFauufAUmN6sPz/d
         mTSII7KzPFx7eGwocNb2Sun1Bh6gfli2fKrTcW+/BtPs/aLyn0Jh4tV3oRMj0RtMBanD
         /MA5pO4L/+s4eytaYG9CqH9vBFnqtVOxSHjA4+GFXmEmpiR9qURC/3DLw5rSjI9TgWFy
         toC9sNYYhnPSmMli3ajSnoW4zLGoxfbBIOfuiMJhut0PVExLMkeaPowcMH4TqD9OAunk
         1WHg==
X-Forwarded-Encrypted: i=1; AJvYcCVx65n6CcAT5G8ugssY5xRoBswGnstNeycoVifkeqT6uSMLBquUCiawfqbJTr8G7pzcRV4VnbiTT/E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCaDBtJjgsYuqzmItU6aBhAVnKchHHLeJHdaQkLquxW6YBcLOx
	/DN3Ue3pPOvDdyAUebTCRTTOfLcxqG6JcPzlFMLlEX6t0tQBXNoL4d3t
X-Gm-Gg: ASbGncujUszC7dAbEz5CEKPLdBxZ/Tc6i2tW7EqVdJJKOOFFeOGAk5QMp/qw2kK3qqz
	Mr5FXIY94itF5XiWPX/JehGkfEu59XW3opuOygXPHFRJms1A5lyypKm6kfd8H0y4lX7XNKd0XIv
	6bu0NaeFmZ4HDqIcdOtZTDothyJjxqrz6VuMUq8EUVWruXqV68jZhf8VbCFy3oB6pV8cHfcuhb5
	BFSFnhQzTO5CofNxJPDkCZkzufDd4VcA0IQT8yvD/PRv7usMgC9cdPsLd3y6JMaFHnNRR4V93qS
	v/8mB+OoOs06CpEnef9LbJfdSQeijhJ2IzLlbgkxpWyNJ8FBq+Jhq8w6yRWjB+JwLASt05WjVbm
	sWksYhO/5WEIhb8r7kZEmDMS0aQ0ZhBPOURbjoJGAZIZAsS6FUYXYm9+rTtt+S2KIRQC/5dl+4q
	QATdg=
X-Google-Smtp-Source: AGHT+IGz1qzq15xr6FFYF1N+SU5pv821ORcu/7J8UUR75MhdpYi6aaDdWxpQ+x4HwuY7ULlTff3Jag==
X-Received: by 2002:ac5:cda8:0:b0:54a:a2a3:b16b with SMTP id 71dfb90a1353d-55b81a1729emr2689162e0c.3.1763771143836;
        Fri, 21 Nov 2025 16:25:43 -0800 (PST)
Received: from localhost ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-55b7f7749f3sm3098987e0c.11.2025.11.21.16.25.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Nov 2025 16:25:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Nov 2025 19:25:41 -0500
Message-Id: <DEESOSIR28AI.2YMRBJ17VCQHG@gmail.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, "Andy Shevchenko"
 <andy@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: Add TI ADS1018/ADS1118
From: "Kurt Borja" <kuurtb@gmail.com>
To: "David Lechner" <dlechner@baylibre.com>, "Kurt Borja"
 <kuurtb@gmail.com>, "Krzysztof Kozlowski" <krzk@kernel.org>, "Jonathan
 Cameron" <jic23@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Tobias Sperling" <tobias.sperling@softing.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20251121-ads1x18-v1-0-86db080fc9a4@gmail.com>
 <20251121-ads1x18-v1-1-86db080fc9a4@gmail.com>
 <32e76bff-f535-40ce-88e2-7bbf7da87620@kernel.org>
 <DEEO8SSA15XY.1SDBZEILR5AHM@gmail.com>
 <2676d37e-fe3c-4504-8990-fbee0ce8407a@baylibre.com>
In-Reply-To: <2676d37e-fe3c-4504-8990-fbee0ce8407a@baylibre.com>

On Fri Nov 21, 2025 at 5:40 PM -05, David Lechner wrote:
> On 11/21/25 2:56 PM, Kurt Borja wrote:
>> Hi Krzysztof,
>>=20
>> On Fri Nov 21, 2025 at 2:10 PM -05, Krzysztof Kozlowski wrote:
>>> On 21/11/2025 18:16, Kurt Borja wrote:
>>>> Add documentation for Texas Instruments ADS1018 and ADS1118
>>>> analog-to-digital converters.
>>>>
>>>> Signed-off-by: Kurt Borja <kuurtb@gmail.com>
>>>
>>> You did not test it before sending, so no full review but few nits to
>>> save you one round of reviews:
>>=20
>> My bad! I will fix the errors. Thanks!
>>=20
>
> ...
>
>>>> +  interrupts:
>>>> +    description: DOUT/DRDY (Data Out/Data Ready) line.
>>>> +    maxitems: 1
>>>> +
>>>> +  drdy-gpios:
>>>> +    description:
>>>> +      Extra GPIO line connected to DOUT/DRDY (Data Out/Data Ready). T=
his allows
>>>> +      distinguishing between latched and real DRDY IRQs.
>>>
>>> I have feeling that you miss proper handling of IRQs (e.g. active level=
)
>>> on your board.
>>=20
>> Can you elaborate? Should I specify active level here?
>>=20
>>>
> The problem is not about the levels. It is rather that the behavior of th=
e
> interrupt when disabled/masked is different on different interrupt contro=
llers.
>
> On some controllers, if an event happens while disabled/masked, it "remem=
bers"
> that and will trigger the interrupt as soon as it is enabled even if the
> condition doesn't exist anymore. Not a great hardware design IMHO, but th=
ere
> is real hardware that does this.

I can attest to that. My hardware (RPI 5) does this haha.

>
> I think a better wording would be to leave out "latched" and say that
> it is needed to be able to distinguish between an interrupt triggered
> by the DRDY signal vs. an interrupt triggered by SPI data.

I'll take this wording, thanks.


--=20
 ~ Kurt


