Return-Path: <linux-iio+bounces-18590-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BF0A9A065
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 07:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCE261946760
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 05:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4D781A2872;
	Thu, 24 Apr 2025 05:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="goR9jLCL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249D435963;
	Thu, 24 Apr 2025 05:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745471964; cv=none; b=aCCWvtMhghW4sFJ9OHFqRbeg3aOgxzG/7hM+H2CT/72KC0pAbTmw9ChlYCPv0BvSUXEx80g7a3fyn0M4hagjQSD0cO1i5QOKsMsar+hXECp/ersGlmxfNZOTgaEbHN+NtKtSP2qREO8Qa6ZfAjDAj6SYxwryIirAhLGKwGqSWUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745471964; c=relaxed/simple;
	bh=cxOAffGmSNXCmuuYRqwydrK/LyPOZoinO1fKOprSYqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyOVmHltnS8mzF77NSVA6MRBSn13s8wVkQO2FTw0D7JbSQ3npGt5LxzBkHiCKFXoYEflmJc1c2VqgwU54bKCP6zlvF3R+Lh1ailClBWWAcNq1qpUoeLNu9LuTyet8twMFJ+w4NWVVeaXkIVW5n/yPYySTnWyrU6pI2ASMtYvs5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=goR9jLCL; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b0b2d0b2843so431452a12.2;
        Wed, 23 Apr 2025 22:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471962; x=1746076762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxOAffGmSNXCmuuYRqwydrK/LyPOZoinO1fKOprSYqo=;
        b=goR9jLCL9LjTmqhnJ2mWH9cDFI9LJX9uDM9uiguI9S52MnAr7IG/Xp/MBfmQ+NZtxc
         WDCGLYYonO55IrB4Bma7Mn6xDp3/RNGvOfXQdqjtQ5arOmEvZIAzFL20fJc4BjMMZJNM
         0i8b+31n+fm9Jixs5JVaOwk0x+KkqnjAdt69TMFzA0xeUlRqQM5dpAprvG9vGH1/OSMq
         8lR36HEWVt1wIa7QwIExIge5HAY8TaWusn7me2AwlpP19kLDN7/E/Q7MbaGYlevtQCJm
         VcHS1srtWEST9aCcL07bbDvVrstn1oBtxx34OSNxx2VgCNvrF6/SfQV2sSo08bXazsqC
         XFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471962; x=1746076762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxOAffGmSNXCmuuYRqwydrK/LyPOZoinO1fKOprSYqo=;
        b=d4hs05qCL448bOv8Og/eD7Aj0VpSjMhJ+Cwp0HYAqRN5vqJ0Rn6F4sG4FISGES6bPD
         pdFz5vGww20zAvX9XurGjTN8l5a9Dkw+NRyWwIhzAvIfAPelqegkI2L1jDwqUw6ZQqiO
         wLndGDvbowuq7VnLSrIBdmeVeIXA7J9vzizbPAcQjDbyJ2qQ+9mgz8/Ohj14czXDBZ5j
         +EEMXReTx8hipBXW3Ipdcg8e77QOr9sb3a92NCb5o0yZlDR+8iQZuAVb6Q2A7NljnJiR
         frOkRJU6GNni5yTogBuRsoYo7ApG7A3vb/OfgGM2AifHLRXiMHWmledolTiFIVXDPFmN
         zW1g==
X-Forwarded-Encrypted: i=1; AJvYcCU5uRKLh3YhQmxnXwmKDNMvBLINfi7ZtbXYrIFwUKFkP7EkINFOwenbw+DflaoK3tRkZL74xXs9XiIC@vger.kernel.org, AJvYcCXiRJZeld6reAbrXwSacpctCOYUwwsEXmZeznlZ6QaAkDQ5Zn96nU+pHwoxdzIfEqNxF42sFQoWiUR5@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0lOGJXSMvqc716+0f79I8gW8TmarB571Nkf2m6RUHoVHs7zhf
	LxQNlQM/Fw1wKWRnjmPD/iSjDHSXpvT1N3cggOI2shxqqTUvJuN5gVGRINJJ7CyL7FWtgJ+aQkn
	sqEN6wDpo6GeSituo8N0n/vf5emEP1aZNIgY=
X-Gm-Gg: ASbGnctWjhNuxyLTGBr0u2g9oSJdmk2WMVs9dPAXPacPBsqKVslV0s454qNsXT0NUUI
	XIO84QwilusoXdMB0Bcn+UNeVk562yqEYuI4vdldH5Mu0cTwozJkas3Q0z9U0h1MlbXPtnkRhtI
	MYPWo/nQLJ3kJOHneV/66iLSs=
X-Google-Smtp-Source: AGHT+IFd3+DWbwqYLjBty7mlBg19qgtdH7s2lZfCr4eSF0v/i7R7uQX8ILDr8QxbI/+tN2syISiew3zunyK/T14w53o=
X-Received: by 2002:a17:90b:544c:b0:305:2d27:7ba5 with SMTP id
 98e67ed59e1d1-309ed26d23emr1873972a91.6.1745471962392; Wed, 23 Apr 2025
 22:19:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250423194100.53934-1-gye976@gmail.com> <20250423194100.53934-4-gye976@gmail.com>
 <CAHp75VdHnBQyGFPLwpiZZdGcuwhyMM0Yfnv=2+nwr1Ma+1T9JQ@mail.gmail.com>
In-Reply-To: <CAHp75VdHnBQyGFPLwpiZZdGcuwhyMM0Yfnv=2+nwr1Ma+1T9JQ@mail.gmail.com>
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 24 Apr 2025 14:19:10 +0900
X-Gm-Features: ATxdqUFdx1OZVDfnOTpSqDMFw3x3r87O8m31VPZwanjM9VomnCMIZtFlyN4o7d8
Message-ID: <CAKbEznvaiF3+TdTwRsh0C9WLtZAu4UObNa5aMAOjYt5KW6hLEQ@mail.gmail.com>
Subject: Re: [PATCH v6 3/4] iio: chemical: Add support for Winsen MHZ19B CO2 sensor
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Thu, Apr 24, 2025 at 6:39=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Apr 23, 2025 at 10:41=E2=80=AFPM Gyeyoung Baek <gye976@gmail.com>=
 wrote:
> >
> > Add support for Winsen MHZ19B CO2 sensor.
>
> LGTM,
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

Thank you for your reviews so far.

--
Regards,
Gyeyoung

