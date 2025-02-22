Return-Path: <linux-iio+bounces-15983-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E907EA40BA1
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 21:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1B1D7AB39C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 20:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE8C203703;
	Sat, 22 Feb 2025 20:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SHzqdl14"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6371547D2
	for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 20:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740257920; cv=none; b=elWwVgRS77qvN3GmqX4KL0emv7KUclcM0c5TCFoCNgPHH82abJIc/jVv4rgxgl6RFQ9F1Dpy3fX/8PvsgWGx+j7ZVkInG5IAmUS3YlDw5vIsb7CE0CsYlHm0Z9xprDfn39+OGnl3XeaXuR4pZstpb3pzLuGDPOkNTO/5a+iXLVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740257920; c=relaxed/simple;
	bh=dhE9Ph4h+rTvzAaPbZqQi0o2kboktxrtpCx1yJqjlBA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ifhSlRyC9gIlqzyjoLwWXpFRKT1PQTygyTY0pWHl/H3PvVuKFqHgHFHr5cfPe8fQDbpS5qa7VSyY9YBlKQKuW3hyFEIr+jiPwSdCdt4oaHELsXjypkROv+/xiAEjOmWyUooIt+KfOOTjF6+QyFlPleu14j9YxNg0qPRMOnJAF48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SHzqdl14; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-abb79af88afso601558266b.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Feb 2025 12:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740257917; x=1740862717; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xRg5M5ne5TEFwhTLs989cyfq/RPh3dWfWhmIorBqrmo=;
        b=SHzqdl14gbZjIGk1u8icfRdPsu/X89qe7hmDg0k9qOOdj/533nSPAkBrbOIwzWSLqW
         gU04RM9F/3UXj38Xj7jOrqZwXRtXzk/VKceryAl4kYTxbA//FirAizse3NIoC29sXUax
         3uX808Zq8M+FT/FqGoYYATASBdBwCvaKgUocjrF9QJPWgUtA6d8LDgwWcDMl95Dd8Tfk
         dANrYA70ji1it31jT8se7BuWZScidIL+S4jsIQtM3yemZNRtUv2SZU/aXIPHQjfac2uS
         z1I4tnaVEVLhTA0HBMixik2XTLKAgDAT8O9qZr3gbqQpQVA57caCQXGi+GJFV6bVR2nN
         XFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740257917; x=1740862717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xRg5M5ne5TEFwhTLs989cyfq/RPh3dWfWhmIorBqrmo=;
        b=etLAcGUZ3pZX/4AI0iVLRtgy40wpGf3CCwuWiA8qfhwr28r3Iqw225N0mVunq+9xmL
         CLgsgu3yvDbkYWvity9i3A54eBB4fZc3gLhJjlnzcQ+O03kjajgJwdsAGZZV1fwrtWsK
         ceTIpeaAO+858czq1ehRuzZw777RdpCkKXn83bksg2dmH5GtpgxhLzda0KEmUkGQEt6r
         RoEiLi7j7PJakCyQefVqIDD2yWrjVaoRY8ujfPUepnZsrsSoulXUlsTuqOU9TxmSo2wt
         A2a4d1MuQG0joNbSYwEjpiLy3OozXrpL2GxoNsHNbW+WmEODunpefjX9U4YqfSnLyeG2
         5PRg==
X-Gm-Message-State: AOJu0YwxErHU8VmMWt7A3fnutr/xvhlUba3kP7uMT0WuCwFunPNTV+W7
	kWnkMArh7c9dcG/73zlutIzREMFfWOFcD+xNURO/bPd+KbP5Pty6JUFxqhQK+hHQKn1jAQb4H80
	o2/SQr8Jb7VEd2Y38NiphTJ+TmU0=
X-Gm-Gg: ASbGncsabDAIbxM7A0o2kqrXgvNkk8wZZ/BA4FFBoT4vxyQH1IjJ6WrO/Lf1eOtuypc
	AGdTwleWb5k3GeDrthpl3cidCq+KSVLL/C5Lst5JlFo5IAZyjBWmWAmwiqgJr0Tw79YYjgdG1RG
	a3APF6udc=
X-Google-Smtp-Source: AGHT+IH/rTvQqVdNsNGEER+ZrUVopB/Ee8duQf+oQZgYSunVC/dp9J5u9D9GoV9vr2QwVDvJhF+59EVIPLmObo05MjA=
X-Received: by 2002:a17:907:1b26:b0:abc:4b2:4d44 with SMTP id
 a640c23a62f3a-abc099b7fc9mr802686366b.6.1740257916912; Sat, 22 Feb 2025
 12:58:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250209180624.701140-1-jic23@kernel.org> <20250209180624.701140-2-jic23@kernel.org>
 <Z7nyQgjZ36zkO8oD@surfacebook.localdomain> <20250222172357.05378fd4@jic23-huawei>
In-Reply-To: <20250222172357.05378fd4@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 22 Feb 2025 22:58:00 +0200
X-Gm-Features: AWEUYZnLUZ3-LGxZ2G40DHLJ6FwmTM4B6HZ2m5g4nEv6cbw_UJ_nDwTPfp3aGx0
Message-ID: <CAHp75Vf_XPSvTOH_zvfndghjy+bM_6hr=z2JAcE8AYh415SPWw@mail.gmail.com>
Subject: Re: [PATCH v2 01/27] iio: core: Rework claim and release of direct
 mode to work with sparse.
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Mudit Sharma <muditsharma.info@gmail.com>, 
	Julien Stephan <jstephan@baylibre.com>, Mariel Tinaco <Mariel.Tinaco@analog.com>, 
	Angelo Dureghello <adureghello@baylibre.com>, Gustavo Silva <gustavograzs@gmail.com>, 
	Nuno Sa <nuno.sa@analog.com>, =?UTF-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
	ChiYuan Huang <cy_huang@richtek.com>, Ramona Alexandra Nechita <ramona.nechita@analog.com>, 
	Trevor Gamblin <tgamblin@baylibre.com>, Guillaume Stols <gstols@baylibre.com>, 
	David Lechner <dlechner@baylibre.com>, Cosmin Tanislav <demonsingur@gmail.com>, 
	Marcelo Schmitt <marcelo.schmitt@analog.com>, Gwendal Grignou <gwendal@chromium.org>, 
	Antoni Pokusinski <apokusinski01@gmail.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 22, 2025 at 7:24=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Sat, 22 Feb 2025 17:51:02 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > Sun, Feb 09, 2025 at 06:05:58PM +0000, Jonathan Cameron kirjoitti:
> > > From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > >
> > > Initial thought was to do something similar to __cond_lock()
> > >
> > >     do_iio_device_claim_direct_mode(iio_dev) ? : ({ __acquire(iio_dev=
); 0; })
> > > + Appropriate static inline iio_device_release_direct_mode()
> > >
> > > However with that, sparse generates false positives. E.g.
> > >
> > > drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c:1811:17: warning: contex=
t imbalance in 'st_lsm6dsx_read_raw' - unexpected unlock
> > >
> > > So instead, this patch rethinks the return type and makes it more
> > > 'conditional lock like' (which is part of what is going on under the =
hood
> > > anyway) and return a boolean - true for successfully acquired, false =
for
> > > did not acquire.
> > >
> > > To allow a migration path given the rework is now non trivial, take a=
 leaf
> > > out of the naming of the conditional guard we currently have for IIO
> > > device direct mode and drop the _mode postfix from the new functions =
giving
> > > iio_device_claim_direct() and iio_device_release_direct()
> > >
> > > Whilst the kernel supports __cond_acquires() upstream sparse does not
> > > yet do so.  Hence rely on sparse expanding a static inline wrapper
> > > to explicitly see whether __acquire() is called.
> > >
> > > Note that even with the solution here, sparse sometimes gives false
> > > positives. However in the few cases seen they were complex code
> > > structures that benefited from simplification anyway.

...

> > > +/*
> > > + * Helper functions that allow claim and release of direct mode
> > > + * in a fashion that doesn't generate many false positives from spar=
se.
> > > + * Note this must remain static inline in the header so that sparse
> > > + * can see the __acquire() marking. Revisit when sparse supports
> > > + * __cond_acquires()
> > > + */
> > > +static inline bool iio_device_claim_direct(struct iio_dev *indio_dev=
)
> > > +{
> > > +   int ret =3D iio_device_claim_direct_mode(indio_dev);
> > > +
> > > +   if (ret)
> > > +           return false;
> > > +
> > > +   __acquire(iio_dev);
> > > +
> > > +   return true;
> >
> > While I understand the intention, I dislike the function return boolean=
 and
> > hide the actual error code, it calls user to misuse and replace boolean=
 false
> > by arbitrary error codes.
> >
> > Can we rather return an error code, please?
> > (as a side effect it reduces the churn in the followup changes)
> >
> Hi Andy,
>
> I tried - see above.  It plays badly with sparse which is the whole point=
 of
> this exercise. Note that iio_device_claim_direct_mode() only ever returns=
 one
> error code -EBUSY. So reality is it's a boolean and this is a lot close
> to mutex_trylock() than anything else hence the switch to a boolean retur=
n.

Hmm... You mean that the following (still as a macro)

static inline int ...
{
  int ret;
  ...
  if (ret)
    return ret;

  __acquire_lock(...);
  return 0;
}

triggers the sparse warning?

> At the end of the full series (not yet posted) is a patch that gets rid
> of their being any pretence this isn't a yes / no question and can
> return other error values. This intermediate step does leave it looking
> more confusing.
>
> Churn wise if we'd been able to do keep the error return and make sparse
> work I could have just applied this to the original functions and made
> no changes at all to the vast majority of drivers.  Sadly that wasn't
> to be. End result of ending up with a trylock type approach is cleaner
> and more compact even if it's not what we have gotten used to for this
> particular function.

> > > +}

--=20
With Best Regards,
Andy Shevchenko

