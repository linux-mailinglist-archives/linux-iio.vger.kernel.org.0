Return-Path: <linux-iio+bounces-23373-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C46B3BAD3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 14:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3DB1645A3
	for <lists+linux-iio@lfdr.de>; Fri, 29 Aug 2025 12:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EB793148C7;
	Fri, 29 Aug 2025 12:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inDrOC9M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE1A229B1F;
	Fri, 29 Aug 2025 12:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756469171; cv=none; b=W3Hko63I5Fw+c6Y0flbCU8fdB0wsByS+9KO4YTwwopq4LVSCK3fH48E011NMro3b01e7UDQMO/AkOqbVA616d5IfQOAvLDthRLctlHFrh5VKEcvVwTc3hhsmoxgxh91efgHYMKAGP4kmbvMIPxYgdql3NCd3JaKcWcyU0o/YX9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756469171; c=relaxed/simple;
	bh=EWFoZW6E8p6KfMm7z5oMEsBNGeK90oTRtTy3fxksL6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gWsUxMmiQ5vmdMJb3CJ1Ea99tU5S72l/xuFG7uYP9XkU8nIEma+5lkSaVHakwO0zJv+C3xhAX/75Ig0svfPEU+wjVP+qcFxQc1UBQ48JQjwLNpgboEZKFhJtrpZMl7HOG2asAaPVaTWNx56fGP47XjOnRe2OtnDKydMNWwn9y6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=inDrOC9M; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-61e110cbcd0so441569eaf.3;
        Fri, 29 Aug 2025 05:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756469169; x=1757073969; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jJBJd9BeeL7u8gdmx6QfCBeyfgHtE3/KhoYQ1c0xrPs=;
        b=inDrOC9MSPmUmdBUIz0tb5BjhVwCyb1J+wb2ErAmaYo8RgTQHgSucBufPI5YZS1aid
         grGzrbqAc6dilvraExBf75FbhJpgQYEd9yFBbAbqVOb7hNOw9anKbjkZ7JMRbiKDhGJg
         3K5B0R9aF494Yc86pw6RAUGbTYunMKilxQ+mv68IpgC+iLLu6PaBBv0Si3+tCmXRKXfE
         sBdXJTKRh2Jpxw15UgVmDOdfdNl4GG5CCedAMxV/8RZjAYY4alkv+IJGENv+PoJM4wQj
         k+4O4/shZNXyKhCa8ts9wi7+LVVoRAKLD+EPCNUEXt7J3wyiuj0fi5Xq6+qOwKaRtd7y
         prOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756469169; x=1757073969;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJBJd9BeeL7u8gdmx6QfCBeyfgHtE3/KhoYQ1c0xrPs=;
        b=QrVJRLils16488YJ17ZS/hlqQYEI99QNOvAIzCg+0jYMJzIKLBenStpYHeXsgF1n1R
         97pfE4ktvIxNs9+v2WhThSlgIetf3hyrIG1kx24CUR4afP+fv8i838lEkI6i/HHJK9k9
         wr89HZ02i7mAtR3k6W7pWguG/hF1q3vMPmNDlsw3HdEtjpWgwbB9SWLCCxxK63c+6cHm
         rhcRmfNLY+5H7uHaVYtROvcHzXZUat/9aOJXVE3VK5+mqEpVHBRujIkWIsb64hMm0yGW
         lBka+pOVWN84vXhq/1mXB/1NF9Ly0yMq8VMnjv+zol3mf4KI1leQAO3nn78Y6WP8CIg4
         utjA==
X-Forwarded-Encrypted: i=1; AJvYcCUl2WTv5QIpT3AVmmLDcCgw684wo8BRB1W8DMnAfqo5wjQb7c75ciy2YVfxO22tyuraSQjagLgiWptX@vger.kernel.org, AJvYcCVKsgvhvOPUylzt8CZTApDBNr4pOmeTZQhoT1+9YM4MlSa0GPAMgFcmLFzUuF/0JURIoM1Jadl9Vb4A@vger.kernel.org, AJvYcCXItMCsP6L7vjVHrtQ1WqV5/bdoIhGHiRmRFtzS4BQ3vyQ4ySlAVklAzwc+loeLtGF4p05wZHkF17lEcadu@vger.kernel.org
X-Gm-Message-State: AOJu0YzcWWdbqzGZLiFsKhPE6cpFY5oZTRIlTTOF+UIKK3FdmBblIPGJ
	SVFFwMUIm52iANSs7JRoZuqVFOqKmBWgUmeFfEu+nhLwxUpRfbAOs03PM30s6zSKf+Bk3zcZgJJ
	LiOlWDhA64EVB3DRP5fTYkVyBWMo3onRWonY9ujo=
X-Gm-Gg: ASbGncuOmzCuKQKeFVuGzqFILm+HNQ28eJl2fO6N4vfGAvK0xJnGVcp/TKBqcoz/m0d
	Px9ANN4dSLwCXivqUGcb3xiuviiqdY19ec67ufsUs6lxvgAs6Qx3ff2NhBQCETKrHHpJNaWTZhA
	1/IKM4AZR5XC1gJsbqVeo0MDJxGeCoK69kORGy4gq4DX+Vg/eZQNPE2HP/BprFkFvxHwPz/2m7R
	aycZtoXCbRA
X-Google-Smtp-Source: AGHT+IF2HoqqI9/KEFYMh9FRd/mcJEHTeMiIcKR4PGQPiLR0u2XUdG4ltyTHRyUbl0ycOxp4wqRZ/+1OyfCeHSSVW1g=
X-Received: by 2002:a05:6820:498c:b0:61d:cc82:251c with SMTP id
 006d021491bc7-61dcc822b75mr11081329eaf.3.1756469168693; Fri, 29 Aug 2025
 05:06:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250829-tlv493d-sensor-v6_16-rc5-v5-0-746e73bc6c11@gmail.com>
 <20250829-tlv493d-sensor-v6_16-rc5-v5-1-746e73bc6c11@gmail.com>
 <20250829-fluorescent-delicate-pogona-c96b5f@kuoka> <CAFmh=S3jKfGMek=ZPUrfgh9fXZaaq6zNBOmCyEpoe0qGpfbt5w@mail.gmail.com>
 <75b2db61-84ad-47a4-b809-da7e63e8dec8@kernel.org>
In-Reply-To: <75b2db61-84ad-47a4-b809-da7e63e8dec8@kernel.org>
From: Dixit Parmar <dixitparmar19@gmail.com>
Date: Fri, 29 Aug 2025 17:35:54 +0530
X-Gm-Features: Ac12FXxxb4_C6aV4ChQfpC8QcdG71lHp9PLjlBAhQjiEDnitmqw_fpJEjafEY_k
Message-ID: <CAFmh=S1K5Okfs30m-d-etXhpPTgQ=pb9+Xnr0DWZ5AXkqFKQ5g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] iio: magnetometer: add support for Infineon
 TLV493D 3D Magentic sensor
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> >>> +INFINEON TLV493D Driver
> >>> +M:   Dixit Parmar <dixitparmar19@gmail.com>
> >>> +L:   linux-iio@vger.kernel.org
> >>> +S:   Maintained
> >>> +W:   https://www.infineon.com/part/TLV493D-A1B6
> >>> +F:   Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
> >>
> >> There is no such file here. Apply this *patch* and check by yourself.
> > That file is being added as a separate patch(Patch 2/2) of this same
> > patch series. It's already reviewed by you only(based on the name).
>
> No. Read my comment again:
I am not sure If I understood what you exactly mean. Below is what I
understood, please correct me if I am wrong.
>
> "Apply this *patch* and check by yourself."
>
> It does not matter if you add the file later. The file does not exist
> now, here.

I have applied the patch on the latest mainline kernel codebase, it
gets applied successfully.
But yes, as you pointed out the
Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
file does not exist by applying JUST THIS patch. That is because that
file is introduced by a separate patch under the same
patch series mentioned below.
If this is not what you mean, I'd request to clarify to help me
understand your concern.

> > https://lore.kernel.org/linux-iio/20250829-tlv493d-sensor-v6_16-rc5-v5-2-746e73bc6c11@gmail.com
> >>
> >> Your patchset is still incorrectly organized. See submitting patches in
> >> DT dir.
> > By "incorrectly organized" do you mean order of the patches in the
> > patchset or anything else?
>
> I pointed to the docs, is anything unclear in there?
I did referred the docs you
pointed(Documentation/devicetree/bindings/submitting-patches.rst), as
per that only one point which is
being missed here that is #5 _The Documentation/ portion of the patch
should come in the series before the code implementing the binding._
That is applicable to dt-bindings patch of this patch series as the
dt-bindings patch is a seperate patch.
Apart from that, is there anything you think this patch is missing,
kindly guide me.

Thank you for review,
Dixit

