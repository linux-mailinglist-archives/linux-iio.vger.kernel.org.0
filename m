Return-Path: <linux-iio+bounces-23334-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09460B39F4E
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 15:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED0041B22408
	for <lists+linux-iio@lfdr.de>; Thu, 28 Aug 2025 13:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25101E376C;
	Thu, 28 Aug 2025 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+yTrnzi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0931D514B
	for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756388888; cv=none; b=f92mmuVE5DGZ4qheccp9+vhrtU5Q2/PE07beyKr6apG98E5vN0vIaf1gt2/gvHFAUTOh16qgfnc6Ak8/q4Knr5xyj940LdwNwR0GvxHtlPw10EVDPrn/w8a/hPdhkq4O3Uk4Dt2sXNzxzYigtU/KTqqlTkvU7+F/VlHzHB50SFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756388888; c=relaxed/simple;
	bh=coqQMZtgw6fObe/yuZTUpMepoGfb8OyIXvsPgHhHzuA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WB61WekKIZiihe3SkOtCO6IoZWjcPI3UX49CZYfSGXpUmYYDq6IzXHcwyFoG7QJSC6L8zWobQVvH8pcgU6Nu4Bx1gviq7GvybF0RFSdQhzs/BVDK9uXVulrCcove9O574KNCsJrdrwVDqeExuQBxyLXbZIkTVCn1gZGTVLfGuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+yTrnzi; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b4c3c36643aso598633a12.3
        for <linux-iio@vger.kernel.org>; Thu, 28 Aug 2025 06:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756388886; x=1756993686; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTSXCA8Vdv1FI8G61EVlMQb2MrnboGC46Yu6Bwsv7kQ=;
        b=k+yTrnziCc/vLmmVI6/0qDjqXjBLzfp6Bd+YbJE9isXXCQLj13ShqA5TCmFcZzOT8Q
         sLC/qjbaZFDPmkYp3Jo1UQZTOC1Hljg3sQBiU40IR7bTZjQSKGnwv3eYXVa7Z3b0+jUq
         IqHO+MXbaRPdMFtZp9QA3g0b9us9wmnyVG93Fcr/iqZf2LbWQu9GwHnx6t1PG1ZGAiKL
         +0RSpJP2A6E+U4HcuilcmBF8c2Q/cWFML9djoNiskc407q1uOdi2lczwkacPBgd02K5S
         URFd3E70ldEgX8wmm0rfiqFAS5nMOZwrEXb4kROdEq/WQ+g6Gq47o0S+E4UjNMHqXEXe
         F44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756388886; x=1756993686;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KTSXCA8Vdv1FI8G61EVlMQb2MrnboGC46Yu6Bwsv7kQ=;
        b=kahb7F9JAD7xkxDKIDZbSu0MT8a9lAEJ3bf8GilOD/dszsz1n02YY9R2xt/u9UKzJi
         c6jwrxn5T1k8oW3hSLPP7xM4tyOvjv/lxMalIgvT4HjmYiGYzAQPW3kKG/uExjn657Qk
         b82O0s27CWyVeHI8A1XnICpbzqwUhXsutFH+XkB6y6sxi+7I8vViB1YN3VfPpxHVS4iq
         uBQmXozxiqzqd7czWHmfkgcbb9VOpQg4+EnW+PkZTTqpDHIXGXSbNKLwf/E0NpR5Rw9o
         4qXCqQB0gUUeGecoRPMiK3tvjhrX4mPmtVcsGSJbV1dsAfLbWS4UTOfrwmBo11aeA5OO
         1H3A==
X-Forwarded-Encrypted: i=1; AJvYcCUOdVR38EDdsI5tPAb4SqRseH9i3TmVsVZkeZCU1jI9snSAYSGy3vwGMtUAKygCBvDlQeZah0l3zr0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0JSENJ6/f4NM13z5MfHkxtDHjb0742jPt4x7xcw+nqEA7PWiz
	yPaElK4zlOQWbuy1e9uZt2mCgsjBy2weu+ZQ+QEj4EpcVO1pTznisAMXH037fCSJqR8JpdVszK7
	9cjcAO9b4krBhVOTVdNfcEz0hoVBgrFY=
X-Gm-Gg: ASbGncv3NRHq+W7GQC2DujYGoOVGxNO85IMoHvmI9NuZEpMRg5LTnaZe8W+W2k4+s49
	Z+dCk0AX68WYiN5miFfFVV25icU/qZqqEUZA7AP+FV1pzheALQujNbAQhv1SeUyA+iVLshjClCG
	HDS2luxbBch33R+xBvCSenDKXcUBONwSS0Zqbl0RFKg0Gacw9J1jmTKTtBhBhkVQaI6RHw50xZB
	YkArc/fRwJm3D0eQFTEzmQrzWNfB2hqDkf/IKO9
X-Google-Smtp-Source: AGHT+IFrf+ZWZ5Wb9ckNr1iBsbvZ+/KwUu+REEX/62nwkRbDsNe0FkaLqoBhJK5fH9t+XkzbLyT9MdtaFdDMqukJNYk=
X-Received: by 2002:a17:90b:530f:b0:325:6598:30e5 with SMTP id
 98e67ed59e1d1-325659833damr24071398a91.23.1756388886163; Thu, 28 Aug 2025
 06:48:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
In-Reply-To: <CAJE-K+CTfwVJkKEzb8D0hijg1VRK4EUOBCytbFJme7EiLMFWBw@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 28 Aug 2025 22:47:55 +0900
X-Gm-Features: Ac12FXzwR4nF8MU0cdhYFoyrOyQcJ8ndFcbJdxMRbO6xZ8iAdOKawGfq1zL7o9g
Message-ID: <CAKbEzntRe1h_5_5JqJ0hTgYdSsrHZ=ZNtZiTTJVuRAMAEmpSKA@mail.gmail.com>
Subject: Re: [RFC] chemical/mhz19b.c: Integrating mh-z-series in mhz19b_of_match.
To: Sidharth Seela <sidharthseela@gmail.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "dlechner@baylibre.com" <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, linux-iio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Sidharth, sorry for the late reply.

On Wed, Aug 27, 2025 at 4:43=E2=80=AFAM Sidharth Seela <sidharthseela@gmail=
.com> wrote:
>
> Greetings,
> As the mhz19b has been discontinued [1]. I was wondering if the newer
> series sensors,
> could be added to the mhz19b_of_match, particularly "winsen,mh-z19c"
> and "winsen,mh-z19e".
> Note: In mh-z19 series 'e' [2]  'b' [4] doesn''t provide a
> communication scheme in its latest datasheet, only 'c' [3] provides
> such a scheme in its datasheet.

Yes, that sounds good.
As David suggested, using compatible =3D "winsen,mh-z19c",
"winsen,mh-z19b" looks simple and appropriate.

> Refs: [1] https://www.winsen-sensor.com/sensors/co2-sensor/mh-z19b.html
> [2] https://www.winsen-sensor.com/d/files/mh-z19e-co2-sensor-manual-v1_0.=
pdf
> [3] https://www.winsen-sensor.com/d/files/mh-z19c-pins%26terminal-type-co=
2-manual(ver1_2).pdf
> [4] https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2=
-manual(ver1_7).pdf
> Thanks,
> Sidharth Seela

