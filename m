Return-Path: <linux-iio+bounces-22538-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8AEDB1FC13
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 22:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D545F1897B5D
	for <lists+linux-iio@lfdr.de>; Sun, 10 Aug 2025 20:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590E7218AC1;
	Sun, 10 Aug 2025 20:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C3hQ54Kn"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78072F9EC;
	Sun, 10 Aug 2025 20:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754858930; cv=none; b=BdY6953hJZ8j4GYj2eKtIEBbrqi8Zi5wyCVtFrMMVrkIYg6e5rf4MyJDE9+gpMyY9uoqVwBP115uI7OeQUSXfzRNTFhUZXIa1e7MZAyNl86abvBdnndnWZriqHXFmZp2bJIM7NeQ+FjwrMwdjpY/6VGnzvYLl7tC8G0lEsxbBwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754858930; c=relaxed/simple;
	bh=rdNHebi+UL1GxCQGqlOikEggD1zovHnZEftEsnYBGmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1vCsw92+jBVa4nWMee7ao26RhpC8Gv0Qy0UptsVUwpHMUT4w4x3RW5/qIfB7s479MRWnuk1jwzRZlu76khknDp5bGcU6Mu8qyGULzQW9pkIvy1AwWvJ831MJTIEdiSQPF1Rs/S++0ZftRkjktH1OcjQRwwekuhMYXk/8VGTxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C3hQ54Kn; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32f1aaf0d60so33210071fa.1;
        Sun, 10 Aug 2025 13:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754858926; x=1755463726; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdNHebi+UL1GxCQGqlOikEggD1zovHnZEftEsnYBGmQ=;
        b=C3hQ54KnyzKvllKHNLdOgCreklAYsy/HX0bUza6p2hO5SZm0hwyFeFXfXDYvslDFDe
         OIJpPWOQazYum9PT/2u3Bh2JHJHO6GNoxmGfpJ9fAF+t/6p/PwFDqkyGfiPxOh1gpTN2
         CKh6YTrEuZy7LteKW1uswWP3GSHqzeN/PE9Erse3cwGsEfN4NZZUYt6StpRSWZrdMftZ
         PHu6mnI/xYDSnOmYj92CpJzaY04eUTGkWtJv+klO7qbOfPWkU1oy7BWvmYpDjqa5wb+i
         TxYnp3ouAjDpKsKN3pV/4OjTCaK7rHGqCxHFXzelH6f//EeLs57SVv5fgvgr1bRGW5yX
         IVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754858926; x=1755463726;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdNHebi+UL1GxCQGqlOikEggD1zovHnZEftEsnYBGmQ=;
        b=HBo7fBGiBf9VHwbQdZaHvvT4bQTJb1ZINMosWqONJ03x8+jRvZwDH7RT/eh7yF00Jx
         WlSmd2xsq8Y2iH9f/guslg8bGKLc52UzZTfsW6n6RKlg7BwP4jwCVEefWYEUiuztrkqh
         rpeULrQ2cqsYrwj5fv0ct8RojOjNyi/yOsBPKaw2ZVkqCsg8HDsd9A8nLk07RZTVoWtm
         MexLZWg17RnvuX5LE9uz02Cwz6dKZuozxGbxEZMLyl8svAYGJSAPAFnAMzuu4Z1zZcjw
         s0QLLPCFcCe0L/0rfLyO6EWYAe5cJSnKLyk+Vk1z+tHBsL0DsxsT9lKV/6CQgGjwbo/s
         GOcw==
X-Forwarded-Encrypted: i=1; AJvYcCVszeE9H/+8VlCp9j+FU7uHeSEJKec0pmH+7i5OLV4+NuqfPnk/bnub4KrgloU9Mj2rcVvZ2trEZQ4=@vger.kernel.org, AJvYcCWTM54tphcg/DwWRNXusED31o8PnF7iIlF/cY6S+4MErQQWbStA9V/8CZhOUX1tHAmTXOKkSDF+iKvqZKsg@vger.kernel.org
X-Gm-Message-State: AOJu0YydlLGQ1zjVdZBUmD6sWih2JRGel7N72rPP+BKlSrCdu+7SP+QG
	jIfEzaQRMT2GKR8Q7mFaHVOBYepMbi6bxcSRW8Xu+EJOISKeuAqtfSYyXIeeGPUlky3jr1A6q2z
	BhN06ITIRVic8oDdzyHFdVVd4pTcKc04=
X-Gm-Gg: ASbGncsWOTHOAUUoi+1nUNihndP4kSJSNZppHcMHgtReCibJSr2oVhvRmoUJ+26WJ/b
	KjhJshtXcBvJAuINnC1DRN3JAEuWYOwkuoepoQFerrmYAx7s44kIBtXgeFCI7oGn5sM+lWLBFE/
	TO2IDPL4+ZY0SIdDx/gX9vuhTCfs2CGV0V2mFdQZ/rIQm/gfGvW6lDTzgw9GmB1YdqrWjn5F75c
	Dwgn7a4
X-Google-Smtp-Source: AGHT+IHYxF/wbVZspbsHga3k6H99j5TR/tuJmZFDOCuHtEDWlfE1Ja5kos7ctC2evw2QgxaFQ+f4s/ZZJWfoA4VRk6Q=
X-Received: by 2002:a05:651c:502:b0:330:8de6:de71 with SMTP id
 38308e7fff4ca-333a1f4e90bmr26476051fa.0.1754858926249; Sun, 10 Aug 2025
 13:48:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804192513.62799-1-akshayaj.lkd@gmail.com>
 <CAHp75VfJzVAJYC9-2oyfV4qBLmraXRgqZFcho6b7orW+1sYkXw@mail.gmail.com>
 <CAE3SzaTBzF=W9++d4CmW-vRkKLy9zd2oB4ADX8NuH-woTvJxqg@mail.gmail.com>
 <CAHp75VePmhLstCraz_+7Cqc_bLQ49+1rV4oH59a1oo2xHp0R+Q@mail.gmail.com>
 <20250806161801.000061c0@huawei.com> <aJO05BNi2TsYtdwe@smile.fi.intel.com>
 <20250807140401.00006c85@huawei.com> <aJcapPt8f5YMUBH3@smile.fi.intel.com>
 <20250809205736.34b75763@jic23-huawei> <CAHp75VffV4Xomb-1zp6_xB=r+PJzsDnj_gjwyWas8cX7dhuhng@mail.gmail.com>
In-Reply-To: <CAHp75VffV4Xomb-1zp6_xB=r+PJzsDnj_gjwyWas8cX7dhuhng@mail.gmail.com>
From: Akshay Jindal <akshayaj.lkd@gmail.com>
Date: Mon, 11 Aug 2025 02:18:34 +0530
X-Gm-Features: Ac12FXyOW0Kqwgm4cP7q5kbJRA2g_4fydpZvChLBBPDwqZ96bllVvqIriG8kG38
Message-ID: <CAE3SzaRZGvOwi0UeBU9Nw2=_jwF9AYLyY0BFG9tHzwbMFv1o7g@mail.gmail.com>
Subject: Re: [PATCH] iio: light: ltr390: Add remove callback with needed
 support in device registration
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, anshulusr@gmail.com, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, shuah@kernel.org, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 10, 2025 at 2:04=E2=80=AFAM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Sat, Aug 9, 2025 at 9:57=E2=80=AFPM Jonathan Cameron <jic23@kernel.org=
> wrote:
> > On Sat, 9 Aug 2025 12:53:40 +0300
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > On Thu, Aug 07, 2025 at 02:04:01PM +0100, Jonathan Cameron wrote:
> > > > On Wed, 6 Aug 2025 23:02:44 +0300
> > > > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > > > > On Wed, Aug 06, 2025 at 04:18:01PM +0100, Jonathan Cameron wrote:
> > > > > > On Tue, 5 Aug 2025 14:47:32 +0200
> > > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > > > > On Tue, Aug 5, 2025 at 6:05=E2=80=AFAM Akshay Jindal <akshaya=
j.lkd@gmail.com> wrote:
> > > > > > > > On Tue, Aug 5, 2025 at 2:36=E2=80=AFAM Andy Shevchenko
> > > > > > > > <andy.shevchenko@gmail.com> wrote:
>
> ...
>
> > > We can do it, but this sounds to me like a step back. Implementing pr=
oper PM
> > > runtime callbacks is a step forward.
> > I entirely agree that runtime PM is good to have and it does a lot more
> > than just turning the power on and off once per probe / remove cycle.

Initially, while working on a patch for this driver(sysfs for data
freshness), while testing
I needed to suspend the sensor but could not because the driver only suppor=
ts
system suspend and resume. At that time, I had made up my mind that I
have to add
runtime suspend support for this driver because before Andy's
comments, I used to consider
runtime PM support as a way to give control to users to do on-demand
suspension and
resuming sensor operations. But now I learnt that it is so much more.

So Irrespective of the acceptance of this patch, my next patch was
going to be runtime PM support.

Will it be acceptable, that this driver like many other drivers have
support for both remove callback
and runtime PM?

Thanks,
Akshay.

