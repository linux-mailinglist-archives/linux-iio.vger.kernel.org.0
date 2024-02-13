Return-Path: <linux-iio+bounces-2517-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9618536F8
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 18:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C495A1F291AC
	for <lists+linux-iio@lfdr.de>; Tue, 13 Feb 2024 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89AF25FDAA;
	Tue, 13 Feb 2024 17:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGnu0Psh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1545FDA5
	for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844494; cv=none; b=KbrFgMG7vcc8b3S68n1XUSLi7aJfHkAjp60t6i5bClI8Jq9K0aYlRsGmf8U+6PBE/VaR4DSNf5nHpg9GWDSk29tLEk8AyAT+wfFBW+Y5eAjPK4n4NZeq+zyjLlpZjnn1TECyNQfgxln42TjTWIptTUvT3xvPPbE3Lni9LalTgjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844494; c=relaxed/simple;
	bh=AFey1LJz+Ppon0mIMe/nqKsvCjYHw7jJ9bu7vmaq9FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=th38W/QghIaKhj8LmiVzshuFzcmd+B8yS1/MJJNZ2/VOy4dTgjb3nDn0lZZ46pJ9eHhDmK8pJAR3phhQnLDOOk3hpFYTYMdM3LblJn6dciAzEO7K/VH0FVLS5ddQTffLWQSIgs5kPnToAODgcIdT0KCh9hVsOW+LEjFCGb6mtUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGnu0Psh; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1d95d67ff45so33958065ad.2
        for <linux-iio@vger.kernel.org>; Tue, 13 Feb 2024 09:14:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707844492; x=1708449292; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AFey1LJz+Ppon0mIMe/nqKsvCjYHw7jJ9bu7vmaq9FY=;
        b=TGnu0Psh6vyR6spLyC66E+AQnafapQe9vdlsAtxzvgOUo5wxB5vI19pIPrlV1M4ZB1
         ugG8X/9TMCYnrWykWQdH99ns4nsZoJHFVXS++GiN0t7P5Ki0C3sPLjRT+eS6u3ZHfmvF
         5IsEk4NZBSIwQxZpurzyZTMGcmF0osWiNEZbbigxyIWaT0TkWrxjuhcH8orQqkS/VMPn
         e0zVrTcWN/VwApePIIaHsl6gc50lnQ0mAtqeVcaA3Pxl/jfhWe7Rj66Vvr71fLONBfVP
         DPOjeJwtjUsOQj7DMNFb0x0kviDhKkn2P8sHMOXoWcZSsMFspJKWuxIxoMogonYn49yE
         EKrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707844492; x=1708449292;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AFey1LJz+Ppon0mIMe/nqKsvCjYHw7jJ9bu7vmaq9FY=;
        b=mPWkNkW/4sY9q1Z2JLhqe3XqYxBWfabzYku/ktY2zYxooAbid3YPK+zO7edz8b+sak
         eidwJjxe+jdiBLKy6wvQ1dh2zY8wzfZv/dccArlNJrmCqh9iFmx5if/wWh2+FL09hIU3
         GllIS+i+PRdhecs8Ty6PS3ZuHHkLYy2J3sByw0f8XBMw2Nnrko0oW1T0z5oCHFgQV5y3
         PXp+EuwkYsG0qGdpMz8y0okmIrUrm8ICRt0Q7kVi3YwS98wbHURQ4ebaUeOxhCseM3mD
         tJd5MRKX7brIgCc8Bh/YlyrlWL3SJWHxRPCZoQb6qZctMkkp88eMT6p8XNrulzBZWfyx
         qFrw==
X-Forwarded-Encrypted: i=1; AJvYcCU25Jj/eKwmoXc7+iJNGlp2Inn7AxSDmO4JX0rlEhaT4liEQq6ndl90OA+di69SImnRrg52ZYTBxoIQVZ+RQkSDPGkg9tYfvWnq
X-Gm-Message-State: AOJu0YzX3NDJBp7TgXyxJ9HGd+ssNwvS0r9EDVmG5rl4KheMAk/QHvmJ
	gzD+gk2sfoRQFsxsthYdueF+XPC3Ktcg1l4Mx5I/Iy1T/OI6MRf9
X-Google-Smtp-Source: AGHT+IF846DZ8rqshHiMu7KcTp0QN8PX8/xRPUjt5CZtTND4d3SrxkipT99os1VoVfFcGYlrPEsPig==
X-Received: by 2002:a17:902:ee8a:b0:1d9:d:5730 with SMTP id a10-20020a170902ee8a00b001d9000d5730mr140694pld.3.1707844492069;
        Tue, 13 Feb 2024 09:14:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW/mzuzJMrlUIJg+v4JMRoceflH0d1P5Ul6OSJk/l31alP8ZInO9Nj2GnpsBBya7D41r6qCV51n7NAct21/+phS/0G/QzLPE2FcgB4dqa4fZX1lYA0+L9t+8l0nIvFdUmEnv7vUhTQvYLW0MB+LDXgcr3m3U8Qu7yPnOmtbhiLRlrKwIINlz2r9cVnAl4u49RLgM0Lhw0HLyt0vOa7svKzyK4M/gc6p+pqFgk5n/5dJ+IpEtsfLX1I/rlsKEzmDSrPZi8dSCyjc7Jmdu8NdTnrSyS2VidMNCc6I7VlAPWkr/2oUEwO0r2JQmw77
Received: from nobara-ally-pc.localnet (076-167-168-058.res.spectrum.com. [76.167.168.58])
        by smtp.gmail.com with ESMTPSA id ju13-20020a170903428d00b001d91d515dffsm2343140plb.156.2024.02.13.09.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 09:14:51 -0800 (PST)
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com, jic23@kernel.org,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 linux-iio@vger.kernel.org, lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v1] iio: imu: bmi323: Add and enable ACPI Match Table
Date: Tue, 13 Feb 2024 09:14:50 -0800
Message-ID: <4917806.31r3eYUQgx@nobara-ally-pc>
In-Reply-To:
 <CAHp75VeBqKiEWHyRjJt62VvrGKjG9S+kgMrbYEPBap311ZtZVw@mail.gmail.com>
References:
 <CAHp75VfJeMZUBO0c9gr=ymee8jqu0xJQRwrg798Trrmr6ox5gw@mail.gmail.com>
 <20240213023956.46646-1-jlobue10@gmail.com>
 <CAHp75VeBqKiEWHyRjJt62VvrGKjG9S+kgMrbYEPBap311ZtZVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4566408.LvFx2qVVIh";
 micalg="pgp-sha256"; protocol="application/pgp-signature"

--nextPart4566408.LvFx2qVVIh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Jonathan LoBue <jlobue10@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 13 Feb 2024 09:14:50 -0800
Message-ID: <4917806.31r3eYUQgx@nobara-ally-pc>
MIME-Version: 1.0

On Tuesday, February 13, 2024 2:49:24 AM PST Andy Shevchenko wrote:
> I'm lost. You sent a lot of patches / patch series all of which are v1. Can you:
> - use versioning (`git format-patch -v<X>...`, where <X> is a plain
> version number)
> - add a changelog here (after the cutter '---' line) to explain the
> history of the changes
> ?

Yes, I will do this. The changes so far included dropping the no longer
necessary DMI quirks portion in the bmc150 driver. I understand from
your comment that we want to add a comment in the bmc150 driver though
to explain what is going on with duplicate ACPI identifiers in different
drivers. I will add a similar comment in the bmi323 driver. The changes
so far also included the fixes that you requested earlier in bmi323:
dropping the duplicate header include entry (included already in other
header file), removing the unnecessary comma in the ACPI match table
portion, and removing the ACPI_PTR when invoking the ACPI match table.

> Since there is a collision please add a big comment in _both_ drivers
> before such ID to explain what's going on.

I will do this and add a changelog after the cutter as requested. Since there
are some changes from my initial submission attempt and with the additional
requested comments, is v2 going to be okay to use so there's no ambiguity
about which patch version to use? I will attach the version label with
git format-patch as requested. Thanks.

Best Regards,
Jon LoBue


--nextPart4566408.LvFx2qVVIh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEgd5eGdGJaPFBoUcS4obKiQwb1x0FAmXLo4oACgkQ4obKiQwb
1x1mgAgAmglJswUX0jQ7Ev9h9CimWpjYeC8PapNKFC5C16TrMHNd9GMxbDcV7Qoj
lPi/D7kr3x8T5oiEIRGooh3RpQyJJUT1RtBDnWvYoGd4XUGq0ZG6K+FLRS+9CUE6
eN8ljfE/jur7OAOdu5xISji9/02cWoUD1sfCYYg9l9ik8U8lbMaCxRbUHp+O4L9r
g++Brbp22XIM7JRlMUhZP49HnMxYNahNGByxWvYwP1OYG69r3c0ZCSNEVjHuRnlL
ErwZEyvqCGS8dLy2ydhoepJCoUTsl2ob+nG9uWyXsHcVYpm6CmnSooTqR0RyTCf8
mUb1wdzOhKf9Fj7cJBWslYZDinSaoQ==
=ymt6
-----END PGP SIGNATURE-----

--nextPart4566408.LvFx2qVVIh--




