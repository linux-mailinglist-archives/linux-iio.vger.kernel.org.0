Return-Path: <linux-iio+bounces-20759-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC3EADEC23
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 14:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED7D64A2F3F
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 12:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AABE9298274;
	Wed, 18 Jun 2025 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aCzebccJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B36136A;
	Wed, 18 Jun 2025 12:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750249474; cv=none; b=A6TLIfYtd4i8ijXQO0//Jk1xRHm3Wy6j3s+hzMa7ykD80xmEmzLxPLE8CCeeR9Tn27USoEdP0cF9NYe/pkMaGixLMH0H0sALW7/3yJaxfuYeKj2lWeLpqEVoTn+cPZF02XmTm571JbidxRYTqPgdKL6Gk4K+2sasR1DT57Hja3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750249474; c=relaxed/simple;
	bh=/NYsxYefGuFZoFcbmNjG74D/3sWLBSAsPK2AYHstAwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJN17FdLcFC2xwKfpdpQ+2uW5sGrbeJjEHQPSbkJPSRxFkuxri22kp7npE/AR2vIMSCwn4kj5cylSKRz4c9C5OLxkGjH7I4lDBGD5BMuTjDZjkXMC8lEylCm03VqBga2VbYE+dmqIb65y8KAJkivbB91fVNNkpte4F2WokDdXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aCzebccJ; arc=none smtp.client-ip=209.85.217.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-4e7f4adaedaso1406901137.3;
        Wed, 18 Jun 2025 05:24:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750249471; x=1750854271; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NYsxYefGuFZoFcbmNjG74D/3sWLBSAsPK2AYHstAwg=;
        b=aCzebccJo6k6U+FpDLeWVUVPLi8neOzP0laB2xNSG40/9PXOdDjxullR2mrxTmqCNw
         xzb3xGb6VAXWuQB9ujTGyDFRHoy8UPc9U9P7lqlgIyEcZrmosSqQeYvhk7K5ZoLca9GG
         6Oc4QLSEU1VKLzQiGPT1naWaMVN7uYv+VFCNMguUCgJ3Lio6ys+IQSwl/Qqio8HF7kk3
         r4sY680mxeYKT71tLQ0qniT+E5MRGjtqKbfgYE490kJucxHyLyIiALvvGyWpxea4D1qg
         U7OvQwA+nq+ZETexelM1MzvgOBO+wE1wyaGUUhQoKjDBU7cjaqRiEke8hQg7+KpCFEYt
         2Bmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750249471; x=1750854271;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NYsxYefGuFZoFcbmNjG74D/3sWLBSAsPK2AYHstAwg=;
        b=l8lJyTr01xrY95duf+cq1qXEL81uJNE/KdpgQNLtb/ZPaQrCXQFNdQdZtFlkUi+vW7
         j4mEZ3CUGOtXCvCN0cRZPLSz7VWUvXjEvgIXkchbz/ZmrrZUJKp1SYjBBKA4O8283f2d
         X55p4jqMbrgXeNTcRdtStYDUB8XnufFbCDRYo+p/yNxF9M2oCSUkcCdvoFuX6Li4hb+j
         tPpqC88TLPyeRY9sFT2GwOOPkmJA6Pa2WcrS4/xrI1BC/ZmUCXJuszfKnVCKnv/owg8P
         bUMHrYYmH/HSu2lHzNZoS8PV43lP9YJTqozAdnErCaa4fEFwriZ5TIv9KcLwqYQVikXs
         JoZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgNzk95jhxPYDEU5K1U9RktQFSOLpjFK/CgPFGyoR2oqHjNzPj6dpBeV3/cnunC46Vc/Q3wDZr+GXyuv8H@vger.kernel.org, AJvYcCWdvZCBjGILh73Xemf7//qAAeSty2mbrKESjxYvZotYG8hxrmMzDtTZp7NQfz1K3aLGY/74cL+Ibqk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeP1QfXtfwQczYkYEm9jp8Yr/oqJJS2VsB5wx33nnjx5MmcWt4
	fnen+dVVcAoT5clbvCVI50mJmU85MtdHVpabLPUq2PYi4wpqxkL1iJAXsJXRCTjzN543okqi4tX
	/AdSuhd5YNNxnfCRYDOCfYyegFACs3tA=
X-Gm-Gg: ASbGncsRZ67tmHrfLfgyu4k0O+zPj0kXA5NOSgvzSvT15rKojYF66Og2Drc5VLTPm2F
	updlaiRZPHwqCVcwKxnVH0KRRDreO/U6+SdHZAZraDy1xG8khyr7gUXRsoh1sZlkd/Nl8MZvr0t
	YAxYrnti5MSoQ9+Tsv8SZNZ8x700MsHaXE9eTUjd18vis=
X-Google-Smtp-Source: AGHT+IFKxo5jOdQO8g9bmHrmLYV3o3dtgYq9weUpw6k+6iarraD/Y0etRIlEYIlAgmm4WMsUniD8eUPR7KBarX0bwMk=
X-Received: by 2002:a05:6102:580e:b0:4e5:9323:d2b9 with SMTP id
 ada2fe7eead31-4e7f60edf76mr14115895137.2.1750249470695; Wed, 18 Jun 2025
 05:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br> <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
In-Reply-To: <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Wed, 18 Jun 2025 09:24:19 -0300
X-Gm-Features: Ac12FXwGVXWrLr13WRwfmpLhpRnPU-8Xv8LlkIM0z-WiaWBJ6g-XsgAvMY0wBbw
Message-ID: <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer infrastructure
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: jic23@kernel.org, andrew.lopes@alumni.usp.br, gustavobastos@usp.br, 
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:56=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jun 18, 2025 at 6:17=E2=80=AFAM Andrew Ijano <andrew.ijano@gmail.=
com> wrote:
> >
> > The sca3000 driver is old and could be simplified by using newer
> > infrastructure.
>
> I haven't found any reference to a base commit here. Have you
> forgotten to use --base when preparing the series?
> In any case, please clarify what this series is based on.

Thank you for pointing this out! I think I forgot to use --base for
it. In this case, should I submit a new version of the whole patchset
with this information or is there a better way to do it?

Thanks,
Andrew

