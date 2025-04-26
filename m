Return-Path: <linux-iio+bounces-18715-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 589D4A9DD2C
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 23:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41D31B67951
	for <lists+linux-iio@lfdr.de>; Sat, 26 Apr 2025 21:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8461C4A20;
	Sat, 26 Apr 2025 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em1eZkhc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195B241C71
	for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 21:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745701222; cv=none; b=bzoLol6AHCZGdWLRQM6eL3w/x+Hx9mI2ijfHrXi/iC4bsSQH/8Py2HCgindInYd9OcfhMlYSG13mDGgy76cvYYK3amFR5/IfTFmltv6QgLlmsiH3OY8AJzg7zyLGKFkp7GYrJQ3RgREZSgpXo+YiUT3UveB0HXN/51w/xCyyG+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745701222; c=relaxed/simple;
	bh=SuUxcw9H3aCaSRwTZHGF69iziRr8yfrwfaB6wmLxfLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gkWHbruLLevc4RGHa3K+WQyDTSCNgdJ7ExGTSvnkyTLl2gSI9EfGzGnyIHufxMP+ddKTVuU57SSRdzLirjVoCJjKauGjUqsE4SxFxt4UQHQ1UMg/w5WTtNeBGmTU0bUNWLf4/e1XIUwfg791/JMId07tHlEkNZQRh2TT4KU+ZWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=em1eZkhc; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-54998f865b8so3450749e87.3
        for <linux-iio@vger.kernel.org>; Sat, 26 Apr 2025 14:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745701219; x=1746306019; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SuUxcw9H3aCaSRwTZHGF69iziRr8yfrwfaB6wmLxfLA=;
        b=em1eZkhcxQ74xSWwxZL4B0ewE0jwt/cDK4ndS5OvM6fGeaekjdbRjpqNveSU1i9qnX
         Ckg/LeQ9aU4WPK7GYtBk57hXZ1Mp7HioymOyt0enptpR8tYPxsNDu4+zcee5FdjVN3aC
         SSSn3MkbGX0/yyV1SMoSEW6gMBRYdId/ryypKK9Tkq6MxBV9ycZX6TVg0V9rROOYSTBk
         ytk5LSUAQMUuyOe+lPZtdgcZdnRkF5IGIw2SuKdWyHJ0gWh2WQU4RzJj8xzO2svUL+Fu
         TM0OT3bpk6pmXmzu4bxT7JLTjCo1UxnxM0uGLeA7Df9IhbmyhsaywFvTuIQnY8XWPsL5
         E5Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745701219; x=1746306019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SuUxcw9H3aCaSRwTZHGF69iziRr8yfrwfaB6wmLxfLA=;
        b=HH5d0lAIQ1heLDUYI81s9zbEFLp5sptgAxR0yhNnepVfnG1c7RPu06QC0cfbKqoYuA
         bNB8XkM8yRqRQXKSEmvuJeHDrBfCQ55hfOhf8t67DD4o9h3epH8I40007igXF2Xyu1hk
         3H6DY6+u95nSSo+HK2oAOQUecZPKb753bHPytUfaoPdgFemFaG01VvSEs1aBbPb2zJbe
         t2RZDJTHLFg3WRFDrXevbPW0FnWZM508THKHTmd3s6Mcjzr/THWofl21bzTWHKY2VBUz
         vUHSs3RHOoMjFxgc1lX3SkcvLNUsJJNtOtxRkoht9OnXh+BYOjqNugpuf0f6jThYOsam
         gYmw==
X-Forwarded-Encrypted: i=1; AJvYcCV31kTDLZolBi9hhUmYb+DjSJt4AEkaTRDPEvfunezPvsnmugShQ4401lZ1Q+HO7EImQDO+lNCmwb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvW320LGoekc1GpnvaayZScxaZ2nx9lhxcoJ3Q7c3yD6NlY+CS
	/J3dGFFYP8qq+wHJ+IPZDTcqm7HMsKWhDlafJD0ZnjbGUCc+SPvruVh6wZz5t/Wkmh2tgWKw9sO
	FQ6sEc9DIcde9GXi+rsTt3HprqE0=
X-Gm-Gg: ASbGnct75upjpT4bn5C2N+GhvHDrj2mxlBKNDaPG3VQLZmzGYpohP7lhH3+hHnWdtua
	T5o3qGeNm1vdeZAt6Rc2K5nBS3n742KuQ4EvA2XINllC6LyygEZihIzNfofQ8KU39n0hZOxTNZZ
	hGwJM+sHnn6TGfULVqklYCkJgbHP8H93FxQhhWB60ODfnPKyxRFgkzBt+kHjYq2mIk
X-Google-Smtp-Source: AGHT+IEkYxtOeq/IhrASoDc/hdHqrki07JzpY51r1rcuBlmu/0moBuinnctiUc3gCfuw3EAl5LqU87UbxpCQDZ672RM=
X-Received: by 2002:a05:6512:31d5:b0:54e:7818:15c5 with SMTP id
 2adb3069b0e04-54e8cc0ff15mr2191229e87.51.1745701218910; Sat, 26 Apr 2025
 14:00:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOMZO5BXp38RMt5vQQWnZBQDzpN+SYB6NVU3c-Krk3po+2Zv7A@mail.gmail.com>
 <20250426160009.161b9f08@jic23-huawei>
In-Reply-To: <20250426160009.161b9f08@jic23-huawei>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 26 Apr 2025 18:00:07 -0300
X-Gm-Features: ATxdqUEgwiqJkcCjaftVQnJwcbb4q2vBTKVr6JiVrBOU0OaaQRCCAlg_I0UvkGo
Message-ID: <CAOMZO5CepxxXo9u+mSB1P8t-tKvayz8b39emo3jHzR+6hr1HSg@mail.gmail.com>
Subject: Re: max1363 : Warnings from iio_sanity_check_avail_scan_masks()
To: Jonathan Cameron <jic23@kernel.org>
Cc: mazziesaccount@gmail.com, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Sat, Apr 26, 2025 at 12:00=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:

> As a trivial test, just reorder max11607_mode_list[] it might fix your wa=
rning.

I appreciate your suggestion.

If I rearrange it like this (only added single channel entries), I
don't see any warnings:

static const enum max1363_modes max11607_mode_list[] =3D {
_s0, _s1, _s2, _s3,
s0to1, s2to3,
s0to2,
s0to3,
};

However, whenever the differential channels' definitions are inserted,
the warnings reappear.

> If you can dump the available_modes table that is generated that might le=
t
> us see what is causing there to be so many warnings.

What is an appropriate place to dump the available_modes table?

I am happy to test any debug patches if you could share them.

Thanks,

Fabio Estevam

