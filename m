Return-Path: <linux-iio+bounces-16586-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8A7A583CE
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 12:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61A23A9F19
	for <lists+linux-iio@lfdr.de>; Sun,  9 Mar 2025 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFCDA1A2C0E;
	Sun,  9 Mar 2025 11:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VM4MSwqd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A8A2F28;
	Sun,  9 Mar 2025 11:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741520019; cv=none; b=ZsRfew83/dE+hVC2dPDUyedW/n9GFs8Zpm+Z/4++vZ9CSrmMwvv294b9BzxgqPeboBPm9JBxlpivJ7FzB2E1Teo6Z1obarzxRSJj26+YJc/w0gIgd2aEdG6xyTCYwdjLKpLVBKa7scEXD5GeHzW7NcVdP+t7d+3c3rN0gqGBhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741520019; c=relaxed/simple;
	bh=RHthkc2j69XzfYIrr4SUtCie38YjQQMGl8Wq9/DxPGk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kegWTL7WioK+pcAG/cIB21Lzk2gS/JrtVEc7NwVMqW0kVTWcBeYacusOiyJBJDjuCTIcmbczbWANq1UXAUTDnycFItXG6jnEeSfAnXq/zVpEnJKeFc0ooVbYvwxG8IuZMLMO1FboDwXvrlQkqCvkq0rm+j+t+ZIVkLGBjO6fz1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VM4MSwqd; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e6372042cc2so87544276.0;
        Sun, 09 Mar 2025 04:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741520017; x=1742124817; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hD6dSJWXPovNvfl2xfXR/ZabcRpLCeSb5xx2IJUN7R0=;
        b=VM4MSwqd2j9ADMyiwMFE6VpqMZGhZpzNvk1XkdIqOEXGc95OHpQ80Muz5oHp6hg1s3
         FMxoKdbCjG9g2Xx6Ra3vozOfOxBjerjZNu3CJ2YvCLstuMdXtQlwpo555x0qfdTgzT8t
         EGA8pQKtJrJjgVjzSTtOYuX9fcJEFPm1mttXIouODqRWJDEnFmhgwPT54PJxVL9V/LWU
         VFZl5yGKwo/thVhjVmzEvKFkCn9MRlZ2oomBx06GXsDFjrihRob5UcZvgmzrKG9VhtQ2
         QyisV6luakllH+yxWqkjQRyHGswWGURsPVZ+ie+wehTudE+Q7LSD4iUMIzOPreOQJHpP
         p8xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741520017; x=1742124817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hD6dSJWXPovNvfl2xfXR/ZabcRpLCeSb5xx2IJUN7R0=;
        b=It34Dx17AnEfZY2+n5POgdaxCFhJ3oLPztqz69K9U/tv+wW8MQRgNdhBuTVUlgRJ9c
         IKnNcSMnGueqWaPm3qbWHLlIscU5otTYFFNyBcCzDYOm9ObbbcCdTt+daLcK1moZ5Xtc
         12tZIdy2sdV6snhNyMMTW1ZvAJKsNCRZAsBVmF3dY/r16BJRggAXQkV2Ve4p+VP+SEoj
         qUhWV1UiD31252X3WPk3oF257kLR581o105VoVSlfZlTu/Ap3TBG8/7MW9hmLCtVrVAX
         06R1KeSz5+bnpVtKSmxiILCjH1amnjNXrSkv4+Uv5tOuuqxwFXSx5lc3p9XYFBKKaF1w
         IUFw==
X-Forwarded-Encrypted: i=1; AJvYcCV2D85G7aLYi9okK6h9IvBFkqMRX1V7whCyvEYT/PpBua5g57PGPfrh10X0vbVHN/EU+BJQkKfbaHI=@vger.kernel.org, AJvYcCWEEIAoP2SqfzmGBXLqzdfQJjnwM973VUsh/QOkibrXq0K9N/sqCknofyUJXg/PZhXVTfBMBXlPQKOEZWI8@vger.kernel.org
X-Gm-Message-State: AOJu0YysxZylniG8vXYHMlxAWre7B/LAV1Ho3pkOXlsvr8cKlRo6ZCBW
	pgFCxYWu9jEYMck8iyeXGNQ+6M3EFXYpqOztx2gX2nvzNHwkhXfhp8wU0kv9FpptZ3iH0uSaI9K
	++dVTrF7n23KVSeCGlukkWVU9uWE=
X-Gm-Gg: ASbGncskSUw8cfMmwS24CZ8KoJ6JiD9MaMGxbLEHHnh03iyZsBm82JiXIcqeA6MSbDh
	mFbUzQq5mOtnyx2XeKOEMo7BRJY68mrWvKk6qJpPrejMtByunp+LtPy+8bx7V9bDWYB6QgUnYLt
	fNv4UbMSM/RklVtuPv/nT1ICI57g==
X-Google-Smtp-Source: AGHT+IGA1Wy//fz7eW7eT/q2jrcjQp0V/XcQS+bPrc/ZNvHnuX6UFWu5yhDiUjJO9e+hykwD1m7ybkneoLXj62lZDVI=
X-Received: by 2002:a05:6902:330f:b0:e58:1112:c3d3 with SMTP id
 3f1490d57ef6-e6371da30c7mr2270597276.4.1741520016979; Sun, 09 Mar 2025
 04:33:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250220104234.40958-1-l.rubusch@gmail.com> <20250220104234.40958-5-l.rubusch@gmail.com>
 <20250302114503.26cbcd97@jic23-huawei>
In-Reply-To: <20250302114503.26cbcd97@jic23-huawei>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 9 Mar 2025 12:33:01 +0100
X-Gm-Features: AQ5f1Jp2-UOSg1n58egPOilYte5A-AmTplg8XtN0ymbsi9QW0UjWKlhoAlITO7A
Message-ID: <CAFXKEHYmWk9tMa5VT_9WKT-j_XvWetjTRu4Lknyv2c3u+UcHNA@mail.gmail.com>
Subject: Re: [PATCH v3 04/15] iio: accel: adxl345: use regmap cache for INT mapping
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, eraretuya@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 12:45=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Thu, 20 Feb 2025 10:42:23 +0000
> Lothar Rubusch <l.rubusch@gmail.com> wrote:
>
> > Use regmap cache to replace maintaining the member variable intio
> > for the interrupt mapping state. The interrupt mapping is initialized
> > when the driver is probed, and it is perfectly cacheable.
> >
> > The patch will still leave the function set_interrupts(). A follow up
> > patch takes care of it, when cleaning up the INT enable register
> > variable.
> >
> > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > ---
> >  drivers/iio/accel/adxl345.h      |  4 ++
> >  drivers/iio/accel/adxl345_core.c | 63 ++++++++++++++++++++------------
> >  drivers/iio/accel/adxl345_i2c.c  |  2 +
> >  drivers/iio/accel/adxl345_spi.c  |  2 +
> >  4 files changed, 48 insertions(+), 23 deletions(-)
> >
> > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> > index bc6d634bd85c..a2a81caa292a 100644
> > --- a/drivers/iio/accel/adxl345.h
> > +++ b/drivers/iio/accel/adxl345.h
> > @@ -8,6 +8,8 @@
> >  #ifndef _ADXL345_H_
> >  #define _ADXL345_H_
> >
> > +#include <linux/regmap.h>
>
> Why add this include?
>
> The file should have a forwards def of
> struct regmap;

Sure.

> which is currently missing.  If you clean that up in this patch that
> is fine (mention it in the patch description though as it isn't
> directly related) but I don't see a reason to include regmap.h here.
>
> Given rest if fine I'll tweak this whilst applying. Applied to the
> togreg branch of iio.git, pushed out for now as testing for 0-day
> to poke at it.
>
> Also move to a newer kernel tree. The changes in export symbol
> should be causing you build errors for this path. I'll fix that up.
> Quotes now needed around IIO_ADXL345 in the EXPORT_SYMBOL_NS_GPL()
> calls. I fixed that up.

Yes, this gives/gave errors. I'm sorry, I left this in the patch.

FYI, I'm always patching against recent kernel source of your
"testing" branch of the linux iio repo. Anyway, I'm testing/verifying
on a semi-automized setup here, involving the particular sensor
hardware connected to an RPI. Although the self-compiled pi-kernel is
+/- recent, it usually needs additional tweaks. My pi-kernel still
uses unquoted symbols here, which I already cover by an auxiliary
patch (not supposed to go upstream). I missed to update this patch
here for the added function. Thank you for the hint. Anyway probably a
good idea to update and rebuild my setup pi-kernel. TY

>
> Jonathan

