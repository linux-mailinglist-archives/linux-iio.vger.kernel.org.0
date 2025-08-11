Return-Path: <linux-iio+bounces-22595-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EA9B2153C
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 21:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 117BA17EDEC
	for <lists+linux-iio@lfdr.de>; Mon, 11 Aug 2025 19:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4348C2BCF68;
	Mon, 11 Aug 2025 19:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFGDbkS/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E8311C2A;
	Mon, 11 Aug 2025 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754939879; cv=none; b=NQFTNTHjVFK+cYPh4bRMgo3ePPqzldHeOjp5L8RdKYkiEtDZra1kgRg1MiNib+cdwHfaqJz3jepEauoskBdjOTutizA0M1l38HHFe5T6EMlAjpQwb8TEWMqgG7ekvM544voCgNPw4XBS4A5OzuSiZcZRp1AS+1B6ITCmDQf/oPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754939879; c=relaxed/simple;
	bh=NqCbTnm1d8r8NAcwLbCEavG/3vW5JpCp0c6eGWldrgM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ixd//zsFGaMYcIY1ADE46pPsmz8nkluHR1z1KCmcyo3IYwEmWa0wB/BVPFo7cCXYS9iHbxMaGVPom3FSNQ/ntUfv83MV0bnuUsdVRCgAo9OkUpyu8R3vX/dZdOD5uxdlWNk4o0FmCF4hdVYNbGzw647O2/tA+N7OG2ffoeqdf1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFGDbkS/; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-af66d49daffso791999166b.1;
        Mon, 11 Aug 2025 12:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754939876; x=1755544676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqCbTnm1d8r8NAcwLbCEavG/3vW5JpCp0c6eGWldrgM=;
        b=CFGDbkS/xWmFlAEsV824cNPp0kgYasrjdqxbPdty93gWXuy5rtmkPNaFHoCkLlHE/a
         E3w6M1uT9ZgV/QG/X056b5O9FdPsKcojM3A3cs1FRKqfM8kKAyxQnJNPvS0J0JPaaEpL
         81ebjXpg3wEyRWbX3yn9vIrFaoYz8KoToIDpT9y2xAR5SfgSESSpXSPfHpmQVyUL6EHI
         If5x1UvV9sgLhU7i0oXzHZ3kwZrg5GTDQjqXu8K0Ce1Ob6bJRalvzH++CBgr38I6ondI
         rTRzNnk2EC4RJO4lpENNFC5xhLnsyTYAvmOJcTTOQDkGthlIQHn2xSibQAIbrUnOluXJ
         /UTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754939876; x=1755544676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NqCbTnm1d8r8NAcwLbCEavG/3vW5JpCp0c6eGWldrgM=;
        b=E2MCV+4cjRGDVvvtiA90UUjSR+oRKpmIIWICtUHFFUGpbwylGVkXEo/ZACCxcki5eW
         GJMHxK81KjOwX6HotmsPVRGBeBTWFUhIV2eyLtplmkEG/NvIBCfTrZW7B/k0JHmC4f8G
         Vhm+7Xx5MQyKteIyLp2ZVjxYZnipI0spj7ZiFso5RRqRUg93mSIwhUm0L9uCEa1pBvis
         ZimJ6uXeJ8Kh3LjktZmHWFu5sLOrc2ktoKRoHVQMJsAUJfD73cMyqE2X7n+cpO64OEhB
         nuGoMqFS+Xud6MJDwMvvJDkHKg4ALu56Nap3MzD1IUYs9spBI3lL2QkkP6cikh4bmYNy
         aX5A==
X-Forwarded-Encrypted: i=1; AJvYcCU80buTPeA7yjEncAWso9vgvjrgzYOAiub2sZZlzAPG3QBoKtVOuFqkC7LDz7nR7WOC2KNXPgR2hDU=@vger.kernel.org, AJvYcCV5rnQLZCMSiUdsUFaTQo7TSGbXFbBqWXxQ3tqMHq3sJ6CzrUaYGOLzIZKnKCMbuODuO9xTAAtr45URWWeD@vger.kernel.org
X-Gm-Message-State: AOJu0YxZqfY3AFs8LPl8BizwXKJ02rMtP6MCVBolJlG2mMgRnASj0oH4
	TlXCwwtLcxn8GUH7JrLy/rLiuoli4PtcmfnvdTtT2PjDpjIwiGIp1UY49PyWN5fBiN3f2Pjt8Dj
	UjRejTwDXE+0Hd63kQ+1csD0wpzKV1xU=
X-Gm-Gg: ASbGncs8Nbfcr+qZhLianFV6hEqD9Eq78w9Bea+v6PKoJt1GklriXAnDaTer3h2KW9Y
	TYGiM2Ku8jBklATLAB2vO8O1StZO907F3qOKq1eUxhjTGPvuo664wNGOP7Xe3k9AjtlHTwYvZU/
	WavZH1nzE4jp3IEsTzp2mgwVyPO34nNIb17kbPx1HFSZXLnMITiQCLG2tUNOSgRFT2T1MCC6+LN
	l6sq62qlQ==
X-Google-Smtp-Source: AGHT+IFvg8MC5VPTI0mMDr3ZjgO1hZC1hJecNIRmoxJEiJKBNdvG9BGTH1cso4p7E/UN4aUaP5ETWA5ERS8g7nlGVtk=
X-Received: by 2002:a17:906:730b:b0:af9:5366:b42c with SMTP id
 a640c23a62f3a-af9c655d50fmr1072472466b.59.1754939875626; Mon, 11 Aug 2025
 12:17:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811165641.1214347-1-akbansd@gmail.com>
In-Reply-To: <20250811165641.1214347-1-akbansd@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 11 Aug 2025 21:17:18 +0200
X-Gm-Features: Ac12FXzC64AiqIcJl4Ec1rvXpqcZkAusyqNclxgfoE58mv5kghsnOOO9xit8ieE
Message-ID: <CAHp75Vf7r53wQtGWes9WH1UubEjhAju+tN0OORTrkNxgTQPsWw@mail.gmail.com>
Subject: Re: [PATCH v4] iio: st_lsm6dsx: Replace scnprintf with sysfs_emit
To: Akshay Bansod <akbansd@gmail.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, linux-kernel-mentees@lists.linuxfoundation.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:57=E2=80=AFPM Akshay Bansod <akbansd@gmail.com> w=
rote:
>
> Update the sysfs interface for sampling frequency and scale attributes.
> Replace `scnprintf()` with `sysfs_emit_at()` which is PAGE_SIZE-aware
> and recommended for use in sysfs.

LGTM,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

