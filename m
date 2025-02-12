Return-Path: <linux-iio+bounces-15443-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D37CA3248C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:14:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9E3A9605
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CBA20B1EA;
	Wed, 12 Feb 2025 11:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cQ4IutSq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605020AF75
	for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 11:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358773; cv=none; b=EVWkS0LZ2lBJZNTFcGIERJ0ZqokmKKtUp54bmef7fTsaQAHvzr8MhNbhbc7sDfAx081e7krKsuOIzT1SpgMCtM1PCEwIOYlRWnWpHD7FR64QacQFF5m1JpSLUgehA0uluuCFwrMqbS69hvFC5QGG8pQtKWzmxTk5EiXX3NjE9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358773; c=relaxed/simple;
	bh=czDBhXds2774fwZNyEeYA03Jzlh2/wYesLkUERE8+UM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7056ej9HGqzjVAaY7NyJihuYC0yl+phATS+SX8VyHpdq3Gp9+LC2t4YnNwAYtFxcy7Da0gUzwVlNZZYAeLgpuvx4fYZGrlqI8KMlQtB6BMIx3lmaDSuKAj+BH3xwehBMMZik8WOfCtI+Q/AYLTsLCZpc48wxxbQTBWZ5FKV2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cQ4IutSq; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-30761be8fcfso67824261fa.0
        for <linux-iio@vger.kernel.org>; Wed, 12 Feb 2025 03:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739358769; x=1739963569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zi7NSGVlmdukYXP2xLDE0jItD13dYbVjBU6ou/KCEC8=;
        b=cQ4IutSqVBqRUrbXKbHaw/NNLr1RNmie25Y/MVG8IodnPJSqJa1cPFbqwN103Z0JrV
         oQD/xEU3XgRSarfKrcXiX1R6KEago3ox9oIBsnI0DjB9UJsWl5sDcNop4HlLguL/G1hu
         GxTT24uzp3zZ4xPySTjF/eTz1vun4CLeFjc33jlvNrBwu6cGZBt5hl0Rt8fbjQf+H/rZ
         eUaZpg1KGuoSAJWBY++4lRaSip9zdagPjDMryJPbVXhf7eYMR4rUviwCv5HHeZUxfMTw
         0myu+Z8dFmtj8OsLAL07GSg9YY4qwgAAg4x0xyfKZRR1n/bfa4Un0GDIw6/E2zW6vQa0
         gw6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739358769; x=1739963569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zi7NSGVlmdukYXP2xLDE0jItD13dYbVjBU6ou/KCEC8=;
        b=lxna8VItPTHHFrS2OEpMhP4cxpvB0A7ZeEDobyIfBijTAnpzD0mrlGzAxFgxO+CYgj
         I1/SD5OHLCKniJBxa7/5h3y22Qd/S8IVXfuf+gsHz9lURtnApgsw0cO7i1xVMQPMRlGJ
         tZQBflEdFH4/04lKyGiGukhSZ4ee64g9yLUSaKiYISZED4PXcAY7RcjWSMdebM3KlLpq
         lJtU7zmv91AfrEvukmXBgd79xxIFwfRVxG8q20i2/dKTigcITpi7bBv+fzbUK8ClWTRn
         pZ5v/NQQMKwy2/BHrURZiVfrN7UdqbFkGCynP0q5k38FMAa4fcJegz/bD737Pgy5q9+H
         wzkA==
X-Forwarded-Encrypted: i=1; AJvYcCUPOHR028qoBz/rLcxh0M/f5ExmDosEvU9dotaXmxMWv0iF0S1Nb7/ZQStnGlfbisw1GkBTaNL3yCg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4h6icbZRjZO+iYXnvgwHcH+eRc5FqwLOXZHO4mdK3SFf81sel
	6dkSZonrl3s8ilxuWEgpbSQRznTBvd+Y/Wt/FNgv7U8rpc0hkwISq8qZRoVY4Bo=
X-Gm-Gg: ASbGnctFavmX3nilkhtPdiMczKcBsT6APuSrQnZLeqJhR5ck/iduYRw9c1pEWFSgACo
	KjvWCt5JnnarozJYth6/0WGb5T81/Xpx5e46mLZcXMkHXzBh14CdUq8EslUB9YlYIeXcwgau+12
	N+jsB0/gSx9SjtsfxH4lu/t9i8oWrH75uCiNJ3+o8faaop2AFKrZdcXUTtECVA8yNxVd05th2Xu
	yecvlRm1KXNiLcuJ4hwSftzRUgaZNg3B7GkTxB9ifrHaScrTHCBYilhrX10GiqNulH4Jd8P6Vib
	6N35gSr4UKZn9i7KHKGJYsQTHQpN/DKkhbg9OkO2roZg2P0KhZzLicaUXpXek/q+hi/8tdE=
X-Google-Smtp-Source: AGHT+IGWDa45dg3xRQlPrBCB2RykQBWQjwcAddvmjkqC+H/VzwhKqUGo6U53A3FTwTYDMQ62clov2A==
X-Received: by 2002:a05:651c:220c:b0:307:e0c3:5293 with SMTP id 38308e7fff4ca-309036ea829mr7444151fa.36.1739358769271;
        Wed, 12 Feb 2025 03:12:49 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-308fe555e5dsm4932671fa.72.2025.02.12.03.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2025 03:12:48 -0800 (PST)
Date: Wed, 12 Feb 2025 13:12:46 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Lee Jones <lee@kernel.org>, 
	Stephen Boyd <sboyd@kernel.org>, Amit Kucheria <amitk@kernel.org>, 
	Thara Gopinath <thara.gopinath@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, quic_kamalw@quicinc.com, quic_jprakash@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH RFC v2 1/5] dt-bindings: thermal: Add MBG thermal monitor
 support
Message-ID: <iuzhsmcfmc5kxpxirqdacxgaqqufs3hdhlvhw2mds2wq3rb6si@pcsvops5yd6h>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
 <sybrfmrpegq7fcqykgsfhm56wjyx5vp6zafqw2d73tiral64aw@hg4di55fzdle>
 <9a61e73d-29d1-4189-89eb-1299b8934af9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a61e73d-29d1-4189-89eb-1299b8934af9@kernel.org>

On Wed, Feb 12, 2025 at 07:06:56AM +0100, Krzysztof Kozlowski wrote:
> On 12/02/2025 00:57, Dmitry Baryshkov wrote:
> > On Tue, Feb 11, 2025 at 12:50:12PM +0100, Krzysztof Kozlowski wrote:
> >> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
> >>> On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
> >>>>
> >>>> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> >>>>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> >>>>>> +
> >>>>>> +required:
> >>>>>> +  - compatible
> >>>>>> +  - reg
> >>>>>> +  - interrupts
> >>>>>> +  - io-channels
> >>>>>> +  - io-channel-names
> >>>>> Binding looks ok, but this wasn't tested due to unneeded dependency.
> >>>>> Please decouple from dependency, so automation can properly test it.
> >>>>
> >>>>
> >>>> The dependency is needed because this mbg peripheral is present on only 
> >>>> targets which have GEN3 ADC5, for which the bindings support is added in 
> >>>> the series [1]
> >>>>
> >>>>
> >>>> [1] 
> >>>> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
> >>>
> >>> Sure. Then this cannot be merged due to resulting test failure.
> >>>
> >>> Please don't post new versions before this can be actually tested and
> >>> applied.
> >>
> >> Heh, you responded *after two months*, to an old email so even previous
> >> discussion is gone from my inbox.
> > 
> > Are you responding to your own email?
> 
> Look at the timeline of these emails. Satya responded after two months
> with some comment. I responded now. Then I noticed that it is talk about
> something two months old, so I responded again. Two responses from me,
> that's correct.

I see, Satya's email didn't get to lore.kernel.org, so it wasn't fetched
by lei.

> I recently got way too many such 2-month old clarifications.
> 
> That's indeed right of the contributor to respond in their own pace, I
> am also sometimes slow, but really there should be some limit. It's
> putting unnecessary burden on reviewers as now I should dig some old
> discussion.

-- 
With best wishes
Dmitry

