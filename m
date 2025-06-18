Return-Path: <linux-iio+bounces-20778-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF89ADF5B6
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 20:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF483BDA7C
	for <lists+linux-iio@lfdr.de>; Wed, 18 Jun 2025 18:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856C570830;
	Wed, 18 Jun 2025 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CMut1qku"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f52.google.com (mail-vs1-f52.google.com [209.85.217.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8672F49E2;
	Wed, 18 Jun 2025 18:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750270823; cv=none; b=bPtFbx5tjlIRovE+AXcsJuelprqw0//sJMCaq/7HJ9nMgCYpGf6w28hV3M/sNkGZmba+nB9H6ewG6I5M8of0bxAnYtqIMYK5jtdfkNFJYDAvwa0EvK5tRIMrAhOaqelKfI16qjeFS1Gu/SbMMwMO+DZ6F535t3z8n1Sjjrob09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750270823; c=relaxed/simple;
	bh=dV4QW3Qy+OGsq+8aGVg5K0nRXDR4y2yCvxMhddwqyLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUm/bJWTV8ZIgFtNvIkq+S+WBBFzGnrZ7uc/oA4vigJTJpJpUsD3vrQikiYEj5g86k5cW/CFq4akn16PIf6nqsQgTW1381NmWNXhRfg9mMuAahQdQIsS+aivAQl6k2mvZbqtL0DtJFVNy0lKnlipu0AWGi0yjQ2/uhRZ9jTlIv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CMut1qku; arc=none smtp.client-ip=209.85.217.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f52.google.com with SMTP id ada2fe7eead31-4e7fc3309f2so1190872137.2;
        Wed, 18 Jun 2025 11:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750270818; x=1750875618; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dV4QW3Qy+OGsq+8aGVg5K0nRXDR4y2yCvxMhddwqyLk=;
        b=CMut1qkuJwtYVjArlT+9nkd7mz8lrhjzAwq960CDUZ7WUq3GlmRb0twCsiESwSQzQe
         XYU1HGzbd4ebLfDiQL/sEU02ILfFhUQd+CE9WDC1VFri9MpXFCjarusBn96kwYaDrrAb
         strzQ5FkfdNr/KB292wLyp89pSVzzLDa4rCyhkRx4FeBfIazWOtOsVj78KzsaUFkxOY/
         fG0RStfGjZ1tneFLMhFV9vQyxHglWiWlMy3BRtmsZMWqUBSKzvsW7h/urx9RBOKkogJv
         ZNzXTwMI1+lM0hp+mC5slThbsQeMwKR7Nb06xfH/7NJz0AQpW+J1BpBUcrWU4OFQYTGn
         aCbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750270818; x=1750875618;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dV4QW3Qy+OGsq+8aGVg5K0nRXDR4y2yCvxMhddwqyLk=;
        b=WTr7M/OWs8aLklco+JPtzsnEXwm+pg3jvNccVs2EADAW6bzR5OD+aoVzyqBMKhde5C
         J6VhEYs5fwA/IS8/P5Nar3MZG/xOwVsNgJRHaMe8B/r8FEtJTJIoG5WdLAnTeg2In3yR
         pfBhPDqj4kveX+Efp4r5IQi4tMRGgR8zPo3+j4r1E7UoUak0HUi5NXQbCyaT/BFA1L68
         +6vJg2GDrxecb75Sse/+vPOBNbppavyivI8hv4UwlflIK/3fEpnG9wRJOmXzhOXWdgJy
         e2FfPkPEYRO2eO0dRF3pYHiznUwzzvEAe7K72A4P3fVUI69xoof3B9qnC1E/W2sNrBOP
         D7OA==
X-Forwarded-Encrypted: i=1; AJvYcCWaOZyNZ77wUinlCeGIeZKKHuJ/Dd+CKCa12PEluc7yN4MAY67ht+GYy+Cx78WThAL8rAZmvkgvJVJ87scI@vger.kernel.org, AJvYcCXmW5OzfmJimFimqHyMUKO2PHYF7IgjEvzD3bNFwrWvcixhON8+RW8vb/vEc3i2YpuSCvbvQtg6eJY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrOJyBVgfXynADOSUUso+W1Ma/e40cAOT/SVp56J10sW1pvXtC
	yWm7QLC5gRdqCLBlCNGD+vS77sqiTutspB4Dr8uiR2DzuVUmkrg74nnMJ/C2KSnruKmvlO8lccC
	KnIb7wfRTtpwSUrL3NC8vxGgz0aH867E=
X-Gm-Gg: ASbGncs9aKK+FJnvIIFGjgvZ1n8LXs9oxuVlussmhfNou0ozzJ2IvXlO7p511Ci9Ify
	ky5M6dujuxuYtcdsJK+9knjpZ9WDKGllnok9hNdoI0uGWiDlLN8o3mUjj6YXz/5Lo85Kg2D9FCk
	w5yDh9aIqKdCrLc8gZghdjrUblZan7hnfwjNot8I3DhQ==
X-Google-Smtp-Source: AGHT+IEr2xqcFOjJxl8R13uHHf7Xf0O/FujSmB6g56UD0DbKN/2CM1jQ03oqnfrVHd2ArdwBZ4OeKRU5BfPgS8F2mIY=
X-Received: by 2002:a05:6102:6a91:b0:4e5:59ce:471b with SMTP id
 ada2fe7eead31-4e7f63eacdbmr15474820137.23.1750270818512; Wed, 18 Jun 2025
 11:20:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
 <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com> <aFL6PE-8KLLKZun_@smile.fi.intel.com>
In-Reply-To: <aFL6PE-8KLLKZun_@smile.fi.intel.com>
From: Andrew Ijano <andrew.ijano@gmail.com>
Date: Wed, 18 Jun 2025 15:20:06 -0300
X-Gm-Features: Ac12FXwpg4CNYOuxa2JcTEKqX7ZLV2AYXm393GaS56j-3RyW3-9KyDOaipftXX4
Message-ID: <CANZih_QeeA_G5mFOAb=TMNYiR4eo9SUD5iW1G-5LBGL27NpTRw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer infrastructure
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org, andrew.lopes@alumni.usp.br, 
	gustavobastos@usp.br, dlechner@baylibre.com, nuno.sa@analog.com, 
	andy@kernel.org, jstephan@baylibre.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 2:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> On Wed, Jun 18, 2025 at 09:24:19AM -0300, Andrew Ijano wrote:
> > On Wed, Jun 18, 2025 at 2:56=E2=80=AFAM Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Wed, Jun 18, 2025 at 6:17=E2=80=AFAM Andrew Ijano <andrew.ijano@gm=
ail.com> wrote:
> > > >
> > > > The sca3000 driver is old and could be simplified by using newer
> > > > infrastructure.
> > >
> > > I haven't found any reference to a base commit here. Have you
> > > forgotten to use --base when preparing the series?
> > > In any case, please clarify what this series is based on.
> >
> > Thank you for pointing this out! I think I forgot to use --base for
> > it. In this case, should I submit a new version of the whole patchset
> > with this information or is there a better way to do it?
>
> For now just reply here what is the base. I asked this question above.
>

Ok! No problem. So the base for this patchset is the commit
3c23416f69f2870bea83697d7ab03c6a8497daa7.

Thanks,
Andrew

