Return-Path: <linux-iio+bounces-5037-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E818C4D04
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 09:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50359B22AB1
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 07:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ED822EE8;
	Tue, 14 May 2024 07:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KicqaabY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27BA21364;
	Tue, 14 May 2024 07:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715671707; cv=none; b=Fb40HklPxHuRs83U6tDnsIL+Ek40qy7s7VZwU71v/3oQ8ApIGuNOOR+Ez+dBSNjLI6hmF1u5ROyVYJdeCXXmsnCIG35fm0XOAqNHV9W5AMmBqzMxSteYw163Rwuuj1hKKCCFLoWXZeyot28c0cCHgN2SV09Cq+xu8UfbJAdic7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715671707; c=relaxed/simple;
	bh=FRYTpE+ZKXIh4YyPPKLg4bjtwKieQShpeatsuOLN5z8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WwItr+cklYwRM3qLAWoFp8n69/H3wkB7hN/bLT88aaQ76Lk/uZ1yBgOiks4qhHJ/83zwFdXq28tvGUGijQFIP5ygSytccXY4zcR3GnGRFe/ahjxQQxtbuO91szDcYZbIEUsxSTTDW07DYbMZttfkZHhd4DuVUbMO8jSzGVRAjeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KicqaabY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a599c55055dso1339106166b.0;
        Tue, 14 May 2024 00:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715671704; x=1716276504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fkOAfgx4bguLtu620L16y0kU0KIWqErrwfo8cR4hKAY=;
        b=KicqaabYoenpZsk6+xeGWBtSFGVV72/Ndw0kxoO/1VyUyd+Ez6Lsnl+gcz5fr3nlyq
         wI482gKcZFOwSC2BjmzJSNpTDSYic6RF7G499H+EyeLrmDibOr1O9VQ1z1ywX0rJ3UWE
         LtOv1ntwY1WLe39QblIopMJUVPOZ87WcleNVKmK/G9aNgHfCKweycizrNK6mFUzS8ZLE
         WR84HjzE+nS7qcatNZeGbJmCn4l2w2smNMFTJV7iqZQXSIAWrU4yLqlYtWRaivIuvfqW
         G3vhP7u9MWflOlG/Iq92C4H4hjyNoMywHZNbFjDlAQQyffN5/jz/6YJC7DKn0Wv32mG1
         wqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715671704; x=1716276504;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fkOAfgx4bguLtu620L16y0kU0KIWqErrwfo8cR4hKAY=;
        b=PMxV88h/gqZESsMaHw61zBlssZq/N9IRXnp2DzjYitutMAAhkyGIhB/dElCTR1Y2T9
         tbuDVw4A9mVfMWH1YgEnbTniEdjMlVKmmXVtaq9zpkyb6F2hfBur0b/LGCM4Z/eTQkMf
         5WIJWFLyPN578l+mS2DxO/PZJDQltQ5DjBhO2H0ozAxvFKcXRnRM+uiDByDiEBeBx986
         mLGMtLZae/mPLx8L8GRQlW1lfTQsHl8KbxfePhddZdc/o+B1Hv64ox4EzDwHphyhn2yi
         P9WVDG/tJn+VJmh7EGOAbf9V0n6bKqPQBM832ZiM0bYbnTdF2kmr/z5wEHvFWMdoSPyO
         H0ww==
X-Forwarded-Encrypted: i=1; AJvYcCXNQeqi5PTwMD6Rkjf7+LRc5/sjvmsexuzPNY1rvtANY+lehrzkOLTe1rAs+vBKODCDQlFsCUeArr37CpTaNkptawvjLbVMFrHZVAX0koTVHI93WqRqBH9fCRCX7vQfW08RviWTc0w1j7EctAfsd7IVstHMD9/6gVj8QWw0fNX3t45V9A==
X-Gm-Message-State: AOJu0YxzvbN47smNDhgUpumbLlB71kG3lOWNvuinaU9d7KnSg5VkcZrG
	i3jWhp64GE68NAAXYEIqkfbzL7NoTcEfHcNhd4/ZvtcbFJAcCh+r
X-Google-Smtp-Source: AGHT+IE1NondGHhAST7tDS6gFOX8bCH78EncM9TLCv5C0qyrSxfln2AbTQ6B2TWE1aZc67h/cD+soQ==
X-Received: by 2002:a17:906:4443:b0:a59:c728:5420 with SMTP id a640c23a62f3a-a5a2d6786damr777502266b.66.1715671703779;
        Tue, 14 May 2024 00:28:23 -0700 (PDT)
Received: from [10.76.84.175] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a7a944664sm104110266b.37.2024.05.14.00.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 May 2024 00:28:22 -0700 (PDT)
Message-ID: <82131f75-b03b-4015-9421-548b0fd7be6e@gmail.com>
Date: Tue, 14 May 2024 10:28:21 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/6] iio: adc: ad7173: Add support for AD411x devices
To: David Lechner <dlechner@baylibre.com>, dumitru.ceclan@analog.com
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240401-ad4111-v1-0-34618a9cc502@analog.com>
 <20240401-ad4111-v1-6-34618a9cc502@analog.com>
 <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
Content-Language: en-US
From: "Ceclan, Dumitru" <mitrutzceclan@gmail.com>
In-Reply-To: <CAMknhBFdtv84E_S4wa4UW0pO2yiUEk9=jn=_i4F=b8VHdR6v+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 22:45, David Lechner wrote:
>>         unsigned int clock;
>>         unsigned int id;
>>         char *name;
>> +       bool has_current_inputs;
> Maybe more future-proof to have num_current_inputs instead of bool?

 At first I agreed with this, but the way that the current inputs are
mapped to reg values does not really offer a way to extend them
without changing completely the numbering scheme. If that happens,
changing this field will be the least bit to need changing.

