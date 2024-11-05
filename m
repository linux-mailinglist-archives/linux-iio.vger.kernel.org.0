Return-Path: <linux-iio+bounces-11911-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1BA39BC6B7
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 08:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 529861F237B5
	for <lists+linux-iio@lfdr.de>; Tue,  5 Nov 2024 07:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E779D18C34C;
	Tue,  5 Nov 2024 07:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="j9I4oblK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175D9188587
	for <linux-iio@vger.kernel.org>; Tue,  5 Nov 2024 07:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730790935; cv=none; b=kdh+PjbBaEo2lXecJbToqZQWcg1sl/xqkCoBQFnbwJTyN4uuInxSrJHk1lp14+JUCRG86x6xM71l1N3kT9lhepVJSGnpNa9USslOUNSo5UxEzPXXluERl454cr2QP06Dz0K5EOVZuoTMgAqaG/h2bSt5DRw4G3fY5Y9pzj72rEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730790935; c=relaxed/simple;
	bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SoUi3z7P1YaLs3GSFSbPvu9vo4I/Yc28pCfsF0flDYKTkXbZfrOtCa2+lJurdXo0NyTb3qU69AA6PGDMkMiOmFQ5v4o7Bn3yOzoy51LNHNg3BTaESjKL1qs4ISQpC1uwaswkudA1tFqRsxM7fTqAG7peISoBnPY/rCyMTpcPtMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=j9I4oblK; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-84fcfe29e09so1557729241.2
        for <linux-iio@vger.kernel.org>; Mon, 04 Nov 2024 23:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730790932; x=1731395732; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
        b=j9I4oblKim4hPplgvIVzMc4NZXPaV4bN3ZDsi/8XIs/rMl3ampSqJGA4UyojjEREb6
         C2MBRMmz8yIZSQ3Ni21VZqGL/v6dhJMAjOQIHWITU2ti2ppNoR20SHNh2rQ+oiDK1xGr
         B7BURRyKt1VpVtsO96h8GTJ37q/f2efYYPtmw1sH4G9t6nNJ85cPY+czinJ5zRHsLxH6
         w3aN3V/sDlb4nr8JWhDF5TbLNQTi+xznWS29eX83OpH8VIFyQMUAW8IAuKDP+fFwQ5Hf
         mz0T/RqENR/0UU+BGW3HPT7/cYpWIxEsnG8NFE6mQHpXgCjqq1+4Vf/vb7vi3d+6RY3c
         HTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730790932; x=1731395732;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKrupjBtkttfD9TudNheeJJdwN3xqZFDec7ws4TNMSE=;
        b=EZ0mzt05g3DoNLyoO82hQI9uBbV9mRhbDiHLtDFLau9P2bZOakpIbaMdBuS7/qrnRE
         91J8O3v8Y5xrMXceUtdmqiZv9buzxX5KCsjsYGqCcxGWD8gph4P9uVme4jY4txhI0eJc
         zASQJu9CyO6y0PhK7TvAeL7Vfrn4WpZY6quj33MemtblRGeMxm8Sb0mnHjPOtUo6HjTR
         mDipuj+iV2OT6oG08HmVERE3+YQ3Ub2+5zXciqneOlNzmu/WVEmkBPjTQvCLyd3HTWM5
         oGxgc81d+Z5kiFpemeM80TpoveaCtN7LuNeEU7kbnyGztKuX6xPiYmPf071kTtPOS2Ow
         U7zA==
X-Gm-Message-State: AOJu0Ywpbtur4KGq/ZVELPPtqTbPIf71SA0ex2+L5Rq4macqRHCXNcJJ
	5gAO7+hYDFUOy8WOWH8nSPDv5tCw2vtW2GiQuJ+H5NaNuSKtz1ImnDreA2C/zOYD7ybdTY7LWpr
	rkfpC/S0WD6PBDuIeorRN8ikFEpGdBHlFdH3YbQ==
X-Google-Smtp-Source: AGHT+IFpURG4bQTnz3LG03WKBpggY5HMxzVDL0detX8WC3WRMfaoHGYLGqK7rmSsRweWcYr4Rc8qK4LRpNvTGQLpsQ8=
X-Received: by 2002:a05:6102:3707:b0:4a4:79cf:be83 with SMTP id
 ada2fe7eead31-4a9542b4691mr18047664137.10.1730790931844; Mon, 04 Nov 2024
 23:15:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031063707.795842-1-aardelean@baylibre.com>
 <20241031185906.064d733825c176addd48a733@linux-foundation.org>
 <CA+GgBR_tCVVo75+eOxtxEtFdCMkAWFiHjm8eAfPYt+sLBGjBFw@mail.gmail.com> <20241101130459.eb29f2ded5da3c4c850cc577@linux-foundation.org>
In-Reply-To: <20241101130459.eb29f2ded5da3c4c850cc577@linux-foundation.org>
From: Alexandru Ardelean <aardelean@baylibre.com>
Date: Tue, 5 Nov 2024 09:15:20 +0200
Message-ID: <CA+GgBR8yiRAVrQx0ef2e3zpiLuky7QTx=5XvXm2kxSn7mJijkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] util_macros.h: fix/rework find_closest() macros
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org, 
	bartosz.golaszewski@linaro.org, gregkh@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 1, 2024 at 10:05=E2=80=AFPM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Fri, 1 Nov 2024 11:07:04 +0200 Alexandru Ardelean <aardelean@baylibre.=
com> wrote:
>
> > I can also do a V2.
>
> That would be best, thanks.

Still working on the V2.
I ended up down a rabbit hole of signed-vs-unsigned arrays and X
(value to search for).
Will try to resolve this as elegantly as possible also with a kunit test.

