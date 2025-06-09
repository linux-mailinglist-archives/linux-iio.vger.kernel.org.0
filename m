Return-Path: <linux-iio+bounces-20327-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD1DAD1A89
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 11:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BE513AC717
	for <lists+linux-iio@lfdr.de>; Mon,  9 Jun 2025 09:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD621250BF2;
	Mon,  9 Jun 2025 09:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NKBwIJ8a"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF6C1F1505
	for <linux-iio@vger.kernel.org>; Mon,  9 Jun 2025 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749461293; cv=none; b=ecSLvbFMzJ2i3+7QqCCf+AagXSeOkhYnbZWsLkkM0xs7S7BG5d3PQsk1z61qeVntr3aZZaIGt5a5CUpc9ZpDlKVmfIcSx6dPK7yr2J4TY9VOqAgAeIcQQEWZD7HkGzIFfpTHbguHKrAgPb8Lmz+EsZB8ut9J4f4/jb0tRDiREWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749461293; c=relaxed/simple;
	bh=aN9cxjzaJNjSOkXNuxRvBXxwAh7+pmficFpFHTe3La0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vGbIU6/rnftMP5bnPBd5ndYUBqeg0yKAY9GlBST8FLcbj7FPDaHAQthblJIIJziCkWyOncktXDfQsRl6+HRyCw6c/O1SR5CGKJTgdNJKlBNj5Nct3UsydCIgG5e48zYGVz8EViBY/iZtCGc15Eq6Xzp+4bOjmPc4JyBhuGMwB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKBwIJ8a; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so2768853a12.2
        for <linux-iio@vger.kernel.org>; Mon, 09 Jun 2025 02:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749461290; x=1750066090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaSFfD/BySG5m4v1ChKZFOqk4IdDRy7e+9oF59gKpk8=;
        b=NKBwIJ8aj75/ewRYMAujqNih9cG3R/W5vd6Oj3ZmU/r98pdCvcVsqKLp9DRSdQreCz
         kYf0ZFI2+1wBR5REnnxmaTLWC3703jRw2Y+6/N+8vE7jLolP5ZSoIc9E92WBqj6F7jT7
         qslkgfJTIPmCx9QIBO+AAUY5ZFp/uE4+HR3DEts/SyTsxGW2PmG5ch1KC2Qs6KQdjrQs
         qOjKpzEs1Z7mUK+MFTDB2eznw+BhO0nU5FBgs2jR3lh7nwWXp8uTO0kg2sa7xvzN+qIR
         j4amNBwjUND5aTVLwwQ1yKR/GnElR11i09zr3GfX3OoTg+LQELzip3aVnEG4gjJ7jAw6
         72kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749461290; x=1750066090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RaSFfD/BySG5m4v1ChKZFOqk4IdDRy7e+9oF59gKpk8=;
        b=YtdJLogS0ufXhCc/2puAMRcGmPpjQe4uP006df32gmqnjJrUn/sJzsVFy7c6ItrXon
         0jZ+cPlS94hwkY1GnKAuG2VTWstxCzns43x6s/df7h6DS3yj8lkHGTxfBakL4FBEeJy1
         ZLqJFBzmgVzrpujX4O1TUx8KkwThdlwLlDBiFj75Nj7x2HTz4/aAI/y5mxZZskugJ0Yv
         qp8iryDSwABOM0UKv79VOP9GatXCbVEOxvQnIWB99H+Jbc6z8te3UJ7CrT/nW5LBkuLf
         zAJ1LjHZFCaHWyIr3xIu7zVTCVd/mi11KulUZT06w0RlZLOrZZMyrIvwruiRmO4hq2/i
         wQOA==
X-Gm-Message-State: AOJu0Yz/cWJlTsaptwlGtYfnqSw17wO6/0dqbKm8xzBIxVpZmYn1melJ
	LkgUUsw+JspdlTK0CRUEziWZVl6W9tI0OT0wupzCrI4KRTjPDg8MHF6oMPuRjeyIXTwd8zOtQNf
	3HxCBI+Ynwr9e2jWyL9v4DJFHCpbJNYo=
X-Gm-Gg: ASbGncuVmJhufldhBOTEoXlM7U4/KsrKeVC30jPC9R9jsoI+0GbU/IrQ2SJrCMNqgU7
	LrN/PKYTCOSB8IQIMoTuzP5uP+FpIrM15I1V+pD9BiEjJvCeG9DfaeFM2xnS0SdOrtHctcBvyek
	XlGUKuN5ij8eHWZGvreaxDTgH/cuehSV93sdsmTod4Ri0=
X-Google-Smtp-Source: AGHT+IGtJuroUZo7l3X7RpdsptmlZWbg7rsUKpBQ75tS/BH8XTxfRnuz4UpLEvgb9Wzc84ewWW5TVXVdy1J/dn1dmng=
X-Received: by 2002:a17:907:7e96:b0:adb:469d:2244 with SMTP id
 a640c23a62f3a-ade1aa48668mr1120503866b.51.1749461290013; Mon, 09 Jun 2025
 02:28:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250609070616.3923709-1-jic23@kernel.org> <20250609070616.3923709-3-jic23@kernel.org>
In-Reply-To: <20250609070616.3923709-3-jic23@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 9 Jun 2025 12:27:33 +0300
X-Gm-Features: AX0GCFuYMgCl-0T3aB-ooJSRAN2WLbnijAEkmVWR7V3Hc91_zbUYzexfQpIxcfs
Message-ID: <CAHp75Vdovs=REuauj_zU3V_aw+zUjWY-pKV5sEuayJb9By1JkQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: dummy: Drop unused export.h include.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 10:06=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Resolves:
>   warning: EXPORT_SYMBOL() is not used, but #include <linux/export.h> is =
present

While this true...

>  #include <linux/kernel.h>

...I prefer a full and not half-baked solution, i.e. revisiting all
headers and esp. replacing kernel.h with what is used.

> -#include <linux/export.h>
>  #include <linux/slab.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>

While doing that, the headers may be sorted (in the same or preparatory pat=
ch).

--=20
With Best Regards,
Andy Shevchenko

