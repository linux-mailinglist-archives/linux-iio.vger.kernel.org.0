Return-Path: <linux-iio+bounces-23322-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B94B37414
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 22:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66CD7C67E9
	for <lists+linux-iio@lfdr.de>; Tue, 26 Aug 2025 20:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0C1283FD0;
	Tue, 26 Aug 2025 20:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPZtVGpf"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0704281508
	for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 20:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756241604; cv=none; b=ALX455MCnHrfTrlM0Nq8DBKk6p1ESow+QijXvo5EKX47J9OgIiSG+0QL3tvfDesi9d7xb57Q4SSUVIzLOC93DKK0ltTgScrDqv9MDmeRNGliL7S/QRsdK4pkD1EVXIM9o+PLs+1oklXj6adhGOdu4CTW3ZKtTgl1Fud218myXnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756241604; c=relaxed/simple;
	bh=R3CnMxXTZrIX3hEfdeDqE9p4sB8kwk22hccKV0mrqkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pABUGgRJ65YXbRlUWPBujEdbeIfSG3gMMScnEbrlGY1GH2WdSAh6wOv/Y8Lk2NFhc73ctKb03UUhdxxRP6rT4x1pjI2tTcoSEmmk9pnAvW1z6aCJXTb94aV1H5MtNs88eueGdEy8qpwZhM8zf//KRiXPZp/aW5usJbA0/tziin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPZtVGpf; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-61c21e50168so5809955a12.3
        for <linux-iio@vger.kernel.org>; Tue, 26 Aug 2025 13:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756241601; x=1756846401; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uxGnPn6J5SfpiDTjYXEy74XpKRjyyY1+Ul3sgu/b95E=;
        b=OPZtVGpfj8fOcKoRGl4U2mHbDTvOiiB4lJ3wMIbc9CWamj+wmL2XFdzM8H3aTtgrcg
         gmOUwn+zCaR30l9/v7tBoggVAbbXTmFMBEhSMxIiAfCVwjC+AXEETv73fKxahnW9yoE6
         /GD6cCDNvbqBt5KRwNob+W+vY3ybSFa0j1V4TRb5Sie2Q8YQcZzAFar2thXxMFPJ8Kjj
         TrfsXi158LzYJlOYpmvc1nt2pHsoI+SNHMSK5f8/VwpkRbPARRszSv0+WNhiTDwJWiuL
         vWWbqKnzEUfCfy+aLOh2RqH8l4CKqbU8Q9wkdO5VIEGetH6Dc3KkvpI6ARPIVA7uRUo3
         f1ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756241601; x=1756846401;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uxGnPn6J5SfpiDTjYXEy74XpKRjyyY1+Ul3sgu/b95E=;
        b=DscoVc2FOqxl//CP13yAXli1/ucfO+gXWWErA0h9gsj7fcX6ZWa/MC8LtpCY8ZHfb9
         OOWV2GgE42OPuqLZV6lsfswp1AGFG/+jfiqs2coJ9FV+RgYXdD4MEE+DCjqU3Xz2pfYp
         ms/4FQN//tROzO7MTFQQRyar/Urx1ACzAthivfK7QP6OOBzsy6Kz660XsQoS50bxkrka
         esT+Vn9pJQ6rfapVF9pQLF2yxaruDYsBuaB2Vu6eTfhYmwiChbzVsUC3KK4NaTM60Qqv
         4M2fd/oTtwj3OF2AZXrgoAGIK6k3YupkkkjMm1LEb9VWMi4wqP/e93m7tTykRczSDGHa
         lRaw==
X-Forwarded-Encrypted: i=1; AJvYcCX5kHcdy2JPy/03BICgXCL6dOuqC3wbKSyJNlMYOmcZnP28F8Ofy5LvQ0/0cWOj9ozVNfV2o0yI8U8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNL48EwXRknlAetzzFSpwBPsMpRgXivopz22rXhlyUv35cfACs
	pIcLLibUAWmpX8ADJqD+2pnbbhNHbomkdS6oTr8IsdAb7gMEq1z/BvT0duVQyb6+kc/6vU/RWwu
	TZOgaiecL2IMJ6+4oPqfV0ar4a+uAe+0=
X-Gm-Gg: ASbGncu5p3OV3aqrZK3P02z9GF89iE2hyNmZOWjm7JCI9Obs2MQt8QUdMVU3sadP1qa
	g4qKlU+imdc9ihx8hB7uoLhxV1dyvQxLAgvlC85C0AdWhCgsItEsfpyQpvDeqewn5rrmexaZfPq
	pxFHtDOMRq5NgTWQ/9PHg5aivfleGQadZC6tFm04ddfm5JWMBo64Vp/4lN1YT/rHdL+dmNrrdqr
	UTLFC7duZyUguZXZMxKiHrRetdWE53jrRjGDds7IA==
X-Google-Smtp-Source: AGHT+IET0hiOUPRFVYCQLBM6u6sBblrzlDr4Hu3SyInf/b8qlOpx4AS9cZ91fClqJRYXBsdtQpyPGISQRCdVR+kRPmE=
X-Received: by 2002:a05:6402:2815:b0:61a:1a57:31a with SMTP id
 4fb4d7f45d1cf-61c1b49d966mr15404185a12.14.1756241601219; Tue, 26 Aug 2025
 13:53:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
 <9e5f3b88-d27e-4c0f-8569-dda353d006b6@baylibre.com>
In-Reply-To: <9e5f3b88-d27e-4c0f-8569-dda353d006b6@baylibre.com>
From: Sidharth Seela <sidharthseela@gmail.com>
Date: Wed, 27 Aug 2025 02:23:08 +0530
X-Gm-Features: Ac12FXx3zftDj_I64aEy_MWt3YHrfXNR1Jf4-ieL9jro6e26oqnPMGWDrzUABl8
Message-ID: <CAJE-K+Dhbjuh8atcTPAEqDa+FNRt3t=8WxEh8FFMbcpJHF0Q2g@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: David Lechner <dlechner@baylibre.com>
Cc: "gye976@gmail.com" <gye976@gmail.com>, "jic23@kernel.org" <jic23@kernel.org>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 1:27=E2=80=AFAM David Lechner <dlechner@baylibre.co=
m> wrote:
> What are the differences between the different series? Do they have
> the same pinout? Do they use the same communication scheme?
The pinouts are the same, the communication scheme is the same as well.

Although there are subtle differences and some missing pieces of
information in mh-z19c's documentation.
MODE                   B.                    C
1. Physical Parameters
- Avg curr@5V       <60mA          : <40mA
- Peak curr@5V     150mA          : 125mA
- Pre-heat time       3 min            : 1 min
- Working temp      0 to 50 C       : -10 to 50 C
- Working humidity 0 to 90% RH : 0 to 95% RH
- Lifespan               >5 Year         : >10 Year
2. Range settings defined
                    | 0 - 2000  | 400 - 2000
                    | 0 - 5000  | 400 - 5000
                    | 0 -10000 | 400 -10000
3. Commands described
Read C02.       0x86: 0x86
Self-calibrate   0x79: 0x79
Zero-calibrate  0x87: NOT DESCRIBED
Span-calibrate 0x88: NOT DESCRIBED
Range-setting  0x99: MISSING.
4. Calib time
zero-point  20 minutes : 30 minutes>

Note: As the latest mh-z19b datasheet (v1.7)[1] doesn't show any
communication parameters,
have used (v1.5)[2] and for mh-z19c the latest documentation[3] has
got communication
parameters. But it is missing details on essential commands such as
range settings, which I
think only by testing can be verified. And for MH-Z19e[4] it is
missing key communication
schemes/commands.

Refs:
[1] https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-m=
anual(ver1_7).pdf
[2] https://www.winsen-sensor.com/d/files/MH-Z19B.pdf
[3] https://www.winsen-sensor.com/d/files/mh-z19c-pins%26terminal-type-co2-=
manual(ver1_2).pdf
[4] https://www.winsen-sensor.com/d/files/mh-z19e-co2-sensor-manual-v1_0.pd=
f
--=20
Thanks,
Sidharth Seela

