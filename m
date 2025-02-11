Return-Path: <linux-iio+bounces-15391-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8E80A31A0B
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 00:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF17188A24A
	for <lists+linux-iio@lfdr.de>; Tue, 11 Feb 2025 23:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECEE271821;
	Tue, 11 Feb 2025 23:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yLp7Sbyl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5699271803
	for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2025 23:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739318286; cv=none; b=pV4X63qsA0C1QVXJOILUKWW4bT14o12+KkuxNFKcu0EwctCoYqQVxxLV7dXt12BJniI5D+GCsptgVKuvcZCn+r8ihxrtDtcYAr05uQqaA+D40R16ufrlrgEamSZdsyhgujLrBjRUlSHi68y5wd3DoifxbjvCV3XwYUCw8nQKCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739318286; c=relaxed/simple;
	bh=RE+aHUIVuDPsDQj42j/fwrw4kpBxa9lJz16JhCXTAlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9/qAtuWje/GqfX3s2nqHX05cakOiy7jDDmFi9xz/jx6FGoqfDR9AqYqctSU1jbmvIJyk5DKj9GmBa5Tdr5p0W73HvA/5Y0wtsAnnSWsI0FNwDQm+oUe+Ji/yAg3jAXEpvyXvY6Lpwk81DrgHeSpebXWE7AccHqhMA9ttllbEN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yLp7Sbyl; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54505c79649so3261006e87.3
        for <linux-iio@vger.kernel.org>; Tue, 11 Feb 2025 15:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739318283; x=1739923083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=yLp7SbylZpV6KkaSft03RvdgKMMDJvCbp1+9KxKl5etNCsfLKcWaKWp6vqobcyoAx4
         0s5SuVB24scHYfL5DRsd8opiUm642VHMw0wFiR20aial2/9DZWNwTSMVYAmQLCNki7jL
         Jpxocb4OXYrDxTr12FjdGB61F5AGXC4BCtCpVw4Ry0VjUOlMondYP+Dt1un41k3mW63W
         BdWiMgN6qxGRO2QvJOxAPbNEbtw23ny7uR4Gy1APWR3DeqJ7IXiENPu/sqn8YnK7tcbr
         IqosVIT6PZ8miakhIlc7rCJ6Onerf/9e2h1Ogt9I3m8D1xIQXzW7KTYN+yMabSuDgZpE
         bbpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739318283; x=1739923083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LX/ULobNxBgRiiE6AfMWm4qglJRxW2bL2STp6gK7uVE=;
        b=akLSIPK6CWTG3bG/+5/CAtXgxqZFPaS2QmOcAFNv5hXvlAF6LlqtxnHIkgCKai4daL
         TL33oAtJQwwbGH6o7F1Qj5dcI6NTGmI4ksn4q7xMVVtJJprSdgSkuLfoBySALAO47Dka
         OWhMgdMFKH9YVp/XZP6b8AT5VR9iOOoJH6v3C5H3tH7LjFA1KR+SDWlXxnL/NbjwCMGB
         0JDOWnjlwarPFO6HvGtBukzYJt6grT+2QWAjvXbF7WRot0SyHFdPN5uHxu6lwj4abhwQ
         T8N0Ufp/fqmH910Ozpiw3h3Tqvj1QKVhNIGpSZQMKpyNZVjJvdNMc/ndmeWTlwvYGdL8
         /uTA==
X-Forwarded-Encrypted: i=1; AJvYcCVJy0VnlWQTo1tMi9sVwUKgTQJ4Fy1Etli9yx6KCI/ZgjZkJNQUqsVkR/UiaH5OlqueMQXoxGMmvTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbpX4tOa77NUyNTRwgLNhctPVH8bN+rZCji9T9zzsSmV0AyR6N
	8YSKWW8f4yx9BPf7PlZxCn7O09HAMTeMfo3fpYng7nm9nEHB7mqlgdw8TSGzgoY=
X-Gm-Gg: ASbGncuEcahbPxy1IMkCmLf0GdcsEBEObSR+8UimJQg7FQLYxkjmuweVsVnf2ajSvJ1
	a0FjckpIOrmEKPcvGxj2KksIRoE5jntj1CXkDINQcAVRzwWy78TT32z0e8HApAzQie9qlnyhPSk
	XjMTvwyi/VcIUOXUe1i0IKuQ95C6UZD8VIWCcY/c5H0QE99VtLFms3L0RkLLQqFMuO9aB8JsVBo
	K+1xjXNewxmvxogMMorYQHWbYmTMK+KES+5xV/3UbeLfqRSYoX0zJcZCvAuzlEICoIWt3pk9dmG
	J3KqEFRvmg4jHbF0xWVYG4c2Jd2m7IKdkkYKqcS7KcL64eBDNvpGiPkZZnugfEkPs/2//wU=
X-Google-Smtp-Source: AGHT+IEZuHKlP0HFN8WiWm/I8ajOzqgUnqFUKxuS5iwuMpASJK2/hwz0WfYOWgwjCMYH+7xZ6hFXEQ==
X-Received: by 2002:a05:6512:124c:b0:545:353:4d46 with SMTP id 2adb3069b0e04-545181148dfmr238228e87.25.1739318282977;
        Tue, 11 Feb 2025 15:58:02 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54512236ba5sm393771e87.110.2025.02.11.15.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 15:58:01 -0800 (PST)
Date: Wed, 12 Feb 2025 01:57:59 +0200
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
Message-ID: <sybrfmrpegq7fcqykgsfhm56wjyx5vp6zafqw2d73tiral64aw@hg4di55fzdle>
References: <20241212-mbg-v2-support-v2-0-3249a4339b6e@quicinc.com>
 <20241212-mbg-v2-support-v2-1-3249a4339b6e@quicinc.com>
 <ojukpywkhu72cimujmijzidf26654g5vkjaj477imcf4suz2o6@cmow62jcqsfz>
 <7a5db383-914c-4c1e-846e-5d68cc6a7765@quicinc.com>
 <fcd718be-fe8a-466f-bd2b-7b75d5f8dd6c@kernel.org>
 <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c85903c6-6a89-4382-bfa2-2fed95f0cbc0@kernel.org>

On Tue, Feb 11, 2025 at 12:50:12PM +0100, Krzysztof Kozlowski wrote:
> On 11/02/2025 12:46, Krzysztof Kozlowski wrote:
> > On 11/02/2025 12:15, Satya Priya Kakitapalli wrote:
> >>
> >> On 12/13/2024 2:08 PM, Krzysztof Kozlowski wrote:
> >>> On Thu, Dec 12, 2024 at 09:41:20PM +0530, Satya Priya Kakitapalli wrote:
> >>>> +
> >>>> +required:
> >>>> +  - compatible
> >>>> +  - reg
> >>>> +  - interrupts
> >>>> +  - io-channels
> >>>> +  - io-channel-names
> >>> Binding looks ok, but this wasn't tested due to unneeded dependency.
> >>> Please decouple from dependency, so automation can properly test it.
> >>
> >>
> >> The dependency is needed because this mbg peripheral is present on only 
> >> targets which have GEN3 ADC5, for which the bindings support is added in 
> >> the series [1]
> >>
> >>
> >> [1] 
> >> https://lore.kernel.org/linux-arm-msm/c4ca0a4c-e421-4cf6-b073-8e9019400f4c@quicinc.com/
> > 
> > Sure. Then this cannot be merged due to resulting test failure.
> > 
> > Please don't post new versions before this can be actually tested and
> > applied.
> 
> Heh, you responded *after two months*, to an old email so even previous
> discussion is gone from my inbox.

Are you responding to your own email?

-- 
With best wishes
Dmitry

