Return-Path: <linux-iio+bounces-2348-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4779484FA0C
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 17:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0959428BDAF
	for <lists+linux-iio@lfdr.de>; Fri,  9 Feb 2024 16:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27161272C2;
	Fri,  9 Feb 2024 16:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8rbGvFV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8127E77F;
	Fri,  9 Feb 2024 16:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497248; cv=none; b=HqJn4c5XJ6SBOfXpu05CSxYoGF8rkjtPRLeuSq0OPrHDpKn0dRhYlMcnz1TFkpbSdpVMGVVxESx9oP/4Pua1IhZz5GZskhbkvZj0At86E33YcyrNHZOJLMnKH3miFDZkHN6fYOHryqz+e4Y6X6leiYkOBpsEIjOiXcoJupZz0sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497248; c=relaxed/simple;
	bh=GvjNkWjFuU9gPa9u67Cmqf0rtzOV28y+JihwcxXnPm4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJcV9fNuv+Qfk6bGAabRxGWDZ0R6ka4+yaIm6eOAVTCsPyfa7Q82xDZKYImppZYiGJWAu7SJB03OAozOJDeuDT9tkjFGk3st00n56RO3r1Ry6cQ95JcO8ggq8jPci9UzEVorFe+dgIf7Lrgr7wXltGfJJkmCIXCsJg/DuqhAu7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X8rbGvFV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3864258438so207218966b.0;
        Fri, 09 Feb 2024 08:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707497244; x=1708102044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/WxMkU74BSyuBotyeONWFBUHqqgiBRmIjKpGNkVbwI=;
        b=X8rbGvFV0SvpmsqCkf8h1oCKdPAIeR4ekGo6/RQ8jj7yd3YYjPaprdvwpF1VRH2qYL
         aAPaWrM/3eeaQrjHkBylGvgZc8FawM4AJmT50nc6qxD0ORLzcroe7GqNnpdO1hSHlBd3
         ngVRxuIC/rtMd/L3itFBbI4YzzJL8pVExgdKIRc87U66p5jf5uDsdVWEFUgtJX7JEM81
         ekWphtd4bKEqdlJYlM1YDTzcycf76i9iNEFuPbuNvmziCRPiyNTybX7c2eLT7ZgL5LVy
         LxiogKEK3sWqFAgHbOseEZmkzV1Re4bXhDtiI4+ppaoUZmCKNk/bk/YjwoMmsIvJB5Et
         gHCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497244; x=1708102044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/WxMkU74BSyuBotyeONWFBUHqqgiBRmIjKpGNkVbwI=;
        b=jkWvUMhD3F1tROhU/srhoPK2GXmjp2swVEp47jD+KK8Tdw0L1vfAAKhHMrF7USsZGA
         856TBZhlzEJgYPwqH2UbhA1gG7MlxZvJ+U7kdhYXdFQdmZdIbCeePn4S7u6omdht4H5R
         Jgx+B+v3bGyAXH9gsSW2e5UiztgMs/qrwWzGcYgL4+x1cH6/45hKAUBEYn0d9TqoZApE
         B+zDTLhPY4BDeO2nQpu7yR9GfZi1hLcadGLPWJmD2qNXJhXP+DgDPU2eiVhA4zlSdg52
         xUO74/txJeo70zJI62/kYWymVdJM8NGZF2b+gv46Lukfuai5scCYMxYNCcwGtFE1kyOE
         /dXA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Uir+2z1O0bN1BzhApEsIEJ+RzzahVm1SrXXG2o11qouI9ia6bHNkEDoMHvji5wXlYT6mAudVFxGRQM9dPfEgmqPeKdI73l7RFg==
X-Gm-Message-State: AOJu0YyEOKDaGvG7noNOXbR0Fn/edTrXf5hU6rKwgKXKmss8IB6ILcMz
	C0qo74/c+CX8r7URObxH/AeMeFqIN30SY8gWdsbnsaqKoknoc+v7OPzKXAmQC2iTHt44Y1hcBK6
	RaK5p4CEYuMFvjmw6rLQtYIJXXobdy349JHA=
X-Google-Smtp-Source: AGHT+IFE5lpMmeVYiyBUB3zhAp5CSbwsEXeHObdhcq4VsH2NqiRarRszdJdAvQKiDvsJVH8ckyshjwOc6gi6tgDANSI=
X-Received: by 2002:a17:906:b893:b0:a38:4fb5:c440 with SMTP id
 hb19-20020a170906b89300b00a384fb5c440mr1311114ejb.37.1707497244165; Fri, 09
 Feb 2024 08:47:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
In-Reply-To: <20240209-iio-backend-v10-0-3ed842064318@analog.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2024 18:46:48 +0200
Message-ID: <CAHp75VcW7D5YLm+VVH+m7s=8t3ki5d58Ta-HLOP3VpCU=rjFfg@mail.gmail.com>
Subject: Re: [PATCH v10 0/7] iio: add new backend framework
To: Nuno Sa <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Frank Rowand <frowand.list@gmail.com>, Olivier Moysan <olivier.moysan@foss.st.com>, 
	Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024 at 5:25=E2=80=AFPM Nuno Sa <nuno.sa@analog.com> wrote:

> Changes in v10:
>  - Patch 5
>    * Removed meaningless @ in function names;
>    * Added ascii diagram for the typicaly HW setup (Andy request);
>    * Add missing period;
>    * Use of dev_err_probe() in APIs meant to be called during probe().
>  - Patch 6
>    * Removed unneeded blank line;
>    * Fixed some English in the commit message.

Thanks for the update!
I found it nice, only one (kinda important) finding is the 1000x reset
timeout decrease. It might justify v11. If so, consider other comments
as well.

--=20
With Best Regards,
Andy Shevchenko

