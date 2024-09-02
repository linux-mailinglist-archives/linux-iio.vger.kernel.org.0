Return-Path: <linux-iio+bounces-8950-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D2F967D99
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 03:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0C401C21C65
	for <lists+linux-iio@lfdr.de>; Mon,  2 Sep 2024 01:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDDF42209D;
	Mon,  2 Sep 2024 01:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn1DbQym"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480BBF9F8;
	Mon,  2 Sep 2024 01:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725242008; cv=none; b=RWHQsbpuF9FAJmWNl+G6vPsOUoU4ytcp+XIN6FM+b3Vgl5ESadW02dLyoZ5q0Dz7xQW3YNdVgmvuM1IR7s8dAtDPMTbi4Zar75+hQoC1SPc9X+2jpzjnv46zOcy6kFC/XrzzIzyaJiQb2IRylMzZVqcajc/Z3mVMOgwLbFjqJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725242008; c=relaxed/simple;
	bh=0Z6kN53pGRC1kBipJQuQz+qtJ1p0yPzsmLKgA7n1uKc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DkPuEP/c10mE0GVyE2z6BydGI/mgOHNj06E4DQQ+LCXjgPqN38TM5MAZqqO2k0IeAetjG//G8glQ0AYnk7joA7gQvPOsAwtfH9+6rIjqWZHaeo412z1HYNqahTi8lpiPsE35TD43CG55/RaLl19xGMalYgo54Se6s32I2qLQ/Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn1DbQym; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2d877e9054eso1659817a91.3;
        Sun, 01 Sep 2024 18:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725242006; x=1725846806; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U3eZEmv0BEUUk1mXF91gUPn0InGpZ5uIO8c06S5wa2g=;
        b=cn1DbQymHHw0bFJG3leNhOnwxTJ2rONAgQOdoNCV4ZH4rKgzA1KjOvfEioZe+q46pa
         mXzZPh3QDqa9Fi0TALxLkx1zgGDL7BzTtWs5bKRJaRnMjV2P3yHPvmrhA0V0VDiGE9NR
         C9TycODJ5jAbWX9SJv4XcX7wItvEsvQWQcWl1eOYGz6616aB53hpf4ZBLpYZ42XztAFc
         zsrd6jXnztZFrZkV71zAv2rKDS7asqN/tVEvuETpeUFi6j4J1OTOYi1+zC/88J81jcZd
         6OyOt53Fe+1PC9HEybRpmTDfT7xT9mwy5qnwf4Ou2CpMZSi0ucmHEw6SJlum7Li3F5yc
         VW0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725242006; x=1725846806;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U3eZEmv0BEUUk1mXF91gUPn0InGpZ5uIO8c06S5wa2g=;
        b=sLyCDDz4uFYTSN8cpaeRkRb2ZgNGY5g9kF2exL+dzzGpVs8+cBZLE4zdkvemMdA1pp
         cZb4pFBuEMp/hiZ7zzi0y0VUIC2ijVlPPOahluJGMEqRkx+ibtOJ7ggCL0U1whAcn8MN
         j3ioRjrgQZi4phAkP2OvS6Dnt7aOQ1JCG4dblpGMo2mE7B4F/+cyMI0z+ZUmBoU32knE
         Txx2/LXOm8uko8ntAVuoXMgum5ZCwGbx1Km7Ljxe2xzDjDf6FKUo45csNA8nLwURGqA0
         9whdlO5xavH6SoyY3L9Klh3JkMZDC89SYRsLZ0kODlbapjvu+AnfMlqbAu6TkbL3BeA2
         T1pQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8hGYTySMgRz3S2w7Rty2PFuuUSzejSKLdoZmEMbsu2TOc1O9quj2yayi8xxwDfq+X88BvvjhZ4ew=@vger.kernel.org, AJvYcCW8kivgNgsLC6FXIKdmR4fRtdQmHbsaNDUd6gIBFifREcccYhXsV0xC+gnkXyMKiGZt81KAlD4s6NjEWAMd@vger.kernel.org
X-Gm-Message-State: AOJu0YzgYVD7dOvl9e023EF8n+zU+PvX71XmAfh5qTrhwFPvgTZY9/0q
	tTyYBxfvzQEKoGtEm7EYXg3pn5OW7TWWKOU10OPqt1YF7DZ8OYXbQMBs9W6eV1ysyKjVfLcjprU
	0p5RR4ADrNd6iisTd3JfTdBd5vD3QYSbGY0EyGlNv
X-Google-Smtp-Source: AGHT+IGS0M4z397CaMnfQ2RoPpTBI8X9KqskUlX59Ks2munzim7W1E4dvyxJZQbzWuSfJ8QSX9d5wqPJ3BluaQjnvjQ=
X-Received: by 2002:a17:90a:c288:b0:2d8:a672:1869 with SMTP id
 98e67ed59e1d1-2d8a672198bmr4841654a91.32.1725242006486; Sun, 01 Sep 2024
 18:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240901120839.9274-1-gye976@gmail.com> <20240901151150.77074133@jic23-huawei>
In-Reply-To: <20240901151150.77074133@jic23-huawei>
From: gyeyoung <gye976@gmail.com>
Date: Mon, 2 Sep 2024 10:53:15 +0900
Message-ID: <CAKbEzntnDGXFCgpscGSg-E-1VraE9J+kTwOsCocmu9N5Agxt-Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Remove duplicate code between labels
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, jean-baptiste.maneyrol@tdk.com, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 1, 2024 at 11:11=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> On Sun,  1 Sep 2024 21:08:39 +0900
> Gyeyoung Baek <gye976@gmail.com> wrote:
>
> > 'flush_fifo' label performs same task as 'endsession' label
> > immediately after calling 'env_reset_fifo' function.
> > So i remove that duplication.
> >
> > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
>
> Ok. This doesn't greatly affect readability and the code
> ends up a bit shorter.
>
> Applied
>
> Jonathan
>

Thank you for approving it.

-Gyeyoung

