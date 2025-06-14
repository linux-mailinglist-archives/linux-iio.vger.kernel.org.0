Return-Path: <linux-iio+bounces-20665-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AED13AD9F53
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5808A176805
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 19:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E2D423C4F8;
	Sat, 14 Jun 2025 19:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XfzVjVBp"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37427713;
	Sat, 14 Jun 2025 19:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749928378; cv=none; b=olakcwHPJgOocY+UMQK5YSzTyMEObUfIzRGwLCy3VFi6TK1o4h0t4bFwUDDHsUJ8UueM70Pmw7VFtmmlybbvTblLg3LI44AQdT2PPI6UgLqQSseePBroLoH09blqP0UooM2ICdQQLvDT3CYHQL4757836sBytIXzGiIas8OK5Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749928378; c=relaxed/simple;
	bh=ie1xKg/UtpXBXk9HFVQ5BkITewKeLpU4WpBX5jWp7Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpJoaWFiSE8uj2MMKtUw6+b+144ujR9rL52SgPwxgb17brNBEbHibi/TIU1PmvNHk/iNodgvoYFP+75cNkDOmdrxw5ZiaCQqNARt1Dd4Mknr+zuPGSLRBBkaS7Gbu7pWLHAajl0YbNpOZkS/GR6KW9kTaEx18yUbLyvquZbxbEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XfzVjVBp; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so182364137.2;
        Sat, 14 Jun 2025 12:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749928375; x=1750533175; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ie1xKg/UtpXBXk9HFVQ5BkITewKeLpU4WpBX5jWp7Sc=;
        b=XfzVjVBpgxFI8GdCCM/P6YW39r1cxAQI5MUTen0Y2d0lYTxsDJyHv9qhrEiUfc6j/A
         CO/eoYbijgDW+XCMnS+cssUearNvTJyFY+xsp9bLax8XWXnW+v3f2XHKf9vOh33QDAeE
         aAU/J/xjJRhB+zbT9BYRLeHndryJA3GjAI9UI78v7W8VWpUBltlvcMcim0PbqIvp6e8q
         rZJ4KkzP+j43HN1755JkQZ6Dy4I3mggbXkhutcXsJKYwVkNyjk58SA44XKSyqn0ZLJ+J
         Ng+hP/Tnr1mPKYXIQ015jOT870PpRH9X/C39GSG3+/BxeRdolx5vEMuQifVtgRWi7BSR
         oNFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749928375; x=1750533175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ie1xKg/UtpXBXk9HFVQ5BkITewKeLpU4WpBX5jWp7Sc=;
        b=tXALPTkMteHi2a6vmdIfDYzA9cvqKf8aWVdpjLKxi1OX+cHwyIKy302kZTetCdg16H
         WBEjoNbrLpTX5I9pGqIbPsA0gmBhxDFhJff5ENyAe4Gv92CCcTVEdXPU6Twl7J6WqMmD
         PAiXJsdZzBUvCxoGq9AeFLVVGMtw8uLtB2r1L2JI/fTlWqeXsgMos8m9NukQOqSPHGus
         bVtzFvcqILnzuFU9Yg2OtQjNgQT1RVcq2FAT0CVvsDm+9VW8UmEI5nCiy7V8ODpOyqf1
         66FMtu5a9uowEEJMj7MA6tgBrTasn/E9K+TOA9Ta6pCxXUk2L9cPJhFrTWkK3qe5fcSq
         UeEA==
X-Forwarded-Encrypted: i=1; AJvYcCV8M1Ww+Gun6DfIA1hQ8xGIyl1a61aJer0lDG45CpRCWqxeoYRD1bgca4GUWQl5CRaYdB3mv0TGHR0=@vger.kernel.org, AJvYcCW8+fHTIEIU/L6ova4C6Fnch/9S8DHJJExiYJ9JPWgFhppOrgQuHgQpMO1JKtuFyzNY8DvqgMf5DoyTSwDo@vger.kernel.org
X-Gm-Message-State: AOJu0YwLGK5hl5W5QUiYIX3o1Uxr4NDlHD8Y0RpO/3LKLum877HeRePr
	dlbcAQ8giWa6VB4miNzGw05+OjKBiySbtxjaxgZvJMZWMkbGGtjXBvSP9rjbLiTKnAqYdSUaSw0
	WklFKqUJzvMA6IudTIUJvqNxkvWg1rDM=
X-Gm-Gg: ASbGncub6UUr2rXLxO3TZ32TxhaDtGKR5rkqj2ulmqSkVNsvY42tRMWz+pe+u0QnulR
	3wuO1lkRe5fT6FGdiEkZDCn3aSh2rlrW1DNneIRc5XqcFlwPAgpmCfihuMedIGMck3HwJgvRlpE
	ieWkwYd886DUOxsV5bg6ru47CUNbJMMgp80kGzsW+bvE10DiiBT0YiP6+GHw==
X-Google-Smtp-Source: AGHT+IEPRbX+mT4mLF/i558EU1A8TO9/DESjBfNeOOB1QljPfD3umD752IkNHxopKpwloIC2+FWMwR1E7nJNVMMAvLU=
X-Received: by 2002:a05:6102:32c5:b0:4de:81a:7d42 with SMTP id
 ada2fe7eead31-4e7f629e258mr2889479137.1.1749928375315; Sat, 14 Jun 2025
 12:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-1-andrew.lopes@alumni.usp.br>
 <20250611194648.18133-2-andrew.lopes@alumni.usp.br> <028710c4e4494285bee82ae811147b03cfa612f2.camel@gmail.com>
 <304d3bcef438a78564650edd52f7570f0bd30c95.camel@gmail.com>
In-Reply-To: <304d3bcef438a78564650edd52f7570f0bd30c95.camel@gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 16:12:44 -0300
X-Gm-Features: AX0GCFvu2eskhM69f-64kJTapHSW24adtvK184XSYArLhYx_s1wEFS8eqlN6PvE
Message-ID: <CANZih_TOQXvHSLg5GQ2NPE+Zp0P3Fm1MBff_2wKEfOOEOQMjVw@mail.gmail.com>
Subject: Re: [PATCH v5 1/3] iio: accel: sca3000: replace error_ret labels by
 simple returns
To: =?UTF-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 4:41=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.com=
> wrote:
>
...
> >
> > Code looks good. But since you're doing this you could cleanup some of =
the switch()
> > cases. Some return in every case statement while other don't (even thin=
k I saw one
> > one place where 'return' in the end was not needed). IIRC, there's pref=
erence for
> > returning in place.
> >
>
> I see the above could be a bit cumbersome in cases there's locking (which=
 get's
> cleaned up in patch 3). So, nevermind the above. If there's any leftover,=
 you can
> send a follow up patch or introduce a new patch if you need to re-spin.
>
Great! That's the idea, I addressed these cases in patch #3, but I'll
double check if there is any leftover!

Thanks,
Andrew

