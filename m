Return-Path: <linux-iio+bounces-17520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC216A78498
	for <lists+linux-iio@lfdr.de>; Wed,  2 Apr 2025 00:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F31116E0CF
	for <lists+linux-iio@lfdr.de>; Tue,  1 Apr 2025 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E40203714;
	Tue,  1 Apr 2025 22:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc3F5AXN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA422154A;
	Tue,  1 Apr 2025 22:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545790; cv=none; b=q52i3XA4H5OziNedysRKUQMxmLOTsu6xke0WSTYg4Okce6L/mTpq33cVIBC4r5kcC45IE4lHJlxabL1cozA4eW/FNj5UDeDTi1SLBwCl+q7IhXV5iRmT0yXI4t0q+15wkWfO8jIVOtEu2aqLVItVGpBq56NHONlBhUce7Vojfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545790; c=relaxed/simple;
	bh=4ZZoMk7Bzxg7EPnIPY4kMYP5TXrvahs3Zqj6VZqMzGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pt5JBherCbAaGZqf2Zkx7j8pjjo4XKlcVN/fCYP8TgZGNUxNoW1Ak7x46uEp7Zmgp+k6ffiqsR/S5kKyYg3jZH+MFfYRhY/uOioKU7t8BdqD9Bz0NoMxuqR/GWSnqZIVa48kRH8WRv6a8jrzHsaT+gQHfxdBRoJRC+mJ3T1GMVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc3F5AXN; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e6dd991a0e6so1113206276.1;
        Tue, 01 Apr 2025 15:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743545787; x=1744150587; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4ZZoMk7Bzxg7EPnIPY4kMYP5TXrvahs3Zqj6VZqMzGM=;
        b=lc3F5AXNccPhfFVI5WVz16JVtagdxy8jwpZYO/z2ezaC0TquM/bnMTJycj8wjspJb3
         JsDAlSatlmCOEQo8dQEUfCuvNbvPFhuWCeOBU55EuYQlVCgLO82FOVkrD0Xk44sYpL7M
         k/aLD61+ZFhH7zwSlZlRr95LA0myPBzYQJjHs/Hk9wLv9YpBlvNstIvopYjSUdW16m1I
         D3MUhRxK0PVvsD/y4LlXX7NSxNaljPOatHvuZhlEiwhSYVpozl2KyaVraHzcFvIA6NV4
         +b2dxTaxte6VvsC6XCvDesC7Pq5BctwuiY4KYAK1p2w7A7WY4BFOiwGyNdRw1FfaNhgk
         S2EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743545787; x=1744150587;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4ZZoMk7Bzxg7EPnIPY4kMYP5TXrvahs3Zqj6VZqMzGM=;
        b=efTH64R6+DCuGTlG9r6KHXGFMOVDiqiNvufJZ1Lyusr9h7LnEnbpJ6PS3GtTwQ1wSf
         LrslimZ7kM7NyRFTX0DYmvJV7JXrz5a5xMr3Fjm3zD/cpTx4JU5HG1YMu7xvF8yinBfN
         SbTLEwopI0VvFuTSwOoFTkeHjc04fZXgy7elbwbP5mZ2sT811jHPEzX4K32zomz+2dEl
         6zHLe43f4B/wu3GlY/0B2V/D8RxuKm/OrP098aLquYpHYEPOrZTMD2QXUT+GOOFxBzxc
         atfzxrvaDOx4yzZHVKhJ8UQKSCJxfijXsRfEA568ec/KrYdfXRQp0Lzkh2M3iWZVYPqa
         S2Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXu2nJSnw6UVdLKybZ/USWijxsZA6uw7XWsRptArgUbwepLdMZPajpyMVfC/okxLcsF6zqAlUnc3JA+g7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDv9wsFP5jswaOFqNCwtB/dcSsN8q0TvuBP7YWADM4ou8+38Sc
	pTRl20W3T7kUcPIgZBtKG8sBiTFqD2Rw2KVo0JF/9Keu3Nv/Z2J0yE7iJK+YDwOSuA5vHlaIwcZ
	IvDf+cz54fq+BXypU4bqnt1Ocw2c=
X-Gm-Gg: ASbGncthxThGQAubeDmXDarGtX2/h0FlUR39L1dKFLojAxpW2TLlRm/kjvSorrStEbI
	SDV7oyuOlGRHW/9Y9uhg5Mr/+gpQihuiWS9xSoxt6FQ7+y6xMsbRXjnF1TihgXxCUAm+8SXQxET
	0eoX2w2IuiW+lvBF2y8dTFAYIHgcs=
X-Google-Smtp-Source: AGHT+IFyrBa8Q+V3emMv0/lFeitl4RCHClPtJE1kMBHwIgnDpEGVlYmEqnl5qU4nw4mkToEp+7y4aeRAOhEpWv50Gqs=
X-Received: by 2002:a05:6902:2747:b0:e6d:f287:bf3 with SMTP id
 3f1490d57ef6-e6df2870d3cmr1158460276.28.1743545787458; Tue, 01 Apr 2025
 15:16:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250330135402.105418-1-simeddon@gmail.com> <Z-lm8l1ILFuJE5YS@debian-BULLSEYE-live-builder-AMD64>
In-Reply-To: <Z-lm8l1ILFuJE5YS@debian-BULLSEYE-live-builder-AMD64>
From: Siddharth Menon <simeddon@gmail.com>
Date: Wed, 2 Apr 2025 03:45:51 +0530
X-Gm-Features: AQ5f1JqRj0rIFNX3PN0empxqba0H3yBaX-Fa98HS939Csdmd4a9CT6Ad5e9h1pQ
Message-ID: <CAGd6pzPe71oY=+cy3WqKPyZ150q3pOM3LrPE0_ENeKgd+OvnfQ@mail.gmail.com>
Subject: Re: [PATCH v5] iio: frequency: ad9832: Use FIELD_PREP macro to set
 bit fields
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-staging@lists.linux.dev, gregkh@linuxfoundation.org, jic23@kernel.org, 
	Michael.Hennerich@analog.com, lars@metafoo.de
Content-Type: text/plain; charset="UTF-8"

On Sun, 30 Mar 2025 at 21:13, Marcelo Schmitt
<marcelo.schmitt1@gmail.com> wrote:
> The previous implementation would set ctrl_fp if val == 1 and unset it if val == 0.
> This patch seems to be doing the reverse (setting ctrl_fp if val == 0, and
> unsetting it if val != 0). Was the previous implementation potentially buggy?

My apologies, I seem to have made a mistake here.

> Hmm, this is modifying behavior. AD9832_SLEEP and AD9832_CLR were only being
> modified if something other than 0 was written to output enable sysfs file.
> Is the patch code mode appropriate than how the driver was before?

I shall address the aforementioned issues along with the ones pointed out by
Jonathan in my next patch.

Thank you for taking the time to review my patches.

Regards,
Siddharth Menon

