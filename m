Return-Path: <linux-iio+bounces-24342-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 54582B8F279
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 08:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AB97189E05D
	for <lists+linux-iio@lfdr.de>; Mon, 22 Sep 2025 06:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D3C2E401;
	Mon, 22 Sep 2025 06:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lc5SqjpP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6224A254AFF
	for <linux-iio@vger.kernel.org>; Mon, 22 Sep 2025 06:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758522778; cv=none; b=QTkg+dzrDJjNAmKhgho4DyxHIjViCRnA6UDSKSOCAKovLgBkTTRR0KT60uKBLzOf//wTFIpoQudrWQAhFqyPw0cNs5YjT4WQMqgvUoVLj0IFsGWKwRY6NfISBVWRLRcjVb/UTyyM+hg+nhMB9axkWPdax1wXDSQnQ+mCakfEEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758522778; c=relaxed/simple;
	bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k0+hB0eJsmVxKYLq6KUDwWRhNKAcb2mk+XdedcnZDqD6lnr97rfsne/+5xsNfDxW4EbnRKhP/263bp+lAYq5JWy28fC6uATmXm43Yt0vG+1VPT8+uv2jsxASAJlJXbpC0iZQSCWDBMUfSXnK+5/yafeGi5a3QQmS9TY6PLnd+Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lc5SqjpP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b07c2908f3eso594062566b.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Sep 2025 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758522775; x=1759127575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
        b=lc5SqjpPrLs8tcBKKoL3pvOyuvcbvFapwBfqPRE2F1sIL+vDghgYjAV0mk6YlN65gs
         JF8MRJKiMnJgD4z/n8qWja/UTDQemsCtJB80X/D+6dV10NqfFHDX1mVRq4hYm/BsKtMY
         t/MlcibUutM7BxroowdrWBlr/evMim/Q/MdqNJDduaqC3t8AQ/J0k8FL1d3LvaAOG07l
         KVZjvf888RxUehAEHheOeogOU6B3lA1OmuDoYroPy3uoQf753Ev1B6ssuk7mTG+1nxb9
         JHA7rHP4yvkvqNIgxl17tAZhu3VXBM4z3UlDDTMY//xnrYwKVO/DQQVmJ9Burmx9CF6k
         LJDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758522775; x=1759127575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wYD/M6PxWq/wgZene6AcBP+PiIeNlODJlqiaad3A24w=;
        b=KNhLaoyejPgVSdYlYhLMfuTFuFFOjh+NN0TzFPaoNThjW8kNhneiUWgI9OifNM9BVb
         sX/9XIuW+h45OsLerLsY5uSgFgrDgR+MUS+3YBB1zNTM7NOu+/fLtOAu2EUvmVE+47Vv
         BsmX/CO0cLiGiO16JEU37oKNwkra6aatfdp5caENyLdVF38uvfq5xTmgg3/n+L0F/eyv
         pz+o7kAl5j8zexB6VVt0vmXn+ySmKPESrFoTUeg3BFQuKuaCj+xT+vw6SEm8t4VEYTsL
         XFi/dG0qt8XvTpJoSjIXPHDSpNFXDQVfH3UXNZpI7eb2D4XbilDCjLraEB2+4liTNV2H
         oZvA==
X-Forwarded-Encrypted: i=1; AJvYcCUtSjvScrMEFLiZDT9b1bPjk6VPl4GAa5D0A17JaJfg4ob8RXbh6xoyHR+qa62HJrkJGNw9kcKDeBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ2n40+lyjWZsmGddKXnqT6exmpUC2stn+Nh/Ogoy1Bcnj2Yjw
	OWi/LlVm+3bLLLr38bfy7KCjaUwEwZN1hlWOeg6OygRktqng3PseyjjErAOyAdJVPUF+SHD3fD8
	xPEzR3nd8iJ1o5MMFYh6aYlmECSN22DU=
X-Gm-Gg: ASbGncsAI82CpsSjKHHjgO6QC5fiJdLk3nwUUv3vG3hjn9WLV44wzLU2p7LtC4pnQm+
	ZYuQgdDJooBn57MyvUMYTskPf1JS+IQYI/ir98BmyPyarM115P0GYDxGXxgXpT6SUjedF/rDV43
	ICmCU1TcLWr1LALRJ3TmQXrn7FeVP8n98A2hkeUggOHY4Py1G+GuWR9/X6NTFNL3McoimD4xIfP
	JZaEJfWRg==
X-Google-Smtp-Source: AGHT+IFt32g296/v7oUwiN3/2WmyoTf3rvdIov16mqu8J6Z28WBVs12Cjb1LzbSnQ8aw+EuwgBCTUHBHTozQRlQCuwU=
X-Received: by 2002:a17:907:934c:b0:b04:5b0a:5850 with SMTP id
 a640c23a62f3a-b24f3e59436mr1217337066b.40.1758522775353; Sun, 21 Sep 2025
 23:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250918190729.387117-1-akshayaj.lkd@gmail.com>
 <fe32537d44cbb187e1518740f33e3a6716dd363a.camel@gmail.com>
 <CAE3SzaReUnhWyzA8RtdizKeRU2zMsGbvQaVT-ug6v+=Pqq8WzA@mail.gmail.com> <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com>
In-Reply-To: <CAE3SzaRsGw0coOWVmnN94E2TQJTOsoxBquYp-PSQrbSdpGGSCg@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 22 Sep 2025 09:32:18 +0300
X-Gm-Features: AS18NWAPruRnjqpSbd4xlkyRDkq2iJo0pBBP6U8n9ilb2ExxqxI1feVAik6XECE
Message-ID: <CAHp75Vdo2SpO_HnCDYnEkZ1LHpn4s0FTO5TjSKRNG24s-ByNDg@mail.gmail.com>
Subject: Re: [PATCH] iio: accel: bma400: Refactor generic interrupt configuration
To: Akshay Jindal <akshayaj.lkd@gmail.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, dan@dlrobertson.com, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, nuno.sa@analog.com, 
	andy@kernel.org, shuah@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 5:59=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.c=
om> wrote:
>
> Hello Reviewers,
> Is there any feedback?

No top-postings!
No HTML!

Please.

--=20
With Best Regards,
Andy Shevchenko

