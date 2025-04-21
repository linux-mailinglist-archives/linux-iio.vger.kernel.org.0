Return-Path: <linux-iio+bounces-18454-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD6BA9521D
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 15:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41334173113
	for <lists+linux-iio@lfdr.de>; Mon, 21 Apr 2025 13:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75124266591;
	Mon, 21 Apr 2025 13:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYmnm7tC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B39261372;
	Mon, 21 Apr 2025 13:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745243814; cv=none; b=lqx4Qh8ew1L+Zmki//w6CiG1PzAc7uTxTBMaAAKjanrtWQUzebKdzCrrUS/K5BKoHSm9+uzaMKWhjp34cFRmRqEKQLu6rm5YFvW6njOjMjlp46C4JiLh5PZB7b4KAzUeH9vN+IxcRR32lKW+L3dpDqeR3L1lMy51xgMfuyLxKMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745243814; c=relaxed/simple;
	bh=7G952GCUAgQVq0vHrcyEXSe0jtpjyYe3cHfs5H9tRi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCHcMweoohxK/RQVI6vg0jeHFmBPzec8Yra+z2f5KqkKFLapqs1IFxqTjPXd5HQeLSxPTKfSrGugusb1pb/zOW0XoeLXaO6kdEcvmlk1OWHQKo597UGl+tSu8iSSZiFVhyugKv3zVxN9NVOF3Mc9E+RcM1WEY5cPi+f9vw9jnXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZYmnm7tC; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c5e39d1db2so198400985a.3;
        Mon, 21 Apr 2025 06:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745243811; x=1745848611; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U50DhOW5tvqG4LqE1ZhO21eZnqHSraou5vt7RRanSeU=;
        b=ZYmnm7tCWx/SinX5CEtwzSyxAZBhJpwuZ57D209lQB9+d2U+MPQ5abDEQ0fD5Ezyu3
         j7uG0UC3zAZGNfdv4GY+KEA5WzxnThDh98maNXYek2eCpjOv/eu498dKhI47fFudAKmf
         WjF83QkmjwBWvTWC6+eokIX7TVF+pctBq2ciwcz+QvnKa1ox6bDT9gsEOtlkrWSGf82p
         C9GCksvVB2Mu6zhKvcXDlcbt+Zb343fRd95xPr+2luyNZ0ShSqxmPUuG32cO+J02gHwm
         8jcDAmIIazKfelq9PVhxF1w2Bjc5Biov3OYGnnRuOPWrsC3Rswnj5i6V+afnMsRSPTUt
         VPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745243811; x=1745848611;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U50DhOW5tvqG4LqE1ZhO21eZnqHSraou5vt7RRanSeU=;
        b=iU1/3g495IyOTtnoEBtosrt70jGXQQvPmADRM6BHoZazHVsUwnrrUsAPQxBvqFekVd
         3s2LV4RCzMNHBNFoL69HCKQ9h0+SP5X71ksXYqqI19WoAuVFnM/t9XTrZZDnigMkbCOT
         ISLSUBIS4IONrCGeYEkANQNMqNWKw8NtQ4lhGWaPibTozjtYuhY4mNpLDHK+aPSN2YyH
         hmKhv7IPf9AxR8pW3o5jL2rIFIyXa3R/PuzCPtBCPQGMjg5JuuEm5Z0IIf9cRwNB3XZ/
         QCS0QfJq1hCZA0KdKWmOp+VhB0OVj5G6ztWihBPjOrvsbhtmGUQPEbn0q0SdRUBRd8Sp
         oEAg==
X-Forwarded-Encrypted: i=1; AJvYcCUywMiI8yOl2Vloq0ABXWNNnLZ5ndXAb/MdW1oq6Ypu61Kwpjycqejm02fqe8tSCTZUPCOA3qsO54k=@vger.kernel.org, AJvYcCV8SNfBZR8Zm0B6RdcpkCshssokovUsILs5gpcE3i/LNEURQgJr+KLT7fRIBVgJ+Cfr939z7C4hV9dTjoXr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzy+9/90ow2lfVtJprr5Jz1ku3hdtNzRVDC61EzhA3ABuV8Kzz
	LB+7Vmy7rzpj9iNtfRt7Hf0TNE/BiwhX1AaBZteX8fusyvTKP4tk1A7FygNPGo8eaBmhk4rzbbK
	w16ioe+8xu7dOjqlItINrVKtkR+M=
X-Gm-Gg: ASbGncsRdIMkPWssr2zz1kc2CQKwXQeS1bhJUCViIaHfctXuRktdseFgSggwzVuV5I2
	FlYoyQhk+h9mk0QuKMcWwGzCi1S7iAuy/5BRgLIeuF50Z3SywX3eGU8LAc03vMUyDBCbuPtjoHy
	ccafdVE3EgFHgHm4XqGFmU8oplA814+bq2d8lPEuSZHDrCXpaZ/o5H9w==
X-Google-Smtp-Source: AGHT+IFwPfdkoy6EEJ8mTuzbNgnOACCZf4/Uyv3+B3FbTRzHLK/2P/3awjMDcxErAWDSHIh3e4LjnEgs1WpxoLtiYfY=
X-Received: by 2002:a05:620a:2409:b0:7c5:b909:fde1 with SMTP id
 af79cd13be357-7c927f9dd6fmr1930284085a.25.1745243811525; Mon, 21 Apr 2025
 06:56:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250420175419.889544-1-gshahrouzi@gmail.com> <20250421123331.634076d5@jic23-huawei>
In-Reply-To: <20250421123331.634076d5@jic23-huawei>
From: Gabriel Shahrouzi <gshahrouzi@gmail.com>
Date: Mon, 21 Apr 2025 09:56:40 -0400
X-Gm-Features: ATxdqUEiUsxoWmmaJ2xyXvjpRnVfAONnlaUDxmAq11sV0agws9ETpfjcyGC5AFA
Message-ID: <CAKUZ0zJ9LkkeWsFQEvAdNw4qYOeX2p=J5PKEoc3Kh9LmCAa4Jg@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix and refactor output disable logic
To: Jonathan Cameron <jic23@kernel.org>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev, 
	Michael.Hennerich@analog.com, skhan@linuxfoundation.org, 
	linux-kernel-mentees@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 21, 2025 at 7:33=E2=80=AFAM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun, 20 Apr 2025 13:54:16 -0400
> Gabriel Shahrouzi <gshahrouzi@gmail.com> wrote:
>
> > Patch 1 includes the initial fix.
> >
> > Patch 2 refactors the code to use the out_altvoltage_powerdown ABI.
> >
> > Patch 3 adds small improvements by minimizing the size of types and
> > doing a redundancy check.
> >
> > Not sure whether to include a read function for powerdown as well since
> > all the other attributes only had write permissions. I can also do this
> > for the other attributes to help modernize the driver.
> >
> > Changes in v3:
> >       - Include version log in cover letter.
> Just post it in reply to that v2!
Got it.
>
> Note though that this needs a rebase as I mentioned in the thread wrt to
> the original fix. I'll take a quick look though to see if I can spot
> anything else for v4.
Got it.
>
> > Changes in v2:
> >       - Refactor and make small improvements ontop of the initial fix.
> >
> > Gabriel Shahrouzi (3):
> >   iio: frequency: Use SLEEP bit instead of RESET to disable output
> >   staging: iio: ad9832: Refactor powerdown control
> >   staging: iio: ad9832: Add minor improvements to ad9832_write_powerdow=
n
> >
> >  drivers/staging/iio/frequency/ad9832.c | 50 ++++++++++++++++++--------
> >  1 file changed, 36 insertions(+), 14 deletions(-)
> >
>

