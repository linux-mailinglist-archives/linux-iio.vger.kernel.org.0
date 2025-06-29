Return-Path: <linux-iio+bounces-21104-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B134BAECE8F
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 18:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87FED3AFC51
	for <lists+linux-iio@lfdr.de>; Sun, 29 Jun 2025 16:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1B3C22FE0D;
	Sun, 29 Jun 2025 16:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhTcNm31"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D4113790B;
	Sun, 29 Jun 2025 16:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751213672; cv=none; b=htU2MBo9zxwuocZsM3PGjS2vgzcGqS2XS2/1O7AI/7EBZ60MxcLi7K/5Nlt5QlhDc7sAzuKHa9GomBaHIEva959mrZ8UljnUWjKszlx+H3Ec9HoN5uigmOPOGVyBBVzjm1x5sceb3HZg55Njb4NfFmM3ErZH03VBU2NmK4kBFts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751213672; c=relaxed/simple;
	bh=P5/pclvstCK7Fn4BW9uy0qhL/YOfmGarlgRNwFRvtg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YznA0yvQxcV+kKChXCgQ6BJik+zRAwa1i2Vm/FhmFsxAEjVPxd18tvu2R9JOQ9/Tt8fGA2FIgrlJQ24FC88CdDdC6d4ix40XGnOuljT/lHqwL/Q3CqE3t2dxZqQU5xl+UvsEQf57WQ+je9wkBWf8Pd80GPN7Xagsr70aFeE86ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhTcNm31; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70e7ebc21d2so2944847b3.0;
        Sun, 29 Jun 2025 09:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751213670; x=1751818470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kvyzx1MIZlJNy26k7PKj6BKtobN6ZhVJ5f3jQVxcEpE=;
        b=EhTcNm31bDnY+Yf8jV5mHNr1BmS6yw9J1GBrjsJj87C8lK5SrG00TWWY/PCVrUDoSO
         B8QHfk1QrsnzKswgm8CxwlrW5wkNxMYk+jDoDKbZYnJkbJswwASLZyLp8thWrIpoY6aL
         ZToloBCQ5wvVG0DawZDHqoBSiki3heX8NoVUznq7/atecMqN5Zz8a/nvl3II9+uUG4TX
         HC2/pWRx/0wue8TzdwbQPPFrVxcOoASWZYUaMyo/dbkPXbP0AHEMYvyN5DQ91KjThLxT
         bKrTuZKZavpb/KNVAic/eFklFP6NFRfRQ4W6keT6hC8jSrMduGrLEpCqH36VXPWGF575
         QlAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751213670; x=1751818470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Kvyzx1MIZlJNy26k7PKj6BKtobN6ZhVJ5f3jQVxcEpE=;
        b=rPB3I7SWV44bGQRbDCRASo9Rp4h9IAsbRAjSaK2uqQc5KaEgpBS7wgxssuj8T0V0AC
         SaT6v9ux0AQlynRuyuxfgbFyMfS8pVjKOwMHgbxsVVyrFZt/uj/jTa1eVpQMUClNENvF
         RPsg/8fji1j1stsIzdtH2qZKRajfe1UkyYdjGf2jYzRoXmds4R3LlBm67Nle7uzBoBAT
         bS0DawBDdzwSavQE6ttUp85GM9c1t/UNeqMfmn3YlWQy672VyjbJIWC+ydrYBDgSdbF1
         IZF5v8OMPZMQax5272Tu2i5tfQkFE7tgRFA9787au9Ah3WPLk1HVNv+HCGxcHGGs8Xnp
         ZiIA==
X-Forwarded-Encrypted: i=1; AJvYcCUE5uxFUOpISM/3Ri13xzoIRmwIfkqQclzohy5pooMDgxA/Ha2/G4fjZ6/Na9fFH1w6USsYEZqfYxZgsz1s@vger.kernel.org, AJvYcCUL5wFAAN/iiV+d0VccGAKbx+wFAmBZ3wCn9dBpVrkROONJTp2qiHPfPGtKuCfXmMVzpdlNlXYAEhg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhCGBgtI1mTFmp38MVs4J+tSXCB8/Gfsn/yO0i1V2kacdG6JIq
	wsJ4zBpcoN4IcJP0b6wwwhYMInsiOJfN4krV6MBupAP7mL5pdh8DO+jFAI6suD0mKnEZKfzN9lT
	O6md4UsVcr2+RleIMXZwHgNJFCP95oI9aEaro
X-Gm-Gg: ASbGncsiPbzd4wzu4SnMxAkvyt0ZClcE08xOdisz463S+ozcHkIFMv0L99cHFfBSoNL
	h6ST/9uK27GAQMmlLiR3nXz7WHf+Q7xoehrZ98FbcnFqXKdfjiuk0Np5dT620MjhbJYsIHC0kqI
	0klk01NCmOIUnRPbCN6Ax4Q2m3cD1XMmVliLpIUWIj8TI=
X-Google-Smtp-Source: AGHT+IE6iOZ1atYJW8d/8i4sksxfq2/l9lw/fmz94fzvS3BPAtVdBgZFC5t0FhxNOK7VQ4wzTV9gb1W2KYN99pYdXS0=
X-Received: by 2002:a05:690c:6f85:b0:712:b536:865d with SMTP id
 00721157ae682-71522db885fmr41271037b3.0.1751213670141; Sun, 29 Jun 2025
 09:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250625170218.545654-1-l.rubusch@gmail.com> <20250625170218.545654-2-l.rubusch@gmail.com>
 <8eb80697-e76e-412d-82a9-5a95d4ca4f2a@gmail.com> <20250626192802.0079d579@jic23-huawei>
 <aGCCIwknL25yAyHL@dev-linux>
In-Reply-To: <aGCCIwknL25yAyHL@dev-linux>
From: Lothar Rubusch <l.rubusch@gmail.com>
Date: Sun, 29 Jun 2025 18:13:54 +0200
X-Gm-Features: Ac12FXz53v2OFWL5UEGH_ycY4KAGx-12VHf8Hkgs0xzzdobWIhtcf9oTTPIHfzg
Message-ID: <CAFXKEHZcUpEpKPQP0CuJmiw20igrDUUEkB19RyQ=FHRqy+JiUg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] iio: adc: ti-adc128s052: add support for adc121s021
To: Sukrut Bellary <sbellary@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Matti Vaittinen <mazziesaccount@gmail.com>, dlechner@baylibre.com, 
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 29, 2025 at 2:00=E2=80=AFAM Sukrut Bellary <sbellary@baylibre.c=
om> wrote:
>
> On Thu, Jun 26, 2025 at 07:28:02PM +0100, Jonathan Cameron wrote:
> > On Thu, 26 Jun 2025 08:24:41 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >
> > > Hi Lothar,
> > >
> > > On 25/06/2025 20:02, Lothar Rubusch wrote:
> > > > Add support for the single channel variant(s) of this ADC.
> > > >
> > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > >
> > > Thanks for this addition. In principle, this looks good to me but I a=
m
> > > afraid there is another colliding series being worked on:
> > >
> > > https://lore.kernel.org/all/20250614091504.575685-3-sbellary@baylibre=
.com/
> > >
> > > Maybe you can align the effort with Sukrut?
> > +CC Sukrut.
> >
> > >
> > > What I specifically like (and think is the right thing to do) in
> > > Sukrut's series is replacing the 'adc122s021_channels' -array with
> > > individual structures. In my opinion the array is just unnecessary
> > > complexity and individual structures are simpler.
> > >
> > > Other than that, this looks good to me.
> >
> >
> > Sukrut, perhaps you could add this to the end of your series, rebased
> > to those changes?  Would save a synchronization step for your v5 (and
> > later if needed)
> >
> > No problem if not, but I agree with Matti that we should take your
> > series first.
> >
> > Jonathan
> >
> Sure, I will add these adc121s0xx to the end of my v5.
> Thanks.
>

Hi Sukrut,

Since David Lechner still asked for ordering the TI ADC vs Rohm
entries a bit, and complained about the missing binding entry: Shall I
fix this rapidly and send in another version?

Best,
L

...

