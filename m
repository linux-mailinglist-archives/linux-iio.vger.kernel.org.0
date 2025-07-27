Return-Path: <linux-iio+bounces-22065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDED5B131A9
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 22:12:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 031F617070D
	for <lists+linux-iio@lfdr.de>; Sun, 27 Jul 2025 20:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D69D22A4E9;
	Sun, 27 Jul 2025 20:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MEWljicr"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574D221ADB9;
	Sun, 27 Jul 2025 20:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647155; cv=none; b=HlCQlmnhJh2VRmfROYLQKnNDBXV7Kw3JlVWjwpopJmBgL6oW/+dEeKM/kdtEGZ7LcAfyVd7E5WKpYaiTxkjAha3TjtgFqy3ids3karZlSxTBG1f4Xfutfc5am2DHsHbItX5SMt/Wyo5xdWVhtsjbPtyEniQyQiPs9VZ1Ad3UEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647155; c=relaxed/simple;
	bh=7ApjSuJC23QK7saQpnw2Vp3ugk9P/RaMuhTegDmrbgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ggmppFJGWvu07OfASWJwrnO33WCo2OUoXxCyQ4ksj1t+Jy/rBy5HPxhDe0wg4OIZljsH4ShaOOYLCrIL8yL+EmWr/+6jb7sGvnKCIhkUlJxX+CQq+Fk6sCvs5UNQa4yFedoxxX92lWn7BcETkXlK7HNWWc/IsQc7zPsceHqX/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MEWljicr; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32ca160b4bcso38842431fa.3;
        Sun, 27 Jul 2025 13:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753647151; x=1754251951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ApjSuJC23QK7saQpnw2Vp3ugk9P/RaMuhTegDmrbgk=;
        b=MEWljicrXv/Yaw9J7+rS9onhVB8DI38PxwIuWRsPccRIl/WWrJRY7uDD02CBhfyntY
         SdAdcLoZH6UMJmwyQDFssyIxYRgdUlVDARgUO5n+bdEYSMPxAhPmYmjtD492wYNJ6j5b
         4ozLbrU4tgXJNB0GUbJfxUPxKXmDUV7+v2N48tR1czc9uKJHRTYDum5JeA1yUg61sDYN
         qGB4/d4mejUy8xYDcfzTepsJd3AYNkBO/a8UJxMf6Z4ozOtWKbMuWp32/Di0n/G8xJJt
         8Jdrfk2kBhFbENrug38mgOnkYmqsZF1tSI8LexvJPyhizmFOgiaUDCcMko8b/1BFOJAA
         ukiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753647151; x=1754251951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ApjSuJC23QK7saQpnw2Vp3ugk9P/RaMuhTegDmrbgk=;
        b=Y3ap4kBhg1UWCblxoF0jslKEjPnJTmpeGK82P5EvLjtYHz2cC5TugpTPzogk2d9dVa
         ciajAJzRPCp1LsqqwnEAbdrYkJrIA9dCZ+ZRLBAx2B0RA1X+RK7GSr65qr9zWmiR5jjI
         M8cymBWuXq8Dt8VpLuFnyc23CYx94/VsoJBpuuJM4Sjok5YFdEK2/SFwTxQ1pNGFXb5+
         7m0BTP+YJh39CaDHMu4vWcobe/0eR89rj2XgWA4paO8V8u8SmdpQywxp9iJxayUs08FN
         NrrPaYNnTH9U+fIRDyWdM4CgbfV8oBHUtlJfQiYb3Bwutc2YIHnoNbi2M2zDil5JrDo9
         zdtQ==
X-Forwarded-Encrypted: i=1; AJvYcCW/UpFiAWLNva1xVsyxSRKa6tKctyliT14O8KQqK4oX4Ih/+op0vR9CqUJhz2gkNX+UWS5RG0E2q/c=@vger.kernel.org, AJvYcCX99DvSgfV+9Zy7142SmZKGf62dmQCexVay4Q4IXgj2qCC+axDZaxqsTV+Y30qYY/bsQqH2pJ4AzEUwoMwh@vger.kernel.org
X-Gm-Message-State: AOJu0YwCYrRaXS08vmOddM3uy/2xlWldaVuKctzgpuSXVE92x8tuL/SJ
	ZUOGQSXmvRkklV6Xpcz7Oi8VBmw7ffRPbslZ+bIe7B5kjZBT0WBd+H7jqeRGkWDmcFBbqK0SZZS
	vB7U4jv+8vc6dyYNix8xJ9nm8Iw8CZIQ=
X-Gm-Gg: ASbGnct1FrxenF6pfGB9+OS15w36F0d25m7eVCsBNXMQB2Yn+vFwyo+/A3Ms2027hot
	nCMgT6Y8qaZTWEQ4tUvrO2zzFsNitoeHHh/B+dq2nfa5VG3wiHxKPjKr+B0o0ous10gYDAfIyvS
	5zPflCSPYEEXRdisNJ0ntO+CdWiAox0Xp6Kp3tX+6Ub/Jc90IhHd7J+U5zj6FRcBXRe6VgwGfyB
	53gs0cG3YqIJeG3hvvFEcm9lvV2TDWQqbThqvc=
X-Google-Smtp-Source: AGHT+IEfuXbQHXoLspiyWRikPAa56LtmBFOxvyJkD5HYzn9Y+YGzw8ycjAg53fZvtCJk/L2/ZAYvTwmZUNq/SYnRYKE=
X-Received: by 2002:a05:651c:1542:b0:32a:714c:12d1 with SMTP id
 38308e7fff4ca-331ee6cfd8bmr23335031fa.1.1753647151055; Sun, 27 Jul 2025
 13:12:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250721195419.526920-1-akshayaj.lkd@gmail.com>
 <20250721195419.526920-2-akshayaj.lkd@gmail.com> <CAE3SzaTFgLsLCw-bqSTygaanCpHKHGRj7ssGim84WjB-DxZPVA@mail.gmail.com>
In-Reply-To: <CAE3SzaTFgLsLCw-bqSTygaanCpHKHGRj7ssGim84WjB-DxZPVA@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 28 Jul 2025 01:42:19 +0530
X-Gm-Features: Ac12FXyvh4514lEL6VLzOdZfA15vrzvmSzkBgRADbeYHV2Wxcw6hr2LA1CZqwsQ
Message-ID: <CAE3SzaRMOFNxciCDQM5dUMTTONgAD8o7u-4hX=TDnLXs1wQ-hA@mail.gmail.com>
Subject: Re: [PATCH 2/2] iio: light: ltr390: Add conditional data freshness
 check with sysfs control
To: anshulusr@gmail.com, jic23@kernel.org, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org
Cc: shuah@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 25, 2025 at 12:24=E2=80=AFAM Akshay Jindal <akshayaj.lkd@gmail.=
com> wrote:
>
> I agree that this will break the user behaviour.
> Before dumping this off, I wanted to explore an idea.
> What if this remains disabled by default, i.e. data->data_fresh_check_en =
=3D 0;
> So this way the regular sensor read_data calls will not break, and
> based on demand,
> the application can configure the driver to check for data freshness,
> by toggling the sysfs attribute to 1.
> i.e. echo 1 | sudo tee /sys/bus/iio/devices/iio\:device0/data_fresh_check=
_enable
>
Hi,
Is there any feedback on this?

Thanks,
Akshay.

