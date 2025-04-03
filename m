Return-Path: <linux-iio+bounces-17594-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20220A7A314
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 14:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B83B07AD
	for <lists+linux-iio@lfdr.de>; Thu,  3 Apr 2025 12:45:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD27B24DFE7;
	Thu,  3 Apr 2025 12:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M891MY8V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0E82E3385;
	Thu,  3 Apr 2025 12:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684329; cv=none; b=Jffhq6O15CkEpw5anamRVFxfCIX5sBcqY2Vxan0zjWdAgQ9tBiy2lTg6hglff/O9sM18Ihf0ayKfUGvNFJLPDSUlu+9hCe7lfXmkpMRvaEmNQicUTl5ofQJTln6nh/2p7x/K5jiwp5rRfXfLtiGoYJM6cD8AgPm7k3YG9hRRFUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684329; c=relaxed/simple;
	bh=DmmRXnc+C+5Qzrcx7mTkzVCPDCYNLp85kXYxa6U1GHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oh3wzPO7Q9UbnU1HaoFdY0U0v0W3erpea5VvO+ZB2ewSmghh9ZklOQF4IuNFpvWNprvortewmEjWGJL9TfcSjaDngdCAnoh36bKf+Q27+ifdkXb63+Sz6m7I5bC6SbbJoDP0tCJPA9Im2Z1U1vkcAw3mwHqhZJGtmpcNAFoNDKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M891MY8V; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so778241a91.1;
        Thu, 03 Apr 2025 05:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743684327; x=1744289127; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DmmRXnc+C+5Qzrcx7mTkzVCPDCYNLp85kXYxa6U1GHs=;
        b=M891MY8VT8uIpMV3ljY9tR0eoN5FR6LdKRkseV8v23zcbctU0vNaoS6G2NKplE5b75
         P0tHkQSBP4STzelUj1WzuEtyAjPzzObkvpZgZr6SQfm0zSZ6Nd1bMZ8Ax0qYjgYeaPG1
         S60EdccZkVR9X9BXHM1nM7LavSwoMip4TX59GhQ5M1Jv1Hbsm/WQIZmtC/qssLj9hXBt
         8w2v6x9AQ+UziwC+9r6DCIG40epIaMv44ols6tLQqEB0jpV1N/jPSOCzd/Gdn71CPWLE
         TEDQeDX980gqhwfB+0weisGTsy55qPpp0G3ziXfZiwvuAOKnveIqDsYbxgmdckvtFukg
         10Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743684327; x=1744289127;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DmmRXnc+C+5Qzrcx7mTkzVCPDCYNLp85kXYxa6U1GHs=;
        b=m8Wr8R5/P2sHw+jGyUnJLZ8sEFPOoDBWBii1jqqppKIHLLn5ve583WsgldVJLNIHJO
         GEZipfu0oI53JRc4LSOe3hWNnVQyQ3qIa0tGnm6UsWMI14OSZ6UEmCvDZEn1ZYsSrcZP
         zJeYq3MwL63idbEfLmv/lKA/Bo5oYaA0hUVOPgzKXg+kvIZwTe+RhlbHQCujxROtn2wE
         p1EaJmt71KpHa9DozeBJp6K0m2tzPEP2tpY9UBYlTjLhK5bkhO9/jwsk+IP1z3H+2raL
         R/5DuuUMbV03f/8qr0Gar7lm/SPqM0S5GXY2FvV8QrswU3QHnW2xpd+QqoHHZ81IRhfD
         m3fA==
X-Forwarded-Encrypted: i=1; AJvYcCX1lXxn3z8GTj1R6UAw6oXlzpsvPS99yphUdcs1Y+ch/HuzuhVCHPQlDoBwQieBTjjQggc2qljPoi1c@vger.kernel.org, AJvYcCXa8HbhX7FYp6G8SDHhNB286ik3NYXuqKPH5DRDP5bEyrz140dhKlb0tAZeGBG2auoml/VpgVXB5WDA@vger.kernel.org
X-Gm-Message-State: AOJu0YxPdGiVN00yYT7+tXxgSSyC9r2yOWbaLQlzD5tdb2hL20SbubdC
	xOA3r//b45cR/h6/ukVTWLOwcnWJiG3es9SysjKAqq62nIQ79NSVv6fYBOR4vhomY3saBxlIzch
	KcREo0/IgyVWFhZaWaxinp1/cmH8=
X-Gm-Gg: ASbGncuzaLXCMBVSuX6ExZ6pgWWE5ZRTxDDxxqEqlYMVyhjbr4cPcAAnMorg1Gge7cr
	LtGqaBB8JCEd7avd+bvpq9osQ3iAVd3vi6OAufCXiowuJ+14g9k4EY0Xz5bH+ac75SCfszn6JRo
	DMMp73vGELaCW2s+vGjJZmzmAGERk=
X-Google-Smtp-Source: AGHT+IFvf9rTGXfqht4dwY3ke3q4cj6dPEN1J6ApkK+0CgI8Yg8YgwSCCxtscvyZM8lxZ3myJ7t4zKek6684uuFOSUc=
X-Received: by 2002:a17:90b:5347:b0:2ff:570d:88c5 with SMTP id
 98e67ed59e1d1-3056ee3151bmr8782674a91.9.1743684327564; Thu, 03 Apr 2025
 05:45:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403053225.298308-1-gye976@gmail.com> <20250403053225.298308-2-gye976@gmail.com>
 <537287ab-4b10-405b-a539-bf3a68a6f4b8@kernel.org>
In-Reply-To: <537287ab-4b10-405b-a539-bf3a68a6f4b8@kernel.org>
From: gyeyoung <gye976@gmail.com>
Date: Thu, 3 Apr 2025 21:45:15 +0900
X-Gm-Features: AQ5f1JrFk8CidTrs9kosL7PSIvpX99enjDuLupdAPZHVSjiCui5VoEZ-WdCeE_c
Message-ID: <CAKbEznuB0+yE-9HXjMjO5fGMcEt+HwR2sC-KG=Zs_qd-8Cg4qg@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] dt-bindings: add winsen to the vendor prefixes
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	lars@metafoo.de, gustavograzs@gmail.com, javier.carrasco.cruz@gmail.com, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Krzysztof, thank you for the review.

On Thu, Apr 3, 2025 at 4:48=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 03/04/2025 07:32, Gyeyoung Baek wrote:
> > Add winsen to the vendor prefixes.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
>
> I am pretty sure you sent v1, so this is v2. And if this is anyhow
> confusing, then just use standard tools - b4 - which would do this right.
>
Yes, actually this is v2. I did it manually, so there was a mistake.
Thank you for the tips.

Thanks,
Gyeyoung Baek

