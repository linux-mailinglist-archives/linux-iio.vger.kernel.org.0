Return-Path: <linux-iio+bounces-20670-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F68AD9FDC
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 23:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BAA1173717
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 21:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0331E1DF0;
	Sat, 14 Jun 2025 21:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGfxaQ8m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A891B393C;
	Sat, 14 Jun 2025 21:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749936107; cv=none; b=FqSpobdh241N2lSqvwsQD/6uQGg1nsreSCkBWGobbjkMRukPGXDClKiDm/bU3xR9909wO2Jh/fZMjBip+9p/3+TOVdurwakXjGzXcc8dPe7rZEGCoDWcvaiQe2Ab5QivtJ8CaUwLmjv0CoogIu91D+9FjycDCrs9GOlAZyDtijU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749936107; c=relaxed/simple;
	bh=95m61qIV6ZpSVPIOwauck0utYq1p5pnDlxVw9fZPoUM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GcjL6r3yc/F0/33dP4HXeNezeZYftcvFLtMRJ0yjfskU6NAq6FMIWEjspx8+GvnnTmGzWyfk5zh7gkVbFQzHr4dGdaF2+ct04V/j3XbQzDANrTAnbzlor1wHT3VBE82HW6511JmfK3MeV4gkUXEe3OpRg1UU2IOYRw0wZqHwZAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGfxaQ8m; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e80edfa06fso58810137.2;
        Sat, 14 Jun 2025 14:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749936105; x=1750540905; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MK467agQBl7b1tY2wypHrza4wnliO7LxjWcV6PEgN6o=;
        b=SGfxaQ8m5MG+ziWAFDsF7YTuoP6KLlGwRh/AorcxDrJ5oTdGNx93rpqX9WShCtLkky
         kdNWVKA86tbeNM8yaV6NAsvawI/WV+v5RxpJ1wuTSbVkLxpS6BrIgLrxBQGYB5m5P2kB
         AOE30eXw4zuyudc5H0FNx9lG8EwJ2tFZaf9R7k4H4OgwAb/GgKlHSnpWbjJawPjIBYMn
         XGSh0fndbyswgIfaJzNDucJMMbUyhyXQqSQJwU/4tKmIyieW7sfYwlUIiE5v7b5Q9SAB
         XzNwHETauic4UUjVHgLXJY+hIv8uKC3mvU/657qVCvtGviwVZECITglMONx00Jx4mhoU
         yuqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749936105; x=1750540905;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MK467agQBl7b1tY2wypHrza4wnliO7LxjWcV6PEgN6o=;
        b=fs51u+hC6sv1DtjiCPIpb82LWfZxqVo1qlI34w83aipI2Ja1u3rRG9baxOYLKDYOlP
         VJSIvBm7PnOw00QaE6+LR+zZlXM0G/em+vsWYQ5QGUiBeiu2+6+aRjOydyyqK3NxSvFO
         xE/x7qKKeCK6tJCTlqiZMqiBQcQ2gUTbRYFpznj22jcBuTc5jplv4XPIeKG3eJl1mukn
         PJX0ezvfZkovmLFEWuRz7W3tBWvVgvheA3V0Nc5TQ4+S5qDF7tkVlZtsA5/cjQoJ5ONF
         +2tPCtif5Brg1EunUixvmWrR0NZ8LJAkdrGoWwJbwBPLFUfgogK49fP+ZuP4xFQo1R/8
         uJmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJE7YjMDq+8UO26OU2RudTFGMSaYCmReSzU1R2bctO4ZiXOh2pOjeJenCRlSRwOr9mUh8JHWEMOus=@vger.kernel.org, AJvYcCVTpwmuRL+3T5HEKRP42fYd/zcmQt/YkVtKE9rX9AB0MLQkoRsY9kP2sQqUkEzoUx2hnHIeGaerH0zx674I@vger.kernel.org
X-Gm-Message-State: AOJu0YxkaYP4tgtKwTbkNf9gpFDn22wRaXXUPqGbOQIGEuJ3RGmmtMLE
	RzMcO6F824looP41RQIN5/pNGbNbXiXYZoMCBS7x+mBVMWrdpc9IXNaFbTgbOSA3tZnh9G+uwtj
	eI3BZtfAcOrN4Mqegjbmfoouc3N4ZnZg=
X-Gm-Gg: ASbGncvjuyFvlblqLshIq1/HLMEUd7rQyVVFtdkVnJEEjMAWVOD+KUorWSCkCgV7AkZ
	M6VXaiTz8dxpda5fdhqaNCpslo4MwPAw2SGwCiYSBnrCUuG/vAGu5CgyWrUooqJm2YsO4lI0tSm
	pleOOfs07nElGxNlz83x04bAu3a+ID7NpAUv3OWs2ygg/UMsKdeNZd8N+fSQ==
X-Google-Smtp-Source: AGHT+IH0tdFLXLY6jlKXLxCkkQ5OlCmVQ9/IMNkj5MVlcXZf4aDR7L/tSB4T3vCPQaU9jj/rvROsVYOur+PnsJBnBII=
X-Received: by 2002:a05:6102:d8f:b0:4e7:bf04:413f with SMTP id
 ada2fe7eead31-4e7f648cd19mr3019968137.18.1749936105288; Sat, 14 Jun 2025
 14:21:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611194648.18133-4-andrew.lopes@alumni.usp.br>
 <202506122309.FvJPaMhh-lkp@intel.com> <1c1c2888-be50-4578-8afd-bfbe4bd9cbae@baylibre.com>
In-Reply-To: <1c1c2888-be50-4578-8afd-bfbe4bd9cbae@baylibre.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Sat, 14 Jun 2025 18:21:34 -0300
X-Gm-Features: AX0GCFskZ6scvwqCQ_LUPZh8XidRkwo3cx6PRXx9bYPaQ-64eMfzIP8pKcRdwss
Message-ID: <CANZih_TWMx2d=8FGRLdHdvQDRQxoYar0v+YpeiogdQOWTnLHpQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] iio: accel: sca3000: use guard(mutex)() for
 handling mutex lock
To: David Lechner <dlechner@baylibre.com>
Cc: kernel test robot <lkp@intel.com>, jic23@kernel.org, oe-kbuild-all@lists.linux.dev, 
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br, nuno.sa@analog.com, 
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 12, 2025 at 1:06=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:
>
> On 6/12/25 10:52 AM, kernel test robot wrote:
> > Hi Andrew,
...
>
> These error messages aren't particularity helpful, but what I think
> this is try to say is that you have to be careful with guard() in
> switch statements.
>
> The guard() macro is declaring a new local variable, which shouldn't
> be done in a case: statement without enclosing it in a separate scope.
> Some compilers complain and some don't so even if it worked for you
> locally, we need to make it work for all supported compilers.
>
> So the code needs to looks something like this:
>
>         case IIO_CHAN_INFO_SAMP_FREQ: {
>                 guard(mutex)(&st->lock);
>                 ret =3D sca3000_read_raw_samp_freq(st, val);
>                 return ret ? ret : IIO_VAL_INT;
>         }
Hi, David! Thanks a lot for the explanation. I'll make this change right aw=
ay.

Thanks,
Andrew

