Return-Path: <linux-iio+bounces-2563-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 570BF85506F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 18:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12AA02846AD
	for <lists+linux-iio@lfdr.de>; Wed, 14 Feb 2024 17:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D3583A15;
	Wed, 14 Feb 2024 17:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YdYzpymO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B2E7E0E3
	for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707932133; cv=none; b=YZqHnJFqvpOskCWYpwN6Vqhgr+FJBtRTMfDU4DwxXK8b+UvZF759xAnocL5Td1J8tj73aAwJUGASoQqhzV/JtdRnrC1NZecfLqQVmUG61MzJEV+u5r2fKQIUEEvCh09DUQ9XrCZilwxu6FK6XXL0HHkr9hOSx3Zz29rzlzRgIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707932133; c=relaxed/simple;
	bh=NaXufiFULerLhpWf6dncD7I4CekCxmTjHj2vHaZV9/c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r+z3+dzGSFXGq5USc6ge3N+VBTn23H3EbiiNcu9wZHqqd/942JG04SYPPNf2rxy30U1d+uo1JHHZzPTy6IAUL9XQccflD5IE2Ss3uPOb4NwUKaWMXLez92UGaiP2q/mtfJjrW67icrMGGIfM/ONh9oB+kcgMnqZFnb8rv/hm6KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YdYzpymO; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e10d08cb4fso462395b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 14 Feb 2024 09:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707932131; x=1708536931; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m8SfD/6px6BU+9Js1Zf1a7Gyhf3G2ArYdI6JrhkYL3w=;
        b=YdYzpymO8TdQlVo4pn4QSaSbIx/dTpn81dlUXhYAetb+CxzS7FeviCBSgR7dwnIf6v
         OKvvSQK+lEYLGbD23xTMmemh2n7y5MoG3C3Jc6JjDUo2gDiY/TKkjg83n/Mt3pJyOt0i
         VDKuA4NxvS7eLpePYK/xidXDAuRS99OHtZHp1Dg5mZh+GX0aggeoesrrw3lkcieK3g23
         J3fmiYWTwp6utcMrVhUR7qprZjzyc2JP48tNAv5bX5g0BehUOHicYiltHNf8CqTERVuw
         /UAKfqqTry+RkRC4Ed/hLZ01TTigDQpxqVoBs9PEG7VVbBqKSU8I8YqdJAvfQBDXIijE
         f+Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707932131; x=1708536931;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m8SfD/6px6BU+9Js1Zf1a7Gyhf3G2ArYdI6JrhkYL3w=;
        b=hRgvDOuC8q7ccBv/eMA+Nz7MZx2ac1pqci9Y6OP1Duxvz8uNlbKHtbLqI1yKBJ91oT
         Dfjt1eUwgEoSkOL3PWj+fh31rEsGoouFK7u3grqoqs39GOP3UbQPekQN9IQiCK/zL/n8
         ZZ0tb2XPBhcx9/W5VQP+X8q6Gqy2APcG7JcAxauxu2jrhQIl11bWC6Tuh0IPIQM9W3L+
         0jbTQSEk5V6+slrITayfgzPUsO0pMUxa9Iu3aX6vzXzhx6NOiqweDCx7c0rUn5qjtpsk
         hijWttkAgP6Leh9NQ5jPAjDk2jpMKpiH4SeIPR0eQ78x/MND4+78ar+3wbXETraKf8sl
         j3Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWG8TS5xz8cUzvnM6yjY3z6ldccoN/zu17UX/pAR7eGPxeEftTwOTzkB9s1mxKMSJWitfNzmzxGSAOh3mot/tn8OCwTD6/P0X6m
X-Gm-Message-State: AOJu0Yyrm+9IyI9DgQs6lQRGii8LElzNnTC6I8Bc7VXo9Q0raqckZBb/
	zE2VkV2XTg3Tr0TditYM0xOjBuUtPsI+M1JFsnOLrLdyEnjtCXY1Z5mvNPl+vBTkxA==
X-Google-Smtp-Source: AGHT+IG6To5UdZEH8oYQNeXLBVysRmc1ZMo7oUhYppb9dvx4JRN4whs3+c1MmM1yrxplgpinQlu2HA==
X-Received: by 2002:a05:6a20:d90a:b0:1a0:5bd8:50de with SMTP id jd10-20020a056a20d90a00b001a05bd850demr3651441pzb.16.1707932131066;
        Wed, 14 Feb 2024 09:35:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX3wRIPbx7GwfTICvq4/SudSf4ijg3ODKNpiEnK5Qcw/FKBvrL32vcWtJiUr9si+HXvrWrgEBMfVwMzG50U/2txtuKxw8lzeVGC7ZbBKeCYuLFOXqoCjfBMLoG01V84IGy5/BltVTybgBD0oLRyEiXpGdFitgKSd2m/t2QryM5N8HqXcfPu5mLQNzY2PzFou/4hdGpPFT4pMa5FWYVUSr7MIAH+71y7pYqiV+gL2wFXHG9Xlj4pXAiFA2tzT33KiMmXUsfvkMiB26cVMyYtd20JSgbbCv/B5CPXX3ddzbfD3jhS+2YmDFQRLCnl
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id 201-20020a6302d2000000b005d880b41598sm4428684pgc.94.2024.02.14.09.35.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 09:35:30 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v2 2/2] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Wed, 14 Feb 2024 09:35:28 -0800
Message-ID: <12396329.O9o76ZdvQC@nobara-ally-pc>
In-Reply-To:
 <CAHp75Vc+pb6YUhx7QOzWGQwmSgGmq2-7NjJHgOBSekKyqdVg5A@mail.gmail.com>
References:
 <CAHp75VfcHnswdXnqdtOkX31LbULu8Pa0WjM5EC96OuOBrZGTxA@mail.gmail.com>
 <2192956.irdbgypaU6@nobara-ally-pc>
 <CAHp75Vc+pb6YUhx7QOzWGQwmSgGmq2-7NjJHgOBSekKyqdVg5A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5770623.DvuYhMxLoT";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart5770623.DvuYhMxLoT
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Feb 2024 09:35:28 -0800
Message-ID: <12396329.O9o76ZdvQC@nobara-ally-pc>
MIME-Version: 1.0

On Wednesday, February 14, 2024 7:31:14 AM PST Andy Shevchenko wrote:
> But are those IDs different?

During the chip id check during init (after ACPI match), yes those IDs are
different between devices with bmi323 and bmc150.

> I also recommend looking at my "smart" script [1] that helps sending
> kernel related patches. Improvements are welcome as GH pull-requests!
> 
> [1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

Thanks for this useful script, and thanks for your patience and guidance.
If I make a future submission after this patch series, the whole process
should go much smoother as I have learned a lot in this thread.

Best Regards,
Jon LoBue


--nextPart5770623.DvuYhMxLoT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXM+eAACgkQ4obKiQwb
1x0/XAf/ckJKoSykSc/2k8yoMkTbF3V8cdsvUez+nmD7vOrIj6NXcqsg9nzwFG8W
yradx40XXm1HMRSKTHwj8yyklHdXmPg+MCa2j2PRJvOzabA14BdpxdHyEWBXqlJi
+Pbeo6E9VXyM96WudNEBXBmdK+3wE1RxAcfnc8zj0ys1TCHX+S/hlTqrX7koWxxt
zXvSnHkAeqI+zSm6o4nYYNFVS5WydS2n01Qi64K0EvoDal8e75IryH8QS8lkgKAJ
93C99LpPk0nJRqmbkXWvukg0SJgMUAi0AqIlbDsk24E1LaTY7KH42YB6lOABNmfi
CKr1oGcJOzx3idvXIf9lNCIv9BSu+g==
=EDcX
-----END PGP SIGNATURE-----

--nextPart5770623.DvuYhMxLoT--




